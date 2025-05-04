Return-Path: <linux-kselftest+bounces-32289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1202AA88EE
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 20:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699D81894244
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 18:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D505B19CC3D;
	Sun,  4 May 2025 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWP9NFiw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126666DCE1;
	Sun,  4 May 2025 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746382987; cv=none; b=KjsdycM0YZPiMWBoJXdnT8LeTZYx76nDmXjow1NcCSpPRQEhmdvaFSDcL7s1v3doRp20Acl6SCxM83S1ANJivxAOxADFuWLeH08QCFk9ToqkLPfX1QTAHKbL727KjA+G5FLfMNp5lL9b+TdQpbor6DNzvmqCjryfxUIJbPAp2b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746382987; c=relaxed/simple;
	bh=NRoTU3EhPJ5MsF4mOID2yy4hxBhLzxcpKGxQ3VUBgts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sn5C8l4UfBrcdm9lh5WTQznvKRYqER/IUDwcMhALXLkinXvWRdA9dEGmQlYHvr0cOo+PwSt0JQUuhi6rI1hLANizi9tpCUrKVRf+QoNT81xQovxDIfO2ercr7/KDoATTdr9d1GlIpJtYxJ08h+WBMRnGll9+2x1UY9ZUFLp/a4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWP9NFiw; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30dd5a93b49so32923551fa.0;
        Sun, 04 May 2025 11:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746382983; x=1746987783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XhcjTb4W0KddGeDKGrQ3a3OAZovTIwLMmR38oMQTDM=;
        b=bWP9NFiwjObmhIpfcaruHcDnhvqlnFyE1ZU79RmFY2JQUd+j10o3TONlhs/7cD7P5n
         u1aZyoQSiDfokZgZ9g72U8AOOQz11IRq3l+2mwgGQ2M6BtcgNb3ib6uLKLd1lKg9e2B1
         LB1U8daZ0jTIvSA4cf73CK9qSFRnhqxaV8bb/FEymh0xl15XaBecfUlS4HAhM2Q8wx8t
         zxSFrNOuFH6ZgWzeGK1S9S6Ow6/gxk67F03ADLjLNqZQYtrEIL0309eay9X7px23vYFI
         NHORoyVg0V+qN0rzyUdyKvC93JShTQfecmr5wR+BGDKnhKBXTwap0e9kYxlK1VEjsgxU
         zQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746382983; x=1746987783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XhcjTb4W0KddGeDKGrQ3a3OAZovTIwLMmR38oMQTDM=;
        b=IMPPbfaisOWAPwwFTDjK/73ry4AaoBR8tsLA986lMelJybiw+oXLZNZIaBDsDOEaq2
         ENNHwKF2HOQSR0sPSZNZuxhQknFMnzcx1rJCxyWel+wh3GSE0L5kB2Rj1vUt/GNUiwCH
         jhCPN3aAMRYwIIIB8LZ+dysNfVf5ZbqtgnN8nKnb+21bMb3/S9rl0kG6uEchxDpuqOdp
         d8Ot+/b15Fkc6ktNvUbdgr7oOrbusDv1zWzVcOyC1opaW7yiBlYqRWIGCkhU8wJVgYxF
         mtETybZi+e79qOiTLIsz3eRppwr13SdAOlWXjvF002i9eKKUT05OSEUAxC5QFBzbBmmY
         eDCw==
X-Forwarded-Encrypted: i=1; AJvYcCUGqgYzLznkgNYnRCKtQyU/FvKsTYaFH8TNFr4kHT9VFI/jPzRkNBkifxL3u2GtLyQEq8vcJWrK0LzeVmw=@vger.kernel.org, AJvYcCVCuR8sFvoivN7xh2KXskfxm8TJZHi4sxIGinIFzZj+crkkMulDtFQHLxXdY281KAQEi9J6AmNo7XI96unDnV8=@vger.kernel.org, AJvYcCXnAq3QebdjcpTxj1q0sH/XCdPhMEhTdM6GMgCF83w/JXGie3CenMSHhBNdGTQSy7kjfJolNXtvTeuxHKpO9A0t@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6HXhCClBPRS4tjOzjX8wPtTWueVDmpMbY041dv4KtCHmvSdQp
	RJCYXOIeMj92GLjIcA0n+6ywnf8MHdfsIR7U1iRCqn7CZc6n4kRXsuH0WD0oXkxqp5DlPi2G/BT
	/V8oP47P9uCB+52G9WutA85Zewp0=
