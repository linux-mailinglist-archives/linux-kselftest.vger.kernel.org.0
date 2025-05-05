Return-Path: <linux-kselftest+bounces-32434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C51B0AA9CAD
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 21:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C961A80EE5
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 19:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0ED1C6FF6;
	Mon,  5 May 2025 19:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYEqpg3c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EF823CB;
	Mon,  5 May 2025 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746473697; cv=none; b=XZsIxJGd29HT2gkQjRCe7jBYQh6W6bjaMIG2SK0MP5YcEMu8QFShKFXy9K07e1Hf7V9e2/Bsf+7jqcKSYfLLXXUKd5Q+AWCsjYOFVwVV7+znW4rg3U5YdfUgJCBiMVPk/ykQt7TFUMiHSJiSxYIuTbSBDyatjpId0GO9mZqI1II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746473697; c=relaxed/simple;
	bh=R4UOYAFLSdII7+XphTMNWPVBpYzJxCWHQxa8/SgBsFI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwI6HjYu6PSZEbxMY9Oe2t5v6jAsphvlc5DzTKSk57xTKrgQZGUVEdU1eLmMEz8psBVfFVLl1zO767yhP792M+i+ugOIfTAju6W4uNjMq24XajhDVcSOAffzOJlDnpBtD2G1Bw//CcUeEc4hUvS7vUmSENwjWbK2yzLWSyLAztE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYEqpg3c; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c9376c4dbaso564836585a.0;
        Mon, 05 May 2025 12:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746473694; x=1747078494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkBn/ab9f6AA7W5UCEebQAelvR/PRTQoq/54e+igHhU=;
        b=BYEqpg3ci0tL7HuDEHTZa8G54OnqKeV8kkIIFJ7dmra8wfBnoMK9E8jejecxtRyhex
         SFa6wxWG6qA0BYECaij7N/AoLYUlZTcsBBLnPP25s7YtIZhP8ZZHhDW7J6knP+6LM25N
         0waZ5XUX/JuoNg5Y0bo3sM037nptGWDetfSiR7q3vB35d+h0Zmb46UXZ9p0nUJOmm4t/
         BOKNb0l0ZSo+4UtJs6cAYgA9rjUKZAPr5J9PWlu3TDtEOVxLAaL1VYbQE1L+0nDA80/K
         xcZAGZz/arRFT7xrTJOpjmBWyUjbPJBkuNP5ydOkugCdCzAw7ityVwRoSHaHRs3AZr7K
         6KIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746473694; x=1747078494;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkBn/ab9f6AA7W5UCEebQAelvR/PRTQoq/54e+igHhU=;
        b=OLX9qEFzhjd99urTyUEXJRvB8uJZ9/Ir29FglUbaqCEfrsWZre6Hz07CVq00QRUIDG
         9eH9dps5nx2/nTv5KQO4/U1ppfgeXv7pNjXBK5MYaCZgbaLBU4KXDOXVYj5RysEKcNfF
         xavtiM8LcH/ZWXGltDhS+njIb4ztMy1gOBPjoQEadVMaI4bokK+eG3LzHWWYm1EeGAz4
         1KT78vr3ysfZER8NayUcUo9G3Q9rKWM6vZDzMOxpavhkHz9E2VkYTaB5BLjRio10PxnW
         sx5/wuRU/EnAftOG0RIr+hw0wksKPThEEZZcGhMwtThHv4I/wBx5PLcSSAUaSEE4bvce
         eUlg==
X-Forwarded-Encrypted: i=1; AJvYcCVNZPCpWfBpisdNqlnuIuqXKj4PuTi/o6h/O+hZlgre/ApzwI+mkigQW4huoffM8VJNRQVVukDFUHEdVK4=@vger.kernel.org, AJvYcCVVCAtoHriIfSOTW6iA1tbj1a+ZEYpD0OlV7ZgEs4eF7qOON8gyMCmAZJBkt9Txgg041dZJHq1OY80B7YqLrXUQ@vger.kernel.org, AJvYcCXjYxZKljZRcHO/xdg7kr3Zj1bURdM81qNrfySUI6V6pc0WsSTUdJmQT/i2GKt7vp7v9haN/cP48zisP0EDl2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbhcDF841CTa1l4TNcc5JZUNjTy1Or/buV1D8L3SrWgdm4qNiu
	JNho7BKkPr7+ri3evfBCpUc3pjrYp0RiU844BfDAlT8B8Q5P+F5A
