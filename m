Return-Path: <linux-kselftest+bounces-48119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CEDCF04F7
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 20:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1FB93016926
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 19:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D2130F527;
	Sat,  3 Jan 2026 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+27lIof"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFF630EF80
	for <linux-kselftest@vger.kernel.org>; Sat,  3 Jan 2026 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767468431; cv=none; b=pBfZ/iZtBwvEtwmkWqLTYKRS6FKONECXOrzz9l5uHx/i7hgunvwri93evJOtAv5+ki7TBb5gYujbDtIAZF8J9fnAUo89NoInAgS3Tlf+74cUbWHkpt4MZS5LCpdHSnHFF+mDnZeDjiFj5b4TP6xJrLPEqtdFlx623slVm14uLjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767468431; c=relaxed/simple;
	bh=aCKhaZU36eVQ1h/LufdorQNPtYAqWN6qXyMQV9WUqSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVG6p1rm/W2tJWl2vsJpH114iZ+XUNyNRM8s8jeJ1te9qiVihkhoCRDTbBrlcX86mOl7+XFBMyxvCsdMRmIO1Stp6n1xWNMU7I0B3nVGsDbxyyh+0YmPb8zPgIIh61WoYzTL/uZIseYziFzBbKwMmzIgxUHVDM9QUjOWcmvkIpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+27lIof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAF3C2BC87
	for <linux-kselftest@vger.kernel.org>; Sat,  3 Jan 2026 19:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767468430;
	bh=aCKhaZU36eVQ1h/LufdorQNPtYAqWN6qXyMQV9WUqSo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b+27lIofdGMiHr9P7I/pQvLNQOkTqAN7Fyl/M+98s7fT+Z4iiX7snp6zSbX/VgUEL
	 h6MZlOV6tR0+0a8qcS84yXrmMIVbocqkrTQkdWP94MxXPw/YW0e4WXaIWAsDblKAae
	 oOZceVG4R9DmmrZiLOvo7jJDYaHaxcrZtDXwL3He87QGqspBYOGl+1bAiYGlXkGqp0
	 fd1ytNIbCJ3t1Aa1YjcZg6+ues1iK0XIrbICXB8rrnzinn7MWGqAYN9u55J6og7KqG
	 jUiTwmuu7gjdMC12iSsGhxeqvPoMy8aCvYkDcfi9BNyizE2jxyuyvDKQuE2QEsrhXF
	 S+gFCecY+GKfA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37d056f5703so98208131fa.0
        for <linux-kselftest@vger.kernel.org>; Sat, 03 Jan 2026 11:27:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVs8siFuPg5WJjUNA59+K497oWugsCjcSd8ksO1MpWgO/18dPiJw/1ENvEA6bBWWlrKOucZeIzsD/w9zLayTnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7FzrEM8Bf3f9sXm9FGuB8c6tPxyhqcceiIDew05Ox77KFqB6l
	wtPTX2yevEZmGUVRFPMUfbzLdLqJm5u4W/8jYZhl0Av7U6fSKfKQDNA9oacTt7sIVF+b9NN/22t
	XQH2W2maYtsWxYXnw+xI35Ny9bHssPTQ=
X-Google-Smtp-Source: AGHT+IEZbDkOHEBfjisIX0GAtzHPU1VUmKQz2LEDD8tix+BZ/ypmz2jDnUnYNL3BCBQ2ZbIx5lt42weFEjlydSyXWtQ=
X-Received: by 2002:a05:651c:199e:b0:37a:2dca:cfc1 with SMTP id
 38308e7fff4ca-3812161d80fmr115743451fa.20.1767468429310; Sat, 03 Jan 2026
 11:27:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-cstr-kunit-v1-1-39d999672f35@gmail.com> <CANiq72=wHw5Vq4Gm9R0cb+2ftDxE5yDOddQ2aRbHDT_9q6d-Jw@mail.gmail.com>
In-Reply-To: <CANiq72=wHw5Vq4Gm9R0cb+2ftDxE5yDOddQ2aRbHDT_9q6d-Jw@mail.gmail.com>
From: Tamir Duberstein <tamird@kernel.org>
Date: Sat, 3 Jan 2026 14:26:33 -0500
X-Gmail-Original-Message-ID: <CAJ-ks9=ysT2vOPE9NnHmFaGXKG3baDjvqnqE7Lm04ogBmdS4LQ@mail.gmail.com>
X-Gm-Features: AQt7F2oKREvd8t84-hb8ftBV2iXp-wZDmoMpeGSCsAvGO-_JTDbaHnHnBVQN1Bw
Message-ID: <CAJ-ks9=ysT2vOPE9NnHmFaGXKG3baDjvqnqE7Lm04ogBmdS4LQ@mail.gmail.com>
Subject: Re: [PATCH] rust: kunit: replace `kernel::c_str!` with C-Strings
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <raemoar63@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 7:59=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Dec 22, 2025 at 1:28=E2=80=AFPM Tamir Duberstein <tamird@kernel.o=
rg> wrote:
> >
> > From: Tamir Duberstein <tamird@gmail.com>
> >
> > C-String literals were added in Rust 1.77. Replace instances of
> > `kernel::c_str!` with C-String literals where possible.
> >
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Reviewed-by: Benno Lossin <lossin@kernel.org>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> Thanks for these (and all the others you just sent) cleanups.
>
> David et al.: I can pick this up if you want with an Acked-by -- thanks!
>
> Cheers,
> Miguel

@David: could you please have a look? Thanks!

