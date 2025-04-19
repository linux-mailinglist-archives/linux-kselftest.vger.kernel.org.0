Return-Path: <linux-kselftest+bounces-31211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F44A94493
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 18:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D829D3AE724
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 16:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFB21DF991;
	Sat, 19 Apr 2025 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MZfZtyqH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA98E1DF25A
	for <linux-kselftest@vger.kernel.org>; Sat, 19 Apr 2025 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745079701; cv=none; b=Tv2sEMBoGsZOgr+08bxgeGbLxELBaCe9UlkcZneT7kMfNlSLl3vVhtEbVx8BaGO/8DROac9ECnq+j5Td0mg1LCo02P4DHIR0YvtIdEZfmx6M3EPPVErHHreFK/5OFqFj/hPAnbugTJBXg/HK6m1+tj0+gPpuvMtxzSuU+zYsops=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745079701; c=relaxed/simple;
	bh=+Auhi+fhizwmRtmPtgmlior927TsrK0KO7qctAT2pis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Re5k6MyL/8TLTfZ0LQC5YerepfapQTXqtnGiCdvehJulUCoqeembWpaa4MEwXJTjFZEbngoFiNF7FIP7gYOFwSuLQs3xRME09kPJQOD8c2sNxmMfNLEMvr8ErShwvCXVA1DmAIY3vVxGXuvommcyZSA9F6MsKy+3w1Ss7d/vDa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MZfZtyqH; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ff27ad48beso21843087b3.0
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Apr 2025 09:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745079697; x=1745684497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SK42IqE6wVyUSsq1mCB2tip52MeUpuaz6h1iIgyehRY=;
        b=MZfZtyqHgqxtktoo7cYhykkt9iBF8PdOAfLyuhm6XYm8SU9AoTG2vsQa2i4ptrwdr8
         XYoV1WQ+4SWzy/K03ngmY2GsflAAIDlSyDqFF6iSc1Vczpl5XelCYXTxXnGha9cf0YXE
         /jf8QGo7PUPRhlFOoTNkgfDVvz59oj/tLDcdY5+J82lfE3O5q2VXoU2Er7BhGwJRQ5SN
         TK7/0HNGp+7tPfTcQrvU2xaMZGlJGs3aVTfiNSt0qELF2gbIioJoi3iMv5gz3q+CDgXP
         nP3jPWFGuX/Kj8IdBZY4d3ck6vleu1XF9TY6Vd4nmXs5Ait49vHuE9ftpglQdV2+k87D
         0zQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745079697; x=1745684497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SK42IqE6wVyUSsq1mCB2tip52MeUpuaz6h1iIgyehRY=;
        b=tT4Rfi84tZxxc1gs7L2HSeuJyxgvJdL8QuQQk9nJEOoICvOZRDiL24q4u27uttNkxE
         5Gi60ixGl1ivoy8iMtaiYJ+NbqlwPoI5ch+qBPv+flWJhyRro/c6SnZlzVoc5y0+RxaI
         KfetByBeoLGza4eqKiouGjQkkH78XrIuGEOMZ8G+cIj9lN664xE35HkjCn4FqcnKaTsD
         Iqiyef9yWM+FAoRNdxMyTkLEcZhiV9cCiY8zBuAusyAmplbRKU7UlSfhGws5tBJsJLtO
         mdvAX8JwLM5cB5NinoNKTTvHKN+cqWeyZlg0yILgUeNAN5fL+/hEFxACm5T13Rhvm5wq
         /dIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCqcokzTn62WXVNlATtQ8Z9ZC6OcMyI5aRBzEANt8bGaXIoEYbBIVh9OV9QtCrRI7NH8TWbFtQCQXsJHauFMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgCzgf3G8uXBCUaG7ZT7ChaUiZRMKS7taNXMlkEwfQhMebHQ9K
	2fR/Yra+mvgIXPIyQbtRxM+keq5E2OD8SqVE61CmCTeTEH1Gak/YFJt9g2thId2Xhgv4cOHC09Y
	p7aJY8IMd/yAEwEyTPn3S4lxa0eDpzNr+BCqR
X-Gm-Gg: ASbGnct16H3cuq/61+UZI2sCeUm+lonUCNbpC3CAa2AvnOoPxi5RsuPkBJmNJgA2jel
	cwydm2jf2Tcy3HHROGiJiG+hEZCdvhjOmxo5ND16pZjJKhvaLHfnenNO0f6+UJ2JkvPrbPMAXZ9
	rmUoMm215BZ+JaDBuBWZsZvIaYI56OYg==
X-Google-Smtp-Source: AGHT+IE3BicjHYyc+GSidJ22/CQRjgbN53OMD/7E3kl6FAHBfatlg7CLbuNJlbDtFKxiZ4CU+uMFqEhJREhcjE8lbJE=
X-Received: by 2002:a05:690c:74c2:b0:703:b0e3:bd86 with SMTP id
 00721157ae682-706ccdf5d35mr99562277b3.25.1745079696848; Sat, 19 Apr 2025
 09:21:36 -0700 (PDT)
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
 <87a58hjune.fsf@microsoft.com> <874iypjl8t.fsf@microsoft.com>
In-Reply-To: <874iypjl8t.fsf@microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 19 Apr 2025 12:21:25 -0400
X-Gm-Features: ATxdqUG75P_ck3eo9mR9xrxf8isa1cXorXFN2bYVLnlyY_vUbbDdQ0hrTgMAh-o
Message-ID: <CAHC9VhRduum5_6fOFs3C7Mn153Fg7VM1HnJfdtKgA-6OUvd82Q@mail.gmail.com>
Subject: Re: [PATCH v2 security-next 1/4] security: Hornet LSM
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, 
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

On Tue, Apr 15, 2025 at 3:08=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
> ... would you be ammenable to a simple patch in
> skel_internal.h that freezes maps? e.g

I have limited network access at the moment, so it is possible I've
missed it, but I think it would be helpful to get a verdict on the
RFC-esque patch from Blaise below.

> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.=
h
> index 4d5fa079b5d6..51e72dc23062 100644
> --- a/tools/lib/bpf/skel_internal.h
> +++ b/tools/lib/bpf/skel_internal.h
> @@ -263,6 +263,17 @@ static inline int skel_map_delete_elem(int fd, const=
 void *key)
>         return skel_sys_bpf(BPF_MAP_DELETE_ELEM, &attr, attr_sz);
>  }
>
> +static inline int skel_map_freeze(int fd)
> +{
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, map_fd);
> +       union bpf_attr attr;
> +
> +       memset(&attr, 0, attr_sz);
> +       attr.map_fd =3D fd;
> +
> +       return skel_sys_bpf(BPF_MAP_FREEZE, &attr, attr_sz);
> +}
> +
>  static inline int skel_map_get_fd_by_id(__u32 id)
>  {
>         const size_t attr_sz =3D offsetofend(union bpf_attr, flags);
> @@ -327,6 +338,13 @@ static inline int bpf_load_and_run(struct bpf_load_a=
nd_run_opts *opts)
>                 goto out;
>         }
>
> +       err =3D skel_map_freeze(map_fd);
> +       if (err < 0) {
> +               opts->errstr =3D "failed to freeze map";
> +               set_err;
> +               goto out;
> +       }
> +
>         memset(&attr, 0, prog_load_attr_sz);
>         attr.prog_type =3D BPF_PROG_TYPE_SYSCALL;
>         attr.insns =3D (long) opts->insns;
>

--=20
paul-moore.com

