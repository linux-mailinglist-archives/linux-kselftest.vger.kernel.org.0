Return-Path: <linux-kselftest+bounces-47139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2070CA8BDA
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 19:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACABB3003F5A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 18:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A4233C197;
	Fri,  5 Dec 2025 18:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XLBpPpEI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709E82D5A14
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 18:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764958888; cv=none; b=pqZVJdg6bCpwMvpnNvZaNDXnTudVzlN15AwR7RgI+oJUC261vhBcJJv88rvdRmZ1o3X42LV+keD2qmgz4BzbCT6i6KFJnfAY6mrQz5+O4DMLoQuXd+THXwkNQp/oTzlzN7TiXJrJFcGqQTO2xyeR+aaNFWtmEUelLaFkaAaUBAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764958888; c=relaxed/simple;
	bh=4a8JkxLdhMJAiX5cx1bbbFMd8E5J3O+4fAZgYGQd0JY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XTKpJFln2fDsCu70MLPQRFruTy6lflBNFZxpaPgwrm5ERh4N0seA3Bga9Fg+m2kfFip9p379ZLPKo7ZHt5xiHnRtbtnvOGiiETI66S4yKBxvnL5YGiWfvi8eSWbv9gdp2NUHVO+PoAT3KKhdgfXHlyZ5eUR06cHlKmxA4k94eDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XLBpPpEI; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2958a134514so34598245ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 10:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764958887; x=1765563687; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/cNFXgo905eYC3nYyEkSmG7vpBPZLh6kRrJTYSXmJ+I=;
        b=XLBpPpEIP106+oVvXRh+MT8xpoITkvLS3Z7F69xfjnodg0BNUEa9K3qVXnpijmpAjp
         Gnd8fDop0fnBXjSm7nt/RgauvOchJV1kQxbntKdueFOZJm6AkpjJypDbqNwXx9ks7Qp4
         VZ2gghFZN+gOy4jVX1yI0VBB7qmPMAgrRlEyAVaes0WlKWAoEjDueN4JkV8+1RdodtTV
         3stoADwwSmIUrv6k4JDFqGaEKhsi6eVJetrkOlKaBcoPmDMSEjXJpNNM/GmZI2THK/dW
         NQ+EISXMpqA+9Hb554TVC6n49SMPraqttBzbnUFkWyYEwEDwS99Tjy3ip6/zrLZlhuQr
         +sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764958887; x=1765563687;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/cNFXgo905eYC3nYyEkSmG7vpBPZLh6kRrJTYSXmJ+I=;
        b=FL/Feio80FeJqH33goHUMuDOLotqjc3PQ91hrRKmMFBxgsf0dYHpinZjFXpzXiIJ9A
         dfM3IaYO/0ro83d+9q0C73hZupCNyPaFuHE/l0osBYi4xaMH9stU0UjHEwMpKp/WNzrt
         CHRwhGDPVU19FCDbjh0BlTS7F/2Dlj+EftBkXGtW0jLMqI2EOb2VpNSjR1c/TT4+Xn3k
         R/azENIP6w5F+8NCVU93wXA5j9LWue+1Vu0ViOTjxFXfm9FTx7zWgKEXPrN6xe/0pDWd
         hPavAzazWpls4ZuXFXP1w22hKF/QnhbvbbIVPuz/iOyanw6SB0aRxAw01Lv1FZc6Nd6G
         OHwg==
X-Forwarded-Encrypted: i=1; AJvYcCUptDSlw5+JQTAVhiH6KLb/aN88WTAo0f67Ni6xJ/djYp//MdRgpq74qFWb7SKtfox4I8fCZtIg43ouFk87EsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuStuxBv35wymtU633XzDvS1hB2n+8JikHKpDTCFGNAlcBk4la
	VIgv9nbVWPLekK2bKyKq7Kb44rzKpb1gopJfIAYCW0ink3gFoA4ZuNC2n8CeOt+1nNsISWlfW4j
	3QDLK6g==
