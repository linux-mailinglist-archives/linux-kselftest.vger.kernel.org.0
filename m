Return-Path: <linux-kselftest+bounces-21312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CB09B96B9
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 18:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7EF1C21397
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 17:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D331A4F22;
	Fri,  1 Nov 2024 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/3Aa7s/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A1A14885D;
	Fri,  1 Nov 2024 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483231; cv=none; b=dapukC8LKETrTJ20YNCQEuofTnqf6Ryqvrr5rUvbmDvcKHL9fM6NXNDAp7eQEdBNHONfbzJJ4jDWVtdaFg3Blc0tke2Lun2BoJ/rEwoqdvr8CdGw0SwvP+mw2VcBVWhVE6kdWV4QxpAdCxpelmYamHE1PsWxvsV6w+AosSOOSvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483231; c=relaxed/simple;
	bh=xCF1mikqyq5ZGJlU4AFffRojpURr2wlyTW8yNjGksvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/ys3J2dmw9flDKPCV9h5qN9CCVZQP2nIBk7Uc4jE9fbfjBuDHiYFvnjxTX1mFNjqdRgSNL8Mp0HQjLf7CCSkUosZ0/OxZItiSUx3xykcreziEuog5Jf8AwUqKd2XnMpKOMLwA02hP5sPu52CDLzf8PB2vg14OSjh0TglmxBOE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/3Aa7s/; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b13fe8f4d0so150109685a.0;
        Fri, 01 Nov 2024 10:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730483228; x=1731088028; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rl0P62FeOI5xHTqt+LnRVZPXGFPBc72ClUpJb3byPSI=;
        b=b/3Aa7s/6L6mXktOoRzv/uhrKg+021j5kZI+hWomq2he+JwtGlAcW0ledZDd0KgLWQ
         APRdSGWeb2d3Z27hdT2D9k3P6o//oXUE4xa3OaKF3G2d2aj1Be+hsT1xuEhlILzoKlI/
         kQJGMT/yhO20svytgJTphokA9cms+N+qUMEftfAOIYH5SKO4vqZdOMLkRkqNNpbxSuux
         OKcyk4L2YJ+cJ5FxNTmPcS0b7gHOu70EfjOmlI4PfIuLssB7eEP9Y1ntqpNBQ8AYqWj7
         p/14jlXScR/ymO+v7fMPccHlPX9CfrI8zYyNZ6q68Pl3jkmaLGWaA4L9buEC9/His04t
         3xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730483228; x=1731088028;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rl0P62FeOI5xHTqt+LnRVZPXGFPBc72ClUpJb3byPSI=;
        b=s8aBmm7c+br44c8irlU++NS1MzrO0KEUba7HUl9iTwFOjNwsX3JeDBHLqKYvAZcZWZ
         AnLGye+ovUyJvsp7mvjyVrFSkgTKII/ZQM4QUs8WK8oioSEj55Mpv824gCr+ON/N/IoH
         48YxMCvy5qwxq64wus83mt8Tml0hQgvMwYFSmMP9Lw7izYYkmkkuP4jTXTuAL1Qa3CuU
         i4ULNEDxKvirPgxU1RbaX4D25qiRuNQVhMNGAk9fIDMb4mhQ7pKIVXpH6jI7I6BQU9Y1
         kBmRFXjMTCQXK0B7v/lQuCniKp9dL4wyAEpPD1e1pqSE2SqLU/pVje6ZmEKfzaebPgyR
         //og==
