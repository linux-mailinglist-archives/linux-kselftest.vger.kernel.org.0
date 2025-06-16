Return-Path: <linux-kselftest+bounces-35086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00399ADB58D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 17:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE04167A33
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 15:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC77257458;
	Mon, 16 Jun 2025 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3bZOHKZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02904214A94;
	Mon, 16 Jun 2025 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088148; cv=none; b=NvdqY4+7K3IyBqJ+NMtRo+vAiRXp3p11Pqm1GWTSCJstg16guFEfVsolH5/gW222709EtH8K+2/Dd+B+QBJ/AKymj9l5xUPOzZvWhh5KO8FtvF90CFBldGojFpxjc3kNa/d26cYI9S84bH5jXuYVybxFSa+Purkr6rAjkr4B7UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088148; c=relaxed/simple;
	bh=wyqcm4yLFb4zJVbqbZ+q1/zy0wFmRhuu32ZyoGJEm1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TojDn1/EltXeRMHpaQ2E/eNZtZV1HLaeKdw9pCRgdEF0eBTW8B1+4GPL3Ns5qdL/wSFBleABVH7hF9JJD4HyTuQQA3bL+cCFrfvnFS2GjHWbvR+RQwKH7wSTPb/wPUUB19mEAeiB19KK7Pqphkl0n5RVO4RIg5B796vt+CDt5+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3bZOHKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F203C4CEF3;
	Mon, 16 Jun 2025 15:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750088147;
	bh=wyqcm4yLFb4zJVbqbZ+q1/zy0wFmRhuu32ZyoGJEm1w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n3bZOHKZoHcqds6WdwLDyCh3eGecUSnALkzpuA6RI2FELJ0DG8RzDRcPyzsFnI4Ab
	 ZN4TgdtH68jdmFSKH1v4IEWLcNeGY5IGxIWYLylzvIdcpzqWQsJHUjBDhxKnqffsuA
	 9lQ2Ab3Sm2gIeJFCkShIkyDnsUFHgIUh5OSbS1VAGeL7udBfn4zwunNF9IiYoCyanx
	 q+9Tp/HH1rZdCnr+paz7eIpDktBTVHAbDfaMrB1RYh5x77mLUDUjEiQ60AW4dtxn+e
	 arDHNiEC8SwPHl7laJtMdGyaPFqIFI1lqOZs/U1Pg0W+m+OkFDB9RrtwCLe9b7+e6L
	 H+lO6Oxh40Mow==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54e7967cf67so4774161e87.0;
        Mon, 16 Jun 2025 08:35:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVkw1rpKVr8+9/zdzHaTr7UuDfpr5Kpz1ZDYGiBoTRPIBomoOk6uPYvwTAtIU6vp3d7yvmJsF1LPbo@vger.kernel.org, AJvYcCVLhkAUHLvSdeVoJ+f2vLzLqQcsVRhuOgA0O58+UVHz6GHqYXjql3gFKvcdy1d0V1rAigbdFe+m7Zw=@vger.kernel.org, AJvYcCWkqu6A5nFQ2d5DBuTMznURN2JvkzJKX/hI+o6aEtIH1Gs3KYYnnp6gikxvkP0SMjbXu49ZsoD//VPZa2Xv@vger.kernel.org, AJvYcCX603D6nx86jL7VRowUjoaoycjmDWZAHS5dciekGEPHP+/0fqYJCev0H3Is6o+jLTHT4FAHnoDkJ4udxMB2@vger.kernel.org, AJvYcCXcB3UO4cfZiwZB+EWcNdAMY+W2lnKBKguX5uj9fypr8gw6F+UNUcKgRdvcu0vj/rs02fv5YPfUJeU1qebKFg8/@vger.kernel.org
X-Gm-Message-State: AOJu0YxZX4OPcDuTNQwQbzk56+qTP60FOqT9otKyLVIoBu5f6C3etL8Z
	nRmODZ7jVhJq7CKNpfYT5KvPIrjsuP+L015PcKe+o/ZeOtWqinSt9G15qpbTtiGjSWpYYnjIwOi
	NwciWkqpODyNEHoECMe8/3S8DA80Cqkc=
X-Google-Smtp-Source: AGHT+IFbOeYossnraAyxlskXcqKyhhi56Nq19OyIZS4QGfWlkeawL/vDS4Zr+c6sgGu0d5OcjxKjLTWl/KyJOsqacys=
X-Received: by 2002:a05:6512:3096:b0:553:2f8c:e631 with SMTP id
 2adb3069b0e04-553b6e6898bmr2461277e87.9.1750088146062; Mon, 16 Jun 2025
 08:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de> <20250611-kunit-kselftests-v3-4-55e3d148cbc6@linutronix.de>
