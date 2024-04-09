Return-Path: <linux-kselftest+bounces-7469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF26889D3B6
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 10:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8221F21333
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 08:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EF67D3F4;
	Tue,  9 Apr 2024 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="bDvmIuLJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1317C69DF4
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Apr 2024 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712649713; cv=none; b=JjWfhO5y2Dc9p9FZQTLDaGtQu+PGTpelMJpWoS4ij36wVZLl2gLcVCRIMgCmvRT/rFd7aJ/+tdKpnB5hmJsVMLL5aaxl0qvPb/w+glQZEBE76l2LRXmjOTm8LNuelSEHGyrGz6OskC7J3Mz6yUdzc4lN6TXt4j60fQ9mDALULvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712649713; c=relaxed/simple;
	bh=bMz8MjfIFsUyXV5WBM+KwspP/jmIVlkv1FepIQu2Qp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIpy3IhbrMJdhpZzptt3gxr53lSqK2xsOXox+Xkmpx6ZX2eh8VVlUHQpNgFsjbMMmSZcewe3w5JXqsfyw8emUCsAZmh2Zmj5FUjfLzAnYA4xHeloyeoPK/Z7+5ASrc3VMCL5DmMTMEhpTMdzHMHMMbnH3lzhY6eXai4HAsIiIbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=bDvmIuLJ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a44665605f3so599008666b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Apr 2024 01:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712649710; x=1713254510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hCIVc0ToTPxKSHwFH39eeFiQ4Iaybjud05qpLdkE0so=;
        b=bDvmIuLJoYJqpdDTSPlonpFWZ014QS2fVczgt/f+ynUjQb2JujJWKWF12nHXlha+3H
         +zywUUlMWJ0TajJEgqBtUVF/t+zW5EWW5A2nOf8wmwsPZHnrmHYaq1K8/ACLGAqIDc71
         blYJwT13++VKoz638Dp1c+9PUBEt/DbD3l/ziA/nFGyX9/UU857ifGmcMTJg52CzW9WL
         R7PLZOBpEHMcWLXHynqP1d1uqMvNS37Fk8loTmXGwMKJHxUNq3M6yqpL7v4Oe4GodW9U
         gGIcw+qmWANNzonmrTZPY4zZyk3H52XleZAkKfVOmthbobOBh/vzHuRl2tQQhG20Ohdx
         7HVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712649710; x=1713254510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCIVc0ToTPxKSHwFH39eeFiQ4Iaybjud05qpLdkE0so=;
        b=sB9CxXeGYOs5hhNhMIA8yNhjazAmu7H7f2/fGLcsRQutoOD7dDrOvNjlgTwWsZ1tZk
         M8JhOI1spZFWdoHuunwuRLN++rI3IG310BcgNGBO3ks8w2e+5lt+eaUPaKOMqZH3CGjD
         FPwakGI5Fm8zITWnTQ2C5Vt/Y4zObs86RnvyHRyp9JQOSJnVQhUrWqSZKtKSTwD3M/XL
         /5LyiYzKWEuYTxHQ/JR1zuCBiqrzJSgrCaXTbPa7XakF3wUNwb0+rMdjuXq1FEOjF+LD
         f/Q5EyvrCYOK3WIpZ15JJCrM6bwtlTZDhefsHKUxowXEA8atSeGawgmQ+kYQq/Ovtivg
         lPYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaiahQ6wefSj+GZxW4km4zQULaW1toAiwtjtqYfRe/4WDCEpV8DCCvTu12k7k91+vbKLGqfWbBSOViNI3Yyi2pH/WmivuIDDsfVQcF3DkK
X-Gm-Message-State: AOJu0YyXdLWac93vxH6eVswaKekf2xwA4MmRJsOU3BNLFHAv9FlrB50p
	SnTgn83JcDzFIcufQKgMr7A85OPcUkDjIRR2bvgyvv7wc3Q9aIZm+486GdijGP4=
X-Google-Smtp-Source: AGHT+IG/T7uaqwe5y6oCGXamr2sprW/wjX+aVwR61ApsAhhRf7ZUfXSB3xs49ZIPwF/ZvGx/GUAiPw==
X-Received: by 2002:a17:906:c454:b0:a4d:f5e6:2e34 with SMTP id ck20-20020a170906c45400b00a4df5e62e34mr6793646ejb.19.1712649710207;
        Tue, 09 Apr 2024 01:01:50 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id xh13-20020a170906da8d00b00a51c0c0cb86sm3775778ejb.22.2024.04.09.01.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 01:01:49 -0700 (PDT)
Date: Tue, 9 Apr 2024 10:01:48 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Ajay Kaher <akaher@vmware.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Alexey Makhalov <amakhalov@vmware.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 20/22] KVM: riscv: selftests: Add SBI PMU selftest
Message-ID: <20240409-dd055c3d08e027cf2a5cb4dc@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-21-atishp@rivosinc.com>
 <20240405-d1a4cb9a441a05a9d2f8b1c8@orel>
 <976411ab-6ddf-4b10-8e13-1575928415ce@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <976411ab-6ddf-4b10-8e13-1575928415ce@rivosinc.com>