X-Forwarded-Encrypted: i=1; AJvYcCUnuhc3fm1are66kuP3LtwdXoDQ1I3/lAev4sKZSYC4PWRTJhLuRZVOtCgALxt7CLdQIW2asr81ujjFiRg=@vger.kernel.org, AJvYcCVgBdaqDZmrcV/bYvRC6TLVBHH26lyVjIAU4bttkB5ioaMJKRxFZjxM/1AVYzswIUtsDzhMXs0kI5oG+bu/+yU=@vger.kernel.org, AJvYcCWm9HH267QI3nwSKGOEInBN7+W+2WDYpTJscF2H1gTcZMFRytZfNMCwadw42x0+EkjXPTRVJD4oaIPUwUVGFmeS@vger.kernel.org
X-Gm-Message-State: AOJu0YySzH6TlxJ2PbQzBxAg8YRWPTXIaGsXGTnZ1fTeoHYzN5soKB0z
	LgqjgU134XnyxcyINGR5v4lcQjQCW3wPSZeR6QrtHVx8T4p0xhti
X-Google-Smtp-Source: AGHT+IEPrNd1bftTbnG4GrWuWQfsJzn0GzYPrHHdbqMK7ZsY1+zHB/eNbgJYJb0bHPiXz4GbakIpbA==
X-Received: by 2002:a05:620a:c4f:b0:7b1:127c:6234 with SMTP id af79cd13be357-7b2f24efc9emr872715485a.34.1730483227594;
        Fri, 01 Nov 2024 10:47:07 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39eb143sm190982685a.12.2024.11.01.10.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 10:47:06 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3CB651200066;
	Fri,  1 Nov 2024 13:47:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 01 Nov 2024 13:47:06 -0400
X-ME-Sender: <xms:GhQlZzBvpZgccVz-hXP4YHdUvGinZhokqbmj4JRQrd8U0-ysU7x9Dg>
    <xme:GhQlZ5iTiwiopIxPwLFa_zYYrmAcoiXJyulkoycS3XESrWpS0AzDMixxEakhzXrOh
    MYeI8bq6kZXYqO0XQ>
X-ME-Received: <xmr:GhQlZ-m_iOFSkMD2dduwjl3jL3iPBWx-wv0zxlRCocLSCCFIYCPjtqaVc6E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekrodttddt
    udenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfekudeifedtfeetkeduheegfffgudev
    iefghffggedutdehfeehgffgjedvfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpd
    hruhhsthdqlhgrnhhgrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlih
    hthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhm
    rghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduiedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiughgohifsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjoh
    hsvgdrvgigphhoshhithhokeelsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrvghn
    uggrnhdrhhhighhgihhnsheslhhinhhugidruggvvhdprhgtphhtthhopehrmhhorghrse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtoh
    epsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtohepsghjohhr
    nhefpghghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:GhQlZ1x4VCFJ1hqKkXV8A052cVdLB2i_OeL5mjTV_v_aL1sGJxmvWg>
    <xmx:GhQlZ4SrLQ4ezHKjgTvVgx8DFSvGLlHN163U9ZEQr5avB88Li--AlQ>
    <xmx:GhQlZ4Y7ISi6k0u6nL6IK005ZzSnjvHbQbosXUnzgChay047SqMbFg>
    <xmx:GhQlZ5RNxnfsTp6-IZY5F5VWUm6FG1t-pzLg1tlIzO1wkX1b4urN1Q>
    <xmx:GhQlZ-DMQg7YGane0Z1Ebe2e_GOyMsP4TjhLSC6AaV7a4GyiDrk4dOEW>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 13:47:05 -0400 (EDT)
Date: Fri, 1 Nov 2024 10:47:04 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Matt Gilbride <mattgilbride@google.com>, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] rust: kunit: add KUnit case and suite macros
Message-ID: <ZyUUGNywoADngOwM@Boquns-Mac-mini.local>
References: <20241101064505.3820737-1-davidgow@google.com>
 <20241101064505.3820737-2-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241101064505.3820737-2-davidgow@google.com>

