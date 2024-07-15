Return-Path: <linux-kselftest+bounces-13733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70926931844
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 18:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67FE1F2237F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 16:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF72262A8;
	Mon, 15 Jul 2024 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZmJXSBl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB8781AC4;
	Mon, 15 Jul 2024 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059930; cv=none; b=RE3s1RV6AodELpjD1EF1AywDb36Ga9uXl+kzs8/sV+7Aod5sp2wkr5a5RfC89us+YbFS5dOV4UOSRLqmjuaNHFqHKFovbbOsqbDc6Xqd3nsCevnGfXQYTr2vpnE/fGDIblWXSXVYPUN9DVnfowfSXGmtZV74jMygBCvncvE5cw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059930; c=relaxed/simple;
	bh=VeGWgs5qYtNLeJW++1CFVrRa2v+g8OjQ7awCLmUdmAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCZM/HudLOida3Xt3T8M9JH++i/P0DMgbb5ztc2oOdUWq9zywshFjfTmqYI4DiEKnzYIl14RCthDbhRCaBaIlKsctvLsadKAKEjVGPe70+mj3V4rbajcV14oNW/M5fHSXDslfXt6MayQsSx2yuan4EIKfjIec9u8d48UiY5Mccw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZmJXSBl; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-dfef5980a69so4635750276.3;
        Mon, 15 Jul 2024 09:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721059928; x=1721664728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CXkzYwfI+Ccb9Zhn7YIC8xVe7PeMwRt7TpoRUvrX0qY=;
        b=jZmJXSBlq6YtJSRXMAtetJQjXc1p7IgoybCIolx3FzHbL+4TeM4M4qtcnERBVT8FjD
         4w7/AgAMPk2jBZ94q9M8O/AuY53uei1lMkqyPDu+7TEYdBmn+mfU7fx7YhL9kLXL7USx
         +k3bQlQ0eGaVPW/3bBz2fLXHXWspiCQmOoWglBM6g1Yt8g2YbkJ4jiHvtvuO+jTESiPW
         BcCbXYhMbLsk+s30I1BtnNYcn18BnyYKCnMceVwLHsROpBZsl1Km8EyOCwDSmeZzdHgT
         QzjvW1Lzy6YhBaKwSvWnTddhm1WbdBH745rAlfETRla/xSLEHpazCvYyQwZxLgCv90lO
         h1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721059928; x=1721664728;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXkzYwfI+Ccb9Zhn7YIC8xVe7PeMwRt7TpoRUvrX0qY=;
        b=jxfNki19XublVrBGBtJoOLzFBpm/BqQStYsJPBInZcW6WGLXcmtON7C8Fyp+68o7BY
         7tl7rSxEzmbK6KTUszESwp5fsjSlTb3tCitqdgL0JSRCPa8cQoYEFiNLLZZ+v4awa0aH
         SbS1SlJOgXNCleoRbpn1I79096fLkQpYiP8VpFbx8QboCn6ti2+/X9b2PLHXUE5ujYJ1
         1uK4IIDnAX0uhplYt+oa+A33odt3TTBKbGPIz6QKQucb7lvBMjv2CLJ/aUfrsW5qzxTB
         owFBmw8+5kOj93pKSSOfIFnCfifhRCmkOK5i4VhFRA/6t4qwk5mYsnb/zblY7ec1O9he
         /JDA==
X-Forwarded-Encrypted: i=1; AJvYcCU1MbgG0hx8VBKrvDPAlF2tFdtVeGBVdMUF7Ci0VWB7xZAFUpYdmtVD8xCxLSoaGBjYvIVZBa/z3rz/f/AS9xu7cG710/FGF9pH/ALtOax/hAteMR522KRFY/2X9NBRblbKpqzMv7b/vbeyxWGma1FnteogiD04wN6dcLx4U98iWLSxTlBSiIiyipmAwqEZ6ds6DkZfVnwRnOVV7vmXo/RPFz6zoJA=
X-Gm-Message-State: AOJu0YxSa9/8DwFPlq+KjSVIpq91fiL/jrXWNsizzntyQMyJXTx/4Yix
	FjKC15aASmDFKN85Dd7Q0HKF9Y3jyU2jh5pxF8zvqanqsOM+j0gq
X-Google-Smtp-Source: AGHT+IEdxk1miMqbRW7Ci7uoCQR8F8T+oixSF87KSPrtc8Puu4mB1k7M3RQfsgulRdZtBjWbxnpI4Q==
X-Received: by 2002:a05:6902:114d:b0:e03:52c6:b338 with SMTP id 3f1490d57ef6-e05d3abf453mr47093276.19.1721059927698;
        Mon, 15 Jul 2024 09:12:07 -0700 (PDT)
