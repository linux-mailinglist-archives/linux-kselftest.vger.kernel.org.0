Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47ED706BA4
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 16:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjEQOw3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 10:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjEQOw3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 10:52:29 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1434E19B0;
        Wed, 17 May 2023 07:52:28 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 08E9E3200903;
        Wed, 17 May 2023 10:52:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 17 May 2023 10:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1684335144; x=1684421544; bh=5mas8wApaiArBzc/k2qYZpcPuHFX2rPvIJz
        00K7T8oE=; b=PgX23426o57WwtsjjYljjBuol/IGj/CdwDxYdVlzVn9DGm1wDMv
        2FycDR3if/94TiLb5t1Sgx5wgRwymx1kDyNIwk42/KtXRE8cVroHeWsgAD7udiIQ
        lgw15YyHjlw6cKboUDmX2B1BGrMyHuKGFtiHdt3MvWYZYTx0y51flCEMGqwb8oOS
        MDnNcvNC5dTNFZZfjgtys4wAotOWdl5aYw1QNDn9N/EY+a3j4FgO17JnmwNzwyLW
        +L1RWjgOGzhOPrZbZBhgqgdOKvnd6ooChaSPW1J2BgIsil9IBQl3xkgEMrGVh+g1
        nSWTQV1EHEbBLvFTg/YnzpTPVw0G7mO1DaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684335144; x=1684421544; bh=5mas8wApaiArBzc/k2qYZpcPuHFX2rPvIJz
        00K7T8oE=; b=xFz/jAwV3qJ5yapPW/ZMpohG53y24e2YAUcXPuy6+uQd5ShtE1S
        nbNkfhIECkF4nDilsZdooexk1mf11q39LZVWpdl6P52J/kzZsoB2N0SFf8gocyGD
        DMtBEVRH+WgNUlJPkRfXnJGbmi99k5CknZw2t4g1UhJg3NsLgE5zB0Q9C55B/0F4
        JNDlIYNtMogx+WHJANRHNZRztj1wLJJ2IpebT0ltPcIwhY34S42Pgq6Z5ZbvkDPD
        WJTl1ujvi6Ata9f6/+6uuox7hxfXhVkCc+wDEet+vGxY07P0aV10Ih5tLNtm0ji8
        0k7xvpekdrytg0TcK5ykd3p8oZ1pS3qsf8g==
X-ME-Sender: <xms:JupkZHJXUwAnZPNa3E8RuTbb2CNWsCwq_Z5tikjt7ADc18n-mdUfzQ>
    <xme:JupkZLLDGsX9lwAFQBl3acQpMglzqnsfJXPOSxDYTRNJifjsUqnnrrooI49gkDc3o
    kJ1JoyxhrDHMXiN7qU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:JupkZPuWr7PbkG8y0OQs8W5jkT7165Fs-hGwQ1dSVjNGZJuoctIlOg>
    <xmx:JupkZAY3sGGDQXi7i1jIpaf7oriSryY6KsNIDvNuiwje_IZhC_FwBQ>
    <xmx:JupkZOaVQhNp_7gXeWPUGsIHD_hREdvTHdUUFKKteLVNN_aws7nsAg>
    <xmx:KOpkZC4wS1szrrY0RrweYZ6FC1I75qf26i68Ll0F1kXm2bXHzRy53Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EB947B60086; Wed, 17 May 2023 10:52:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <6b7f6f66-7890-47a3-a22d-e29f2944823a@app.fastmail.com>
In-Reply-To: <CAJZ5v0h0spuxK-7LBJSU9BK2TEOUeMjf7hhKScadkxFN_RwStQ@mail.gmail.com>
References: <20230517131102.934196-1-arnd@kernel.org>
 <20230517131102.934196-11-arnd@kernel.org>
 <CAJZ5v0h0spuxK-7LBJSU9BK2TEOUeMjf7hhKScadkxFN_RwStQ@mail.gmail.com>
Date:   Wed, 17 May 2023 16:52:01 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Russell King" <linux@armlinux.org.uk>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, "Michal Simek" <monstr@monstr.eu>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Helge Deller" <deller@gmx.de>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, x86@kernel.org,
        "Paul Moore" <paul@paul-moore.com>,
        "Eric Paris" <eparis@redhat.com>,
        "Dennis Zhou" <dennis@kernel.org>, "Tejun Heo" <tj@kernel.org>,
        "Christoph Lameter" <cl@linux.com>, "Pavel Machek" <pavel@ucw.cz>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Waiman Long" <longman@redhat.com>,
        "Boqun Feng" <boqun.feng@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        audit@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 10/14] suspend: add a arch_resume_nosmt() prototype
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

On Wed, May 17, 2023, at 15:48, Rafael J. Wysocki wrote:
> On Wed, May 17, 2023 at 3:12=E2=80=AFPM Arnd Bergmann <arnd@kernel.org=
> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The arch_resume_nosmt() has a __weak definition, plus an x86
>> specific override, but no prototype that ensures the two have
>> the same arguments. This causes a W=3D1 warning:
>>
>> arch/x86/power/hibernate.c:189:5: error: no previous prototype for 'a=
rch_resume_nosmt' [-Werror=3Dmissing-prototypes]
>>
>> Add the prototype in linux/suspend.h, which is included in
>> both places.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Do you want me to pick this up?

Yes, please do. Thanks,

     Arnd
