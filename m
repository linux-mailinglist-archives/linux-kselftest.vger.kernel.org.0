Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D22F7215D3
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jun 2023 11:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjFDJZK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 05:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjFDJZK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 05:25:10 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A82B4;
        Sun,  4 Jun 2023 02:25:08 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6173F5C00EC;
        Sun,  4 Jun 2023 05:25:05 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 04 Jun 2023 05:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1685870705; x=1685957105; bh=XfcdNIb0iKDc88JTEvQZP3mryRBy0lricuJ
        YjJH51q8=; b=fV8hohYurmAXdy7NIRl2Iih+PmBfQOdum7I1ekGoQwAnkIF7wtP
        jE2wStOMgmyyFZwj2X0jUux5KkkST4/TFfRBpO3xVqnR1RMI64NX8cyZom82x6TP
        ZH64fXxv2uiNh5CKvR/ZOueQunPdYgXb2dUkMCWgtgconnL8F4Z7k1lV3GfDBG60
        C3ecL2Mf5bD2pLHT6RHPxbr4LmSy2HbikUo1Ua0ZY09wtRH0cbuzuQz5W8cGLGot
        D0cTu9umThZtsu9C/VIKEpMIA+3uiATn+aYZnShXbMmwPXVZZzk/k1gWcHm1U3gj
        DyVjd61XGY4k/DR4Hqnb7JilGP7r7BcnxIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685870705; x=1685957105; bh=XfcdNIb0iKDc88JTEvQZP3mryRBy0lricuJ
        YjJH51q8=; b=mZkmWbDvU3WZBsJ4N17WIaevXWee0F4bGB5O+xJ7V+hOeQuLvbf
        j3yvNn22dRxDNJGVUUkFRQ3CL6d/N/pXaRnkLzX0hGAvzYWCsytQ76SNvrxGBl3I
        c0PxUkjm4J5q1lSXD8Z7t0VXnwFLll1FyDb4/ptP/Ady1ffDykXSTn5n17Qchd80
        oY040w+i2YaQIy86KkzSXNlFjSRMPjyN6oFCCIg4aTwxIO1A3/949PrWkSdSJOGH
        sJAVjaSUNX6kMCsnuKgDl4yg6IrayHWc+kA6ElRm0NIBQ/DjBCT7yRWPZEP0n3Uo
        xAmzP/VbIHWA858SM4JHZCmBglw/ns204og==
X-ME-Sender: <xms:cFh8ZDsi772J3rLmhqkiafqbZkp92fewh2ldBc7ZQk83djUQnb_MIA>
    <xme:cFh8ZEex7Le44KnbYYiWu9IuR0LAcfnrTDRV5e6Kg2_qec8MGyprb565lNubz3kjF
    Uj8Rx7p05yr7R_51gI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeljedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:cFh8ZGyd4e0FaIFWo1-GtkqXOS66OWeMTjxHYwKlVk9GffWggrm_7g>
    <xmx:cFh8ZCN78gjlSaYc2zRKtDH1pLGG5d2bmQ_8ROvlqyZoZuKwj62oeA>
    <xmx:cFh8ZD-kZ8Q9ml3KMfmmNJth7F0_xTL_ruCiew5ufLpE9eqnQdF1Iw>
    <xmx:cVh8ZGYqRMrysLw4vMlis8bYI8CJmPzB2dpxf_RRHPG2Q0zBHp3-TA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8932EB60086; Sun,  4 Jun 2023 05:25:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <51e1db37-3981-4ea5-9348-b6f6b31ecc8a@app.fastmail.com>
In-Reply-To: <tencent_4668A50A08C3D31E7531619E@qq.com>
References: <cover.1685777982.git.falcon@tinylab.org>
 <68dace9e2532316ff454894697ecfd99e419a523.1685777982.git.falcon@tinylab.org>
 <2fccaff5-2354-4ac0-8389-1004d47d8dc9@t-8ch.de>
 <tencent_4668A50A08C3D31E7531619E@qq.com>
Date:   Sun, 04 Jun 2023 11:24:39 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Zhangjin Wu" <falcon@tinylab.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     "Willy Tarreau" <w@1wt.eu>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 11/12] selftests/nolibc: add new gettimeofday test cases
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jun 4, 2023, at 10:29, =E5=90=B4=E7=AB=A0=E9=87=91 wrote:
>
> Sorry for missing part of your feedbacks, I will check if -nostdlib=20
> stops the linking of libgcc_s or my own separated test script forgot=20
> linking the libgcc_s manually.

According to the gcc documentation, -nostdlib drops libgcc.a, but
adding -lgcc is the recommended way to bring it back.

> And as suggestion from Thomas' reply,
>
>>> Perhaps we really need to add the missing __divdi3 and __aeabi_ldivm=
od and the
>>> ones for the other architectures, or get one from lib/math/div64.c.
>
>>No, these ones come from the compiler via libgcc_s, we must not try to
> reimplement them. And we should do our best to avoid depending on them
> to avoid the error you got above.
>
> So, the explicit conversion is used instead in the patch.

I think a cast to a 32-bit type is ideal when converting the
clock_gettime() result into microseconds, since the kernel guarantees
that the timespec value is normalized, with all zeroes in the
upper 34 bits. Going through __aeabi_ldivmod would make the
conversion much slower.

For user supplied non-normalized timeval values, it's not obvious
whether we need the full 64-bit division

     Arnd
