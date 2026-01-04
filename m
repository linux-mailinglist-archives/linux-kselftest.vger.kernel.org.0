Return-Path: <linux-kselftest+bounces-48150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DD2CF1758
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 00:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD18E3015875
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 23:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0622EFD91;
	Sun,  4 Jan 2026 23:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFO5Cso3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8935127F724
	for <linux-kselftest@vger.kernel.org>; Sun,  4 Jan 2026 23:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767570262; cv=none; b=ZBDa7bEu6lmyJfyW+VIc2vCDYNPVimUKqN92X63fQMuDZLZogHu0lBFI0CKuMVo2G6d+niKOKJ/uqbMCGTx1FL/LnP4oMnkpaR7Oo9rsUXiVfO0+WWAiRiImOHVVSkmtXjxG4YhCPNm+OSeQFvjkUj0O3ZjNNonNOiEMMfplqJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767570262; c=relaxed/simple;
	bh=p306LGy9eyHijx4jtMFK/9mzd15/zQrT57WNykUTQAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJRSzi6AcruwNi9z7LBhMugoA4xQXXgA5tZ94QexnDc1LLqAiMS6wZUtPjoWY8x6UQnLJ/zB6DSpjASeRXA0E73alcq11Om3iGS+UMFMBu9+0HuTv9q8kyLGtAU96Z4mSAVhWTwwEUnKAXjYunQWfnDZ+XpAMYHImLE/pDp6KHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFO5Cso3; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37fcec29834so116990231fa.0
        for <linux-kselftest@vger.kernel.org>; Sun, 04 Jan 2026 15:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767570258; x=1768175058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwHMhGA+OGxFsPqS+gadiDszFLzctoJHxAFwyBwL5ow=;
        b=AFO5Cso3xWamk3aAjID4gVgSvat9pX/8+WXVhv0se1w9B36Y4EoNPE6KY4jU+EEEo7
         OXI4RIAtXninFFy1CMLpTpOEwa8Cc2z2zNlAFN3KBFtOWyFKNk783r94sxwpab/rPw73
         2cWG42UlUAqNwR/mL3IvShyr/4c92UB24r66agHRDXJz1oU6WtMbLD7Jx2FzvY7pxLx0
         1EdADw7HKh6S3N4HO59G4sKGYDN2eYGVPPnKLcW+7J8m/Yq+UlVwPIc98/FnPIQ6eRAb
         kKbvpqRAValZCSXZURTlWwQUxe/Js1S6Is/aOyZsYToKN0/B396+c44jsDOk4JwaIZKG
         IA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767570258; x=1768175058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nwHMhGA+OGxFsPqS+gadiDszFLzctoJHxAFwyBwL5ow=;
        b=nH0IsPG87BLTo5f26nABPMIC0vHBhWT+3/3o1e2zgIO6WpGoOxUwGGJyWw+rRe6U2b
         VKE/K/RDGpuVxVu8ml9FBqweqVFG1vfVZbfJ3ZQTJo8FxFWc1GjcSZBnOXNo7z4BHgmm
         aYzGhKoF3zD2K9MO4QB6JDEn9tEM4nFpW5rbwV46Fq0+xN7lxswax78REwl0dEY0VMGa
         YFqAyRTmfAKu0qC/lr+6L/kI6iOkek5zjrwrbBf8HTKdEyhTLZUXzRdALwFjZXf8ucyJ
         QGcEplYZ5dmwbYnHq/Qc+RTFHlc0awlHBYHtwYAONl7m5T029eNSjHGUvHHz/7ivGac5
         IYyw==
X-Forwarded-Encrypted: i=1; AJvYcCVQBK9IyE+KheiQm+odjQ6G2S009vFJDUEaqx5dk/FVZBntuxn0peKaetdPG1Kp5Bni2QeL0gPzgxfWOjei0x0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgW+iHA5rsG1jcVbEfVvRxlM/Ju9ZKSqLMnXyI1wFsfVk0nIKH
	9qm0irmB/fuEUROuNkvnzEMpP3FiSazB08oX/lnaa2QUBewM+6CpZGMY1WveecyQPW9r77kbxd8
	NJtdQiO3QgX0+kqPrm7KOrEtoRZF8f10=
X-Gm-Gg: AY/fxX7JI4kwK3jDBsOk0Jk8PVA5HX2r0FnntBJfB+5+t1VaAzNH9eT/3UmW+ORSOpE
	Vup76ixrulM/Q/yyU7xWwn2vGo857KPHwHekOZabQEXP9MqVzeQCr1/Zw1RraPkqwPbhSkJ1umQ
	A7K1PdXssJwbDI2btf5zt61Kkx1/+t12fWOl3y3/hJ2DkdJ+64bvUHpHgjWCpxUaMYU+5r5TN3f
	JiGjOCN/vfAXNg6pFEp4PIiGChM+zkOkAGAZLrrLBa8I3pTNML/lOzkOqQ6ltkccPzWs/2CuT2W
	Lk2Ym1SUoGtgwCArqQq+tIHJQcgeuCyL2CkVL7cUV3J5h/sA/LprinwpL/A6HABW2PugNNxpBd6
	k0S56kHtPLcsmPlaom+1FVahpwPXc8X+PXOMs6iuI9M1Iq/mthKqR
