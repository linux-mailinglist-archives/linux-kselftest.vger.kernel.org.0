Return-Path: <linux-kselftest+bounces-20950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750F59B49AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 13:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A4B283CA9
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 12:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298BB20606B;
	Tue, 29 Oct 2024 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJcH5mV1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDBC20604D;
	Tue, 29 Oct 2024 12:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730204915; cv=none; b=Q8oZy6IT+4UMk1lUzGNZI+EM9Jhlrg4S+Fjb5A/RPFZXFSibQLzXvFX+igoQTb7bHJxaUv9DlkD7Q7G5VgCfVm6E+pUoK2YipChS05Z+11kvGX0aO9yDSB40lwo6tBd5tD92vA7+dFrjea7J7PkAt+MQnhMyoFn0JAPyClFXs1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730204915; c=relaxed/simple;
	bh=nYsmanhQZGG5XWSoUfkAMXQY0DmtdmuUHfAg8dTxKeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqYDIhp6q7LxulwmlPZMyFoABRzHeRRewoA62fijhRekKVB696cOwNzlmkEMFymsbhyIU2KJzdFlfIrM46wxqsa9tZKGNqRwGmi8WthuXjYcuLxey0/GYtSgmjyypuCR1KzaxmjYXQNL3R5Mqd1hV3NcyGK/KKx8NeW5qPXFT1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJcH5mV1; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-715716974baso3238103a34.1;
        Tue, 29 Oct 2024 05:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730204912; x=1730809712; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZwKrcWQHBRJjnPGWIuMQvqCRyvLG5N+gBcfmK3bYBQ=;
        b=VJcH5mV1rrupIqtr2doJvZFcSBTgewovbSJ4yFeQr297Zqu9dP0FJJ3aZH//s29Flo
         9x4viiVjL+34lcsP/RSf3N5G3h8Zoly74IvnNW3u8incT3xE8Pkw9DwBqQhIlMjnqmG2
         Owjx4MAlBTJBvwrk7tF069UezSeFsLvXjGxHsMXBgIENbetfeqsjWvOdaxPOXNhHXhBG
         SC2R4NYryllg0nHzGUcQgbWi1IRHh28DB4UMvG3HG19r7+NkwMuNz/ArFepJc90bJFZM
         X7hQOwKwdkhURE0nOvOmoY7QC9olDopl+3wT4DNeUCJrOsgusXaBVvalCZQrSV/ashRL
         Ovlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730204912; x=1730809712;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZwKrcWQHBRJjnPGWIuMQvqCRyvLG5N+gBcfmK3bYBQ=;
        b=sGZVS6UUmmBSVCdgehO/l4FrfpoWaF7kO0z4f+V2LFy+YfjvwouNW8XsCFtAlk47IU
         2b+RIfvLhlivIStEBKnA/jVUekZgUFviBnNmWyuPFBKdssyuk8FoKgsqmlQD1Dir92og
         LlGWFcBU1nAfGFYmDWR9HolmgPmw+6lviIl57eiML6ryL7XPSRGDjCCrQPZs/WR8Kob5
         BZdxlxydX49S2MsdgKXKCm2i7vf1b30NG2WEkI0X6j+qvodlgYzD6dKB6Um3M0BFmNyw
         SWshhDKtWO/JF/sdcXzz/PXQNuV1ocXzO6NeQrZd8K0dfG/mK/3f6qrXUnhc+g2XpPkc
         6y9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuyHECwo6hF5AjH0jNrPXR33EcPoBiXyJ9Itdjtwy1hSDMqHoJvfoE2zwvO0iBYRDjHzB7vhesmLwsX0g=@vger.kernel.org, AJvYcCUx2dSZpb2r99hBdIxkhEB0rp04jJobPQ/+s0DKEbPmRCAa/EJ5eXqJIb3mjKkrvRS+eZBwu/wg+wGz6DuJdlo=@vger.kernel.org, AJvYcCX4MVar7Q9JCDrfVTnjdW8ecIwZqEhpmbazJWiSGCxIaLu7RhP4TX+MUo+fyuEZ2Ko7vwaK2DdPIabGOx9jesk4@vger.kernel.org
X-Gm-Message-State: AOJu0YxZYQr2CAZxClwC5VK6gGO0QmVY7iGclvSJ6MmwZ6G030JacTFl
	+LZRbSm6Kh8HeIr7KYggXLh7+Lv806xnYDv5On4RC93nEAwTmFHI
X-Google-Smtp-Source: AGHT+IGZW0l+eKKZX0KrjhiiiUdC5sbjv3DWFPGgCotA+/LUkAOPi6WHiD0+ygV8Lgq/pV3OHGf5Vg==
X-Received: by 2002:a05:6358:70e:b0:1b8:5e16:1a07 with SMTP id e5c5f4694b2df-1c3f9ec2c45mr434007355d.12.1730204911860;
        Tue, 29 Oct 2024 05:28:31 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1798b764bsm41468916d6.44.2024.10.29.05.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 05:28:31 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id DD1961200043;
	Tue, 29 Oct 2024 08:28:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 29 Oct 2024 08:28:30 -0400
X-ME-Sender: <xms:7tQgZ3ckLum4Wc4ixg146bFIVsQHUtRDDbm2ZTsXSqX1YgajlUftLg>
    <xme:7tQgZ9OMEtX73oaTu9ajO6yRtUobxW_mC_OEXrbNnM0GqpO_8V6rw2o7KsK0ASIVh
    y--GBZzDUvaZbX7yQ>