On Mon, Apr 08, 2024 at 05:37:19PM -0700, Atish Patra wrote:
> On 4/5/24 05:50, Andrew Jones wrote:
> > On Wed, Apr 03, 2024 at 01:04:49AM -0700, Atish Patra wrote:
> > ...
> > > +static void test_pmu_basic_sanity(void)
> > > +{
> > > +	long out_val = 0;
> > > +	bool probe;
> > > +	struct sbiret ret;
> > > +	int num_counters = 0, i;
> > > +	union sbi_pmu_ctr_info ctrinfo;
> > > +
> > > +	probe = guest_sbi_probe_extension(SBI_EXT_PMU, &out_val);
> > > +	GUEST_ASSERT(probe && out_val == 1);
> > > +
> > > +	num_counters = get_num_counters();
> > > +
> > > +	for (i = 0; i < num_counters; i++) {
> > > +		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_INFO, i,
> > > +				0, 0, 0, 0, 0);
> > > +
> > > +		/* There can be gaps in logical counter indicies*/
> > > +		if (ret.error)
> > > +			continue;
> > > +		GUEST_ASSERT_NE(ret.value, 0);
> > > +
> > > +		ctrinfo.value = ret.value;
> > > +
> > > +		/**
> > > +		 * Accesibillity check of hardware and read capability of firmware counters.
> > 
> > Accessibility
> > 
> 
> Fixed it.
> 
> > > +		 * The spec doesn't mandate any initial value. No need to check any value.
> > > +		 */
> > > +		read_counter(i, ctrinfo);
> > > +	}
> > > +
> > > +	GUEST_DONE();
> > > +}
> > > +
> > > +static void run_vcpu(struct kvm_vcpu *vcpu)
> > > +{
> > > +	struct ucall uc;
> > > +
> > > +	vcpu_run(vcpu);
> > > +	switch (get_ucall(vcpu, &uc)) {
> > > +	case UCALL_ABORT:
> > > +		REPORT_GUEST_ASSERT(uc);
> > > +		break;
> > > +	case UCALL_DONE:
> > > +	case UCALL_SYNC:
> > > +		break;
> > > +	default:
> > > +		TEST_FAIL("Unknown ucall %lu", uc.cmd);
> > > +		break;
> > > +	}
> > > +}
> > > +
> > > +void test_vm_destroy(struct kvm_vm *vm)
> > > +{
> > > +	memset(ctrinfo_arr, 0, sizeof(union sbi_pmu_ctr_info) * RISCV_MAX_PMU_COUNTERS);
> > > +	counter_mask_available = 0;
> > > +	kvm_vm_free(vm);
> > > +}
> > > +
> > > +static void test_vm_basic_test(void *guest_code)
> > > +{
> > > +	struct kvm_vm *vm;
> > > +	struct kvm_vcpu *vcpu;
> > > +
> > > +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> > > +	__TEST_REQUIRE(__vcpu_has_sbi_ext(vcpu, KVM_RISCV_SBI_EXT_PMU),
> > > +				   "SBI PMU not available, skipping test");
> > > +	vm_init_vector_tables(vm);
> > > +	/* Illegal instruction handler is required to verify read access without configuration */
> > > +	vm_install_exception_handler(vm, EXC_INST_ILLEGAL, guest_illegal_exception_handler);
> > 
> > I still don't see where the "verify" part is. The handler doesn't record
> > that it had to handle anything.
> > 
> 
> The objective of the test is to ensure that we get an illegal instruction
> without configuration.

This part I guessed.

> The presence of the registered exception handler is
> sufficient for that.

This part I disagree with. The handler may not be necessary and not run if
we don't get the ILL. Usually when I write tests like these I set a
boolean in the handler and check it after the instruction which should
have sent us there to make sure we did indeed go there.

> 
> The verify part is that the test doesn't end up in a illegal instruction
> exception when you try to access a counter without configuring.
> 
> Let me know if you think we should more verbose comment to explain the
> scenario.
> 

With a boolean the test code will be mostly self documenting, but a short
comment saying why we expect the boolean to be set would be good too.

Thanks,
drew

> 
> > > +
> > > +	vcpu_init_vector_tables(vcpu);
> > > +	run_vcpu(vcpu);
> > > +
> > > +	test_vm_destroy(vm);
> > > +}
> > > +
> > > +static void test_vm_events_test(void *guest_code)
> > > +{
> > > +	struct kvm_vm *vm = NULL;
> > > +	struct kvm_vcpu *vcpu = NULL;
> > > +
> > > +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> > > +	__TEST_REQUIRE(__vcpu_has_sbi_ext(vcpu, KVM_RISCV_SBI_EXT_PMU),
> > > +				   "SBI PMU not available, skipping test");
> > > +	run_vcpu(vcpu);
> > > +
> > > +	test_vm_destroy(vm);
> > > +}
> > > +
> > > +int main(void)
> > > +{
> > > +	test_vm_basic_test(test_pmu_basic_sanity);
> > > +	pr_info("SBI PMU basic test : PASS\n");
> > > +
> > > +	test_vm_events_test(test_pmu_events);
> > > +	pr_info("SBI PMU event verification test : PASS\n");
> > > +
> > > +	return 0;
> > > +}
> > > -- 
> > > 2.34.1
> > > 
> > 
> > Thanks,
> > drew
> 

