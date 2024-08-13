Return-Path: <linux-kselftest+bounces-15241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE3C950A65
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 18:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100641C22513
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 16:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391CD1A76CC;
	Tue, 13 Aug 2024 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1w3czFHq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3312C1A76AE
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567048; cv=none; b=NhMBgjV/xO6ZCuzxi0azgmFkYKBA0jE9a7vg0kstDlQ+9c6J8QltG9/0kLkd0bz9+vZHwlWhjksNuzwQVgUeuvQtjt+DkiBJwU4tIVACtyMCl7Ex6mIZ3AJ5XAdDTWQ/CYfkZ3HqNmE98j0DwaHRgNKspnqnLJKKjeqmpAW7ZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567048; c=relaxed/simple;
	bh=cXXSSGfkTJ3VxBSZyoAFuSt8cW4+hnYwCWGkR0yTBY8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LMgfDs9IzfYEWd0c3MWKyP3kf8jUKP0lYV2vA7TQkQglQWd4g7r7KfwhwOkf6CH390gwv9Ds5YkgoiopHp9HKkw1oFhvKDsyCVWK6I9cvtzr3e0UBMI98WvNwwF6n2FM/UI2W2q5/u0hHQihJP12Rg3p57mNAEEg9NLLxSNL/b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1w3czFHq; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6506bfeaf64so113049267b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 09:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723567044; x=1724171844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Plseirnji2ra22gQQmTti4dnuddSXpM5QGubtyfU24=;
        b=1w3czFHqwBUPUxjMudtWV3xZjrjZN02CydOu5Cwe3/6Fh2iCmOuKBMGMeE2og13tXZ
         Pq1yBb+1w99yaxN5cKHRlPJSQwevrVk5LcAjUgp+PiUzWoPSUiZDg0Txe5QGcPd11N1P
         Acaqc2QCVhtZcgN7YdWg3oZdMod/r7np5rts9+tpZmfA8cEAoVzvdanvb0tpPRftdF1G
         w+m6WqAxlRZSpDnHxDBtq+alW8NOdrYEx1F0k2yL2VY40cYHwLaxMbpUI/ptYSFV1UZq
         T+ID2is88ZTMXv6IYNLJL+sMBDuMMtEVbphbn8Hv7CRC4VdH9mkHKM3MA4kKu//cfSrv
         EuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723567044; x=1724171844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Plseirnji2ra22gQQmTti4dnuddSXpM5QGubtyfU24=;
        b=YQItP4u1vfYfqO+Ygx7oWSzJE4MoZZMC9x3RF+45m4+365mK668raPCkpwRQOmZa8P
         EaADAyGa0CWJcU8AJmUg5vvLdJoRWrqV/0jkEp9BC+hpyJfK9bqBIv1we+qKW1lUZPeG
         r0yYtXDcjEayeBT3j4HgWcRA9YlQlSwdZ/K+VXbYBrMMd+mHbTLZZqLfvlL71WIoldcp
         t3jSzIkNiw96Q71OFgYBMlECDJ7mlO52zy5y4hem5deCvKr4lTeG61dlhQoRT0UtyrAR
         70XxlMo73y9+6HquYNhBbzErM1fi44oSowBMQ5R2TDbsFFnszqPPibb3FbSBUJYnqzj7
         ns9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJyLIBGlCa6tlP2KHIAyiD8QIeznNJtlu8TlQpa+ztVg2leBtvIx7rgxhASioYdd5V8N78IQtoG7Bh4XKtOmwgHfQ2amus2BMTgZPQX6+/
X-Gm-Message-State: AOJu0Yz5+hMqgLoYbiWlNZJrd0DJOWAQFI2WJv/UrsVWjiTh/PKXz+m9
	6RusBfhUkXi0bmMbeTGVDFEt8I+2tbxY9leG+BxgKXKL88r0q9bd5LsV2fkGS0IDuPAfTTmM5O1
	VtQ==
