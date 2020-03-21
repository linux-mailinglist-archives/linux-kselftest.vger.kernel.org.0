Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42CC618DC84
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Mar 2020 01:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgCUAbV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Mar 2020 20:31:21 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5081 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbgCUAbU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Mar 2020 20:31:20 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e755ff40000>; Fri, 20 Mar 2020 17:29:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 20 Mar 2020 17:31:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 20 Mar 2020 17:31:19 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 21 Mar
 2020 00:31:15 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 21 Mar 2020 00:31:15 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e7560530000>; Fri, 20 Mar 2020 17:31:15 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH v8 3/3] MAINTAINERS: add HMM selftests
Date:   Fri, 20 Mar 2020 17:31:08 -0700
Message-ID: <20200321003108.22941-4-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200321003108.22941-1-rcampbell@nvidia.com>
References: <20200321003108.22941-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1584750580; bh=bNrMPa0jrTNV4fcrzexEDzXuAkPayCgL/RpL1nSWEq4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=sQJwWTTYPeHTuFtS9c/PuGy+fTzcfjEBsl93lYRQ3DohZdMwIwYMi49AxT48k7uXt
         J18O7HhdLj1J4p5gEoClh1yH097UAA1HbwJ3oksXxgiIF/2h5S1tgOv0iTWBRlb8Ll
         DJCLQQVaqUgV98hMft2uDzim2xown9KZblxADidoUMblvRK7SubytFIH7uf0BHjF3I
         Z6etKG72v91Uc0BAD9VILagMWvIcJ68STlQjChlchbr5ycJmQt2K6IpXrowRiOKfPA
         3/CljxkhyS4DSwd1QiIFdvIfBJQEaGd8KyQuS0Jg+F8eDaTuuCmvJggLRBvjij5C2i
         f1ZZMqJ5T4q6w==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add files for HMM selftests.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fcd79fc38928..d9f5869d6cda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7610,7 +7610,10 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	mm/hmm*
 F:	include/linux/hmm*
+F:	include/uapi/linux/test_hmm*
 F:	Documentation/vm/hmm.rst
+F:	lib/test_hmm*
+F:	tools/testing/selftests/vm/*hmm*
=20
 HOST AP DRIVER
 M:	Jouni Malinen <j@w1.fi>
--=20
2.20.1

