Return-Path: <linux-kselftest+bounces-47140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CFECA8CA6
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 19:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 741E83020365
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 18:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E9033FE23;
	Fri,  5 Dec 2025 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zoy5iSaO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8462233FE0D
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764959026; cv=none; b=YbK1u6qU2zbc5TgyUIKoHk1R0i6gWqlrG43mNa06jOThfggYzOvWnEEmu1peLFZz47+DPYza7zjbE4vDnE7PDDGs2DS/dPHG+rjYsSY6uuvDdcNp5GLWSC74pGd+HCQRDJgSYcGkn/ePknqrIHx2DoPCKPOltwoXMrUD71Uw7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764959026; c=relaxed/simple;
	bh=tuSE/NPeIPZv0T1R7ISQkLqsTw60bgooej+WJk2mtkM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KL81P+OmCfFlFAtepeIXbuqdjxjg/eJt+FL2oNtA8wFu/e6E9n45N0wMXHar7BfJPRUOF/0z2mCTadPlOX27aMVyf7GFLNe6tnKG0TUSezeEE7cC1ztAmLRoTull2R/mlbX0LeoefHA4k2fMf69Mj3q2arMKvT9jFjI0lVXKSBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zoy5iSaO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-340c261fb38so3883029a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 10:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764959025; x=1765563825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qTzJ3fFbHNg+Y5ksEzbBY6QMbRGpva8/nn9IicDkFak=;
        b=Zoy5iSaOzhobzMv/XGUi97R2wgBMyKhq7Kji4nHMT++K9ZnOvM7t8KwW6JzZXFZXZe
         iyqGpAZuIZBN/3sZynZb+jGCscwiKJPhIcdfzjImiY6NqgVu26Mj4PUNYYaJ6jibxxgM
         4imF+FEWiGSrK7E/SKyKus7TsyWmOQHZwbGl0Yw66BR94R4vybIcauSAdHKjliF3Y3Im
         ziGah7PpYy4GmnVSUCwvX/A80Qo8FeiwMMCN5a/zNaUt3iDX6XVoJcb7E1vvSHmloKH8
         U2JvQh8/3j75S16L7rap2K9Ag/pSa+Te1YRuhM+O50KyIVgpFIe0Z31XjjWiQN7NdEj4
         XivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764959025; x=1765563825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qTzJ3fFbHNg+Y5ksEzbBY6QMbRGpva8/nn9IicDkFak=;
        b=Yw2ziDzAU6Ykug0jkWlIbIIMrcUDtfOPxlj72ihGu6N8+AnTS6YSPufkqjIw5N7BYW
         vud6S2kL4XkOVhBHoTjX01S0bv0KfPdwm+JXGcQ6BKUOXQZKBmR+ts3u0bEUUNqqpHVt
         2NBlwR/1AWvMtDanJrkPWJlVU+nAh5Fxies58Ce71LSshdFrgtAljEdTU2NMyoab8n3K
         qtX33mp4XTEgJ/lio2ucsg0+TsQMpjgDygS7+TXxshmWEMCjB0KbEHsUHTJQY/rXZnT1
         60vp7aVbrTo/zHv85lSRZTQCph3Z0j3KEeDIC34JyMYnNrbI1wUXralTVukm3MBdV8yL
         I1Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWwb2tZ8udhujLXLMtx/aZXkojTkeo/scJBBp5bK52UN50D2X18JWgf1qZ86htRzB5TmuxvnlUne15Rbk9tfRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaLwmCbt8mTI1gje8cg3EJwOFcHyyB48KNf5nKx4dhHTUpYjH+
	uv7n1YFd6eHY6hEfN9w7yvm6qHi5IDHegcJFyKdMynzREBAm1x71P81AjYz8jyVhu0bdgETQfFe
	F0tAP5w==
