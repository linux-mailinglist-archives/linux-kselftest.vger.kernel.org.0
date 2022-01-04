Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA43484910
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jan 2022 21:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiADUBc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jan 2022 15:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiADUBb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jan 2022 15:01:31 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CADC061785
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Jan 2022 12:01:31 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id h1so24563469pls.11
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jan 2022 12:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P38x3udDv7VccpZiXoJefyN8u/f+VmXSebvIF1IMJ9Y=;
        b=qw2oIUC6W97Gros4OgiOyM9i+7wnsvMfbBO23Bw18z3JsaKNq/k2XsNKJCHIs+uVhy
         LmQ2DH+PIflhbQyURRzOlqUVA/dYVzQ12LkZXFq45gUQaxupOlYHXeyYVsxaSjASGl3S
         I3smWKwTp3QwUj7mR7TBDxgbLSUUQaBE7x1YudiYEl9vOXxoPnFxMLlNGowaNoUtOsY7
         oWzeA6Ag6CFEl7bhn8kaTJBmd9SsR0da/cCl2HOmLeD/c6hgdl1K8Vbn+irjyJggrDLD
         G7gxVyMzrcBVJdVBE13VgLzQVG1NPt9Ca/2mS6l4lsOJ1jvBpH4jMbyliEsT9CTHaVRi
         UB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P38x3udDv7VccpZiXoJefyN8u/f+VmXSebvIF1IMJ9Y=;
        b=cAN/Yt6jk8+CQuW5nj8/uaAvrWBPJhXzm8+F1rjEBFffYnJJ2p+++3TUTW//NuuqjL
         Cb9Rb7luw+4eXs966oRUT+L3eTcUgQuzN79pu7+EJxvsktY6mpZD5PXkntu/0fKndGWw
         G9qiZIEBLHPDKOYCrTTH3SHlV4QrVGITMT+Fy3iESwP4fSRQV3y7ZGAY2YxxpQ2Ar0S8
         MFgA21lEb7c5ZTHao62xQs+xc61+pDxNS/BO9MjK3L6SuuHuikk/jFbRQTr6zCh8pj0Z
         IBj0J9w6iMQiE4dLL7R3gcYDpYZZ5WSjvkg9W4FF2js1BQ5cGVm0uQBhAqJ/aqYjnMTh
         9QjQ==
X-Gm-Message-State: AOAM533V/9LnQA7o+g0BflKcyRP9UK7veKXat5J3MpVM6MPQBBKoKTKV
        lvd0354KJKDxtjGxyIsTtvcbNQ==
X-Google-Smtp-Source: ABdhPJwBn8VJJJbQjgdjK3BL5ElqCtvbbHY3YHVoqOGEuLZPAF39gjygq4zF9vcYOMP1k5rlARtrIQ==
X-Received: by 2002:a17:902:c94b:b0:149:22af:ed1c with SMTP id i11-20020a170902c94b00b0014922afed1cmr49705852pla.78.1641326490792;
        Tue, 04 Jan 2022 12:01:30 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id nu18sm160918pjb.15.2022.01.04.12.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 12:01:30 -0800 (PST)
Date:   Tue, 4 Jan 2022 20:01:26 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yang Zhong <yang.zhong@intel.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com
Subject: Re: [PATCH v4 12/21] kvm: x86: Intercept #NM for saving IA32_XFD_ERR
Message-ID: <YdSnlmO4dUnwRxxc@google.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
 <20211229131328.12283-13-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229131328.12283-13-yang.zhong@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 29, 2021, Yang Zhong wrote:
> +static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)
> +{
> +	rdmsrl(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
> +	kvm_queue_exception(vcpu, NM_VECTOR);

This is still wrong, even though no additional supported is needed to support
nested XFD.  If L1 wants to intercept #NM, then KVM must not inject the #NM and
must not read XFD_ERR.

That this was posted multiple times is disturbing, because kvm-unit-tests has a
test for exactly this, and running it against this series on a host without XFD
yields:

  unchecked MSR access error: RDMSR from 0x1c5 at rIP: 0xffffffffa02478ee (vmx_handle_exit_irqoff+0x1de/0x240 [kvm_intel])
  Call Trace:
   <TASK>
   kvm_arch_vcpu_ioctl_run+0x11a0/0x1fb0 [kvm]
   kvm_vcpu_ioctl+0x279/0x690 [kvm]
   __x64_sys_ioctl+0x83/0xb0
   do_syscall_64+0x3b/0xc0
   entry_SYSCALL_64_after_hwframe+0x44/0xae
   </TASK>
