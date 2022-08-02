Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670085884CE
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Aug 2022 01:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbiHBXlm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Aug 2022 19:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiHBXlk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Aug 2022 19:41:40 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B9A51A2C
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Aug 2022 16:41:39 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t22so7129731pjy.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Aug 2022 16:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=iTI6R7KJRLoQz0Ou6npQPtCdRk1U91+pQrT2aXmYFB8=;
        b=Oh9t50zfLcxshPY/AFGfgwtjfzyvMdtWg8eEtOildHv377TPfNSEx5a4qDS+cFTrhx
         Y76eiJJLg/PQ4Q5yIQ7c+0CGejiX6bLs/lrnyErzMKPq4qGCoYy9zaJme1NvO8eZR/tG
         TfA4Q0+tUcbM+tuMAFVY7uAw0pO17bAtiBvNZE0koCICsSAlYun9lOfYNCwm4mw2MAAS
         kgeXIyG1cb25J2Kuftn/qS1T00GEDdCITB5ujQHnp79WgHsQKZ5gYWXcj9lJ2e/0bY6K
         tPD6MGOChvpHuIKtkMjIDlS8pXMStdVfmoMOoK3e5hyVKqfg3GhhYOYIY8OzZ/EvJF/P
         uAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=iTI6R7KJRLoQz0Ou6npQPtCdRk1U91+pQrT2aXmYFB8=;
        b=pLYW3oitMGSOPW1fJcYweXep+tEWZ7K/sOZI2uytXMAaCyW69flvHRrND7rCuy2DNT
         p9xlPYvdbAhHlGgs7VsEQ+Gx15YDunS6AxC/ouIK8XEo3CXvb6JIGVM8Mi+l8EvQaqxS
         RzsuK6KszgEAHqam/KcriQjakF4wObZzRIGrUP86dKWGAfOHQDeHJ0LzQuiNzOlZakkC
         ScwOHaSffRY2RuT/pxSgtLru0KkV21NDOi3/0ZzuuYkcCbNEtmvEfnc6bcd2SlC5We0s
         Dwl4M0q0JHB49XOheFpSNgumYNVMveEfh/miNjh3sXj8W0aA91dGI7dS130rLp/xd4lq
         nL3Q==
X-Gm-Message-State: ACgBeo3/wdo8HpsnMQsPXCOAVogdkqWmjqB80w4TyP2PJUJuvbqzDNEo
        Z3vnlgJ9RhE4MYM/mqhscf0dYw==
X-Google-Smtp-Source: AA6agR4Z47AtYT5XZEOgUPdpd2Nl5IkEKWyGkiFppvyFrhAnLUfrk+dL6GJ7CEKbN1M8HaBhYr9IJg==
X-Received: by 2002:a17:902:d50c:b0:16f:736:33a0 with SMTP id b12-20020a170902d50c00b0016f073633a0mr4854120plg.137.1659483699097;
        Tue, 02 Aug 2022 16:41:39 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u62-20020a627941000000b0052ac12e7596sm1436806pfc.114.2022.08.02.16.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 16:41:38 -0700 (PDT)
Date:   Tue, 2 Aug 2022 23:41:34 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Michal Luczaj <mhal@rbox.co>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH v2] x86: Test illegal LEA handling
Message-ID: <Yum2LpZS9vtCaCBm@google.com>
References: <YuQQiv862oWDpgt5@google.com>
 <20220731204653.2516-1-mhal@rbox.co>
 <YugC4rUvdbroNk3M@google.com>
 <c2001bfa-7602-e99a-dc41-1d9d993581ac@rbox.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2001bfa-7602-e99a-dc41-1d9d993581ac@rbox.co>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 03, 2022, Michal Luczaj wrote:
> On 8/1/22 18:44, Sean Christopherson wrote:
> > On Sun, Jul 31, 2022, Michal Luczaj wrote:
> >> +{
> >> +	exceptions = 0;
> >> +	handle_exception(UD_VECTOR, illegal_lea_handler);
> > 
> > No need to use a custom handler (ignore any patterns in emulator.c that suggest
> > it's "mandatory", emulator is one of the oldest test).  ASM_TRY() can handle all
> > of this without any globals.
> > ...
> > static void test_illegal_lea(void)
> > {
> > 	unsigned int vector;
> > 
> > 	asm volatile (ASM_TRY("1f")
> > 		      KVM_FEP ".byte 0x8d; .byte 0xc0\n\t"
> > 		      "1:"
> > 		      : : : "memory", "eax");
> > 
> > 	vector = exception_vector();
> > 	report(vector == UD_VECTOR,
> > 	       "Wanted #UD on LEA with /reg, got vector = %d", vector);
> > }
> 
> I must be missing something important. There is
> `handle_exception(UD_VECTOR, 0)` early in `main()` which simply undoes
> `handle_exception(6, check_exception_table)` set by `setup_idt()`. If
> there's no more exception table walk for #UD, `ASM_TRY` alone can't
> possibly work, am I corrent?

Argh, you're correct, I didn't realize the test zapped the IDT entry.  That's a
bug, the test shouldn't zap entries, the whole point of handle_exception() returning
the old handler is so that the caller can restore it.  Grr.

> If so, am I supposed to restore the `check_exception_table()` handler? Or
> maybe using `test_for_exception()` would be more elegant:

Hmm, I prefer ASM_TRY() over test_for_exception(), having to define a function
just to emit a single instruction is silly.  What I'd really prefer is that we
wouldn't have so many ways for doing the same basic thing (obviously not your
fault, just ranting/whining).

If you have bandwidth, can you create a small series to clean up emulator.c to at
least take a step in the right direction?

  1. Save/restore the handlers.
  2. Use ASM_TRY for the UD_VECTOR cases (KVM_FEP probing and illegal MOVBE)
  3. Add this testcase as described above.

Ideally the test wouldn't use handle_exception() at all, but that's a much bigger
mess and a future problem.
