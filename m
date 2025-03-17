Return-Path: <linux-kselftest+bounces-29280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91132A65F76
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 21:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95CC189F53C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 20:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5E31F416E;
	Mon, 17 Mar 2025 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iM5QlSTt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670491E1DED;
	Mon, 17 Mar 2025 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742244385; cv=none; b=p8i0ZxNgRA9sV1sNbDtXgpe/cg0iZW61+V1dlBGu7QwRQjV1Z9B26yhdokdSH8+hsZ0TWgsHEr01a997sMXijhzdQyOqeHDjSh4Ocudu8B4d0mbVbiJ7vyUonFUhlY5yPmXTcGmaUzEyeeRU2eyYYb2rSogy5gK546a676DoH/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742244385; c=relaxed/simple;
	bh=GH4BVQajgFQQaWzmqicXBwzlPErY6rgL8IZUAiLLgK4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFMEslPveEMr44T0ZppKC0yqpa2jssBpdVb6XHcrbnjo/+So9eQiDCvS+MDFegl3IC0Z3UjCWU4CFo+1Fs9PeMpw76lMkVND9JlkpPLPDKYqKBV367yevG5zzbYEbqUHOYgV6sTQyseJzBXCvhDRulD8uuRqaU/KF/nhlOQwtgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iM5QlSTt; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476f4e9cf92so8556491cf.3;
        Mon, 17 Mar 2025 13:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742244382; x=1742849182; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tY8Z3X40rKLh2ulbc0uC4/AepcRoPAQU5zZDg+Uz+LE=;
        b=iM5QlSTt9x2fJstoOgbf20ep2OgBg+2wVGxR2ykmVrxNSzQrYlmHxgW/45yqWjljcE
         Q+YkpjLhgDkGFbHbT00vCBsGUrYXsOk3UDPY7pjR6t3/AhEqQnIrMTNZ1c3FclanFi5f
         TLq4+NWwcG6VO+3yw2sh2uf1C37HEDw5vqa+go5C6O3M4UMGXLKlsLP1t72SceG/Xn3p
         dar93V3QXjk3kqq7PS8VvjKrsrIohzr39bV0wcFleceQ9oMxOxq/8alpxOxVSzO9LT41
         5SXhB6cdZsEf0vzWyu2OhFY+9cpFbrdCou0pN8yeOVdeN7UTq/DxIHwKu6KHagPPlY5b
         Gqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742244382; x=1742849182;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tY8Z3X40rKLh2ulbc0uC4/AepcRoPAQU5zZDg+Uz+LE=;
        b=SANaQuCofb8naXxi3VyYX2ilzAIeUHwYpjn2CApX3MF3vxZMTgCNUYfRoYrd9MrG3Z
         fMSeFSETRzIj7VCHUxQU7MAhC8mqZUSp46W5KI0/UxWKC7HIaRLknpOxHbKub/ysCsBn
         fB8M5tyv3k6nbUhxNlHa/lYzmgHhMYJkwh/yZE3T2t+iqkCLZ7VfzLsR3d4qiLdIFFlt
         HL+p1BZLJ//q+Z4V2CAW0yj7RaoZ/kVVBny18K/cO8rgi3UeSPSYquXhb0s8ZIJlNTAr
         kkHCoY5tMkIwpOuDhl2POwHelPLYEuSRnmqtrJitbEDllBAciW1U0lC8oxMiDAAhY0K2
         lv2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSG1BFLHwxKf93a74QaES8+dkZaREuETcwfSfYre7tnJLwvHs8t1Au26oMQ9tKhIkSJrJJVMPA4JaUPf/a7No=@vger.kernel.org, AJvYcCV8UAwz2+wO0wQcsDotac/9vIubcB+A2Tfze4Zz4osKw87u9W61RYLW+cilV483007sjCjiwf9dNLH+dKw=@vger.kernel.org, AJvYcCVh+9JYJk5tgqUZDfyZrUUpIfyqEmSD2pMEGJrMORKOTKEwgKV12BSp8Jm048T97shcyXKLWidLT/06@vger.kernel.org, AJvYcCWiXvpcQn/upg98azDNRq82U7Ez9X3uiANDwCe6pKpR+ijIn425uJrj/vppx8PDE0qxc+Lh3xJFx3+p@vger.kernel.org, AJvYcCWuUvZDhzT6//TmjD9ZWuZepP8q9VKo9qnj5vpSojiCBnxLY3lO1I8Ai8xuxE2q7EWky2EfEel2IbZwpW42@vger.kernel.org, AJvYcCXVzBgTc6viuAUtlWqCoy+1QVyiQwWs42NCLhqwVF8YXvHTGsb/nBcDZsS/rGy3WVBg+Iwjb5LzvOgxY0LNftDE@vger.kernel.org, AJvYcCXll41ug90a4/SXkbyfq1kmBAmjdQ5Xg2J95QqBoGrCOwl/g2/cAUxlCYHLSrWOHySIzKd5Yoyxx8LJpXvU@vger.kernel.org
