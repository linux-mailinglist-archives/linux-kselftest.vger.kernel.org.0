Return-Path: <linux-kselftest+bounces-35615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AE2AE40A8
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 14:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2112F3BE609
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 12:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF60723E23C;
	Mon, 23 Jun 2025 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3yQUiSa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C001DF728;
	Mon, 23 Jun 2025 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682137; cv=none; b=Eu785+KqhKlSorT1SNO0t2urJT6Y1hGG3ENCiSRGv0edPxghURrHG3eSfDK5GM+bZQGn/JAi75J/dtbHcBPxCYhjdpCd5piz193jmZo9dKtVVXgd0LsOcvypAVgXknn5I4cR/bBoRCFosS64tfDrejRibbztDqWAEdB5maxZoNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682137; c=relaxed/simple;
	bh=Fw8H1bJz3s55X12OstVPkl/Ss/KPoSsjGMv4XIofF3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBF2+a+PTkBhRyA9swwvXIdyNihTCvgu9K4dr2+yy3Kc/fXxOr7e6q0iB6DeRRUJhpj/NWWhBfUvGb8EH4Pc0Kp4ci6DC5RlDoAzSFa+FVHqXsMyNi1QLccRnLLhnZt41AxURTxYW75xcxTKzvU2n5rD4Ntw1ASqU6wsC0fx9Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3yQUiSa; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-312e747d2d8so3205345a91.0;
        Mon, 23 Jun 2025 05:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750682135; x=1751286935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7qhLKSaZBJUrIQxrexkwHh16gMLen9lREkpVcdbEtQ=;
        b=B3yQUiSa7l3Ph10YCNdYqsld90RF15RqUG3arqhBT3Ym/fgxggwleqexhl1gNvxEVG
         3b3om6XIvKaYc2POshekmDqoB2YElD42NQqUL+eMCpSOPoIPVYJVGAXwMC5UkUoDel4q
         hcIWDBWUeqoqIjTTWgfcxcrI2Xnn68N7Y+aCzuXrLjmBmp7+4HTysSqUIC/yPAtM6yRc
         Lvu9mzg2aVy2Fwhk13gyGE14AKP1ZMDanz87gLBJmPgwHI+ujRMqLeuqKva0l1UMDmvm
         ttPw2TPU6TMwB+BxeevYHxT7ttbaxy2dseVyNiePJoawyS2WmCNs/3MUhSZLUSx/+OE7
         9IGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750682135; x=1751286935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7qhLKSaZBJUrIQxrexkwHh16gMLen9lREkpVcdbEtQ=;
        b=HmwonrBC8yEqGeks13dwCAPbiwTpSD6W5QdM1riggl9BFfubMKRyXwBQK5cBvqNHx7
         I0ZB9kKlw0v8FXR4oBtusZHhmBkCnMoLJTrYiMbTY2s/wcd92LTo72e7ieoVHU6qHMk5
         V22xglT/XFYcppK0HIT8XHJckEMhe77RUIs2+Q524zNQoVz80z7bfHWPJKphX9wxuu8O
         FDLDF/qAFa2YBeLKw/7hHCjlDXk4IURpZfFmUL6Nh29yJ3nVgf1U8yLdGaryUliffdjh
         KO+6M2ISmJcUbUxFDT/WjXaramzP3GZ+h6NhTT9yd0JCPJF/YHP/mCWcOsAl7jNMVjKV
         VG0w==
X-Forwarded-Encrypted: i=1; AJvYcCV+uWKliNGpZcnykMPNPkDOZy2zo3vujhvCOsO2O0+AwEVvLuz2WmAnX8eS0d66CSp/nwYziMngg4TNd3xCmjD0@vger.kernel.org, AJvYcCWmgmX4XyUJN/NtxVnUvk7fOCfEluXr9fl38AT2pb/ri7V9lDDBjP0uNF70XrwYR+fserIVjYoJzHFTh9LY2dw=@vger.kernel.org, AJvYcCX22DHYN9a+ZjjokXuwrXZ+Qiz+dSaFt9k6PQoFx4OU7UqSDZkPwNK1ZLFAI7PswCFx0E2Ltm8wQQ==@vger.kernel.org, AJvYcCXF6qNlICpwF87LD9gUwlZYk08IPgZaw0lhJU0hM0x2yrGSWR3wCD1j1tFAfkbCfz+ixS9DFbdjUsgocyz/@vger.kernel.org
X-Gm-Message-State: AOJu0YyLHS2S1tokvSFCJZ5nTpclWIFjJFpTMPlEdyz795ziqQhEXwNJ
	ftm2JyjE3kToc1FGo5VngpqGdYMS1cKtRrkGh9JEOOta0EDjjeXInUqfxcuo8aHh4uQOEDR7mxL
	YFHaEqw2yek7BaTWxzHxlWdWQqzFwURU=
X-Gm-Gg: ASbGncsP3llbvsoteKz9sDPZ9sezWXaxNuZBM/JFGOZAAOSC1fhpiEo1KV7Fmx0FzN3
	f6oRjXE3qgPNpAk2vlHb4zXxBd6Xpkgoivg/Jxx6hFFM1ftZhTokyCe167gn8BhwpiQ33cL07tI
	eIsW4TeO5Np4124gP2RBRnXXYqnnn3Ah9YeUOU2/bYkcMYjxywgjRZ5g==
