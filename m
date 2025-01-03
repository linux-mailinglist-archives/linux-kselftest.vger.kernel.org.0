Return-Path: <linux-kselftest+bounces-23875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F317A00B9E
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 16:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A20B1884869
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43BC1FA24D;
	Fri,  3 Jan 2025 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSY7Dc52"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC4217BA3;
	Fri,  3 Jan 2025 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735919009; cv=none; b=uZFFOHvk3IDOQJTHlig5uN38DeX5+I/dbqj3gr3aFppy3lTnnajdA7cfli9CfLrkSj6qeuM/DJZ6PxqWG6a01FcvNKn2u9uWtPOQPr8XG8tsFaQM50xLwDKAHQ8E+mD6bI3fkJH+krL8BFTPsH+pAW/2T3qGt0PdkLffMrVaSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735919009; c=relaxed/simple;
	bh=wZ5eJLs2akZMOcNUFHkT2IHpMMrs27teBjxbQTJZcAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfALluWed4JF3D/1hUxG0uij6ZILkglxXF7z7Rh/kzXvFYxCI2t85Jq3CtEw5HmC7Zt1AiWZtdlyGw7JYwyYFtzIOszrvobvsNI8G8sn/ZKacYW16req/ErHfv61wB3Dog9guQmve7zVVlzlJsYQ6Q0CLFydeSjrPX/dvg6ZbCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSY7Dc52; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216513f8104so16997865ad.2;
        Fri, 03 Jan 2025 07:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735919007; x=1736523807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5Cj+dv8k85BhdyjAiDFJMj3Zb2/QvYVSVLgI0pirM4=;
        b=aSY7Dc52IjfmwTbps15usSbg3yThJYIdYW62EEYHInuijPHZXu5oSvGs/qqDzOeecq
         fSMcWKWp9BSwK1mcx0mZLS9FUvf424zB/oQ8CTnTu/KweDU9whrWNiGJDEfL3L6CN67H
         46msr5RsmznJEdfQ775GslmTv2kSz6c8SNXBsDGL0gTpq2ocqL9oBZPiw8ZTtKFZOdm8
         YxjDBvkm87vC7mPujG6dKNcNZFj6mqWREf4xxXoz8AtxbceV7hGOApTBfAFrTqr/xbv+
         lrEy8IO1To+Pp2AqyKAeaMlCEGCLEEHQ/dKdoL9Uux2ySltG/VAB45HPirDE/Kwzbb5G
         ImNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735919007; x=1736523807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5Cj+dv8k85BhdyjAiDFJMj3Zb2/QvYVSVLgI0pirM4=;
        b=BhJiSnEAWvU55uIfxna06GTpTu+QjFyaCNIkJBvE8Duob43TAVglNB1ehw0DPyYs5g
         nSj4LEw1LPtETTSnHZc8RjdcMcIQc+z4cQjHk8N/kuDBWrQOcdqJqFHshrnt+TOVMxLH
         UK3onImqDdvpFdR80p43r8KUnxkwL7/Chfm2C35TJ69AG41/UeQ+ASv+B19PQ2m3gWGe
         oueNa/uMaaBk+4YGVX4h7UzIdMAHb4/k+HclhKxFILUNUm3AhYLxW8WZdjkWp2lsdklF
         0+JDXN8AxmQlBw+TJCjDdiQtLrFsXJvgiZ79XOYNS+ql5TYsdInGiu0DLR7H6Whoj8o9
         MfdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUePg6+GkXVCcfTqICLHoU/Za0UTwt33PuhE6y6SF6zZLgELzu5Vrht2Z3p1k5e13lE1bH0dqFo1bac+gnKXp8U@vger.kernel.org, AJvYcCUr6UMugyzr5Xue3XZSJQdoVOlS4+VCgS9Qy+F1XFjH3d6qRgbTmPO0NMD6TM1n01AqwwDTSegg9vb5XCozUOI=@vger.kernel.org, AJvYcCVAmTRJR9pWA2VkwImU8NccCclFEjWtx5EeFuWe9u6M+of/bCyL8FH8yYUWA+x62GHOBkTyMdKsi5R8Qsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3kArOnMifk/FJbLDgTKLhmi0fzgEE/VC7e8twv27tFMTc/RMn
	F1+9kQpfq7N8xBikkq4g8kcnK1/r8KD6/QZYZEhpbVnGxAHZQxSmcDIICcyqIFKAvuz0yX6l3si
	UKJsDfZlykderVXHop3VK9+1Yyak=
X-Gm-Gg: ASbGncvbibrjT1o824Y+op9jlTa1V6ekAlB/nBZrt3uW6uOkO2hAhUQKIJw4CA7oXn2
	Woz8Z0uAXgBt4ZynwwEpQ6f64//4DPAMTst7waA==
X-Google-Smtp-Source: AGHT+IFCA7G0jR3qB6OEjg2YkmOHctxWSKstr7y+0g5C7duADQmK9x+abiRSEk5WZMjUbSsYQcPO3ZvaSRNjfH9HRyI=
X-Received: by 2002:a17:903:2cc:b0:216:536a:9d3b with SMTP id
 d9443c01a7336-219e6e8541dmr256483435ad.1.1735919007260; Fri, 03 Jan 2025
 07:43:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213081035.2069066-1-davidgow@google.com> <20241213081035.2069066-4-davidgow@google.com>
