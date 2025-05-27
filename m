Return-Path: <linux-kselftest+bounces-33869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E59AC51E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 17:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B29B1BA24ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 15:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AC227AC41;
	Tue, 27 May 2025 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7N/JIhY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA1827AC26;
	Tue, 27 May 2025 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748359361; cv=none; b=rDdWZepUyujb9099HzQshxGKw9pfTSXP9/4CvpHGGSvAWzaNzyAYj1CoPfuoORUb29vMx3OGcAz1GpudwZMLl0dEeQh8qvXVz8TXIf+nZMb43+dwuhXt848TJfXR82xlPcJwQVWJ0Btsn6wIcKKH/F8WcCXPWrTIuF4RDTsgR88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748359361; c=relaxed/simple;
	bh=xFVApp8xTfR/YzA8SQhWfU8t8lZcJsWBKVg3yZcwNbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6R9o3Ae/5jBTiBmxSoog3sWc4V+39RZ7Hxu3Nuil6nWIX1Sq+LWt5YEkbpzAH1Jej0QhWYobxlm7nTBS6QdKCL0emtEtHMWCpM3MbgfmlAelg2FF03yrQq42s0SwN5NANIf8103POKyrxWdFaKb6KWAggZtRKdJbw+FdBzYNNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7N/JIhY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-231f39b1b7aso3129135ad.2;
        Tue, 27 May 2025 08:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748359359; x=1748964159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFVApp8xTfR/YzA8SQhWfU8t8lZcJsWBKVg3yZcwNbM=;
        b=K7N/JIhYLLWF74Do7LKeHsBnGzqpN3J7lcH87N1ppBqlfNNASyb30ulTIbYX2vvSo+
         cp/NHezpMp3qGVg/sC0D4uSCuBM0t+1yFY5YImM2ooYHJg+YxQfk9TbxWE5RzHBN5YiV
         pyTPY0c8c53V8h+C8q36aicBiAi0pxdzOqgItnrfYoLzN7JaKrjHQybbqxIK68GPdG8z
         EY0nghCu/oN81w1QyZX2kfNDDoK8k0xjRYjqsxONj3dK2xVaoIo5sotxHow8sMuIvq12
         jEMWgRM0nKJrCZfXWFwtH760PYtH3Pjh0diUv+HTeJC+u6zbjSo6sUZP9bz2G11pK7R4
         1ehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748359359; x=1748964159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFVApp8xTfR/YzA8SQhWfU8t8lZcJsWBKVg3yZcwNbM=;
        b=AW3W96obosyQlA6HFhXpHDUVFNkKvIG6a0tK/VQz+ZjUVH+1JdUEiFocTmlew2BGTi
         Xsf/yqtJFu8z8A+LFmEHxpFsBqlJ7jjocqjP9cMSCj2EJSIZva94H1uW5PtIkafxTYBt
         HVqSO1cbuG92Vp5h8VFoMRY70dOwOae78mWelbaUWhkDOxLCFZWQ1Bk/I2MCWng/O51w
         /qlbcm/vko2gU3TAwGlhhN/LBJMSIAapKv0ym/95Fi0drPpL4X6Tk5earHLwVDxWyB3L
         SK0d4WSBFfU2WitJBlsiYrPszcaTagyZf4IHIqMn9FZvzAklTDCppyqUemKXQklmPpT9
         zRsg==
X-Forwarded-Encrypted: i=1; AJvYcCUILJhR+yLjmZcgsbflkPvkP9T3XF+HmQrBH0JZf/tUcvqUnMkBfZ8hrXfvqcpDZy8YWhotDTg2ONKnmvY+Pf0=@vger.kernel.org, AJvYcCVJBrpulZvF3foRQCppsRCav82zwJWqv+/6T+1xq5oPF6wFPD91OVVO4VUxI2LdVWZ7jBcCMzZoNRBuA7j0urHq@vger.kernel.org, AJvYcCXNz/I7ZleCk/xtGA/Xwl6sSToKKpezsOKuM0uNQfTsveQNGF2RCKuIly6H1075k5vGQfLc5G4PIGATK/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp7tT9rtjfhRl7VQ/Oy5VXD0zpBjlluefj89nKZQj+JYW1JOGg
	5AGqpD1++qc1uOCbpP7C09L5hG/NlqWhDzVGnRb/mgZZ3bfeMeGF2g4ZTw5AzztukcIrZPvbGla
	aP2guKDnBWXjgf4yTo1mwNVvy6Finmrg=
