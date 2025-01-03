Return-Path: <linux-kselftest+bounces-23874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634C2A00B9A
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 16:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5B617A157C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 15:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A241D1FA8E7;
	Fri,  3 Jan 2025 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWeojbJ5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E7E1BD9E5;
	Fri,  3 Jan 2025 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735918795; cv=none; b=sVvekqD8xGroxsENe7592RM8m7vpTSMqJigro3R8Vi65tLhegvt8ds1EJlnkAIE0t0a37A+846utVFCOesRF/Sgh63zNGbD/EvbeXMtdcskMWsBRnGxdoetszp9BzJR7GF9fvl6A/4RgSh3M5w1X3g/4YodEzAutv1YDvo7GWtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735918795; c=relaxed/simple;
	bh=rVidkNLbYiaLUkixqEuo9NujrQHbmxPys2DJC4X7Ek4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKKs+sktsb2opEjAsWlsPaf/xFisvtt2tqy7UU5dZ+seEmov8uwbXyJv7IyV2iFbLs47Z9LgfbRyvd1X5Xx9BfFzDVBh0QGmEH9LQ1N7oxaqJyVtxtehHYNWCBhRydCH2hMcJxdC9pBSHdAWfnqzE4fpri5+f+lhCA3jh7Ednfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWeojbJ5; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ef6ee55225so2512745a91.0;
        Fri, 03 Jan 2025 07:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735918793; x=1736523593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7F8dV60gDGRhSufdp3yFWfkKajhRsy09yCP7BX4Imw=;
        b=XWeojbJ5gthXHgmXcrN1AapCve+qtIULzT09h/xdCwEJ6heOLJ8OYZsJOZ1Q09qnnd
         7QEE0JJUYqR1TFVJOJM4Sb9ODmSnkgDWgJaw/FBvxhofkcMaNRvPlpQzDgUhj1fEECIK
         S6+hYtr5P/4W0C+Ueudgt845RISfVe0OP5aXDow7WYC5Wa2LdywfHNcFLFUI3EG/wkfd
         91wEfi96tsq73z3r6BcOBjmj5JS/KcP3aV8AM93AIwCtU2uHFPU0JQC9fjfQUnWCOlqV
         N/ZBBu5LB979GMwFGXKDKEtpaJAui7DA6PfdV/tKaGvwnVk19KaoAyU2fVaeenI+jTUD
         QQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735918793; x=1736523593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7F8dV60gDGRhSufdp3yFWfkKajhRsy09yCP7BX4Imw=;
        b=kjiON2ZZRb9VtPQ4SINptMKZKNSsJJZ6I1Sd7HYPkuaa0XAvntbb4+DDjvp7dVPrLT
         KgDR7d14NzUh4tRvuLBjlinwC2zRob7cw7KtfXmqPTh5yhMWhykH2KWRU490zSJ5wzq4
         0wckAhwZHxIyXBR7UP8GVtBc/L8qeoyHGDeqk/xsDaFvBwkBihBtDcrJEcyQbdxIWjrY
         q4OeZMvaznM0Xf6ClSrPjiLNwlqfRNbiw6cu2OpzAxfGoBxWuQmbRLxXbljrMLwmNZHZ
         G6NlnhGP1+PRife/MxehY+KZmKz0YpSUNMUHYVvS057sPB4VwJ6CR/FTbuanFXEUAnkM
         /FIA==
X-Forwarded-Encrypted: i=1; AJvYcCUGuTnFrC+nqFIYuQxNx03ktyIwqfpoPuR44AcPAh+yVXVzg2PF5UPTJJpeXyHQnutWZeArjDqUgGdByckSESo5@vger.kernel.org, AJvYcCUirMpjwuWBveZolMfvbeH0d4AUKcp5u5Qnsb6XoCXLlRedhUCghnoH4pb8sQMxGX7Y6ZqkAquCiyzF/I4=@vger.kernel.org, AJvYcCVesYxnmPZVmfQYsvvKDhmZ99qPj8djXOdbLlJo96xlNwdI/jTy5DDfvXtMH7jXf5niSLZHIMdsURjuT+9DU4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/oG6338RB1XE2Rfkw9xkv9f2P0cdqTY9jZbmKGQk9ZlJahEYL
	8MW8GYbEHR4m94zwxsMdCBVE0jZCwquCTfTvPBP60CkZ79tG765naFABDoHDHQ/GbstygoIInE6
	WAV+lLwtJ7yCDdYbsDQODuZWVexw=
