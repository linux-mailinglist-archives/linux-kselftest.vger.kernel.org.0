Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA30B4F8132
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Apr 2022 16:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbiDGODr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Apr 2022 10:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbiDGODq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Apr 2022 10:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70495B3684
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Apr 2022 07:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649340103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iPVjUD4VGANcIQRfm5QWOv0d3iQPwruTr6X8FPFV1Gg=;
        b=eMZe9Jeu2JWiugzr+686Syu3U4+J1RTvr1cPNIma0uRrYGxRxCeSIjdbLXQCeuoIpfwJEX
        tPiVukqv/lKiUHVjLKE0t7F4rKr+M0Q4qn25eXFsB05R0h3oC/CvFFd6Hz8n57xcztWzZi
        TTL4Xuj8B9y+MNw/mhRq2JRzyhbk5do=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-KcYe9yA4Px600drJqwESbA-1; Thu, 07 Apr 2022 10:01:42 -0400
X-MC-Unique: KcYe9yA4Px600drJqwESbA-1
Received: by mail-wm1-f69.google.com with SMTP id a16-20020a05600c349000b0038e6392a346so3014399wmq.4
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Apr 2022 07:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iPVjUD4VGANcIQRfm5QWOv0d3iQPwruTr6X8FPFV1Gg=;
        b=EFW3hFTqN4/CdahoGC0G3CGy4KHQbonQ5u2rUxSqmx12VAxPqDPmaZE+qNBzF3ZjeI
         eyWCww99FGvy3nTXZxktfP/M2wSYWM/XUQ5mS6ZjcGUNjG4YIXOWc3Ydbh/6c95RJ/i3
         oadZjJgdt0dJI3L+6Mp9UPx0ZWkyCYsoVtrCGyFaJ0Z+IfTAcTyerzepRZmEm0MbkLzS
         P0LsxTWRJAAuXpALdcKwGPPkbPp+1beOL+dpF+CDb3VOTutAdf6U9V8Ma6vtTa7l27si
         VgLVrNEXkpBgUKC+S954SU1IUc2ZhIA0eIp00guJGOAIDTuGra+rLsUtDZWvpGXB5Oga
         pGOg==
X-Gm-Message-State: AOAM531CMxXZ45wW25o0CyTi454BrbYny7F5bndPg8QDkuK+Q57F5hGQ
        9Mts0vtPl7FVKlrxktobEl33vk6Q36jE26T2qkuPexXyyyCDuJiP0Po28GoWezIiQ66puGLUVIi
        8+d3ExKRQlOBASCulaRS7gWxY/Y0a
X-Received: by 2002:a05:600c:1910:b0:38c:bff7:b9db with SMTP id j16-20020a05600c191000b0038cbff7b9dbmr12633654wmq.182.1649340100901;
        Thu, 07 Apr 2022 07:01:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxU/dYZtfiATAomIrnRvl8FEyxkNIr3CwJEqCIWLwzLHA8afMCdfS5sdwqZVv6K+GTlXvZw4A==
X-Received: by 2002:a05:600c:1910:b0:38c:bff7:b9db with SMTP id j16-20020a05600c191000b0038cbff7b9dbmr12633611wmq.182.1649340100678;
        Thu, 07 Apr 2022 07:01:40 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id v1-20020adf9e41000000b00205c3d212easm17786210wre.51.2022.04.07.07.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:01:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: WARNING: at arch/x86/kvm/../../../virt/kvm/kvm_main.c:3156
 mark_page_dirty_in_slot
In-Reply-To: <YkMxGLAG0zqEzt1V@google.com>
References: <CA+G9fYsd+zXJqsxuYkWLQo0aYwmqLVA_YeBu+sr546bGA+1Nfg@mail.gmail.com>
 <YkMxGLAG0zqEzt1V@google.com>
Date:   Thu, 07 Apr 2022 16:01:39 +0200
Message-ID: <87tub56lh8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Mar 29, 2022, Naresh Kamboju wrote:
>> While running kselftest kvm test cases on x86_64 devices the following
>> kernel warning was reported.
>
> ...
>
>> [   62.510388] ------------[ cut here ]------------
>> [   62.515064] WARNING: CPU: 1 PID: 915 at
>> arch/x86/kvm/../../../virt/kvm/kvm_main.c:3156
>> mark_page_dirty_in_slot+0xba/0xd0
>> [   62.525968] Modules linked in: x86_pkg_temp_thermal fuse
>> [   62.531307] CPU: 1 PID: 915 Comm: hyperv_clock Not tainted 5.17.0 #1
>> [   62.537691] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
>> 2.0b 07/27/2017
>> [   62.545185] RIP: 0010:mark_page_dirty_in_slot+0xba/0xd0
>
> Long known issue.  I think we're all waiting for someone else to post an actual
> patch.
>
> Vitaly, can you formally post the below patch, or do you need feedback first?
>
> https://lore.kernel.org/all/874k51eddp.fsf@redhat.com/
>

Sorry, missed this. Will do.

-- 
Vitaly

