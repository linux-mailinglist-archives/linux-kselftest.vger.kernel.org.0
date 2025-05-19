Return-Path: <linux-kselftest+bounces-33355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AE5ABCBAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 01:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09721BA08E6
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 23:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB04220F31;
	Mon, 19 May 2025 23:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcQWP80d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F84220F2A
	for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 23:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747698139; cv=none; b=FiTO7fvaWMrGFroEZkZ1wiyMWqXI20y1JEzBDgBGTJLDxNpTXGGjft8o0IBpGI5no1k1XQ9gqfewbiO8PHrRvSoLfltZzOBMyCGAKki6026NDWQqyS496Y0IZFpIBAnVin4BK38c0DgPW2B/Qwd5744/iMwE+EgtfxMB5zrHQpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747698139; c=relaxed/simple;
	bh=ZKYV4DZqCzOu7XtrDoRxpxOQ2X8r++kTwWByKtXDhrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIJujlfHopqEFX0DE5UreU4hoNMFwCiPBcCB6J5cfjD8SLKyUGKhcWbVwe3fssTDFj5cIistV9IEGQ6ZwDqpz3N2b6JCP4MG7TXHVnmCb2EMAQlQmr19uQhIgCxgth0gZgCnD0npFN4jxAo4nBNt7a7ouzs5S1j05U6RrmJscRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcQWP80d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243D2C116C6
	for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 23:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747698139;
	bh=ZKYV4DZqCzOu7XtrDoRxpxOQ2X8r++kTwWByKtXDhrI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TcQWP80dqZf6wsvV46hfhbTO/IwcHkluZg9gwlAJFqA4nPRc6j1YFLmQJtaAY+re1
	 r6KwA0YpngRxsaYwDegU8IRBmfb2DX/xHbQYWRDtiZtUMl3K0+wv3kCs/BNHL8XKVo
	 ygRM0Dj8edMrC3lEXrMqVpKFHE8jPUzI9twSqdjyHF1ekm8EtSeC/ylD8vXIwTpwnm
	 AaqU/swIMCkJHDGVuJ7yxk/8AYDS6T7xHiBImEzyOo11qLtzeZOlZAjh8G94L8btBT
	 OaXfds5P5StEhfx+AaUM5UvfuSIhfq6IckwMm2CLKYDJSF2XVgUha6NZ5uurJ7VCWV
	 ++9nrEevi9YKw==
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47662449055so27404061cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 16:42:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXd5pIGnN65Cf6oYfP15hnNQBgtpIausXqGudZhbY0Yxa4i2zyonyKY5e5wmVTltNrc4dPiROTj6owIPjkUhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6NItnceN/E6GsvdTv0ufmIwcZMBzN9ezqvQ7J1RY1up2Lywk9
	xmhw6YT3S26TJzEj19Jva5JBnNaj35LKcBixcKaxBJtTSJ6VK7J0BHnVcHJJFijFV9TMCFixxTF
	dQyHvNcsQwkAG1Xwo2h3FjBH1YYxZWUXN2Et69Nv7
X-Google-Smtp-Source: AGHT+IF3yXeBG7TOl1OWLmx6UHDF/3YbnaTG/HjinvwYXZmduyt29cvicBww1a9vAZvlcO0xk5OSvjlLpQi0hnBcD0E=
X-Received: by 2002:ac8:5654:0:b0:494:af82:7804 with SMTP id
 d75a77b69052e-494af8278f4mr201668631cf.29.1747698137942; Mon, 19 May 2025
 16:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
 <20250502210034.284051-1-kpsingh@kernel.org> <CAHC9VhS5Vevcq90OxTmAp2=XtR1qOiDDe5sSXReX5oXzf+siVQ@mail.gmail.com>
 <CACYkzJ5jsWFiXMRDwoGib5t+Xje6STTuJGRZM9Vg2dFz7uPa-g@mail.gmail.com>
 <CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com>
 <CAHC9VhQL_FkUH8F1fvFZmC-8UwZh3zkwjomCo1PiWNW0EGYUPw@mail.gmail.com>
 <CACYkzJ4+=3owK+ELD9Nw7Rrm-UajxXEw8kVtOTJJ+SNAXpsOpw@mail.gmail.com>
 <CAHC9VhTeFBhdagvw4cT3EvA72EYCfAn6ToptpE9PWipG9YLrFw@mail.gmail.com>
 <CAADnVQJ4GDKvLSWuAMdwajA0V2DEw5m-O228QknW8Eo9jxhyig@mail.gmail.com>
 <CAHC9VhTJcV1mqBpxVUtpLhrN4Y9W_BGgB_La5QCqObGheK28Ug@mail.gmail.com>
 <CAADnVQ+wE5cGhy6tgmWgUwkNutueEsrhh6UR8N2fzrZjt-vb4g@mail.gmail.com>
 <196e1f03128.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <CAADnVQ+=2PnYHui2L0g0brNc+NqV8MtaRaU-XXpoXfJoghXpww@mail.gmail.com>
 <CAHC9VhRKZdEia0XUMs2+hRVC7oDzkBfkk5FPMD+Fq5V7mAk=Vg@mail.gmail.com>
 <CACYkzJ7oxFA3u9eKDpKgCsZsYsBojVJPHVeHZnVaYQ5e9DavmQ@mail.gmail.com> <CAC1LvL2F_WbObrdcumVZCKc7yLeq4e9PQhYHrLiyVzpzf=V_Xg@mail.gmail.com>