In-Reply-To: <20241213081035.2069066-4-davidgow@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 3 Jan 2025 16:43:15 +0100
Message-ID: <CANiq72=A2kT4ZHCH2c7DVv+WQpH+c2vKcib-Kh7=6LWyUv9Xaw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] rust: kunit: allow to know if we are in a test
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	Rae Moar <rmoar@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Matt Gilbride <mattgilbride@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 9:10=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> +/// In some cases, you need to call test-only code from outside the test=
 case, for example, to
> +/// create a function mock. This function can be invoked to know whether=
 we are currently running a
> +/// KUnit test or not.

The documentation of items use the first paragraph as a "short
description" in some places, so ideally it should be as short as
possible (e.g. one line), similar to Git commit titles.

So what about:

    /// Returns whether we are currently running a KUnit test.
    ///
    /// In some cases, you need to call test-only code from outside
the test case, for example, to
    /// create a function mock. This function allows to change
behavior depending on whether we are
    /// currently running a KUnit test or not.

I tweaked the second sentence to avoid repetition, and to take the
chance to mention "allows to change behavior" instead, since that is
what we want to achieve.

> +/// #

Nit: currently the style we use doesn't keep empty `#` lines to separate.

> +/// fn fn_mock_example(n: i32) -> i32 {
> +///     if in_kunit_test() {
> +///         100
> +///     } else {
> +///         n + 1
> +///     }
> +/// }

Early return would look better here since we really want to do
something completely different, and would avoid indentation in the
"normal code".

> +/// // This module mocks `bindings`.

This could perhaps be documentation (`///`), but either way it is fine.

> +/// mod bindings_mock_example {

Could this get a `#[cfg(CONFIG_KUNIT)]` too?

> +///         if in_kunit_test() {
> +///             1234
> +///         } else {
> +///             // SAFETY: ktime_get_boot_fast_ns() is safe to call, and=
 just returns a u64.

Formatting: `ktime_get_boot_fast_ns()` and `u64`

Perhaps emphasize with "always safe"?

Also, why does the `u64` need to be part of the safety comment?

> +///             // Additionally, this is never actually called in this e=
xample, as we're in a test
> +///             // and it's mocked out.

If the function is safe to call, should we have this as part of the
`SAFETY` comment then? We can move it above, if we need to keep it, or
we could just remove it.

In any case, if the `else` is dead code, why do we have it? i.e.
shouldn't the mock just return the 1234 value? (see below)

> +/// // This is the function we want to test. Since `bindings` has been m=
ocked, we can use its
> +/// // functions seamlessly.
> +/// fn get_boot_ns() -> u64 {
> +///     bindings::ktime_get_boot_fast_ns()

I think this wouldn't work: `ktime_get_boot_fast_ns()` is unsafe when
`CONFIG_KUNIT` is disabled, so it wouldn't build for an actual user.

Unless I am missing something, mocks should keep the `unsafe` status
(i.e. in general, the signature should be kept the same), and the
`SAFETY` comment should be here, i.e. in the "normal code", not above
in the mock (we should probably mention this as a guideline in
`Documentation/rust/testing.rst` too, when the docs are added there
for this).

And by doing that, we can remove all the usage of `bindings` inside
the mocking module, and we keep the "normal code" looking as normal as
possible, i.e. we don't hide `// SAFETY` comments inside mocking
modules.

With all put together, we get something like this:

    /// ```
    /// // Import our mock naming it as the real module.
    /// #[cfg(CONFIG_KUNIT)]
    /// use bindings_mock_example as bindings;
    /// #[cfg(not(CONFIG_KUNIT))]
    /// use kernel::bindings;
    ///
    /// // This module mocks `bindings`.
    /// #[cfg(CONFIG_KUNIT)]
    /// mod bindings_mock_example {
    ///     /// Mock `ktime_get_boot_fast_ns` to return a well-known
value when running a KUnit test.
    ///     pub(crate) fn ktime_get_boot_fast_ns() -> u64 {
    ///         1234
    ///     }
    /// }
    ///
    /// // This is the function we want to test. Since `bindings` has
been mocked, we can use its
    /// // functions seamlessly.
    /// fn get_boot_ns() -> u64 {
    ///     // SAFETY: `ktime_get_boot_fast_ns()` is always safe to call.
    ///     unsafe { bindings::ktime_get_boot_fast_ns() }
    /// }
    ///
    /// let time =3D get_boot_ns();
    /// assert_eq!(time, 1234);
    /// ```

I added a `#[cfg(CONFIG_KUNIT)]` for the mocking module here, like for
the other example.

> +pub fn in_kunit_test() -> bool {
> +    // SAFETY: kunit_get_current_test() is always safe to call from C (i=
t has fallbacks for

Formatting: `kunit_get_current_test()`

Also, I think we should remove "from C" since it may be confusing --
or what is it trying to say here? i.e. it is always safe to call from
both C and Rust, no? Or is there something I am missing?

> +    // when KUnit is not enabled), and we're only comparing the result t=
o NULL.

Does "and we're only comparing the result to NULL" need to be part of
the safety comment? i.e. comparing a pointer is safe (and `is_null()`
too).

> +        let in_kunit =3D in_kunit_test();
> +        assert!(in_kunit);

I would simplify and call directly the function.

Cheers,
Miguel

