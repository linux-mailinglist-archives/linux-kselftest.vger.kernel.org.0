Return-Path: <linux-kselftest+bounces-36020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39665AEC392
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 02:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EFA4A3106
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 00:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D22B13B58A;
	Sat, 28 Jun 2025 00:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGXPk980"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEBF12FF69;
	Sat, 28 Jun 2025 00:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751071467; cv=none; b=cRIl4TAiE5kUE/YzyY9QFC7/D7sRa2lBpzNW281WrFdx632TG/SZ+U2O6W0CKbpmIOnBvvEXtD4inGx3iCOf03CT+ExwfLJ5a0/hQEZO/YCmkzH9BRBt3uYVrCZXw18ju7yIO55IICA+ioHml5pWkFn/IKym2aI3SFg1mr5FbFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751071467; c=relaxed/simple;
	bh=3DlYou99xKBPhtCbnrBB02y+pxpHZSdecYrNGaQcjfI=;
	h=From:To:Cc:Subject:Date:References:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Lnqdn6AUIgBAFdhICg04g8ihBFMG4bJr8ruXun2AxzZRoGWSDrS4galvbpEFF9bb79F8NRvfgKsntbBpEM8g5n8k9KwQASaGVuvJSqbTIOJ+IwDtf5Od7tfxPEYOOKjjdfVcUXmPIdQB+SWPuxJsJ9dzuy6YXPeIwol8hGsCrVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGXPk980; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso759578a12.2;
        Fri, 27 Jun 2025 17:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751071465; x=1751676265; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GpxNzKdU8lMnnqevDa29WkePK3DkzP2rZRE+gu6i3wM=;
        b=iGXPk980otBXbsvDgpnJNzkCYlqfKKaKY88a2FduJrRBL1vn2WH1eVv5sJGw9v25Fs
         QOnUjSIuY9RcwmzQ47MBY2EZ8oXvTtPB6jAaO67A8MMpIzly24E9HnIH5lbbbCTFJOHz
         LK7hn5LsiNL/mArxiq/i6jPdR8+BRABFMyDH64smFS/XGQhH677Ds/pSwI8+CxixrYq8
         xxbZldE3xer82TYd+JEvh3L3W+XoCBqrjkMeuVTh6DxCjbgFzP+9e+HH6iH6ln+WOKNJ
         0yixJ2LXkk75Y+jVw+rXiJ+rik7c49TRY1KeyS5L4BWtkCfIOrDUstDomFqY0w0nVkgB
         dIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751071465; x=1751676265;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpxNzKdU8lMnnqevDa29WkePK3DkzP2rZRE+gu6i3wM=;
        b=m5VImUj9wghFKVuFBMX77hUsJ8tNKuVnnUzicnWhjVBz1UDyT15pq4YwcUBKDq16KP
         6IIUAeCQ/tdu14QPxrtuy5/z7jSV6aeeF0N6BPxCG/oRe1Y7JMxn1f8iT1dvT1OhWfVu
         9EewfNrO2wN5j4CC9BF5YG5Tzit2G4xwGUocnheoWlDR5rdoV9zNuWk4M0dzjMdb3LIa
         ZFgGyb+4hOzPxE9gauFUekkrsXs5iTu06X2vSBlMTZE06XICm0YtawVuGvt2clT9QrrI
         B8qaNckE2zVUho6mi/3ZVX0oBUDjUezsdBzcq8sUbfNGITDf+WfCVV6z5ScINlI5DJxn
         8xNw==
X-Forwarded-Encrypted: i=1; AJvYcCVI7IG2NShUte/uJYZEOS9vgB4I3H8VeBfQ+RQicB6b6y4s0vfhVT71q4UOMi6Z0nzhbGDB8n62DpoAFSRk@vger.kernel.org, AJvYcCVlacMV8V6s2Qjh2LmzvsCl4LOXwCMYanIrn1YVoaOTov9hR7cO1GbBWS8+Op/NKgohIX1VL3DpSawpdI14xtg=@vger.kernel.org, AJvYcCVoTqqgMW5OayEGYeM7o2PjVTiz8eBDjEvSbqB7h55uRTslD9HbJADs4PlF+rTmribi+PkEODtlOID8hTQweIYA@vger.kernel.org, AJvYcCXd9yjc8iWaDmzBIUu+6XoMNR4xP2GX5JtwjMAAi1GQwQVx3vZyVYBR4E5HO6QKjV91CFSQJEGLUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyry4gTYPUerd2ZDIYVT7UuLsbdU74Zjd2O/6RXU19yJo4OcyN
	aPK4lhCe8Uw9Xxu6nu8rb5tbDJnuBpbUkPowBlPZ4XLFH4jiNpURaSorTVQti83/9ns=