X-Google-Smtp-Source: AGHT+IFgLQuZoeX9b3aKKJtmdXKrWNO2mg86tL81LoOCWkqAY8Cl6nMZugpAgQtX1P3C6+d9ero2JdkR6FprooZDhVc=
X-Received: by 2002:a17:90b:4c50:b0:30e:6a9d:d78b with SMTP id
 98e67ed59e1d1-3159f50379bmr16763807a91.12.1750682135242; Mon, 23 Jun 2025
 05:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622-toicsti-bug-v1-0-f374373b04b2@gmail.com>
In-Reply-To: <20250622-toicsti-bug-v1-0-f374373b04b2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 23 Jun 2025 08:35:23 -0400
X-Gm-Features: AX0GCFuLnTJxzf2okVc0glfm3bX5AeBW2XJ6g5gUFYldkEA9RJmWnCx-TMi6png
Message-ID: <CAEjxPJ4bru=J=XZGSFXoxkQJZHQX_iJaxdCwpY8PAcaNv0F2fA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Possible TTY privilege escalation in TIOCSTI ioctl
To: xandfury@gmail.com
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
	selinux@vger.kernel.org, kees@kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2025 at 9:41=E2=80=AFPM Abhinav Saxena via B4 Relay
<devnull+xandfury.gmail.com@kernel.org> wrote:
>
> This patch series was initially sent to security@k.o; resending it in
> public. I might follow-up with a tests series which addresses similar
> issues with TIOCLINUX.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The TIOCSTI ioctl uses capable(CAP_SYS_ADMIN) for access control, which
> checks the current process's credentials. However, it doesn't validate
> against the file opener's credentials stored in file->f_cred.
>
> This creates a potential security issue where an unprivileged process
> can open a TTY fd and pass it to a privileged process via SCM_RIGHTS.
> The privileged process may then inadvertently grant access based on its
> elevated privileges rather than the original opener's credentials.
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> As noted in previous discussion, while CONFIG_LEGACY_TIOCSTI can restrict
> TIOCSTI usage, it is enabled by default in most distributions. Even when
> CONFIG_LEGACY_TIOCSTI=3Dn, processes with CAP_SYS_ADMIN can still use TIO=
CSTI
> according to the Kconfig documentation.
>
> Additionally, CONFIG_LEGACY_TIOCSTI controls the default value for the
> dev.tty.legacy_tiocsti sysctl, which remains runtime-configurable. This
> means the described attack vector could work on systems even with
> CONFIG_LEGACY_TIOCSTI=3Dn, particularly on Ubuntu 24.04 where it's "restr=
icted"
> but still functional.
>
> Solution Approach
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This series addresses the issue through SELinux LSM integration rather
> than modifying core TTY credential checking to avoid potential compatibil=
ity
> issues with existing userspace.

So I'm unconvinced that fixing bugs in core kernel permission checks
by adding new checks to SELinux is the right way to go.
Also, SELinux already provides a way to control ioctl, although it too
uses the current cred, but the granularity of the
process labels and the ability to distinguish individual ioctl cmds
may mitigate this issue in practice.

>
> The enhancement adds proper current task and file credential capability
> validation in SELinux's selinux_file_ioctl() hook specifically for
> TIOCSTI operations.
>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
>
> All patches have been validated using:
> - scripts/checkpatch.pl --strict (0 errors, 0 warnings)
> - Functional testing on kernel v6.16-rc2
> - File descriptor passing security test scenarios
> - SELinux policy enforcement testing
>
> The fd_passing_security test demonstrates the security concern.
> To verify, disable legacy TIOCSTI and run the test:
>
> $ echo "0" | sudo tee /proc/sys/dev/tty/legacy_tiocsti
> $ sudo ./tools/testing/selftests/tty/tty_tiocsti_test -t fd_passing_secur=
ity
>
> Patch Overview
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> PATCH 1/2: selftests/tty: add TIOCSTI test suite
> Comprehensive test suite demonstrating the issue and fix validation
>
> PATCH 2/2: selinux: add capability checks for TIOCSTI ioctl
> Core security enhancement via SELinux LSM hook
>
> References
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> - tty_ioctl(4) - documents TIOCSTI ioctl and capability requirements
> - commit 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled")
> - Documentation/security/credentials.rst
> - https://github.com/KSPP/linux/issues/156
> - https://lore.kernel.org/linux-hardening/Y0m9l52AKmw6Yxi1@hostpad/
> - drivers/tty/Kconfig
>
> Configuration References:
> [1] - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/tty/Kconfig#n149
> [2] - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/tty/Kconfig#n162
> [3] - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/tty/Kconfig#n188
>
> To: Shuah Khan <shuah@kernel.org>
> To: Nathan Chancellor <nathan@kernel.org>
> To: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
> To: Bill Wendling <morbo@google.com>
> To: Justin Stitt <justinstitt@google.com>
> To: Paul Moore <paul@paul-moore.com>
> To: Stephen Smalley <stephen.smalley.work@gmail.com>
> To: Ondrej Mosnacek <omosnace@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Cc: selinux@vger.kernel.org
>
> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
> ---
> Abhinav Saxena (2):
>       selftests/tty: add TIOCSTI test suite
>       selinux: add capability checks for TIOCSTI ioctl
>
>  security/selinux/hooks.c                       |   6 +
>  tools/testing/selftests/tty/Makefile           |   6 +-
>  tools/testing/selftests/tty/config             |   1 +
>  tools/testing/selftests/tty/tty_tiocsti_test.c | 421 +++++++++++++++++++=
++++++
>  4 files changed, 433 insertions(+), 1 deletion(-)
> ---
> base-commit: 5adb635077d1b4bd65b183022775a59a378a9c00
> change-id: 20250618-toicsti-bug-7822b8e94a32
>
> Best regards,
> --
> Abhinav Saxena <xandfury@gmail.com>
>
>

