Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FB3269B20
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Sep 2020 03:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgIOB3S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Sep 2020 21:29:18 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15393 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgIOB3E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Sep 2020 21:29:04 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6018d10001>; Mon, 14 Sep 2020 18:28:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 14 Sep 2020 18:29:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 14 Sep 2020 18:29:03 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Sep
 2020 01:29:02 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 15 Sep 2020 01:29:02 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.52.22]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f6018de0006>; Mon, 14 Sep 2020 18:29:02 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 2/2] selftests/vm: fix incorrect gcc invocation in some cases
Date:   Mon, 14 Sep 2020 18:29:01 -0700
Message-ID: <20200915012901.1655280-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915012901.1655280-1-jhubbard@nvidia.com>
References: <20200915012901.1655280-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600133329; bh=YXRQjVHw+ed30bzvLPvyZylzyyOGabivbYbBP0UE7/0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=bXDgqilpWOGNSEqdqyYdIiMsZpXv3obNwn+Rw762HjUJDJxSG1F296n8/tzUsAj4L
         NX3DEOL60q70iciUHRrP0zRZki5GOzSSAjQnzS/I5Xu66wxfM5MDPEJXfsw2tvLMJE
         r2hXKnnoxarCGjE0Mt+XxgbdHvWcPDHf+pkw/5FcAuKYxFKfT0y7Vzsj5+HAD+kkxz
         uo7bFj9UavV8nxFa3jRVmJ2bOl9uwySW5nuivxlHq9azIgHFVBdbR7NJvp4BSHGHxS
         v9K4rEz8fOLZRJE5lYLRPWJNeMgKrFbC5LhfnS3tM1e1qYZSB55eoZqwoqkS6YsJmD
         AujhowxfS8gRQ==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Avoid accidental wrong builds, due to built-in rules working just a
little bit too well--but not quite as well as required for our situation
here.

In other words, "make userfaultfd" (for example) is supposed to fail to
build at all, because this Makefile only supports either "make" (all),
or "make /full/path". However,  the built-in rules, if not suppressed,
will pick up CFLAGS and the initial LDLIBS (but not the target-specific
LDLIBS, because those are only set for the full path target!). This
causes it to get pretty far into building things despite using incorrect
values such as an *occasionally* incomplete LDLIBS value.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/vm/Makefile | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/=
vm/Makefile
index 9f2625bebf07..30873b19d04b 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -8,6 +8,18 @@ MACHINE ?=3D $(shell echo $(uname_M) | sed -e 's/aarch64.*=
/arm64/')
 # make invocations:
 .DELETE_ON_ERROR:
=20
+# Avoid accidental wrong builds, due to built-in rules working just a litt=
le
+# bit too well--but not quite as well as required for our situation here.
+#
+# In other words, "make userfaultfd" is supposed to fail to build at all,
+# because this Makefile only supports either "make" (all), or "make /full/=
path".
+# However,  the built-in rules, if not suppressed, will pick up CFLAGS and=
 the
+# initial LDLIBS (but not the target-specific LDLIBS, because those are on=
ly
+# set for the full path target!). This causes it to get pretty far into bu=
ilding
+# things despite using incorrect values such as an *occasionally* incomple=
te
+# LDLIBS.
+MAKEFLAGS +=3D --no-builtin-rules
+
 CFLAGS =3D -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
 LDLIBS =3D -lrt
 TEST_GEN_FILES =3D compaction_test
--=20
2.28.0

