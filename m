Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C796D7123C5
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 11:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242777AbjEZJgC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 05:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243450AbjEZJf3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 05:35:29 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADDD1A4;
        Fri, 26 May 2023 02:35:11 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C87AF5C02A7;
        Fri, 26 May 2023 05:35:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 26 May 2023 05:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1685093710; x=1685180110; bh=VQuY/hL2S/RS8GNDFwVDAwplsazM8ODjSL8
        HxOJd4/M=; b=nwK6/l/Qae+SBdLMMpC8B/2CiUB+2CFgiCiftBPiwUx1JwLIBhI
        2Zx1jckJ3DX8WZWAh8rhOwF5ufG1TFkxNHAFtHJBI45m4b2jUp9TMb7GvUmedRq9
        RYRUUkLm2hK5qadBAGJUZf+H/n5tD0HT7/Gdoy5CkK9kguBQlk4IzX7ZwMCed4ZW
        Y9MeJQ/eEpSK+paOQl4XrrN6cdBwrUmsF5OjnEYsGSpHKlvTKO5lbhUYww2u9QY/
        xN7psVe7Vd6wiK6hMpntz85UqmLcHdDxoibcgvnLkC2NanKn9oOnRmeNX8IuPTVq
        6rV6eMoORCWGKxlv5Y6jWDxZMLzMSvgRDRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685093710; x=1685180110; bh=VQuY/hL2S/RS8GNDFwVDAwplsazM8ODjSL8
        HxOJd4/M=; b=lJ+afdWVNY+5p1btQimqvgioXqVzsADLAjA8v/L0UM8MgNRC2AN
        dUAxU5T3Vu4pR4tVzWC4JGhjPF2D6vYIEoxnXoVwnFfm0WV/QftbQfD7oXIklg4S
        cPMu2dgkiriEq3qQXTmvoaC09McuCpVmZ7plxdbonHSXcxQa5oo+2L5koof/Tbqv
        /TK8yMfBCdo/eMpK3CFCSyFeCGfH7IHTvnDvSYVUEmuGhQREhV9gGOuD7m5kkwRz
        OPhq0FKBj5lfzfUH+5z8Y6vzwbvsS26Zr2BGb6tUhMY9DfZlkxSf73BfIH7kVQiI
        VVCQeSEELgJwFKJzd3BgIadGNQFX9s13lSA==
X-ME-Sender: <xms:Tn1wZNQohCUUl8CF-T0qRkqy04FPKUkOhFAa8x8RgUF6MRwUeQ4o9g>
    <xme:Tn1wZGz2WXl0mSB-m5swPxBsFljQznixhkVm4uuBd3EA7hH9nPdiV6FBkRdH_YiBr
    b8gFqhQfRSU3cwQ5PY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Tn1wZC1Mo0kZBNMUjJu8vENwbYYhuFdwHZ1vpnuyIrZTc713OsV8Tw>
    <xmx:Tn1wZFBJV5WggaFPQbzroudAjMF_leGrvSHEZ1BhC9v8zxgeaFOKKA>
    <xmx:Tn1wZGjbCzTt76jRHsb6khFLbw-6tccF6S4G6ux-GmdML5EcrmedvQ>
    <xmx:Tn1wZIZ5XQSy09vmRDbepF54mJ8VLE1u-1JT6mPmPPydzVV7zB7Atg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 89C20B60086; Fri, 26 May 2023 05:35:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <83ab9f47-e1ed-463c-a717-26aad6bf2b71@app.fastmail.com>
In-Reply-To: <78d91061-1bcd-4031-89e1-706c3f49d762@t-8ch.de>
References: <cover.1684949267.git.falcon@tinylab.org>
 <ec5af2ae25264eddce4b50380bfd24f9490eca75.1684949268.git.falcon@tinylab.org>
 <78d91061-1bcd-4031-89e1-706c3f49d762@t-8ch.de>
Date:   Fri, 26 May 2023 11:34:46 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        "Zhangjin Wu" <falcon@tinylab.org>
Cc:     "Willy Tarreau" <w@1wt.eu>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>
Subject: Re: [PATCH 09/13] tools/nolibc: sys_poll: riscv: use __NR_ppoll_time64 for
 rv32
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 26, 2023, at 09:15, Thomas Wei=C3=9Fschuh wrote:
> On 2023-05-25 01:57:24+0800, Zhangjin Wu wrote:
>> rv32 uses the generic include/uapi/asm-generic/unistd.h and it has no

>> =20
>> +/* needed by time64 syscalls */
>> +struct timespec64 {
>> +	time64_t	tv_sec;		/* seconds */
>> +	long		tv_nsec;	/* nanoseconds */
>> +};
>
> A question to you and Willy, as it's also done the same for other type=
s:
>
> What is the advantage of custom definitions over using the one from the
> kernel (maybe via a typedef).
>
> From linux/time_types.h:
>
> struct __kernel_timespec {
> 	__kernel_time64_t tv_set;
> 	long long tv_nsec;
> };

I agree the __kernel_* types are what we should be using when
interacting with system calls directly, that is definitely what
they are intended for.

I would go further here and completely drop support for 32-bit
time_t/off_t and derived types in nolibc. Unfortunately, the
kernel's include/uapi/linux/time.h header still defines the
old types, this is one of the last remnants the time32 syscalls
definitions in the kernel headers, and this already conflicts
with the glibc and musl definitions, so anything that includes
this header is broken on real systems. I think it makes most
sense for nolibc to just use the linux/time_types.h header
instead and use something like

#define timespec   __kernel_timespec
#define itimerspec __kernel_itimerspec
typedef __kernel_time64_t time_t;
/* timeval is only provided for users, not compatible with syscalls */
struct timeval { __kernel_time64_t tv_sec; __s64 tv_nsec; };

so we can drop all the fallbacks for old 32-bit targets. This
also allows running with CONFIG_COMPAT_32BIT_TIME disabled.

     Arnd