Received: from [192.168.158.7] ([207.35.255.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b761a0f802sm22574616d6.82.2024.07.15.09.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 09:12:07 -0700 (PDT)
Message-ID: <52676577-372c-4a7f-aace-4cf100f93bfb@gmail.com>
Date: Mon, 15 Jul 2024 18:12:05 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: str: Use `core::CStr`, remove the custom `CStr`
 implementation
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
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
 <CANiq72=kchSt5XjAJRVgNWG-iNXbc2E64ojwsQYnB2pshULK1Q@mail.gmail.com>
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
In-Reply-To: <CANiq72=kchSt5XjAJRVgNWG-iNXbc2E64ojwsQYnB2pshULK1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.07.24 19:30, Miguel Ojeda wrote:
> Hi Michal,
> 
> Thanks for the patch! Some notes below...
> 
> On Sun, Jul 14, 2024 at 6:02 PM Michal Rostecki <vadorovsky@gmail.com> wrote:
>>
>> `CStr` became a part of `core` library in Rust 1.75, therefore there is
>> no need to keep the custom implementation.
> 
> It would depend on the differences, right? i.e. for a reader, is this
> meant to imply there is no meaningful difference in what you point out
> below?
> 

Alright, I will remove the second part of the sentence.

>> - It does not implement `Display` (but implements `Debug`).
> 
> One question that comes up when reading this is: are we losing
> `Display`'s output form?
> 

Yes, we are losing the `Display` trait implementation by switching to 
`core::ffi::CStr`.

I was thinking whether I should keep `kernel::str::CStr` as a wrapper, 
just to keep the `Display` implementation. I could still do that if you 
want. I'm also open for other solutions.

The reason why I decided to not do that and go ahead without `Display` 
is that it was used only in rust/kernel/kunit.rs inside `kunit_assert`, 
for formatting the file and path the error message. This diff:

@@ -71,11 +75,11 @@ macro_rules! kunit_assert {
                  //
                  // This mimics KUnit's failed assertion format.
                  $crate::kunit::err(format_args!(
-                    "    # {}: ASSERTION FAILED at {FILE}:{LINE}\n",
+                    "    # {:?}: ASSERTION FAILED at {FILE:?}:{LINE:?}\n",
                      $name
                  ));
                  $crate::kunit::err(format_args!(
-                    "    Expected {CONDITION} to be true, but is false\n"
+                    "    Expected {CONDITION:?} to be true, but is false\n"
                  ));

The only practical difference in switching from `Display` to `Debug` 
here is that the fallback kunit error messages are going to include 
quotation marks around conditions, files and lines.

> Also, for clarity, please mention if there is a difference in the
> output of the `Debug` ones.
> 

There isn't any difference, I will mention that.

>>    - Otherwise, having such a method is not really desirable. `CStr` is
>>      a reference type
>>      or `str` are usually not supposed to be modified.
> 
> The sentence seems to be cut, and it should probably try to explain
> better why it is undesirable, i.e. if it is needed for something like
> `DerefMut`, then it seems better to have a method.
> 

Regarding `DerefMut` implementation for `CString` - we don't need it. Or 
at least - removing it (after my CStr patch), does not break anything. 
If that's fine for you, I'm going to remove it in v2 all together.

About why having `&mut CStr` is undesirable - I will try to find better 
wording. My general point is that I've never seen `&mut str` being 
exposed in any core/std API to the external user, mutation usually 
implies usage of an owned String.

>> -            static CONDITION: &'static $crate::str::CStr = $crate::c_str!(stringify!($condition));
>> +            static CONDITION: &'static core::ffi::CStr = unsafe {
>> +                core::ffi::CStr::from_bytes_with_nul_unchecked(
>> +                    core::concat!(stringify!($condition), "\0").as_bytes()
>> +                )
>> +            };
> 
> This looks worse after the change and requires `unsafe`. Can we do
> something to improve it?
> 

I think the best solution would be leaving `c_str` macro for that. The 
reason why I removed it is that the GitHub issue[0] mentions its 
removal. But for that case, I think it makes sense to leave it. What do 
you think?

[0] https://github.com/Rust-for-Linux/linux/issues/1075

>> +        // SAFETY: Casting to CStr is safe because its internal representation
>> +        // is a [u8] too.
>> +        unsafe { &mut *(self.buf.as_mut_slice() as *mut [u8] as *mut CStr) }
> 
> I see Björn commented on this already -- `CStr`'s layout is not
> guaranteed (and is a `[c_char]` instead).
> 
> Also, the casting is not what is unsafe, so perhaps it may be clearer
> to reword the comment.
> 
> In addition, please format comments as Markdown.
> 

Good point, I will fix the comment.

>> -//!             work <- new_work!("MyStruct::work"),
>> +//!             work <- new_work!(c"MyStruct::work"),
> 
> I agree as well that it may make sense to simplify the callers as much
> as possible, unless there is a need to have that flexibility.
> 

I already replied to Björn - names passed to `new_work!`, `new_mutex!` 
are immediatelly passed to FFI calls and are not used in the Rust code 
internally, so I prefer to keep them as C strings rather than Rust strings.

> Cheers,
> Miguel


Cheers,
Michal

