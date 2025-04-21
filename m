Return-Path: <linux-kselftest+bounces-31270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A356A9570A
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 22:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EA53AEA37
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 20:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B271E5B89;
	Mon, 21 Apr 2025 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0+rLbLe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CAA1EF090;
	Mon, 21 Apr 2025 20:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745266388; cv=none; b=snZ3DF1Q7Ri4bUZR3oE13o4gZHsCl85yusITwP2qf8RtCxVd/UGsN5Nm7fRh4YrlM9JBRH5qiY6IC2rVHF4ARTwMw4D5AlwDr/IH//sznoJPwiay2l7R35YruSTHU6B1rtcr3IcfP3KhhNBh9lklqU3LRYeAuOOK26J/gCJ9wQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745266388; c=relaxed/simple;
	bh=KuPglRXXva+tRt/1RLlrTkqN4JV8/fN1ppPKTXytjUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKB5HQHt4FlOOsFz2zy6+Mvj67FKk62ZPilJvETQqwYGmHRWT6i0OxYgL3jUjG3CIMcL6bfno8YKhI1kyRK/QF382cA63rgxp/R973aFCv3U+bKutPWlmYqOTKoBJlYbVCGACVVo1jwS0AyYHyjqMeuuCFqUFZRWv1J6Jp5mf6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0+rLbLe; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c1ef4ae3aso2595004f8f.1;
        Mon, 21 Apr 2025 13:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745266385; x=1745871185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuPglRXXva+tRt/1RLlrTkqN4JV8/fN1ppPKTXytjUk=;
        b=F0+rLbLeNxQmLiUHq6UehsU1hKKU5uiV/66bpZ/3eECH/iIVwfQdG+MkziMC3tk5NV
         tf/EDEhNkM3qC0gkYwOCifXrWe6G4I2hwFWx8zhDnEuXKhv+mx/ohAAtjriveQeGVDWf
         q1jWR5WB1asYQoUIrE+VGDGINRf3DA4iKYrapgPPE44L6lzh716WQjawxJEFxKCs1SG/
         cUawQO8uKiqxEcnM8VNkRm+frBR/6PjV7XUd8HScSsU5WJrnoll612b0d+dqemz0nwC6
         Gq2QWH9fK6Ku3s7sOVVcbvKcGuu5oPYBh6If6yErVXbGfnLpRw7bQ198mazKUch43GAL
         83fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745266385; x=1745871185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuPglRXXva+tRt/1RLlrTkqN4JV8/fN1ppPKTXytjUk=;
        b=SKgBrUGZSH7a6hLyWp5pu5+Qr3QIv5E1qrrHU8Mgt6ydMGHDdbO4jFcC1GasnDq/6g
         repBvstjIQGJeh8/8Bat+OtWY4bC/yv4g9Adr9kwRlDxb4cSNwPanc60IE4Ulcc/Pi7V
         yqoLgj/70sjKsoZq0XA82cO2PX/NbqA2RFWo6X7Zdk45cPF9ayP4YjkrmrX+rYJk4Yi5
         JdWPahs/0GHEy48DyVptWN0xvPLdZkrEJcna0z746YIUmxf7mhtgRkkEfCj5vTh4nFgz
         8Rsj1DOU60983UGazl70rO6n6xypiTHxEDMzmmAf4gGD2lrgBfct7iJvnDR83N1h9iGz
         zaUg==
X-Forwarded-Encrypted: i=1; AJvYcCV8u6r+03YZDmt7EbER9u44Wn6SsGTmz4jtAUWxvbttFp31XvWj1XltYqWl9AyiBCrdwDJx5XqFUUtlUz6t@vger.kernel.org, AJvYcCWB4vwcbu5eKUokyhVxsQ40Phy2doFob1PhEK2sp1OXCU65fNWXC7rpZCbtfqftBCO5xqU=@vger.kernel.org, AJvYcCWH+T3xX3e7fZQMPdhY4idcK72UEPRI4VishyR239cIqpM/DKiydhzxy0tupOgRlGuoAGCWNaO18j8ztsTY@vger.kernel.org, AJvYcCWXsMKeBPw+9TLCsJHBnCQ7xtEfOD/gGgfwGwUmznoGlVGfUrJY0tbMlcJnc6Hn8do1IixhhYvUmn8W@vger.kernel.org, AJvYcCWbSRf4UQc1mN6qA31CseskaHRSwIr/Fzd9wJtmikk3thFfRjYKS9Fc9V6nfHkOk8x2RAaBMAusBgwu95/r@vger.kernel.org, AJvYcCWmdIQaOxVg0PPa+NqVqRtvTW+qUb1TBj6WDh9tbKLVtvUkP+KGUEx9zOWNV4A/tOhvgPO3JjBMtyT6IXtOHODMbnzvYr27@vger.kernel.org, AJvYcCX1f2eas/YJS4C48ZN0GwEw+bD1oZHLfHy/liBMr7NIPWdlJSIRTP9jm4cZRsmhd3XKwHHPWqRCtLE=@vger.kernel.org, AJvYcCXE0Dzfu1SXnGdwNdwwrXYZGUkG1u9xe73H2o9gOHKH7pMO45DL24HoweEsd3qw/fVDFVEI6MXyvBE4NzUlJ/td@vger.kernel.org
X-Gm-Message-State: AOJu0YzORCojolxKqUy2dXwYqWrVqVGtya7MGaM+OF1b6JfMzewYNrhu
	5UgRUQ+7z2suCA5vapa/tGShlCiIgDjxa05zGcvqC67lDszC2EtXC9rEjO6Yqb8B4egKF3gmZKB
	I4QPoZrYqQPvhXlLZjrRYtR7HmP8=
