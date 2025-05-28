Return-Path: <linux-kselftest+bounces-33926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D088AC66D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 12:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A293B13C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 10:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4519214A9E;
	Wed, 28 May 2025 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pJPFUHQE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F088C214229
	for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748427503; cv=none; b=IFZj66mEBLzUJub7zjQQ+HjHBh9/s6YeGaMONWn5DQzb0FupLBz1PfQY7HxK/0jePoNjfzB53BlKns2bOUVSbzIFGd8820Dcy7OfZM4ljZWrd4P9zGarsXs1DaS5soMFCQ2rhS68znG4LjFFcOR2nE9X2nf+E8EvpZVxYG/RkTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748427503; c=relaxed/simple;
	bh=A0xb8zh27S93Eetp8e9L6f77n+tEtjFUeeIM8YlkTkI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qGjZAmFbZJHQSc8ScM3Lb1aGLrsVNP7x5ItBgbiqQMWfMPLgqlIz3e1gU6KO4YGhgMcwqbsEJDgbwhWfRgmVQ1pq8fcBL4RYV/wdvb+mYfqkahGpsY2wlpDvSkLQ0B7xiXNFfUq0Ph4iiBBaY9Q3Atx+qSQ5n+qD90avJ7Erj+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pJPFUHQE; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-450cb8f8b1bso1031275e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 03:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748427500; x=1749032300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8NINXg8J4QmaW8sPWc6e+ws47cGsufUBr4Yz5V/EO6s=;
        b=pJPFUHQEn3WIBV0/p3yjBolM7DbIugyFbQA9a5cPBLSH2NwW6ttsXd7NThCtu057NZ
         lDiMBTTPK4faNbNOQ7pzXXU7jS+SVWag9YMfmJeopLaQZO2kCw87Cy9clLy+kejdYNgh
         X9ZFGBh8us/U2QMmhVJ5hOm/wj+r1BFdGMoRFxZyKuSsRT8lmZKV/sdyFlrg7lmpOfmZ
         WiIJtdIrCendbCOOsgIePtrhuQf/hhjpkYL3m65gGK2E4fmawODsw6TDhVbfRFLB6T7r
         Zjwiuej5wLEx0kqq0XSNWj3K5vftEIrutiVx9eYvIpWpNZiOe5fmjGsuBchqs4IsnFlq
         m2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748427500; x=1749032300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8NINXg8J4QmaW8sPWc6e+ws47cGsufUBr4Yz5V/EO6s=;
        b=U2XLpJrDqXVRFP+9t2CdTjfKi/6+ajJwrnVH4FQDwi96vQnqZ/ry90Imq6bA7sfIqW
         em150tVyIKbi86y9kXcHuN32ZECNg6eDxBRoZXFjwTECiCfAVs/sa6zxoiNlzGLf9YsW
         vLTbb7wfrflpzmhTd/8ac58dRg6Ce0SyiSyUuqke3fO5OPBAdLu5VWOV8Ue8p4TLvGaX
         EKce+/xTkNvWQgJxc8omcz7U2lliLMfmjPVMcn7QLBbJy4mL/YohoPevsq75jt5qY0qX
         ecQqiaFkgxgssF+mRV4ijRhxp7QiC9ghyjYk02okZFXU7EU8m7VPy28rrvuxnlt2VVSD
         m93w==
X-Forwarded-Encrypted: i=1; AJvYcCUX6R9hh6TRCAZGbNhXEhvVJLYZJtLEIYspjqKkZGyslUKciAlUgks2ni1UQp+0Ude64MRDFOsk760IvgVwJ9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQwpqozq99SBNueIGEUs3Y9XKkmoIQzMgWBzHGirVyVQN3Xl6S
	qW4Ky613ZQn+NnANrMHZfqF1OYEwLizLlawaJfLQ1FV2OBMyprLvYnea3p3IepNkd4UUTYqNpPQ
	pdLzOZ5XKR2yPLTi8Hg==
X-Google-Smtp-Source: AGHT+IG9PGBM2TysjUwYmOEWzK8Ty36GnkdiP9d5JzUPAfuLhTCZs5RZuwULClsLB26imfDnECTaA8g9RXT0RAo=
X-Received: from wmsp39.prod.google.com ([2002:a05:600c:1da7:b0:442:ddf8:99dc])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e25:b0:43d:db5:7af8 with SMTP id 5b1f17b1804b1-44c92a547bbmr142010215e9.21.1748427500382;
 Wed, 28 May 2025 03:18:20 -0700 (PDT)
Date: Wed, 28 May 2025 10:18:18 +0000
In-Reply-To: <20250527-idiomatic-match-slice-v1-1-34b0b1d1d58c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250527-idiomatic-match-slice-v1-1-34b0b1d1d58c@gmail.com>
Message-ID: <aDbi6i9xWWRHaBGb@google.com>
Subject: Re: [PATCH] rust: replace length checks with match
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, May 27, 2025 at 12:09:36PM -0400, Tamir Duberstein wrote:
> Use a match expression with slice patterns instead of length checks and
> indexing. The result is more idiomatic, which is a better example for
> future Rust code authors.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

