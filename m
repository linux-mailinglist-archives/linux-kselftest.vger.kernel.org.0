Return-Path: <linux-kselftest+bounces-7281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18860899D89
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 14:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64A82B24C0D
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 12:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F1B16C870;
	Fri,  5 Apr 2024 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="a8TNQw8f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A593F16C866
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321436; cv=none; b=AucNaP6sCrmTOMUIPZnTiWATdouY2/M2+Trwj2b55DqHc7dDmdAEVghKt6P60GZc6DKhUB1zPi4f8h0UKPVn1Nxpjg+a5ZXAKkK4RrQskqCn64d5Zg84ERDAz7SCQ7P1/IMi4+zI312y1f0PSsehHZ56AYYTuRbJA4Kthfmn/gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321436; c=relaxed/simple;
	bh=Vqv3W2/VCBye3UEJwCHMOm8a0FVjlz+y/cOCepR8BTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOXKM1wgTGFEqcdD9++nPJ+E6bIGYix8hvecPhBND1lzHw09WnTT/84MOZT0PjJjSDyxFlhNhpXcsaf9iw/rEWOWBMVto2G5U9CvKU2PLslXeoDHzdetnuwpTqhDMgcHvW92jV1HYKEwhMkt1VrRLrzQOYZxTNAgr5N1plKkNCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=a8TNQw8f; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a4a393b699fso357384666b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Apr 2024 05:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712321433; x=1712926233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+KZChT2cdzkHkVrpBT1mwN6D5B3F3KpgiaxmMWQvAA=;
        b=a8TNQw8fKNLDEP9/Dl2mGdotjhamMETYCk6tpjPG7zQr2asSHu3ZUEWiYYmDOXHItS
         BIYAGR1pzAgk0OXZ+8hL88hsc9kwpZq8ZbR44IpqKVpcuHezI71wjSQGTKVSSfvcZ90o
         xk5N/VjQ3omwUNnWlcah56qbGg4v5RI0Ot5pNTbapEQ1atBXqYdlcr+BKIRMagYejUIv
         Rs4geJ85pcT36lvH0EP4ODcE+qAwEBv779SGelazVOeqh8njxOUaXpGKsopHt5EqkYnH
         9TDNw30NXtHHIbe7NA/lCfxyeyNILlEjeNzZqOYoY8Kd6wJEBNejRMwJayta5LHomx/h
         4xSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712321433; x=1712926233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+KZChT2cdzkHkVrpBT1mwN6D5B3F3KpgiaxmMWQvAA=;
        b=uhOJ89DvKEYv+fr+26xd6j3pdINhQ9JKla7fWGFMEJNg274JqhTVQV5UHFeRhczt6E
         7HG8dQvRweEYEw5aswHIDX9vHjFa/GRWXWawOt7DyeIP9QAtgtrXTwqCrrnkh63zKMdG
         GbQVhshlVvOvl978CCHU2B9s86gwGsxTsMZbQ5JcHDJ6DI8nVzmERkAuRgCChfEoxBlA
         t+f3Q2jpY9a+Y2G6JmSND+u5EwdcPZmwKTcbbxTBor0bTB2YH3T4qpiY/xLEzdhy4lDI
         t6UgeL2WMU46K5tzwav10l8upC2eFgJtPOdymnVq1Fr85LNZOeOV5SngZoFE6UT6i7KW
         lbqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq9PwbpyHDyxLHmXXbsJZaQX7+IqK0Fy38AYCEZvrSG2WvlZnz1nuSoWrguDTk/4T6k0JACOrOoXiBYppYTXhdkXu9ozEsA3e9wwmQlkt9
X-Gm-Message-State: AOJu0Yz1mGqIuV9mhUMPFCBntzPGaoqlGWGAP6Z8/VVclN+BDse2lm8J
	q4sdLiprGoagvbxJEg/3MheFvm6bK3wlGUTm+q39ezMMI5fgUTDK35+11LhKFkM=