X-Gm-Gg: ASbGncvOOJapLx7PGAZ7VgLSRy8ykIi5TKPPI1MChqxw8bj57FK8uN6HoJEyZhk4cfC
	CRExEHvTCrSiSnPWqycJsu043Yc8LmYTR5RLszqG3SMSNrjWEVi+M/D8ZhpAlK5SFnoISlt7Jt9
	3RfzQnvoEdS0rkbt/oNg1XrW+D+kKPfci0L8u6p0HglZgNUN93mlWOw8cB44uxqvl9q3UBYJqv3
	D7Yqt33Kw9C0ocvEFegco3SerXRCbnJy8UMkaXLgkOE+OkqlNm2A54AA5g0OATG2rFHBnLsDfyW
	d/z3FbUwFS0JvqKiCOR2KOdu92R7jfkWZpxn1u841/yj5WYbdxwOtRIONxJNB8zrM1OVZuHEJ4b
	IdRfKEncb0VqOiNiSra30eCbeFMxm0IQ=
X-Google-Smtp-Source: AGHT+IFY12NsRRcgW0xx+lO9IySSe0Y4a8h3F+41ev4UQvcjKPFIvM2ToqA8JyqXddvLXXcDLCEXng==
X-Received: by 2002:a05:620a:6105:b0:7c7:c6e9:963c with SMTP id af79cd13be357-7caf04c142fmr87551785a.4.1746473694490;
        Mon, 05 May 2025 12:34:54 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cad23b5278sm606919985a.1.2025.05.05.12.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 12:34:54 -0700 (PDT)
Message-ID: <681912de.050a0220.383f17.18c4@mx.google.com>
X-Google-Original-Message-ID: <aBkS25IAZXiyXeXZ@winterfell.>
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8B8F3120007E;
	Mon,  5 May 2025 15:34:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 05 May 2025 15:34:53 -0400
X-ME-Sender: <xms:3RIZaENOKcV_V4pchMDIGpgqOT8XeYyK7jqMEa--H2Sfepw08f8ijg>
    <xme:3RIZaK-goJa0QuWpIgmKvY5jgUBAc87hW5au3mVlx9jIUH-AYw9c88C3LDlN6Ame6
    ChzIm-TziuNeJNc_Q>
X-ME-Received: <xmr:3RIZaLT8dU3hIUe4mBMvj7PC8hJ4ISIQfR0g0qsKehaR0zeBobQnmGEWsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeduleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudekpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgughhofiesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    sghrvghnuggrnhdrhhhighhgihhnsheslhhinhhugidruggvvhdprhgtphhtthhopegrlh
    gvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhmohgrrhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhhnihhtqdguvghvsehgohhoghhl
    vghgrhhouhhpshdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvth
    dprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:3RIZaMu8GU9Ixwt_lnrfB4AOZGU4ehJiJajRp5xMVPmQiJJXIwMR5g>
    <xmx:3RIZaMeI-x4I7P7SZLXK0Dwz3XQnfvQVaJ_THw1O1SNzSzJBci_P5A>
    <xmx:3RIZaA2jVlhadXx5BUw9i9mSQsvMTHBgGYZ8_1YVGzakXFGH0f3tqA>
    <xmx:3RIZaA-s-nsYuLKNr6F4LFSWwXc7q5nZq_aELczlW1uCS0L1ELdSLw>
    <xmx:3RIZaD-J1ajwYTRjr-wt8yw2pWXopfcpzZwsO8yCWY4bEDWi68U8qru9>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 15:34:53 -0400 (EDT)
Date: Mon, 5 May 2025 12:34:51 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Alex Gaynor <alex.gaynor@gmail.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 2/7] rust: kunit: support checked `-> Result`s in KUnit
 `#[test]`s
References: <20250502215133.1923676-1-ojeda@kernel.org>
 <20250502215133.1923676-3-ojeda@kernel.org>
 <CABVgOSm8T+_kXY78sioUHEcG7rYApfWK2Gfxkrvw94Dz57G0oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSm8T+_kXY78sioUHEcG7rYApfWK2Gfxkrvw94Dz57G0oQ@mail.gmail.com>