X-Gm-Gg: ASbGnctGtRkF1DOA0Xufo8hdvwWCz+4VSPDt5RK7LQQNNHUfm1c4Tb8hMFuqhqa9J9g
	Sz21MbSRt8WdXrFHbuad/cNlREDHFwG2C+apfC01dclYGZoNLp8ssFJeNQ2vZkYNVPWIkgOmxOV
	9B96IC+7lwGHHiwj5sqVQbvGxg5jdr7ic21RZXQRZe0S9ilYwhotMXHAyZk19/vz9ETBj+Zq2BX
	rWmiKHWSsSgDXemScvSX+0twT2dYnelcDGRsl0i11pwMSX4tXoUvRj2bhiJil4CBa+/E+Q2XV67
	Ymvyojl003G97bi1MkFLTK243xrGI8zlDaLuYuh7P/DOojkMWyKm
X-Google-Smtp-Source: AGHT+IHFC6aR3irUDLsqIURFtrCziwHLbDvreY8MVz83v50IvdwAMb01cbpFfB+89lcldfKQWSmCTg==
X-Received: by 2002:a17:902:d603:b0:235:711:f810 with SMTP id d9443c01a7336-23ac43d3283mr84587795ad.23.1751071465118;
        Fri, 27 Jun 2025 17:44:25 -0700 (PDT)
Received: from 1337 ([136.159.213.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e39d4sm26196845ad.18.2025.06.27.17.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 17:44:24 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
To: xandfury@gmail.com
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Paul Moore
 <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 selinux@vger.kernel.org, kees@kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/2] Possible TTY privilege escalation in TIOCSTI ioctl
Date: Fri, 27 Jun 2025 18:38:42 -0600
References: <20250622-toicsti-bug-v1-0-f374373b04b2@gmail.com>
User-agent: mu4e 1.10.8; emacs 30.1
In-reply-to: <20250622-toicsti-bug-v1-0-f374373b04b2@gmail.com>
Message-ID: <87y0tcu23d.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Abhinav Saxena via B4 Relay <devnull+xandfury.gmail.com@kernel.org> writes:

> This patch series was initially sent to security@k.o; resending it in
> public. I might follow-up with a tests series which addresses similar
> issues with TIOCLINUX.
>
> `=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D'
>
> The TIOCSTI ioctl uses capable(CAP_SYS_ADMIN) for access control, which
> checks the current process=E2=80=99s credentials. However, it doesn=E2=80=
=99t validate
> against the file opener=E2=80=99s credentials stored in file->f_cred.
>
> This creates a potential security issue where an unprivileged process
> can open a TTY fd and pass it to a privileged process via SCM_RIGHTS.
> The privileged process may then inadvertently grant access based on its
> elevated privileges rather than the original opener=E2=80=99s credentials.
>
> Background
> `=3D=3D=3D=3D=3D=3D=3D=3D'
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
> CONFIG_LEGACY_TIOCSTI=3Dn, particularly on Ubuntu 24.04 where it=E2=80=99=
s =E2=80=9Crestricted=E2=80=9D
> but still functional.
>
> Solution Approach
> `=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D'
>
> This series addresses the issue through SELinux LSM integration rather
> than modifying core TTY credential checking to avoid potential compatibil=
ity
> issues with existing userspace.
>
> The enhancement adds proper current task and file credential capability
> validation in SELinux=E2=80=99s selinux_file_ioctl() hook specifically for
> TIOCSTI operations.
>
> Testing
> `=3D=3D=3D=3D=3D'
>
> All patches have been validated using:
> - scripts/checkpatch.pl =E2=80=93strict (0 errors, 0 warnings)
> - Functional testing on kernel v6.16-rc2
> - File descriptor passing security test scenarios
> - SELinux policy enforcement testing
>
> The fd_passing_security test demonstrates the security concern.
> To verify, disable legacy TIOCSTI and run the test:
>
> $ echo =E2=80=9C0=E2=80=9D | sudo tee /proc/sys/dev/tty/legacy_tiocsti
> $ sudo ./tools/testing/selftests/tty/tty_tiocsti_test -t fd_passing_secur=
ity
>
> Patch Overview
> `=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D'
>
> PATCH 1/2: selftests/tty: add TIOCSTI test suite
> Comprehensive test suite demonstrating the issue and fix validation
>
> PATCH 2/2: selinux: add capability checks for TIOCSTI ioctl
> Core security enhancement via SELinux LSM hook
>
> References
> `=3D=3D=3D=3D=3D=3D=3D=3D'
>
> - tty_ioctl(4) - documents TIOCSTI ioctl and capability requirements
> - commit 83efeeeb3d04 (=E2=80=9Ctty: Allow TIOCSTI to be disabled=E2=80=
=9D)
> - Documentation/security/credentials.rst
> - <https://github.com/KSPP/linux/issues/156>
> - <https://lore.kernel.org/linux-hardening/Y0m9l52AKmw6Yxi1@hostpad>/
> - drivers/tty/Kconfig
>
> Configuration References:
> [1] - <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/drivers/tty/Kconfig#n149>
> [2] - <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/drivers/tty/Kconfig#n162>
> [3] - <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/drivers/tty/Kconfig#n188>
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
> =E2=80=94
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
> =E2=80=94
> base-commit: 5adb635077d1b4bd65b183022775a59a378a9c00
> change-id: 20250618-toicsti-bug-7822b8e94a32
>
> Best regards,

Hi everyone,

Thanks for all the feedback.

SUMMARY OF FEEDBACK RECEIVED
`=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D'

Re: SELinux, I agree. As I mention in the cover letter, using LSM was just a
suggested fix (not a solution). In retrospect, I should=E2=80=99ve added RF=
C to
the patch series.

I spoke with Kees this past week about the possibility of completely
disabling TIOCSTI while maintaining backwards compatibility. He confirmed
the initial focus was just on adding tests and improving test coverage.

OUTSTANDING QUESTIONS/COMMENTS
`=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D'

Based on the discussion, I have three specific questions:

1) Test coverage: Are the current selftests sufficient, or should I add
   more comprehensive TIOCSTI-specific tests? Or maybe KUnit tests?

