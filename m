Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1AC01B4DAD
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Apr 2020 21:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgDVTuw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Apr 2020 15:50:52 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18207 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgDVTuv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Apr 2020 15:50:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ea09fa60000>; Wed, 22 Apr 2020 12:48:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 22 Apr 2020 12:50:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 22 Apr 2020 12:50:50 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 22 Apr
 2020 19:50:49 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 22 Apr 2020 19:50:49 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ea0a0180002>; Wed, 22 Apr 2020 12:50:49 -0700
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
Subject: [PATCH v10 3/3] MAINTAINERS: add HMM selftests
Date:   Wed, 22 Apr 2020 12:50:28 -0700
Message-ID: <20200422195028.3684-4-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422195028.3684-1-rcampbell@nvidia.com>
References: <20200422195028.3684-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587584934; bh=b7tTpiApGMMYtdFPfk/WzUBMYPgRnFiqmY96DP1koEQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
         Content-Type;
        b=lPNQGCeuKcLlWa6rgdUO/k6nXAWn2duMWq41iKuApymUt/YkALocc4nkXI2WnetU5
         9kknR0yx+wEoIavFU9ryFucGUcz5/Krps63TvPX3upafRZq5D5MwaudkI+dTHFO77Z
         TJspH8EIhcPG4H99x6sgE61WfRmLjjqNEAFPNuXTDIg/bVPZbu+G3hHmwWxLhTgy+F
         qmJQWJO+SqqdocUF3vw2ezqfEsrUdvBH0fO6HVMC8Z5k9Db1PNS/dfVI39F/X27lpH
         mL9oc9bWj7gzn+f7XXAGjkZzJT4WDVzvZwlEc26lC02ZsbXOFekZ/edBBIhk8JD8ii
         D/x2Q9kSUhVOg==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add files for HMM selftests.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b816a453b10e..96fc44d0f5f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7732,7 +7732,9 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/vm/hmm.rst
 F:	include/linux/hmm*
+F:	lib/test_hmm*
 F:	mm/hmm*
+F:	tools/testing/selftests/vm/*hmm*
=20
 HOST AP DRIVER
 M:	Jouni Malinen <j@w1.fi>
--=20
2.25.2

