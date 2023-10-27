Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386FC7D9908
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 14:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345458AbjJ0Mzn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 08:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjJ0Mzl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 08:55:41 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDC91AC;
        Fri, 27 Oct 2023 05:55:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5A673320091D;
        Fri, 27 Oct 2023 08:55:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 27 Oct 2023 08:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698411335; x=1698497735; bh=gG
        RYM14aZY3Kp3uQ0eXzrYsoJmWuvlpwHRlsj1zrCsk=; b=SrccGR4SPWvnQmG04c
        0ltmWMvgRqf15DwaKzu7jUg2TMf5W/aFR0HIZyppt/FJycxzTY6hMJ8kb6r4tXVI
        75/VJAiFGYRCfZ5mPwh3z1KRCntVjXRevWJsUpb9Oi8osZ4BAsBb0a3kFxz+DIBs
        ssOu9IB2P8ZqKsP+LknrWjHqpor9i1ASZGw41x3MDQrohxjjABYVwW1u3uLexzmv
        GYFFKf7JyIQpvjYqfTe/tfjqk3TuSS7qCqRAPKrfWGPquRPOilDoCwTS3DJFlIQ2
        EZW7qFCKZ+su5++FHtkq7xRuyvbSGEMLHvHDSDi/reGLYP8UbxxRhsNDjdq39FuC
        /yCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698411335; x=1698497735; bh=gGRYM14aZY3Kp
        3uQ0eXzrYsoJmWuvlpwHRlsj1zrCsk=; b=InrHBg1QRue2x60CWmu+3gJ8oG5Tb
        FId0kYouj1tmDdGZA7qlX8VuqTJxQ4d8zM5R7Roxs2ivFnX8i1Gq4kOzjBRVdbkz
        t8fYOIFc/EvAYD9MNyYAp23WRwLXdHLtJqkvmmD0WhUPlAANEIPhxvzyyezESjdT
        Nwfr3JEbYvHlB8K5FzttTUx6bxJSa8/iSxlgT1XvA1w0NgdtroWsSywGoKFdj0Am
        gf7JMVEvaH29N7EJUTN8VIaME+5pOe7KEKV4/MwWwZqVHmCRkMNN3UhVRpruqveh
        31R8jslm11tKJGEre7OLLA9MYb8zSKdstRTIntTTSDAaZ55gVgVuM4Sfg==
X-ME-Sender: <xms:RrM7ZbNk6IQ1omsX9bdDz4a6D4iOfUrRqXNAz32XyIonf4s6ojT2jA>
    <xme:RrM7ZV_OZbiUNYZ_ywV0KAi6pZhHbGxGr0XbHRpOwYzBhTMkg0iBvyY3RrTMfa_97
    NDQbFYUCYgcTJuf10M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:RrM7ZaSQtpOaKGv366OoOGiOnORcaNg2nAu1mbaPmSoJiHMV4amt_g>
    <xmx:RrM7ZftZwr7DxzUzUZ4-wfSimbbO2xW_LrIwYCEREFZAR4yq_54DLQ>
    <xmx:RrM7ZTeWP6-d_W2YkRsE2ETMDZVVNSUPh2KRev97mNTAo5FPy3pagg>
    <xmx:R7M7ZeB8o6VF8jcQePrk-Pexo0o4wWDBK37kAkPRUTXawEhiLiQhPA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9C1BFB60089; Fri, 27 Oct 2023 08:55:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <8f86f22a-e182-4ddf-b533-b4ae8b088dd4@app.fastmail.com>
In-Reply-To: <CA+G9fYt6pY+tMZEOg=SoEywQOe19fGP3uR15SGowkdK+_X85Cg@mail.gmail.com>
References: <CA+G9fYt6pY+tMZEOg=SoEywQOe19fGP3uR15SGowkdK+_X85Cg@mail.gmail.com>
Date:   Fri, 27 Oct 2023 14:55:14 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        "open list" <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org
Cc:     "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Oleg Nesterov" <oleg@redhat.com>, "Dave Jones" <davej@redhat.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Paul McKenney" <paulmck@linux.vnet.ibm.com>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Sasha Levin" <sasha.levin@oracle.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Dan Carpenter" <dan.carpenter@linaro.org>,
        "Ajay Kaher" <akaher@vmware.com>
Subject: Re: selftests: ftrace: RIP: 0010:__lock_acquire
 (kernel/locking/lockdep.c:5005)
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 27, 2023, at 13:47, Naresh Kamboju wrote:
> Following kernel crash noticed on x86_64 while running selftests ftracetests
> running 6.6.0-rc7-next-20231026.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

My guess would be that this is caused by 5790b1fb3d67 ("eventfs:
Remove eventfs_file and just use eventfs_inode"), in which
Steven Rostedt recently added the create_dir_dentry() function
through a rewrite:


> log:
> -----
> # ok 44 ftrace - test for function traceon/off triggers
> # ok 45 ftrace - test tracing error log support
> # ok 46 Test creation and deletion of trace instances while setting an event
> [ 1402.419605] BUG: kernel NULL pointer dereference, address: 0000000000000097
> [ 1402.426574] #PF: supervisor read access in kernel mode
...
> [ 1402.581170] ? exc_page_fault (arch/x86/include/asm/irqflags.h:26
> arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127
> arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561)
> [ 1402.585094] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570)
> [ 1402.589283] ? __lock_acquire (kernel/locking/lockdep.c:5005)
> [ 1402.593296] ? lock_acquire (kernel/locking/lockdep.c:467
> (discriminator 4) kernel/locking/lockdep.c:5755 (discriminator 4)
> kernel/locking/lockdep.c:5718 (discriminator 4))

The lock passed to spin_lock() and lock_acquire() is a NULL
pointer.

> [ 1402.597045] ? create_dir_dentry.part.0
> (fs/tracefs/event_inode.c:357 (discriminator 1))
> [ 1402.601928] lock_acquire (kernel/locking/lockdep.c:467
> (discriminator 4) kernel/locking/lockdep.c:5755 (discriminator 4)
> kernel/locking/lockdep.c:5718 (discriminator 4))
> [ 1402.605503] ? d_invalidate (fs/dcache.c:1725 (discriminator 1))


This lock is part of the dentry passed to d_invalidate()

> [ 1402.609170] ? lock_release (kernel/locking/lockdep.c:5429
> kernel/locking/lockdep.c:5773)
> [ 1402.612923] ? create_dir_dentry.part.0 (fs/tracefs/event_inode.c:387)
> [ 1402.617803] _raw_spin_lock (include/linux/spinlock_api_smp.h:134
> kernel/locking/spinlock.c:154)
> [ 1402.621467] ? d_invalidate (fs/dcache.c:1725 (discriminator 1))
> [ 1402.625126] d_invalidate (fs/dcache.c:1725 (discriminator 1))
> [ 1402.628619] create_dir_dentry.part.0 (fs/tracefs/event_inode.c:390)

Which is called by create_dir_dentry(). I don't see a bug
in that function, but maybe Steve has an idea.

    Arnd
