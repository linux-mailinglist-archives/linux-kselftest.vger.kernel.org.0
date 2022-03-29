Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBD24EB1AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Mar 2022 18:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239551AbiC2QTR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Mar 2022 12:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239524AbiC2QTQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Mar 2022 12:19:16 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52DF18FAC4
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Mar 2022 09:17:33 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f10so7735267plr.6
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Mar 2022 09:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TMrA0BSxQ2e14GUo8aUARrnnRc+CyMpNFMpjP7yEipw=;
        b=ZpI8HNwlFm89T3GivZ/z8dptmrBOynllfNitBkGa8KUnUZUORBC1R73FTdtWPAGk5l
         QabfMqpAm2NMfMr1MidAfzdW0P3dArEUOu1NaBpJPi5zlopNDkr7S/vZJ/wmZ3VdLzpj
         OO38ARcDPSppoN4qNsO+xF5QRfLfHSgMRUpF8EmNiDVY6AxUZs6jN1toKtdDOjf+e22L
         hqrV9unSkQknZnx2q8HUYZ44wRa0YEymQ6kXax81e0SSXqqdaLA7C5OuZYHvyFwy521E
         bIq11o9dVlBIImt8PzSLvu6DXujxCO3RbEZoGW0QH3zTlscx2/dxrV82sWRecub8/Enn
         wV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TMrA0BSxQ2e14GUo8aUARrnnRc+CyMpNFMpjP7yEipw=;
        b=GEWLNrS57pIazBmdI6ryUNf2NLZ6h/+8POZTtr3B1Sq2uDfVaS0FrLwGFXok1Ox4mB
         PEGzFT8OZN9vTL+vMXQTCElFis5V401k/0sy0D1Ntd0+mRHNXp4yQ49Rcx5bFnCmozkI
         nPeOAIeXbs708nXprvY9FSwLwGEgdm5SAkSVnq6REER/pZIbdxE5q0Quf2RdmvEWtZYL
         oOKuC+pNKI5LxJNSEj8/W0341Lk7vm/jF2ilQ+3oSOdg5Picnfw1MarsyrL48yoJJfjn
         BssbkR/QiypNk8gysbiAtVAYLkFrHzPFGifoIJSIMP2FjU6N+PN+pFahKuPedUVkNZrM
         8VSQ==
X-Gm-Message-State: AOAM530LYUG1l7L8YOtq926EEWZpqDLVKcOad2yrUvkxPtgijICWTw6Q
        HfePSjS9bSVzPmk55bGucNL+3g==
X-Google-Smtp-Source: ABdhPJytcG+eED68hrgGg1AnBIRwhFeGvXbf9FyhfN4WiBIavoIciyGwvRV+T95FqYOFvEGhwoo/aw==
X-Received: by 2002:a17:902:d708:b0:156:1858:71fa with SMTP id w8-20020a170902d70800b00156185871famr8454366ply.92.1648570652930;
        Tue, 29 Mar 2022 09:17:32 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w9-20020a056a0014c900b004fb2ca5f6d7sm12956163pfu.136.2022.03.29.09.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 09:17:32 -0700 (PDT)
Date:   Tue, 29 Mar 2022 16:17:28 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: WARNING: at arch/x86/kvm/../../../virt/kvm/kvm_main.c:3156
 mark_page_dirty_in_slot
Message-ID: <YkMxGLAG0zqEzt1V@google.com>
References: <CA+G9fYsd+zXJqsxuYkWLQo0aYwmqLVA_YeBu+sr546bGA+1Nfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsd+zXJqsxuYkWLQo0aYwmqLVA_YeBu+sr546bGA+1Nfg@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 29, 2022, Naresh Kamboju wrote:
> While running kselftest kvm test cases on x86_64 devices the following
> kernel warning was reported.

...

> [   62.510388] ------------[ cut here ]------------
> [   62.515064] WARNING: CPU: 1 PID: 915 at
> arch/x86/kvm/../../../virt/kvm/kvm_main.c:3156
> mark_page_dirty_in_slot+0xba/0xd0
> [   62.525968] Modules linked in: x86_pkg_temp_thermal fuse
> [   62.531307] CPU: 1 PID: 915 Comm: hyperv_clock Not tainted 5.17.0 #1
> [   62.537691] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.0b 07/27/2017
> [   62.545185] RIP: 0010:mark_page_dirty_in_slot+0xba/0xd0

Long known issue.  I think we're all waiting for someone else to post an actual
patch.

Vitaly, can you formally post the below patch, or do you need feedback first?

https://lore.kernel.org/all/874k51eddp.fsf@redhat.com/
