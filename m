Return-Path: <linux-kselftest+bounces-9080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 412268B6452
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 23:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726A01C2213B
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 21:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5C717F376;
	Mon, 29 Apr 2024 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ar9O67WY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8080A17BB3E
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 21:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714424596; cv=none; b=iW6LcTYXrHAg61zQ1y+0PW3XyT2IhJX4CmMfp8K8kLuBiOObiZ+SBtkspnGAOwCdHk1YBUvvJryAKvlJGu01kGCloRnPlj9gpEqeGDGgVXmvwgdUyLtQgK3dYaVnPciA4+anZodHeHnIVkBpRq+sFVuzOM9l6V5UM6qqDhMJ8iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714424596; c=relaxed/simple;
	bh=JeyP8cn4XaLMo9uWQpa8hkNSVNY6YUTuJio+Ip9OTe0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qMG8pRSSI/58Q5MLXZHBmnZQSWOJkguNyi/fVkUTOw7Ft7frBWDwziBWJnp/YWjS+LgSLasvLfakeLVOmw4KvW/z5x2mIWQYYDSrlSZ8M6PKtCGX6D1xvY/yazX5j8T4Ger6urAtKZ5K14q8LyUu58/eS0JfQI2qkR/Es5BwwnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ar9O67WY; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b2738ce656so155038a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 14:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714424595; x=1715029395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FKzm6kyuYISrLzvb3bWjOOWCaxpGt4qDUIOJyhcwL9Y=;
        b=Ar9O67WYJtmHiQcgrQgnBVHLA8mj5PKeyTwMexBGlEK5MV0zLQu2LrmhmZYxsFAHsc
         3nlyqPJdqDvmzJ4E/dwfuzgn8OoVLDyPFPWtr9EzQNiMuhNZiCeLgkk8puGsA63mpqvr
         qJ/iJaGEXp62/jxWsN6rycp0smiewcK1NEwK7OvJds5Jv97yOBw1DqD0oFaisJzsk7x8
         l7eXEvDhlpjb2kSffXzSJTN4i/z4RLX4BBH22XVJi3ZS8OeJ8jgNQ4bJZexuxqxYVdS9
         /CJ5O1HcNBO6/kS8B+CUzztZFdWnRTEUiJCvejhpnZ7h0o0pwZEL5D2APgijLrBE6lK6
         1yVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714424595; x=1715029395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKzm6kyuYISrLzvb3bWjOOWCaxpGt4qDUIOJyhcwL9Y=;
        b=ZiDGyJAy4TPWvP9ZUWGgp5CGVXA6vnqB9Fzo7YtQLbVdlWZa6/FnITLMvY3teylY02
         39ba7gg0qZhymNi/LkSndBBF+R+vxVdLJsaxRexSJKT7HU05vIoD3GEMWC3wxR7CLP/2
         AXga+7YHfdwb6p4rAmSKqlKaS4Jx3grIgscgnov4r2lCsKUoADxcXhSoin3sv6cX7l3z
         yajdYx3Yl4HQ9EGVNeOqARRZLftvxMopkb09e5Qunn7FreXOYG1n/TJnRhvNL6sfJG2v
         cHD0BCjpGZ5BxkPpNjENLF7tpu3d5qrZ5hPldlR0LRB+QExDma7DmJAUI5n7kd4g1ViE
         WQeg==
X-Forwarded-Encrypted: i=1; AJvYcCXbz0BM2N4raWddvhec5majjsq6RAspBZjf7hegVqPFnC15lU2Ocu42BYlKHZvqbXblUklejWGc5e4r5oersOJpZIwMzy40kb5j3CBrBOzK
X-Gm-Message-State: AOJu0Yzku6icUoYrVZiizvIWd6AEgwEIcTEk7Lu9vSbt5IdsSGuKM1cD
	DC39gNXIm6riL4zwTrY9f5ie2suehNeSQiG+HyX5c+8xTQz/6UDlnXu0O3YiJP6E9O2DaJDtC6v
	DhA==
X-Google-Smtp-Source: AGHT+IHPfYFTKFUMgRh/oKItKHonLuzFkQ6T1IrvmIEXH7s0Z5XPc7nJpOEKbPthWhRMiFtjpCLqdnBnkes=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c58d:b0:2b0:e2cf:1187 with SMTP id
 l13-20020a17090ac58d00b002b0e2cf1187mr21017pjt.4.1714424594907; Mon, 29 Apr
 2024 14:03:14 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:45:29 -0700
In-Reply-To: <20240411210237.34646-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240411210237.34646-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <171441840313.71030.14991866054241895716.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Make monitor_mwait require MONITOR/MWAIT feature
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, linux-kselftest@vger.kernel.org, 
	Zide Chen <zide.chen@intel.com>
Cc: pbonzini@redhat.com
Content-Type: text/plain; charset="utf-8"

On Thu, 11 Apr 2024 14:02:37 -0700, Zide Chen wrote:
> If this feature is not supported or is disabled by IA32_MISC_ENABLE on
> the host, executing MONITOR or MWAIT instruction from the guest doesn't
> cause monitor/mwait VM exits, but a #UD.
> 
> So, we need to skip this test if CPUID.01H:ECX[3] is cleared.
> 
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Make monitor_mwait require MONITOR/MWAIT feature
      https://github.com/kvm-x86/linux/commit/72cd4de01d8b

--
https://github.com/kvm-x86/linux/tree/next

