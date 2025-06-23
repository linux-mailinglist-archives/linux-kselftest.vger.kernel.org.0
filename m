Return-Path: <linux-kselftest+bounces-35617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A518CAE40D1
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 14:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05813AF635
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 12:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7778524887D;
	Mon, 23 Jun 2025 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJuUf72k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D995D242D6F;
	Mon, 23 Jun 2025 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682346; cv=none; b=L+R9vaGKHUYH8BtM/5xUlutsWpBBAd38FqeJ4COieNJlA6au4AHyNqbNCOhNn1LSfPvj1X5F1BIL7FC56oV9temz+0bPlgOgRHw7hqpi7KC0C2zcNXQYml7v8gSO8T8k7Bjlp3yPwZ08+EaNszvuix/paLsagMJCuTSSO4FSqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682346; c=relaxed/simple;
	bh=VYo3p1+S5WO9Tb6kOiFHRrBY9irGuOM6GBG3nuNIfWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGbpModZir+N0ldCkyz3y2oticsiiqzb9L3+PErRjBKqDAYNuiFzmnFso+N+axZ1VTVnszWLdFjbGNvI0pOB8METAhTXvCtX9/2DNodCOnFrffPjTGcPG+KmocTyTHEgP1MVXXbowUNFgH7n038ldh9y5IygOOCkZtVHcDb89v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJuUf72k; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23602481460so35648035ad.0;
        Mon, 23 Jun 2025 05:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750682344; x=1751287144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWrGAMcPpZRG8lbQJxeM8jdjCzJyD9CWefbLAZMxLgI=;
        b=RJuUf72ky1dCPX/TSnIy3nCmubvUly2T21uijg5DV4aETFSmU09BSyPihJ2Bqui4wf
         h7kcwqvCwcfSQt0IZA7YKkjKKby75F2C9ldtTorwBmRVOJ2xU2K5AKgLWLSPAJv6nY2P
         N7vyF6UmSFvDnouGteFZb/waUHuNrPj5kkH54KmfAzSyy9HmcZZmZcryzlJH/wLn2pXM
         KSrs7+zc6d8tKzyyvNfvrDHXkWtubat1+6IKVp7p/krtcAuuy5vVhFXXiAlXD9im0xIo
         eqdAkTnvrQRiJxtydurKFwtMdQWtA+qzgyM3+bBZWh2E/XG0WgH5UzlODOVnrlRD8pma
         bohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750682344; x=1751287144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWrGAMcPpZRG8lbQJxeM8jdjCzJyD9CWefbLAZMxLgI=;
        b=qQU7VW4XjujUvK8g/I1RK1nFIRPBB5dMbPe7vO50pOZ8xM0HxQyBfIJ1D63wuMBWaL
         4wP+Y4QwMq8fMt1ORHCbtzU0xie99TUfU9vDshr6VUrfqnZDjwNaEP4OGrK4PtwK0AEY
         5opfAiemrO+RgND2ldgVCpcySKyZTfvRPsACETjUZNdVInywSAMfsZB+kVl4HI/2nvsm
         IZ32u66BGhAI6cdvx6pgMLurNV8JJxUei4ud+oW6dJn+kKLxFBiuxjPt5vNEKJMZBdaY
         9eEHDoLkqCLbRNSmtIL2YouwgoqVZ3eFM7lgmLMvko79pUv76Yt1YEn+/mkEfTniCOYE
         OJ0w==
