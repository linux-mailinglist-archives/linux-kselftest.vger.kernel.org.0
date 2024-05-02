Return-Path: <linux-kselftest+bounces-9262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368838B9B66
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 15:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A45BB20AD9
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 13:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2582E83CCF;
	Thu,  2 May 2024 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GzBlG7oI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C607824AC
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655689; cv=none; b=WFSAeKFB7aX3DYMtl+X9KhuVdGLbeMj6oFZmTgDreehWEeLZCI4VKdqbCBaGfxLrKpEmqI8wfLMPB6l5ujUjxT6GFRDL9SKkKhJ9IBlRogmX1JBiVg9p5fggiQj+8Plv7aPoX/HUp/jFGntXZMYlG6wTJ0X+fY6OQaG7f+yHCn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655689; c=relaxed/simple;
	bh=2hQhyZNEmCrt6YN4ixePY3tRJcJ8zXFd3QOzd3CYO2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MADYpCaslecNkuAMw6JKDVJGZ94pEZLrWfxnxuDmqiV2QEnBOcZ6z9aW4Mz45dzveoU5yXTKJp1ekhLab9Qlm76g9wOkU3zVTAloSFckwQXdc5osEz1OxDJqjFgh+qgFEdWBLIUZ8SvJi8VtXvSmUR0XNEiGyI5si1b0tBvKjMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=GzBlG7oI; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51f1bf83f06so832693e87.1
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2024 06:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714655685; x=1715260485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N04nmIhCaSLp976hW0Nt5kcaucCvNOD49E/G6JkJFhw=;
        b=GzBlG7oIf+n5b52QNbfa152qoM+KUYOTxnwF4DqQc8uJx0pRbgXlODrPYye2THwFgl
         UluT9VlFDJs+wYDEpZ+SzdkymB1oBJIWRG+eAvmhKYpkrQJk+0WbGOASe9KIzVj2flEP
         7exaTCHpY7+oJsSm4oEqNlX+HZf49rGJEKFGbC007R561w/6hhdUo3ceHmU02ORtdN0t
         fvaNFpDhqpTu+AeXyLCeRYz6Sdo89k3lR3kWRlTm1vYg+vyb3Il2dRVRd1uGBL3s2WZN
         7VBWVVcRsf+HX1V19K7LF/jnA87KfMImQJNBcPMg/dlc8xbIeEoK9uq345Os5jg//0Q9
         CpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714655685; x=1715260485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N04nmIhCaSLp976hW0Nt5kcaucCvNOD49E/G6JkJFhw=;
        b=QYaRpzXjVbSCic3xcJ6wXqHXT7EO84n3eGveGr/WeA1fzyyGGi+Lq1S23nWk6LoorU
         p1UdMWTZsUUheyVu/UF2Dxd0j/f7ReTLDK9bzYfSP9DF50x2zoR3KM/AAhltzuO03IMx
         wd7jkNuTbnR4Ols6MfEtVKDGnAMyw2fp1uoDlG8S0ZNzD735y4ceDhlSUGndBrF8ILPh
         04xDZazTFPn+apBT64qVGcEv+xQUeEpaF1XmBw5E6QI/nknmKRJ7SRqIWMf73fvv+QyQ
         7yRzgVRjO+/UgTaJXFhD99VB/pviZXb8c4WZN8Yk8IIP9TYXOwK2kDpL7xYiCrMjrrJE
         dmLw==
X-Forwarded-Encrypted: i=1; AJvYcCWnSFODQZoenJ6eYJ0LgFf0LQB7iicg8f5kT9CqpsSWVSMkFkYPjETxe0HkeONj4zBgXio9589emSa9l+RHAe8JfJehXh+sLQNQffeD5/Et
X-Gm-Message-State: AOJu0YyoOVCQ5UJb82d3xhobBpDhsscFGPbssTC9OqrUzPLEhJ/TjKqu
	H6x6PRHD2pm7JHNuZvnhYasifH1twTGPHM0MItMOgBVKxqUvLTXM9vdNEa4HA+o=
X-Google-Smtp-Source: AGHT+IFCPiFxNjxB0htqVv8Jm9Dd485dVc8qfuYYebVcbCV1yz1LUb7952rHwjiRAEYqGCy0hmBGDw==
X-Received: by 2002:a05:6512:6d6:b0:51d:d630:365a with SMTP id u22-20020a05651206d600b0051dd630365amr4809799lff.54.1714655685323;
        Thu, 02 May 2024 06:14:45 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a4-20020aa7cf04000000b00572abf81975sm522305edy.52.2024.05.02.06.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 06:14:44 -0700 (PDT)
Date: Thu, 2 May 2024 15:14:43 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com, 
	thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de
Subject: Re: [PATCH v2 4/5] KVM: selftests: Add an interface to read the data
 of named vcpu stat
Message-ID: <20240502-c23f757478f11e7b087377ee@orel>
References: <20240501145433.4070-1-manali.shukla@amd.com>
 <20240501145433.4070-5-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501145433.4070-5-manali.shukla@amd.com>

