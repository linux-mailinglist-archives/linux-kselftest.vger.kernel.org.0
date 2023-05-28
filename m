Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078D37138C9
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 May 2023 10:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjE1Ist (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 May 2023 04:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjE1Iss (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 May 2023 04:48:48 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A628C7;
        Sun, 28 May 2023 01:48:46 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C1A2032007F9;
        Sun, 28 May 2023 04:48:42 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 28 May 2023 04:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1685263722; x=1685350122; bh=dbKqJffHV3+pecTgDfQClj4wiqdZaANtKaF
        kt+SsH/g=; b=Tv2E3uUrtLBy2QKoeONeldiMNdpg6aLqu8QF/rrkSiRLOT5cjz0
        2fLEpW8vyASR9mA3Mzhiwn5BKVclmpDPSvvdUz1pqLqc+UlLvp+7EeoDWvZxeOky
        NuvYJ28OhKIEpaiWcNzX9px7nKR1cSuyM7JsuaufiR86tRSF/jCtD2Si3oAWgiiQ
        e5vgjq3f5m7XAMidY7sVwI3AthMTozE72BYNJVL4iW/WBlU5s+iJTKPHm0aNd2HN
        NcU+WiDRDFT1ATeGVcD1pbiLzAaVnldpvkK/J1qdaTM904TPIV2+omWuF3bLE63B
        I+jevwj+8OG9bndinGMoQWxSMvU5qv0cM/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685263722; x=1685350122; bh=dbKqJffHV3+pecTgDfQClj4wiqdZaANtKaF
        kt+SsH/g=; b=hG00OSxux0WIwOwHpOeMTe5riqTGkenybsGeCByKaiWIvN62/9/
        NvHEYkxgZhltRf4xLvurXskOkmxEkcAEAdKFXGiXldB1NUZShjGuWTwP8kaELdXl
        G8KbzNVfqBkxkyerJOjeicPbkOleoOJ6t9KDYIucpJE885ydoD9O/Cf6dS7NJL/n
        g4JCMrrFxRjcwyv4+QOk/cT9Ddgc8AUG+/PSX1GGzJ1hVzCSHsc5odl6KnUzzGgk
        BVLU7xg5kMhguVjlin6maI6NJ2LohbyRLT7a1IGXMeUOe+UhgRLKZazZ6TW8rIF0
        tUNOFS4b8Uk7W142wq100n/IiEVL+Hzc7Fg==
X-ME-Sender: <xms:ahVzZCQOGpZ583z5KzNxJV-esR1t_GGc9KRBMYr3BfeseIPIrGWhTQ>
    <xme:ahVzZHx58tqW9SqjX1q3WmwUpfjZ9f5GihvwGVdT1jtXWvZ1z4FjL4MpZ7rKici8k
    Dn-i0tvPTMeeYvKw9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekfedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:ahVzZP15E5B_QRNofh8yefy6zH_cdZxvPWfDRqT6SQPgUryvoC4_pg>
    <xmx:ahVzZOCqA_hcIcgk5Ux2za4siiOMWZjrXcI3OxIEFKFfhfdNcaEeNw>
    <xmx:ahVzZLjF2OfPnQPNnnQ43LrJu0jYlRQikHH_fpmVXThQazkKSrgv7A>
    <xmx:ahVzZBYmIc7C9FrVAQbxbWMrsHTcguiTAJ-bG74RcfSpuWfs_DAbGw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F404DB60086; Sun, 28 May 2023 04:48:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <9e4064fc-f0c5-4dd3-941f-344d2150e1cd@app.fastmail.com>
In-Reply-To: <20230528082509.293250-1-falcon@tinylab.org>
References: <83ab9f47-e1ed-463c-a717-26aad6bf2b71@app.fastmail.com>
 <20230528082509.293250-1-falcon@tinylab.org>
Date:   Sun, 28 May 2023 10:48:21 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Zhangjin Wu" <falcon@tinylab.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        "Willy Tarreau" <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>
Subject: Re: [PATCH 09/13] tools/nolibc: sys_poll: riscv: use __NR_ppoll_time64 for
 rv32
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

On Sun, May 28, 2023, at 10:25, Zhangjin Wu wrote:
>> On Fri, May 26, 2023, at 09:15, Thomas Wei=3DC3=3D9Fschuh wrote:

> * Use __NR_*time64 for all 32bit platforms
> * Use __NR_pselect6/ppoll/clock_gettime only for 64bit platforms
> * New sizeof tests added to verify off_t, time_t, timespec, itimerspec=
...
>
>    	CASE_TEST(sizeof_time_t);           EXPECT_EQ(1, 8,  =20
> sizeof(time_t)); break;
>     	CASE_TEST(sizeof_timespec);         EXPECT_EQ(1, 16, =20
> sizeof(struct timespec)); break;
>     #ifdef NOLIBC
>     	CASE_TEST(sizeof_itimerspec);       EXPECT_EQ(1, 32, =20
> sizeof(struct itimerspec)); break;
>     #endif
>     	CASE_TEST(sizeof_timeval);          EXPECT_EQ(1, 16, =20
> sizeof(struct timeval)); break;
>     	CASE_TEST(sizeof_itimerval);        EXPECT_EQ(1, 32, =20
> sizeof(struct itimerval)); break;
>     	CASE_TEST(sizeof_off_t);            EXPECT_EQ(1, 8,  =20
> sizeof(off_t)); break;
>
>
> @Arnd, the above timeval/itimerval definitions are used to override th=
e ones
> from linux/time.h to avoid such error:
>
>     error: redefinition of =E2=80=98struct timeval=E2=80=99
>
>     nolibc/sysroot/riscv/include/types.h:225:8: error: redefinition of=20
> =E2=80=98struct timeval=E2=80=99
>       225 | struct timeval {
>           |        ^~~~~~~
>     In file included from nolibc/sysroot/riscv/include/types.h:11,
>                      from nolibc/sysroot/riscv/include/nolibc.h:98,
>                      from nolibc/sysroot/riscv/include/errno.h:26,
>                      from nolibc/sysroot/riscv/include/stdio.h:14,
>                      from=20
> tools/testing/selftests/nolibc/nolibc-test.c:12:
>     nolibc/sysroot/riscv/include/linux/time.h:16:8: note: originally=20
> defined here
>        16 | struct timeval {
>
> @Arnd, As you commented in another reply, is it time for us to update
> include/uapi/linux/time.h together and let it provide time64 timeval/i=
timerval
> instead of the old ones? perhaps some libc's are still using them.

It's hard to know if anything is using it until we try. On the other
hand, we also know that anything still relying on it is going to be
increasingly broken on 32-bit architectures over as we get closer to
y2038, so we can just try removing these here to see what happens.

> Or perhaps we can add a switch like __ARCH_WANT_TIME32_SYSCALLS, add a
> __ARCH_WANT_TIME32_STRUCTS and simply bind it with __ARCH_WANT_TIME32_=
SYSCALLS?

I don't like that idea: __ARCH_WANT_TIME32_SYSCALLS tells us that
an architeture still provides those syscalls for compatibility, so
that is architecture specific, but __ARCH_WANT_TIME32_STRUCTS is not
something that is an architecture specific decision at all, it's
only needed for old source code.

> About the above ugly override code, What's your suggestion in v2? ;-)

Can you maybe just remove the "#include <linux/time.h>" from all
include/uapi/ and nolibc headers so it just never gets seen?

Unfortunately I see the header contains a few other definitions,
which might have to get moved out of the way, possibly to
linux/time_types.h.

       Arnd
