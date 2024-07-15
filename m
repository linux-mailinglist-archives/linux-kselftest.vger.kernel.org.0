Return-Path: <linux-kselftest+bounces-13734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF19931851
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 18:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6F11F21B7A
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 16:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0D51B813;
	Mon, 15 Jul 2024 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eL3c5aee"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04721CD3F;
	Mon, 15 Jul 2024 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721060134; cv=none; b=iFPZHZP9CMqcxysObzatxvMi6uRbzLL+BlmWxdIAzbO3v3ZeWtEtBzbpmoO1OcXC7angdk0iddVPS6PnL49cvml0RJT3RMXx0YsjBq3wJazTkVqzUKn9awT3r9BKL4SRtMDNOVrRxtL6qjC4yyKBQVAeACmD9hucVjBXCNA8fJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721060134; c=relaxed/simple;
	bh=MNcH4FQYV6xUFbte1qhFhl/P8o5Nh+WNSfGIeuyORq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pkj3fEtoGexUhVKPtggR5WPM5wKPq68MhGVPgXFOOtC4OzfaU4vIKuacnR1jtnT6hsl4cY+i31PJeaTh1xmUyqWmKFtK6yDGJMgAr77lIaybCxBbV3Y65eC7VtQH4ibtjye+EBNIugHSvuyUGixPuCrDsS6VPq8dGppLuPqAr5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eL3c5aee; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-6b5def3916bso26929446d6.3;
        Mon, 15 Jul 2024 09:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721060131; x=1721664931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B86oylWeQ/+rBCNttrbAo/LkztHTkh3FQpXO6sNcI50=;
        b=eL3c5aeeoIMeXrahv3kWnG6Naa8F53YPMXaZklAhS7Dxmh1vYGvGsvBLdho8SotvTx
         ytFPDiFmedUGmFx7ijTbg15GVvXKK5UgkQi6AOjdiga6DCZ5kfkCkK1QgawNqjBhPTo9
         b+y+USuQNp/tRs6Mxu7wvnq77Nby3az1zg3mlARdfr9vi2UGSm43QCfxG4zbkbeklSqB
         /zqBDlqA4oNJiakSTs2YGdSoGVZ19CAnCgtBxA2pYUICOrK1of7wxgXmXJGmTWHSDnpy
         zP8Y+Se3ovU42xB+UIHwU1jfIGTN5PB2hMF7EUFX1K3Oaw3jwvSfHeaG2vTDRUC3YfcR
         f1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721060131; x=1721664931;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B86oylWeQ/+rBCNttrbAo/LkztHTkh3FQpXO6sNcI50=;
        b=Qmz6V/bY88mzgnrGEkwyF5H3BtSoA0LRaX7Q0KQ3kQUfrXijIN/PoXEVqzTBlmc1c3
         cjU/F68y7ud5xOCgdJTkwNJ2FBydjfg2Md/wJDhhIsEwmd12srz7vYiFcBsYGowilBmm
         +hu4XERHoRlx/AffFXzHP593EWkROxZb9ZZ3/YcvPc6AgaZz3v39K+ecPi/oChSjz+GV
         jwBpSCeYurDDiO4qXTBG8ghZmxazYiewOjF0ebnrpsboVDhSWX0bBTp39sRHtnVo8x8/
         gNzwVbMXzJzVvFNIjSMWPGdhrwa/H/Sn2s1h8DL5l8YtcWwoZQw5ea4Vw10KeiCeoqkb
         BZog==
X-Forwarded-Encrypted: i=1; AJvYcCVc31DpVziF1UWUtchpj0f2ADw9GyqBB6xgeuzZ+hpKdVEOJYj7z/fV//Pbc76bndVUN/zWOd/8T1U3y+mXi9tVjg2hrG0LFiV8P1mf/38k+ximde+RKixgDemQsjZN4TgXEKQat+062ZwzEGwwZPKrFD7spBu3tJ13EhddIdw4yzn256/CcYvxClb/PKe+EBggnkxm9Kw2jyLuCw5KxLKlGGXWSOM=
X-Gm-Message-State: AOJu0YyRBU2F+1j8LM9WPtrvTZrtUBixPrVUEyfKKUUq8aW+xEvQZnzs
	CbLuEApH3qXaLQQ5vZUKiJsN20ZPXuKeMXwfne9/NVto2UOyck8w
