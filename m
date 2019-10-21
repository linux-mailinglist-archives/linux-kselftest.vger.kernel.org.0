Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B448ADF768
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2019 23:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbfJUVYi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Oct 2019 17:24:38 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9072 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbfJUVYi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Oct 2019 17:24:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dae22190000>; Mon, 21 Oct 2019 14:24:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 21 Oct 2019 14:24:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 21 Oct 2019 14:24:37 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Oct
 2019 21:24:37 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 21 Oct 2019 21:24:37 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dae22150002>; Mon, 21 Oct 2019 14:24:37 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Keith Busch <keith.busch@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/1] mm/gup_benchmark: fix MAP_HUGETLB case
Date:   Mon, 21 Oct 2019 14:24:35 -0700
Message-ID: <20191021212435.398153-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191021212435.398153-1-jhubbard@nvidia.com>
References: <20191021212435.398153-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571693081; bh=Ia7+yGVPadcQzuPA7gW008zSE+NH1nISNCbcuj3+bIA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=OTC8d3ZE9fJ0Hb2v8pEfvXND3hp78cAKhSqr+KUCHRl9piPHKBIHMod7VkMRG/V07
         YiSuKsdFJN/DtpDmHBNAjg0SY/+yw6EZVbEBBRcY5hKDPY2cwJi4Yy17qhEwozgbXp
         jD2oUyt7AENs2BEp1SMVn3lETH6pAEsDl/oDEcIUTKXYkUka0rUy3UXtxBZdCe2Fhs
         9YL7rBPNlFbNtFy9br7US89E0IFpJiaTELl5vPfnQioCelddiyfHAyOHRjNZks6g4s
         lPQfDa1Mgyz+bDNtzAbOYex69TebqWe0OaW+5qZRnZrgQmhswsnaA2NIMik4bxbUW5
         i3YmawSo4o7Hg==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The MAP_HUGETLB ("-H" option) of gup_benchmark fails:

$ sudo ./gup_benchmark -H
mmap: Invalid argument

This is because gup_benchmark.c is passing in a file descriptor to
mmap(), but the fd came from opening up the /dev/zero file. This
confuses the mmap syscall implementation, which thinks that, if the
caller did not specify MAP_ANONYMOUS, then the file must be a huge
page file. So it attempts to verify that the file really is a huge
page file, as you can see here:

ksys_mmap_pgoff()
{
    if (!(flags & MAP_ANONYMOUS)) {
        retval =3D -EINVAL;
        if (unlikely(flags & MAP_HUGETLB && !is_file_hugepages(file)))
            goto out_fput; /* THIS IS WHERE WE END UP */

    else if (flags & MAP_HUGETLB) {
        ...proceed normally, /dev/zero is ok here...

...and of course is_file_hugepages() returns "false" for the /dev/zero
file.

The problem is that the user space program, gup_benchmark.c, really just
wants anonymous memory here. The simplest way to get that is to pass
MAP_ANONYMOUS whenever MAP_HUGETLB is specified, so that's what this
patch does.

Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/vm/gup_benchmark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/sel=
ftests/vm/gup_benchmark.c
index cb3fc09645c4..485cf06ef013 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_benchmark.c
@@ -71,7 +71,7 @@ int main(int argc, char **argv)
 			flags |=3D MAP_SHARED;
 			break;
 		case 'H':
-			flags |=3D MAP_HUGETLB;
+			flags |=3D (MAP_HUGETLB | MAP_ANONYMOUS);
 			break;
 		default:
 			return -1;
--=20
2.23.0

