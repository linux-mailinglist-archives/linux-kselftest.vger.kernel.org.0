Return-Path: <linux-kselftest+bounces-13837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F15E933F79
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 17:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4179A1F2419C
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 15:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25EC181B8D;
	Wed, 17 Jul 2024 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aY5EMzet"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E69B1E495;
	Wed, 17 Jul 2024 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721229764; cv=none; b=BTMMZu9i+U7SD9fzIZIXOEMq74HpLruMWJHKprJkiBLLCaUkrUhoavSDIrPw0KU90eVB9iMc8ezzwXxu5/I1dmBy2fmRmCechrwWKFK43IlcY9SIBiqUavaa9J4JljOEMtnCbwO4IAwn84SXN6sIvtmzbKl25JmQ/uQa0axUkGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721229764; c=relaxed/simple;
	bh=DlZBDGEE6rsw2BleIQnyaOUNz0azkcrEXDjsAnoaN78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TyD62w7qUpVHW76YiSqLbK+ZxiT3IQ4RqQHJnfA9OfHGKXqt0+lJJ0FaqOcPAZ9Rye/l8a5hyvssH3k8MrFsHuCV3U6u1YiN/1xqhvqwMsIZyJNVfSEXi8cRvjbkggCctjPJtpvTXEEr+DkiEj1W6RqZ/iWHFvoPPUgqlvBaqSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aY5EMzet; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-6b553b1a159so41098736d6.0;
        Wed, 17 Jul 2024 08:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721229762; x=1721834562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3eEdGd2VnoTge1W0GucF77sPRByUJDFTcPDf9F0DoH0=;
        b=aY5EMzetIgGGv0fjdZ2H2Wm/tizmqqYE3BW1bvKYYc8tO3dcD8/JsMZVfuxxtw7YXI
         rIUQrqh2t0qwch8EeRR75dgwZmfLiQpmtqNfKbXKxB1VQFcR8oko2b0E/QIsXv7aFwRo
         5tJrZ6oySPIe9MLZN1YhYwUzXyzxpxSRZE5GhwDWsMiJyIswmwwf2TDgIF/MEj/KzFCP
         3zzTyPgKDxZq/KWiQc1czbbfaDgPTT0bUGqbyzdRNgeYHKmrNYpDcmiwpuP8YWvM/F4O
         2CCmU5QB2n4hiVm+Zh1gmbW/N+tiWnARfti91ZOEUnGxuZaabZ9drR3VjhPEV3euYpTU
         DgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721229762; x=1721834562;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eEdGd2VnoTge1W0GucF77sPRByUJDFTcPDf9F0DoH0=;
        b=gGjO/osNDc8VmMpRTDblHYgaqAT28QkHArpkiShmRjOp5/BvRhcnfi5XrOo3AHXGes
         or2zwJA03RvMBiyOOi0VYyFejgJOsEGIIypih9CA5OY8upWYXs0AHnr4vlia3xjPdlxf
         TvH2APucpPfhD1E0/yHmzLhcyROk6iRS9lGvsDXL8SQA7frB9jVM54+8ybCpIlaiX4LB
         v5H7upJ5oJdeyY09Qzfvraoj0NK949NrCE/WYLmrA2PYWd/rhjgN2hSPJQP4YKbUdvyq
         QgNDvCSIIw2eBUHteubMqLFQgjaBHxu0Vsl7oQiG8fttJ6hmZdeWx8eQ/LJlmsYdvUV2
         xNsg==
X-Forwarded-Encrypted: i=1; AJvYcCUqLsmV/lfsAPOHhk//JW8+wQyCweGfg2za66dhLTWu9QMSKXrfOp9RPFBFPUPV59ojGTK3ytgJBXqxrSsgn7CGlW6J1t9VnbTUtB1yR7rbxmZ9BDyi9iUCQQHTWAxF8zHbiy/CU/BpWhoAI8R4apW9gP6CRXwFPXkXT6lyA3zdQQQhkeNVtKc7LZzSUnuKOqweRHywWp4z7JoewYR7d4TDZ7PBnOg=
X-Gm-Message-State: AOJu0Yz2cFvUPIzQJ6ksPdp0VdaAorIo301Ago1IQLah5vi3HpTOYHr/
	ZwX6nMCGxC5lE+hN3A3UiZ0m/1mYincD0tO7jnjU6+4nkdllNp1r
X-Google-Smtp-Source: AGHT+IF5CrrOa+jt+poegxq6FKrEqcYei7xwwuAPqnkmw08Qsn2PNEs5PLxrWWYeqPuVf4H8IwYuAg==
X-Received: by 2002:a05:6214:300d:b0:6b0:7413:e0e9 with SMTP id 6a1803df08f44-6b78ca515demr23395236d6.5.1721229762060;
        Wed, 17 Jul 2024 08:22:42 -0700 (PDT)