2) SELinux patch: I can remove the SELinux-specific patch from the
   series.

3) Complete disable option: Is there broader consensus on supporting
   complete TIOCSTI disabling while maintaining backwards compatibility?

DESIGN OPTIONS FOR EXTENDED CONTROL
`=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D'

For question 3, I=E2=80=99ve analyzed three approaches for extending the cu=
rrent
boolean tty_legacy_tiocsti sysctl:

=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81
 Tri-state  Signed    Dual Bool=20
 (0,1,2)    (0,1,-1)  Controls=20=20
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94|=E2=80=94=
=E2=80=94=E2=80=94=E2=80=93|=E2=80=94=E2=80=94=E2=80=94-|=E2=80=94=E2=80=94=
=E2=80=94=E2=80=93|
Backwards Compat     | No        | No       | Yes       |
Clear Semantics      | Yes       | Partial  | Yes       |
Extensibility        | Yes       | Partial  | Yes       |
Single Control       | Yes       | Yes      | No        |
Kernel Precedent     | Common    | Rare     | Common    |

**Option 1 (Tri-state):** 0=3DCAP_SYS_ADMIN required, 1=3Dlegacy, 2=3Ddisab=
led
**Option 2 (Signed):** -1=3Ddisabled, 0=3Drestricted, 1=3Dlegacy
**Option 3 (Dual bool):** Keep existing bool + add disable bool

The dual boolean approach preserves compatibility but requires managing
two separate controls.

NEXT STEPS
`=3D=3D=3D=3D=3D=3D=3D=3D'

Based on community input, I=E2=80=99ll:
=E2=80=A2 Focus on test improvements first
=E2=80=A2 Drop SELinux-specific changes
=E2=80=A2 Implement extended control only if there=E2=80=99s consensus on t=
he approach

Feedback welcome on any of these points.

Thanks,
Abhinav

--=-=-=--

