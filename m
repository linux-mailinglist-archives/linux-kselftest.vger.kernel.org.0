Return-Path: <linux-kselftest+bounces-33411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61626ABE116
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 18:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8481885F4B
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 16:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF14272E75;
	Tue, 20 May 2025 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ld+qggO7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228162701B6
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747759711; cv=none; b=V0hrvYm7lXcpfE6aLd/3P7ojRJIAMdgbSlTXw8OLNEqKrEhrwLGgzU/8LyX+iBop3OBqKlHqJ5apAhbcNyU3zUf5A4/Ndb1KqBlCKeWTwemWEfygHhgN5R9akzx3CgTHSF1X6S5oxBUtnU7ePQJ8T19QTsb0+c6KT748Z3oBPIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747759711; c=relaxed/simple;
	bh=KlV0RXmqKpJ77CyyCsB0Wo5O3FyVrt7eDZrhGXiZPok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RrVHmPFqisaHnq+sGIMze9flbiHGKwCx+O6f4lwNXvEcKJlP7pdYpTaS12t0ykRjBCKlH4DYSjAUaj88Su9Y8WSjFKECB36XiPExr+4K5bhDxKUAmhJxy9GOv+7gSs+xDtM5wRg3OeSs9deHmKqIogMam9Ge1QD6YrKeYcd1X8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ld+qggO7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30a59538b17so5317901a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 09:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747759709; x=1748364509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KuJYydDReX9RTl05bbdXTXs3Odmmz9RsQYChmIkMKX8=;
        b=ld+qggO7zrvfVgzUjwUWUm05Ba+/1u05BO5SrY7ZMAtt+3eXXv6/x62NiTqaRggIOI
         FViM+a2VIZhMrWy/nhZ6N2XjRzRyJbe0f3Ks29crwYDZZ1WmEoDZO0kJmYRVQoafukR4
         dFb/lySmEOD3PPWNiD+kxUqL3P9P/HZ7Pucq0qdyHsET9j/bjz5lJWMWb/PDOHXA5EHQ
         Ikf5rWpMHBw0D7G7dER15/IKjUdJhBbfrxr8in8Z+/mVGgB943synN359wAGQy4kk5jA
         HAaSt/y1OE1fn/Vj2hx4jFayT01i8SDDgn8SsOxN4xhfYpzkjD+9MFqqxtRBBUKS0Rrv
         WXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747759709; x=1748364509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KuJYydDReX9RTl05bbdXTXs3Odmmz9RsQYChmIkMKX8=;
        b=gvjU8cEUZ52sdwBdHADgxrBwdoiAAbiuWgXHeibnUB0khMhdxH62FAfJFDhVYug4Ta
         lg+JSmXQuXpASY51L0LnuKhF7R6aMJ/DoIHq+YRaubEhNcqER9WG22cVEP2coh0uTtWk
         r8ih8HvMo1IvQh0iB2JMEddK6ArrnFogsRkeUOQaOHwZ+90QjzqBNzUZMO9eCr8AEyAQ
         AA45/851P1YZ3OZ12pBMj6zneFs20EMeu/zeExh/rdxG+UeuPLGOhtMIgB08XB057eKW
         zdPag5blMGRzlWg2kAi5fpV2PAbDDpcdcGLtl4/h9/lBnMuA8l6Bcnloja/ufUe2tmnu
         bhSw==
X-Forwarded-Encrypted: i=1; AJvYcCUzmFqqeieUZMIbbbzpCE2SFm0v9ZFKu4vQdi11Z8XT6VhzGY1al8JhCIMVlV61chUsRfV90EhD4+tFC4xJcZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU4Sxg1cfUEaRFIo/qGMee7O/dNvS1uP1A4w/dbEYjUqm/HNzg
	yF0FJPvOWJt7bWOi/hsY8a/xcMzrhDYHF4cbqKwrr2wf6qfRJRU+q0NyISgnk0/6FtaboJC019L
	1p8typA==
X-Google-Smtp-Source: AGHT+IEGFK1iHgjNql7Jg32erSL4VFEPnjrseOMCWC27oDhyRo6xkoj3Gu6mn3PMHwbhO+N/ywLOodNSFGQ=
X-Received: from pjbpl16.prod.google.com ([2002:a17:90b:2690:b0:30e:7003:7604])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3846:b0:2ff:6788:cc67
 with SMTP id 98e67ed59e1d1-30e7d5ceeb4mr22007339a91.34.1747759709435; Tue, 20
 May 2025 09:48:29 -0700 (PDT)
Date: Tue, 20 May 2025 09:48:08 -0700
In-Reply-To: <20250502050346.14274-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250502050346.14274-1-manali.shukla@amd.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <174742194085.2506614.18155306395568716918.b4-ty@google.com>
Subject: Re: [PATCH v5 0/5] Add support for the Bus Lock Threshold
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Manali Shukla <manali.shukla@amd.com>
Cc: pbonzini@redhat.com, nikunj@amd.com, bp@alien8.de
Content-Type: text/plain; charset="utf-8"

On Fri, 02 May 2025 05:03:41 +0000, Manali Shukla wrote:
> Misbehaving guests can cause bus locks to degrade the performance of
> a system. Non-WB (write-back) and misaligned locked RMW (read-modify-write)
> instructions are referred to as "bus locks" and require system wide
> synchronization among all processors to guarantee the atomicity. The bus
> locks can impose notable performance penalties for all processors within
> the system.
> 
> [...]

Applied to kvm-x86 svm, with a heavily modified test, and the comment typo fix
for patch 4.

[1/5] KVM: x86: Make kvm_pio_request.linear_rip a common field for user exits
      https://github.com/kvm-x86/linux/commit/e9628b011bbd
[2/5] x86/cpufeatures: Add CPUID feature bit for the Bus Lock Threshold
      https://github.com/kvm-x86/linux/commit/faad6645e112
[3/5] KVM: SVM: Add architectural definitions/assets for Bus Lock Threshold
      https://github.com/kvm-x86/linux/commit/827547bc3a2a
[4/5] KVM: SVM: Add support for KVM_CAP_X86_BUS_LOCK_EXIT on SVM CPUs
      https://github.com/kvm-x86/linux/commit/89f9edf4c69d
[5/5] KVM: selftests: Add test to verify KVM_CAP_X86_BUS_LOCK_EXIT
      https://github.com/kvm-x86/linux/commit/72df72e1c6dd

--
https://github.com/kvm-x86/linux/tree/next

