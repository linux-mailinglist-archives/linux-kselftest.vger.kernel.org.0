Return-Path: <linux-kselftest+bounces-23568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F649F72CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 03:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9894218909DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 02:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E687786327;
	Thu, 19 Dec 2024 02:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWbCxTAY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB9378F34
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 02:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734576131; cv=none; b=ukaMnyTA7MTtXt3XUhdIVsh5R0pf6Uw07ytyqC5wLEV3hkjBqXZB9SNnOmB9dn7FNmGcrPcsFlzOmUzrBL+WYT4pqsYbGOLmUgDPnZV6hwM425b0GSvlC9Uuc/xaYiaxghCMfMJfOYNpnX6TjtNyGs248J9XAR3Gt+N1P0pPX/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734576131; c=relaxed/simple;
	bh=+0YB1wnZO+N4Mgt+2ULmShqZq3rw6HcIFLVbUH2eZuw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a0ecpZFYmDR4BZj8ReIWVW1L4rtgGv3mI23/mY3u+YExOXZBCSkvA0xDwvP7oTaO3VnxPOHb8WehEAUr6tY57VeZOIRfhgdEFOndG3FJIUtOXg1rlUfNtVA7tm3tFUcKSDAKAgEkgdKsSqOCo9QRcpRm4ElQ5eyIe2O7kArgxXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YWbCxTAY; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef9e4c5343so449355a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 18:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734576129; x=1735180929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m0Cubv7YLSSEZBcbcu/q09glZ18XxGHJ6dVd9FcHtzc=;
        b=YWbCxTAYzCw3rL0VtmJprR2WLwkCsLQS/+LIa/g9XDenXlJIn3Za7I/i9r8eWT9PL7
         dUvOWIoAUkZkPEWEDaXPVV9yKlwyD11VB20AnU9Isde704rZgBJVOCYofEeFqkq+gukk
         RVs6Jrbb91XMR0fP1EhxKc9rqV5wJad8daZhhO8BW5tQyqal3LR1H2v2H2DNDyeJmAw+
         XTZZe3LzRwlD1i7Iud9HpTxKn0PS7L/M6fD2boj9w7rGIqzIS9Q/LxkWgmWN1EphAFJZ
         1yNVDu9yInr6z2jpu2NM8gbnX1/MyEW6GupHk1Dikf3kirISp2QYx99Jnom/aScoEGO2
         QtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734576129; x=1735180929;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m0Cubv7YLSSEZBcbcu/q09glZ18XxGHJ6dVd9FcHtzc=;
        b=aeODKaN1LpMz91Uovmchm1lOXi85sJ6klFuK9NDtlR2NanW4RK5IHzf7Xohhzqp5pU
         KCGJtBHXtHd6zvCjF1SC3Cra6CHHuiCISSLzhLLY3AUaZxztEwdOg8xDHZkuZLdyzYIF
         WJ1182OFgLqtZ2Vq+4DS+jTFgmMervR36S/3ahT6qWxWvRdUpCyllAqJNSDFbatNox4r
         mjLmJa+Nr11fHmSdt2iJTRRMx9FLErn8kO9MPcYay14A7+CzrvW1Jy4iNg6KXyaSLGVD
         1aTDytB1s5IzncOfHBiGFWYOiVnAb+ozuKxaNOngPx4XjTs3V+yppOD8ec77Iq/Qlg1z
         ZvkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFT/FEKIubAETZEr5GRnkvra5M8Ff/cCezuspXbD3aUMZq5apafDeptGxw+9ypgjTRF5kcWnat3i5ed7X1Nd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5FV5v0Pnlw4CBivaR5XhUBWHsjm74ogmecVOPDJOh/YXM97A5
	iIDefwPSm/MjiuGixyLOm6iV9KpdvTRKfgp+tCEYv+cTmlQw9I3jhhI28r8kTXPUTAvKQXndD5k
	+ww==
X-Google-Smtp-Source: AGHT+IEnYzmbvfGN7/B6ViEtGfWEw0anaTCEutqaOfeDitWi6EveqXP0+98dhgD6pETsbyq/KQ5AnaRCuh4=
X-Received: from pjbso12.prod.google.com ([2002:a17:90b:1f8c:b0:2ef:85ba:108f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d648:b0:2ee:9b2c:3253
 with SMTP id 98e67ed59e1d1-2f443d45292mr2198688a91.30.1734576128828; Wed, 18
 Dec 2024 18:42:08 -0800 (PST)
Date: Wed, 18 Dec 2024 18:40:46 -0800
In-Reply-To: <20241217181458.68690-1-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241217181458.68690-1-iorlov@amazon.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <173457555486.3295983.11848882309599168611.b4-ty@google.com>
Subject: Re: [PATCH v3 0/7] Enhance event delivery error handling
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, bp@alien8.de, dave.hansen@linux.intel.com, 
	mingo@redhat.com, pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, 
	Ivan Orlov <iorlov@amazon.com>
Cc: hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, dwmw@amazon.co.uk, 
	pdurrant@amazon.co.uk, jalliste@amazon.co.uk
Content-Type: text/plain; charset="utf-8"

On Tue, 17 Dec 2024 18:14:51 +0000, Ivan Orlov wrote:
> Currently, the unhandleable vectoring (e.g. when guest accesses MMIO
> during vectoring) is handled differently on VMX and SVM: on VMX KVM
> returns internal error, when SVM goes into infinite loop trying to
> deliver an event again and again.
> 
> This patch series eliminates this difference by returning a KVM internal
> error when KVM can't emulate during vectoring for both VMX and SVM.
> 
> [...]

Applied to kvm-x86 misc, thanks!  If you get a chance, please double check that
I didn't fat-finger anything.

[1/7] KVM: x86: Add function for vectoring error generation
      https://github.com/kvm-x86/linux/commit/11c98fa07a79
[2/7] KVM: x86: Add emulation status for unhandleable vectoring
      https://github.com/kvm-x86/linux/commit/5c9cfc486636
[3/7] KVM: x86: Unprotect & retry before unhandleable vectoring check
      https://github.com/kvm-x86/linux/commit/704fc6021b9e
[4/7] KVM: VMX: Handle vectoring error in check_emulate_instruction
      https://github.com/kvm-x86/linux/commit/47ef3ef843c0
[5/7] KVM: SVM: Handle vectoring error in check_emulate_instruction
      https://github.com/kvm-x86/linux/commit/7bd7ff99110a
[6/7] selftests: KVM: extract lidt into helper function
      https://github.com/kvm-x86/linux/commit/4e9427aeb957
[7/7] selftests: KVM: Add test case for MMIO during vectoring
      https://github.com/kvm-x86/linux/commit/62e41f6b4f36

--
https://github.com/kvm-x86/linux/tree/next

