Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0790C762104
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 20:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjGYSHk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 14:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjGYSHj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 14:07:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E172122;
        Tue, 25 Jul 2023 11:07:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99b78fda9a8so654021966b.1;
        Tue, 25 Jul 2023 11:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690308454; x=1690913254;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6P6nInJaW7G7gJCJpOM64PYpwfKrcIGKm7+sHoKzLBM=;
        b=o0hUV0twM1c86PgBwH8TT3CNnElIybifN4P2oZW9MOLAwQ/UltCSOKmcmQ5aJ2PKyU
         Us5KD3EBFY1du0cMSlHXPHdiHHYknP1TCPx6lz6HP+qayRY1IBEzVcaJJOywrOxDVw84
         2LY76BTywpkUcda9EPxH1+r9Aafm4eEM2xNPnFzjBNmSuKWcB1ta1hdTlIEkXal+mfVa
         zWPXv2MMRhKzC7Z2gt7WzOAYeJljVR2VQBdD4CmmHpgp8l/7+Ugq/KC0zbx6jurRWCl3
         OW9aaxtveSNSHWrBxmDEAhoJTHQ9Xgv4xajJxqXT4gAzWqH6+uPMrZtPh294HGUzNGvC
         YzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690308454; x=1690913254;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6P6nInJaW7G7gJCJpOM64PYpwfKrcIGKm7+sHoKzLBM=;
        b=PR6Jf8I+zaiNUAtLSDCTG0gTlTKXCjHXud5apu885mwrYyU8U0Ek5O+V/KUSd0tYoY
         LfMbPrfZwMNWDsd8otSeC/3dBsLSikF3wlhZ0RjuIrAJtC/x2DsWsTVCQddu2LH/zy3H
         jGVgbigFDQd2jkjQwR6a0I3Rh4XdhWcAhgCTMb8/Dxv6sqj5xM64AmRnx29XroOxLuCw
         FiX6RjT/wnZVdnwCF5RVBLPvJH2cPigN26gPgtYFOWCmLleo/XVW2q5mEk+Xiij/SNaP
         UpcjDp9NfTy6l+lHlBH6ljNFW0MM2qK9hJyNNGcx6lYIXeMbsUeDrZdYV2VK+uTeWDCT
         nbnA==
X-Gm-Message-State: ABy/qLZzYeWDE0TX9oTFlPV4UbGQHzRVe+B1+Cct4hfRrDIAAa12Rloi
        cEj9a0FJuDezVK4uUAb0L9A=
X-Google-Smtp-Source: APBJJlExLR8jaPuaX780epX99381rLSkyjeh8Ha8M3N5UIXQ14qEb8M3XahPikZ6LkwvahSVlMiqEA==
X-Received: by 2002:a17:906:31d4:b0:993:e2ba:55a2 with SMTP id f20-20020a17090631d400b00993e2ba55a2mr12119913ejf.19.1690308453541;
        Tue, 25 Jul 2023 11:07:33 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id z6-20020a170906814600b00993cc1242d4sm8473747ejw.151.2023.07.25.11.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 11:07:32 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id B9C0427C005A;
        Tue, 25 Jul 2023 14:07:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 25 Jul 2023 14:07:30 -0400
X-ME-Sender: <xms:Yg_AZG5hVtAL4Mgvrlx0MSLxw1en2Nwk10x5zOixwODm9ECNBUNZlg>
    <xme:Yg_AZP5rrs0HoQXaQm5OHlWZWPz2qKoUeW7fZBgRhVgKMdwuUN8r9SWyj8X9ZK36Y
    J5J4qHkacEVDjS-YQ>
X-ME-Received: <xmr:Yg_AZFeH0hESD9YUCvD3ER5B9-AYO0IGXVWh5VLbM8EajuhJgriO5byNuPHUwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedtgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnheptdegheelveffudejffegvdelgffhhfelkeeiieefgeevteejvdegveeu
    ffeihefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Yg_AZDI2Uzd1M5m0QGTnCjYb63WwShmsoY3JIZLMCSRSSIUq6fl3ng>
    <xmx:Yg_AZKLDet_ROuO94cl0a2SFyXb_d8eL6VWtuQ8eVSlxyiL1dExFUg>
    <xmx:Yg_AZEx0R8nH4wZs3hX6WlvGVZgJBajXs4-6r3N4UMzAa04JUaglzA>
    <xmx:Yg_AZMCa_TlnAd6VIMX1Fu_QsLhoVvcNLP8ZeAD6hYo7nziJIlN62w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jul 2023 14:07:29 -0400 (EDT)
