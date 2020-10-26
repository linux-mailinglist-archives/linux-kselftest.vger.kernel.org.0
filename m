Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611572986F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Oct 2020 07:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770536AbgJZGlB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Oct 2020 02:41:01 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11563 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1770532AbgJZGlB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Oct 2020 02:41:01 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f966f850000>; Sun, 25 Oct 2020 23:41:09 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 06:41:01 +0000
Received: from sandstorm.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Oct 2020 06:41:01 +0000
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
Subject: [PATCH v3 3/9] selftests/vm: rename run_vmtests --> run_vmtests.sh
Date:   Sun, 25 Oct 2020 23:40:15 -0700
Message-ID: <20201026064021.3545418-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201026064021.3545418-1-jhubbard@nvidia.com>
References: <20201026064021.3545418-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603694469; bh=WdoWEqTNiav7NyD5HcaEtNdHSu4LOQ12IbFmU76EADo=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type:X-NVConfidentiality:
         Content-Transfer-Encoding;
        b=JJ1lwM72L7Dn+NEcHc3EynSVnpobex0IK0D/s3ZsVPVE9OgV1eE/MC7FuqhVYjL/G
         rXHhkzYH5vtaRN9Wd33695ErvG9EW1+1qHCdvzqxYtIlW7NQ4x+1cwzF2oaZqI7jom
         ljAEfJl6AXKakCVzqEhwOMIntDS3qdL3GpFSRK+g7NKIKeRP/MfmyY+wbuKM7FpN5J
         sq/7xuhja1Bbdf+MOoWcF7ubz68ZulcR151MKO8VGCSNV7CP/mz9v/JuD2p82snkjH
         kmCwUUoGc5bjqf5GZQXHRI1DbK9M4Ztbnd9HEwHzp2qMt6nImS6LOSfi5+yrqsxmwj
         brXYdvwg0P3hA==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rename to *.sh, in order to match the conventions of all of the other
items in selftest/vm.

The only reason not to use a .sh suffix a shell script like this, might be
to make it look more like a normal program, but that's not an issue here.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/vm/Makefile                        | 2 +-
 tools/testing/selftests/vm/{run_vmtests =3D> run_vmtests.sh} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/vm/{run_vmtests =3D> run_vmtests.sh} (100%)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/=
vm/Makefile
index 9cc6bc087461..5a3bd0c497b6 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -69,7 +69,7 @@ TEST_GEN_FILES +=3D virtual_address_range
 TEST_GEN_FILES +=3D write_to_hugetlbfs
 endif
=20
-TEST_PROGS :=3D run_vmtests
+TEST_PROGS :=3D run_vmtests.sh
=20
 TEST_FILES :=3D test_vmalloc.sh
=20
diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftes=
ts/vm/run_vmtests.sh
similarity index 100%
rename from tools/testing/selftests/vm/run_vmtests
rename to tools/testing/selftests/vm/run_vmtests.sh
--=20
2.29.0

