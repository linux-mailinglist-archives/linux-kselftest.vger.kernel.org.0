Return-Path: <linux-kselftest+bounces-26659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BC8A360B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 15:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2163AF4A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 14:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED14266EF5;
	Fri, 14 Feb 2025 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmHEnCms"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18DE266581;
	Fri, 14 Feb 2025 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739544102; cv=none; b=PaC3Jgs9vsr1TQ1bVDaznr94X8cWh92/tyVY8hrL4G0etGLqfdFXxWgT8sVhIKkMLofWRuQpfrYvwYpP9OEL+yFsuVHlm/Gjb/NNab9NKZyqyd77hUrLgOBJi/DxCo1EGb4XqBy58lPGWyIVr708e2udAkBxRM3eqNA5OFB5Vto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739544102; c=relaxed/simple;
	bh=OTXs3V3Gm6IRul4QKaL7JCAspCNZEAUXXNFKStN0soQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXM+EnpxVsh7ZZerlbX+bFDSr6XCIQHs5Eliah5gTkqocWns47BqvZ+MuFzwvezIHVHqufobve4JmuosxnMJvQM8LP7Y1GjDufEh8fZypjluCF1ScMOgB1EnlhBZQaurLxypziBQt27EkkzmG8jlsm3E8Z/Mlq7zFXykc8zjkZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmHEnCms; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-307c13298eeso20830311fa.0;
        Fri, 14 Feb 2025 06:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739544099; x=1740148899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZywg83io+M8jYPqDvZGoCFahp6/T+xzE48i56QLMnM=;
        b=XmHEnCmsacK+e+eO8cls6EvBkWNJhoqQ290R53VmttlJTmK0cELQV9UdNiPyoL+0Eb
         lK9mbnSWVvI8I65RSPfsDQDwjwLI4OZE0Y8riVTfB9W9ckAJi3eC5ybPOaHfxmStapvP
         WBysmIjCDo5qTUWt5kI0tDRkU+UlcXv47sOKR5DljARLEdexCrFhJkP55pzTPkYlkUPR
         VNEMxSUVXY100HUeacH4R9G+3fHtWo+MVYXXlS6k3fosV579kLrFQ5du/t5IDgxFmQsX
         L2wfKGiwokap0D0P8r1bpNhYwlmal/1nZqMtGK4/CsToHtClBDbfQifCeR/ooQ720jeK
         KZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739544099; x=1740148899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZywg83io+M8jYPqDvZGoCFahp6/T+xzE48i56QLMnM=;
        b=NPIvFtmiMbt2xnj/8DWEkPsLs0MoI0wxF57LwX5ojPce/+NUZbleGqkHeifHLENZbU
         73+dhaXAr5jsp0uI66ZQaELzCEWVp4O/IJaykdstFTeZ4XSpJa+cs/5T2ySkfb4dFb0v
         TIf5byeaJH6UOy/Gcehr20wz+GmNyApeWe6NzVVJFh5u1Xu9AzvBfPNQDIAIk3k2InQa
         DWzaw2wWjS7ZuiUeC+eA+6MECcvb0+NdoeAUiNplGlFc9u70ACmLSI3LarOlyeH5I66v
         fK/bm7EWrrFTYQucdiZJDgaPEBHWmeL3ZMDULb9F9/vska7AFg+AgPj0G4FZ9qxHpSxX
         BlKg==
X-Forwarded-Encrypted: i=1; AJvYcCVCkdpVAyQWzzU5VSi1W4fk016P6od4Slib5j3UCkcqNVBn5MI8CGaYv5U9j68TTVfSaA8NpGfo3+SmY3Nbb7oO@vger.kernel.org, AJvYcCVvOxZ3AoNEByCZp//qvMNrYgynkyQ/42N1DFAvyceon6O0/VNY+c08LoNoqzJnuUxMuFFLa6jhCY7nVNk=@vger.kernel.org, AJvYcCWmXCk6O6gmVeO9i2qd4W3bgCVQiHQ39Q5oGXprAMKPaPNxP9CdL5BbON4+7DarMYrfPCqX2Z4h5MA3POfbtRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0YuKWAIAi2QububelGWTWPVKnoS1MykLPV8roZD1yhiCfr6yn
	a8MSdD0zuJk7rqCaKlGBZNLjXl43ZAKqE34yxrALRDnYJhDzzRWP2MOp1pQIbQQqG4gurWc3p0H
	oNn5yfuUEZKoEs8KHXIihNqB9Nbg=
