Return-Path: <linux-kselftest+bounces-38711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E16B2168E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 22:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ACC616E94E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 20:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D652DECA5;
	Mon, 11 Aug 2025 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="msI8tNLj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC892DA75A
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 20:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754944529; cv=none; b=oY9M5i+zV4WuOuDitdR1c8EECi/2Cv8HnmGPzo9v3ZRV9f97GnD36OGwkT7lqoDXE1Tc4IF9y3659km/AmW/OUGGLA4OVMaDzSUVrMk2ijxNUpF0kJo9BIot3w53REe3ft17vez8iIK9/ycZAmejrYR91ekG9jdc0WjRMB2+Xt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754944529; c=relaxed/simple;
	bh=QpDf+elt9M9TKmobx1BaTq9lS4qdM3lH4ej26Ym52hk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lBxTWO06ZrsVsKYNmh97cvCCOXJ+st6i/lsL+Z5ZbBargrPgWpZhj1OpghK+h5o7aRtyYMyY8h5K04rF2RL4ueMo/6fJ+ZWepHFB0AxNwVUvgS9vNp2i2UNOnr3zY5R2vjPOd9lMoGOShHliRj70rCg5VjNbJZG/kmG+6VhZse0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=msI8tNLj; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-321a3669ba4so2413646a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 13:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754944527; x=1755549327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vTpJfMamSKiMcyAgK8UySPyjbjczetycEUO9ZouvYAA=;
        b=msI8tNLjcyFy4VHG60oFhYnyavOX3RcwRuANNxCrroYviZnOY1WHUvuca+TeVt/fpq
         4i1G+dxq/Sf30EKKYjSvGN+ctttaf9nNUc82mOXFnO+N1BVYTcEm5Tq5lGStc5ySU+DV
         sQvKyRXNqfG2RZ6MZuufxOzYvAwCibMNIhYIIuahmbeJyJwjY9Nt9JM5MBxK0TxHXrKi
         byNL/jwDyownPUwMj0p4D6F7gPjJpUR9nYDZLU2OoiQNV0JmPvbbUWR9N1CAfuq/DXLj
         c+QQqroiOU/ylxQa1IccPv7zXbBJcPD32fnmislMgTrJa/Q7lzJctgtfUHhZ5puM4Cwb
         uRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754944527; x=1755549327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTpJfMamSKiMcyAgK8UySPyjbjczetycEUO9ZouvYAA=;
        b=baIwRzmpJRMTxMTD18/Jl6t9U7AP8nqZaQUB/+BRI5Ajk6UY03RmnrciHGnf3+VOvf
         wChhTO1/iSt23WtWfe7A5MggSuO1WJQqjpLBuiUU3VXpTIWnw8oBacNgxjTsy04s/G5p
         1oscDfFcUtIzSi34fUoXODy2ORuCDLwS7mbuWQudKYb9g/9ZEPgmS0ltrK+xQfF1C6yb
         MWidHjFC1cHmjQxSgGhDx55PnkqPD7dZz0xArjs67MxKS9Qx6/j2rGA+8+A92eSdCVkD
         l2ZN0IZJIqiYYv7vDLoST6/+X1znIh8px+EUq2RIciCeH6rudurdtrKSYeeoavztI4EB
         Zd6A==
X-Gm-Message-State: AOJu0YzpRR0IA0Kbnhoc3htsteQ1vj874WOB0MPymgs9w+ZSN+JuBPOd
	j6OvVhlTHp0ScoXu0l+xiWdI0Kro4mJKBhDyrQPa4bppErBaSWDmHKcofsiH6ibmtC81Qsb8ZMm
	8tQ0VKw==
