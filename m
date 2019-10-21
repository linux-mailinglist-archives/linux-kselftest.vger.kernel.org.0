Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87BD9DF767
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2019 23:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbfJUVYi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Oct 2019 17:24:38 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12213 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUVYi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Oct 2019 17:24:38 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dae221b0000>; Mon, 21 Oct 2019 14:24:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 21 Oct 2019 14:24:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 21 Oct 2019 14:24:37 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Oct
 2019 21:24:37 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 21 Oct 2019 21:24:37 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dae22150001>; Mon, 21 Oct 2019 14:24:37 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Keith Busch <keith.busch@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/1] mm/gup_benchmark: fix MAP_HUGETLB case
Date:   Mon, 21 Oct 2019 14:24:34 -0700
Message-ID: <20191021212435.398153-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571693083; bh=wu/SMv1VjPJ5GhwwryKc/x1EceeeDVg2bDlxgVqD7SA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=lr0DG/CMWSKkIRrB6/PQUu74DTjBkutvIoEjyJ7e9I+xY3sg+OdVB28hD/TxYTG6f
         LinV6bhwqOFcLYnYe5T8TdST9BpSdwaHDLIafrscXs9ylWZ75pFW93dGUKBnAkApWr
         ewDAEVu1T4yb1ojcafsT8t6V5UtSMkPw8dwC3Eh2/Vi+yt4sCvJTXEYpJQB5oujFfi
         es8YKQ40DWXvdq8RKvn+WLc2PLfGFilDMn4b82pmQt0z7usL/ttuzs4zyQeYHpGQLT
         OZ9zPPd+CEovYE57GT5VEcBY37/fxavtpz4mNfRM1ZfNWYErke/gG3NaC6E3USm8X8
         MO4Gq9iqAfg6g==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Here's another gup_benchmark.c fix, which I ran into while adding
support for the upcoming FOLL_PIN work. Anyway, the problem is
clearly described in the patch commit description, and the fix seems
like the best way to me, but the fix is not *completely* black and
white.

This fix forces MAP_ANONYMOUS for the MAP_HUGETLB case. However,
another way to do it might be to mmap() against a valid hugetlb
page file, instead of /dev/zero. But that seems like a lot of
trouble and if I'm reading the intent correctly, MAP_ANONYMOUS
is what's desired anyway.

John Hubbard (1):
  mm/gup_benchmark: fix MAP_HUGETLB case

 tools/testing/selftests/vm/gup_benchmark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
2.23.0

