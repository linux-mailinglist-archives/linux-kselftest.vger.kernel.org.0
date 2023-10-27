Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003CC7DA410
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Oct 2023 01:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346633AbjJ0XY1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 19:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJ0XY0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 19:24:26 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1311BD
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Oct 2023 16:24:22 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b2f4a5ccebso1670370b6e.3
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Oct 2023 16:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698449062; x=1699053862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2GtWOmDm2DZyVdf43Y6zUW3QwX9tZvbKVx3zn9eClIU=;
        b=dFfBhWoAfkYspAeKLN/WHyQm1h9wxF5ua3i2/K4XyWfPfITPZBkicxp15Eu62EWoqq
         0caL+xZSzUHLs+X9MImT7JaNHcVB0azPj6m3xdNNtYhmqSWe5wCGGS0JOtTyCbd8vQSL
         S9GF5NHqM0/qyJMVbdY87vRwrawcO2VnkwRZ7lEOiGzEnZ55noC0YAuSOb53U6dPHrsl
         kdvl+XoN+lF3bfFZXeRuqE3ha2NbQF4WemnQFM/wyaAjGKymaVUpH3jKXY2Ch1twpXFD
         lYnn6CgibYJ+YYeYpg9Qc1KFNd1UYGskVmJ3vSbDF6c8S/GPLlBrqZR2D4J2Yk2YhqwL
         zE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698449062; x=1699053862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GtWOmDm2DZyVdf43Y6zUW3QwX9tZvbKVx3zn9eClIU=;
        b=JRql5gC1I6x5gUUTj2OdyfccY3wTSEVpcSPafq4coRhnrPsYdUArrk7sg+TDixQq05
         cSLozHXb8K4zryszBWbh+JohO3G0lg6dg7ZTkLeS42JmBh5kTzkxktnh6MatVrshsKVu
         iSseZYB1UK8c4dgFg5uuRbvgetE/9NtiGNCMxVhvBQ07zBg3JVnfz7C04X82Tpzu92xk
         DzOks+v+PBRy8nBSWogGWbemBZAecJt9xLmc4dNO8KopzXWW9gLZgauH+iWZfjHz7TGE
         f9qz10VgYTozweRjZomeXo5NN7ufuAbqhXYpYtaxMLzrJfd6dbXHD/hl7cU6FeF8tk4c
         cW6g==
X-Gm-Message-State: AOJu0YwVDUN2zEaAJbeWk4k6TIhURlozJpVe+XtcEek4PIAa2jN7/De3
        0l79qRCy+1jsNiA8+VrNoqRLaQ==
X-Google-Smtp-Source: AGHT+IFMyRSJAPNgriqDeeQrdkYIrXs02lA19ewIsskrs6McU9uDM2J+60eUBgzLzs/rD9gBsdq/oA==
X-Received: by 2002:a05:6808:1141:b0:3b2:ec06:7061 with SMTP id u1-20020a056808114100b003b2ec067061mr5059285oiu.14.1698449062187;
        Fri, 27 Oct 2023 16:24:22 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id bp2-20020a056808238200b003af638fd8e4sm476791oib.55.2023.10.27.16.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 16:24:21 -0700 (PDT)
Date:   Fri, 27 Oct 2023 16:24:18 -0700
From:   Deepak Gupta <debug@rivosinc.com>
To:     "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
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
Message-ID: <ZTxGovqKdhA5hYMz@debug.ba.rivosinc.com>
References: <20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org>
 <20231023-clone3-shadow-stack-v1-2-d867d0b5d4d0@kernel.org>
 <dc9a3dd544bbf859142c5582011a924b1c1bf6ed.camel@intel.com>
 <8b0c9332-ba56-4259-a71f-9789d28391f1@sirena.org.uk>
 <2ec0be71ade109873445a95f3f3c107711bb0943.camel@intel.com>
 <807a8142-7a8e-4563-9859-8e928156d7e5@sirena.org.uk>
 <ZTrOw97NFjUpANMg@debug.ba.rivosinc.com>
 <ZTuj565SqIb9KjQr@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZTuj565SqIb9KjQr@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 27, 2023 at 12:49:59PM +0100, Szabolcs.Nagy@arm.com wrote:
>The 10/26/2023 13:40, Deepak Gupta wrote:
>> On Thu, Oct 26, 2023 at 06:53:37PM +0100, Mark Brown wrote:
>> > I'm not sure placement control is essential but the other bit of it is
>> > the freeing of the shadow stack, especially if userspace is doing stack
>> > switches the current behaviour where we free the stack when the thread
>> > is exiting doesn't feel great exactly.  It's mainly an issue for
>> > programs that pivot stacks which isn't the common case but it is a
>> > general sharp edge.
>>
>> In general, I am assuming such placement requirements emanate because
>> regular stack holds data (local args, etc) as well and thus software may
>> make assumptions about how stack frame is prepared and may worry about
>> layout and such. In case of shadow stack, it can only hold return
>
>no. the lifetime is the issue: a stack in principle can outlive
>a thread and resumed even after the original thread exited.
>for that to work the shadow stack has to outlive the thread too.
>

I understand an application can pre-allocate a pool of stack and re-use
them whenever it's spawning new threads using clone3 system call.

However, once a new thread has been spawned how can it resume?
By resume I mean consume the callstack context from an earlier thread.
Or you meant something else by `resume` here?

Can you give an example of such an application or runtime where a newly
created thread consumes callstack context created by going away thread?

>(or the other way around: a stack can be freed before the thread
>exits, if the thread pivots away from that stack.)

This is simply a thread saying that I am moving to a different stack.
Again, interested in learning why would a thread do that. If I've to
speculate on reasons, I could think of user runtime managing it's own
pool of worker items (some people call them green threads) or current
stack became too small.

JIT runtimes (and such stuff like go routines) do such things but in
those cases, kernel has no idea about it. From kernel's perspective
there is a main thread stack (hosting thread for JIT) and then main
thread can take a decision switching stack to execute JITted code.
But in that case all it needs is a shadow stack and managing lifetime of
such shadow stack using `clone` wouldn't be helpful and perhaps
`map_shadow_stack` should be used to create on the fly shadow stack.

Another case I can think of for a thread to move to a different stack
when current stack was too small and it wants larger memory. In such
cases as well, I imagine that particular thread would be issuing `mmap`
to allocate larger memory and thus that particular thread can very well
issue `map_shadow_stack`

In both of these cases, a stack free actually means thread (application)
issuing a system call to free the going away stack memory. It can free up
going away shadow stack memory in same way using `unmap_shadow_stack`

Let me know if I misunderstood something or missing some other usecase of
a stack being freed before the thread exits.

>
>posix threads etc. don't allow this, but the linux syscall abi
>(clone) does allow it.
>
>i think it is reasonable to tie the shadow stack lifetime to the
>thread lifetime, but this clearly introduces a limitation on how
>the clone api can be used. such constraint on the userspace
>programming model is normally a bad decision, but given that most
>software (including all posix conforming code) is not affected,
>i think it is acceptable for an opt-in feature like shadow stack.
>
>IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