X-Gm-Gg: ASbGncvtz7vxgZU4eVaqPCOTNNKaoJ5I0XAv/FJLMkEJ1wEQXqh42EUps+syy+tSTiI
	DvlAw09b/4q893RVKArSi8LC5M3ojBGpR4DshPoWiA2Unb6+xjDBhsfqYVFafu3xJN7VxxMEMlE
	IRBvKXIWMplPPkNUt2mlp5Ers/nkcoOb56kA44RE6FyOuQ62NYti73wJI=
X-Google-Smtp-Source: AGHT+IHSewq7mdLrxjK+vevTX/WiVDVEg4IYgv9T71zxpZE7LcUHsuSJbg8EfkKEWa79PebPla5TMC7VhhAOKWGapOY=
X-Received: by 2002:a2e:bea8:0:b0:30b:a4f6:bb35 with SMTP id
 38308e7fff4ca-323490564e0mr13143181fa.22.1746382982891; Sun, 04 May 2025
 11:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org> <20250502215133.1923676-6-ojeda@kernel.org>
 <CAJ-ks9n7u3WkYmJCVc18c_cKod6DaB7KrA7NXbOuD3E3TYbvpQ@mail.gmail.com> <CANiq72nEHy5wvOyPzW4DLu9aE_MxTx1gq7AJ-f_Ny4E6bbOJ5g@mail.gmail.com>
In-Reply-To: <CANiq72nEHy5wvOyPzW4DLu9aE_MxTx1gq7AJ-f_Ny4E6bbOJ5g@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 4 May 2025 14:22:26 -0400
X-Gm-Features: ATxdqUGfMI3KYY_di8D8LLhpwzQrp-ESsq5HMgnbqfcQ7rC_Yr8vP3dgQ2T2Pik
Message-ID: <CAJ-ks9krSxo_DWFJdccP+SYJhX4WF0hXdq-20Rtf3doMp_2zDw@mail.gmail.com>
Subject: Re: [PATCH 5/7] rust: str: take advantage of the `-> Result` support
 in KUnit `#[test]`'s
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025 at 2:15=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sun, May 4, 2025 at 7:30=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
> >
> > Alice pointed this out in another thread but: one of the downsides of
> > returning Result is that in the event of failure the line number where
> > the error occurred is no longer contained in the test output. I'm =F0=
=9F=91=8E
> > on this change for that reason.
>
> We could perhaps customize `?` to help here, e.g. printing a trace or
> panic, with the `Try` trait or similar.
>
> Related to this: I thought about saying in the guidelines that `?` in
> tests is intended for things that you would normally use `?` in
> similar kernel code, i.e. things that the test is not "testing",
> rather than things that you would want to assert explicitly. Thus the
> actual code under test should still have `assert!`s in the right
> places. I did that in the sample. That way, having `?` would still
> simplify a lot of test code and yet allow us to differentiate between
> code under test vs. other code failing.

I see. Up to you, obviously, but ISTM that this degree of freedom is
unnecessary, but perhaps there's a benefit I'm underappreciating?

>
> > These changes don't depend on returning `Result` from the tests
> > AFAICT. Can they be in a separate patch?
>
> Not sure what you mean. The change below uses `?`, which is what
> allows this to be removed.

Even without this change, couldn't you apply

     macro_rules! format {
         ($($f:tt)*) =3D> ({
-            &*String::from_fmt(kernel::fmt!($($f)*))
+            CString::try_from_fmt(kernel::fmt!($($f)*)).unwrap().to_str().=
unwrap()
         })
     }

and achieve roughly the same reduction in line count in the test module?

Cheers.
Tamir

