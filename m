Return-Path: <linux-kselftest+bounces-35341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB131ADFEC6
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 09:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77035189948B
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 07:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2C224418F;
	Thu, 19 Jun 2025 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="W1EU5ukR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A1E1624FE;
	Thu, 19 Jun 2025 07:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750318396; cv=none; b=o3RrCJaingimhtwFFhd022XUXC/JW7LFmS/U7lLjVBLIWzllzIIjWTtfNrjIJ8GVMWIRjpIQyTjiNWJ2TO8Wggm3f4lYeSJYnlMdA2U1xv27H5bkaP+Y+ULSxr/EQoj3QclQ7Xi2FnOBBcGDURtbPvG2twUQbIZIzdjhgfKnu/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750318396; c=relaxed/simple;
	bh=jJTJCnuUZuu5I7KpZyHw1dRPFExLhTji8RhL8GshejU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqsNQNnnuJNj2SWCe2c5rHJzD62zqnUzfYCj9nyqjp8vAT18kpLcLfK/ATYJ15DMzJ+wNS0Y09mJNpiRiw0GzLt7AVTJ86syD064bQMddWrcE1gMAm3cnxVaqtPgVJUB8F85AEeRXHrus/XvYuyLj9RPuXjA8DAVx3plZw9EIPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=W1EU5ukR; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1750318382;
	bh=hS9pkBauGtrLbwfALUak/O6IaavFUNnnrqvmuoEMxWQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=W1EU5ukRpz93tRE/d2VykfJhe0KGlhaJ6LXyKBQHU0VYTPwycHWGY16mHEvOyEG2u
	 zFT+Z3CG6YnipWlnW0TgqkcN/NNskdyJcEwlkCTmzMRaJmvzIonF64SkS47puZ4vjj
	 aB11rjkMXdQdu5/pZ0bipWPi6VCRs9UHRy+hxo5w=
X-QQ-mid: zesmtpsz9t1750318377tbc21b23f
X-QQ-Originating-IP: dWuuVPlY8vuYb0pAxJCPPSgbq6VlHNEuqihuDckeF0I=
Received: from mail-yw1-f172.google.com ( [209.85.128.172])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 19 Jun 2025 15:32:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14664830986900177817
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70e6bddc30aso4451257b3.0;
        Thu, 19 Jun 2025 00:32:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVeC1f7abzb6K6ALvOuSRpYvrmYnGRRyiktxzux+PyLHKn3Ic5DW+BO/WRc/w3Y0havnG4K81HNSj6gRG8nblph@vger.kernel.org, AJvYcCXxcvUIIr/jZdF4MMrW3KIzRaWaKyS72xT5Ptn8fORzWyj9yJTCB4k/4Ti1wXB3u0Mfzc5ddgMkojDL0dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAGczz/x1m/Pe++qunXmBrX9GTk4p1s7fMt5OgMqpHNcQWjEbI
	E1FNozrCWqe3BSB4mzbErfud5qcHLhvyC16aJeR6MIPb4c5YzhXA6Cajt+9Qsr2KehElJfhS2yd
	M9hWrNgBZOSKBbIwMpmjE9wOxK954fw0=
X-Google-Smtp-Source: AGHT+IFAuYqN4PVY3838CUXp+PSTNNhNwutzp0tc6osJzPm+nssprI2c8XNwVJDRAiSovs72ex2JX/RBJWhRpmp6YnA=
X-Received: by 2002:a05:690c:3512:b0:70d:f3bb:a731 with SMTP id
 00721157ae682-7117539977cmr268732267b3.9.1750318374963; Thu, 19 Jun 2025
 00:32:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610020839.2799222-2-chenlinxuan@uniontech.com> <97e0eae8-954a-40dd-91ee-4a0a7cc4b9b4@linuxfoundation.org>