X-Google-Smtp-Source: AGHT+IG6XKFR7iCnTYVsn72OcFsqQ/CO3Rz0ggpBtTVg/0txMW6+hBUP+NpuyuP8ULhm5Cq9UuLdpA==
X-Received: by 2002:a17:907:1711:b0:a51:8a0c:cf39 with SMTP id le17-20020a170907171100b00a518a0ccf39mr1906632ejc.20.1712321432731;
        Fri, 05 Apr 2024 05:50:32 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id jy5-20020a170907762500b00a466af74ef2sm806704ejc.2.2024.04.05.05.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 05:50:32 -0700 (PDT)
Date: Fri, 5 Apr 2024 14:50:31 +0200
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
Message-ID: <20240405-d1a4cb9a441a05a9d2f8b1c8@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-21-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-21-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:49AM -0700, Atish Patra wrote:
...
> +static void test_pmu_basic_sanity(void)
> +{
> +	long out_val = 0;
> +	bool probe;
> +	struct sbiret ret;
> +	int num_counters = 0, i;
> +	union sbi_pmu_ctr_info ctrinfo;
> +
> +	probe = guest_sbi_probe_extension(SBI_EXT_PMU, &out_val);
> +	GUEST_ASSERT(probe && out_val == 1);
> +
> +	num_counters = get_num_counters();
> +
> +	for (i = 0; i < num_counters; i++) {
> +		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_INFO, i,
> +				0, 0, 0, 0, 0);
> +
> +		/* There can be gaps in logical counter indicies*/
> +		if (ret.error)
> +			continue;
> +		GUEST_ASSERT_NE(ret.value, 0);
> +
> +		ctrinfo.value = ret.value;
> +
> +		/**
> +		 * Accesibillity check of hardware and read capability of firmware counters.

Accessibility

> +		 * The spec doesn't mandate any initial value. No need to check any value.
> +		 */
> +		read_counter(i, ctrinfo);
> +	}
> +
> +	GUEST_DONE();
> +}
> +
> +static void run_vcpu(struct kvm_vcpu *vcpu)
> +{
> +	struct ucall uc;
> +
> +	vcpu_run(vcpu);
> +	switch (get_ucall(vcpu, &uc)) {
> +	case UCALL_ABORT:
> +		REPORT_GUEST_ASSERT(uc);
> +		break;
> +	case UCALL_DONE:
> +	case UCALL_SYNC:
> +		break;
> +	default:
> +		TEST_FAIL("Unknown ucall %lu", uc.cmd);
> +		break;
> +	}
> +}
> +
> +void test_vm_destroy(struct kvm_vm *vm)
> +{
> +	memset(ctrinfo_arr, 0, sizeof(union sbi_pmu_ctr_info) * RISCV_MAX_PMU_COUNTERS);
> +	counter_mask_available = 0;
> +	kvm_vm_free(vm);
> +}
> +
> +static void test_vm_basic_test(void *guest_code)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> +	__TEST_REQUIRE(__vcpu_has_sbi_ext(vcpu, KVM_RISCV_SBI_EXT_PMU),
> +				   "SBI PMU not available, skipping test");
> +	vm_init_vector_tables(vm);
> +	/* Illegal instruction handler is required to verify read access without configuration */
> +	vm_install_exception_handler(vm, EXC_INST_ILLEGAL, guest_illegal_exception_handler);

I still don't see where the "verify" part is. The handler doesn't record
that it had to handle anything.

> +
> +	vcpu_init_vector_tables(vcpu);
> +	run_vcpu(vcpu);
> +
> +	test_vm_destroy(vm);
> +}
> +
> +static void test_vm_events_test(void *guest_code)
> +{
> +	struct kvm_vm *vm = NULL;
> +	struct kvm_vcpu *vcpu = NULL;
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> +	__TEST_REQUIRE(__vcpu_has_sbi_ext(vcpu, KVM_RISCV_SBI_EXT_PMU),
> +				   "SBI PMU not available, skipping test");
> +	run_vcpu(vcpu);
> +
> +	test_vm_destroy(vm);
> +}
> +
> +int main(void)
> +{
> +	test_vm_basic_test(test_pmu_basic_sanity);
> +	pr_info("SBI PMU basic test : PASS\n");
> +
> +	test_vm_events_test(test_pmu_events);
> +	pr_info("SBI PMU event verification test : PASS\n");
> +
> +	return 0;
> +}
> -- 
> 2.34.1
>

Thanks,
drew