X-Google-Smtp-Source: AGHT+IEddK7PEBaCSNDNEBvqCUdC5OzDCMcmzqUVh8L8uH1O/tNClhC2R2sZba38ZA4PUKkAO+0nZsPKRGI=
X-Received: from plda5.prod.google.com ([2002:a17:902:ee85:b0:297:f35b:e211])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:938c:b0:35f:68d:430e
 with SMTP id adf61e73a8af0-36617ea8ee7mr228352637.9.1764958886631; Fri, 05
 Dec 2025 10:21:26 -0800 (PST)
Date: Fri, 5 Dec 2025 10:21:24 -0800
In-Reply-To: <0fc4f9d4aa0b1ed41cdeea1788d1d8907326d9b4.1757416809.git.houwenlong.hwl@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1757416809.git.houwenlong.hwl@antgroup.com> <0fc4f9d4aa0b1ed41cdeea1788d1d8907326d9b4.1757416809.git.houwenlong.hwl@antgroup.com>
Message-ID: <aTMipH-_x4WQVzSL@google.com>
Subject: Re: [PATCH 6/7] KVM: selftests: Verify guest debug DR7.GD checking
 during instruction emulation
From: Sean Christopherson <seanjc@google.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: kvm@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 10, 2025, Hou Wenlong wrote:
> Similar to the global disable test case in x86's debug_regs test, use
> 'KVM_FEP' to trigger instruction emulation in order to verify the guest
> debug DR7.GD checking during instruction emulation.
> 
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> ---
>  tools/testing/selftests/kvm/x86/debug_regs.c | 25 +++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86/debug_regs.c b/tools/testing/selftests/kvm/x86/debug_regs.c
> index 2d814c1d1dc4..ba80b77c2869 100644
> --- a/tools/testing/selftests/kvm/x86/debug_regs.c
> +++ b/tools/testing/selftests/kvm/x86/debug_regs.c
> @@ -19,6 +19,7 @@
>  uint32_t guest_value;
>  
>  extern unsigned char sw_bp, hw_bp, write_data, ss_start, bd_start;
> +extern unsigned char fep_bd_start;
>  
>  static void guest_code(void)
>  {
> @@ -64,6 +65,12 @@ static void guest_code(void)
>  
>  	/* DR6.BD test */
>  	asm volatile("bd_start: mov %%dr0, %%rax" : : : "rax");
> +
> +	if (is_forced_emulation_enabled) {
> +		/* DR6.BD test for emulation */

Put the comment above the if-statement, that way there's no need for curly braces.
Or just drop it entirely; unless the comments more verbose, I don't think it adds
much value.

> +		asm volatile(KVM_FEP "fep_bd_start: mov %%dr0, %%rax" : : : "rax");
> +	}
> +
>  	GUEST_DONE();
>  }
>  
> @@ -185,7 +192,7 @@ int main(void)
>  			    target_dr6);
>  	}
>  
> -	/* Finally test global disable */
> +	/* test global disable */
>  	memset(&debug, 0, sizeof(debug));
>  	debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_HW_BP;
>  	debug.arch.debugreg[7] = 0x400 | DR7_GD;
> @@ -202,6 +209,22 @@ int main(void)
>  			    run->debug.arch.pc, target_rip, run->debug.arch.dr6,
>  			    target_dr6);
>  
> +	/* test global disable in emulation */
> +	if (is_forced_emulation_enabled) {
> +		/* Skip the 3-bytes "mov dr0" */
> +		vcpu_skip_insn(vcpu, 3);
> +		vcpu_run(vcpu);
> +		TEST_ASSERT(run->exit_reason == KVM_EXIT_DEBUG &&
> +			    run->debug.arch.exception == DB_VECTOR &&
> +			    run->debug.arch.pc == CAST_TO_RIP(fep_bd_start) &&
> +			    run->debug.arch.dr6 == target_dr6,
> +			    "DR7.GD: exit %d exception %d rip 0x%llx "
> +			    "(should be 0x%llx) dr6 0x%llx (should be 0x%llx)",
> +			    run->exit_reason, run->debug.arch.exception,
> +			    run->debug.arch.pc, target_rip, run->debug.arch.dr6,
> +			    target_dr6);
> +	}
> +
>  	/* Disable all debug controls, run to the end */
>  	memset(&debug, 0, sizeof(debug));
>  	vcpu_guest_debug_set(vcpu, &debug);
> -- 
> 2.31.1
> 