X-ME-Received: <xmr:7tQgZwjgTyezIiGisF4o1-wMG37CROdrs5VqbaWVs4Ti8B5M7zytBJcCMOv3yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddu
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgfelheetkefgudetjeejkefhjeefvdeifedt
    hfehgffgheehieeliefhtdetheefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegurghvihgughhofiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepohhjvggurges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhoshgvrdgvgihpohhsihhtohekleesgh
    hmrghilhdrtghomhdprhgtphhtthhopegsrhgvnhgurghnrdhhihhgghhinhhssehlihhn
    uhigrdguvghvpdhrtghpthhtoheprhhmohgrrhesghhoohhglhgvrdgtohhmpdhrtghpth
    htoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghr
    hiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesph
    hrohhtohhnrdhmvgdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:7tQgZ4__jDwmlmgs7mEqsIQF0p1sg3uyQrpbTy6pkbUSwMXQn6VY-Q>
    <xmx:7tQgZzsOu0vnxPxM_t00cenO5O5rW2vmc7-vvTRqQLiwe0gcKYzuhg>
    <xmx:7tQgZ3GtuBYCZ4xXhyL3HWwSCwwbeYpAuALM45XeVMxz366Iw4KgNg>
    <xmx:7tQgZ6PwPu17K7F2Lz7hbFVwZlBKqd03Wl5vFovgF_Ngt9f8DvXQDw>
    <xmx:7tQgZ0O088gbC9KV9jEFNFnF1_GrMtQDi4wQsdl4ZN1L6vUgqmVF93ih>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Oct 2024 08:28:30 -0400 (EDT)
Date: Tue, 29 Oct 2024 05:27:28 -0700
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
Subject: Re: [PATCH v2 2/3] rust: macros: add macro to easily run KUnit tests
Message-ID: <ZyDUsFaZt2WViQL8@boqun-archlinux>
References: <20241029092422.2884505-1-davidgow@google.com>
 <20241029092422.2884505-3-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241029092422.2884505-3-davidgow@google.com>

Hi David,

On Tue, Oct 29, 2024 at 05:24:18PM +0800, David Gow wrote:
> From: José Expósito <jose.exposito89@gmail.com>
> 
> Add a new procedural macro (`#[kunit_tests(kunit_test_suit_name)]`) to
> run KUnit tests using a user-space like syntax.
> 
> The macro, that should be used on modules, transforms every `#[test]`
> in a `kunit_case!` and adds a `kunit_unsafe_test_suite!` registering
> all of them.
> 
> The only difference with user-space tests is that instead of using
> `#[cfg(test)]`, `#[kunit_tests(kunit_test_suit_name)]` is used.
> 
> Note that `#[cfg(CONFIG_KUNIT)]` is added so the test module is not
> compiled when `CONFIG_KUNIT` is set to `n`.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> [Updated to use new const fn.]
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> Changes since v1:
> https://lore.kernel.org/lkml/20230720-rustbind-v1-2-c80db349e3b5@google.com/
> - Rebased on top of rust-next
> - Make use of the new const functions, rather than the kunit_case!()
>   macro.
> 
> ---
>  MAINTAINERS          |  1 +
>  rust/kernel/kunit.rs | 11 +++++++++++
>  rust/macros/lib.rs   | 29 +++++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b77f4495dcf4..b65035ede675 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12433,6 +12433,7 @@ F:	Documentation/dev-tools/kunit/
>  F:	include/kunit/
>  F:	lib/kunit/
>  F:	rust/kernel/kunit.rs
> +F:	rust/macros/kunit.rs

I cannot find this file in this series, and it's not in the current
rust-next either.

(Did you do the same thing as I sometimes did: forget to `git add` a new
file?)

Regards,
Boqun

>  F:	scripts/rustdoc_test_*
>  F:	tools/testing/kunit/
>  
> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> index fc2d259db458..abcf0229ffee 100644
> --- a/rust/kernel/kunit.rs
> +++ b/rust/kernel/kunit.rs
> @@ -40,6 +40,8 @@ pub fn info(args: fmt::Arguments<'_>) {
>      }
>  }
>  
> +use macros::kunit_tests;
> +
>  /// Asserts that a boolean expression is `true` at runtime.
>  ///
>  /// Public but hidden since it should only be used from generated tests.
> @@ -269,3 +271,12 @@ macro_rules! kunit_unsafe_test_suite {
>          };
>      };
>  }
> +
> +#[kunit_tests(rust_kernel_kunit)]
> +mod tests {
> +    #[test]
> +    fn rust_test_kunit_kunit_tests() {
> +        let running = true;
> +        assert_eq!(running, true);
> +    }
> +}
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 939ae00b723a..098925b99982 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -10,6 +10,7 @@
>  mod quote;
>  mod concat_idents;
>  mod helpers;
> +mod kunit;
>  mod module;
>  mod paste;
>  mod pin_data;
> @@ -430,3 +431,31 @@ pub fn paste(input: TokenStream) -> TokenStream {
>  pub fn derive_zeroable(input: TokenStream) -> TokenStream {
>      zeroable::derive(input)
>  }
> +
> +/// Registers a KUnit test suite and its test cases using a user-space like syntax.
> +///
> +/// This macro should be used on modules. If `CONFIG_KUNIT` (in `.config`) is `n`, the target module
> +/// is ignored.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +/// # use macros::kunit_tests;
> +///
> +/// #[kunit_tests(kunit_test_suit_name)]
> +/// mod tests {
> +///     #[test]
> +///     fn foo() {
> +///         assert_eq!(1, 1);
> +///     }
> +///
> +///     #[test]
> +///     fn bar() {
> +///         assert_eq!(2, 2);
> +///     }
> +/// }
> +/// ```
> +#[proc_macro_attribute]
> +pub fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
> +    kunit::kunit_tests(attr, ts)
> +}
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 
> 

