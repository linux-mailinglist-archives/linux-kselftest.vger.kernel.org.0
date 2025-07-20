Return-Path: <linux-kselftest+bounces-37684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2FEB0B419
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 09:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B383C0E17
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 07:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7071AAE13;
	Sun, 20 Jul 2025 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIdEM+FG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230318B0F;
	Sun, 20 Jul 2025 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752996782; cv=none; b=uYksHege3qfwed1x61lXDpt/uo72W4JB7nBdlSOCp6nbLgIvfcZiaVIfSrnHKKYBwFOBuDv2sJn16EJ6L4Kvvpzogo9rjeOg0M19rYXJhidfxbhJ/zzdwZND42/KDcwtI9SHMxKwINeKi8EvKgFgU5b58IAu2GHA+UB3RacHFvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752996782; c=relaxed/simple;
	bh=GUf6N3TqKM3NlAZc3TkaUseabajlOnvUW3B1TeZqF2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Btl9RqtozmSexxejP6Q8qgyxVVj6rtnuv+JZuxuHRF7pm3TXFnUMAkZDZdU6RfGC9c/+xWgZ78r+ui38o+hxygHuxmug7NdufD4b4dvYtm5XV/FubBPQmFz7C9qbEuk5HPDNfmCLbPP/wJbAC2hFfll2RM7lzxV/HPOrvl+CRKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIdEM+FG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896C4C4CEFA;
	Sun, 20 Jul 2025 07:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752996781;
	bh=GUf6N3TqKM3NlAZc3TkaUseabajlOnvUW3B1TeZqF2g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WIdEM+FGmgqw7d5Ow5RRj2eJFVnGzRZAH2SQcPMs5HlVLhXED6o9vu4EyHelH6bSN
	 8lZexpZgFWmnRn7lM1S0SIJlVUFpH4H5/1RdHGKHBjPSZ2E15mWgS390se+GXUma1D
	 P9RNNxu+pHQt/Mku+9k+VcNBwuMcpUnD9M+O3nosI4DSmfnRaIadkfA2i6FyVPWi+c
	 BqottYw3OPAqU2RQzbg0uIZ6AoIlqLSOCQFBRSwFBF3Tj0rM73MYQgzYQwXluLe07F
	 qu+NU0SD9eunGyWxHF6sB7fGsZY+VQNAKRRWDVo1MkeGUayi0e/YsWvjJHcKfre/VH
	 +YszUogZ7J0zw==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-711d4689084so29684307b3.0;
        Sun, 20 Jul 2025 00:33:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdjXD+dYoaAU1XagmLcq30dlCEySnfD2DRfaYgL2UMl9KpaHs5f/z8N3aS0EOorAke1pXhZLj8ueyk8mTTQIgb@vger.kernel.org, AJvYcCUuKK3uBN8RqWsYtBsh3gbYBOhr97ISfhiA2t+XI713zzimJqsfIktkwHCJJmouQLM+PSXq+sgVX6mPHwhc7slfBH2c52C9@vger.kernel.org, AJvYcCWFeUWRZ6LGnVmuOtsuvbI5ng2m68e8NKEPuVkr4y7Qh6pKF85SH/p3EIixs002Z5yo6Ww+pgc3ANIPA6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx615i89ytRkSdvDMkKP2pLbztUyETX2RMMu+nI6VljNgibYraX
	YPyHLxvRRPCfYNfKCNKQxdefmORvIy3ZDaspBodIu+kkENp8fy9K8RSyb++guW32vZnFZps6EDI
	F8KXvrdfBxlVlD7ZutzxJP0yYceuyNQo=
