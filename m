Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068067240C0
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 13:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbjFFLV7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 07:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbjFFLVt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 07:21:49 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90568E5E;
        Tue,  6 Jun 2023 04:21:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id F33D95C01BC;
        Tue,  6 Jun 2023 07:21:47 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 06 Jun 2023 07:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686050507; x=1686136907; bh=1x
        n4EnfXPYPcSd+SYlCMqeGdlk7+uLOsdP8xB0JMCIg=; b=Ql8KhoFvs6janwDPYm
        OzFnqZbirQ3Y1K/vaWQUlfwmD6LLsen3JVt1Trqjhmh1d6XJaad8lWQ/Lnqi3H60
        f0DMSkIZbX1RAd1S3OiQgOy/huyUyDrgIK311sNrC9SVe4CMaC12/NySF6Oi6SYI
        T0xJtHVXbRqTxA346xGMtBCkMTiR2bjcah9oeGV2pehTWN+Q3m3QOs4UtlEHfor1
        ATqjmdDuCG/8IVRJsw19UFeisjALKMEEuIhKJdMFkSP8zmyYOXO9cjCwPMV7JrHG
        1moLS1VazweI4fT39KVr/Wvxh/U+JubvzNVd6GTLfWGvvbT4Ax8XHQg7Qeu0d1jz
        oE9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686050507; x=1686136907; bh=1xn4EnfXPYPcS
        d+SYlCMqeGdlk7+uLOsdP8xB0JMCIg=; b=SoXI6SuToid++cgZQHF+nQwl5JUOj
        B7iVXV2kSaTM6n4O/WMF/pZSxe14Lp/NszNzLEzghNRlmhh6PkKz9aQA5GIadIcy
        sVd8mf1y9DyNR4aAqyb+xyfP7lC4ROYB24Y7TcxuPswg7T83xu0gmOF1rJTnXQf2
        5RpPjxVsykYqTUgp8VfuoP85DUjrQDAf4b6iBvcm3gTGn1cjnadFvHmfy8jA4aRd
        DKGFVTgCMoPfmpDSn1XVpoU4/ymakGZlF+kuwniJd/wRlYPDe6tOvonLCmNdwqUw
        vcOxpswbtRteBo6hIP4O69/NM0zUMLBp+pp81ElMQehHzbt1h+AwapsAg==
X-ME-Sender: <xms:yhZ_ZM8OrrNAFSWfiy_I81HTHoPLeUkTMlXNIPkNhZ6lbqofLZkK0A>
    <xme:yhZ_ZEtkNFO4emSxZjf73vuZBsZRrOiSU_a8c9Qv7WubopeJ1rQVorVGmqlf7RCa_
    Yce6O80Q0xxIFuCrxE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtuddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:yxZ_ZCBu7vWQL64mUtLPgb2p5GNhVIwZVeAxWIvr1Huc-JIXN-OUCw>
    <xmx:yxZ_ZMcP2Xc1TwSQbQs00NMfGL5dDmmy2GUm4thhbLAAw0dL1V_M_w>
    <xmx:yxZ_ZBNGUGXTxkdrRQATBt9rqKTOj7AcJwUPc7-8tnf9xwjiYyYxDg>
    <xmx:yxZ_ZCquUM0kNEoguyU_GnRNzIHkGfSFKYmSx0osfr8NYSbTAm_Ang>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DC0D9B60086; Tue,  6 Jun 2023 07:21:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <63133024-e986-44e2-86f5-efc1c42207ac@app.fastmail.com>
In-Reply-To: <20230606111216.524384-1-falcon@tinylab.org>
References: <d1c83340-af4c-4780-a101-b9d22b47379c@app.fastmail.com>
 <20230606111216.524384-1-falcon@tinylab.org>
Date:   Tue, 06 Jun 2023 13:21:26 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Zhangjin Wu" <falcon@tinylab.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        "Willy Tarreau" <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 3/3] selftests/nolibc: riscv: customize makefile for rv32
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 6, 2023, at 13:12, Zhangjin Wu wrote:
>> On Sat, Jun 3, 2023, at 11:05, Zhangjin Wu wrote:
>> would seem more consistent with how x86 is handled, and would
>> probably be more easily extensible if we want to also make
>> this work with other sub-targets like mipseb, armv5 or ppc32
>> in the future.
>
> As Arnd and Thomas suggested to align with x86, I just tried to find a
> solution to avoid mixing the use of _ARCH and ARCH in this Makefile.
>
> Since both riscv32 and riscv64 share the same SRCARCH=riscv (arch/riscv),
> and the kernel side doesn't accept riscv32 or riscv64 currently, we need to
> manually convert them to _ARCH=riscv and pass them to the kernel makefile
> like this: ARCH=$(_ARCH), it mixes the use of _ARCH and ARCH, this is why I
> used the '$(if' method currently.
>
> The solution is adding something like x86 in the kernel Makefile:
>
>     diff --git a/Makefile b/Makefile
>     index 9d765ebcccf1..a442c893d795 100644
>     --- a/Makefile
>     +++ b/Makefile
>     @@ -415,6 +415,14 @@ ifeq ($(ARCH),parisc64)
>             SRCARCH := parisc
>      endif
>
>     +# Additional ARCH settings for riscv
>     +ifeq ($(ARCH),riscv32)
>     +        SRCARCH := riscv
>     +endif
>     +ifeq ($(ARCH),riscv64)
>     +        SRCARCH := riscv
>     +endif
>     +
>      export cross_compiling :=
>      ifneq ($(SRCARCH),$(SUBARCH))
>      cross_compiling := 1

I've never been a big fan of the top-level $(ARCH) setting
in the kernel, is there a reason this has to be the same
as the variable in tools/include/nolibc? If not, I'd just
leave the Linux Makefile unchanged.

For userspace we have a lot more target names than
arch/*/ directories in the kernel, and I don't think
I'd want to enumerate all the possibilities in the
build system globally.
> b/tools/testing/selftests/nolibc/Makefile
>     index 4a3a105e1fdf..1b2247a6365d 100644
>     --- a/tools/testing/selftests/nolibc/Makefile
>     +++ b/tools/testing/selftests/nolibc/Makefile
>     @@ -21,6 +21,8 @@ IMAGE_x86        = arch/x86/boot/bzImage
>      IMAGE_arm64      = arch/arm64/boot/Image
>      IMAGE_arm        = arch/arm/boot/zImage
>      IMAGE_mips       = vmlinuz
>     +IMAGE_riscv32    = arch/riscv/boot/Image
>     +IMAGE_riscv64    = arch/riscv/boot/Image
>      IMAGE_riscv      = arch/riscv/boot/Image
>      IMAGE_s390       = arch/s390/boot/bzImage
>      IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
>     @@ -34,6 +36,8 @@ DEFCONFIG_x86        = defconfig
>      DEFCONFIG_arm64      = defconfig
>      DEFCONFIG_arm        = multi_v7_defconfig
>      DEFCONFIG_mips       = malta_defconfig
>     +DEFCONFIG_riscv32    = rv32_defconfig
>     +DEFCONFIG_riscv64    = defconfig
...

Right, that part looks good to me.

      Arnd