In-Reply-To: <97e0eae8-954a-40dd-91ee-4a0a7cc4b9b4@linuxfoundation.org>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Thu, 19 Jun 2025 15:32:43 +0800
X-Gmail-Original-Message-ID: <3A53297940D67C21+CAC1kPDODFjR5sEVy-0steveRi+90AQrkV7xC50O9+hYzv6jQeQ@mail.gmail.com>
X-Gm-Features: AX0GCFvOPBosgHDI8EComfhSDilZaiUMzBjSr9S9Cy35SpdPsKTSKkbQqmShz-I
Message-ID: <CAC1kPDODFjR5sEVy-0steveRi+90AQrkV7xC50O9+hYzv6jQeQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] selftests: add missing include
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, Christian Brauner <brauner@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, zhanjun@uniontech.com, niecheng1@uniontech.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NxrXWi6fIKd3h3ZxfuxPxudQgjARUeG14Fs3RLSI3/YvH4pk24dPLSGq
	H5ECVARiodkno6WCrTYHm67Ovboc+dbo4ncXfal5DZ7vZFRhlm0fKJLqD50wdh90fWfp/qJ
	b6CA8lCaawhsoa/uivFt8rtYjPh7M4nr8ZDrMlNSVBfDJjX0o1f9mMFhCqdu5Jn8YL52A7o
	a1iU858Ep5KvhjaVwnGF2ijlfiXb80EBZHiR0T6tvDIurT9hvNzJAf95qGJhz1ZymUQBQhs
	KrPcOyAAKDQY7RAYebCZOPYfD//ZZmkcPtbveNFNTLscmwc3N0mcjQpS8Nu6TngF51/+bOM
	EUe2eZ1V4+QFLthqSiX4wTr6uzvD03S+sqIa9Bf7fJf3LTBdxR87Cbd+WAhUywfjkCMXVMe
	fcc05A/hEuDbFE/rdZbY1XH7pCV50Kdyuyj4dlcQPDWSj9YdX/o3FvKgQFi94UN6Orqw5/D
	Ya3bkZRI1ZGlS+oqjHLnbg5NTNSldzE00TviP6I/bqvThi7cRdhiZlIMwrFJmyG2/wVWkwL
	n2JHXnTVpWpVp8jmAtzGxq4Z6ofdBWkZXebqLyQEVxKCU3Ty3hkgMXujof6SN02W+sCQKE9
	sX1PxDMcXoYd+Paw19ODbbV8r+aauVEtlfitT1hixmDGfN6bp9QOhP9mS4blGWjrp8qIpUP
	QwbZFRtsW/w1MZMEKNSfaRgWZkRahcYOR7YGLpzRnejSPKA8WmNoWP9kcJhjUlK35vPPnKQ
	7v5K+lydW3L0QcsrgcbKG3EAtwP0suxgpwnI0HmaQdYBWvjzivFIF8rWhalbvdbaBdzeyU9
	UH7LuRdxZhKv+27V+3thxG+XM3nT8h5LJ5izGlA15B22r/D8qMapg8vYmFytvMoWdfdOT6Y
	kjCOBpI/yL0DNOkPAL+kYdSOJ8eA/Y/YUf5kbYIYy6Gpz5WZXpYC1Jp169vjgVarrymC6o3
	43h12EWIPpg08a4VTQvMHoVWETOiiKkIRucM/iIYes7n8VKf7PfEkmyTuFHVMrVKbJIvtJX
	PXGBR/HfkY5oo6xoKr73i2uvP4z2ZVFBtrsZP6ExRtKZ1BsIPx
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Thu, Jun 19, 2025 at 5:25=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 6/9/25 20:08, Chen Linxuan wrote:
> > I failed to build this test on Ubuntu 24.04.
> > Compiler complained about undefined functions mount, umount and some
> > mount related flags.
> >
> > Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> > ---
> >   tools/testing/selftests/pid_namespace/pid_max.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/te=
sting/selftests/pid_namespace/pid_max.c
> > index 96f274f0582b6..c3ee8a2eff75b 100644
> > --- a/tools/testing/selftests/pid_namespace/pid_max.c
> > +++ b/tools/testing/selftests/pid_namespace/pid_max.c
> > @@ -12,6 +12,7 @@
> >   #include <syscall.h>
> >   #include <sys/mount.h>
>
> Hmm. I see mount.h included here?

=E6=88=91=E5=9C=A8=E9=87=8D=E6=96=B0=E5=8F=91=E9=80=81=E8=A1=A5=E4=B8=81=E7=
=9A=84=E6=97=B6=E5=80=99=E7=8A=AF=E4=BA=86=E4=B8=AA=E9=94=99=E8=AF=AF=EF=BC=
=8C=E8=BF=99=E4=B8=AA=E8=A1=A5=E4=B8=81=E4=B9=8B=E5=89=8D=E5=B0=B1=E5=B7=B2=
=E7=BB=8F=E8=A2=AB=E5=90=88=E5=B9=B6=E4=BA=86=E3=80=82=E6=8A=B1=E6=AD=89=E3=
=80=82

>
> >   #include <sys/wait.h>
> > +#include <sys/mount.h>
>
> You are adding a duplicate include for the same file?
>
> >
> >   #include "../kselftest_harness.h"
> >   #include "../pidfd/pidfd.h"
>
> thanks,
> -- Shuah
>
>