On Fri, Nov 01, 2024 at 02:45:00PM +0800, David Gow wrote:
> From: José Expósito <jose.exposito89@gmail.com>
> 
> Add a couple of Rust const functions and macros to allow to develop
> KUnit tests without relying on generated C code:
> 
>  - The `kunit_unsafe_test_suite!` Rust macro is similar to the
>    `kunit_test_suite` C macro. It requires a NULL-terminated array of
>    test cases (see below).
>  - The `kunit_case` Rust function is similar to the `KUNIT_CASE` C macro.
>    It generates as case from the name and function.
>  - The `kunit_case_null` Rust function generates a NULL test case, which
>    is to be used as delimiter in `kunit_test_suite!`.
> 
> While these functions and macros can be used on their own, a future
> patch will introduce another macro to create KUnit tests using a
> user-space like syntax.
> 
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> Co-developed-by: Matt Gilbride <mattgilbride@google.com>
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>
> Co-developed-by: David Gow <davidgow@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> Changes since v3:
> https://lore.kernel.org/linux-kselftest/20241030045719.3085147-4-davidgow@google.com/
> - The kunit_unsafe_test_suite!() macro now panic!s if the suite name is
>   too long, triggering a compile error. (Thanks, Alice!)
> 
> Changes since v2:
> https://lore.kernel.org/linux-kselftest/20241029092422.2884505-2-davidgow@google.com/
> - The kunit_unsafe_test_suite!() macro will truncate the name of the
>   suite if it is too long. (Thanks Alice!)
> - We no longer needlessly use UnsafeCell<> in
>   kunit_unsafe_test_suite!(). (Thanks Alice!)
> 
> Changes since v1:
> https://lore.kernel.org/lkml/20230720-rustbind-v1-1-c80db349e3b5@google.com/
> - Rebase on top of rust-next
> - As a result, KUnit attributes are new set. These are hardcoded to the
>   defaults of "normal" speed and no module name.
> - Split the kunit_case!() macro into two const functions, kunit_case()
>   and kunit_case_null() (for the NULL terminator).
> 
> ---
>  rust/kernel/kunit.rs | 112 +++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs   |   1 +
>  2 files changed, 113 insertions(+)
> 
> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> index 824da0e9738a..85bc1faff0d5 100644
> --- a/rust/kernel/kunit.rs
> +++ b/rust/kernel/kunit.rs
> @@ -161,3 +161,115 @@ macro_rules! kunit_assert_eq {
>          $crate::kunit_assert!($name, $file, $diff, $left == $right);
>      }};
>  }
> +
> +/// Represents an individual test case.
> +///
> +/// The test case should have the signature
> +/// `unsafe extern "C" fn test_case(test: *mut crate::bindings::kunit)`.
> +///
> +/// The `kunit_unsafe_test_suite!` macro expects a NULL-terminated list of test cases.
> +/// Use `kunit_case_null` to generate such a delimeter.
> +const fn kunit_case(name: &'static kernel::str::CStr, run_case: unsafe extern "C" fn(*mut kernel::bindings::kunit)) -> kernel::bindings::kunit_case {
> +    kernel::bindings::kunit_case {
> +        run_case: Some(run_case),
> +        name: name.as_char_ptr(),
> +        attr: kernel::bindings::kunit_attributes {
> +            speed: kernel::bindings::kunit_speed_KUNIT_SPEED_NORMAL,
> +        },
> +        generate_params: None,
> +        status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
> +        module_name: core::ptr::null_mut(),
> +        log: core::ptr::null_mut(),
> +    }
> +}
> +
> +/// Represents the NULL test case delimiter.
> +///
> +/// The `kunit_unsafe_test_suite!` macro expects a NULL-terminated list of test cases. This
> +/// function retuns such a delimiter.
> +const fn kunit_case_null() -> kernel::bindings::kunit_case {
> +    kernel::bindings::kunit_case {
> +        run_case: None,
> +        name: core::ptr::null_mut(),
> +        generate_params: None,
> +        attr: kernel::bindings::kunit_attributes {
> +            speed: kernel::bindings::kunit_speed_KUNIT_SPEED_NORMAL,
> +        },
> +        status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
> +        module_name: core::ptr::null_mut(),
> +        log: core::ptr::null_mut(),
> +    }
> +}
> +
> +
> +/// Registers a KUnit test suite.
> +///
> +/// # Safety
> +///
> +/// `test_cases` must be a NULL terminated array of test cases.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +/// unsafe extern "C" fn test_fn(_test: *mut crate::bindings::kunit) {
> +///     let actual = 1 + 1;
> +///     let expected = 2;
> +///     assert_eq!(actual, expected);
> +/// }
> +///
> +/// static mut KUNIT_TEST_CASE: crate::bindings::kunit_case = crate::kunit_case(name, test_fn);
> +/// static mut KUNIT_NULL_CASE: crate::bindings::kunit_case = crate::kunit_case_null();
> +/// static mut KUNIT_TEST_CASES: &mut[crate::bindings::kunit_case] = unsafe {
> +///     &mut[KUNIT_TEST_CASE, KUNIT_NULL_CASE]
> +/// };
> +/// crate::kunit_unsafe_test_suite!(suite_name, KUNIT_TEST_CASES);
> +/// ```
> +#[macro_export]
> +macro_rules! kunit_unsafe_test_suite {
> +    ($name:ident, $test_cases:ident) => {
> +        const _: () = {
> +            static KUNIT_TEST_SUITE_NAME: [i8; 256] = {
> +                let name_u8 = core::stringify!($name).as_bytes();
> +                let mut ret = [0; 256];
> +
> +                if name_u8.len() > 255 {
> +                    panic!(concat!("The test suite name `", core::stringify!($name), "` exceeds the maximum length of 255 bytes."));
> +                }
> +
> +                let mut i = 0;
> +                while i < name_u8.len() {
> +                    ret[i] = name_u8[i] as i8;
> +                    i += 1;
> +                }
> +
> +                ret
> +            };
> +
> +            static mut KUNIT_TEST_SUITE: $crate::bindings::kunit_suite =
> +                $crate::bindings::kunit_suite {
> +                    name: KUNIT_TEST_SUITE_NAME,
> +                    // SAFETY: User is expected to pass a correct `test_cases`, hence this macro
> +                    // named 'unsafe'.
> +                    test_cases: unsafe { $test_cases.as_mut_ptr() },
> +                    suite_init: None,
> +                    suite_exit: None,
> +                    init: None,
> +                    exit: None,
> +                    attr: $crate::bindings::kunit_attributes {
> +                        speed: $crate::bindings::kunit_speed_KUNIT_SPEED_NORMAL,
> +                    },
> +                    status_comment: [0; 256usize],
> +                    debugfs: core::ptr::null_mut(),
> +                    log: core::ptr::null_mut(),
> +                    suite_init_err: 0,
> +                    is_init: false,
> +                };
> +
> +            #[used]
> +            #[link_section = ".kunit_test_suites"]
> +            static mut KUNIT_TEST_SUITE_ENTRY: *const $crate::bindings::kunit_suite =
> +                // SAFETY: `KUNIT_TEST_SUITE` is static.
> +                unsafe { core::ptr::addr_of_mut!(KUNIT_TEST_SUITE) };

FYI, `addr_of` and `addr_of_mut` is safe now on statics since 1.82:

	https://blog.rust-lang.org/2024/10/17/Rust-1.82.0.html#safely-addressing-unsafe-statics

We need a `#[allow(unused_unsafe)]` here to avoid the unused unsafe
warning.

Regards,
Boqun

> +        };
> +    };
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index b62451f64f6e..d662aa37070f 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -18,6 +18,7 @@
>  #![feature(inline_const)]
>  #![feature(lint_reasons)]
>  #![feature(unsize)]
> +#![feature(const_mut_refs)]
>  
>  // Ensure conditional compilation based on the kernel configuration works;
>  // otherwise we may silently break things like initcall handling.
> -- 
> 2.47.0.199.ga7371fff76-goog
> 
> 

