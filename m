Return-Path: <linux-kselftest+bounces-48780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BC2D1477F
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 18:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D3C73039AC6
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 17:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588BC37E31D;
	Mon, 12 Jan 2026 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UkbZAQgT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA00A30EF62
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239663; cv=none; b=ZHJZ/tUemB+VrBJfqq3BwaJTXmI7LjNndXvdHHnPEIi5Hd03GOxabAq73T5bcN1a6VG9iaLGgUXMoWJyxR1K9l/smaUgILPuHjc8NDjuQPoR1X1TFndKhyzcIxXkhG0jxNkH6B86tAQ2OI8oNYiozykqOCWHC29HlINJ00ul5/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239663; c=relaxed/simple;
	bh=i6y/xW8JZjpTrRKnZ13Y6DixUs9nnjzLnsnXAENI5T4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XGMnu6o8owi1t/i0he2yuYatNX6EHibCDxuiEki+R1cN84LDNF9+G4cMs6KBfdPzLnCHtwQXQmg1RgbpU7M9tU6sUto7Hs4yo5zxntKq8k25ri50W1JsaxwenDcd5ttcINsxGLHq+nWrTtYaXEaVlaYxjF+9a5AVvjTWgvuHLwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UkbZAQgT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34c6e05af6fso6832786a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 09:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768239660; x=1768844460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9qaWJfkCMEyAoUQAzN2rDC87xL97AfctNGKLRuM2/oE=;
        b=UkbZAQgTZgMv3AER864AW0BPC7n5leuFz7/bfaltj15C1a1TYgDghhP0Z3cfxmWbxU
         QuignJw02vPRWSYG87k5DzrBprqHmTd1wp5vWgnkB9A0wrbQqn4HLmUpmo0smXxSq5PO
         5b3nMsX1eI9ObXDprjvGssTfbQv8LQ5JsVt8WTcTw52eanZ9Oi3i4oJqcfDyYaQNKq9Q
         zbmctKMEiZdHOM4JOzdB0JSNrDKRneYeZ/RWa3IUBKgMPhcc/+gFhm5pLaJ5cPPIAipE
         2Ry0p1k+dCpWhVhLcaTP6d6cSv5Hz8wQeTFvx4dJii5N3IzfjKTYkRVvu0bfpqUbYQwF
         bd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768239660; x=1768844460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qaWJfkCMEyAoUQAzN2rDC87xL97AfctNGKLRuM2/oE=;
        b=Qg3L0KbRLZ99Ag7Fas7N0uwHZK1yaHuzIUCnJDSeqwGUQ9tGRATwPlcScUjQ4vTZ5t
         nwOBFnf9cdFnJY6WQCsXI0IuuNSmD/h8EhMSNgaRL9k3rlAnfG/cmcMSY8r7DwPQjaxi
         iSi+1MMGxZFSx2j4vDAZY6so/m6V8e4e/oodDEh8mdJe8UQHMkgeoJAIPBDAUuie0jcW
         pN8LrTJB2QaDjRWLHWwXBwK9A2j6Jv9U3CN/58RzjUI95N/6K/s18pSF6CAF/e4hISev
         9O8Wts3JYPsKbSaQ41SCchzNe6tGzVyCIcSpxcPVelKhFGzSHA39OvTvt2V8NyWH6kuN
         QdEw==
X-Forwarded-Encrypted: i=1; AJvYcCUiVfieIKMi0DRrBQnSYZwXBvxSa5GLfc7qRoclb2M70DVeV9J2lsaMJ9MxOJVl4i1g8biM/hhdtu9krgnmLsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUnv+M3DpSt55KhpPnaPCq/aRkW0HVP477roLSg9GF5+hv1mCl
	lA3zRC5G50snGYCIIkbWqUX99ujpje+0shYpix5PpVsiiWz8mq4QlvKMOWHEE1nyY/76j6PNxNX
	YSIhodg==
X-Google-Smtp-Source: AGHT+IFLp/98pk5R3YNhnGDED198MYUha3D/aQztds2iS2t8rz4tXHTf+NF/DVDaNwMXAHSOi2PDVAUlEPc=
X-Received: from pjbdt6.prod.google.com ([2002:a17:90a:fa46:b0:340:bd8e:458f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5287:b0:34a:8c77:d37b
 with SMTP id 98e67ed59e1d1-34f68c502a3mr18857238a91.16.1768239660360; Mon, 12
 Jan 2026 09:41:00 -0800 (PST)
Date: Mon, 12 Jan 2026 09:38:48 -0800
In-Reply-To: <20251222174207.107331-1-mj@pooladkhay.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251222174207.107331-1-mj@pooladkhay.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <176823878891.1368899.400639654569804512.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: selftests: Fix sign extension bug in get_desc64_base()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, 
	MJ Pooladkhay <mj@pooladkhay.com>
Cc: shuah@kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 22 Dec 2025 17:42:07 +0000, MJ Pooladkhay wrote:
> The function get_desc64_base() performs a series of bitwise left shifts on
> fields of various sizes. More specifically, when performing '<< 24' on
> 'desc->base2' (which is a u8), 'base2' is promoted to a signed integer
> before shifting.
> 
> In a scenario where base2 >= 0x80, the shift places a 1 into bit 31,
> causing the 32-bit intermediate value to become negative. When this
> result is cast to uint64_t or ORed into the return value, sign extension
> occurs, corrupting the upper 32 bits of the address (base3).
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Fix sign extension bug in get_desc64_base()
      https://github.com/kvm-x86/linux/commit/7fe9f5366bd5

--
https://github.com/kvm-x86/linux/tree/next