In-Reply-To: <CAC1LvL2F_WbObrdcumVZCKc7yLeq4e9PQhYHrLiyVzpzf=V_Xg@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 20 May 2025 01:42:06 +0200
X-Gmail-Original-Message-ID: <CACYkzJ43yJRMS+e-7LefYts_v2ZH7_FCbw_LfG3mYfu6q6VD0g@mail.gmail.com>
X-Gm-Features: AX0GCFuKLMZDwuoCJgohVN01wRXVU9M-dpj2qXdRHi2W4iwOU0W5kASpMuAgI_I
Message-ID: <CACYkzJ43yJRMS+e-7LefYts_v2ZH7_FCbw_LfG3mYfu6q6VD0g@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
To: Zvi Effron <zeffron@riotgames.com>
Cc: Paul Moore <paul@paul-moore.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, bpf <bpf@vger.kernel.org>, 
	code@tyhicks.com, Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, 
	David Howells <dhowells@redhat.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jarkko Sakkinen <jarkko@kernel.org>, 
	James Morris <jmorris@namei.org>, Jan Stancek <jstancek@redhat.com>, 
	Justin Stitt <justinstitt@google.com>, keyrings@vger.kernel.org, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, Masahiro Yamada <masahiroy@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nicolas@fjasle.eu>, nkapron@google.com, 
	Roberto Sassu <roberto.sassu@huawei.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Shuah Khan <shuah@kernel.org>, Matteo Croce <teknoraver@meta.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, kysrinivasan@gmail.com, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

> > > > > > No. New hook is not needed.

[...]

> > > > >
> > > > > It would be good for you to explain how the existing LSM hook is sufficient
> > > > > to authorize the loading of a BPF program using the signature validation
> > > > > state determined in the BPF verifier.
> > > >
> > > > I already explained:
> > > > .. a job of trivial LSM:
> > > > if (prog_attr doesn't have signature &&
> > > >    (task == .. || task is under certain cgroup || whatever))
> > > >   disallow.
> > >
> > > I read that earlier reply as an example that covers a sample use case,
> > > I didn't realize you were asserting that was the only approach you
> > > were considering.  Perhaps that was the source of confusion earlier,
> > > we may disagree, but I don't intentionally "twist" words; not only is
> > > that rude, it's just stupid in public, archived discussions.
> > >
> > > As I mentioned previously, we really need to see an explicit yes/no
> > > flag from the BPF verifier to indicate that the signature on the BPF
> > > program has been validated.  It really should be as simple as adding a
> > > bool to bpf_prog_aux which the BPF verifier sets to true upon
> > > successful signature validation, and then an LSM can use this flag as
> > > input to an access control decision in a hook placed after the
> > > verifier.  Are you objecting to the addition of a flag in the
> > > bpf_prog_aux struct (or some other struct tightly coupled to the BPF
> > > program), the LSM hook after the verifier, or both?  It would also be
> > > helpful if you can elaborate on the technical reasons behind these
> > > objections.
> >
> > Neither the aux field, nor the hook are required because:
> >
> > * If the signature is passed, it will be enforced, there are no
> > "runtime aspects" that need to be configurable here.
> > * What the LSM can specify a policy for is when a signature is not
> > passed, for this, it does not need an aux field or a signature or the
> > new hook, existing hooks are sufficient.
> >
>
> What about wanting to create a policy that requires signatures under certain
> situations and allowing the lack of a signature under others? How is that
> implemented with the existing hooks?
> As I understand it, all the existing hooks know (would know) is that _if_ there
> is a signature _then_ it will be enforced. There is no way to know _whether_
> there is a signature.
>

The signature is passed in bpf_attr and if there is a signature the
LSM's job is done.

   https://elixir.bootlin.com/linux/v6.14.7/source/kernel/bpf/syscall.c#L5771

 It will be enforced.


- KP

> An example policy I can think of is that most users (with CAP_BPF) must submit
> signed programs but some users are exempted. Would that policy be able to be
> made with the current hooks?
>
> > - KP
> >
> > >
> > > --
> > > paul-moore.com
> >