On Wed, May 01, 2024 at 02:54:32PM GMT, Manali Shukla wrote:
> From: Manali Shukla <Manali.Shukla@amd.com>
> 
> The interface is used to read the data values of a specified vcpu stat
> from the currenly available binary stats interface.
> 
> Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
> ---
>  .../testing/selftests/kvm/include/kvm_util.h  | 66 +++++++++++++++++++
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 32 +++++++++
>  2 files changed, 98 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 63c2aaae51f3..7dad3275a4d3 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -518,6 +518,72 @@ static inline uint64_t vm_get_stat(struct kvm_vm *vm, const char *stat_name)
>  	return data;
>  }
>  
> +/*
> + * Ensure that the sequence of the enum vcpu_stat_types matches the order of
> + * kvm_vcpu_stats_desc[].  Otherwise, vcpu_get_stat() may return incorrect data
> + * because __vcpu_get_stat() uses the enum type as an index to get the
> + * descriptor for a given stat and then uses read_stat_data() to get the stats
> + * from the descriptor.
> + */
> +enum vcpu_stat_types {
> +	HALT_SUCCESSFUL_POLL,
> +	HALT_ATTEMPTED_POLL,
> +	HALT_POLL_INVALID,
> +	HALT_WAKEUP,
> +	HALT_POLL_SUCCESS_NS,
> +	HALT_POLL_FAIL_NS,
> +	HALT_WAIT_NS,
> +	HALT_POLL_SUCCESS_HIST,
> +	HALT_POLL_FAIL_HIST,
> +	HALT_WAIT_HIST,
> +	BLOCKING,

Everything below here is x86 specific, but this is an arch-neutral file.
Please structure this in a way that each architecture can share the
generic types and also provide its own.

Thanks,
drew

> +	PF_TAKEN,
> +	PF_FIXED,
> +	PF_EMULATE,
> +	PF_SPURIOUS,
> +	PF_FAST,
> +	PF_MMIO_SPTE_CREATED,
> +	PF_GUEST,
> +	TLB_FLUSH,
> +	INVLPG,
> +	EXITS,
> +	IO_EXITS,
> +	MMIO_EXITS,
> +	SIGNAL_EXITS,
> +	IRQ_WINDOW_EXITS,
> +	NMI_WINDOW_EXITS,
> +	LD_FLUSH,
> +	HALT_EXITS,
> +	REQUEST_IRQ_EXITS,
> +	IRQ_EXITS,
> +	HOST_STATE_RELOAD,
> +	FPU_RELOAD,
> +	INSN_EMULATION,
> +	INSN_EMULATION_FAIL,
> +	HYPERCALLS,
> +	IRQ_INJECTIONS,
> +	NMI_INJECTIONS,
> +	REQ_EVENT,
> +	NESTED_RUN,
> +	DIRECTED_YIELD_ATTEMPTED,
> +	DIRECTED_YIELD_SUCCESSFUL,
> +	PREEMPTION_REPORTED,
> +	PREEMPTION_OTHER,
> +	GUEST_MODE,
> +	NOTIFY_WINDOW_EXITS,
> +};
> +
> +void __vcpu_get_stat(struct kvm_vcpu *vcpu, enum vcpu_stat_types type, uint64_t *data,
> +		   size_t max_elements);
> +
> +static inline uint64_t vcpu_get_stat(struct kvm_vcpu *vcpu, enum vcpu_stat_types type)
> +{
> +	uint64_t data;
> +
> +	__vcpu_get_stat(vcpu, type, &data, 1);
> +	return data;
> +}
> +
>  void vm_create_irqchip(struct kvm_vm *vm);
>  
>  static inline int __vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 6b2158655baa..3de292ca9280 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -2256,6 +2256,38 @@ void read_stat_data(int stats_fd, struct kvm_stats_header *header,
>  		    desc->name, size, ret);
>  }
>  
> +/*
> + * Read the data of the named vcpu stat
> + *
> + * Input Args:
> + *   vcpu - the vcpu for which the stat should be read
> + *   stat_name - the name of the stat to read
> + *   max_elements - the maximum number of 8-byte values to read into data
> + *
> + * Output Args:
> + *   data - the buffer into which stat data should be read
> + *
> + * Read the data values of a specified stat from the binary stats interface.
> + */
> +void __vcpu_get_stat(struct kvm_vcpu *vcpu, enum vcpu_stat_types type, uint64_t *data,
> +		   size_t max_elements)
> +{
> +	int vcpu_stats_fd;
> +	struct kvm_stats_header header;
> +	struct kvm_stats_desc *desc, *t_desc;
> +	size_t size_desc;
> +
> +	vcpu_stats_fd = vcpu_get_stats_fd(vcpu);
> +	read_stats_header(vcpu_stats_fd, &header);
> +
> +	desc = read_stats_descriptors(vcpu_stats_fd, &header);
> +	size_desc = get_stats_descriptor_size(&header);
> +
> +	t_desc = (void *)desc + (type * size_desc);
> +	read_stat_data(vcpu_stats_fd, &header, t_desc,
> +			data, max_elements);
> +}
> +
>  /*
>   * Read the data of the named stat
>   *
> -- 
> 2.34.1
> 