Date:   Tue, 25 Jul 2023 11:07:04 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: kunit: add KUnit case and suite macros
Message-ID: <ZMAPSHyswu1Kgd1U@boqun-archlinux>
References: <20230720-rustbind-v1-0-c80db349e3b5@google.com>
 <20230720-rustbind-v1-1-c80db349e3b5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230720-rustbind-v1-1-c80db349e3b5@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 20, 2023 at 02:38:52PM +0800, David Gow wrote:
> From: José Expósito <jose.exposito89@gmail.com>
> 
> Add a couple of Rust macros to allow to develop KUnit tests without
> relying on generated C code:
> 
>  - The `kunit_unsafe_test_suite!` Rust macro is similar to the
>    `kunit_test_suite` C macro.
>  - The `kunit_case!` Rust macro is similar to the `KUNIT_CASE` C macro.
>    It can be used with parameters to generate a test case or without
>    parameters to be used as delimiter in `kunit_test_suite!`.
> 
> While these macros can be used on their own, a future patch will
> introduce another macro to create KUnit tests using a user-space like
> syntax.
> 
> Co-developed-by: David Gow <davidgow@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  rust/kernel/kunit.rs | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs   |  1 +
>  2 files changed, 93 insertions(+)
> 
> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> index 722655b2d62d..4cffc71e463b 100644
> --- a/rust/kernel/kunit.rs
> +++ b/rust/kernel/kunit.rs
> @@ -161,3 +161,95 @@ macro_rules! kunit_assert_eq {
>          $crate::kunit_assert!($name, $file, $diff, $left == $right);
>      }};
>  }
> +
> +/// Represents an individual test case.
> +///
> +/// The test case should have the signature
> +/// `unsafe extern "C" fn test_case(test: *mut crate::bindings::kunit)`.
> +///
> +/// The `kunit_unsafe_test_suite!` macro expects a NULL-terminated list of test cases. This macro
> +/// can be invoked without parameters to generate the delimiter.
> +#[macro_export]
> +macro_rules! kunit_case {

kunit_case doesn't need to be a macro, right? We can define it as a
const fn. Maybe one `kunit_case_null` and one `kunit_case`. Macros
should be avoided whenever possible.

Thoughts?

Regards,
Boqun

> +    () => {
> +        $crate::bindings::kunit_case {
> +            run_case: None,
> +            name: core::ptr::null_mut(),
> +            generate_params: None,
> +            status: $crate::bindings::kunit_status_KUNIT_SUCCESS,
> +            log: core::ptr::null_mut(),
> +        }
> +    };
> +    ($name:ident, $run_case:ident) => {
> +        $crate::bindings::kunit_case {
> +            run_case: Some($run_case),
> +            name: $crate::c_str!(core::stringify!($name)).as_char_ptr(),
> +            generate_params: None,
> +            status: $crate::bindings::kunit_status_KUNIT_SUCCESS,
> +            log: core::ptr::null_mut(),
> +        }
> +    };
> +}
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
> +/// static mut KUNIT_TEST_CASE: crate::bindings::kunit_case = crate::kunit_case!(name, test_fn);
> +/// static mut KUNIT_NULL_CASE: crate::bindings::kunit_case = crate::kunit_case!();
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
> +                let mut i = 0;
> +                while i < name_u8.len() {
> +                    ret[i] = name_u8[i] as i8;
> +                    i += 1;
> +                }
> +
> +                ret
> +            };
> +
> +            // SAFETY: `test_cases` is valid as it should be static.
> +            static mut KUNIT_TEST_SUITE: core::cell::UnsafeCell<$crate::bindings::kunit_suite> =
> +                core::cell::UnsafeCell::new($crate::bindings::kunit_suite {
> +                    name: KUNIT_TEST_SUITE_NAME,
> +                    test_cases: unsafe { $test_cases.as_mut_ptr() },
> +                    suite_init: None,
> +                    suite_exit: None,
> +                    init: None,
> +                    exit: None,
> +                    status_comment: [0; 256usize],
> +                    debugfs: core::ptr::null_mut(),
> +                    log: core::ptr::null_mut(),
> +                    suite_init_err: 0,
> +                });
> +
> +            // SAFETY: `KUNIT_TEST_SUITE` is static.
> +            #[used]
> +            #[link_section = ".kunit_test_suites"]
> +            static mut KUNIT_TEST_SUITE_ENTRY: *const $crate::bindings::kunit_suite =
> +                unsafe { KUNIT_TEST_SUITE.get() };
> +        };
> +    };
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 3642cadc34b1..ec81fd28d71a 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -18,6 +18,7 @@
>  #![feature(new_uninit)]
>  #![feature(receiver_trait)]
>  #![feature(unsize)]
> +#![feature(const_mut_refs)]
>  
>  // Ensure conditional compilation based on the kernel configuration works;
>  // otherwise we may silently break things like initcall handling.
> 
> -- 
> 2.41.0.255.g8b1d071c50-goog
> 
