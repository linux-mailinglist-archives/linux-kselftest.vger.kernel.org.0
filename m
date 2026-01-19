Return-Path: <linux-kselftest+bounces-49331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D9CD39F66
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 08:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 645F13025710
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 07:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E96F2DB7AF;
	Mon, 19 Jan 2026 07:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WO6+95Tj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341AF2DB788
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806624; cv=pass; b=is1Y8GJu9xC4j8K5S9K66zzDdtximSv9mFFMv0D9ltnD1tD6XWWfUDDo4bBekI+BBdsUvg/ii8tiEJYGjcHQIvDzaw/HVk24lOvLAOGYRCfuAvxzqRBbChfdfJmkEB0aKQaksX8rn6No1kx4MMr1FhutCXOqtIqmx/hayEfCOGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806624; c=relaxed/simple;
	bh=V1UIkHyj+yQ8lMVwE2mGi/qZBxcDcpGyrPfWZXP4iJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3B3MnyyobRqg6pdqbci13QfuRbg0+/VcwcMhYwA7E4ZlwU+rjGtR6EYVimmdo2C/h6+8iX1cmgEJOWFnGenHO5rrxS30ZYTdLR6ZF5LsnIdFYpfiiidavjBdwAYx1S8XG+eQrOEJsx3kVS9yuqVs2C54cknmzVnmMgmalIJEWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WO6+95Tj; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so44977185e9.0
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 23:10:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768806621; cv=none;
        d=google.com; s=arc-20240605;
        b=Wt46CLHxuOs1kjh0wY95PC3vS870TEvunQtNxkDcHlMxDrNXbRfqBoJObaWSjiTI33
         JGowevhUHCVkWFj4pGKxg7q1vVvW41Y4M1cmjwYzT4C+57Ld9dEEleIddWryHTzSe+2o
         ZuK9SqJwXTYIOBH86q+sIHohRRAN6xRa7/gxX8rBMxryXypdX8Ftkzj3NtgvrsUiO5Ds
         4a00YZrz9NWVHt5NEwcyi86zMynMlaHwEBEqRIJRgRrQ0Oyxk0mS9yo1esWvzK1x7lfZ
         /Nl2i3IjPLFCXXixHjgRntHrSRqYbGkmjtmT80gaC4pLu1bCaNbjAbTu3KviOtE45XW4
         jlSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1J5LWW/7OP/+o9Ipvu2tvX/P4Mui/hzuYlTPkDj+ufI=;
        fh=8ZOyNnPm4UOCMr1yvTQQH4AvS9Q8al5mys+Djyx31QE=;
        b=AWOtlqK0t5uqhZwz+e/ooyDvAZn1lt3wxRYX+fblawWGMGPi5U6cwjXmm6HuG5ECl5
         fIRgYJXjtIR1HfmOT90OaEJswTWJSsZG9Y/4nRPJHvxej4TZSGxN5eiqOzn2gtmJ5ARz
         K+8s/Ti117aUp69+b9sTn3ASEazulpt+FxVfCOjOvaM6lnlvkkay4fM6zaU5YJDLXliU
         ZuWxDXjbBJ7k2XJeb5+RSI0b51YnlEscsWE9Hz/1S6k03wzx8WtCRAxjPruwc3xKzY3I
         3MLKDWcft7+HcOxR+4uVg2J6ikbn7D1mWbUsxeaRCK6AKawwVeR86ysxqpmuT1qqax0C
         XKEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768806621; x=1769411421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1J5LWW/7OP/+o9Ipvu2tvX/P4Mui/hzuYlTPkDj+ufI=;
        b=WO6+95TjNVD2rincAYjp5FJqylv94CLF0TlaWM/FzM/K1jSbRGu6po8Le1X4Q4eMTU
         fI1niylAC8WF0xxbv1tqd0dJtFnt1F5HPK1UDMyo+ORcrZzh3NsywFW1Lu6cJI/Bf12k
         lS9opHR+HlOVbEDApDWnPnpDJOUW0h75i8mRpDUdfCdl1YLzgw5B10tu2IP+KmwVaNac
         OwUJ+o5kOF3K58TDKJb2r8DPslSRAhfy2/oK5Ntp4cI4+q2MgeJkNiCZPGMoJFL7T9DP
         7VYjjRODJrfHKuX8bfATh3CiCSMO6bJisMPx4T5AYmSC2DoIL2wWsvhKuJDxdeKZw+an
         jGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768806621; x=1769411421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1J5LWW/7OP/+o9Ipvu2tvX/P4Mui/hzuYlTPkDj+ufI=;
        b=H+BrXwN4kzCUMvYHXs89BRiOYpT6/OCs7QAP0DselBUeBSKsZb1RZCVVxSbh8/7/Gf
         iIKphqMPKjiNvQnEqG8ZICbFAGs4crDnLp7wjZYrpcaa7v6wb7tr36KP9LdV8B3X91gb
         xjNz8eQMQQ6hG6Ta9H0Po/NWYe4ct6u+cma0ZWnMXutACKNStL3z7ULslaRz+awSKMLE
         7QTwfaoTXOTZbJlXhZF6VH2ElFCHutPt/eGoDb5Ws46/LA69kU9bQBBqm8kT+aijLIqJ
         lzNtVJAYLu1GvosS51tVyKj2lfeiS6Qt9bIc2/ba+BuCTNeR2RhsHWnpQ7wcSOX+HmWk
         HD/w==