X-Gm-Gg: ASbGncsOX0Oq5NuY0x6pr71XyzZu8z/f+XY6EzaUROrQk8ATZdgr+AE9V23UEDd+4Ky
	p/1IuM9avGkWLeYGZ2+1BF0AkdJOe23HZihc80rOzZ0+qIDGkWMwDr7mz9LACFAugJUjqB3rGDU
	ABYAAEYEXeIW7ZwFoUaEAfQf2h+ZpiAnc=
X-Google-Smtp-Source: AGHT+IFHKgpZPcpXEVRmDoWFwA2sR1RNqGhaFaOyGhlS5WyPRXpQVTSo6DzE0uTiP9BYq/oi9I1N4cXElI3SDgPoGuU=
X-Received: by 2002:a2e:2e0c:0:b0:308:e2da:2168 with SMTP id
 38308e7fff4ca-3090f2495ebmr20155371fa.11.1739544098529; Fri, 14 Feb 2025
 06:41:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214074051.1619256-1-davidgow@google.com> <20250214074051.1619256-4-davidgow@google.com>
In-Reply-To: <20250214074051.1619256-4-davidgow@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Feb 2025 09:41:02 -0500
X-Gm-Features: AWEUYZnfWpWjmZOjvgT1lwCZJX7AcCD4niJuCdhB2H3Ki6byoqEQZFxKixu6sKA
Message-ID: <CAJ-ks9kwVz4sPdmqfTLVK-Z2C7WmXHpBhbe5_ozWBZnwxJ8HpA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] rust: kunit: allow to know if we are in a test
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

On Fri, Feb 14, 2025 at 2:42=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> From: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
>
> In some cases, we need to call test-only code from outside the test
> case, for example, to mock a function or a module.
>
> In order to check whether we are in a test or not, we need to test if
> `CONFIG_KUNIT` is set.
> Unfortunately, we cannot rely only on this condition because:
> - a test could be running in another thread,
> - some distros compile KUnit in production kernels, so checking at runtim=
e
>   that `current->kunit_test !=3D NULL` is required.
>
> Forturately, KUnit provides an optimised check in
> `kunit_get_current_test()`, which checks CONFIG_KUNIT, a global static
> key, and then the current thread's running KUnit test.
>
> Add a safe wrapper function around this to know whether or not we are in
> a KUnit test and examples showing how to mock a function and a module.
>
> Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> Co-developed-by: David Gow <davidgow@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>
> Changes since v5:
> https://lore.kernel.org/all/20241213081035.2069066-4-davidgow@google.com/
> - Greatly improved documentation, which is both clearer and better
>   matches the rustdoc norm. (Thanks, Miguel)
> - The examples and safety comments are also both more idiomatic an
>   cleaner. (Thanks, Miguel)
> - More things sit appropriately behind CONFIG_KUNIT (Thanks, Miguel)
>
> Changes since v4:
> https://lore.kernel.org/linux-kselftest/20241101064505.3820737-4-davidgow=
@google.com/
> - Rebased against 6.13-rc1
> - Fix some missing safety comments, and remove some unneeded 'unsafe'
>   blocks. (Thanks Boqun)
>
> Changes since v3:
> https://lore.kernel.org/linux-kselftest/20241030045719.3085147-8-davidgow=
@google.com/
> - The example test has been updated to no longer use assert_eq!() with
>   a constant bool argument (fixes a clippy warning).
>
> No changes since v2:
> https://lore.kernel.org/linux-kselftest/20241029092422.2884505-4-davidgow=
@google.com/
>
> Changes since v1:
> https://lore.kernel.org/lkml/20230720-rustbind-v1-3-c80db349e3b5@google.c=
om/
> - Rebased on top of rust-next.
> - Use the `kunit_get_current_test()` C function, which wasn't previously
>   available, instead of rolling our own.
> - (Thanks also to Boqun for suggesting a nicer way of implementing this,
>   which I tried, but the `kunit_get_current_test()` version obsoleted.)
> ---
>  rust/kernel/kunit.rs | 66 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> index 9e27b74a605b..3aad7a281b6d 100644
> --- a/rust/kernel/kunit.rs
> +++ b/rust/kernel/kunit.rs
> @@ -286,11 +286,77 @@ macro_rules! kunit_unsafe_test_suite {
>      };
>  }
>
> +/// Returns whether we are currently running a KUnit test.
> +///
> +/// In some cases, you need to call test-only code from outside the test=
 case, for example, to
