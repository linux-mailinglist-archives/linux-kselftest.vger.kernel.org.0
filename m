Return-Path: <linux-kselftest+bounces-39340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E33B2CF9E
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 01:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7967624CFC
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 23:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398C2253F39;
	Tue, 19 Aug 2025 23:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="riWNlU7C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53641E492D
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 23:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645148; cv=none; b=VdBxnWQ2gEhE2af6vfvlIzu4Hg/ZnY+Awa7kyw3KL8MCjRUbju6jIUpgSQYE37thebQTwyeRQXHAv8aHGN0yfV1QDva8LQ4SVo3Suqd5CInPkZ9l8B/D1gE1BmGgiWjrgwikfPuM8Nitzhw8CChlt+JMBgNoyBT5njT6fIAgFFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645148; c=relaxed/simple;
	bh=v2vX/cnMmP2ZmwIYBg7JQT2n8UsblFCE1UC3UDa+6zo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aMjP/KrHrvz+vU3gOUFfKx+j1lyLzGyIInrluGzRvDmbb8vQIq40mZraSHtnitqd8vNIFzi2+sgqJuTeWaw4x78CjjxqigX1hw7MvBFw1PEM7/RMQCVOb592gBgqUGBu1VmuKYYoZRFolF3RWsbjU8lTB7yPgkcdMoULp/0PnA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=riWNlU7C; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326e2506aso5472300a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 16:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755645146; x=1756249946; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pS3XTdqqM+qHyeEmmcCU7Ef1sxc6Ffnow7aIi0ltObw=;
        b=riWNlU7CkSYQA/5w8dUD3pH6tJjhTcwVEvkB4vM6ubS8VX3o3aH65jQzt8qZLtwvV2
         NAqakryFQHSpTJG+idUNkOb7S9jiCnDbie6kDy8aZap5+X96w7WEWSBEpXzKQPsdLn2N
         W/qOYrEIbUDWmNrFnm3DAJopKeFvmJidYPogkXpCZ88H6oUdejP7+AK8S3tdkKiY5dht
         fK4C0YcrRxHy/qr/+o6s394sbb7QI2xfUdLiEnPGFovVqcWgZN2+wN4tBMciWj6hZ2rg
         nMu9kelPpt0UJ2vs6OU3IRIYx7G0LekvXEFbaLOv0KhJjRSdXP0tG1n5iiCkZx19ULis
         X6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755645146; x=1756249946;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pS3XTdqqM+qHyeEmmcCU7Ef1sxc6Ffnow7aIi0ltObw=;
        b=nQeYeezQowZvSQiTc1jD624jRMnFZo7x92qO/X6GoR5YRNV7rjonc6hhZD5D/Spw87
         N596OYJzoiZ5k8yJHYGTPXhTR/wRpkAec8ZNWvoEXG3ybAPdmw1fZ+Z2utHbm/LwBvVK
         KR1KejCzi/xDZ7RzoYIywr/JYs2xDuep1GC7JeH+M970l3NFcEzzPglFRlKoiKunXSVg
         vVNyN0S1TOe+hTJiQyW39YmEgdI3Z49iTLGCcEhleTqhov0rYuGZ+xWKeA9FIBYGSuNN
         VhtvELSRs9wQXj/V1AYJXwnD4BoRN7iK6LSLTOPdpICVgZ0jf3lE/zeDhYJfvfkGeMRh
         lN0w==
X-Gm-Message-State: AOJu0YyCeYP8Dv/YjFKLJI1nnPVB29hbY/fjaKcZ08Q0o3HB42cNseQP
	y3UJdjsgL5xbZSxThnUkZU/DFYZKptpMn+Q9LScJqYYZzAZKlfce3SLnyweWBhGIZbv3BVbfYza
	+KXb7Vg==
X-Google-Smtp-Source: AGHT+IFmm3oxrqfPZ/tov0nsrjCsmOf23ZhirNJbODV6rD1jV29iPklcYCinde3523/OPAfLgSpC/Od15DE=
X-Received: from pjyp4.prod.google.com ([2002:a17:90a:e704:b0:321:6924:af9a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:380f:b0:313:dcf4:37bc
 with SMTP id 98e67ed59e1d1-324e1488b06mr977568a91.34.1755645146126; Tue, 19
 Aug 2025 16:12:26 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:11:47 -0700
In-Reply-To: <20250624231930.583689-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250624231930.583689-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <175555274676.2809352.2693071242682617234.b4-ty@google.com>
Subject: Re: [PATCH] selftests: harness: Rework is_signed_type() to avoid
 collision with overflow.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 24 Jun 2025 16:19:30 -0700, Sean Christopherson wrote:
> Rename is_signed_type() to is_signed_var() to avoid colliding with a macro
> of the same name defined by linux/overflow.h.  Note, overflow.h's version
> takes a type as the input, whereas the harness's version takes a variable!
> 
> This fixes warnings (and presumably potential test failures) in tests
> that utilize the selftests harness and happen to (indirectly) include
> overflow.h.
> 
> [...]

Applied to kvm-x86 fixes, as this is still a big thorn in my side.

[1/1] selftests: harness: Rework is_signed_type() to avoid collision with overflow.h
      https://github.com/kvm-x86/linux/commit/40d5b2ab0d72

--
https://github.com/kvm-x86/linux/tree/next

