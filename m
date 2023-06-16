Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6AC732F92
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jun 2023 13:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344779AbjFPLNr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Jun 2023 07:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344143AbjFPLNr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Jun 2023 07:13:47 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F9E123;
        Fri, 16 Jun 2023 04:13:45 -0700 (PDT)
Date:   Fri, 16 Jun 2023 11:13:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1686914021; x=1687173221;
        bh=sccioiXsNUAcH9xywdgmZto1VqADKegnl2UO80aJshs=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=S+gkd8mbyeZq1CI9uwKLZz7vUSMHVV/JB7Zd/BELk+ADXaSAYClyM0s3yBO/xiUXY
         d9eRkDarxVqIUwYqkkAJzmxU0fANLwlE6qWC+E3t3TGlkHfdRXue6HE2m3HCc6Zor0
         ivXHZaU59hCvq9R2PjQi01X2m1FmEqIPv8e1fWh3AG7eKwIoaKDk7UuW6dtE/DbCkB
         83wFNINzLPfb2hQT/oPCPh0hE6VB1ITbyGA2XRvbbxgHRUKKEyOjjxE9Q4KeZ9M2mY
         GbqGfYojoyJ0qyTCxn5eWCLv1wJJxM4PHzXAHntBUGvklIFh4yJkgYYOHK27FK7SUY
         bVYVo03SOU1wA==
To:     Miguel Ojeda <ojeda@kernel.org>
From:   =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        Philip Li <philip.li@intel.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 2/6] rust: str: make doctests compilable/testable
Message-ID: <swNtKemE4jl-Unjz4p8_YFbTdqelLeksw6BO7uKOoJjltsTg46zSiRGlg2H4eR2PZtlu0mVdR4ZtVkH5ted1u031qaWckxgG4NL5tzx3ymM=@protonmail.com>
In-Reply-To: <20230614180837.630180-3-ojeda@kernel.org>
References: <20230614180837.630180-1-ojeda@kernel.org> <20230614180837.630180-3-ojeda@kernel.org>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


------- Original Message -------
On Wednesday, June 14th, 2023 at 20:08, Miguel Ojeda <ojeda@kernel.org> wro=
te:

> Rust documentation tests are going to be build/run-tested
> with the KUnit integration added in a future patch, thus
> update them to make them compilable/testable so that we
> may start enforcing it.
>=20
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/kernel/str.rs | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index c9dd3bf59e34..c41607b2e4fe 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -213,6 +213,7 @@ impl fmt::Display for CStr {
>      ///
>      /// ```
>      /// # use kernel::c_str;
> +    /// # use kernel::fmt;
>      /// # use kernel::str::CStr;
>      /// # use kernel::str::CString;
>      /// let penguin =3D c_str!("=F0=9F=90=A7");
> @@ -241,6 +242,7 @@ impl fmt::Debug for CStr {
>      ///
>      /// ```
>      /// # use kernel::c_str;
> +    /// # use kernel::fmt;
>      /// # use kernel::str::CStr;
>      /// # use kernel::str::CString;
>      /// let penguin =3D c_str!("=F0=9F=90=A7");
> @@ -529,7 +531,7 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
>  /// # Examples
>  ///
>  /// ```
> -/// use kernel::str::CString;
> +/// use kernel::{str::CString, fmt};
>  ///
>  /// let s =3D CString::try_from_fmt(fmt!("{}{}{}", "abc", 10, 20)).unwra=
p();
>  /// assert_eq!(s.as_bytes_with_nul(), "abc1020\0".as_bytes());
> --=20
> 2.41.0

Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