X-Gm-Message-State: AOJu0YyNWyc5WdMeuY5m6WgtpwbQvpuh1gdL4GoTw7DQ7aEBCTbVf70b
	Fkwk8uVGGceVSFzXryYAIRPZSb37I1R6qy5z1rJo7v9gk0kJTY3h
X-Gm-Gg: ASbGncsAQRMUok0cQm+Sy2PTlg9sIIWxKeGy+oV8e3v0OuJJyWf82aQ/HY8OA3zswGe
	CceeMqYVn4NlYxeCQIvgeCbgm7ZlryrqKnv7tGHxjVQJlvTzWRs0GnteD/SRt5RhDw9WxfK8nXm
	gURAJ1+uAX0irXYh7TUDNMprhz4T3rm8pOk1/JRWU/9ivMeVZ1qz8oDXbEQpbIaaf2cqKAyn0Q0
	gq6SwMC4sBa3xl/qxrNJVxXoGQ+MSFPkYRSSl0i9TuykqlhgEyUbBqL697vsnz7y7jNQkt6I8GU
	Hk3h1i7ld2FugeI+ALdneXQcm+VIeUnacOGlYCDl/HHvLrwu5XLQfP4KLC3NMy7B2llRTNQu8Vb
	4AUr6/hpKCop+LR8o/xM96HIvbOtYZFJmAqs=
X-Google-Smtp-Source: AGHT+IF68e+DGFvzm8ApjfN1u6FmtFIBsxe7HRpR0UwJzq9vZbrQeFPK8gL4IOswyF9qdXUojAOFzQ==
X-Received: by 2002:a05:622a:298b:b0:476:6599:dee2 with SMTP id d75a77b69052e-476c8150168mr225028341cf.27.1742244382062;
        Mon, 17 Mar 2025 13:46:22 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb63e688sm57438121cf.31.2025.03.17.13.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 13:46:21 -0700 (PDT)
Message-ID: <67d88a1d.050a0220.2cdacf.4adf@mx.google.com>
X-Google-Original-Message-ID: <Z9iKGSuWGf_XXVZd@winterfell.>
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 411A3120006B;
	Mon, 17 Mar 2025 16:46:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 17 Mar 2025 16:46:19 -0400
X-ME-Sender: <xms:G4rYZ9sF4PyT6MtayKy1rHb8uxx1LGOkSSnL5l5TFKi8ujuPoUjsmQ>
    <xme:G4rYZ2dcf4hvjwjrjp4RewMWLz78gvkQ8gRmkGzWBnmooPgaAEaapoVC_-3VPa7er
    wecu5yLySKN5i0Tqw>
X-ME-Received: <xmr:G4rYZww6kwMHtqdZr8C2sBYo52FiN9Zvu7jadzdvSMGNdwkP2pSYPNNPxt3zhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedthedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhephedthfeukeefuefhteehgedvvdfhleff
    jeefleevkeeklefhffdvkeefleeuvedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    dprhhushhtqdhlrghnghdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlh
    hithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehg
    mhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepfedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehtrghmihhrugesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmrghsrghhihhrohihsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhitgholhgrshesfhhj
    rghslhgvrdgvuhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgr
    rhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhroh
    htohhnmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhho
    thhonhdrmhgv
X-ME-Proxy: <xmx:G4rYZ0PryfuDDkH1UlulmOqbX9fq1wqBI8jgeRxXSk8Tz45iQA5Ylg>
    <xmx:G4rYZ98hX9bRztgvlF4oTkGrHv40ecKSiAugWgAtLoTkQioAxHyAPA>
    <xmx:G4rYZ0ViatslefDkJnndSPGOY3cJBUde0zu7h7quCpa54DJhQF-i-A>
    <xmx:G4rYZ-dmz-BfA7we39AGX_oV37_i81iFnCyAIax47T-8irKiFYBIEQ>
    <xmx:G4rYZzcnZ0YarUp1KuIAIdhN8S2oNGTgyRUP9OKA-2a9ymEB3jgKkiH_>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 16:46:18 -0400 (EDT)
