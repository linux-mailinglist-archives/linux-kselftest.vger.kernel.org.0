Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0272C712552
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 13:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243009AbjEZLNd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 07:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbjEZLNc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 07:13:32 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14020101;
        Fri, 26 May 2023 04:13:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B087C5C02A5;
        Fri, 26 May 2023 07:13:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 26 May 2023 07:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1685099607; x=1685186007; bh=+1
        8KTealJLeomxP83iUYPUtTDn9OVxN2b+ZOdMcxvhk=; b=nnjCAIoLe7xGWK1YuI
        Xang8XbZjzLFWCpoWixBEa3RX0P4a8BOHaxOC/EL5zq5BnHvgKnL66zyrEmNkImr
        TFSAHbFTGY7MlB+ACRAzLM5Izbgiec24cJ/t7008U5TB+YNsd/eHksWl4gLh+Swn
        h5QJofJowBPPuHzj/0A8D5NsasOKT4KsczDAPbYGi3UETp8z82gt4C2muNvyNCFJ
        Z7Zk5UJS6fi9qxDg3MF8nyxmDi7YHEmKPxSd3ifcorwAFSVkIrq98jgB+RQBGCrI
        pCMfA1CkVL4Takj7tx6g3btUl+NGS9LxNKYUwKQa64bmznE8zFz6C3v3VDFIFUlC
        hXyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685099607; x=1685186007; bh=+18KTealJLeom
        xP83iUYPUtTDn9OVxN2b+ZOdMcxvhk=; b=aAb2jxFdPzrHMAOwME7yp/30F6SbL
        w4YY0CjNjVVv9a4Y/JY5Dx9TAdIN4IhD+MAwIhkS2eHI2PbZPhjXsEQUPFTC+QtN
        pbvbiGDztsZDAoApSVR4fKt6z2w2g52qhi+QLA1NA9XmTnAFzy5MdXzstgGKkHs3
        4BYAR63r8O24yvBFgblgBXZJo3eM0LKcdJ3zOKzjlvYycl6zEDfQrDH/P5g6+ruF
        zy/pSJWhtPFBDkJlH2a9lZ1DRlJT7KcELfgdVad64KKOGq0izJ5624A/Oy/BKwXR
        LlRlQoCGJbi4YpbRyaDEJ9Ph7g3NDOOoXlTrQ2uTMz9w9bOTP8JjOwjyw==
X-ME-Sender: <xms:VpRwZC2S5KTaQ62euVeI2Iru8fFItByL29XmCKDP05HUzWhXkR1Zmg>
    <xme:VpRwZFHHGKAP-gr9K7MB1jAoQqWnkUGBw7faEd3c2xc1m24pcE9yabMJyu_RLNU2i
    Cl4cHWJWLE6tC9QDoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejledgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:VpRwZK77q2EPZn_tpVGMTPK0ZF1abrg4sPQI14SPqlAY7T33KKmLyA>
    <xmx:VpRwZD3po0ckUAFEljiBunNdbxxx_5Y5wp5rcqwnS-4EhIDXMw3IhQ>
    <xmx:VpRwZFHh1uqiEnpbQB6NVP-p4sopCFl-MGm0J6E9Yi7JilqPM7MIDg>
    <xmx:V5RwZOOl0DpxATfFluZzxCG7I7quRudGHZ059zQbm8IRZflp_WT9Kw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 069CCB60089; Fri, 26 May 2023 07:13:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <70cf0d8f-ea8e-43b6-9b99-739562ea865d@app.fastmail.com>
In-Reply-To: <20230526110001.150368-1-falcon@tinylab.org>
References: <bf3e07c1-75f5-425b-9124-f3f2b230e63a@app.fastmail.com>
 <20230526110001.150368-1-falcon@tinylab.org>
Date:   Fri, 26 May 2023 13:13:05 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Zhangjin Wu" <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        "Willy Tarreau" <w@1wt.eu>
Subject: Re: [PATCH 00/13] tools/nolibc: riscv: Add full rv32 support
Content-Type: text/plain
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SORTED_RECIPS,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 26, 2023, at 13:00, Zhangjin Wu wrote:
>> On Wed, May 24, 2023, at 19:59, Zhangjin Wu wrote:
>> > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
>
> I have applied this method for ppoll_time64 and clock_gettime64 too,
> this method can save several duplicated lines for us, I have prepared v2
> patches locally for them. 

Ok, that addresses my concern about the possible bugs.

>> I would just use __kernel_timespec64 unconditionally and then
>> use __NR_pselect6_time64 on all 32-bit architectures here,
>> but use __NR_pselect6 on 32-bit architectures.
>>
>
> The 2nd 32-bit you mean is 64-bit?

Yes, sorry for the typo.

> This is related to the timespec64/time64_t definitions as you commented
> in another reply. I will learn how to use the one from
> <linux/time_types.h>, it may require to clean up the existing files in
> tools/include/nolibc/ at first.

Ok, thanks.

>> I think we can also kill off the oldselect and newselect 
>> cases, using pselect6/pselect6_time64 unconditionally here,
>> and no longer care about building against pre-5.1 kernel
>> headers, at least for the copy of nolibc that ships with the
>> kernel.
>
> As Willy commented in another reply, users may want to copy the recent
> one and use them with an old kernel, even if want to drop them, a
> standalone patch may be preferable.

Fair enough. I checked the old versions and see that 5.1 in May 2019
was the first one to include the time64 system call definitions, though
5.6 from March 2020 was the first version that I consider fully working
with time64.

I don't know how common it is to copy nolibc into other projects,
but requiring a three year old kernel might be a little too aggressive
here. They could copy from 6.1-stable to keep the fallback (and miss
rv32) if we do this, but a better cutoff may be Dec 2025 when
linux-5.4 has its "projected EOL" date and one last LTS with the
fallback (linux-6.16 or so) gets released.

      Arnd
