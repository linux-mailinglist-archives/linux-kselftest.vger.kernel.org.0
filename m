Return-Path: <linux-kselftest+bounces-26444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD81A31B9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 02:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642A91888101
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 01:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FA6149C4D;
	Wed, 12 Feb 2025 01:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ARZ3Bj9j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D27878F20
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Feb 2025 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739325496; cv=none; b=Ij42qsu8oXEmKefnfQzX7oeZozyCXj7estschUAVqJNV6DPgJxBOt8V4nMQ9ardP4vxbOiAQfxdjKgYdy97v/z7QMRUyAv9r5xVDS7TbNWGdI8qiI2IJCbhRbBjpRmker/iKQXAdvsG3GUude64q4WuqxObzKmymHbJoN76bop8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739325496; c=relaxed/simple;
	bh=XIMgkskMxn1nn+KR+UHsoIEJpOMWNgBuJYgmSHFKAZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=deXngBWwWxY+/cFAO0B4CjXSIY6UwSXtZuY2WwtLi9z+8LzjD+XH/C32m+jxDD3EDo2U1bA+u3dmszKxzIv5lt5rL+BVquN/9Byxsf+Y00vK/l82QHkzL5MwRMoMKe0zFgRMSBTpP7e672tnPqDtQhc3/XsH7YrRj1c3FMczXFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ARZ3Bj9j; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fa9bfea46aso3917934a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 17:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739325494; x=1739930294; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JBmexDJauWUVMueSQTYcfoS5XgO5mBN+j+WiBcxqz+0=;
        b=ARZ3Bj9jl8OJMYGMS/FPbwXsuvkeWZCEBkmkkQPAuzEX0G8LLGHWejhHH91mOuIVmp
         iKCdZ5CpvKM/rTywAtOLVVAfSorMPO5fdt5KsGv7jvO5IGnr0DOxQ7ry7AGiKT/rvfEp
         vbe9avvOFcFkew9HcMm63VUF2T1lwehR35KRC/kgEUyOX91hh5Kk8EuEBSd2tkTuksHW
         gDt6R7R8dZYSndtUuU+z8vkgY4hULZMe6aZOvcvSLq92dsjkVF49uyUAq/TYME2vChY7
         f0HUqz/LSEUAOUe1qN1GMe+/pYoGoJKbqRKfkCIYXtmqvMmOWdp7g32DL6sv2+oXPLOR
         Dd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739325494; x=1739930294;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBmexDJauWUVMueSQTYcfoS5XgO5mBN+j+WiBcxqz+0=;
        b=HgZIg0cN7g2VbazgCnGu8djCQI+aND0nuXQNmP7moyJRJlVdETbhgo6B6K79scKX6q
         7VviHFyoeM1bnOVC9YLQzIc84Opmpm5B80DI/NDh7gOdQvtLT1tSo0h5x3wUqNArS3lT
         ktbUG/J5rOtoOY+kGiYkdYzAdkv1kv2ACjEnMdqencIL5XNdOPxRmslQVOuRpa8Gj62V
         jRO95dzWbr5aYJFPd5vwYI9fBf8gSAauVjx8u9ROwWPPrwHIrt3B1ekSLSrlZq5B4drb
         30ks/vTjwHCJZ9JlbZAJ8HQMxfpIiNY+KcpS2dflTDYBRKkZYao2+uJVSpaskZInSH04
         A0Vw==
X-Forwarded-Encrypted: i=1; AJvYcCViv2PWrxXs/bR4DtmW4GjT21L87x6ojOcRV1DQ1LO+kdlLWeNqaf+99eWChImdfGe0BaLybbDpd/cu752/WA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7LCm6KfULSJWeZKQ6y8UMBZJJqGMLGnmje/Jy/ZXJQnMiYJsS
	X3Ac+eflQmzrNWGKmJ2PQCt9uJfGnl6rk4xybz2NXI8MMCmDpHbCUUzarZlW9AuIt7QF/W6aXeZ
	ZwQ==
X-Google-Smtp-Source: AGHT+IG8gNhDei/WwBHZVkG78nqd1F8fT+XYoWcLtzAPMmJRfa8+UGmH6QlGzlgYGpwOFsPEKl6pyd8osao=
X-Received: from pji8.prod.google.com ([2002:a17:90b:3fc8:b0:2fa:1fac:269c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2712:b0:2ee:741c:e9f4
 with SMTP id 98e67ed59e1d1-2fbf5be0da2mr2064880a91.11.1739325493702; Tue, 11
 Feb 2025 17:58:13 -0800 (PST)
Date: Tue, 11 Feb 2025 17:58:12 -0800
In-Reply-To: <20250203223205.36121-3-prsampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203223205.36121-1-prsampat@amd.com> <20250203223205.36121-3-prsampat@amd.com>
Message-ID: <Z6wANGkZb7_HK8ay@google.com>
Subject: Re: [PATCH v6 2/9] KVM: SEV: Disable SEV on platform init failure
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com, thomas.lendacky@amd.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, shuah@kernel.org, 
	pgonda@google.com, ashish.kalra@amd.com, nikunj@amd.com, pankaj.gupta@amd.com, 
	michael.roth@amd.com, sraithal@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 03, 2025, Pratik R. Sampat wrote:
> If the platform initialization sev_platform_init() fails, SEV cannot be
> set up and a secure VM cannot be spawned. Therefore, in this case,
> ensure that KVM does not set up, nor advertise support for SEV, SEV-ES,
> and SEV-SNP.
> 
> Suggested-by: Nikunj A Dadhania <nikunj@amd.com>
> Tested-by: Srikanth Aithal <sraithal@amd.com>
> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
> ---
> v5..v6:
> 
> * Rename is_sev_platform_init to sev_fw_initialized (Nikunj)
> * Collected tags from Srikanth.
> ---
>  arch/x86/kvm/svm/sev.c       |  2 +-
>  drivers/crypto/ccp/sev-dev.c | 10 ++++++++++
>  include/linux/psp-sev.h      |  3 +++
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index b709c2f0945c..42d1309f8a54 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2957,7 +2957,7 @@ void __init sev_hardware_setup(void)
>  	bool sev_es_supported = false;
>  	bool sev_supported = false;
>  
> -	if (!sev_enabled || !npt_enabled || !nrips)
> +	if (!sev_fw_initialized() || !sev_enabled || !npt_enabled || !nrips)
>  		goto out;

Me thinks this wasn't tested with KVM_AMD built-in[1].  I'm pretty sure Ashish's
fix[2] solves all of this?

[1] https://lore.kernel.org/all/d6d08c6b-9602-4f3d-92c2-8db6d50a1b92@amd.com
[2] https://lore.kernel.org/all/f78ddb64087df27e7bcb1ae0ab53f55aa0804fab.1739226950.git.ashish.kalra@amd.com