X-Google-Smtp-Source: AGHT+IHT78LgI19wps2RLAxgCax2XEyj6SW9H06cyh7CoTL43upSi0hM42iNIXeFEbo/SBCPg4jFxg==
X-Received: by 2002:a05:6214:29e1:b0:6b0:8e1d:f720 with SMTP id 6a1803df08f44-6b77df2b7ddmr1305126d6.59.1721060130683;
        Mon, 15 Jul 2024 09:15:30 -0700 (PDT)
Received: from [192.168.158.7] ([207.35.255.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7733ee169sm11594636d6.26.2024.07.15.09.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 09:15:30 -0700 (PDT)
Message-ID: <be2586e2-8d85-426e-975d-6f57da4ccf75@gmail.com>
Date: Mon, 15 Jul 2024 18:15:28 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: str: Use `core::CStr`, remove the custom `CStr`
 implementation
To: =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross
 <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Finn Behrens
 <me@kloenk.dev>, Manmohan Shukla <manmshuk@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>,
 Laine Taffin Altman <alexanderaltman@me.com>,
 Danilo Krummrich <dakr@redhat.com>, Yutaro Ohno <yutaro.ono.418@gmail.com>,
 Tiago Lam <tiagolam@gmail.com>, Charalampos Mitrodimas
 <charmitro@posteo.net>, Ben Gooding <ben.gooding.dev@gmail.com>,
 Roland Xu <mu001999@outlook.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, netdev@vger.kernel.org, llvm@lists.linux.dev
References: <20240714160238.238708-1-vadorovsky@gmail.com>
 <S-L4QE4MFYzY1ba0fdkJYuAVIkZHxxYB6Jk9XPFuo3ZdbvNxtfN_mCFc5oNPfTu2X17vvyPUStAviAUAzeKlCGxwRM-VbC4aPUGBGtDQCcU=@protonmail.com>
 <df092baf-03a5-4b4a-ab8b-ee7a5677c172@gmail.com>
 <T4cW5BFYytkMlTR5e2C2FfFJ5Z8P5XPw5dEsTQ2V-hoAo5yZkeYLSU3GvVCTH1Ga3f-mbPvEKZxOEWT7E1-xWu4EDE6-jCoQj3If-qCKCHA=@protonmail.com>
Content-Language: en-US
From: Michal Rostecki <vadorovsky@gmail.com>
Autocrypt: addr=vadorovsky@gmail.com; keydata=
 xsBNBGYJcUEBCAD3ciAzHQ8NElYQtsiPZ9NjsR7ttfihe0FM+PDT+6cChjFLQ8qO/1zEL5mh
 YaLbkjitrIYARhmo3lRDq3+G4L5+gRVExm9Rd98PcQy2P9F8shxI/msC50i1Fb9N4D0pP8Hx
 hhZ/or+2mbokZh8Qc9RdjynXRXAezhOFN4+0L2jkN7fjTO1IArl+TirXx+cvhQUbwKyyJlGL
 Kldvue2EqU4maZ+KIUs5di3kZgDPLILzvBqX9TLtwEMAkNY1uMCKK+C2aihap19OjoK0qOYj
 IahVHjqGL+Mb/Ga7jxMGr2TFeQEcwIgvdRiVVLtu+uiaRKqULGokBL3l9gprtBZWdLq7ABEB
 AAHNJk1pY2hhbCBSb3N0ZWNraSA8dmFkb3JvdnNreUBnbWFpbC5jb20+wsCXBBMBCABBFiEE
 3RZt3oLrB5kpFLy14qU49yah1xEFAmYJdCQCGwMFCQHhM4AFCwkIBwICIgIGFQoJCAsCBBYC
 AwECHgcCF4AACgkQ4qU49yah1xFuDQf+NE2Oy6zF+uVh3vtidkfacCSMnu1QxojJHB8C1/Ep
 g4JU5hPcG9hC+HrMs5/Hqs7DOike9bZjhpEmnW4DIeI7Wy3t1Qf7A8EOzS0nrMgbX8TnkEon
 zMBBqiNp3VVVcltRJtc58xMP8K3yu6Ty2Q8e6GWdL5bqDr9gshb+vWu8inh5CullsGRJFJl0
 BfSdDKAbpH3NdEoWnL4JvFphpouh2vhd/ScvfNAQcuyBn3cbCyQdjNTgRVBkBNDEYCaWLVqP
 r4IU0JNjgk+cTLbyFmgn2++bWoIICGrAeWGruSpl7UGJ2PdJokWI9zp5UqSCezejDS53yhkU
 GsCrF7LrTceB6c7ATQRmCXFBAQgA2yrqjTKvL7VJKi/NNcpQ7EvAEm6omO+O4wQltdpybaxe
 mbLT0vZTH6rjZba28ixZmFHtwOjzNNtabmb4uK+nxs0BkVBpRvJNJ0LM1ydGYZQ46Sbvr1dE
 7yWDkkG1CjmXYGd5I2iqx+ATbdrtzDGWLsvDXd/yEaO9dxAR+LqGOg1HdgE9Hhmuv8BRYSCL
 vnXaMA7Orq9oAmu+Q5q9TT3aZGMdBFdcoUNSVPX82uIYXjDaXj0Del8tluAHLf3oV7ZXEgOx
 c6OpRY3+8Pr9//UtfoaHNOjoKFNyPaIUf5U1+E9J0UoDm8m1usrwnghg6yRyPhczhCOvbYNL
 hQ6TiImvowARAQABwsB8BBgBCAAmFiEE3RZt3oLrB5kpFLy14qU49yah1xEFAmYJcUECGwwF
 CQHhM4AACgkQ4qU49yah1xHetgf9FpI4Y+okwFRIqRa6WJ8jhz6us+oYKedftr313NwerUB5
 8nnhK0YWkZWZMuu5B4LCMiv71Ugqlc7ahBy5sQx/acRPe+NiYpwiN/pWrv7njaA6evDieXL8
 jc3j+xy4fsi861BWJXaurWQtLMXyHBUmdJ+StU7tscYTPe4fN1fdkBh0SreZxLfvp/+SMRQk
 g9PmXb1BMZdw8gWghPAbYg5bfCzXF9iZp4bmjuCENfwG4zmnYJzR6uTI0reqECo6Ee7NjOQ7
 qKy29wW+kVnEjX481iCEUmqKHEaQB08Ueb45If09fThw1baHLAk6bFk5cabMtD3JbWEifa6M
 RS+eXZNwwQ==
In-Reply-To: <T4cW5BFYytkMlTR5e2C2FfFJ5Z8P5XPw5dEsTQ2V-hoAo5yZkeYLSU3GvVCTH1Ga3f-mbPvEKZxOEWT7E1-xWu4EDE6-jCoQj3If-qCKCHA=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.07.24 17:56, Björn Roy Baron wrote:
> On Monday, July 15th, 2024 at 17:46, Michal Rostecki <vadorovsky@gmail.com> wrote:
> 
>> On 14.07.24 19:01, Björn Roy Baron wrote:
>>> On Sunday, July 14th, 2024 at 18:02, Michal Rostecki <vadorovsky@gmail.com> wrote:
>>>
>>>> `CStr` became a part of `core` library in Rust 1.75, therefore there is
>>>> no need to keep the custom implementation.
>>>>
>>>> `core::CStr` behaves generally the same as the removed implementation,
>>>> with the following differences:
>>>>
>>>> - It does not implement `Display` (but implements `Debug`).
>>>> - It does not provide `from_bytes_with_nul_unchecked_mut` method.
>>>>     - It was used only in `DerefMut` implementation for `CString`. This
>>>>       change replaces it with a manual cast to `&mut CStr`.
>>>>     - Otherwise, having such a method is not really desirable. `CStr` is
>>>>       a reference type
>>>>       or `str` are usually not supposed to be modified.
>>>> - It has `as_ptr()` method instead of `as_char_ptr()`, which also returns
>>>>     `*const c_char`.
>>>>
>>>> Rust also introduces C literals (`c""`), so the `c_str` macro is removed
>>>> here as well.
>>>>
>>>> Signed-off-by: Michal Rostecki <vadorovsky@gmail.com>
>>>> ---
>>>>    rust/kernel/error.rs        |   7 +-
>>>>    rust/kernel/init.rs         |   8 +-
>>>>    rust/kernel/kunit.rs        |  16 +-
>>>>    rust/kernel/net/phy.rs      |   2 +-
>>>>    rust/kernel/prelude.rs      |   4 +-
>>>>    rust/kernel/str.rs          | 490 +-----------------------------------
>>>>    rust/kernel/sync.rs         |  13 +-
>>>>    rust/kernel/sync/condvar.rs |   5 +-
>>>>    rust/kernel/sync/lock.rs    |   6 +-
>>>>    rust/kernel/workqueue.rs    |  10 +-
>>>>    scripts/rustdoc_test_gen.rs |   4 +-
>>>>    11 files changed, 57 insertions(+), 508 deletions(-)
>>>>
>>>
>>> [snip]
>>>
>>>> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
>>>> index 68605b633e73..af0017e56c0e 100644
>>>> --- a/rust/kernel/init.rs
>>>> +++ b/rust/kernel/init.rs
>>>> @@ -46,7 +46,7 @@
>>>>    //! }
>>>>    //!
>>>>    //! let foo = pin_init!(Foo {
>>>> -//!     a <- new_mutex!(42, "Foo::a"),
>>>> +//!     a <- new_mutex!(42, c"Foo::a"),
>>>
>>> That we need a CStr here seems a bit of an internal implementation detail. Maybe
>>> keep accepting a regular string literal and converting it to a CStr internally?
>>> If others think what you have here is fine, I don't it mind all that much though.
>>>
>>
>> The names passed to `new_mutex`, `new_condvar`, `new_spinlock` etc. are
>> immediately passed in the FFI calls (`__mutex_init`,
>> `__init_waitqueue_head`, `__spin_lock_init`) [0][1][2]. In fact, I don't
>> see any internal usage, where using Rust &str would be beneficial. Am I
>> missing something?
>>
>> Converting a &str to &CStr inside `Mutex::new` or `CondVar::new` would
>> require allocating a new buffer, larger by 1, to include the nul byte.
>> Doing that for every new mutex or condvar seems a bit wasteful to me.
> 
> The names passed to `new_mutex!` and such are literals known at
> compile time. This means we can keep adding the nul terminator at
> compile time without allocating any extra buffer. Basically just
> adapting the current implementation of `optional_name!` to produce an
> `core::ffi::&CStr` rather than a `kernel::str::CStr` from a regular
> string literal is enough to avoid having to explicitly use C string
> literals in those macro invocations. This way users don't need to
> know that internally an `&CStr` is used.
> 

OK, good point, I can indeed handle that in `optional_name!`.

>>
>> [0]
>> https://github.com/Rust-for-Linux/linux/blob/b1263411112305acf2af728728591465becb45b0/rust/kernel/sync/lock/mutex.rs#L104
>> [1]
>> https://github.com/Rust-for-Linux/linux/blob/b1263411112305acf2af728728591465becb45b0/rust/kernel/sync/condvar.rs#L111
>> [2]
>> https://github.com/Rust-for-Linux/linux/blob/b1263411112305acf2af728728591465becb45b0/rust/kernel/sync/lock/spinlock.rs#L103
> 
> [snip]

