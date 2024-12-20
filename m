Return-Path: <linux-kselftest+bounces-23631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8D09F8903
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 01:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348EE16AAEB
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 00:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC009259492;
	Fri, 20 Dec 2024 00:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HcfrR3nd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5147817C2
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 00:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734654916; cv=none; b=ECBBrlgjh17EeQkNZPcQMd36ci4f+1w6kBjDbqp3yBtC5KLH09V13D9SLCLVOEDY4I71wXfIMWZ+S9/6zEjBJz0hk09V+fKe6/lU6ijUi6fOE8PXtfnt5ogUcN7el0HBPwOUxnnRzAKwTovsVOlxQu1bpJJTF3t5ho3C9qDC++w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734654916; c=relaxed/simple;
	bh=8zesFsrhYxe56sl6AP//SXwGCndt3z3bBtXXdGkbVnc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hut8mjijcg8sCSKPrDaKEu1puwmtkG5lDMti+9YON+5kEIVE4lmiZ5KkdxZtAG6qrTA3aAn8/CSL2TniMj/SxtSOp3LhTID52/y2bFX9zCbuWTCx6M3gIrm2VvT+z6NZmH45u3gHOh/9M4gplVBnXk4XElAuVgdPsBIgg7qWqU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HcfrR3nd; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-8019f05c629so1422497a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 16:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734654914; x=1735259714; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZP7EweettbHnaJfHAvM9ZvXX/gJoJ0NtSQ9ImC1SkLU=;
        b=HcfrR3ndRq0vOl02bA4z/UGgpScbxC2PzdDjL6VV1T6TseSoFxQZaQmT4yqis/i3A+
         Owy27vBsHivMP/d2Dc0veWCeaQ5YarxTp6ezPPhz6jUH4t5M5cAACABi7hzXM+GbUVnw
         vae/NUL2cny1k7uFtHosqVQVf/dsz8oeaobMZ9z5+Y5i+1mrQnZrRd3kmOirgUulpvxi
         fckj6NkAKYijD3njnz+Ho0MpHGgQhH7oxDeD14io3z+/xw+LeJHlOiMUIRPZQ+6MWN4S
         em71z0EBsyMIIqFH+iufa8fwe3FY6uo+3y5A7CSLwhzPQHh30V+NVKK81Sxc3FV5MHZM
         2ZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734654914; x=1735259714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZP7EweettbHnaJfHAvM9ZvXX/gJoJ0NtSQ9ImC1SkLU=;
        b=sIvzGByTp/ohyIIX578eCXOEDmRtGAFxb0P+638mx2dwTGlfObh88oGHc3my+VsRyu
         /RtEICkm3Uoy69yo4ZWWFDLy90iL8rZZ48moLu8Po+gRR7c96Glw1cYQ0KKTUvJAQPn9
         HTSdrrZOo1wYTKz9rXDWo0e1aPE2LZNYXCJftH1+x/zdX1BN5p0o/R6sR03YFdx7hjYE
         jz58jP3iS2Hla6dVy4wfjdLjVZrm7iup7BTZsqMcqJb6C4S5+s0J2UIBH8GdvTTH9BL5
         SalqEhPv2NOMMLIGcilHyUly1HFii22Xh9GY+rbtyAxCuyN0oHGR4LoB9iNC2qj4eTVx
         c04g==
X-Forwarded-Encrypted: i=1; AJvYcCVS2Wz0aB00ukjLQP8hv+TnzWUGH8G4xhpOS8Q2rT8R9AeqL9CYyhKnXJ4+J6atse8SMCe/IzhS6ji0yuiDeJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0AAvKYbyWxvODKkiZTTZ6ALCeSjueTV+n6qlNvF/42BlCjqZW
	pWBYQoi7sfevzeLu2wYvQgP48dtONx6AfDGD2D0nBQEL7Tz68cjiOKdILU+hjKmmVua6c5HLu5i
	ljw==
