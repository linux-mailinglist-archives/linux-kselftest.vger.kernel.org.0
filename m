Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA7F1FFAD2
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jun 2020 20:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgFRSLC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Jun 2020 14:11:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33217 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729982AbgFRSK6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Jun 2020 14:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592503856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ugL5EDkOFovVhePvihWbG2FEcMKXoqwpXQR5vaHX4hs=;
        b=AqeRXgr3rHB9ifK0yf8rLKDcaYg7PChb3VwlOB2nblOOe3Vq6vybmUMhl98NuE3kz6vYBH
        lIAq3IrDNv+BYufsDm+bHVX1D0mIcO02n5jvAM1TcJgMUPKiJ4Y0TVxhh3I9Xrw0jYMzG3
        kLq1hQwZoYlZAjIw7U9/OZisXSKLP/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-e8Q8XtJPMwWrWU3vWEU3vw-1; Thu, 18 Jun 2020 14:10:54 -0400
X-MC-Unique: e8Q8XtJPMwWrWU3vWEU3vw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD8D81005512;
        Thu, 18 Jun 2020 18:10:53 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (ovpn-112-56.rdu2.redhat.com [10.10.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BCBF1E226C;
        Thu, 18 Jun 2020 18:10:52 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Yannick Cote <ycote@redhat.com>
Subject: [PATCH v3 2/3] selftests/livepatch: refine dmesg 'taints' in dmesg comparison
Date:   Thu, 18 Jun 2020 14:10:39 -0400
Message-Id: <20200618181040.21132-3-joe.lawrence@redhat.com>
In-Reply-To: <20200618181040.21132-1-joe.lawrence@redhat.com>
References: <20200618181040.21132-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The livepatch selftests currently grep on "taints" to filter out
"tainting kernel with TAINT_LIVEPATCH" messages which may be logged when
loading livepatch modules.

Further filter the log to drop "loading out-of-tree module taints
kernel" in the rare case the klp_test modules have been built
out-of-tree.

Look for the longer "taints kernel" or "tainting kernel" strings to
avoid inadvertent partial matching.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Revieved-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Yannick Cote <ycote@redhat.com>
---
 tools/testing/selftests/livepatch/functions.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index bf73ec4f4a71..5e5a79179fc1 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -277,7 +277,8 @@ function check_result {
 	# post-comparison sed filter.
 
 	result=$(dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$SAVED_DMESG" - | \
-		 grep -v 'tainting' | grep -e 'livepatch:' -e 'test_klp' | \
+		 grep -e 'livepatch:' -e 'test_klp' | \
+		 grep -v '\(tainting\|taints\) kernel' | \
 		 sed 's/^\[[ 0-9.]*\] //')
 
 	if [[ "$expect" == "$result" ]] ; then
-- 
2.21.3

