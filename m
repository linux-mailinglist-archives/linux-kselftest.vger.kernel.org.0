Return-Path: <linux-kselftest+bounces-29305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A887A66407
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7EBB3B898D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 00:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916672E62C;
	Tue, 18 Mar 2025 00:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw7StJyc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0130D528;
	Tue, 18 Mar 2025 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742258528; cv=none; b=qX6ghlp4UZ9MRc3uChxEPMfvJxhvyAo3R1cWu6s37wt+EJh/F6Qzvy6UGL/+Rmio/HNhjMNH5nMlC1mKgNTFMYhSRIn7A93wuxrLzjwz769R9BxlpC64pbRZqERAiHRxNpf1atvJX3DJc7mdCS7VQiJRkwblOxNRbG06A/9FYY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742258528; c=relaxed/simple;
	bh=PgzC/F33BYAA53t0eSb8TLPna6imarmpm+vWugeqXCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzdwmsK40zrzZvBlTHMQ8tvKvCnGciukIoHtyeAM9KoJOKit5lh0rQXiz14FLJKxOElEK3k183lq+Uy/7uG0YkQCBRW3xwZegBnDAZv0V4u35hp6f0rrdwRL1ta7ByXmikgNdgRa2lQF+V8LhN02MpD3sBzF8d1xZMXpRBqMoNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qw7StJyc; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30795988ebeso52112181fa.3;
        Mon, 17 Mar 2025 17:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742258525; x=1742863325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7IfKOPhAlS//llZDZ8iu5ShHju61/9HzEhonjMXx+s=;
        b=Qw7StJycBI7mWjgQpc6ky6N7gIAmD3ev7RIaMuDfW7ioBGCk4pWfFo+tGqnCYIy6Ax
         Ijh+TWl/48z78hJ6QfsHpPZ9lzWZFTNPqpw5AGGECHVsDwVvPxa7otrcO+8sfh5JWiyP
         5xSHz9KjTKQNU9ZoZpsGWzpfdbOjhO+O42dV/n/HqKtKB6HmccORC/XHZX2dvmNjU/6v
         jh6ZZK+t6urhPGu7tq9Sjq+xjwKqXXPpwJ7gdheUyO/WC0ZhLL/x90I8svKkVrnHYsw1
         HDeCyYCQ0yQf1iFJZwpNGmlERbxzxPRsULqix160gxkrzMxvFffSsM45R6cx+miDy/j0
         0DAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742258525; x=1742863325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7IfKOPhAlS//llZDZ8iu5ShHju61/9HzEhonjMXx+s=;
        b=Qm4e3bQpi4U/4T5QC8EjrqzIEZF4JjiIV4x3XBB+dp6YODxv14NWfubFQdyapFFGEg
         36AU7+cXeJYpSrpw9kioh9CEo+eplZ0j9E9N8mowKzljr5tyrKBvX8iOmIN9JKHp9GXW
         djBgRGdbTJSDMUW/LtXp+ZPr+ussc2YvWsiz6G/X3WVuw/qbeUrFsr68JnXrnAVTRzNp
         Aoi+/HcbAmIsNkh1XwMJoBpLvmcO7mRMifBA1BbqhAsi/oXmVVa1tpYMUyI7TLpn9zJg
         ARzOWIRjty5uxykf+D2txuWd9o7b6vAi3+7vuF+3mBEc4HEGcQu9WLTeH08rzmrF8sr8
         fUBw==
X-Forwarded-Encrypted: i=1; AJvYcCUO5KwCEsYD35cZzdIQNEbwZa78SS+Ra/obJt0ERJ+2j9+P8QwCJ3FGQByuXKcrJA+I52nW5kdWzcuLtqMm@vger.kernel.org, AJvYcCVYkMozWUZk1m2CFAfIKdU/Vnp+2InnFolnwHc0QE3+5zDDcVIHjzAnhZx2ZvqHYN+RJu6q69qa1OadYQpAoq0=@vger.kernel.org, AJvYcCVtR64EvI8P7O5FNn8SyHjhjyM4M4YY5zZDAT38VOwj2xMLOXsf9FOiTN8OQJo6sHbpvCj5GRwB76Iuues=@vger.kernel.org, AJvYcCW0lxuQpcVrCWASUtPxhf3fnpkvtKzdn2PJwKNbvD1P5BYJgkKDVGQWzwheZcgpwrCRPSvUoXmjhBPlfPkDIzY8@vger.kernel.org, AJvYcCWATtWO76muUPyfGFgwi+FYoDC/yTDVBan9CZY9AzZOeQDlyn+5ze5eotmbNvkuoIqocCsqvcsV7i7tTRdL@vger.kernel.org, AJvYcCXah9vW6lD6Jp4QqbooTx8HeSNtPHNRDldHHjeuWOJMrGZiAEQa7XFBLasD0ng8uEbxa/iZNTXLTzVl@vger.kernel.org, AJvYcCXo2tst5mLk8G+JHcoiysN9la+s9zLuTiChJq8ldYOKYcUkJjjr1YED4KkVQIM2p0g8pFXP/BP3rE+b@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/3sw9BkEf8Y9pqIRm3jTqAe5mo5WNOKpn22MR671ajjjSsFXO
	HyafM8WxMdqjh8HArlksxQZkIn0yneZwPEyfOloHNJU9TQZOomm6xcyCc4JCHXp35K+KutIFxq1
	PfYPbdwtQE1gySoWEgCIalvHHejA=