X-Google-Smtp-Source: AGHT+IHyhaALMr5XuJoOSrDVhdZmcQWkFVvTH6tfqb1JQAjECOzXqhG5Gursizm3hnRl2+Uz1FQ4pdr6quY=
X-Received: from pjbph15.prod.google.com ([2002:a17:90b:3bcf:b0:321:b92a:7a39])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:540d:b0:311:ea13:2e70
 with SMTP id 98e67ed59e1d1-321839f1159mr19783183a91.14.1754944527061; Mon, 11
 Aug 2025 13:35:27 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:35:25 -0700
In-Reply-To: <20250807201628.1185915-22-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <20250807201628.1185915-22-sagis@google.com>
Message-ID: <aJpUDS4PSgLK8A16@google.com>
Subject: Re: [PATCH v8 21/30] KVM: selftests: TDX: Verify the behavior when
 host consumes a TD private memory
From: Sean Christopherson <seanjc@google.com>
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 07, 2025, Sagi Shahar wrote:
> +void verify_host_reading_private_mem(void)
> +{
> +	uint64_t second_host_read;
> +	uint64_t first_host_read;
> +	struct kvm_vcpu *vcpu;
> +	vm_vaddr_t test_page;
> +	uint64_t *host_virt;
> +	struct kvm_vm *vm;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +	vcpu = td_vcpu_add(vm, 0, guest_host_read_priv_mem);
> +
> +	test_page = vm_vaddr_alloc_page(vm);
> +	TEST_ASSERT(test_page < BIT_ULL(32),
> +		    "Test address should fit in 32 bits so it can be sent to the guest");
> +
> +	host_virt = addr_gva2hva(vm, test_page);
> +	TEST_ASSERT(host_virt,
> +		    "Guest address not found in guest memory regions\n");
> +
> +	tdx_test_host_read_private_mem_addr = test_page;
> +	sync_global_to_guest(vm, tdx_test_host_read_private_mem_addr);
> +
> +	td_finalize(vm);
> +
> +	printf("Verifying host's behavior when reading TD private memory:\n");
> +
> +	tdx_run(vcpu);
> +	tdx_test_assert_io(vcpu, TDX_HOST_READ_PRIVATE_MEM_PORT_TEST,
> +			   4, PORT_WRITE);
> +	printf("\t ... Guest's variable contains 0xABCD\n");

Don't use bare printf() for what is effectively debug info.
> +
> +	/* Host reads guest's variable. */
> +	first_host_read = *host_virt;
> +	printf("\t ... Host's read attempt value: %lu\n", first_host_read);
> +
> +	/* Guest updates variable and host rereads it. */
> +	tdx_run(vcpu);
> +	printf("\t ... Guest's variable updated to 0xFEDC\n");
> +
> +	second_host_read = *host_virt;
> +	printf("\t ... Host's second read attempt value: %lu\n",
> +	       second_host_read);
> +
> +	TEST_ASSERT(first_host_read == second_host_read,
> +		    "Host did not read a fixed pattern\n");
> +
> +	printf("\t ... Fixed pattern was returned to the host\n");
> +
> +	kvm_vm_free(vm);
> +	printf("\t ... PASSED\n");
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	ksft_print_header();
> @@ -966,7 +1045,7 @@ int main(int argc, char **argv)
>  	if (!is_tdx_enabled())
>  		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
>  
> -	ksft_set_plan(13);
> +	ksft_set_plan(14);
>  	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
>  			 "verify_td_lifecycle\n");

This _really_ feels like it wants to be a first mover for using fixtures and
test suites: https://lore.kernel.org/all/ZjUwqEXPA5QVItyX@google.com

>  	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
> @@ -993,6 +1072,8 @@ int main(int argc, char **argv)
>  			 "verify_mmio_writes\n");
>  	ksft_test_result(!run_in_new_process(&verify_td_cpuid_tdcall),
>  			 "verify_td_cpuid_tdcall\n");
> +	ksft_test_result(!run_in_new_process(&verify_host_reading_private_mem),
> +			 "verify_host_reading_private_mem\n");
>  
>  	ksft_finished();
>  	return 0;
> -- 
> 2.51.0.rc0.155.g4a0f42376b-goog
> 