X-Google-Smtp-Source: AGHT+IGuPXba3z676DlVj61wJCekKitKvtqU0BKt1o39uHMbQ3Gl9Z09lZ4ePwCUOEShjHGlrnmGWmO4NBXpCNDJB9w=
X-Received: by 2002:a2e:8a94:0:b0:37a:29b5:e62c with SMTP id
 38308e7fff4ca-38121552fd5mr132780531fa.5.1767570257433; Sun, 04 Jan 2026
 15:44:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211185805.2835633-1-gary@kernel.org> <20251211185805.2835633-12-gary@kernel.org>
In-Reply-To: <20251211185805.2835633-12-gary@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 4 Jan 2026 18:43:41 -0500
X-Gm-Features: AQt7F2paFES2E6TsHfyG09C6nDI2aB8-aBBa0kRt5qNHk6sNb4ZmZsDDv-QPdI8
Message-ID: <CAJ-ks9nF00Nn1oRFu+5AWi37WbvJUWJcWwHdA24nyc3TyUdiew@mail.gmail.com>
Subject: Re: [PATCH 11/11] rust: kunit: use `pin_init::zeroed` instead of
 custom null value
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 2:36=E2=80=AFPM Gary Guo <gary@kernel.org> wrote:
>
> From: Gary Guo <gary@garyguo.net>
>
> The last null element can be created (constly) using `pin_init::zeroed`,
> so prefer to use it instead of adding a custom way of building it.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Tamir Duberstein <tamird@gmail.com>

> ---
>  rust/kernel/kunit.rs | 26 +-------------------------
>  rust/macros/kunit.rs |  4 ++--
>  2 files changed, 3 insertions(+), 27 deletions(-)
>
> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> index 79436509dd73d..034158cdaf06b 100644
> --- a/rust/kernel/kunit.rs
> +++ b/rust/kernel/kunit.rs
> @@ -192,9 +192,6 @@ pub fn is_test_result_ok(t: impl TestResult) -> bool =
{
>  }
>
>  /// Represents an individual test case.
> -///
> -/// The [`kunit_unsafe_test_suite!`] macro expects a NULL-terminated lis=
t of valid test cases.
> -/// Use [`kunit_case_null`] to generate such a delimiter.
>  #[doc(hidden)]
>  pub const fn kunit_case(
>      name: &'static kernel::str::CStr,
> @@ -215,27 +212,6 @@ pub const fn kunit_case(
>      }
>  }
>
> -/// Represents the NULL test case delimiter.
> -///
> -/// The [`kunit_unsafe_test_suite!`] macro expects a NULL-terminated lis=
t of test cases. This
> -/// function returns such a delimiter.
> -#[doc(hidden)]
> -pub const fn kunit_case_null() -> kernel::bindings::kunit_case {
> -    kernel::bindings::kunit_case {
> -        run_case: None,
> -        name: core::ptr::null_mut(),
> -        generate_params: None,
> -        attr: kernel::bindings::kunit_attributes {
> -            speed: kernel::bindings::kunit_speed_KUNIT_SPEED_NORMAL,
> -        },
> -        status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
> -        module_name: core::ptr::null_mut(),
> -        log: core::ptr::null_mut(),
> -        param_init: None,
> -        param_exit: None,
> -    }
> -}
> -
>  /// Registers a KUnit test suite.
>  ///
>  /// # Safety
> @@ -254,7 +230,7 @@ pub const fn kunit_case_null() -> kernel::bindings::k=
unit_case {
>  ///
>  /// static mut KUNIT_TEST_CASES: [kernel::bindings::kunit_case; 2] =3D [
>  ///     kernel::kunit::kunit_case(kernel::c_str!("name"), test_fn),
> -///     kernel::kunit::kunit_case_null(),
> +///     pin_init::zeroed(),
>  /// ];
>  /// kernel::kunit_unsafe_test_suite!(suite_name, KUNIT_TEST_CASES);
>  /// ```
> diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
> index 516219f5b1356..fd2cfabfaef76 100644
> --- a/rust/macros/kunit.rs
> +++ b/rust/macros/kunit.rs
> @@ -74,7 +74,7 @@ pub(crate) fn kunit_tests(test_suite: Ident, mut module=
: ItemMod) -> Result<Toke
>      // static mut TEST_CASES: [::kernel::bindings::kunit_case; 3] =3D [
>      //     ::kernel::kunit::kunit_case(::kernel::c_str!("foo"), kunit_ru=
st_wrapper_foo),
>      //     ::kernel::kunit::kunit_case(::kernel::c_str!("bar"), kunit_ru=
st_wrapper_bar),
> -    //     ::kernel::kunit::kunit_case_null(),
> +    //     ::pin_init::zeroed(),
>      // ];
>      //
>      // ::kernel::kunit_unsafe_test_suite!(kunit_test_suit_name, TEST_CAS=
ES);
> @@ -159,7 +159,7 @@ macro_rules! assert_eq {
>      processed_items.push(parse_quote! {
>          static mut TEST_CASES: [::kernel::bindings::kunit_case; #num_tes=
ts_plus_1] =3D [
>              #(#test_cases,)*
> -            ::kernel::kunit::kunit_case_null(),
> +            ::pin_init::zeroed(),
>          ];
>      });
>      processed_items.push(parse_quote! {
> --
> 2.51.2
>
>

