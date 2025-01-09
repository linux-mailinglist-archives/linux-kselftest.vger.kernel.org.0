Return-Path: <linux-kselftest+bounces-24163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD22A080E0
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 20:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A2C1658C4
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 19:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EA71FE463;
	Thu,  9 Jan 2025 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K7WuMsnN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577971FCFF1
	for <linux-kselftest@vger.kernel.org>; Thu,  9 Jan 2025 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736452290; cv=none; b=ac2auXDapEh/iE5d1ZZbecNVgs+egKi92isRmabBeXeu4HgMIb2NXATImzR2X25IDztkYFDOvbNNrpTKMu/rc/L93kZB08BvcvN/GsAIm++sD5r4EpK78KYdhE1gYLzrUZZgzkRWea4MU0jjWMy4gs8LC7Y7ZHpi/3tDviR9mFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736452290; c=relaxed/simple;
	bh=MvkEk3gSSDbS3zZPJLdX95x01W/tyUYM4PAuF5w5OC4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S1KNYbLUpMUT3JpV+n//NVjHFl25XTbPRI47xDRJW++kAqqi6Nx+TxvIyfFlEYpzggGZq5mVTUVh48QkbDRahcrjnuSDyRNdUYcFMsM9+lPtz5BW4fIGTDyGkULlc249ptVcp5ntJvRyrVBNeUGxM+kUvITf1rz/3Z8OCfnFiPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K7WuMsnN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2efc3292021so3294012a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Jan 2025 11:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736452288; x=1737057088; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=57Etux7AEN5TmMsdcxvDpSx5a9gpJFGTs6viFVCrUcc=;
        b=K7WuMsnNJDompEqbNA1fa5RXPm2utyRb6SIEfLr/+bNREHk9zA7VqnM2TvUhUp+2Xi
         7jtSrhOVWl/ef6boCENrXSL8e28+CQcwgCvSkXi7/RTeA+uaDdgzNfEPFs/EMP2PKpK9
         RCsFd9Zov14BXFtQNoyyGrt+W5tf7nZeUMN7Gb84b7pa6JkBEYb0kZfkEsJTq0SWy12E
         OZvjeLxOrWrcCDv8dvr6jogr8yZ4dF/DfxsJruQAYIcwUFQoIz11n29FFdbmT9w8HtlP
         jCyGJ/wHMhPGncGEotRusscwxK/zqxvhuXj/PzpsQakeu5neFuVHrFJ0QXFHPt4TaiTM
         XPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736452288; x=1737057088;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57Etux7AEN5TmMsdcxvDpSx5a9gpJFGTs6viFVCrUcc=;
        b=wM+R6WghiFm1xLP+XsG/NaQxRaXHVDZ9gVy40pCkBEkElUaF+VljdcNI03l8oc9gt9
         1tXV8exi3qq+rkpSK5bcvjn5Kxg0Q651rNweZfWXDkuo6Sr7lwodAy4nQSy+Rr09He4K
         bvjjtK0Bxb/VSbnfhB5Pw3lPSFs6EPf8aKkPy2Ggf7OuSNSTMQjj2gfaNfzF2/pzsZuX
         lCQ6jg3IMZmMS9YEBSEjMf+skfsALeJVmx4PtyhVnzOyEtz3H7et02Z7kMXACg4TKzJf
         fMokfwunuHTE2x6AgswTYGSpg89CZNtWHKWMT4kKUcyUlS0IsvZIxnTPcczXChLjXQx+
         jIEA==
X-Forwarded-Encrypted: i=1; AJvYcCV4TnOCoibNiiKKR4O7cWlCOCG/Up0jT8flaoMEf345brbPRQbmn3mOyHmCK0iz11TPyLUofFD6/EyQz66PzJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkxT2GRWGDYOx7yChPIEHx0VeMFk9hrzADjFcWq2/WeZUT/JVv
	V6/NKxQShbdm7XAiU+P1tvfZwWqD9qlAJuGA/LJpESt6Si28MlHSPfnYBHBsPgUd/6kFGpUYUmc
	I2A==
X-Google-Smtp-Source: AGHT+IFHDTy4w76td90IJzNaC3o+z6gkD1eeZgoEcbJclu/ja9AI/IqxAF+xDqx17F3s6er+xWr0fh4cKz0=
X-Received: from pjc11.prod.google.com ([2002:a17:90b:2f4b:b0:2da:5868:311c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c88f:b0:2f4:434d:c7ed
 with SMTP id 98e67ed59e1d1-2f548f34ee2mr12933623a91.16.1736452288677; Thu, 09
 Jan 2025 11:51:28 -0800 (PST)
Date: Thu,  9 Jan 2025 11:47:25 -0800
In-Reply-To: <20241219221034.903927-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241219221034.903927-1-mlevitsk@redhat.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <173645201741.890420.7594833670950629627.b4-ty@google.com>
Subject: Re: [PATCH v2 0/2] KVM: x86: read the PML log in the same order it
 was written
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kselftest@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 19 Dec 2024 17:10:32 -0500, Maxim Levitsky wrote:
> Reverse the order in which
> the PML log is read to align more closely to the hardware. It should
> not affect regular users of the dirty logging but it fixes a unit test
> specific assumption in the dirty_log_test dirty-ring mode.
> 
> Best regards,
>        Maxim Levitsky
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/2] KVM: VMX: refactor PML terminology
      https://github.com/kvm-x86/linux/commit/ae81ce936ff9
[2/2] KVM: VMX: read the PML log in the same order as it was written
      https://github.com/kvm-x86/linux/commit/37c3ddfe5238

--
https://github.com/kvm-x86/linux/tree/next

