Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F47E2986FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Oct 2020 07:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770574AbgJZGlL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Oct 2020 02:41:11 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13010 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1770549AbgJZGlC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Oct 2020 02:41:02 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f966f830001>; Sun, 25 Oct 2020 23:41:07 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 06:41:02 +0000
Received: from sandstorm.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Oct 2020 06:41:02 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shuah Khan <shuah@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 9/9] selftests/vm: 2x speedup for run_vmtests.sh
Date:   Sun, 25 Oct 2020 23:40:21 -0700
Message-ID: <20201026064021.3545418-10-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201026064021.3545418-1-jhubbard@nvidia.com>
References: <20201026064021.3545418-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603694467; bh=YaxNbn53iJTo0Zqqd0XK0hs/zmsFR5Tq5VhzHL3FjMc=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=Z2utBgK/QM6HMt/paiqpFJE3pN4KXFgyn2VjwwMQYkBlAY26mL/4fqFu2U2oWYhvt
         A4JIP9Tm2a1OaJLI2cAtKONTtVkSrKBFK997J+1I3S6R2C2X62Jw7MJ5JbNCrDWFSi
         jPzil8KDf5D+qjiHvLialCa6RNpR3llgKttBzRXZnEoDIeLRUvkr/WudssyyLF1Xof
         do61iGiBi01RNougugJsQcI4Ni3kAK5YQVFrC7nkX9u0YTg0GmsMRdmIKRWpnfbuaM
         HecH/4Ayj7vpIJfPk07ociCu/2kK6qWHSqCRPvvzBqxQj5ML/hSHJN7JdKU3k5dxPl
         ryhHtakDhFAoA==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Each invocation of userfaultfd for "anon" and "shmem" was taking about
6.5 sec to run, contributing to an overall run time of about 22 sec for
run_vmtests.sh.

Reduce the size and bounce input values to the userfaultfd invocation
within run_vmtests.sh, enough to get each invocation down to about 1.0
sec. This should still provide a reasonable smoke test, while staying
within a nominal time budget of around 1 second or so per test. And this
brings the overall running time of run_vmtests.sh down to 11 second.

Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/vm/run_vmtests.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/self=
tests/vm/run_vmtests.sh
index 4ac84b350d9f..9e8837768ee2 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -160,7 +160,7 @@ fi
 echo "-------------------"
 echo "running userfaultfd"
 echo "-------------------"
-./userfaultfd anon 128 32
+./userfaultfd anon 20 16
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
 	exitcode=3D1
@@ -185,7 +185,7 @@ rm -f $mnt/ufd_test_file
 echo "-------------------------"
 echo "running userfaultfd_shmem"
 echo "-------------------------"
-./userfaultfd shmem 128 32
+./userfaultfd shmem 20 16
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
 	exitcode=3D1
--=20
2.29.0