X-Google-Smtp-Source: AGHT+IEWVvHa+4kFz5YgRzFoH1A2AZVaqfN0I7i5pY7mC/HauFO0hq0wQRHoYpNTs6SgQ9NngOKkSpA7ZpE=
X-Received: from pjbbo18.prod.google.com ([2002:a17:90b:912:b0:33b:c211:1fa9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b50:b0:340:29a1:1b0c
 with SMTP id 98e67ed59e1d1-349a24cb7e6mr31067a91.7.1764959023910; Fri, 05 Dec
 2025 10:23:43 -0800 (PST)
Date: Fri, 5 Dec 2025 10:23:42 -0800
In-Reply-To: <3c0686934fc33ebb484aa5cc71443a22504df7ca.1757416809.git.houwenlong.hwl@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1757416809.git.houwenlong.hwl@antgroup.com> <3c0686934fc33ebb484aa5cc71443a22504df7ca.1757416809.git.houwenlong.hwl@antgroup.com>
Message-ID: <aTMjLkW2h_FWjfxe@google.com>
Subject: Re: [PATCH 7/7] KVM: selftests: Verify 'BS' bit checking in pending
 debug exception during VM entry
From: Sean Christopherson <seanjc@google.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: kvm@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 10, 2025, Hou Wenlong wrote:
>  #define IRQ_VECTOR 0xAA
>  
> +#define  CAST_TO_RIP(v)  ((unsigned long long)&(v))
> +
>  /* For testing data access debug BP */
>  uint32_t guest_value;
>  
>  extern unsigned char sw_bp, hw_bp, write_data, ss_start, bd_start;
> -extern unsigned char fep_bd_start;
> +extern unsigned char fep_bd_start, fep_sti_start, fep_sti_end;
> +
> +static void guest_db_handler(struct ex_regs *regs)
> +{
> +	static int count;
> +	unsigned long target_rips[2] = {
> +		CAST_TO_RIP(fep_sti_start),
> +		CAST_TO_RIP(fep_sti_end),
> +	};
> +
> +	__GUEST_ASSERT(regs->rip == target_rips[count], "STI: unexpected rip 0x%lx (should be 0x%lx)",
> +		       regs->rip, target_rips[count]);
> +	regs->rflags &= ~X86_EFLAGS_TF;
> +	count++;
> +}
> +
> +static void guest_irq_handler(struct ex_regs *regs)
> +{
> +}
>  
>  static void guest_code(void)
>  {
> @@ -69,13 +89,25 @@ static void guest_code(void)
>  	if (is_forced_emulation_enabled) {
>  		/* DR6.BD test for emulation */
>  		asm volatile(KVM_FEP "fep_bd_start: mov %%dr0, %%rax" : : : "rax");
> +
> +		/* pending debug exceptions for emulation */
> +		asm volatile("pushf\n\t"
> +			     "orq $" __stringify(X86_EFLAGS_TF) ", (%rsp)\n\t"
> +			     "popf\n\t"
> +			     "sti\n\t"
> +			     "fep_sti_start:"
> +			     "cli\n\t"
> +			     "pushf\n\t"
> +			     "orq $" __stringify(X86_EFLAGS_TF) ", (%rsp)\n\t"
> +			     "popf\n\t"
> +			     KVM_FEP "sti\n\t"
> +			     "fep_sti_end:"
> +			     "cli\n\t");
>  	}
>  
>  	GUEST_DONE();
>  }
>  
> -#define  CAST_TO_RIP(v)  ((unsigned long long)&(v))
> -
>  static void vcpu_skip_insn(struct kvm_vcpu *vcpu, int insn_len)
>  {
>  	struct kvm_regs regs;
> @@ -110,6 +142,9 @@ int main(void)
>  	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
>  	run = vcpu->run;
>  
> +	vm_install_exception_handler(vm, DB_VECTOR, guest_db_handler);
> +	vm_install_exception_handler(vm, IRQ_VECTOR, guest_irq_handler);

But the IRQ should never be taken thanks to the CLI in the STI shadow.  I.e.
installing a dummy handler could mask failures, no?

> +
>  	/* Test software BPs - int3 */
>  	memset(&debug, 0, sizeof(debug));
>  	debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP;
> -- 
> 2.31.1
> 