X-Gm-Gg: ASbGncsy+cQC59TxL2XQIcvGv2hPBqB8DkaUOFnnreIjGAq5oUcH5JheOtfZZ+eVUeR
	0inYcDaThjbvsrcJrQqlQjxStCA04qcnchqP478zrj32rmG/G1W/bAGdkSBXL6w5rV9Mf2d6BHZ
	tuBhBVhhCM38wz9wlLoxpg28M2/wNp3II5lrTcNDeoXkQ5jll6rQUtLSDmI0N+LToDND9Repk=
X-Google-Smtp-Source: AGHT+IF5vCiDQ8UvKh1Yne26mi3NIgR+bYUhG99rsvoK4CRqZFLHBICrHc5mvPXVOh74lH0hTvVBsz+mo/B6+Mv42Wo=
X-Received: by 2002:a05:651c:2108:b0:300:5c57:526b with SMTP id
 38308e7fff4ca-30c4a861dc9mr89186201fa.11.1742258524555; Mon, 17 Mar 2025
 17:42:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67d864b2.0c0a0220.39fb6f.4df4@mx.google.com> <CAJ-ks9n8mwt5q9unqfkfSHj9=ELJHtqsXM-xQ8jsbXeJX6Uyfg@mail.gmail.com>
 <67d8671d.050a0220.3305ab.6372@mx.google.com> <CAJ-ks9=uHjJrzM0ruvm4v4wr8LygRMP-1orWBy_9OiNNeQr0ow@mail.gmail.com>
 <CAJ-ks9=Qcmvbm=YGJ=jrX_+YdMsftk=FAimszYZB1OUuV4diZw@mail.gmail.com>
 <67d885ff.0c0a0220.111215.5644@mx.google.com> <CAJ-ks9kYB1b4XsQcFb=NScPq+R+13U+Sv-6opi-yp6=ZjuLD_g@mail.gmail.com>
 <67d88a1d.050a0220.2cdacf.4adf@mx.google.com> <CAJ-ks9kg4Br=56HT7T5sWpoMKhRqT_2x+cpQAWoyrEG3qyqQ6Q@mail.gmail.com>
 <67d895cc.050a0220.99d33.5adc@mx.google.com> <67d8ba3e.050a0220.39b3b5.753c@mx.google.com>
In-Reply-To: <67d8ba3e.050a0220.39b3b5.753c@mx.google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 20:41:28 -0400
X-Gm-Features: AQ5f1JoEGp_5o1WcOYKQ7KQIGBB5nqYglySnTY7b-xENR_n0SAcUGZzOBrzhgus
Message-ID: <CAJ-ks9n57P=NnMAAvLr9dnZhs2zT8cvD_gdLkSmnFtSQR4b-Jw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 8:11=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
> index 036635fb1621..331ed32adc35 100644
> --- a/scripts/rustdoc_test_gen.rs
> +++ b/scripts/rustdoc_test_gen.rs
> @@ -224,6 +224,8 @@ macro_rules! assert_eq {{
>          BufWriter::new(File::create("rust/doctests_kernel_generated.rs")=
.unwrap()),
>          r#"//! `kernel` crate documentation tests.
>
> +#![allow(clippy::incompatible_msrv)]

Ah, this is the reason this works for you (and the one in the kernel
root). When I said it didn't work, I was referring to not being able
to convincingly avoid these lints without disabling the check
altogether. Let's see what Miguel thinks. I agree that the options
are: extension trait + stubs/reexports + suppressing
`incompatible_msrv` or just dropping the last patch until MSRV bump.

