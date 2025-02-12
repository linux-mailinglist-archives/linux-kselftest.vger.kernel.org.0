Return-Path: <linux-kselftest+bounces-26447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DB3A31C14
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 03:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6FC18824E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 02:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577561CAA80;
	Wed, 12 Feb 2025 02:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XMCQ5w2a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBE42AF1B
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Feb 2025 02:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739327506; cv=none; b=BjEYT4+xR6ly3UlCS4klTE2TSvxRKbQduqHrnAcwz1+15e7wKOEMzWkmF3tZyjTYCY4Bx25t8gI4NKMlfddcapOsuml3cxisr7HggUMxTTCvRyNq1O5UgVK0veT37Wk3ZYVM+MDygsDghMaApDgeCErCQ5r2Og2B6bmHkXtmy7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739327506; c=relaxed/simple;
	bh=/xVLIbnBID19pVlqnJua6JU9LCMU9qjYDj0RqS1xVgc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S/3FfUoIO34mmz/BlL3KUhsPOZBlNtJGLAnM0098v33xCrNrUiaS2+HqTUlimUsedKo1LmLNv0/PLOx6Om/YiBQRzhzrbnJBcsh87yjaBOZZjdEAfLXHGPQ+lH7dGkcVTjA5zAZg65Bs3eb8Dqr+D9qVZuzsvOOAzmJ8DbHer4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XMCQ5w2a; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fa9bfea46aso3986615a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 18:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739327504; x=1739932304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vPRb0IsRdvCLk95iJ9DvUJH0LJh/0xdqXsVtoHsQUsQ=;
        b=XMCQ5w2agmlYv1s0pdi7t182NBsKWVRQWC2FKVwRvkwm3y/AL3HSvSfBaosrMIIivI
         3rZSbBi93tSybljuoxp+P6VId+R47ZiRcmthPecAGnxXijT6ENxJRJt1KpspZE1skV5x
         rapOU6yl/LlVmyAXlH+y/DG+5f823a3U5WTDkONfvU35oZeWOU7Czuxl/36dYnMleOAA
         oe4QbvocdqVYS3quW7FEAE8ukVdj7ULI3J2AXq6jwAuuwj8HiuopMe4W4S1Mqaf5QsO9
         Chix6cRJfc6shn+KepOWopI0bpfY4+WnH3Ovt6ehIbbPgd5rw/FSOiQ0nzcy3XdhhEPb
         k2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739327504; x=1739932304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPRb0IsRdvCLk95iJ9DvUJH0LJh/0xdqXsVtoHsQUsQ=;
        b=OnPy4RwVHyBBF5hVQefJN9oJnwUxW3PgDGbKNtbnOg+MH8TaY4e6az+2FcnqF2/+Sg
         tb4TEvAugnyTxtRi7Fpm6WaHMPo76Kna5eTAVqs+1s8QqdURDPkykZZmyjCQAs44YSnn
         fu9iZa/VlAWfyL4th+ZVvX7+OHVA+P5xfhIyWowqpjtMqLOpjrKYPu7seNt4mG4uHEZU
         gTwsXoAUXHlboK7Inxmm7yIGDLeJ3ZVfdnhhv1m/CLEHqjVl3axXt8SpHyhozjDbMDy5
         Asb6NdPKT7LwgDKjbG5lJo2E19UbWwIHEyiF0A3iH8B2ZTxPobEg5VAflTDKyU3+LdNm
         0A4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQFOeasDWz2iVAF3neQen8g3NUg0vUPJTwm6bieb2L61yzyZVnejiseKdklYw/mOGsR5BpbRe/sd5SU8HDt3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlqV+63nLdB0PgF3MKbh7yM4OpK8eprx5U+fbm/Hpz12MIAUuZ
	QoabpsWj9KvatPxjFYu82j6B6wfKFYk4blhxXb9iQFxYNLdCsA0lJdEwYfWa06f9gGLuafLBw17
	4uQ==
X-Google-Smtp-Source: AGHT+IGMX9u7M35FXglCi8he7YjOChUI+hVwPKDefN8wt50qF3YlUo1gLTN02dl5lpemjD008hcqqNreu6U=
X-Received: from pjbpw18.prod.google.com ([2002:a17:90b:2792:b0:2ee:4b69:50e1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:dfcd:b0:2ee:863e:9ffc
 with SMTP id 98e67ed59e1d1-2fbf5c237demr2067501a91.21.1739327504064; Tue, 11
 Feb 2025 18:31:44 -0800 (PST)
Date: Tue, 11 Feb 2025 18:31:42 -0800
In-Reply-To: <20250203223205.36121-10-prsampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203223205.36121-1-prsampat@amd.com> <20250203223205.36121-10-prsampat@amd.com>
Message-ID: <Z6wIDsbjt2ZaiX0I@google.com>
Subject: Re: [PATCH v6 9/9] KVM: selftests: Add a basic SEV-SNP smoke test
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
> @@ -217,5 +244,20 @@ int main(int argc, char *argv[])
>  		}
>  	}
>  
> +	if (kvm_cpu_has(X86_FEATURE_SEV_SNP)) {
> +		uint64_t snp_policy = snp_default_policy();
> +
> +		test_snp(snp_policy);
> +		/* Test minimum firmware level */
> +		test_snp(snp_policy | SNP_FW_VER_MAJOR(SNP_MIN_API_MAJOR) |
> +			SNP_FW_VER_MINOR(SNP_MIN_API_MINOR));

Ah, this is where the firmware policy stuff is used.  Refresh me, can userspace
request _any_ major/minor as the min, and expect failure if the version isn't
supported?  If so, the test should iterate over the major/minor combinations that
are guaranteed to fail.  And if userspace can query the supported minor/major,
the test should iterate over all the happy versions too. 

Unless there's nothing interesting to test, I would move the major/minor stuff to
a separate patch.

> +
> +		test_snp_shutdown(snp_policy);
> +
> +		if (kvm_has_cap(KVM_CAP_XCRS) &&
> +		    (xgetbv(0) & kvm_cpu_supported_xcr0() & xf_mask) == xf_mask)
> +			test_sync_vmsa_snp(snp_policy);

This is all copy+paste from SEV-ES tests, minus SEV_POLICY_NO_DBG.  There's gotta
be a way to dedup this code.

Something like this?

static void needs_a_better_name(uint32_t type, uint64_t policy)
{
	const u64 xf_mask = XFEATURE_MASK_X87_AVX;

	test_sev(guest_sev_code, policy | SEV_POLICY_NO_DBG);
	test_sev(guest_sev_code, policy);

	if (type == KVM_X86_SEV_VM)
		return;

	test_sev_shutdown(policy);

	if (kvm_has_cap(KVM_CAP_XCRS) &&
	    (xgetbv(0) & kvm_cpu_supported_xcr0() & xf_mask) == xf_mask) {
		test_sync_vmsa(policy);
		test_sync_vmsa(policy | SEV_POLICY_NO_DBG);
	}
}

int main(int argc, char *argv[])
{
	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));

	needs_a_better_name(KVM_X86_SEV_VM, 0);

	if (kvm_cpu_has(X86_FEATURE_SEV_ES))
		needs_a_better_name(KVM_X86_SEV_ES_VM, 0);

	if (kvm_cpu_has(X86_FEATURE_SEV_SNP))
		needs_a_better_name(KVM_X86_SEV_SNP_VM, 0);

	return 0;
}

