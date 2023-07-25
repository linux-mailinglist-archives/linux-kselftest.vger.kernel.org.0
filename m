Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0A376276A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 01:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjGYXfU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 19:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjGYXfR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 19:35:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0E62109;
        Tue, 25 Jul 2023 16:35:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-991ef0b464cso85702666b.0;
        Tue, 25 Jul 2023 16:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690328112; x=1690932912;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3+zmA3b0fWEn/LYAXcL90zcHuxRMIJbjiT+FvyTCVX8=;
        b=LirfYxMKrvMzK+AoQtUv0/Xw4eJUk4zcJL1wWMw4S3jmv7nuZ9nTY9Ng1ETF3uCdC9
         zBM8IbFajaZJ7C+2PPOX15Kvs8mqDyU0XhQrfbxkJx3P69DztI5KBDAvDa8fLE7TJt40
         Ko8KLzhoXKy7/TLcH1tgvjsAIPMVseOC9uFrGRkMbiVIUh6TBWJiVMbMosumHB8/k+f9
         m/e6hfTynoh+riM+3VweoatLoZcOaidEeZ+Z5wbDOLzkOMrjCEl6X+nG+n1LzYr224F+
         +aElJASEaAeXyR+PPTEQvVjLWxp23rNdaCT50lfUeB0n6ZSvq/1v4MA01vAAC+2fzD8i
         stIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690328112; x=1690932912;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+zmA3b0fWEn/LYAXcL90zcHuxRMIJbjiT+FvyTCVX8=;
        b=ByNBYGxO0e7CimjDYNNcQWCxlVESOLa9XZjUg6kqrrOzajtw9P9So4emz9QSG6HJvY
         5nIBraAHlYCmu6LI7ixtCP095/Ty/wX855ZEp0jq56JkyCGyWe+Gn8FWCLhRHupvLkOD
         6JkTjgOVUa7mP9bzNrpQNYp2V56iVM3qvhGucmmjja+jsyjyWzoabsysTnTRVVN0s+l9
         p7D7J8PQia3yjkGl8xVXc06RNMRWXzvzjppjARdu/DYfREb1ec4cQlze4zF3Mqq+kKZa
         qW9EbWaIhgzsXegfAkuyXupN37zNgi2xB/8zIcVvQrjoc8cLRusdFb7zottNt+6hozQt
         M1cA==
X-Gm-Message-State: ABy/qLbingyOpuR0g+fyx+Okw4GZpVctiOScGjUoNaw4g5M5N+0Rte53
        /e/yPXr3L2UkGmO2w1//wOM=
X-Google-Smtp-Source: APBJJlHtDJh+zIju8bxQmTm3vIUJTQGQjajVipzAiZqcDKNHLL1QVLeVWtETpEVTl7Dia9tn+Hiq9A==
X-Received: by 2002:a17:906:3008:b0:988:71c8:9f3a with SMTP id 8-20020a170906300800b0098871c89f3amr641066ejz.16.1690328112056;
        Tue, 25 Jul 2023 16:35:12 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id z3-20020a170906270300b00993017b64a8sm8777836ejc.224.2023.07.25.16.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 16:35:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8BE5227C0054;
        Tue, 25 Jul 2023 19:35:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 25 Jul 2023 19:35:09 -0400
X-ME-Sender: <xms:LFzAZI2DsR0Tj_ZMYLierxo1KEkWFTBKXih-1kHw6vQus9RK95Nuyw>
    <xme:LFzAZDHNt_Q1Mpcg7dlMFpPIrljf3e39idcNTOZr_xWNFAIaR8fsmCUDwPHAVveLo
    NpSdfSJV7miG74hxQ>
X-ME-Received: <xmr:LFzAZA68KPObveqULD4gQLHDB7w5F6SsHKf13pVNT5e6hDBox5dLFICC58F-3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedugddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtgeehleevffdujeffgedvlefghffhleekieeifeegveetjedvgeevueff
    ieehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:LFzAZB0SGOfn2TXHHH2Q3ZOfpdw6RZn0AFwBWvt17Y2kIXvBoPQNcQ>
    <xmx:LFzAZLGIhRo-eVz6AAZxYFgYDm0wxzgN_-JpHs9YoDSU1IaGjU9aHA>
    <xmx:LFzAZK_VvEX5-EV5nNNqt_lM1OUnKkctvjkPfyMtPU5eMvZTpqBV8A>
    <xmx:LVzAZKebkz4r0yJTq3MesiiMRTXoPTy1w9tIe27g0vmSqP_ewsG99Q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jul 2023 19:35:08 -0400 (EDT)
Date:   Tue, 25 Jul 2023 16:34:43 -0700
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
Subject: Re: [PATCH 3/3] rust: kunit: allow to know if we are in a test
Message-ID: <ZMBcE8WABtx7GD2R@boqun-archlinux>
References: <20230720-rustbind-v1-0-c80db349e3b5@google.com>
 <20230720-rustbind-v1-3-c80db349e3b5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230720-rustbind-v1-3-c80db349e3b5@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 20, 2023 at 02:38:54PM +0800, David Gow wrote:
> From: José Expósito <jose.exposito89@gmail.com>
> 
> In some cases, you need to call test-only code from outside the test
> case, for example, to mock a function or a module.
> 
> In order to check whether we are in a test or not, we need to test if
> `CONFIG_KUNIT` is set.
> Unfortunately, we cannot rely only on this condition because some
> distros compile KUnit in production kernels, so checking at runtime
> that `current->kunit_test != NULL` is required.
> 
> Note that the C function `kunit_get_current_test()` can not be used
> because it is not present in the current Rust tree yet. Once it is
> available we might want to change our Rust wrapper to use it.
> 
> This patch adds a function to know whether we are in a KUnit test or
> not and examples showing how to mock a function and a module.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  rust/kernel/kunit.rs | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> index 44ea67028316..dcaac19bb108 100644
> --- a/rust/kernel/kunit.rs
> +++ b/rust/kernel/kunit.rs
> @@ -40,6 +40,8 @@ pub fn info(args: fmt::Arguments<'_>) {
>      }
>  }
>  
> +use crate::task::Task;
> +use core::ops::Deref;
>  use macros::kunit_tests;
>  
>  /// Asserts that a boolean expression is `true` at runtime.
> @@ -256,11 +258,87 @@ macro_rules! kunit_unsafe_test_suite {
>      };
>  }
>  
> +/// In some cases, you need to call test-only code from outside the test case, for example, to
> +/// create a function mock. This function can be invoked to know whether we are currently running a
> +/// KUnit test or not.
> +///
> +/// # Examples
> +///
> +/// This example shows how a function can be mocked to return a well-known value while testing:
> +///
> +/// ```
> +/// # use kernel::kunit::in_kunit_test;
> +/// #
> +/// fn fn_mock_example(n: i32) -> i32 {
> +///     if in_kunit_test() {
> +///         100
> +///     } else {
> +///         n + 1
> +///     }
> +/// }
> +///
> +/// let mock_res = fn_mock_example(5);
> +/// assert_eq!(mock_res, 100);
> +/// ```
> +///
> +/// Sometimes, you don't control the code that needs to be mocked. This example shows how the
> +/// `bindings` module can be mocked:
> +///
> +/// ```
> +/// // Import our mock naming it as the real module.
> +/// #[cfg(CONFIG_KUNIT)]
> +/// use bindings_mock_example as bindings;
> +///
> +/// // This module mocks `bindings`.
> +/// mod bindings_mock_example {
> +///     use kernel::kunit::in_kunit_test;
> +///     use kernel::bindings::u64_;
> +///
> +///     // Make the other binding functions available.
> +///     pub(crate) use kernel::bindings::*;
> +///
> +///     // Mock `ktime_get_boot_fast_ns` to return a well-known value when running a KUnit test.
> +///     pub(crate) unsafe fn ktime_get_boot_fast_ns() -> u64_ {
> +///         if in_kunit_test() {
> +///             1234
> +///         } else {
> +///             unsafe { kernel::bindings::ktime_get_boot_fast_ns() }
> +///         }
> +///     }
> +/// }
> +///
> +/// // This is the function we want to test. Since `bindings` has been mocked, we can use its
> +/// // functions seamlessly.
> +/// fn get_boot_ns() -> u64 {
> +///     unsafe { bindings::ktime_get_boot_fast_ns() }
> +/// }
> +///
> +/// let time = get_boot_ns();
> +/// assert_eq!(time, 1234);
> +/// ```
> +pub fn in_kunit_test() -> bool {
> +    if cfg!(CONFIG_KUNIT) {
> +        // SAFETY: By the type invariant, we know that `*Task::current().deref().0` is valid.
> +        let test = unsafe { (*Task::current().deref().0.get()).kunit_test };

Note here are two unsafe operations: `Task::current()` and the pointer
dereference. You can use the `current!()` macro here to avoid the first
unsafe operation here. Besides I think it'll be better if
in_kunit_test() is a safe method for `Task`? That will be easier for us
to track the usage of task_struct fields in Rust side. But I'm OK with
either way.

Regards,
Boqun

> +        !test.is_null()
> +    } else {
> +        false
> +    }
> +}
> +
>  #[kunit_tests(rust_kernel_kunit)]
>  mod tests {
> +    use super::*;
> +
>      #[test]
>      fn rust_test_kunit_kunit_tests() {
>          let running = true;
>          assert_eq!(running, true);
>      }
> +
> +    #[test]
> +    fn rust_test_kunit_in_kunit_test() {
> +        let in_kunit = in_kunit_test();
> +        assert_eq!(in_kunit, true);
> +    }
>  }
> 
> -- 
> 2.41.0.255.g8b1d071c50-goog
> 