X-Gm-Gg: ASbGncvsR8Vuqp5vq9vicXxSomyg/JrEhVMJ/zIhB9Pkp2uBX04KN5i9mUBMie+KBT3
	iWwHdgHtXfh8ysoqIBtgOAN2rFmEqrnHNLdQecpBpd42OtF+HVN9AWxwJxCoRjFw0hYWYTqmCBR
	SFYjDjYljROQlyDKA3fHS72knlVnzvS5vP
X-Google-Smtp-Source: AGHT+IHQ0WA1MTUyC6cHQOw0z+tsCUEH0shIicp1agCv9Ylpi4oiC765zmtaMYFB7Tkm8FdLcYHAnrnZmM6rCS/lHhg=
X-Received: by 2002:a17:902:cf03:b0:21f:356:758f with SMTP id
 d9443c01a7336-23414f2f960mr82446905ad.3.1748359359182; Tue, 27 May 2025
 08:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org> <20250502215133.1923676-3-ojeda@kernel.org>
 <CABVgOSm8T+_kXY78sioUHEcG7rYApfWK2Gfxkrvw94Dz57G0oQ@mail.gmail.com>
 <681912de.050a0220.383f17.18c4@mx.google.com> <CABVgOSnqtxwYQBbed_-TYr6D3BZJ=MT3KVv-eXUFbnRm1UyETw@mail.gmail.com>
In-Reply-To: <CABVgOSnqtxwYQBbed_-TYr6D3BZJ=MT3KVv-eXUFbnRm1UyETw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 May 2025 17:22:26 +0200
X-Gm-Features: AX0GCFuo2q6SOgnXa03Y5boBAZLUrzMqZnJGPrSsiqpZAwCDDg2s1k_ev0Vzb3E
Message-ID: <CANiq72kSjCueyXQBONE+nOOiHd-AFTu91N55a=pu07Z6iNjyjQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] rust: kunit: support checked `-> Result`s in KUnit `#[test]`s
To: David Gow <davidgow@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 8:33=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> FWIW, having out-of-memory situations trigger a test failure is
> consistent with what other KUnit tests (written in C) do.
>
> There's both advantages and disadvantages to this: on the one hand,
> it's prone to false positives (as you mention), on the other, it
> catches cases where the test is using an unusually large amount of
> memory (which could indeed be a test issues).
>
> My go-to rule is that tests should fail if small allocations (which,
> in the normal course of events, _should_ succeed) fail, but if they
> have unusual resource requirements (beyond "enough memory for the
> system to run normally") these should be checked separately when the
> test starts.
>
> That being said, I definitely think that, by default, an `Err` return
> should map to a FAILED test result, as not all Err Results are a
> resource exhaustion issue, and we definitely don't want to mark a test
> as skipped if there's a real error occurring. If test authors wish to
> skip a test when an out-of-memory condition occurs, they probably
> should handle that explicitly. (But I'd not be opposed to helpers to
> make it easier.)

Yeah, agreed.

There may be value in differentiating errors coming from `?` vs.
`assert!`s -- i.e. the discussion in the other thread. It could even
be a different error state if that was valuable -- though I think over
complicating is not great either.

By the way, before I forget to write this down: I talked to Alice
about this back when this discussion happened and she suggested having
a `Result` that carries extra information -- the location. I was
worried about the added cost of doing that in all cases (i.e. for
every `Result` in the kernel), so I suggested doing that but opt-in,
i.e. with a Kconfig option that would be in e.g. the debug menu. Then
people could typically run their debug kernels and things like KUnit
with it enabled, but production kernels without it. Then later on, if
it proves useful for other things, we could try to figure out ways to
do it without too much cost.

Cheers,
Miguel