Date: Mon, 17 Mar 2025 13:46:17 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,	linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org,	rust-for-linux@vger.kernel.org,
 linux-kselftest@vger.kernel.org,	kunit-dev@googlegroups.com,
 linux-pci@vger.kernel.org,	linux-block@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
References: <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com>
 <67d85e51.050a0220.2a36b.58b3@mx.google.com>
 <CAJ-ks9kBp8zPfaQuZRb0Unms1b13hDb5cRypceO8TWFR0Ty5Ww@mail.gmail.com>
 <67d864b2.0c0a0220.39fb6f.4df4@mx.google.com>
 <CAJ-ks9n8mwt5q9unqfkfSHj9=ELJHtqsXM-xQ8jsbXeJX6Uyfg@mail.gmail.com>
 <67d8671d.050a0220.3305ab.6372@mx.google.com>
 <CAJ-ks9=uHjJrzM0ruvm4v4wr8LygRMP-1orWBy_9OiNNeQr0ow@mail.gmail.com>
 <CAJ-ks9=Qcmvbm=YGJ=jrX_+YdMsftk=FAimszYZB1OUuV4diZw@mail.gmail.com>
 <67d885ff.0c0a0220.111215.5644@mx.google.com>
 <CAJ-ks9kYB1b4XsQcFb=NScPq+R+13U+Sv-6opi-yp6=ZjuLD_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9kYB1b4XsQcFb=NScPq+R+13U+Sv-6opi-yp6=ZjuLD_g@mail.gmail.com>

On Mon, Mar 17, 2025 at 04:35:42PM -0400, Tamir Duberstein wrote:
> On Mon, Mar 17, 2025 at 4:28 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Mon, Mar 17, 2025 at 03:05:45PM -0400, Tamir Duberstein wrote:
> > > On Mon, Mar 17, 2025 at 2:50 PM Tamir Duberstein <tamird@gmail.com> wrote:
> > > >
> > > > On Mon, Mar 17, 2025 at 2:17 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > > >
> > > > > Then we should fix clippy or how we set msrv rather adding the stub.
> > > > > @Miguel?
> > > >
> > > > I filed https://github.com/rust-lang/rust-clippy/issues/14425.
> > >
> > > I don't think we can wait for that to be fixed, though. Usually clippy
> > > is distributed with rustc via rustup, so even if this is eventually
> > > fixed, all versions between 1.84.0 and the fix will need this
> > > workaround until MSRV is >= 1.84.0.
> >
> > We need to take one step back to evalute this "workaround".
> >
> > First, expose_provenance() and with_exposed_provenance{,_mut}() API are
> > clearly defined as equavilent to `as` operation [1]. Therefore, the
> > changes in this patch doing the conversion with expose_provenance() and
> > with_exposed_provenance{,_mut}() don't change anything related to
> > provenance in practice.
> >
> > I do agree we want to use the explicit provenance API, but I don't think
> > we want to introduce some API that we know we will change them latter
> > when we bump the rustc minimal version. So the question is: are these
> > stubs what we want even though in the future our minimal rustc version
> > stablizes provenance API? If not, then the cost of this patch cannot
> > justify its benefits IMO.
> >
> > Now let's also look into why we choose a msrv for clippy, I would guess
> > it's because we need to support all the versions of rustc starting at
> > 1.78 and we want clippy to report a problem based on 1.78 even though
> > we're using a higher version of rustc. But for this particular case, we
> > use a feature that has already been stablized in a higher version of
> > rustc, which means the problem reported by clippy doesn't help us, nor
> > does it provide better code. Frankly speaking, I think we have other
> > ways to ensure the support of all rustc versions without a msrv for
> > clippy. If I was to choose, I would simply drop the msrv. But maybe I'm
> > missing something.
> >
> > The point is tools should help us to write good and maintainable code,
> > we shouldn't introduce complicated structure of code just because some
> > tools fail to do its job.
> >
> > [1]: https://doc.rust-lang.org/std/ptr/fn.with_exposed_provenance_mut.html
> 
> Even if we globally disable this clippy lint, we still need stubs
> because exposed_provenance was added in 1.79.0. Did your suggestion
> address this? Perhaps I missed it.

No, I didn't.

That's a separate topic though, because I can see the argument that:
because with_exposed_provenance() is a function rather than a method, it
won't be very benefical to use ptr::with_exposed_provenance() instead of
kernel::with_exposed_provenance(), therefor these stubs of
exposed_provenance make sense to exist. But I don't think the same
argument works for ptr::{with_,map_,}addr().

Regards,
Boqun