X-Google-Smtp-Source: AGHT+IGl8E4sDgGBr1D8JkzPtvpN5PJd847VMGo8Pw0nVcJamESqSCKGCzn3YUhvVhWMECtIO8funFn8/PM=
X-Received: from pjbli10.prod.google.com ([2002:a17:90b:48ca:b0:2ee:2761:b67a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f85:b0:2ee:7870:8835
 with SMTP id 98e67ed59e1d1-2f452f0164cmr1565495a91.33.1734654913764; Thu, 19
 Dec 2024 16:35:13 -0800 (PST)
Date: Thu, 19 Dec 2024 16:35:12 -0800
In-Reply-To: <20241021062226.108657-3-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241021062226.108657-1-manali.shukla@amd.com> <20241021062226.108657-3-manali.shukla@amd.com>
Message-ID: <Z2S7wArwoBu4wBUb@google.com>
Subject: Re: [PATCH v1 2/4] KVM: selftests: Add an interface to read the data
 of named vcpu stat
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 21, 2024, Manali Shukla wrote:
> From: Manali Shukla <Manali.Shukla@amd.com>
> 
> The interface is used to read the data values of a specified vcpu stat
> from the currenly available binary stats interface.
> 
> Add a concatenation trickery to trigger compiler error if the stat
> doesn't exist, so that it is not possible to pass a per-VM stat into
> vcpu_get_stat().
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
> ---
>  .../testing/selftests/kvm/include/kvm_util.h  | 52 +++++++++++++++++++
>  .../kvm/include/x86_64/kvm_util_arch.h        | 36 +++++++++++++
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 40 ++++++++++++++
>  3 files changed, 128 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index bc7c242480d6..5dd3acf174f8 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -531,6 +531,14 @@ void read_stat_data(int stats_fd, struct kvm_stats_header *header,
>  		    struct kvm_stats_desc *desc, uint64_t *data,
>  		    size_t max_elements);
>  
> +#define DEFINE_CHECK_STAT(type, stat)			\
> +static inline int check_##type##_##stat##_exists(void)	\
> +{							\
> +	return 1;					\
> +}							\
> +
> +#define STAT_EXISTS(type, stat) (check_##type##_##stat##_exists())

This is all unnecessary complicated.  To trigger a compilation error, the set
of knnown stats just needs to be defined as _something_ and then referenced.
There's no need for layers of macros and a function for each stat.  The fact that
a stat is defined is proof of its existence.

> +
>  void __vm_get_stat(struct kvm_vm *vm, const char *stat_name, uint64_t *data,
>  		   size_t max_elements);
>  
> @@ -542,6 +550,50 @@ static inline uint64_t vm_get_stat(struct kvm_vm *vm, const char *stat_name)
>  	return data;
>  }
>  
> +#define DEFINE_GENERIC_VCPU_STAT				\
> +	DEFINE_CHECK_STAT(vcpu, halt_successfull_poll)		\
> +	DEFINE_CHECK_STAT(vcpu, halt_attempted_poll)		\
> +	DEFINE_CHECK_STAT(vcpu, halt_poll_invalid)		\
> +	DEFINE_CHECK_STAT(vcpu, halt_wakeup)			\
> +	DEFINE_CHECK_STAT(vcpu, halt_poll_success_ns)		\
> +	DEFINE_CHECK_STAT(vcpu, halt_poll_fail_ns)		\
> +	DEFINE_CHECK_STAT(vcpu, halt_wait_ns)			\
> +	DEFINE_CHECK_STAT(vcpu, halt_poll_success_hist)		\
> +	DEFINE_CHECK_STAT(vcpu, halt_poll_fail_hist)		\
> +	DEFINE_CHECK_STAT(vcpu, halt_wait_hist)			\
> +	DEFINE_CHECK_STAT(vcpu, blocking)			\
> +
> +/*
> + * Define a default empty macro for architectures which do not specify
> + * arch specific vcpu stats
> + */
> +
> +#ifndef DEFINE_ARCH_VCPU_STAT
> +#define DEFINE_ARCH_VCPU_STAT
> +#endif
> +
> +DEFINE_GENERIC_VCPU_STAT

There's also no need to define macros in arch code just to expand them in common
code.  Add simple macros in kvm_util_types.h and this goes away.

> +DEFINE_ARCH_VCPU_STAT
> +
> +#undef DEFINE_CHECK_STAT
> +#undef DEFINE_GENERIC_VCPU_STAT
> +#undef DEFINE_ARCH_VCPU_STAT

> +void __vcpu_get_stat(struct kvm_vcpu *vcpu, const char *stat_name, uint64_t *data,
> +		   size_t max_elements);
> +
> +#define vcpu_get_stat(vcpu, stat_name)				\
> +({								\
> +	uint64_t data;						\
> +								\
> +	STAT_EXISTS(vcpu, stat_name);				\
> +	__vcpu_get_stat(vcpu, #stat_name, &data, 1);		\
> +	data;							\
> +})								\
> +
> +#undef DEFINE_CHECK_STAT
> +#undef DEFINE_GENERIC_VCPU_STAT
> +

...

> +void __vcpu_get_stat(struct kvm_vcpu *vcpu, const char *stat_name, uint64_t *data,
> +		   size_t max_elements)
> +{
> +	int vcpu_stats_fd;
> +	struct kvm_stats_header header;
> +	struct kvm_stats_desc *desc, *t_desc;
> +	size_t size_desc;
> +	int i;
> +
> +	vcpu_stats_fd = vcpu_get_stats_fd(vcpu);
> +	read_stats_header(vcpu_stats_fd, &header);
> +
> +	desc = read_stats_descriptors(vcpu_stats_fd, &header);
> +	size_desc = get_stats_descriptor_size(&header);
> +
> +	for (i = 0; i < header.num_desc; ++i) {
> +		t_desc = (void *)desc + (i * size_desc);
> +
> +		if (strcmp(t_desc->name, stat_name))
> +			continue;
> +
> +		read_stat_data(vcpu_stats_fd, &header, t_desc,
> +			       data, max_elements);
> +		break;
> +	}
> +}

This is copy-pasted nearly verbatim from the VM-scoped code.  It even has the
same bugs (doesn't assert the stat exists), along with new bugs (leaks the fd
and header).

It takes a bit of work, but not _that_ much work, to genericize the VM-scoped
infrastructure and reuse it for vCPU-scoped stats.