In-Reply-To: <20250611-kunit-kselftests-v3-4-55e3d148cbc6@linutronix.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 17 Jun 2025 00:35:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQUN3hWYh_1=LMzVp1Ddbq3W=yGHZ5__LbcfBajfuhscg@mail.gmail.com>
X-Gm-Features: AX0GCFsBbQd8edKmRItTPTAmU_9r7N84LVB4bZhJmBSwwSeK_bPp6ZeS2KFUAXQ
Message-ID: <CAK7LNAQUN3hWYh_1=LMzVp1Ddbq3W=yGHZ5__LbcfBajfuhscg@mail.gmail.com>
Subject: Re: [PATCH v3 04/16] kbuild: userprogs: add nolibc support
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 4:38=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Userprogs are built with the regular kernel compiler $CC.
> A kernel compiler does not necessarily contain a libc which is required
> for a normal userspace application.
> However the kernel tree does contain a minimal libc implementation
> "nolibc" which can be used to build userspace applications.
>
> Introduce support to build userprogs against nolibc instead of the
> default libc of the compiler, which may not exist.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>
> ---
> This could probably be moved out of the generic kbuild makefiles.
> I think the ergonimics would suffer and this functionality could be
> used by other users of userprogs.
>
> Also this does currently not support out-of-tree builds.
> For that tools/include/nolibc/*.h and usr/include/*.h would need to be
> installed into the build directory.
> ---
>  Documentation/kbuild/makefiles.rst | 13 +++++++++++++
>  scripts/Makefile.userprogs         | 13 ++++++++++---
>  2 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/ma=
kefiles.rst
> index 8aef3650c1f32b6b197e0dc777e26775d371a081..4cc7a1b89f1803857a4723284=
613111e9ad71d92 100644
> --- a/Documentation/kbuild/makefiles.rst
> +++ b/Documentation/kbuild/makefiles.rst
> @@ -974,6 +974,19 @@ When linking bpfilter_umh, it will be passed the ext=
ra option -static.
>
>  From command line, :ref:`USERCFLAGS and USERLDFLAGS <userkbuildflags>` w=
ill also be used.
>
> +Building userprogs against nolibc
> +---------------------------------
> +
> +Not all kernel toolchains provide a libc.
> +Simple userprogs can be built against a very simple libc call "nolibc" p=
rovided
> +by the kernel source tree.
> +This requires ``CONFIG_HEADERS_INSTALL=3Dy``.
> +
> +Example::
> +
> +  # lib/kunit/Makefile
> +  uapi-preinit-nolibc :=3D $(CONFIG_ARCH_HAS_NOLIBC)
> +
>  When userspace programs are actually built
>  ------------------------------------------
>
> diff --git a/scripts/Makefile.userprogs b/scripts/Makefile.userprogs
> index f3a7e1ef3753b54303718fae97f4b3c9d4eac07c..b1633a9de6c86a023c70a717b=
ac0b80b89d01431 100644
> --- a/scripts/Makefile.userprogs
> +++ b/scripts/Makefile.userprogs
> @@ -16,10 +16,17 @@ user-csingle        :=3D $(addprefix $(obj)/, $(user-=
csingle))
>  user-cmulti    :=3D $(addprefix $(obj)/, $(user-cmulti))
>  user-cobjs     :=3D $(addprefix $(obj)/, $(user-cobjs))
>
> +user_nolibc_ccflags :=3D -nostdlib -nostdinc -static -fno-ident -fno-asy=
nchronous-unwind-tables \
> +                     -ffreestanding -fno-stack-protector \
> +                     -isystem $(objtree)/usr/include -include $(srctree)=
/tools/include/nolibc/nolibc.h -isystem $(srctree)/tools/include/nolibc/

The tools/ directory is a different world, and Kbuild scripts do not know
anything about it.

And, you do not need to implement this in scripts/Makefile.userprogs
because you can move this to lib/kunit/Makefile.kunit-uapi or somewhere.









> +user_nolibc_ldflags :=3D -nostdlib -nostdinc -static
> +
>  user_ccflags   =3D -Wp,-MMD,$(depfile) $(KBUILD_USERCFLAGS) $(userccflag=
s) \
> -                       $($(target-stem)-userccflags)
> -user_ldflags   =3D $(KBUILD_USERLDFLAGS) $(userldflags) $($(target-stem)=
-userldflags)
> -user_ldlibs    =3D $(userldlibs) $($(target-stem)-userldlibs)
> +                       $($(target-stem)-userccflags) $(if $($(target-ste=
m)-nolibc),$(user_nolibc_ccflags))
> +user_ldflags   =3D $(KBUILD_USERLDFLAGS) $(userldflags) $($(target-stem)=
-userldflags) \
> +                       $(if $($(target-stem)-nolibc),$(user_nolibc_ldfla=
gs))
> +user_ldlibs    =3D $(userldlibs) $($(target-stem)-userldlibs) \
> +                       $(if $($(target-stem)-nolibc),$(user_nolibc_ldlib=
s))
>
>  # Create an executable from a single .c file
>  quiet_cmd_user_cc_c =3D CC [U]  $@
>
> --
> 2.49.0
>
>


--
Best Regards
Masahiro Yamada

