Return-Path: <linux-kselftest+bounces-28519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF69A57080
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 19:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080A53A46BF
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 18:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9745721ADCC;
	Fri,  7 Mar 2025 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvfnBXg3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3196F23F434;
	Fri,  7 Mar 2025 18:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741372044; cv=none; b=tIHgzv3g9ss1FStEUt6OerKcJWBt/Tr8OOywfsn+fk/MfIh3X20VH4nRTneZWKkyqjfHWRdlfqYbeDd8hWkxemaOXj2u9r2oHJiSqE6VBBri+Hhoaj/cyLroERWk3yFAARxzHx/RGOhbpo9W0WAd0pmwWNqPJjxaSHF2rEhP8+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741372044; c=relaxed/simple;
	bh=WWPFCKjncMR6X7DZ7Y8D9qVllmrW3P1ooSr3vHJo4s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HiayZrsHJpZ3huG7csf+cbo39uaIVquH7TUPJWpqlZE5XUNS/0um2oWxbsHH4MDlWDKV7e1wpqnec41qIQlFtwNvgZEzQbI5I8gg5f8RZ2dYdywq2+0gkhV0xiqkvClKAW4tPFQgjwnDk6jX1wPTmNaEQdkQYwabG8wpQEMXZeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvfnBXg3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2240ff0bd6eso5720605ad.0;
        Fri, 07 Mar 2025 10:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741372042; x=1741976842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWPFCKjncMR6X7DZ7Y8D9qVllmrW3P1ooSr3vHJo4s4=;
        b=JvfnBXg3Nlk8sgyBjzRSTt95OCBZ4mX1MDF6krwP1oMwnElBvAE3ZmGeLz/IeJ59Ny
         sWdQz+MMb9FpxS1rrBQ8unFwXWJZWwK8/guOtqBnTfvsHZ9K+G7Tv6Sh9VmbpKtJYhH9
         rVADVBw/1r+KodPhooBewEvAMaKoFWmHruhGK6UfoMC1K1pQVb3zcPL4n4rOkYzVhxkx
         snW3mQGp6mPRUevU1hsHHA9DPBUIf5Nxq4iT8w1FSTFqKecLzkQtn6sGYzdXOqL1qKt2
         NNaCtu6p6dLEdtzEXPl47EfhlVQf/RTU8/aHftzjPkyLvCKzTnc4rKmoWVTv5rRg709H
         Ccvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741372042; x=1741976842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWPFCKjncMR6X7DZ7Y8D9qVllmrW3P1ooSr3vHJo4s4=;
        b=gpxW2oXEe0CFB/CSZZRn2BnEpf6J+Q3JH1n0WMCDGI0TuZ5HgfHoLJjmK7d2ho9JDO
         ELncaVmwixoBLgnsJtT3PgWhivtXnYEOjZCcD9oFAvgJ2BhVdXQ17VSWBMxBSgmJ5og1
         4bQTq8pz0VbklYel8D/2gpbv5FVdj9tPd+NzuCcCdBaVP+4rTiHJeRCQRXTg7+eaeyqR
         uFsuVPXAFeujALpbIMcEh3hd3xZOgO/dqRd0xHoXCNR3J6JZ1O1l5ux/rYqfiqK7CGFG
         FWM25OPV/8fW2KNCbQhrdZklx0MJnNTF8mg8YvUHVUBMtrpofCnSM8jGTgmf2BP95CZB
         BFHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUezbFU2DlCtrIpfrDcYiHmKbwhHd4mtAXzYnuP3FX7IyhM3HQps9s1WvfJPzwewrHfXFquTLplTVgZ@vger.kernel.org, AJvYcCVzxk1MWm7+hebj7ADhiC2g7SGB0qjCCyHvzpnnIwde3aKkyzPZ6o3rLZR4iSmfx2pYxq/WM69dodMa0OiewFg=@vger.kernel.org, AJvYcCWXyr+Mbg0U1qEOadkYJWZCC6M54yZsHiNu+7hwoBHD6eeqk92/mcE20DyoO3kFBhftDFBWQg1+WlZLmt1x@vger.kernel.org, AJvYcCXAPRI/MIOBPEw/xEdjcadtTCdn5E2UljF3AFCJBDn3BQATS0nntvQG5xr/eVAWJNHwG/h9w4ABneUAGkE=@vger.kernel.org, AJvYcCXThV5GeYvXycgzK4AkdTZ8eSlUMxdJEjrb8sRXIhyMRZjCR4UrDQXtOVzrRYGPotsaEwMmWT2h01pczboIf0J1@vger.kernel.org
X-Gm-Message-State: AOJu0YxL06/ufeUDEK+lapL8+IGH8J2/4XUwutZblDQg3Ujsk17AJ7+b
	zGSXDHdyOQwukwzXeEOROXiMJjvOoBdtfkFSvUi+1phvtnXF+/NgDo5nGk3WAWYEuQ0nKkHhiBj
	YJaW2hemSUBEzSciE7FF9nrk5S1Q=
X-Gm-Gg: ASbGncv24o94PsI3NZX/iA0rwqRRr4v3fh0eh3dG3qv3kqTjBquF7WFFNIXGIEl0agC
	AMbxtJbkggo3Td4jU+MUTdR+hfQNFwUmOssbdW4ehwCgmsLShYBg7d88OmlYGHJ+ldoD1M/E9JG
	PXPZLsW+coiNxm5CZLan36rpDvmQ==
X-Google-Smtp-Source: AGHT+IFzZCN+WDBMLfUjOiNeV6ZDYR/8Xnn0PDTFCTkxoBd3vXIXfne6nV1JEdeDWqb2O84Vu9diIMPLd3gHPA3w1Yc=
X-Received: by 2002:a17:902:ce05:b0:224:e0e:e08b with SMTP id
 d9443c01a7336-22541628a67mr56595ad.0.1741372042305; Fri, 07 Mar 2025 10:27:22
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-ptr-as-ptr-v1-1-582d06514c98@gmail.com> <D8A6YVP8B1UB.38AHIB0LMO85Y@proton.me>
In-Reply-To: <D8A6YVP8B1UB.38AHIB0LMO85Y@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Mar 2025 19:27:09 +0100
X-Gm-Features: AQ5f1Jr6LEyVKZec63NBPYaXJv92BoX_oGh9bpii21uvzrdOuGLuwIGdVHT-imA
Message-ID: <CANiq72nW45z7n=38AQF45vpKQxWfrA5pvt2Q5DbjqgYR2ZR09Q@mail.gmail.com>
Subject: Re: [PATCH] rust: enable `clippy::ptr_as_ptr` lint
To: Benno Lossin <benno.lossin@proton.me>
Cc: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 5:58=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> You link to the `ptr_as_ptr` lint though, is this a typo?

I think Tamir was following the pattern of commit 3fcc23397628 ("rust:
enable `clippy::ignored_unit_patterns` lint"), which I appreciate! :)

Cheers,
Miguel

