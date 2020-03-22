Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE03118E5CF
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Mar 2020 02:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgCVBfd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 Mar 2020 21:35:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:30660 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726859AbgCVBfc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Mar 2020 21:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584840931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vC6nIVunZ7Rm0krd+FFCpzgbO+fh9BWQe1SFxACqKGo=;
        b=BzHr2XmT+FACUMgfcarWR8idYk4TBRmzuzQhDh1nzlO7IvHP5qVEyeM3jE+wsnGNjGnA3/
        dXCo+NJPciBtqEWACBu7+UOgFxSAocyem1femmTkeFHP7vAEnlr+ugax1jNUDjn07PT/r0
        tmCuO/uaveF6Pw2fh0C3lq/IprrQQkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-xaRD8C2UOfGUK-pcPgABGA-1; Sat, 21 Mar 2020 21:35:29 -0400
X-MC-Unique: xaRD8C2UOfGUK-pcPgABGA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C5638017CC;
        Sun, 22 Mar 2020 01:35:28 +0000 (UTC)
Received: from t490s.redhat.com (ovpn-112-44.phx2.redhat.com [10.3.112.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC9C610002A7;
        Sun, 22 Mar 2020 01:35:27 +0000 (UTC)
From:   Rafael Aquini <aquini@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        shakeelb@google.com, akpm@linux-foundation.org
Subject: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2 false-negative errors
Date:   Sat, 21 Mar 2020 21:35:25 -0400
Message-Id: <20200322013525.1095493-1-aquini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changes for commit 9c4e6b1a7027f ("mm, mlock, vmscan: no more skipping pa=
gevecs")
break this test expectations on the behavior of mlock syscall family imme=
diately
inserting the recently faulted pages into the UNEVICTABLE_LRU, when MCL_O=
NFAULT is
passed to the syscall as part of its flag-set.

There is no functional error introduced by the aforementioned commit,
but it opens up a time window where the recently faulted and locked pages
might yet not be put back into the UNEVICTABLE_LRU, thus causing a
subsequent and immediate PFN flag check for the UNEVICTABLE bit
to trip on false-negative errors, as it happens with this test.

This patch fix the false negative by forcefully resorting to a code path =
that
will call a CPU pagevec drain right after the fault but before the PFN fl=
ag
check takes place, sorting out the race that way.

Fixes: 9c4e6b1a7027f ("mm, mlock, vmscan: no more skipping pagevecs")
Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
 tools/testing/selftests/vm/mlock2-tests.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/vm/mlock2-tests.c b/tools/testing/se=
lftests/vm/mlock2-tests.c
index 637b6d0ac0d0..26dc320ca3c9 100644
--- a/tools/testing/selftests/vm/mlock2-tests.c
+++ b/tools/testing/selftests/vm/mlock2-tests.c
@@ -7,6 +7,7 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <stdbool.h>
+#include <sched.h>
 #include "mlock2.h"
=20
 #include "../kselftest.h"
@@ -328,6 +329,22 @@ static int test_mlock_lock()
 	return ret;
 }
=20
+/*
+ * After commit 9c4e6b1a7027f ("mm, mlock, vmscan: no more skipping page=
vecs")
+ * changes made by calls to mlock* family might not be immediately refle=
cted
+ * on the LRUs, thus checking the PFN flags might race against pagevec d=
rain.
+ *
+ * In order to sort out that race, and get the after fault checks consis=
tent,
+ * the "quick and dirty" trick below is required in order to force a cal=
l to
+ * lru_add_drain_all() to get the recently MLOCK_ONFAULT pages moved to
+ * the unevictable LRU, as expected by the checks in this selftest.
+ */
+static void force_lru_add_drain_all(void)
+{
+	sched_yield();
+	system("echo 1 > /proc/sys/vm/compact_memory");
+}
+
 static int onfault_check(char *map)
 {
 	unsigned long page_size =3D getpagesize();
@@ -343,6 +360,9 @@ static int onfault_check(char *map)
 	}
=20
 	*map =3D 'a';
+
+	force_lru_add_drain_all();
+
 	page1_flags =3D get_pageflags((unsigned long)map);
 	page2_flags =3D get_pageflags((unsigned long)map + page_size);
=20
@@ -465,6 +485,8 @@ static int test_lock_onfault_of_present()
 		goto unmap;
 	}
=20
+	force_lru_add_drain_all();
+
 	page1_flags =3D get_pageflags((unsigned long)map);
 	page2_flags =3D get_pageflags((unsigned long)map + page_size);
 	page1_flags =3D get_kpageflags(page1_flags & PFN_MASK);
--=20
2.24.1