On Mon, May 05, 2025 at 02:02:09PM +0800, David Gow wrote:
> On Sat, 3 May 2025 at 05:51, Miguel Ojeda <ojeda@kernel.org> wrote:
> >
> > Currently, return values of KUnit `#[test]` functions are ignored.
> >
> > Thus introduce support for `-> Result` functions by checking their
> > returned values.
> >
> > At the same time, require that test functions return `()` or `Result<T,
> > E>`, which should avoid mistakes, especially with non-`#[must_use]`
> > types. Other types can be supported in the future if needed.
> >
> > With this, a failing test like:
> >
> >     #[test]
> >     fn my_test() -> Result {
> >         f()?;
> >         Ok(())
> >     }
> >
> > will output:
> >
> >     [    3.744214]     KTAP version 1
> >     [    3.744287]     # Subtest: my_test_suite
> >     [    3.744378]     # speed: normal
> >     [    3.744399]     1..1
> >     [    3.745817]     # my_test: ASSERTION FAILED at rust/kernel/lib.rs:321
> >     [    3.745817]     Expected is_test_result_ok(my_test()) to be true, but is false
> >     [    3.747152]     # my_test.speed: normal
> >     [    3.747199]     not ok 1 my_test
> >     [    3.747345] not ok 4 my_test_suite
> >
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > ---
> 
> This is a neat idea. I think a lot of tests will still want to go with
> the () return value, but having both as an option seems like a good
> idea to me.
> 

Handling the return value of a test is definitely a good thing, but I'm
not sure returning `Err` should be treated as assertion failure
though. Considering:

    #[test]
    fn foo() -> Result {
        let b = KBox::new(...)?; // need to allocate memory for the test
	use_box(b);
	assert!(...);
    }

if the test runs without enough memory, then KBox::new() would return a
Err(ENOMEM), and technically, it's not a test failure rather the test
has been skipped because of no enough resource.

I would suggest we handle the `Err` returns specially (mark as "SKIPPED"
maybe?).

Thoughts?

Regards,
Boqun

> Reviewed-by: David Gow <davidgow@google.com>
> 
> Cheers,
> -- David
> 
> 
> >  rust/kernel/kunit.rs | 25 +++++++++++++++++++++++++
> >  rust/macros/kunit.rs |  3 ++-
> >  2 files changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> > index 2659895d4c5d..f43e3ed460c2 100644
> > --- a/rust/kernel/kunit.rs
> > +++ b/rust/kernel/kunit.rs
> > @@ -164,6 +164,31 @@ macro_rules! kunit_assert_eq {
> >      }};
> >  }
> >
> > +trait TestResult {
> > +    fn is_test_result_ok(&self) -> bool;
> > +}
> > +
> > +impl TestResult for () {
> > +    fn is_test_result_ok(&self) -> bool {
> > +        true
> > +    }
> > +}
> > +
> > +impl<T, E> TestResult for Result<T, E> {
> > +    fn is_test_result_ok(&self) -> bool {
> > +        self.is_ok()
> > +    }
> > +}
> > +
> > +/// Returns whether a test result is to be considered OK.
> > +///
> > +/// This will be `assert!`ed from the generated tests.
> > +#[doc(hidden)]
> > +#[expect(private_bounds)]
> > +pub fn is_test_result_ok(t: impl TestResult) -> bool {
> > +    t.is_test_result_ok()
> > +}
> > +
> >  /// Represents an individual test case.
> >  ///
> >  /// The [`kunit_unsafe_test_suite!`] macro expects a NULL-terminated list of valid test cases.
> > diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
> > index eb4f2afdbe43..9681775d160a 100644
> > --- a/rust/macros/kunit.rs
> > +++ b/rust/macros/kunit.rs
> > @@ -105,8 +105,9 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
> >      let path = crate::helpers::file();
> >      for test in &tests {
> >          let kunit_wrapper_fn_name = format!("kunit_rust_wrapper_{}", test);
> > +        // An extra `use` is used here to reduce the length of the message.
> >          let kunit_wrapper = format!(
> > -            "unsafe extern \"C\" fn {}(_test: *mut kernel::bindings::kunit) {{ {}(); }}",
> > +            "unsafe extern \"C\" fn {}(_test: *mut kernel::bindings::kunit) {{ use kernel::kunit::is_test_result_ok; assert!(is_test_result_ok({}())); }}",
> >              kunit_wrapper_fn_name, test
> >          );
> >          writeln!(kunit_macros, "{kunit_wrapper}").unwrap();
> > --
> > 2.49.0
> >



