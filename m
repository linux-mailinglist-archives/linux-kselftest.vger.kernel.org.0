Return-Path: <linux-kselftest+bounces-32281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 183FBAA872F
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 17:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D557218983AC
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 15:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4531B3957;
	Sun,  4 May 2025 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a/1jX6U9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2663FB0E
	for <linux-kselftest@vger.kernel.org>; Sun,  4 May 2025 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746370987; cv=none; b=tRLJobBnYQseiqxHoUMRzKojgBy1ozSsZWL2yHR5K4sC9d3accrS7RgLS5boSW8ghcEmrcdZ86bSJtJxqL8aCxPizun62Vup9dTPQ0j8slClE2T8WSP6d4q0Cy3FKz+UnUqfXk5tJ6SZxvA7F3NtdrXJ/m+Bkj6s380eyOfV1pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746370987; c=relaxed/simple;
	bh=N4cxeiFuZJq4ZkwPC0chJf/hRnNW/GZ4UmSHUGiYz/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBOwI74XT0VTFTC8sKEBkg0yOZKMDuyKgTEn4HhwyHj7hROLZaOFVVvCQAFPKu1Ams1WL7D9MSaJlclumx22/JoRv5nDznPMaYsDPWAV4xTn3oKWL9vwMfxogdbiqeRBqL6hS/8JZwl5cAPa1HEasotoAauXUNIOm7Tugdt44Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a/1jX6U9; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e6405e4ab4dso3673433276.0
        for <linux-kselftest@vger.kernel.org>; Sun, 04 May 2025 08:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746370983; x=1746975783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFW+c/pzu01ksPogBDsF0yztuQICEpFi/6JnX1ys5aQ=;
        b=a/1jX6U9Mk/1hp0jwVQ5K0EiUFfjEsjyng/VBVauQtE6aVEojFUxWONgfZRmQbUR0Y
         76I01tdvkumZxzZVbP7XRxfuD7csuX+Ybc55U5/0xlfkKsszs+zvNErTFIUj2kB6xuEZ
         fsi9Qpz1nvA5Kg3zB04N8tWXbyfyU4B4B7J7QhpWHrEjaoqF2XHhTV9qydcEn/J30TtS
         kR43YqtmKU6cD5wZ87IAabT7muvhlQ/fX3taxpQ3EmV5ERlAiI1c/G1dTQkmIRDzoelA
         +tbENm7Z0ITGIKWVITwy9sLtNdgAyvci8DEfUHYbMZRjPNoMwGFIkAHcbTbA2fzSLNIy
         AwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746370983; x=1746975783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFW+c/pzu01ksPogBDsF0yztuQICEpFi/6JnX1ys5aQ=;
        b=hE+sixwcLYuL+f3msWe17Zlo9LbEh9CEl+VWIpVfaD7E3vQX2/bGSBoraq1W8YpCDB
         tEYk5EQl0ASUrXsuxxRRwnV+BtRYwk6aWlVpS8IRUcDAr6EfIur65XfCuzr87R38tpsR
         9kcBE/3BN211bDWb2nRhzfnvRgMKkFbR/XtgzgRmVEYdUqRIIPgDgYgn+9b7t95++o9c
         QEDUOPaVRLRK5s9OdPp8W7F5q/8GAGOBNJBJ0UYqDiFDGcf9Y6t/MriqXPZzduSoNQtL
         NtG6KLUZCRT9kSLOAiweUS9B9pcMi+VXN/ZLkLciGAhOPWwm0ydh62gWjGGPXFyBd0cJ
         R1iA==
X-Forwarded-Encrypted: i=1; AJvYcCUYf7giXtVXHRQ9AcjfYAv7YcEcU6rVumX05u9Omymecu/KCLF6GrLxNhRw0G3Is5Xmb4G5/RG1wFzkpKs3ll0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmOwEiWG/HFPxG3hEz2otTNN5BbOAsOPQSy9IIogtGT6XRA/e7
	msKskVPQAjLB6dX68s3JxpQx2GUdxHEh+2beaFZlje4BYXSitdBu1A9NasSnYMOi98sgFzHh9Gn
	TA24oYfpoySgAh3WncT7fS4/+GvIDLphZnu+D
X-Gm-Gg: ASbGncuUyQEtfQsAwn0Zk1+ElpCauenzgoH2DubBYRSPVtAdah7KXs0JgeR6YpRLl8Z
	fKaq9wvU+WlQCzLM2kSnANSblQrh99KcVk2glEd8qthk4LGzrjDHLduVqsGp7UWu8P3nYjdmAxF
	c301pK78WLWcHNZRlTJ4b0wA==
X-Google-Smtp-Source: AGHT+IGh+tKAyMeigoarPIi+V1deYWycva3XdHdZPQu9YAQ/LoyQ/7QaDDfIn1SlXnCdq3yX/3xBVxLxcxwerl1v8k0=
X-Received: by 2002:a05:690c:3682:b0:705:edab:f36d with SMTP id
 00721157ae682-708bcf63de9mr169594707b3.16.1746370983565; Sun, 04 May 2025
 08:03:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com> <20250502184421.1424368-2-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250502184421.1424368-2-bboscaccy@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 4 May 2025 11:02:52 -0400
