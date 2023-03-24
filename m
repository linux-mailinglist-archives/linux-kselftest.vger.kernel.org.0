Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AFD6C8775
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 22:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjCXV1T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 17:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjCXV1S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 17:27:18 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3836199D9
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 14:27:17 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id b1-20020a17090a8c8100b002400db03706so1061010pjo.0
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 14:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679693237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6zePKddV/iwqym9bgYlEazTH1FsVa1YzF3bKPGXvyUE=;
        b=TPLvUusFr04aY1T8sG+B11UMeVGSvt3rYDLfC+ZDclob/dEbEDc+HS2AMxlgy8GJ6c
         yF9p4G8EY3b9xXqA0mjA6XXvfzwxsYOsZw4QCZBQ1X/FKmrGmKg6i39HGfImcXuJJoTy
         EdPIGSymDbNdzX1EA0vaAZm4KiQZbUZgaoOTMFRMBPmfzbSHimw4Fhg76gxYdRLg+o5y
         0WHD5fLeSOQ41C41WYtOoow8OZioEc/lbQGhWf+hXCZOjxn8CA8k/0JBLVpyz7sCHsYK
         HDY7xVfSswAjRVXv4O3AhGyB6LcCDgyDikHDD6AJRCrxMB53rBbzFR+cFmgLuPPCvzkP
         qjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679693237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6zePKddV/iwqym9bgYlEazTH1FsVa1YzF3bKPGXvyUE=;
        b=KKEnYkYMqDdhPgpZl0nYaEbZTgeXVX8san3j/NGs17lSnw2IbWGzKqtFxrRpICdEUe
         omzeoKgI4LYBIs+eNitEsPigP5ov66gQQ8jc8WO53jfVRheu1iNeCJgUZZsX86GgWxnB
         LtoByHxABUV6L6VxBxjKDVsj8o/oiTVL6VOIui7NgWWUvMluP/LBgvL4zprv9ly3dSaf
         k/u/qqYXjE3tUKue3822YdNMASdnBhv6juNiswwEkAPZDeTCHmH38GzhKdwBFUNxOMVe
         0Z9TkqjSQwUHmxCHizMVdUTNMe5/n3o5CMqkYTbcVGSyDszYwEpaYO1r2McLA4RoDXuH
         Pa1A==
X-Gm-Message-State: AAQBX9dySnYqEt9qp/5Br4do4e2yw2+pL0iOywP/QAQqv9/OHDOJh8Y/
        nqNixsYSqwvZobu+E+fezMPufi5+9SM=
X-Google-Smtp-Source: AKy350aqGWsdWjWwegqoLWfvcdbn6k4rDZFiOq/lDmEEoy5VQtVIcuZTzkPUDGTRpSoVgjf+URb5P6CmVQ4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:fa12:b0:23b:3426:bc5e with SMTP id
 cm18-20020a17090afa1200b0023b3426bc5emr1279659pjb.4.1679693237539; Fri, 24
 Mar 2023 14:27:17 -0700 (PDT)
Date:   Fri, 24 Mar 2023 14:27:16 -0700
In-Reply-To: <167969137156.2756401.15618241992481271147.b4-ty@google.com>
Mime-Version: 1.0
References: <20230227180601.104318-1-ackerleytng@google.com> <167969137156.2756401.15618241992481271147.b4-ty@google.com>
Message-ID: <ZB4VtIPZjDGwuPOc@google.com>
Subject: Re: [PATCH v2 1/1] KVM: selftests: Adjust VM's initial stack address
 to align with SysV ABI spec
From:   Sean Christopherson <seanjc@google.com>
To:     pbonzini@redhat.com, shuah@kernel.org, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Cc:     erdemaktas@google.com, vannapurve@google.com, sagis@google.com,
        mail@maciej.szmigiero.name
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 24, 2023, Sean Christopherson wrote:
> On Mon, 27 Feb 2023 18:06:01 +0000, Ackerley Tng wrote:
> > Align the guest stack to match calling sequence requirements in
> > section "The Stack Frame" of the System V ABI AMD64 Architecture
> > Processor Supplement, which requires the value (%rsp + 8), NOT %rsp,
> > to be a multiple of 16 when control is transferred to the function
> > entry point. I.e. in a normal function call, %rsp needs to be 16-byte
> > aligned _before_ CALL, not after.
> > 
> > [...]
> 
> Applied to kvm-x86 selftests, thanks!
> 
> [1/1] KVM: selftests: Adjust VM's initial stack address to align with SysV ABI spec
>       https://github.com/kvm-x86/linux/commit/1982754bd2a7

Force pushed to selftests 'cause I had a goof, this now:

        KVM: selftests: Adjust VM's initial stack address to align with SysV ABI spec
        https://github.com/kvm-x86/linux/commit/8264e85560e5
