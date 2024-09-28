Return-Path: <linux-kselftest+bounces-18525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 634E4988EB1
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Sep 2024 11:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C460A281C7A
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Sep 2024 09:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6C119E83C;
	Sat, 28 Sep 2024 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1/fXMcy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9649319DFBB;
	Sat, 28 Sep 2024 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727514682; cv=none; b=EGEjmeKNJtO9nf4LkgCf48DDjm5uNuZoVm1ZVeRqUc1PpLm8wAup33mHY+bZ+y5takc52NPoNhsUVrS+CMYCDnqFbED9VYNffJ6AoQ4xiGkAD740awJJ0tmAoMo9GeXpI+o8WK4wcPsOcucwZBO1Sb/2f8pN+IwYYgqIWbSLKz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727514682; c=relaxed/simple;
	bh=li0bXHR0TvXcwt8qhQR9j/FFiIA5/ek6EQTh0iCst/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stBBYkxVN+M/K2ZjVTN6gLptg2xu9XjCjwaP5dow5+fdL0ZHDQKDj8I5rjeJhiYWdi1TMsHITE9FLYgblDcmle3tb3pBHUFWBBwc88mCg7vsCA+Nuj8HZudt2jcb7MoVQMCUr1HjsiOQ3GamW7TG7jy6ZL3HUe0D/+IDzNc4Mok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1/fXMcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041D7C4CECD;
	Sat, 28 Sep 2024 09:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727514682;
	bh=li0bXHR0TvXcwt8qhQR9j/FFiIA5/ek6EQTh0iCst/Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b1/fXMcyj6RG+4FeYlLcnEoKnbZmjb4NUFZjgiidVyDyPc5ve0S22mvTiw4BTahWd
	 lVLpFBvsUgtpKwHbj2sQpX3NtP6eiN4yh09Bg7NFhZa8zqs8S1tjQYUOj9+md/sM12
	 VQ+7+3cXXyXJJ7OVqEUMpPBZc8Jsts+AoISCxUfTrAsb10z4bInevJzE5Kj1arWjxL
	 jPed5Ds2y87JYWDbq7E6BbbNlgzMDXzglivDwOcaYKervxE/EThFLvDGuiH8hdJq+G
	 AOaoBRSopNeN+Wm/30PPeSpi4+lfbEbk5rqZMmCFNJAJi8jDQBIkY95cPcHsaM7Ppm
	 PGkE/TADjw+eA==
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-45812fdcd0aso35014481cf.0;
        Sat, 28 Sep 2024 02:11:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWo7N6JWArAQ1uAcy6ixiCPPGuUqWU/uwbCKfmKhybRzv40rLbp7d5c/J9qxzsrqw5m5l/mvgMbbtchwJgP@vger.kernel.org, AJvYcCXF1+8Q3RbG2CDlcfO7DbmHfh7+u6rp/EZcwNqoVR62JDXwotabNhWjUAPQfjeSasg6nhRLuNLr@vger.kernel.org, AJvYcCXUQ5tYNO8WD3aRUN0WLbS68yrXwOM5ESt1l4FQAbwwYIqzwdy+jlfc1IvOAWWS7KUr32wrUSWttT0KEaWxA7gu@vger.kernel.org, AJvYcCXcKv69+J1a8jGAoueQntAzKchWpB/o79UX0jbzG5dD+O/nlc+ouk+vWR3AK+BzQtMcgus=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYPmQXo+10vjcZarm11tN9YUZgPApRQHe5ohvWkZQY/Cf2xXqR
	2NQjaVW0QgFu2sQb1EUFVBf+nSSCX2M7PdxPTA8d1WwAI2RXIheCklRX489JWglX6R3LpGc77P5
	NGnVltTbf/E7XCjOQj1THGxuK2+M=
X-Google-Smtp-Source: AGHT+IGQzctwOpKFuOtCkRYlVjrpRKVgfRrk5wUSUePsrzDaXpPbQ/kK+OwI+9znW9FBFK+ZV1jb1ra9eyUnKzEamAU=
X-Received: by 2002:a05:6214:5012:b0:6b5:d90d:ea4f with SMTP id
 6a1803df08f44-6cb2f29730emr166967016d6.15.1727514681117; Sat, 28 Sep 2024
 02:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927131355.350918-1-bjorn@kernel.org> <CAEf4BzYCf2+8JkCjWZWGaNQcEc_=WO_emP2GPBQGZyrWm8APUg@mail.gmail.com>
In-Reply-To: <CAEf4BzYCf2+8JkCjWZWGaNQcEc_=WO_emP2GPBQGZyrWm8APUg@mail.gmail.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Sat, 28 Sep 2024 11:11:10 +0200
X-Gmail-Original-Message-ID: <CAJ+HfNgrxUmHuY8b1AmWoR+YpBnsNZxSDCeUfBOQcC70POEU_w@mail.gmail.com>
Message-ID: <CAJ+HfNgrxUmHuY8b1AmWoR+YpBnsNZxSDCeUfBOQcC70POEU_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Add missing per-arch include path
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Charlie Jenkins <charlie@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrii,

On Fri, 27 Sept 2024 at 22:51, Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Sep 27, 2024 at 6:14=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
> >
> > From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >
> > libbpf does not include the per-arch tools include path, e.g.
> > tools/arch/riscv/include. Some architectures depend those files to
> > build properly.
> >
> > Include tools/arch/$(SUBARCH)/include in the libbpf build.
> >
> > Fixes: 6d74d178fe6e ("tools: Add riscv barrier implementation")
> > Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > ---
> >  tools/lib/bpf/Makefile | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> > index 1b22f0f37288..857a5f7b413d 100644
> > --- a/tools/lib/bpf/Makefile
> > +++ b/tools/lib/bpf/Makefile
> > @@ -61,7 +61,8 @@ ifndef VERBOSE
> >  endif
> >
> >  INCLUDES =3D -I$(or $(OUTPUT),.) \
> > -          -I$(srctree)/tools/include -I$(srctree)/tools/include/uapi
> > +          -I$(srctree)/tools/include -I$(srctree)/tools/include/uapi \
> > +          -I$(srctree)/tools/arch/$(SRCARCH)/include
> >
> >  export prefix libdir src obj
> >
>
> Do you know what exactly is used from tools/arch/$(SRCARCH)/include
> for (I assume) RISC-V? I'm asking because we'd need to make sure that
> Github version of libbpf Makefile and include directory has all the
> necessary pieces as well (so I'd appreciate if you could take a look
> at that as well, if you haven't already).

Ah, apologies for not stating that explicitly. It's
tools/arch/riscv/include/asm/{barrier.h,fence.h}

Cheers,
Bj=C3=B6rn