X-Forwarded-Encrypted: i=1; AJvYcCU/G0KBJXYdwNuxjE4mD8a91A84u42s+KaQSUmfZksL3P8OvT63mbGqAidlDjrsOdl8Zc5bLWxhWg==@vger.kernel.org, AJvYcCUZ2WsD8ph6rJGu1Pev3s1E5AARdcJLH3fJWBe5lMaqzgv2FQI6JrA4Nv79IkY0pvxC9gje8ye4VkYtOoUb@vger.kernel.org, AJvYcCW2EsyzGvlUIS7PxI1Rlhvu4sd8bNOKK+Ez+oHx+KpLjVd6gTFAKgwsbvy8lp7pK0pXBu9HxwSaE9WWipvbr98=@vger.kernel.org, AJvYcCXt9ConeoxRt/adnkAMxq1N7FJgVOSGIZlTy4E+dYLAQWM7jCuNiUcmE6AvzhyFtkbNoLtpa+Ogjj5E/nDbLwBM@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2pIec3xMoOA+NlNw2f1joJ4rs8TCsJnehwe+itFwzihk9YMYv
	NH0d9s6bi8d/Cd4qF6ldeh1AyvX3LY5CiIWOsbPSwMX0ar3LV/v/74aCjR32tL2WuVe5PRlpH9X
	Kp2xssLIETg6Nx1L1LrluO4Ftvn3Jlg4=
X-Gm-Gg: ASbGncuOBaMH1cyzr+ACebN2HJ8Pr2CIurYjqQXxyz+gOOl+gSlFGsUNCyt3IKhrwbE
	wtJUJB7pJnBgMAWnkN+zpqiYf2L6/1olrWvSXLy0msLTuBKIp51q+gAHmNTKrZo3Vneg6nyXkiG
	t1jnXQi7l4I22kCC+owAs5IWaqSoSq0EuYuxkUHuQRAqq4KuR4Vl6nuA==
X-Google-Smtp-Source: AGHT+IHSzNNomm2sZ7DqFw/h9VK1brbUJVtiqQwHa1/h6hA4CGRTGEPksBVJIe6zn58E0Oipluv4lu24aaz6hy2XCTo=
X-Received: by 2002:a17:903:1a24:b0:234:aa5b:e7b1 with SMTP id
 d9443c01a7336-237d986e579mr155778265ad.18.1750682344055; Mon, 23 Jun 2025
 05:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622-toicsti-bug-v1-0-f374373b04b2@gmail.com> <20250622-toicsti-bug-v1-2-f374373b04b2@gmail.com>
In-Reply-To: <20250622-toicsti-bug-v1-2-f374373b04b2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 23 Jun 2025 08:38:52 -0400
X-Gm-Features: AX0GCFveve2Y7pvAArc2q1uVqo_M9l_e71tEKBIitiCegsNZwagPgJSEqL5WlVU
Message-ID: <CAEjxPJ6v12nLFx-x4-=esuPMp7L8UBvTzoj1kkTPcD2mDKKW8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux: add capability checks for TIOCSTI ioctl
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
> From: Abhinav Saxena <xandfury@gmail.com>
>
> The TIOCSTI ioctl currently only checks the current process's
> credentials, creating a TOCTOU vulnerability where an unprivileged
> process can open a TTY fd and pass it to a privileged process via
> SCM_RIGHTS.
>
> Fix by requiring BOTH the file opener (file->f_cred) AND the current
> process to have CAP_SYS_ADMIN. This prevents privilege escalation
> while ensuring legitimate use cases continue to work.
>
> Link: https://github.com/KSPP/linux/issues/156
>
> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
> ---
>  security/selinux/hooks.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 595ceb314aeb..a628551873ab 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3847,6 +3847,12 @@ static int selinux_file_ioctl(struct file *file, u=
nsigned int cmd,
>                                             CAP_OPT_NONE, true);
>                 break;
>
> +       case TIOCSTI:
> +               if (!file_ns_capable(file, &init_user_ns, CAP_SYS_ADMIN) =
||
> +                   !capable(CAP_SYS_ADMIN))
> +                       error =3D -EPERM;
> +               break;
> +

So, aside from what I said previously, this also will break any
existing policies currently controlling TIOCSTI
via the selinux ioctl checking in the default case, so at the very
least, this would need to be gated by a new
SELinux policy capability for compatibility purposes. But I'm still
unconvinced that this is the right approach.

>         case FIOCLEX:
>         case FIONCLEX:
>                 if (!selinux_policycap_ioctl_skip_cloexec())
>
> --
> 2.43.0
>
>