X-Gm-Features: ATxdqUF_SJM_Ksnl9ID37yfRWwOX1K9UN729WFbsKoyMwbuKaeF0TYKGFD4cZ_k
Message-ID: <CAHC9VhQi2m19pJvUiTbzaNqh3omYGCVC43_G7H8EvZsPaOzevQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] security: Hornet LSM
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jan Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev, nkapron@google.com, 
	teknoraver@meta.com, roberto.sassu@huawei.com, xiyou.wangcong@gmail.com, 
	Tyler Hicks <code@tyhicks.com>, James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 2:44=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> This adds the Hornet Linux Security Module which provides signature
> verification of eBPF programs. This allows users to continue to
> maintain an invariant that all code running inside of the kernel has
> been signed.
>
> The primary target for signature verification is light-skeleton based
> eBPF programs which was introduced here:
> https://lore.kernel.org/bpf/20220209054315.73833-1-alexei.starovoitov@gma=
il.com/
>
> eBPF programs, before loading, undergo a complex set of operations
> which transform pseudo-values within the immediate operands of
> instructions into concrete values based on the running
> system. Typically, this is done by libbpf in
> userspace. Light-skeletons were introduced in order to support
> preloading of bpf programs and user-mode-drivers by removing the
> dependency on libbpf and userspace-based operations.
>
> Userpace modifications, which may change every time a program gets
> loaded or runs on a slightly different kernel, break known signature
> verification algorithms. A method is needed for passing unadulterated
> binary buffers into the kernel in-order to use existing signature
> verification algorithms. Light-skeleton loaders with their support of
> only in-kernel relocations fit that constraint.
>
> Hornet employs a signature verification scheme similar to that of
> kernel modules. A signature is appended to the end of an
> executable file. During an invocation of the BPF_PROG_LOAD subcommand,
> a signature is extracted from the current task's executable file. That
> signature is used to verify the integrity of the bpf instructions and
> maps which were passed into the kernel. Additionally, Hornet
> implicitly trusts any programs which were loaded from inside kernel
> rather than userspace, which allows BPF_PRELOAD programs along with
> outputs for BPF_SYSCALL programs to run.
>
> The validation check consists of checking a PKCS#7 formatted signature
> against a data buffer containing the raw instructions of an eBPF
> program, followed by the initial values of any maps used by the
> program. Maps are verified to be frozen before signature verification
> checking to stop TOCTOU attacks.
>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  Documentation/admin-guide/LSM/Hornet.rst |  65 ++++++
>  Documentation/admin-guide/LSM/index.rst  |   1 +
>  MAINTAINERS                              |   9 +
>  crypto/asymmetric_keys/pkcs7_verify.c    |  10 +
>  include/linux/kernel_read_file.h         |   1 +
>  include/linux/verification.h             |   1 +
>  include/uapi/linux/lsm.h                 |   1 +
>  security/Kconfig                         |   3 +-
>  security/Makefile                        |   1 +
>  security/hornet/Kconfig                  |  24 +++
>  security/hornet/Makefile                 |   4 +
>  security/hornet/hornet_lsm.c             | 250 +++++++++++++++++++++++
>  security/selinux/hooks.c                 |  12 +-
>  security/selinux/include/classmap.h      |   2 +-
>  14 files changed, 380 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/admin-guide/LSM/Hornet.rst
>  create mode 100644 security/hornet/Kconfig
>  create mode 100644 security/hornet/Makefile
>  create mode 100644 security/hornet/hornet_lsm.c

...

> +Configuration Options
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Hornet provides a kconfig knob
> +CONFIG_SECURITY_HORNET_WHITELIST_PID_ONE.  Enabling this will allow
> +bpf programs to be loaded from pid 1 without undergoing a signature
> +verification check. This option is not recommened for production
> +systems.

...

> +config SECURITY_HORNET_WHITELIST_PID_ONE
> +       bool "Whiltelist unsigned eBPF programs from PID 1"
> +       depends on SECURITY_HORNET
> +       default n
> +       help
> +         Selecting this will configure Hornet to allow eBPF loaded from =
pid 1
> +         to load without a verification check.
> +         Further information can be found in
> +         Documentation/admin-guide/LSM/Hornet.rst.
> +
> +         If you are unsure how to answer this question, answer N.

...

> +static int hornet_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *a=
ttr,
> +                               struct bpf_token *token, bool is_kernel)
> +{
> +       if (is_kernel)
> +               return 0;
> +#ifdef CONFIG_SECURITY_HORNET_WHITELIST_PID_ONE
> +       if (current->pid =3D=3D 1)
> +               return 0;
> +#endif

Two quick comments on the build-time conditional above.  First, unless
there is some subtle reason why you only want the exception above to
apply to a single thread in the init process, I would suggest using
task_tgid_nr() instead of current->pid as I believe you want the init
exception to apply to all threads running within the init process.
Second, I think it would be helpful to rename the Kconfig knob to
CONFIG_SECURITY_HORNET_PIDONE_TRANSITION, or similar, to help indicate
that this is a transitional configuration option designed to make it
easier for developers to move to a system with signed BPF programs
without excessive warnings/errors from systemd in the beginning.  I
would highlight the transitory intent of this Kconfig knob both in the
Kconfig description as well as the Hornet.rst doc, a brief explanation
of the drawback for enabling this long term or on "production" systems
in the Hornet.rst section would also be a good idea.

--=20
paul-moore.com

