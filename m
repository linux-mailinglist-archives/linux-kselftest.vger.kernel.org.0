Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9B8725B3E
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 12:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbjFGKCp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 06:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238408AbjFGKCo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 06:02:44 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4303E19BD;
        Wed,  7 Jun 2023 03:02:43 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 89F633200907;
        Wed,  7 Jun 2023 06:02:40 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 07 Jun 2023 06:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686132160; x=1686218560; bh=T0
        S94E2qLXmGs+N9sPOaQszP553BKZ2FJLocWfYPArs=; b=pFhjS116As8+eGURjI
        zVHDXCcfMw2WiNMgh3caeu5W6Fpjv5Bo5arbt445G4Ii3l0NgiWci8HdkXDCbE7j
        RbuTQqfMjFMXWdjpo58NMN24tC84cBVnIBIEZBYZQnyvjU6xpAxyKHBd6K+oFd1O
        HYKnOwSH3S364eDp9K+YXhHnkb2ryLRIx1pbskIO3y0EHyyj0zSpwTuDzo8j8Gpm
        ALCYUqnfSIIr+mRw7NzfQE6V9jAZ8Qyg8QJ0bJdWIvVLzRDlsvL38xnaJQQ9k0my
        ck9peEuB/sSL9ZVv+FBjUtIFDuukdpR4EusWJmbu8InAzLKoVADG1iRjkxremr3J
        acPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686132160; x=1686218560; bh=T0S94E2qLXmGs
        +N9sPOaQszP553BKZ2FJLocWfYPArs=; b=t8ZZIgthjGwEP1RH+BAH4u5JBRhm7
        ZnXTWLnHptByfT2ahXyjN+BqgcKxWyELWKlp9hBk8Q0Bchj7u1copP+07bM4cYFO
        47sm6ZPJo2RBXGGAOhYlcd8L82/mGxF3iImaWsF5WpVO3lefh1RmeLFC1Fz4opq3
        d2Rhm+ooAoNRLUjASCToADEW7D3iOXIw2POZHMUeBaxUVBNlfyvunBTS754pcBtS
        DyMnXvvnIAR6HD5C2uDIEb5iqfqzfMjK58l5cWjjIohtmitJuIQhT3xqxBsAgfzv
        WwIEpYNcZ+qYJ4gNDZQIqHaof3ye7q4YkSXIAPCJSp3RhsHBt6A8dhoAg==
X-ME-Sender: <xms:v1WAZNZ6tx4KzLLwjBQybMyfYrpydqQygebu58gMU898AaW3Mybsxg>
    <xme:v1WAZEatuQXZPeiyRazxsbX3d6f2KdM7mEZ8Joak9-W_Nn0ZwoOM2j0h8NB8lGVji
    f12eYqsaVUL0Vpli0E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtgedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffdtleeuheffgefggedugfelleeigfdukeegffeggefhveffgeekteduleel
    vdetnecuffhomhgrihhnpeguihgvrdhnvghtnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:v1WAZP8CpKmKcWHhUIHLX1JxIlfSRjRGRMjCP-2R5lQFwxZOdQGFbQ>
    <xmx:v1WAZLrMfb9ykHuWBytX9AIPB1zYj5Q47SnOwDbZuTmgL7sFnciGcQ>
    <xmx:v1WAZIoLO9IR2dKbhHGEOnadDVWykCK-gRTYXRN-dsPt49J4Yap3jw>
    <xmx:wFWAZDWWByNSSzYfgRTvqGCehTTBvNYxePiX4YXRyDy2bA9U4OPQzg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 14B58B60086; Wed,  7 Jun 2023 06:02:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <635d1aaf-3982-4404-9c05-05e51800691e@app.fastmail.com>
In-Reply-To: <20230607094615.792013-1-falcon@tinylab.org>
References: <b80f021a-30b7-47e9-8455-3844be157cc2@app.fastmail.com>
 <20230607094615.792013-1-falcon@tinylab.org>
Date:   Wed, 07 Jun 2023 12:02:18 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Zhangjin Wu" <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        "Willy Tarreau" <w@1wt.eu>
Subject: Re: [PATCH v3 1/3] tools/nolibc: fix up #error compile failures with -ENOSYS
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

On Wed, Jun 7, 2023, at 11:46, Zhangjin Wu wrote:
>> On Wed, Jun 7, 2023, at 07:19, Zhangjin Wu wrote:
>
> Ok, agree, as the 64bit version of lseek may be enough for nolibc, if a target
> application really require, they can add the alias themselves.
>
>> Are there any examples of functions where we actually want mulitple
>> versions?
>>
>
> For example, the following ones are related to the syscalls being added,
> all of them have similar library routines in current sys.h:
>
> * waitid, https://linux.die.net/man/2/waitid
> * ppoll, https://linux.die.net/man/2/ppoll
> * pselect, https://linux.die.net/man/2/pselect6
> * clock_gettime, https://linux.die.net/man/2/clock_gettime
>
> The similar routines are put in right side:
>
> * waitid --> waitpid, wait, wait4
> * ppoll --> poll
> * pselect --> select
> * clock_gettime --> gettimeofday

Ok, I think these are all useful to have in both versions.

All four of these examples are old enough that I think it's
sufficient just expose them to userspace as the bare system
calls, and have the older library calls be implemented using
them without a fallback to the native syscalls of the same
name on architectures that have both, newer architectures
would only have the latest version anyway.

> For the clock_gettime, it may also let us think about if we need to add
> its friends (clock_getres, clock_settime) together.

Yes, I think that makes sense. We also need clock_settime()
to implement settimeofday() on rv32.

Ideally, I'd love to extend the tooling around system calls
in the kernel so we can automatically generate the low-level
wrapper functions from syscall.tbl, but this needs a lot of
other work that you should not need to depend on for what
you are doing right now.

     Arnd
