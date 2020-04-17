Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6531E1AE8CE
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Apr 2020 01:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDQXzr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Apr 2020 19:55:47 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15718 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbgDQXzQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Apr 2020 19:55:16 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9a41a90000>; Fri, 17 Apr 2020 16:54:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 17 Apr 2020 16:55:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 17 Apr 2020 16:55:16 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 Apr
 2020 23:55:12 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 17 Apr 2020 23:55:12 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e9a41df0002>; Fri, 17 Apr 2020 16:55:11 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH v9 3/3] MAINTAINERS: add HMM selftests
Date:   Fri, 17 Apr 2020 16:54:58 -0700
Message-ID: <20200417235458.13462-4-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200417235458.13462-1-rcampbell@nvidia.com>
References: <20200417235458.13462-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587167657; bh=GyLokF/cCftHiQhFp0QTeYQ9GqyBdoCLnSMurDx5KYs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
         Content-Type;
        b=Frp8ejDzmhfC9X7XlBDO9tcA5U87RnhabyROBiZALpLPWpDkw7Zp1+WHzud+Nzv3B
         u2aCCu1jsijw5WOLyqQ2lYdmd4xoeWbw7NEDS37y6MSyfb6q+OXb7dnQRxJ5hvthVX
         lAqc3pneN5vbFvdPJvnCImc1X0QyC17ZwAFHqGWf2lgRyMDa62USNdXdQUIScEfNnp
         y7Sr8htiqDDxcj3jEfP8MXjBCPZnKli0J0IH6uMI6oByUiJIjklL3q5dkf/czccKfU
         5sBNObm2IbBpxltGP/QuoFcMsxdVM1r65gPapnyUhb9Wr5uNoWRngBI7bsoTw6J41c
         Gzu7yeDXLW0oQ==
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
index e64e5db31497..072921b7bae2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7729,6 +7729,9 @@ S:	Maintained
 F:	Documentation/vm/hmm.rst
 F:	include/linux/hmm*
 F:	mm/hmm*
+F:	include/uapi/linux/test_hmm*
+F:	lib/test_hmm*
+F:	tools/testing/selftests/vm/*hmm*
=20
 HOST AP DRIVER
 M:	Jouni Malinen <j@w1.fi>
--=20
2.25.2