X-Google-Smtp-Source: AGHT+IGiaUBChhoilDWQGY8xzsyuDEnbKs8zjsijAZ7ur8XfgdnK08pPVT/znSB+xjmFxf0BU9p3kYK2fPU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:9c54:0:b0:62c:ff73:83f with SMTP id
 00721157ae682-6ac9a663c2bmr477b3.8.1723567044030; Tue, 13 Aug 2024 09:37:24
 -0700 (PDT)
Date: Tue, 13 Aug 2024 09:37:22 -0700
In-Reply-To: <20240528041926.3989-5-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240528041926.3989-1-manali.shukla@amd.com> <20240528041926.3989-5-manali.shukla@amd.com>
Message-ID: <ZruLwp54itwpCPk-@google.com>
Subject: Re: [PATCH v3 4/5] KVM: selftests: Add an interface to read the data
 of named vcpu stat
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com, 
	vkuznets@redhat.com, bp@alien8.de, ajones@ventanamicro.com
Content-Type: text/plain; charset="us-ascii"

On Tue, May 28, 2024, Manali Shukla wrote:
> From: Manali Shukla <Manali.Shukla@amd.com>
> 
> The interface is used to read the data values of a specified vcpu stat
> from the currenly available binary stats interface.
> 
> Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
> ---
>  .../kvm/include/kvm_arch_vcpu_states.h        | 49 +++++++++++++++++++
>  .../testing/selftests/kvm/include/kvm_util.h  | 34 +++++++++++++
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 32 ++++++++++++
>  3 files changed, 115 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/include/kvm_arch_vcpu_states.h
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_arch_vcpu_states.h b/tools/testing/selftests/kvm/include/kvm_arch_vcpu_states.h
> new file mode 100644
> index 000000000000..755ff7de53d9
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/kvm_arch_vcpu_states.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Arch-specific stats are added to the kvm_arch_vcpu_states.h. Sequence
> + * of arch-specific vcpu_stat_type should be same as they are declared in
> + * arch-specific kvm_vcpu_stat.
> + */
> +#ifdef __x86_64__

This is backwards.  If you want arch specific stats, put it them in an arch specific
header.

> +#define KVM_X86_VCPU_STATE(x) KVM_VCPU_STATE(x)
> +
> +KVM_X86_VCPU_STATE(PF_TAKEN)

I'm pretty sure you want KVM_VCPU_STAT, KVM_X86_VCPU_STAT, kvm_arch_vcpu_states.h,
etc.

> +KVM_X86_VCPU_STATE(PF_FIXED)

...

> +/*
> + * Ensure that the sequence of the enum vcpu_stat_types matches the order of
> + * kvm_vcpu_stats_desc[].  Otherwise, vcpu_get_stat() may return incorrect data
> + * because __vcpu_get_stat() uses the enum type as an index to get the
> + * descriptor for a given stat and then uses read_stat_data() to get the stats
> + * from the descriptor.

This isn't maintainable.  Unless I'm missing something, the _order_ of KVM's stats
isn't ABI, and blindly reading an entry and hoping its the right one is doomed to
fail.

I don't see any reason whatsoever to diverge from the core functionality of
__vm_get_stat().  The only difference should be the origin of the stats file and
header.

I do see a lot of room for improvement, but that can and should be done for both
VM and vCPU stats.  E.g. provide an API (and a container/struct?) to get a direct
pointer to stat so that selftests don't have to walk all descriptors when they're
reading the same stat over and over.

And to detect typos at compile time, {vcpu,vm}_get_stat() could either play macro
games or use enums and array to detect usage of a stat that doesn't exist.  E.g.

static inline uint64_t vm_get_stat(struct kvm_vm *vm, int stat)
{
	uint64_t data;

	__vm_get_stat(vm, kvm_vm_stats[stat], &data, 1);
	return data;
}

or 

#define vm_get_stat(vm, stat)			\
({						\
	uin64_t __data;				\
						\
	<concatenation trickery to trigger compiler error if the stat doesn't exit>
	__vm_get_stat(vm, #stat, &data, 1);	\
	data;					\
})

I'd probably vote for macro games, e.g. so that it's all but impossible to pass
a per-VM stat into vcpu_get_stat(), and vice versa.

