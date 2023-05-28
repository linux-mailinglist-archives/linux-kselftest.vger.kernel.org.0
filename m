Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800FF713917
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 May 2023 12:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjE1K4W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 May 2023 06:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1K4T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 May 2023 06:56:19 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4238BA4;
        Sun, 28 May 2023 03:56:12 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 517163200094;
        Sun, 28 May 2023 06:56:08 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 28 May 2023 06:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1685271367; x=1685357767; bh=1x
        43zMiuvtYxd7dVtv6VinrR59ld5ADzgde8ibsMU+U=; b=eL8OT1LOKiZn+jz23Z
        keOq+NyHaFzxihqmBPQ8ZT9VLgimNw2IwwXx2IDfchHBxumm9IA3yx+QR2SSwF94
        PzifSYBG1XP+orpS72ibCrwry2IyRxwK2bqfDrCM1ZdbwOTdqkRkw4w/3Im49mBV
        c6HWx0yE2JmXucxadsTHspWEdXxmMD1DA/Ekv865ZOyKasK0uBdb9+WyiMcJrrB+
        TWSVsE8lGBTdUb5njIb+GnFau1l1AKjakgl9vJVIEVpzYAomaEOXyw8qH1P4fO5f
        4y1YbeHrg+M8EIL7w1JF+8teKf8+/AQmiesBDltMMAL+MwXNwUgl+PIXl4MAeXjA
        d9WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685271367; x=1685357767; bh=1x43zMiuvtYxd
        7dVtv6VinrR59ld5ADzgde8ibsMU+U=; b=BlJsWmQ6VCi+oO8Nt0A5GqYUOn2m/
        7Wn029Riq4eSe8dq9jsAoIZ5vWmZWQtYtUPIkUHnk/FRPTr89AULQeFcW+JeSy6m
        l3Nq0oi+mmV97C1uxYrta5ZORz+40UcrmS5Lhyu/ksiawsXOrwcsW0n9H+BBbHhJ
        udvm1vtlpp0wpaaQ3I3xDgmgm6ZDFdfvBBpTI9bTShyq70AzdnWCGl1w8fJqjZZs
        kZWoqbzF4j7neObEeu8CIhEkU0YB2WdzEPzHtwR62LhU+4BaystGTbXk+SknfQqM
        8f5ZxX59OX32yKbj3e5PRKQwUBR2vljvB9akV6RYoFJlDqP/XjwDK5XGg==
X-ME-Sender: <xms:RzNzZNx4jc6vxcKupl6y2zBXdumsPO4TCwn9EhwNnScxCZLUE0Ku9Q>
    <xme:RzNzZNQ5mIffFQ39bwjOdZPk_fp17f0VPbhaGRW6N4fvrQ_F-j6uZ7kEti4rHAEOR
    p7xFM3CNNPULsup8VA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekfedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:RzNzZHVvlZ5yy2u7rw9Zq9TDDKyCVZxcfVQZdMsMNGHetlNs24m64w>
    <xmx:RzNzZPj-gkJfl5h78PrtjokyHer-OUfFFJhN6YXCQIm0p6Bhltx7uA>
    <xmx:RzNzZPAjvVtDj9GW7xUEprNMps5x5kk9CmV0ZVLgbZxQTyf5qmoehA>
    <xmx:RzNzZK6-EyqdUznrrQQppKdrMRc5fNRwv4mJJgym853lBCmmO3KGbw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 46218B60086; Sun, 28 May 2023 06:56:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <afc4944f-9494-4367-906d-06ac47648ab7@app.fastmail.com>
In-Reply-To: <20230528102947.GH1956@1wt.eu>
References: <83ab9f47-e1ed-463c-a717-26aad6bf2b71@app.fastmail.com>
 <20230528082509.293250-1-falcon@tinylab.org> <20230528102947.GH1956@1wt.eu>
Date:   Sun, 28 May 2023 12:55:47 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Willy Tarreau" <w@1wt.eu>, "Zhangjin Wu" <falcon@tinylab.org>
Cc:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>
Subject: Re: [PATCH 09/13] tools/nolibc: sys_poll: riscv: use __NR_ppoll_time64 for
 rv32
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, May 28, 2023, at 12:29, Willy Tarreau wrote:
> On Sun, May 28, 2023 at 04:25:09PM +0800, Zhangjin Wu wrote:
>> 
>> * Use __kernel_timespec as timespec
>> * Use 64bit time_t based struct timeval
>>     * Disable gettimeofday syscall completely for 32bit platforms
>>         * And disable the gettimeofday_bad1/2 test case too
>
> When you say "disable", you mean "remap", right ? Or do you mean
> "break in 2023 code that was expected to break only in 2038 after

clock_gettime() has been supported for a very long time, so both
time() and gettimeofday() can be trivial wrappers around that.

Nothing really should be using the timezone argument, so I'd
just ignore that in nolibc. (it's a little trickier for /sbin/init
setting the initial timezone, but I hope we can ignore that here).

clock_gettime() as a function call that takes a timespec argument
in turn should be a wrapper around either sys_clock_gettime64 (on
32-bit architectures) or sys_clock_gettime_old() (on 64-bit
architectures, or as a fallback on old 32-bit kernels after
clock_gettime64 fails).

On normal libc implementations, the low-level
sys_clock_gettime64() and sys_clock_gettime_old(), whatever
they are named, would call vdso first and then fall back
to the syscall, but I don't think that's necessary for nolibc.

I'd define them the same as the kernel, with
sys_clock_gettime64() taking a __kernel_timespec, and
sys_clock_gettime_old() takeing a __kernel_old_timespec.

    Arnd
