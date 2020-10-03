Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DEE281FFA
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Oct 2020 03:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgJCBRY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 21:17:24 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15319 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJCBRY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 21:17:24 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f77d0bb0000>; Fri, 02 Oct 2020 18:15:39 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 3 Oct
 2020 01:17:23 +0000
Received: from sandstorm.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Sat, 3 Oct 2020 01:17:23 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH] selftests/vm: 10x speedup for hmm-tests
Date:   Fri, 2 Oct 2020 18:17:21 -0700
Message-ID: <20201003011721.44238-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601687739; bh=YW/NWGpa68jtDIRpTXUYduQIdru2AkHtxJU2AhNsM+0=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
        b=SoUIN9/u21hlPuWqGmiNhBACDJHJQd9Sn87vBzky3eLvGj5B72TVGaEHnYyH5QUlJ
         TMsVPyuYUtXFvaqPM6WIBfbsRs1PdRP6RdUW5E9XBUHNoCwz8QBmFhTc9xrde9QCZM
         NoqFEMU/8nEp7J1Hl4DKNYfMSNNl2m2yeOFGQEzeWrm4fXc8HtOZ9wSBLi6JFvUkY3
         q04FbnaWAW4TLzb5xewaBBh0oMWBA8TGIXMf3E7RhejB8SdmomvxhKeiHlxgRbOzIy
         9h4gnsKWzrQItebOvLEpeX4lQnyEhFQgD2B2k7oSndB3/3GMK0Qee3gntO4v0he4jV
         U1JzvDbLUk7OA==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch reduces the running time for hmm-tests from about 10+
seconds, to just under 1.0 second, for an approximately 10x speedup.
That brings it in line with most of the other tests in selftests/vm,
which mostly run in < 1 sec.

This is done with a one-line change that simply reduces the number of
iterations of several tests, from 256, to 10. Thanks to Ralph Campbell
for suggesting changing NTIMES as a way to get the speedup.

Suggested-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

This is based on mmotm.

 tools/testing/selftests/vm/hmm-tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftes=
ts/vm/hmm-tests.c
index 6b79723d7dc6..5d1ac691b9f4 100644
--- a/tools/testing/selftests/vm/hmm-tests.c
+++ b/tools/testing/selftests/vm/hmm-tests.c
@@ -49,7 +49,7 @@ struct hmm_buffer {
 #define TWOMEG		(1 << 21)
 #define HMM_BUFFER_SIZE (1024 << 12)
 #define HMM_PATH_MAX    64
-#define NTIMES		256
+#define NTIMES		10
=20
 #define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
=20
--=20
2.28.0

