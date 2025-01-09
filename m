Return-Path: <linux-kselftest+bounces-24160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D00A080C1
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 20:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63CB8188C246
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 19:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B371D5AAC;
	Thu,  9 Jan 2025 19:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJ/G8WBP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ABA1369A8
	for <linux-kselftest@vger.kernel.org>; Thu,  9 Jan 2025 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736452089; cv=none; b=bLR01s0FDJ7gh2rCH5cj9n5oa3/tUVL7ZZ6r9bZSa7Tf22xAfUEKdRjQyjSTHrFyOjEUbADM+YQTbMFb6UJs6f2wwyt1QFAJKRnWoewtPzN1UxZaL75+uRX/lnDtzldXIm8705bPipYb1ufa20b1pz8Kn+oxjPpK+FZk9Dn/xGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736452089; c=relaxed/simple;
	bh=9oXz7eNeGbveESkmF9yrda7YeYxpiiir+vwUJjOgpZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NslvuxwRoejbyzFVPn3way7loXBVo/ZWGoHNMD0q5Xuat27Qp/2/dW86hjEfplJQdSHI558knVEnlthuHdpPSDElxGoJcSqDAe1rfWa4FDQ8o6XO8hxnZ6NcsyZHNQXrjZZN7L0KWjIwOCQbrvcAMEnxrZePFpAFk6bGCBO6afQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WJ/G8WBP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef79d9c692so3289128a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Jan 2025 11:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736452088; x=1737056888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ioFLEvIQ3l2mrG5QyAprCujKthc9WsXf5JYkZUGRwr4=;
        b=WJ/G8WBPIebAUxWyt+4t17NXcdAIOT76VGlM4W3tVo97gh7UVPZRl/KVIj3/nLX4J4
         jlleu0NZnorip+fpLKLBPaadchlKCyXoEVDB2p+i3nWOv5BvC3+Uht79f7iOW4IQ2UbH
         6N5nanXzmep/8b3356bcC0yiezgDFIAZYYELlePUEGdEbKUIyJrFYppTUV3HF8HKxzqN
         1rJ7aV+AnuXySI3WjbXodEoDBAfgqlO5yIGGmYYe2Mr2jNpNiGm87PFsNdih9M3VnGB3
         Z62uz/epehcwIkVIJhTmUEkEuOp5LRw2MKQNieepc/JZICgVm9K2jJXWZHkrrDdaEwtg
         T/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736452088; x=1737056888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ioFLEvIQ3l2mrG5QyAprCujKthc9WsXf5JYkZUGRwr4=;
        b=pOdAzf0fJSZr/x7iy9sF+3twoouQcs936PDo5n+kWo7bqQgeBvb8gho8wBotT7EceP
         hdkxhG68pwlKrp2WyjgXUMnTFBRH+QeE991NqJqOfMVBfVMAyfeZRVyXVsJsfdpYTbS/
         grFbz/YOB9/DB1uu3cqhzdFZHvoxEU/Kzhn+hXd53uwowfpE4qQDv6IQfhJIRqXNsBlt
         stJQIALbY0376bJ2eKrurTQM58irpfYlmuxjJU/X12sTdCoPqhSCRr2OZgIJyHTQkhIJ
         VwbKYOepp+ToJCet9KUZGfLUJFWGWkBgz+/x9Omiy8Od422ciIKEu8ymqFVOPFbV0SLY
         ap5w==
X-Forwarded-Encrypted: i=1; AJvYcCVruPA61qIHlPuKlomHqNUFKnYQAC5jiqE5htmjOmlK5KlbpNA9XsuHxQkAGOTjtfE4pCFPgroWXDJla3UdHh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyShgUQ1w2euyi+omRNA57JFUPBeZYmmeMcEHlxzUyjq5L3fQIP
	i5j9BxeO1w/hd9PpxOUlFIqX9BSIS4ATmniuC8wkjVgItH4z1GWA2R1KlJ9xdKhIHLOIYrgErp+
	53Q==
X-Google-Smtp-Source: AGHT+IEd6fPtUqOmLIFErIg79PiIK5Ek8YRAIMNBoDdQl6kKMsPbTLRjJCSKEEwcQMrDs/N3knvGrLDfTw8=
X-Received: from pjbov12.prod.google.com ([2002:a17:90b:258c:b0:2ea:5c73:542c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2747:b0:2f2:a664:df1a
 with SMTP id 98e67ed59e1d1-2f548e9c9bcmr12165669a91.2.1736452087892; Thu, 09
 Jan 2025 11:48:07 -0800 (PST)
Date: Thu,  9 Jan 2025 11:47:07 -0800
In-Reply-To: <20240918205319.3517569-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240918205319.3517569-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <173645110935.884997.7060671564225875763.b4-ty@google.com>
Subject: Re: [PATCH v2 0/6] Extend pmu_counters_test to AMD CPUs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Cc: Mingwei Zhang <mizhang@google.com>, Jinrong Liang <ljr.kernel@gmail.com>, 
	Jim Mattson <jmattson@google.com>, Aaron Lewis <aaronlewis@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 18 Sep 2024 20:53:13 +0000, Colton Lewis wrote:
> Extend pmu_counters_test to AMD CPUs.
> 
> As the AMD PMU is quite different from Intel with different events and
> feature sets, this series introduces a new code path to test it,
> specifically focusing on the core counters including the
> PerfCtrExtCore and PerfMonV2 features. Northbridge counters and cache
> counters exist, but are not as important and can be deferred to a
> later series.
> 
> [...]

Applied 1 and a modified version of 2 to kvm-x86 selftests, thanks!

[1/6] KVM: x86: selftests: Fix typos in macro variable use
      https://github.com/kvm-x86/linux/commit/97d0d1655ea8
[2/6] KVM: x86: selftests: Define AMD PMU CPUID leaves
      https://github.com/kvm-x86/linux/commit/c76a92382805

--
https://github.com/kvm-x86/linux/tree/next