X-Forwarded-Encrypted: i=1; AJvYcCX22RJw/Gw4DozgstnKzANh/Czs1y9/cGz6aFScoS2lUTdsAUwPc4qj3wJHXv0L5XuCBhgivhBaxzryFwIfQIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLEJNPnwaseHwcdMsuIZnb+a69iCsMbsfRl9xyFHdX+tUh4rfA
	0nF+N1D+g3/6PHCBgCNA4rZIf60BYXG1lcsH9s9TXRizDgFYhoCWEr1a+gOzqehnHYtquFXddZ4
	sl0NY4ATru9PqMCBiu6gL+06CyRYSA7XNznPseiW/
X-Gm-Gg: AY/fxX4Otkw3QcXeFPGDSmuUanBAyK+5vi8PZwfv/31SXpVNcRxYi696ZtEZ1qm6zwy
	BA4XfumnWjdQ2vuC50gPlFsQ3OMC/+Rl/1CxEC3y3QeovIT7St+9X2lrU+BUTH/xwPTJvVRrEkB
	fJRitB7wt196ucb6ot+JwZZCy/uWu9uZYXsICDr0s9PNP2YhFFghJsGic6ynwbyboaoPDRUqee8
	Mo/pdtEG4cMSaSqBjCJfRGMW9q96JIpVluq3fdcK9KSYI26ajElAW+msgr1HoUvQ0UDXQ==
X-Received: by 2002:a05:600c:a12:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-4801e34cbd8mr126406565e9.30.1768806621292; Sun, 18 Jan 2026
 23:10:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112170919.1888584-1-gary@kernel.org> <20260112170919.1888584-12-gary@kernel.org>
In-Reply-To: <20260112170919.1888584-12-gary@kernel.org>
From: David Gow <davidgow@google.com>
Date: Mon, 19 Jan 2026 15:10:09 +0800
X-Gm-Features: AZwV_Qgo9v66ooOKcB-5OAr4hbkT0J0EXuRWA__fIMMC3b7ibM65SOuFODLzNnE
Message-ID: <CABVgOSnPzHZZN=w2cZrCg26bjqOgoqUYZf2roG7gpFtLFyqC-Q@mail.gmail.com>
Subject: Re: [PATCH v3 11/12] rust: kunit: use `pin_init::zeroed` instead of
 custom null value
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <raemoar63@gmail.com>, rust-for-linux@vger.kernel.org, 
	Tamir Duberstein <tamird@gmail.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000604de60648b8628b"

--000000000000604de60648b8628b
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Jan 2026 at 01:12, Gary Guo <gary@kernel.org> wrote:
>
> From: Gary Guo <gary@garyguo.net>
>
> The last null element can be created (constly) using `pin_init::zeroed`,
> so prefer to use it instead of adding a custom way of building it.
>
> Reviewed-by: Tamir Duberstein <tamird@gmail.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---

Reviewed-by: David Gow <davidgow@google.com>