Received: from [192.168.158.7] ([207.35.255.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b76199f055sm42385176d6.65.2024.07.17.08.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 08:22:41 -0700 (PDT)
Message-ID: <604c64b6-2eff-42a0-91fe-211f7763ba6a@gmail.com>
Date: Wed, 17 Jul 2024 17:22:39 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: str: Use `core::CStr`, remove the custom `CStr`
 implementation
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
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
 <CANiq72=kchSt5XjAJRVgNWG-iNXbc2E64ojwsQYnB2pshULK1Q@mail.gmail.com>
 <52676577-372c-4a7f-aace-4cf100f93bfb@gmail.com>
 <CANiq72nbbtNp4vGGHkXVSgSW+WU=5Z9uGRO_LLg7+ezTqrZ_tQ@mail.gmail.com>
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
In-Reply-To: <CANiq72nbbtNp4vGGHkXVSgSW+WU=5Z9uGRO_LLg7+ezTqrZ_tQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16.07.24 09:44, Miguel Ojeda wrote:
> On Mon, Jul 15, 2024 at 6:12 PM Michal Rostecki <vadorovsky@gmail.com> wrote:
>>
>> @@ -71,11 +75,11 @@ macro_rules! kunit_assert {
>>                    //
>>                    // This mimics KUnit's failed assertion format.
>>                    $crate::kunit::err(format_args!(
>> -                    "    # {}: ASSERTION FAILED at {FILE}:{LINE}\n",
>> +                    "    # {:?}: ASSERTION FAILED at {FILE:?}:{LINE:?}\n",
>>                        $name
>>                    ));
>>                    $crate::kunit::err(format_args!(
>> -                    "    Expected {CONDITION} to be true, but is false\n"
>> +                    "    Expected {CONDITION:?} to be true, but is false\n"
>>                    ));
>>
>> The only practical difference in switching from `Display` to `Debug`
>> here is that the fallback kunit error messages are going to include
>> quotation marks around conditions, files and lines.
> 
> That is a fairly important difference -- the messages are intended to
> match the C KUnit ones.
> 
> Especially the file:line notation -- I don't think a user would expect
> to have quotes there (regardless of KUnit).
> 
> In general, even if we didn't need it right now, I think it is
> something we will need sooner or later.
> 

Alright, I will go with Trevor's suggestion and provide a `display()` 
method via an extension trait.

>> wording. My general point is that I've never seen `&mut str` being
>> exposed in any core/std API to the external user, mutation usually
>> implies usage of an owned String.
> 
> Not sure what you mean by exposed, but even if `&mut str`'s methods do
> not count (used via `String`), there is also
> `from_utf8_unchecked_mut()` that returns one, which is essentially the
> same idea as what we had here.
> 
> So I am not sure about the "The rule of Rust std" part in the new
> commit messages. And, to be clear, while the Rust standard library is
> a good reference to look into, sometimes we want/need to do things
> differently anyway (which is not really the case here given
> `from_utf8_unchecked_mut()`, I would say).
> 
> In this case, regardless of the standard library, personally I would
> have preferred to have a non-public function, but still have it (and
> properly documented), rather than open code the `unsafe` block with
> the casts.
> 

Fair enough. I will provide `from_utf8_unchecked_mut()` as a part of 
`CStrExt` in the next version.

>> I think the best solution would be leaving `c_str` macro for that. The
>> reason why I removed it is that the GitHub issue[0] mentions its
>> removal. But for that case, I think it makes sense to leave it. What do
>> you think?
> 
> Perhaps the issue was only taking into account the C string literal
> case? Benno may know more.
> 
> Generally speaking, replacing a clean line with a bigger `unsafe`
> block is something to be avoided.
> 
> Maybe a `c_stringify!` is what we need :)
> 

`stringify!` is not the only case where I ended up using `c_str!`. After 
addressing Björn's suggestion about taking Rust strings as arguments in 
`new_mutex!`, `new_condvar!` etc., `optional_name!` is also using 
`c_str!` in the following way:

   macro_rules! optional_name {
       () => {
           $crate::c_str!(::core::concat!(::core::file!(), ":", 
::core::line!()))
       };
       ($name:literal) => {
           $crate::c_str!($name)
       };
   }


So I think that leaving `c_str!` still makes sense, unless you have 
other suggestions, which are still easily applicable there. :)

> Cheers,
> Miguel

Cheers,
Michal

