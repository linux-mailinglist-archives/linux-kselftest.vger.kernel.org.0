Return-Path: <linux-kselftest+bounces-11808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8E4905F74
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 01:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24021C210D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 23:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4BD12D74B;
	Wed, 12 Jun 2024 23:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jirNIJYY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CB712D209
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718236533; cv=none; b=BoQhWBPvv4ls/nlpz4dDvoF4QRJVYFXqlb2FD8tWUO/1WB5q4IQRGkrnCmLpcQfEQrAfwim1ZeTcrKfMGpOx3hdBUmpYOVyqNG3B0qmCJDhjRrTMcf1v8smVxjfjHsOaqK44ws/vb48t/9xWXUjeKfMeseR+R2U70GsSp50yxDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718236533; c=relaxed/simple;
	bh=UExzSWlT64SRTujuwraGmriH1bXzmArZy7Cn25txElQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZFVu8fwNXorLr0DExRBaXJifhLUP0XBHcUWf4aGlg8Y+F/Idny0NlZt0colVmS6EzfKLee4MYhq/h1ishpQNNl51EV8bhbgkFKwywnzNAnPicBsyUpt5cPpwAPPIHKgMgz10uryKwvuwa5zckEs+/1h1ZL9EHIDVIT+ZYwpWbK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jirNIJYY; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7042d4c7a21so285960b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 16:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718236532; x=1718841332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LbtqKKQm97BowZds9B5adCnW1KnZQCMsmfiIrci+y0c=;
        b=jirNIJYYKuHlN88ExgvTAXbzBT5huFy4GJFP0i7P5OP3701PKraGKtdsuHi9tq17uf
         rP4p+tjbRQFk2Pg7HYiyJoX34ie/ja4NbmDtp3jLVx1kAWhpgr0A080Ag86uERFnlpKd
         qNvnLn31puwbxsPh+KrOKJzAjMWAlNk5X2tdrmXlR9qNgtQL/kW7BBVHH/GGo1y+/wrh
         xwcPD0v+o1fijW9uK5iv3DQowwruNhsD5VP8JXpwv/azfaDoBREB3I6APEnpRhl8yKDJ
         pFaOL+Ta1zAArMnSzNup/eDXuynXsJ7li2kB9fNk7+o2ErtdnZHqqY/m/yMzjGAgn4hw
         /oVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718236532; x=1718841332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbtqKKQm97BowZds9B5adCnW1KnZQCMsmfiIrci+y0c=;
        b=Pc6BYcCKSFx19s8TciSAoqxPmj14jyvAzo/vdo+v6Krlf32Odg9zzuRXwIV8rjBkZc
         ctsIABgNy7MER8ZfnqYGbU+pb3NC+p5tZh8VlsxYY3JfVbvsmQTMzFjYzxg6jmhUqHnS
         UZtQghDIP6SFoP+Uh54eo88kC4Iu3MuN7FH00XEn322drDHmKDk2YFydl70qKZHQdHu/
         nYYjOkLXwG51iW0LvuwrrAroeiFSHOi1E84Q6a7LF8eqbLMjKeN1yULuT7ycoDtCNRxJ
         mk2GmQdr18yR4VqG2IyzwL2KWzYeSdYWW+z5as3rZ1HoT+hrVZuVXhtNepbcfSiXcuMY
         RKXw==
X-Forwarded-Encrypted: i=1; AJvYcCV3bf+XpxfqrYLnSG7LRCKD4ScWaVQOMiRXzZoHwzTgF+kK0UGznORBhIizGm6BUNvUkWRzDxDaFxQE4GlrBz/ARYueFILjfGgHcd7jZuMd
X-Gm-Message-State: AOJu0YzLAKHCJMMVf2Z+jDXJWBLCaid98kyReos9q6HrJOxVpCvZij+R
	fv+sBicv8Rnjmt/oK+3gfjGPNV9jIlTCFSmhvuWzNSIKvy/Okn5R7RpsWY84xADWuT2XVIFdLP7
	qgg==
X-Google-Smtp-Source: AGHT+IGuecHJt0nHiXhJJYQkDb8/xV2VtUD4kUhO0uw0vw6n+UwkxLnb8lI0ADIZLteFZY80tW1W5/H7pvs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2d0f:b0:704:1a73:d008 with SMTP id
 d2e1a72fcca58-705bcddfb7emr13011b3a.1.1718236531660; Wed, 12 Jun 2024
 16:55:31 -0700 (PDT)
Date: Wed, 12 Jun 2024 16:55:30 -0700
In-Reply-To: <ZjC1QpnyQA0gHoo4@chao-email>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-16-xin3.li@intel.com>
 <ZjC1QpnyQA0gHoo4@chao-email>
Message-ID: <Zmo1cqTgJwfDL0kW@google.com>
Subject: Re: [PATCH v2 15/25] KVM: VMX: Dump FRED context in dump_vmcs()
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Xin Li <xin3.li@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	Ravi V Shankar <ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 30, 2024, Chao Gao wrote:
> On Thu, Feb 08, 2024 at 01:26:35AM +0800, Xin Li wrote:
> >@@ -6449,6 +6451,19 @@ void dump_vmcs(struct kvm_vcpu *vcpu)
> >        vmx_dump_sel("LDTR:", GUEST_LDTR_SELECTOR);
> >        vmx_dump_dtsel("IDTR:", GUEST_IDTR_LIMIT);
> >        vmx_dump_sel("TR:  ", GUEST_TR_SELECTOR);
> >+#ifdef CONFIG_X86_64
> >+       if (kvm_is_fred_enabled(vcpu)) {
> 
> FRED MSRs are accessible even if CR4.FRED isn't set and #ifdef is ugly, I think
> you can simply do:
> 
> 	if (vmentry_ctrl & VM_ENTRY_LOAD_IA32_FRED)
> 
> just like below handling for EFER/PAT etc.

+1

