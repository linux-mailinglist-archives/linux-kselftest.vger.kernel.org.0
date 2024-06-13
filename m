Return-Path: <linux-kselftest+bounces-11884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9F5907AA1
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 20:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6241A281197
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 18:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D83A14A629;
	Thu, 13 Jun 2024 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g7UtXrQm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF29314A617
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302305; cv=none; b=bLfOzNuDAb9pxXTLIxCVG/sKx4xvFE1py57wHuRZMaWv9v6X4MobppOKFjCMPcTPcBsv4etKOUvmYkrsCbDhjNPaNitKq1vbNXPfjOEYkrwXIAcHpAEQJ5zir8AqyL9C7rLqbxN+hJGz5S81KgscCST7Kqtns3/vNqG17LRONO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302305; c=relaxed/simple;
	bh=Uu68SQerv1eT74j5km+BfiY4zyB89y2nPa1tlbQp+kI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G+pAxXTpqHK4svbz415pWXeEoeqEE9fKNfBndOIPWZEzdcT5YVJh3/c4smgz0EluEMkNPuNhEp84/QdvXd87/qRdv9CaGr9nB5xQ2LSX+QmjLP9j7/eqbbn5Z7zLhUXEEYB3jN9Ll7s5bkmaTBocaDErnhSVrTYGjZGCz992dTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g7UtXrQm; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-705c3933341so974406b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 11:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718302303; x=1718907103; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gk7J+8BbLxtOtkAajMM7yjvy9BH01Nbjlz3KRlct3ug=;
        b=g7UtXrQm37ym/wAOavx/bPMBWS7ssUaYMUDUwpr+tR/XZdGaOER/npNTx2JrRc9n0w
         RI2Jp74o9jAAAeIk2iRi/7U58jINPT+Mv9Yo2OVG8zr6MQKm7QIzejEY9+SRwGALcFyt
         29LA80kFZ5Xq+vf75Yp9wSAGzmZ52OH9Vau+QlCT22m2xCYAAfacgcV9o9MEBcN2YRoj
         m5lwH2AUeuQ1uzJGaaL6gwhb9DOW+VDwNyLUvmcATZvZD0mV7WWlIX+1tetA1oaC3CFs
         a8zF0bm9Y5pQYKusS8FxwGOyYW5vGL2WrQEgoTKWf2uId48sPDhH/Kqij/i+vROuTiGb
         UYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718302303; x=1718907103;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gk7J+8BbLxtOtkAajMM7yjvy9BH01Nbjlz3KRlct3ug=;
        b=v/o0HbxpoPDEdakA+iFASB7JjAvXka58+NV3rz9SZsvP+ARgl/uvhR7XEJWsrNfxr1
         uNLKHjkAQXWHGs1WL03HdNcEFV2Z9I0ydx4TH7cQ2SmyO8eXB29K69ptv6T4ul4y/deE
         ulUwQcaWXCjY/cJhfhznf2vZ8LxP3F/dQwVWhmDijtpF5S5kAt1n5TiSVCqAVtJJBgCl
         BNe0vTayAWYRxVYsuR3H7mC77JGWUrwgShrnLw5BiMkTm9HUax1VyvV0PbNIf8wJGNGX
         4oM/+35yaM6Pv7Ive1cJKcvP4ZjKVV7jkaJdyCfR0GBFGphpT6YtmegdMHj8+zarr/qf
         8QVA==
X-Forwarded-Encrypted: i=1; AJvYcCXmAZmGO1sNL7pxzd40n0zBrha0HKa1gGwyaGvUYmkGzDLkArKev1E/0oeT96ugx58AHi6oCj8gAS9cXAfbUHSCQe28fG0wAAp70DuChDgd
X-Gm-Message-State: AOJu0Yza4j5lFpdEx3I5g+RlqcXTt0FBW2XqUztkgZcV/cu6SMdGcl7S
	4d2gX20uM2vwmfQKRcehu3eRYVrpy2XFu+cLBWrYo/m4lX1WQNuQQmR4bjhTBydCKLlDwrEOUYJ
	8HQ==
X-Google-Smtp-Source: AGHT+IGpMP0YQDlOCYIQIVWZSRBk825/2I3DscRy5g+RvmAsPoOTYF5t3/qW64MoZp/92K3S7nX8p21Z3KE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2da1:b0:705:d750:83f4 with SMTP id
 d2e1a72fcca58-705d7508823mr1219b3a.3.1718302303033; Thu, 13 Jun 2024 11:11:43
 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:11:41 -0700
In-Reply-To: <20240207172646.3981-18-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-18-xin3.li@intel.com>
Message-ID: <Zms2XcFS5Ve0XLUa@google.com>
Subject: Re: [PATCH v2 17/25] KVM: nVMX: Add support for the secondary VM exit controls
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin3.li@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, vkuznets@redhat.com, peterz@infradead.org, 
	ravi.v.shankar@intel.com, xin@zytor.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 07, 2024, Xin Li wrote:
> @@ -6856,13 +6865,17 @@ static void nested_vmx_setup_exit_ctls(struct vmcs_config *vmcs_conf,
>  		VM_EXIT_HOST_ADDR_SPACE_SIZE |
>  #endif
>  		VM_EXIT_LOAD_IA32_PAT | VM_EXIT_SAVE_IA32_PAT |
> -		VM_EXIT_CLEAR_BNDCFGS;
> +		VM_EXIT_CLEAR_BNDCFGS | VM_EXIT_ACTIVATE_SECONDARY_CONTROLS;
>  	msrs->exit_ctls_high |=
>  		VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR |
>  		VM_EXIT_LOAD_IA32_EFER | VM_EXIT_SAVE_IA32_EFER |
>  		VM_EXIT_SAVE_VMX_PREEMPTION_TIMER | VM_EXIT_ACK_INTR_ON_EXIT |
>  		VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
>  
> +	/* secondary exit controls */

Drop the comment, it's pretty obvious what field is being setup.

> +	if (msrs->exit_ctls_high & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS)
> +		rdmsrl(MSR_IA32_VMX_EXIT_CTLS2, msrs->secondary_exit_ctls);

This is wrong, the resulting msrs->secondary_exit_ctls needs to be sanitized
based on what KVM supports for nVMX.

On a very related topic, this should not do a raw RDMSR.  One of the reasons why
KVM uses vmcs_config as the base is to avoid advertising features to L1 that KVM
itself doesn't support, e.g. because the expected entry+exit pairs aren't
supported.

And by pulling state from vmcs_conf->secondary_exit_ctls there's no need to check
the activation bit.

I.e. literaly just this:

	msrs->secondary_exit_ctls = vmcs_conf->secondary_exit_ctls;
	msrs->secondary_exit_ctls &= 0;

and then when nVMX FRED support is ready, it becomes:

	msrs->secondary_exit_ctls = vmcs_conf->secondary_exit_ctls;
	msrs->secondary_exit_ctls &= SECONDARY_VM_EXIT_SAVE_IA32_FRED |
				     SECONDARY_VM_EXIT_LOAD_IA32_FRED;

