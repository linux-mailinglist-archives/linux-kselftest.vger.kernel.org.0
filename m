Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF942732F9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jun 2023 13:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345319AbjFPLPN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Jun 2023 07:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345292AbjFPLPM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Jun 2023 07:15:12 -0400
X-Greylist: delayed 88 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Jun 2023 04:15:11 PDT
Received: from mail-40138.protonmail.ch (mail-40138.protonmail.ch [185.70.40.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A4A123
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jun 2023 04:15:11 -0700 (PDT)
Date:   Fri, 16 Jun 2023 11:14:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1686914109; x=1687173309;
        bh=Xlt+L2igKBybmuk4k08Rh12Cc6jOODhbLzjmeZ+ig8k=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=KcI4N9qEs7ur1mLLG7PX0Z5G5NKrd7FGM3FZApAwyxEPJzfL+z1SH8QDD8zbmB3Bn
         FvVXJAc4jUDI5Ek6CrRJUQCrUTsRtLtB8ODqgE3UjY6dA0BdjXaw2shF09JJG97iJf
         DoUeANvRgexUVTnLfi+lWvDaX9vB0BZVvx0b6ca9NuJCQehAIprYRymcNvKxrkPgdO
         LkHdBr24xCrIr+3XVKxKGa2qUrU050J13PJ9n+7WKT8Q6fGEIZFy5MXZ+dNLXbl6eu
         G64CSURZ1yDFov2MB4bu6DskPn9CzPdEUJMBYoU2Em9Lro36at86IjVTCnqOIKWcs3
         btmPgBcxKxwXg==
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
Subject: Re: [PATCH 4/6] rust: types: make doctests compilable/testable
Message-ID: <8G95KEldmnhs6iOWt4K2Qpb6_TNvLTj36k5DT1ydKnJqcmp4FY44KP6rr8aqNGZE3EirT8v2Ak14r5keNM8kf-BBC8Yobi6W2eLaiu1AFq4=@protonmail.com>
In-Reply-To: <20230614180837.630180-5-ojeda@kernel.org>
References: <20230614180837.630180-1-ojeda@kernel.org> <20230614180837.630180-5-ojeda@kernel.org>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
>  rust/kernel/types.rs | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 1e5380b16ed5..696d6c5a3b9d 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -109,7 +109,7 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -=
> Self {}
>  /// In the example below, we have multiple exit paths and we want to log=
 regardless of which one is
>  /// taken:
>  /// ```
> -/// # use kernel::ScopeGuard;
> +/// # use kernel::types::ScopeGuard;
>  /// fn example1(arg: bool) {
>  ///     let _log =3D ScopeGuard::new(|| pr_info!("example1 completed\n")=
);
>  ///
> @@ -127,7 +127,7 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -=
> Self {}
>  /// In the example below, we want to log the same message on all early e=
xits but a different one on
>  /// the main exit path:
>  /// ```
> -/// # use kernel::ScopeGuard;
> +/// # use kernel::types::ScopeGuard;
>  /// fn example2(arg: bool) {
>  ///     let log =3D ScopeGuard::new(|| pr_info!("example2 returned early=
\n"));
>  ///
> @@ -148,7 +148,7 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -=
> Self {}
>  /// In the example below, we need a mutable object (the vector) to be ac=
cessible within the log
>  /// function, so we wrap it in the [`ScopeGuard`]:
>  /// ```
> -/// # use kernel::ScopeGuard;
> +/// # use kernel::types::ScopeGuard;
>  /// fn example3(arg: bool) -> Result {
>  ///     let mut vec =3D
>  ///         ScopeGuard::new_with_data(Vec::new(), |v| pr_info!("vec had =
{} elements\n", v.len()));
> --=20
> 2.41.0

Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
