Return-Path: <linux-kselftest+bounces-19680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0693599D9B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 00:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C991C216C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 22:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890AD1D26F7;
	Mon, 14 Oct 2024 22:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtZ8UA56"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88675231C88
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 22:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728944340; cv=none; b=Wiwxq+qP/M6hg/6sdUw2LoNgnI9epKU09TgnP+T5Nlks3y3DsH4fWPDeaQEI8uzXpD7pE53rZmWy1QeXudd3vDGYqEC+amM7LjxD0tfb7HpZCrWMXatkhec9rBn7/GKxqV1PAYtRuYvPr6jAUIU0uEtFjridS5MKt406nUL02xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728944340; c=relaxed/simple;
	bh=yB3I8uiuIfodLQQg70tjfVrEE4L5/9aX3fHruOdlsDE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=usrtUd0GV5Zt0iwnljxht0bPW/3J24HmDVVkMuDJ/YCqMWPWfn7EYZpoFSsh4PcM/JZwKYPjOhIynsXFF7tWUhJArygSwH0lnnYFuJaq9HpxrDZIX4ljGjI/RokvocR+2sHuZYQVgw7hb2FJMwduj/yBYErtG3397jUgCv1OWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jtZ8UA56; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3529d80e5so38576837b3.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 15:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728944336; x=1729549136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TY1Bpkrr53yL83DAOoYM0CZgNHKv6sxwoJKshYPV+pQ=;
        b=jtZ8UA56LYCq1zl3D0FTWT/JxEWYjpCNRNA+vpxMPpbG/Xal10G60URayiLuVYbPYZ
         gOPj/Cn4vhMsSTsNiE233V7Q3lNAYcjFY/V3D4dVGrvpnYV5Q79779ZnoeWSpe37MdLV
         ZstXtTJH6A0hMQEeqp8UrzL2QH+0srJeBGt4QQzDM0xxrb9LlvXPbtD89dZsGpXx9KDt
         1TiBzJMPeAWiTw/w6uwriZFe1c2yrvjfDTErvPjvsDCVWql9Y34+KL9lfYfXQ7w1EGiL
         CcXwd5OklvQA3Qp2ewWIXpRbSNnxabNhPoengmllurLBz8/wNbNlxHFUA3IlZSJoRABs
         F2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728944336; x=1729549136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TY1Bpkrr53yL83DAOoYM0CZgNHKv6sxwoJKshYPV+pQ=;
        b=uyJve2GaYkZAeSnw+CTD0CvnWgH6+Wgt+dly9lLl4AtgDLCFF8baVUJXrcghNBgZ4c
         8sNfQ7IzVMYvkjDUABOy5dORN+pcQbTIv97uv+bYEw99M6pu/XdWlcS5YJlVQ60R7z71
         A+KLHqe64QygRS/s5vg1e5vYlIWy6OADCQfWKmU5UfwNzQMkTIb7oy81qnJaA4ORYzLq
         /Iy13dJxBlC1I2A/zt/HYHpCM68qUFosfPajHfgumBaao4+XW5laE+zy66Lc+h3iWAvO
         Y8f14G94hqkvXWDRh9gI7yUdPPX5s42Gi//qjZTKnS3cySFZt/7UTxLlSk32JVJ2haDY
         4sHA==
X-Forwarded-Encrypted: i=1; AJvYcCXr6HhEB2GlAXhWoK1n31DxjKVExRCnfBCbT3OBr7cEJ3mj5uzFsJBGtMUITneKDZ66tqxWY89zEzuK6DccrrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1x5vTszvdk3y1MndxcHZQNr003qSePsCM1wLWp3RGkEI2uk81
	O6TdvJyw/QBYGVxxSauMILowvOP/pTg3R3J5AkJq+msd/SwtlVl4X4OdHMChWyOyVhs1oA2o+MK
	MZQ==
X-Google-Smtp-Source: AGHT+IGmKxrngJUuCWLjHKOARMaUFTzc06SCFOqpWBfOT7Q1F3B7SJdXCtSJeIXIUx44V54dolQvTBOidIU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:c09:b0:6e2:6f2:efc with SMTP id
 00721157ae682-6e347c52d2emr3662017b3.5.1728944336631; Mon, 14 Oct 2024
 15:18:56 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:18:55 -0700
In-Reply-To: <20240905124107.6954-2-pratikrajesh.sampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240905124107.6954-1-pratikrajesh.sampat@amd.com> <20240905124107.6954-2-pratikrajesh.sampat@amd.com>
Message-ID: <Zw2Yz3mOMYggOPKK@google.com>
Subject: Re: [PATCH v3 1/9] KVM: selftests: Decouple SEV ioctls from asserts
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, pgonda@google.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 05, 2024, Pratik R. Sampat wrote:
> +static inline int __sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
> +					   uint64_t hva, uint64_t size)
>  {
>  	struct kvm_sev_launch_update_data update_data = {
> -		.uaddr = (unsigned long)addr_gpa2hva(vm, gpa),
> +		.uaddr = hva,
>  		.len = size,
>  	};
>  
> -	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_DATA, &update_data);
> +	return __vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_DATA, &update_data);
> +}
> +
> +static inline void sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
> +					  uint64_t hva, uint64_t size)
> +{
> +	int ret = __sev_launch_update_data(vm, gpa, hva, size);
> +
> +	TEST_ASSERT_VM_VCPU_IOCTL(!ret, KVM_SEV_LAUNCH_UPDATE_DATA, ret, vm);
>  }
>  
>  #endif /* SELFTEST_KVM_SEV_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
> index e9535ee20b7f..125a72246e09 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
> @@ -14,15 +14,16 @@
>   * and find the first range, but that's correct because the condition
>   * expression would cause us to quit the loop.
>   */
> -static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region)
> +static int encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region)

This is all kinds of wrong.  encrypt_region() should never fail.  And by allowing
it to fail, any unexpected failure becomes harder to debug.  It's also a lie,
because sev_register_encrypted_memory() isn't allowed to fail, and I would bet
that most readers would expect _that_ call to fail given the name.

The granularity is also poor, and the complete lack of idempotency is going to
be problematic.  E.g. only the first region is actually tested, and if someone
tries to do negative testing on multiple regions, sev_register_encrypted_memory()
will fail due to trying to re-encrypt a region.

__sev_vm_launch_update() has similar issues.  encrypt_region() is allowed to
fail, but its call to KVM_SEV_LAUNCH_UPDATE_VMSA is not.

And peeking ahead, passing an @assert parameter to __test_snp_launch_start() (or
any helper) is a non-starter.  Readers should not have to dive into a helper's
implementation to understand that this

  __test_snp_launch_start(type, policy, 0, true);

is a happy path and this

  ret = __test_snp_launch_start(type, policy, BIT(i), false);

is a sad path.

And re-creating the VM every time is absurdly wasteful.  While performance isn't
a priority for selftests, there's no reason to make everything as slow as possible.

Even just passing the page type to encrypt_region() is confusing.  When the test
is actually going to run the guest, applying ZERO and CPUID types to _all_ pages
is completely nonsensical.

In general, I think trying to reuse the happy path's infrastructure is going to
do more harm than good.  This is what I was trying to get at in my feedback for
the previous version.

For negative tests, I would honestly say development them "from scratch", i.e.
deliberately don't reuse the existing SEV-MEM/ES infrastructure.  It'll require
more copy+paste to get rolling, but I suspect that the end result will be less
churn and far easier to read.

