Return-Path: <linux-kselftest+bounces-10628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7BD8CD9B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 20:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EA2AB22473
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 18:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF9781ABE;
	Thu, 23 May 2024 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2X/9CXkz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C480E76F17
	for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2024 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716488003; cv=none; b=PonAcLL4ZSYW8muFpbO+gpB26NYR9bFFHHvehMzjvJQDsD8cqiAWHhn5cj+WdgbEwc37aUIF54dTju1zhwib1Tzn5LiqCRonB2OS6wtb8KO9GDIQWcA7bS/gteRnqR3Jj8eVaExxydh8bC9+J+48w/h10DpP/muP2jRrmaWowr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716488003; c=relaxed/simple;
	bh=zsnTKCdVkvI0k+jxRH2TuSi7PFifNDtiAicq3/1spJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grn8uc7HmWb7nxZ3be/Bd3UGXX5pgA40zAJ9iCmf1dCIxbr8HWVWKNtEQ1UUGEngCDGTb6jIBy+auWD/DtGM+Q09scxH4fMfm1LJUiB/hLThbZopBq9pnmvI75ToUMyUZvNhEbw7EbfyDCUgwpwt4MlFGHAimZlZ/dbU43DU8QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2X/9CXkz; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso2364a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2024 11:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716488000; x=1717092800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmV9pjx2Z/cgyKoVK6PJ6k9Fa04AQ2nQf51yC2c36Uc=;
        b=2X/9CXkzUa2XXZf7Pc6ONJBU1W/rvJ4wSpgHYq2AexrqD9KxQIdkteHQRvbnQ7Nu6i
         7whqhSAEFey88amyy43L2nGMCCb0zl7EGVf/rhm5gJDBD/dh3BYxadgIe1Aqizu+n8eR
         tNloqYgm7JQBR/3xPhVDvsIBPrEGgxdT5WXve8uf7mnGdFHCBRwPRG/xj1LdXVzGqImg
         Nl9fVZJgYUt/kPF/b0R2I6DAMQh6feIwKOe08Y/wIoAnTySIUhOn9JwpKy5kHDhkEahl
         WEgwfKhhrey4SacY6KSCQ+5jzUB+5lhy68+PkmDMEC/aFnI9Cp8ad69dRLJxTH6ybTeo
         3r4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716488000; x=1717092800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmV9pjx2Z/cgyKoVK6PJ6k9Fa04AQ2nQf51yC2c36Uc=;
        b=I9jVZ5e4uJ+7V/MJ4lU2S3NxZNGJ7B9YHQpExoEbMEVd51Qwg4G3qu/nXFN4LxKHJX
         ihOWEbeDk1ODDt7M7Sa+w6861CDUhbSMvssQxmwxZvc5XNfUyVkaqYkBCwlm8eMiWMMm
         ZHvL5TUiKy1vkAMcItsrA64+OEaYlGMbVH1AoYpLty+O1ptsIJpPE8kjW/Auq/xwMmjj
         8SksuWJi2gqa2f9tq7i2ClMZ1pUxQVd3gj1VOtoPxOQ3i7lhSgePP4WkQOnvf3bHQ1+l
         1kctevBcihRW5Nekmvbad6MhHb6b+kyUpD9HPhorTiqFlqkGO0ELIiOswBE/k1NUw8qr
         ndEw==
X-Forwarded-Encrypted: i=1; AJvYcCXIcSzpS1seObkpVmkgf8Kw4oLpZ9oMH/bQN4REnlZ1AqU7eJPz5o/T8AL0H7OSJMoukDeflk8Pcf6rUtLY5Jj3/4q2yTxBU9eOGgnVJujG
X-Gm-Message-State: AOJu0YywoSLes0l4Pse828IvGF5i26yOwW9iukWLylNfMaHxBsX3+Qgw
	ws6Cwpf/y81hSyMrgxCcHK8oVeKDrUVS2EHaNrBvpZMUT1JR7EBnVEFlrjoUYl4uqbyQPlRYjIg
	GsIDzMmjL/2fI6kwX1pYHjTj6zmMOwswl8KaJ
X-Google-Smtp-Source: AGHT+IH4XyN34wwdQO+LD1omzn19g4Z0hsO4LF5HJg6/COqxImkywXTVpGaksCMO62vMlBB+i2WN/mYDnRwwA5mbJXU=
X-Received: by 2002:aa7:c941:0:b0:578:33c0:f00e with SMTP id
 4fb4d7f45d1cf-578510d677dmr19276a12.0.1716487999947; Thu, 23 May 2024
 11:13:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com> <20240522005913.3540131-3-edliaw@google.com>
 <94b73291-5b8a-480d-942d-cfc72971c2f5@sirena.org.uk> <CAG4es9WAASaSG+Xgp31-kLT3G8wpeT5vAqbCA4r=Z8G_zAF73w@mail.gmail.com>
 <9e2677ec-1d54-4969-907b-112b71ef8dd3@nvidia.com> <d5471e30-227d-4e6d-9bbd-90a74bd9006b@linuxfoundation.org>
In-Reply-To: <d5471e30-227d-4e6d-9bbd-90a74bd9006b@linuxfoundation.org>
From: Edward Liaw <edliaw@google.com>
Date: Thu, 23 May 2024 11:12:52 -0700
Message-ID: <CAG4es9XU2fMo7hBv81vpn1JGKFWt9gExOhyAyRtOc-5OR5eiLQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/68] kselftest: Desecalate reporting of missing _GNU_SOURCE
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Mark Brown <broonie@kernel.org>, shuah@kernel.org, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kees Cook <keescook@chromium.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 11:02=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.=
org> wrote:
>
> On 5/22/24 20:28, John Hubbard wrote:
> > On 5/22/24 10:46 AM, Edward Liaw wrote:
> >> On Wed, May 22, 2024 at 4:21=E2=80=AFAM Mark Brown <broonie@kernel.org=
> wrote:
> >>> On Wed, May 22, 2024 at 12:56:48AM +0000, Edward Liaw wrote:
> > ...
> >>> You've not provided a Signed-off-by for this so people can't do anyth=
ing
> >>> with it, please see Documentation/process/submitting-patches.rst for
> >>> details on what this is and why it's important.
> >>
> >> Sorry, my mistake, I forgot to add it after cherry-picking.  If added
> >
> > Adding this to your .gitconfig would cover you for cases like this, I t=
hink
> > it's pretty common to do this:
> >
> > [format]
> >      signoff =3D true
> >
> >

Thanks Mark, I'll add that.

>
> Mark, Edward,
>
> Is this patch still necessary of the series is dropped?
>
> thanks,
> -- Shuah
>

No, it is not necessary anymore.

