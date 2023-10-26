Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59157D89C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 22:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjJZUko (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 16:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjJZUkn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 16:40:43 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881191AC
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Oct 2023 13:40:39 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3ae5a014d78so1225282b6e.1
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Oct 2023 13:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698352839; x=1698957639; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q9VGZryxohWoLkcssXCQeH8twZ55IAA507WLGCAYAaE=;
        b=iTmjDJ5GoUNt/kokTUjonvJDn31eaTPqWFpdZVJXkEbAVmY+DxoZVbQWzH2YjFkz9n
         hvCBMCuG7hr/9h66PWJL8Lks3kgH+fM7kH0emJ5AT75iJmkJVnqjCTDJOljtYJ1rqgRr
         yITJCAiZDP6JzT/H6Bvg7/V2ypcV5c8TAO7XraoH+YBIdL7LW55cYG2l2zwTIv1fA5GC
         dKeh4ISRGIt10dHYecFU7H4my8I9WtK14tTClqhhurWqg5+IKF1P6DD9Dwn+bbI52SQo
         jz3Lqc6yhe1CEQ+BS/SxHpfdRMPVW4LqEDZPAxCYJsasqNNmfaXCGPPuGqSsNE/yc7zY
         Lp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698352839; x=1698957639;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q9VGZryxohWoLkcssXCQeH8twZ55IAA507WLGCAYAaE=;
        b=EM2VPmWtiztL+QTfbUXnufJdNTu8wh8Icqb5nDiiE2tNhecCN5dWjwOaBHPymNrTV5
         WZ1NwxoRYQPOcen+GEJLEUXrv7e9BQOgQjYcFo9e4wArMJxM0WKIO1iQNNb1kHW3zv3k
         iAj3Qi6RkOEC08i1YFR7TIUJFLuQOUpPv0dSFfkM8UGYnVGjFayM/InN8ga4qEETNb0p
         k2fow4fVJx7FFfIWJ6j2YU3JXuBzhkPGArAZmCjiSt2u+yaw7axIOXPE6z+7UbP5alX6
         lMPyScClxWr2NpgajZpymV02aE8wiTaMcWo3Mltw8wRPi7S65gzqSTxvJJEvmrEhL9WH
         34wA==
X-Gm-Message-State: AOJu0Yx1HTfnvAVIBz+yF+XkmaqDhk24msQDqjC/T+xsfKHNzU/G1ArT
        Yw50Hs7O7O4CQkTBYmYvmJ9zKg==
X-Google-Smtp-Source: AGHT+IGCTBZtkCCqu5afIx/QC6bIDygKrlkNFZqpmqwK9+dCMi0WvVZgjm1UujEAwrNrPBouPD8Pfg==
X-Received: by 2002:a05:6808:338f:b0:3aa:1306:96e8 with SMTP id ce15-20020a056808338f00b003aa130696e8mr2012202oib.1.1698352838725;
        Thu, 26 Oct 2023 13:40:38 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id y25-20020a056808061900b003b2f369a932sm19865oih.49.2023.10.26.13.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 13:40:38 -0700 (PDT)
Date:   Thu, 26 Oct 2023 13:40:35 -0700
From:   Deepak Gupta <debug@rivosinc.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jannh@google.com" <jannh@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "bsegall@google.com" <bsegall@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFC RFT 2/5] fork: Add shadow stack support to clone3()
Message-ID: <ZTrOw97NFjUpANMg@debug.ba.rivosinc.com>
References: <20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org>
 <20231023-clone3-shadow-stack-v1-2-d867d0b5d4d0@kernel.org>
 <dc9a3dd544bbf859142c5582011a924b1c1bf6ed.camel@intel.com>
 <8b0c9332-ba56-4259-a71f-9789d28391f1@sirena.org.uk>
 <2ec0be71ade109873445a95f3f3c107711bb0943.camel@intel.com>
 <807a8142-7a8e-4563-9859-8e928156d7e5@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <807a8142-7a8e-4563-9859-8e928156d7e5@sirena.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 26, 2023 at 06:53:37PM +0100, Mark Brown wrote:
>On Thu, Oct 26, 2023 at 05:10:47PM +0000, Edgecombe, Rick P wrote:
>> On Mon, 2023-10-23 at 19:32 +0100, Mark Brown wrote:
>
>> > Right.  We're already adding the cost of the extra map_shadow_stack()
>> > so
>> > it doesn't seem that out of scope.  We could also allow clone3() to
>> > be
>> > used for allocation, potentially removing the ability to specify the
>> > address entirely and only specifying the size.  I did consider that
>> > option but it felt awkward in the API, though equally the whole
>> > shadow
>> > stack allocation thing is a bit that way.  That would avoid concerns
>> > about placing and validating tokens entirely but gives less control
>> > to
>> > userspace.
>
>> There is also cost in the form of extra complexity. Not to throw FUD,
>> but GUP has been the source of thorny problems. And here we would be
>> doing it around security races. We're probably helped that shadow stack
>> is only private/anonymous memory, so maybe it's enough of a normal case
>> to not worry about it.
>
>> Still, there is some extra complexity, and I'm not sure if we really
>> need it. The justification seems to mostly be that it's not as flexible
>> as normal stacks with clone3.
>
>I definitely agree on the complexity, trying to valdiate a token is
>going to be more code doing fiddly things and there's always the risk
>that something will change around it and invalidate assumptions the code
>makes.  Particularly given my inability to test x86 I'm certainly way
>more happy pushing this series forward implementing size only than I am
>doing token validation.
>

FWIW, from arch specific perspective, RISC-V shadow stack extension has
`ssamoswap` to perform this token exchange. But I understand x86 has this
limitation (not sure about arm GCS).

 From security perspective:--
Someone having ability to execute clone3 with control on input, probably
already achieved some level of control flow bending because they need to
corrupt memory and then carefully control registers input to clone3.
Although if it is purely a data oriented gadget, I think it is possible.

Since this RFC is mostly concerned about `size` of shadow stack. I think
we should limit it to size only.

>> I don't understand why doing size-only is awkward. Just because it
>> doesn't match the regular stack clone3 semantics?
>
>Basically, yes - we don't allocate userpace pages in clone3() for the
>normal stack and we do offer userspace control over where to place
>things.  There was some grumbling about this in the current ABI from the
>arm64 side, though the limited control of the size is more of the issue
>really.
>
>I'm not sure placement control is essential but the other bit of it is
>the freeing of the shadow stack, especially if userspace is doing stack
>switches the current behaviour where we free the stack when the thread
>is exiting doesn't feel great exactly.  It's mainly an issue for
>programs that pivot stacks which isn't the common case but it is a
>general sharp edge.

In general, I am assuming such placement requirements emanate because
regular stack holds data (local args, etc) as well and thus software may
make assumptions about how stack frame is prepared and may worry about
layout and such. In case of shadow stack, it can only hold return
addresses and tokens (created by user mode itself). Both of them endup
there as result of call or user sw own way of setting up tokens.

So I don't see a need for software to specify address.

>
>> > This also doesn't do anything to stop anyone trying to allocate sub
>> > page
>> > shadow stacks if they're trying to save memory with all the lack of
>> > overrun protection that implies, though that seems to me to be much
>> > more
>> > of a deliberate decision that people might make, a token would
>> > prevent
>> > that too unless write access to the shadow stack is enabled.
>
>> Sorry, I'm not following. Sub-page shadow stacks?
>
>If someone decides to allocate a page of shadow stack then point thread
>A at the first half of the page and thread B at the second half of the
>page nothing would stop them.  There are obvious issues with this but I
>can see someone trying to do it in a system that creates lots of
>threads and has memory constraints.
>
>> > > > +               /*
>> > > > +                * This doesn't validate that the addresses are
>> > > > mapped
>> > > > +                * VM_SHADOW_STACK, just that they're mapped at
>> > > > all.
>> > > > +                */
>
>> > > It just checks the range, right?
>
>> > Yes, same check as for the normal stack.
>
>> What looked wrong is that the comment says that it checks if the
>> addresses are mapped, but the code just does access_ok(). It's a minor
>> thing in any case.
>
>Oh, I see, yes.


