Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506FF6AC7CC
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 17:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCFQYI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 11:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjCFQXc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 11:23:32 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ACC14232;
        Mon,  6 Mar 2023 08:22:10 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 6A16932007CF;
        Mon,  6 Mar 2023 11:09:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 06 Mar 2023 11:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678118959; x=1678205359; bh=XR
        O8Do199obI6zA36V/kT6yPqF9RqFZuXH+nYQYRKNc=; b=NusjyYLc/7OA3juj4B
        6dCU1nz3WCEgpzuPH3rl5sULYqlX+QQXjpUs4B+a0t2Ps3wd2Cj+4EgMCgKkcwHQ
        LJwC3mPu33p+jwC+XJhwXmXQuzlv3xEJo0aoq34UE+5gpZErn79gL2qtkDzDT4h5
        pEldO6OKHojQqkTNi/K1SeMKmI18gPB9gTXWZ+VoWnYpqYCmYH7lL1HGq0vQNOO7
        m+JMqOp1H7xfENi8/fFgf0g8Im6iH38VOfSKvhpckK3y9mWB0GUr9DlEI8oxqOiA
        yvyuRFGy/Gh5WoHYaokyxQr4zyROY+x9/32eHw8dKh4TGmTUYETL4XACU6aouHUb
        uWBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1678118959; x=1678205359; bh=X
        RO8Do199obI6zA36V/kT6yPqF9RqFZuXH+nYQYRKNc=; b=T6I4O+s0y64Cq32Mj
        22Jy8qk2PviPfAm9KK+/F+MW7vXTKV+qaugy9TlEYpKEPvfrAQZQUVp9pC1QObWO
        deoabPG0Ks9nRMhWbAFpze2NYJF8evgea0y2iJbX6XBoGeywidsg/Jmx0rqsKzg+
        vtHT19GK+z3SFYBN+C5WV88A83Cgj/k/uG+VDWTAg30uaD0R6goKR2vF79lryn1P
        VFSlqOM/XpeYkh2Az44FrRYgFakMlJ/0ZNnZfBc8YrswXehuqF2urMtG+uN+4TBm
        j0BiUOoM6+u9toD7q7Ar7BsBcrKvy0K3MTRL7ownN9QzpdwiP97838UdIrUw4Uo1
        qfPZQ==
X-ME-Sender: <xms:LhAGZGfmCs3dluWFx5Sq0p0KFZHmJQ59FkfEEntzbxGUX00NtsZd9g>
    <xme:LhAGZAPAjhlcvEr8O9rcXKd_sXDjYUp9vQoVa59MWxyeMWOssWNTTwGwB9Gxoh-EO
    JuzU5GE6PpFIx8x5A>
X-ME-Received: <xmr:LhAGZHjLbrYd3mLlz-8lxokyY61ys-V7QQe70UwiUlqswsqvV3JkODeW7sy2X4ghvmSkyK94DwZI2GdHBE2ngqP2IFFrsiZDcVRvBZN7GtWS8LhJWxf9evb-g8AV8GY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtkedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpedtgffhtd
    etledtkeeihfefueeuhedvudfhvdeifeevtdektdetgfeiieejuefhtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
    htrdgtohhm
X-ME-Proxy: <xmx:LhAGZD_efR-RQ-367YJa65SiKudUfJJDxFi01vnJBOrI3u4Val1afw>
    <xmx:LhAGZCv_mz4VRKBPrQvvUHzD1GETOa_q0k1DmmRBUbO13OSk5LTYeQ>
    <xmx:LhAGZKHjNtahZDmlWOtlowyT0EGbQqYMtpViMGcv82CNAvT7SGoYMw>
    <xmx:LxAGZEUrCquYT3CdznGiOOAubxmWU8OOA7ASle3f-tH-YFB0Kc30Sg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Mar 2023 11:09:18 -0500 (EST)
From:   Zi Yan <zi.yan@sent.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Zach O'Keefe <zokeefe@google.com>
Subject: [PATCH] selftests/mm: fix split huge page tests
Date:   Mon,  6 Mar 2023 11:09:07 -0500
Message-Id: <20230306160907.16804-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.39.2
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Fixed two inputs to check_anon_huge() and one if condition, so the tests
work as expected.

Fixes: c07c343cda8e ("selftests/vm: dedup THP helpers")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Zach O'Keefe <zokeefe@google.com>
---
 tools/testing/selftests/mm/split_huge_page_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/test=
ing/selftests/mm/split_huge_page_test.c
index 76e1c36dd9e5..b8558c7f1a39 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -106,7 +106,7 @@ void split_pmd_thp(void)
 	for (i =3D 0; i < len; i++)
 		one_page[i] =3D (char)i;
=20
-	if (!check_huge_anon(one_page, 1, pmd_pagesize)) {
+	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
 		printf("No THP is allocated\n");
 		exit(EXIT_FAILURE);
 	}
@@ -122,7 +122,7 @@ void split_pmd_thp(void)
 		}
=20
=20
-	if (check_huge_anon(one_page, 0, pmd_pagesize)) {
+	if (!check_huge_anon(one_page, 0, pmd_pagesize)) {
 		printf("Still AnonHugePages not split\n");
 		exit(EXIT_FAILURE);
 	}
@@ -169,7 +169,7 @@ void split_pte_mapped_thp(void)
 	for (i =3D 0; i < len; i++)
 		one_page[i] =3D (char)i;
=20
-	if (!check_huge_anon(one_page, 1, pmd_pagesize)) {
+	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
 		printf("No THP is allocated\n");
 		exit(EXIT_FAILURE);
 	}
--=20
2.39.2