X-Google-Smtp-Source: AGHT+IF1VxxR+4HdNpFLZwc7UhA2IPzQimfkylbquxsG4X+5YY29CDKhDrh1yAjgYaYXhcX5RSmunUxONBPEJavLmbA=
X-Received: by 2002:a05:690c:6d06:b0:70e:2d30:43d6 with SMTP id
 00721157ae682-7183517c58fmr221992957b3.38.1752996780713; Sun, 20 Jul 2025
 00:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719-memfd-exec-v1-0-0ef7feba5821@gmail.com> <20250719-memfd-exec-v1-2-0ef7feba5821@gmail.com>
In-Reply-To: <20250719-memfd-exec-v1-2-0ef7feba5821@gmail.com>
From: Fan Wu <wufan@kernel.org>
Date: Sun, 20 Jul 2025 00:32:50 -0700
X-Gmail-Original-Message-ID: <CAKtyLkEJKLgO1GvpTNmW=DnRhrsiPXGgz9=F7oJXVQPLSocSeA@mail.gmail.com>
X-Gm-Features: Ac12FXwM5d9XENWMfedXVCr4EtwnEwR84CVbOz6P-hi7ZGkZgUIUwlZziX0dfMw
Message-ID: <CAKtyLkEJKLgO1GvpTNmW=DnRhrsiPXGgz9=F7oJXVQPLSocSeA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/4] landlock: implement memfd detection
To: Abhinav Saxena <xandfury@gmail.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 4:13=E2=80=AFAM Abhinav Saxena <xandfury@gmail.com>=
 wrote:
>
> Add is_memfd_file() function to reliably detect memfd files by checking
> for "memfd:" prefix in dentry names on shmem-backed files. This
> distinguishes true memfd files from regular shmem files.
>
> Move domain_is_scoped() to domain.c for reuse across subsystems.
> Add comprehensive kunit tests for memfd detection edge cases.
>
> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
> ---
>  security/landlock/domain.c |  67 +++++++++++++++
>  security/landlock/domain.h |   4 +
>  security/landlock/fs.c     | 210 +++++++++++++++++++++++++++++++++++++++=
++++++
>  security/landlock/task.c   |  67 ---------------
>  4 files changed, 281 insertions(+), 67 deletions(-)

...

>
> +/**
> + * is_memfd_file - Check if file was created via memfd_create()
> + * @file: File to check
> + *
> + * Returns true if @file was created via memfd_create(), false otherwise=
.
> + *
> + * memfd files are shmem-backed files with "memfd:" prefix in their dent=
ry name.
> + * This is the definitive way to distinguish memfd files from regular sh=
mem
> + * files.
> + */
> +static bool is_memfd_file(struct file *file)
> +{
> +       const struct dentry *dentry;
> +       const unsigned char *name;
> +       size_t name_len;
> +
> +       /* Fast path: basic validation */
> +       if (unlikely(!file))
> +               return false;
> +
> +       /* Must be shmem-backed first - this is the cheapest definitive c=
heck */
> +       if (!shmem_file(file))
> +               return false;
> +
> +#ifdef CONFIG_MEMFD_CREATE
> +
> +       /* Validate dentry and get name info */
> +       dentry =3D file->f_path.dentry;
> +       if (unlikely(!dentry))
> +               return false;
> +
> +       name_len =3D dentry->d_name.len;
> +       name =3D dentry->d_name.name;
> +
> +       /* memfd files always have "memfd:" prefix (6 characters) */
> +       if (name_len < 6 || unlikely(!name))
> +               return false;
> +
> +       /* Check for exact "memfd:" prefix */
> +       return memcmp(name, "memfd:", 6) =3D=3D 0;
> +#else
> +       return false;
> +#endif

I was trying to do something similar early this year but didn't hear
feedback from the linux-mm folks.
https://lore.kernel.org/linux-security-module/20250129203932.22165-1-wufan@=
kernel.org/

I have considered this approach but didn't use it. My concern is,
potentially a malicious user can create a file in a shmem fs, e.g.
tmpfs , with the "memfd:" prefix, which can be used to bypass security
policy.
(Resending this message due to a misconfiguration with my email
client. Apologies for any inconvenience.)

-Fan