X-Gm-Gg: ASbGncu98ZK++zhp0chFl7HjGQSEgdPI2gGTByn7PPqOFzEKWYSpkunZh9/rCWDGpJy
	JisZtQ+EsF9S4YC2u737Zg7GKsYnIS1x6GR/nAA==
X-Google-Smtp-Source: AGHT+IHGe9JpnLeOzaXMl06PtFPZ+aBYP+9K4d21AWXcIb4nD9+KvIC5o+24t/4cT5X/UqdbHunnctcQLZLLMWqctu8=
X-Received: by 2002:a17:90b:2f46:b0:2ee:a558:b6bf with SMTP id
 98e67ed59e1d1-2f452efc09dmr27436140a91.8.1735918793394; Fri, 03 Jan 2025
 07:39:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213081035.2069066-1-davidgow@google.com> <20241213081035.2069066-3-davidgow@google.com>
In-Reply-To: <20241213081035.2069066-3-davidgow@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 3 Jan 2025 16:39:40 +0100
Message-ID: <CANiq72=Mn=N5LJ-9P6YSbOYGZDXeAGnEGcMY8GjDdmPKS=841A@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] rust: macros: add macro to easily run KUnit tests
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
> +            #[allow(unused_unsafe)]

Should this be in the first patch?

> -                unsafe { core::ptr::addr_of_mut!(KUNIT_TEST_SUITE) };
> +                unsafe {
> +                    core::ptr::addr_of_mut!(KUNIT_TEST_SUITE)
> +                };

Spurious change?

I thought this should perhaps have been in the previous patch
directly, but running `rustfmt` shows the previous patch is the
correct formatting.

`rustfmt` also needs to be run for these files -- it reveals a few
more changes needed.

> +//! Copyright (c) 2023 Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.co=
m>

(This is not something we need to change now, since it is orthogonal
and debatable, but I think copyright lines should not be in the
generated documentation unless we really want contact points in docs.
I think it could go in a `//` comment after the `SPDX` line instead.)

> +pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenSt=
ream {
> +    if attr.to_string().is_empty() {
> +        panic!("Missing test name in #[kunit_tests(test_name)] macro")
> +    }
> +
> +    if attr.to_string().as_bytes().len() > 255 {
> +        panic!("The test suite name `{}` exceeds the maximum length of 2=
55 bytes.", attr)
> +    }

We could do the `to_string()` step once creating a single string (and
we can keep it as a `String`, too):

    let attr =3D attr.to_string();

> +    // Scan for the "mod" keyword.

Formatting: `mod`

> +        .expect("#[kunit_tests(test_name)] attribute should only be appl=
ied to modules");

Formatting: `#[kunit_tests(test_name)]`

> +        _ =3D> panic!("cannot locate main body of module"),

Formatting: Cannot

> +    //     #[test]
> +    //     fn bar() {
> +    //         assert_eq!(2, 2);
> +    //     }
> +    // ```

Missing closing `}` of the `mod`.

> +    // static mut KUNIT_CASE_FOO: kernel::bindings::kunit_case =3D
> +    //     kernel::kunit::kunit_case(foo, kunit_rust_wrapper_foo);

I think this is not in sync with the generation, i.e. missing
kernel::c_str!("foo")

(and ditto for the other one)

> +    // static mut TEST_CASES : &mut[kernel::bindings::kunit_case] =3D un=
safe {

Formatting: extra space and missing space.

> +    //     &mut [KUNIT_CASE_FOO, KUNIT_CASE_BAR, KUNIT_CASE_NULL]
> +    // };
> +    //
> +    // kernel::kunit_unsafe_test_suite!(kunit_test_suit_name, TEST_CASES=
);
> +    // ```

With the suggestions from the previous patch (i.e. avoiding
unused/duplicated `static`s, intermediate mutable references, unstable
feature and `unsafe`), we can simplify the entire example down to:

    // ```
    // unsafe extern "C" fn kunit_rust_wrapper_foo(_test: *mut
kernel::bindings::kunit) { foo(); }
    // unsafe extern "C" fn kunit_rust_wrapper_bar(_test: * mut
kernel::bindings::kunit) { bar(); }
    //
    // static mut TEST_CASES: [kernel::bindings::kunit_case; 3] =3D [
    //     kernel::kunit::kunit_case(kernel::c_str!("foo"),
kunit_rust_wrapper_foo),
    //     kernel::kunit::kunit_case(kernel::c_str!("bar"),
kunit_rust_wrapper_bar),
    //     kernel::kunit::kunit_case_null()
    // ];
    //
    // kernel::kunit_unsafe_test_suite!(kunit_test_suit_name, TEST_CASES);
    // ```

...with the corresponding removals in the actual generation code
below, of course.

Cheers,
Miguel

