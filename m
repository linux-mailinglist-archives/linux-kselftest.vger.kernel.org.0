Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2586721667
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jun 2023 13:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjFDLjG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 07:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFDLjF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 07:39:05 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24667CD;
        Sun,  4 Jun 2023 04:39:04 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E72555C00F5;
        Sun,  4 Jun 2023 07:39:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 04 Jun 2023 07:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1685878740; x=1685965140; bh=DE
        Q24KaCgZ4/pEUSv8IkC2IlBgiOfkfs8fsUXXMnOhs=; b=O13GmFivotkhY/CCsM
        kQ1Jrf5MmMFSE8POyLnqrnysH1lWvf5kcc9FOhAOJCd2w7+i2fLDtgnKnvQ2h3K6
        +vw/Oce3ODUC4VXzS3fp3vNO6xdxTU/YLZ16LH2Yp2XoMbnddwzUIBt+mlayzaF8
        MDpUM03/GvC4U2x2/baCB09tmp6jwcMpJTjn4WjF+450F6mvzn0LzNMSfMTB5p0/
        tOY9X6H5mvCX9xgnbcCDP6NkkR+smQgIe7TIWX9w8BYCr4NqrO+BVTUZGymhbtAq
        /Gqh+iF2fCI5jKckvc5Xu5zAx6DcvVq03iGPOzrvvgZ6T9DYKBY0Z50NwtTmi5cA
        F7uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685878740; x=1685965140; bh=DEQ24KaCgZ4/p
        EUSv8IkC2IlBgiOfkfs8fsUXXMnOhs=; b=zn8g6WPW+s68N+nwbcsnTobAjgL6q
        bVJ1ymrzhsmcx9OPlVor6CPkp/OYvlCIRlFA964UNAD7U7EX942TVX8RCnhcKsXi
        KkN97cz9B5cQMTSYVluX0gAaF2jbSOf/aB+piI6KOU7K7IQ2sw1jkpIr4UtSV7Pn
        jeyP87Z5VBMYTNC+pPPhkaOho4j5/la0avjLK3GOw95VVtqRS/MPjIKIOYXxDRuN
        4J4RiqGLe3x/tbasqp4tfg0FUhkR92h/F0L2hbqI/0lrBrddS3FXnlerDlCk4D8e
        9j8oeWADcMXK578Jy3al5WlB6sRN3GHwyE7n7z2wXX5HzqhREKJsuFdjQ==
X-ME-Sender: <xms:1Hd8ZBLt4IW7vdclxPXDMgCe2tn0rUu0ZkhVs8QVHeRFsICgAKvYCg>
    <xme:1Hd8ZNI4UYaVKb1iR-9mI-TQYXImdC_5L6-uWoWxdLFtxbQRvtcHofyILPGEtdBg4
    ZUAmxTl3TWGxcjIQQE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeljedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:1Hd8ZJs1mp7itbAdgrucjR-Akjxp8C4m0uRTzJ9QM7eGgtK_i0btKQ>
    <xmx:1Hd8ZCaBmS1343W9HbMuVvsrXh47ncFAIfLRSe5IrCyoVba85n9VTQ>
    <xmx:1Hd8ZIblr5OKicbkwZarrfjoW5apzW7ov9WTKXgdoijsArewIrMCcg>
    <xmx:1Hd8ZAEMCwjTgHVdLtkztAq1nkyfdf8TbqxqdXsWtTWOBQ3KMX7-4g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 55000B60086; Sun,  4 Jun 2023 07:39:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <54edae1f-0c1c-4beb-b6ac-fcd61fc81de8@app.fastmail.com>
In-Reply-To: <ZHx1OliMqHx9U1Lw@1wt.eu>
References: <cover.1685777982.git.falcon@tinylab.org>
 <68dace9e2532316ff454894697ecfd99e419a523.1685777982.git.falcon@tinylab.org>
 <2fccaff5-2354-4ac0-8389-1004d47d8dc9@t-8ch.de>
 <tencent_4668A50A08C3D31E7531619E@qq.com>
 <51e1db37-3981-4ea5-9348-b6f6b31ecc8a@app.fastmail.com>
 <ZHx1OliMqHx9U1Lw@1wt.eu>
Date:   Sun, 04 Jun 2023 13:38:39 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Willy Tarreau" <w@1wt.eu>
Cc:     "Zhangjin Wu" <falcon@tinylab.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 11/12] selftests/nolibc: add new gettimeofday test cases
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jun 4, 2023, at 13:27, Willy Tarreau wrote:
> On Sun, Jun 04, 2023 at 11:24:39AM +0200, Arnd Bergmann wrote:
>> 
>> For user supplied non-normalized timeval values, it's not obvious
>> whether we need the full 64-bit division
>
> We don't have to care about these here for the microsecond part,
> because for decades these were exclusively 32-bit. Also the only
> one consuming this field would have been settimeofday() and it's
> already documented as returning EINVAL if tv_usec is not within
> the expected 0..999999 range.

Right

> Over time we managed
> to make simple code compile with both glibc and nolibc, but when it
> comes at the cost of adding size and burden for the developers, such
> as forcing them to add libgcc, I prefer that we slightly limit the
> domain of application instead.

Good point. This also reminds me that the compilers I build for
https://mirrors.edge.kernel.org/pub/tools/crosstool/ don't always
have every version of libgcc that may be needed, for instance
the mips compilers only provide a big-endian libgcc and the
arm compilers only provide a little-endian one, even though
the compilers can build code both ways with the right flags.

      Arnd