> +/// create a function mock. This function allows to change behavior depe=
nding on whether we are
> +/// currently running a KUnit test or not.
> +///
> +/// # Examples
> +///
> +/// This example shows how a function can be mocked to return a well-kno=
wn value while testing:
> +///
> +/// ```
> +/// # use kernel::kunit::in_kunit_test;
> +/// fn fn_mock_example(n: i32) -> i32 {
> +///     if in_kunit_test() {
> +///         return 100;
> +///     }
> +///
> +///     n + 1
> +/// }
> +///
> +/// let mock_res =3D fn_mock_example(5);
> +/// assert_eq!(mock_res, 100);
> +/// ```
> +///
> +/// Sometimes, you don't control the code that needs to be mocked. This =
example shows how the
> +/// `bindings` module can be mocked:

[`bindings`] here, please. There are two more instances below but
those aren't doc comments, so I don't think bracketing them will do
anything.

> +///
> +/// ```
> +/// // Import our mock naming it as the real module.
> +/// #[cfg(CONFIG_KUNIT)]
> +/// use bindings_mock_example as bindings;
> +/// #[cfg(not(CONFIG_KUNIT))]
> +/// use kernel::bindings;
> +///
> +/// // This module mocks `bindings`.
> +/// #[cfg(CONFIG_KUNIT)]
> +/// mod bindings_mock_example {
> +///     /// Mock `ktime_get_boot_fast_ns` to return a well-known value w=
hen running a KUnit test.
> +///     pub(crate) fn ktime_get_boot_fast_ns() -> u64 {
> +///         1234
> +///     }
> +/// }
> +///
> +/// // This is the function we want to test. Since `bindings` has been m=
ocked, we can use its
> +/// // functions seamlessly.
> +/// fn get_boot_ns() -> u64 {
> +///     // SAFETY: `ktime_get_boot_fast_ns()` is always safe to call.
> +///     unsafe { bindings::ktime_get_boot_fast_ns() }
> +/// }
> +///
> +/// let time =3D get_boot_ns();
> +/// assert_eq!(time, 1234);
> +/// ```

Isn't this swapping out the bindings module at compile time, and for
the whole build? In other words cfg(CONFIG_KUNIT) will apply to all
code, both test and non-test.

> +pub fn in_kunit_test() -> bool {
> +    // SAFETY: `kunit_get_current_test()` is always safe to call (it has=
 fallbacks for
> +    // when KUnit is not enabled).
> +    unsafe { !bindings::kunit_get_current_test().is_null() }

Nit if you care about reducing unsafe blocks:

!unsafe { bindings::kunit_get_current_test() }.is_null()


> +}
> +
>  #[kunit_tests(rust_kernel_kunit)]
>  mod tests {
> +    use super::*;
> +
>      #[test]
>      fn rust_test_kunit_example_test() {
>          #![expect(clippy::eq_op)]
>          assert_eq!(1 + 1, 2);
>      }
> +
> +    #[test]
> +    fn rust_test_kunit_in_kunit_test() {
> +        assert!(in_kunit_test());
> +    }
>  }
> --
> 2.48.1.601.g30ceb7b040-goog
>
>