X-Gm-Gg: ASbGncuS1MKLmCN1hoOmym+I2gItZ9QV3rXmxoUvLvK/YysQv/jdkBcHvPNgyzc1Ydb
	jdZBRl48OGjztfJkvcYVvV7Caa/2mrkKPcnDzxsKoXmqS6qyorg90mvCeW6ZlhSDYdDiX4OuwJd
	yZmqbEkts8qirQs5RSJSNEZq3cKwSuXVX5KmZiQg==
X-Google-Smtp-Source: AGHT+IENKQ7OPTDyXPDMm1eLtepnMBhG5YwiFzhKG6wQNnttfR2T/r01wwOVnACt/7hy7lkYefJ9i7RiLoFp/wuHfL0=
X-Received: by 2002:a05:6000:2285:b0:39e:cbca:74cf with SMTP id
 ffacd0b85a97d-39efbd5a34bmr10154288f8f.6.1745266384670; Mon, 21 Apr 2025
 13:13:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
 <20250404215527.1563146-2-bboscaccy@linux.microsoft.com> <CAADnVQJyNRZVLPj_nzegCyo+BzM1-whbnajotCXu+GW+5-=P6w@mail.gmail.com>
 <87semdjxcp.fsf@microsoft.com> <CAADnVQ+JGfwRgsoe2=EHkXdTyQ8ycn0D9nh1k49am++4oXUPHg@mail.gmail.com>
 <87friajmd5.fsf@microsoft.com> <CAADnVQKb3gPBFz+n+GoudxaTrugVegwMb8=kUfxOea5r2NNfUA@mail.gmail.com>
 <87a58hjune.fsf@microsoft.com> <CAADnVQ+LMAnyT4yV5iuJ=vswgtUu97cHKnvysipc6o7HZfEbUA@mail.gmail.com>
 <87y0w0hv2x.fsf@microsoft.com>
In-Reply-To: <87y0w0hv2x.fsf@microsoft.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 21 Apr 2025 13:12:53 -0700
X-Gm-Features: ATxdqUHHcxXreT9hXAZ5WwrofB06M_gd4QuHmZEieMGyBqtir206iJME0ypgG-U
Message-ID: <CAADnVQKF+B_YYwOCFsPBbrTBGKe4b22WVJFb8C0PHGmRAjbusQ@mail.gmail.com>
Subject: Re: [PATCH v2 security-next 1/4] security: Hornet LSM
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jan Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	keyrings@vger.kernel.org, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, nkapron@google.com, 
	Matteo Croce <teknoraver@meta.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 10:31=E2=80=AFAM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> > Hacking into bpf internal objects like maps is not acceptable.
>
> We've heard your concerns about kern_sys_bpf and we agree that the LSM
> should not be calling it. The proposal in this email should meet both of
> our needs
> https://lore.kernel.org/bpf/874iypjl8t.fsf@microsoft.com/

kern_sys_bpf was one example of a layering violation.
Calling bpf_map_get() and
map->ops->map_lookup_elem() from a module is not ok either.

lskel doing skel_map_freeze is not solving the issue.
It is still broken from TOCTOU pov.
freeze only makes a map readonly to user space.
Any program can still read/write it.
That's why freeze wasn't done back then when lskel was introduced.
There is still work to do to make signing practical.
One needs to think of libbpf equivalent loaders in golang and rust.
The solution has to work for them too.
In that sense bpf signing is not analogous to kernel module signing.
Programs are not distributed as elf files.
elf is an intermediate step in a build process.
bpftool takes elf and generates skel or lskel and
user space does #include <skel.h>
to access maps and global variables directly.
See how systemd does it.
bpf progs are part of various skel.h-s in there.
systemd is also using an old style bpf progs written in bpf assembly.
We need to figure out how to make them signed too.

The signing problem is big and difficult.
It will take time to figure out all these challenges.
Introduction of lskel back in 2021 was the first step towards signing
(as the commit log clearly states).
lskel approach is likely a solution for a large class of bpf users,
but not for all. It won't work for bpftrace and bcc.
lskel loading is also opaque.
The verifier errors are not propagated from the loader prog back to the use=
r.
To load normal skeleton the user space can do:
LIBBPF_OPTS(bpf_object_open_opts, opts);
opts.kernel_log_buf =3D my_verifier_log_buf;
myskel__open_opts(&opts);
There is no __open_opts() equivalent for lskel.
It needs to be fixed before we can recommend lksel as a solution
to signing.