(Do note, however, that this conflicts with
https://lore.kernel.org/rust-for-linux/20251130211233.367946-1-seimun018r@gmail.com/)

Cheers,
-- David



>  rust/kernel/kunit.rs | 26 +-------------------------
>  rust/macros/kunit.rs |  4 ++--
>  2 files changed, 3 insertions(+), 27 deletions(-)
>
> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> index 79436509dd73d..034158cdaf06b 100644
> --- a/rust/kernel/kunit.rs
> +++ b/rust/kernel/kunit.rs
> @@ -192,9 +192,6 @@ pub fn is_test_result_ok(t: impl TestResult) -> bool {
>  }
>
>  /// Represents an individual test case.
> -///
> -/// The [`kunit_unsafe_test_suite!`] macro expects a NULL-terminated list of valid test cases.
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
> -/// The [`kunit_unsafe_test_suite!`] macro expects a NULL-terminated list of test cases. This
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
> @@ -254,7 +230,7 @@ pub const fn kunit_case_null() -> kernel::bindings::kunit_case {
>  ///
>  /// static mut KUNIT_TEST_CASES: [kernel::bindings::kunit_case; 2] = [
>  ///     kernel::kunit::kunit_case(kernel::c_str!("name"), test_fn),
> -///     kernel::kunit::kunit_case_null(),
> +///     pin_init::zeroed(),
>  /// ];
>  /// kernel::kunit_unsafe_test_suite!(suite_name, KUNIT_TEST_CASES);
>  /// ```
> diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
> index afbc708cbdc50..cb29f350d5b2b 100644
> --- a/rust/macros/kunit.rs
> +++ b/rust/macros/kunit.rs
> @@ -74,7 +74,7 @@ pub(crate) fn kunit_tests(test_suite: Ident, mut module: ItemMod) -> Result<Toke
>      // static mut TEST_CASES: [::kernel::bindings::kunit_case; 3] = [
>      //     ::kernel::kunit::kunit_case(::kernel::c_str!("foo"), kunit_rust_wrapper_foo),
>      //     ::kernel::kunit::kunit_case(::kernel::c_str!("bar"), kunit_rust_wrapper_bar),
> -    //     ::kernel::kunit::kunit_case_null(),
> +    //     ::pin_init::zeroed(),
>      // ];
>      //
>      // ::kernel::kunit_unsafe_test_suite!(kunit_test_suit_name, TEST_CASES);
> @@ -159,7 +159,7 @@ macro_rules! assert_eq {
>      processed_items.push(parse_quote! {
>          static mut TEST_CASES: [::kernel::bindings::kunit_case; #num_tests_plus_1] = [
>              #(#test_cases,)*
> -            ::kernel::kunit::kunit_case_null(),
> +            ::pin_init::zeroed(),
>          ];
>      });
>      processed_items.push(parse_quote! {
> --
> 2.51.2
>

--000000000000604de60648b8628b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
Dxz3AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHZtY3XkWtC2
e2Idfk+0JyK7BLzzMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBo
hqjbVaHxZoT6HHUuwQcTlbgXpuVi59bQPrSwb/6Pn1t3h3SLeuUCvOYpoQjxlWy/FexsPW+nWS0I
PUmWpt6sxbIRTKPfb7cPk32XezfnA0jexucybiXzkZKTrbI7zoMOzDIWpTKYZAonB9Zzi7Dso4An
ZOtz/E3yhdR/q1MK30d5fiCS0vorEd0Oy8Jzcc7TJ2HGMzEEXiFFvVrJYJHvfYOeXE4ywAG6YWO0
x78+bXeB9vkeWHhOYKyYXuAXrnHASddEICg1QlJCHDAISMC1Wn/tjqTMTt3sDAe+dhi9V1FEGTbG
g9PxPVP4huJEMIBu/MWNMzHfiW4E7eCHVPrmtX7CFDlMik7qsgQBbO5h6EcxBamhIflfMgoISsRJ
Vyll2E5BNVwkNstMgU3WMg5yIaQcuGFgFnMTrQcaLEEFPV3cCP9pgXovYDirnB7FKNdCZNHfeBY1
HEXJ2jIPDP6nWSbYoRry0TvPgxh5ZeM5+sc1L7kY75C8U4FV3t4qdC+p7rgqfAggdvDPa5BJbTRg
KAzwyf3z7XUrYp38pXybmDnsEcRNBIOEqBXoiBxZXaKQqaY921nWAroMM/6I6CVpTnu6JEeQkoi4
IgGIEaTFPcgAjvpDQ8waLJL84EP6rbLW6dop+97BXbeO9L/fFf40kBhve6IggpJSeU9RdCQ5czGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAYQLf/BIzLow9kWqD8My
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgxJ6DP9Ref9pIzdptBXiFqqVVMJvz
f+bvZFQjMIOKwfwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
MTE5MDcxMDIxWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEATcypXUJ0gMUTBgcrgb9sMEXs/EsmvMiJDe/A5q5KKxCoEBWoxjgc3FEDMwnVHK01
Jo1VRB25elc2gcPBtKwEmu5FDC8Ds/RZv7Cys6FEEriz+jC2WBe1TZYxaeKihaCLCei5xti0W0cl
C+qmBdAaquj2x9/7/y9i+j7ABt/712Jy+1vCpf5hcDv9OiDt05V5xsqVYcT/WxsqAA+Ljp8gppPM
BWuSIQtajVcY/7iZOpUuqxQQD9L/moYaqGy0U5+1LY/mGXjVdT845Qh2KOHtpxy8Py5AGd0Y7tT1
PgSXqxmFhYCkmrEeKR/a2maNSYz1NX/QYZUNgSfpYZYTbiC/Mg==
--000000000000604de60648b8628b--

