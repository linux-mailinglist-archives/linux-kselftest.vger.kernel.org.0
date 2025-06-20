Return-Path: <linux-kselftest+bounces-35444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2ABAE1DED
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 16:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2383AB673
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 14:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028572BD5AF;
	Fri, 20 Jun 2025 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="jiHtZcP+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022A6238D57;
	Fri, 20 Jun 2025 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750431383; cv=none; b=u19uTKnGcr9vO9Vlky155lSWomgQWe8CWdvKV4/M7WgnInxd+0enE9NNTYrtNSbiR1cVf9O1bIJS8MnmXv5OXF/4CU2A+XHCeal1sbmAa2hs9ZOGrxLcAvz+dEzNEELlNbX/Mj13hOQH54bcCTrKZQecMDym8b18hMBMT5e+NWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750431383; c=relaxed/simple;
	bh=KeAdY4d0cQANbJNGCRb8Z3ipjjE1ByYddMKzzlWqmpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsYTDJ1FN5rrmvzynLP6n8SpRFq28Xdvn3gK5ru8AxA/sIcBd4xrSQND/oFG7nY/E9ew8i8LSLjSSVBSbPDIp9scWPyVepoJXKhIFkI/cx6onr7kjjIWzDl0pCmPsrHDJcD8QxSaCpgm876STg71glFnF+OjVJ8Tlm+QWnN7dxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=jiHtZcP+; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1750431373;
	bh=d+9Oljaa8nVwFXMldUvn8KGLEXEO6mQB0rGIcsdEKuE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=jiHtZcP+Z63+TnW4X2nDakt6soxRpOBJnD1uM9FdWOxUeNRwuQ0IpARvAI5KSAAKq
	 y54fIB+CWpvNqYOVAAGKgWfMHer5wXfi3M0tdYsYMYgvmDRW9TXg/dwKgrb48EXaOU
	 UzPZX40NbULm1QDstGUcYbN/lxD85lkiqkvQc1Ls=
X-QQ-mid: zesmtpgz5t1750431369t3a4ec14a
X-QQ-Originating-IP: we/QfigL6tmmNVqvgAIa+m2z/XvXE2l0eBX/THfP+4w=
Received: from mail-yw1-f178.google.com ( [209.85.128.178])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 20 Jun 2025 22:56:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5536147073178439197
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70e302191a3so18311847b3.2;
        Fri, 20 Jun 2025 07:56:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWxmwlxLyKodCM634dBy12RBfxYwQ24uICxrgMF7r7xvL+AiiFueSOoUhrmwLr1he6xIPa7nVcl8obbjg=@vger.kernel.org, AJvYcCVAbGuDCdlZmuj0pE/IyNOYwhC3gEF4lwHmtssumWz7iw9C1sogTaLl2BcnpVPjQfWxVcDK19YLQNhsqrfZrW9v@vger.kernel.org
X-Gm-Message-State: AOJu0YyUfQl4CZ1+dBuErybvyu0dfaGGV5w8jT2lqgJiUKx9Q8HVCnsO
	JuvGhoZxmtqdVZAz5uDLlC/P78w5vce/b2lu9IoPUFZAFw0c3mJQ3pq0rnGK3aNAhxc19eLCqkd
	A0jdTbZWqkZFEqYFio/ILHBwlI716iZg=
X-Google-Smtp-Source: AGHT+IE4iv2qEvM8iF1q7CQ+2AU5TZ1FwuqsVLITl3Uh/iQfGo6kjpbytbiftf4SKsLOj/ViXWRfU3Ulh9UUj+j/oIM=
X-Received: by 2002:a05:690c:61ca:b0:70d:ffaf:48e1 with SMTP id
 00721157ae682-712c63ed67dmr42413407b3.9.1750431366218; Fri, 20 Jun 2025
 07:56:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620035125.2938774-2-chenlinxuan@uniontech.com> <213adda0-1db2-46e7-9342-cc97fbd58d96@collabora.com>
In-Reply-To: <213adda0-1db2-46e7-9342-cc97fbd58d96@collabora.com>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Fri, 20 Jun 2025 22:55:55 +0800
X-Gmail-Original-Message-ID: <0C9854C6041AF5C1+CAC1kPDMUUc3c7Ofyr7vXiW_Yt-kwrAOHK=9kQd5uCm2vv4h1gA@mail.gmail.com>
X-Gm-Features: AX0GCFv1RrpcOagRj6rVm3UUQF6GLHA5GNpSdpRGU3MN1Y4zYRM4DSpmFcdMLpE
Message-ID: <CAC1kPDMUUc3c7Ofyr7vXiW_Yt-kwrAOHK=9kQd5uCm2vv4h1gA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/filesystems/mount-notify: fix unused unused
 result warning
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	John Hubbard <jhubbard@nvidia.com>, Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>, 
	zhanjun@uniontech.com, niecheng1@uniontech.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NBkE/PP8DpFYfkDXBULGrQ4bPGlzJ5DeIvTJ5mfcD2P0JfSV3IfKc88W
	8pi/IDsHKYhYJofZv4MXhZ0hNBsYPbxI0zkJILVaroPxcQMVoVGbNnuuZi0yx4+IUc/eXzv
	KnwEnaKRO+TSpSNh25Hizy4fZAZGKl6Vug5ketwkckSeRKYTZBuEdRPDaUgRWGEHacql44s
	5528eD7X4LNwg7K4xFEUFEqtIjRcw+H1/67jJUKCx0S0DEtlQFOhC1WX1ZI2NGj4pCtsy/C
	QYJwAwraq3Ci80K04dWyXkh7Mnrn42Rgb5rk7NaELmFqKC5kTajyfDl7H91pDTplusd8xRB
	iE+ekmZ6X1CoqZtZ3cdEGkocBm3fKD4SqSXUO3shYGx3hEIBSYnS5n3oXR2n15GOwA6lDu/
	0Obf5eZ+iqK0i82nAchlkidZZPqruqkebsB9nQJyEt8b3UpllDl8KFCuVdWpMYfjmpuAs0h
	8HYX22wLMJ1NfBTzIodNO1FXiCc9AEwYhCzCkQcEKw+dodt/w+AnNTX1VtclYhFBzHrviJ/
	/kDFYpAEHB498Cx4ebFSs2nfqbnEpXaaqQxq9YvwbVtzO4lyoJ0dyckLRFs51sMzOvkkjHG
	hJH6vy3sGLCwVnTcF2I7oJumoObin7qcvUex92Ilhxr9dn2QbTAnIXWs2oXctNSc9S0ZeWy
	CYhi7ab5/Kjt13VJPdMRyUGmkhpKE3mbty20E9hCjbx13m8M6lGf8se2ERlqlyYW5Wfp/VI
	SqY+iLO9w8VHlyghup5qEjD7HPSkqud2mSnsTLErZmNWnYEgu7Y9dmQEBiGJEhx1SM6Nbg0
	cRf/He7kbIQpLaWGM0hKszLJ3vEDfm7EPQ3Ng3JFxPQh45XR96rSYiVDIh7h6JMRiZoXc9H
	dO/g00mNz11LLpbNByTGK5n03pAcAac1mjBTno0DSbF+pNxM4uhJREylSmRcXhzG7wsCDN/
	meV7L9lWkReJGozTXp3+ljOT2dhECEx2qm8lT8pnq61lVCcNidj6M00LNx4Dkjwt94BwS/m
	4jlBCfkbIc4+gfKzEazSG7Rz73yIbJqH6yjMQ9PFRRfe94OcA06kpRNfZSrzCe9E6vSW+62
	Cn3WBO02K8l0uLQIiUd6k0=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Fri, Jun 20, 2025 at 10:46=E2=80=AFPM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 6/20/25 8:50 AM, Chen Linxuan wrote:
> > When running `make kselftest`, the following compilation warning was en=
countered:
> >
> > mount-notify_test.c: In function =E2=80=98fanotify_rmdir=E2=80=99:
> > mount-notify_test.c:490:17: warning: ignoring return value of =E2=80=98=
chdir=E2=80=99 declared with attribute =E2=80=98warn_unused_result=E2=80=99=
 [-Wunused-result]
> >   490 |                 chdir("/");
> >       |                 ^~~~~~~~~~
> >
> > Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> > ---
> > Changes in v2:
> > - Apply changes suggested by Shuah Khan
> > - Link to v1: https://lore.kernel.org/all/20250610020758.2798787-2-chen=
linxuan@uniontech.com/
> > ---
> >  .../filesystems/mount-notify/mount-notify_test.c  | 15 ++++++++++-----
> >  .../mount-notify/mount-notify_test_ns.c           | 15 ++++++++++-----
> >  2 files changed, 20 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-not=
ify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_=
test.c
> > index 5a3b0ace1a88c..f8e0c6b06e2d9 100644
> > --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_tes=
t.c
> > +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_tes=
t.c
> > @@ -458,12 +458,17 @@ TEST_F(fanotify, rmdir)
> >       ASSERT_GE(ret, 0);
> >
> >       if (ret =3D=3D 0) {
> > -             chdir("/");
> > -             unshare(CLONE_NEWNS);
> > -             mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
> > -             umount2("/a", MNT_DETACH);
> > +             if (chdir("/"))
> Please use the APIs provided by the kselftest_harness.h instead of checki=
ng
> return types manually. For example:
> use ASSERT_EQ(chdir("/", 0)).

Are you sure=EF=BC=9FWe're in a forked sub process here.

>
> > +                     exit(-1);
> > +             if (unshare(CLONE_NEWNS))
> > +                     exit(-1);
> > +             if (mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL))
> > +                     exit(-1);
> > +             if (umount2("/a", MNT_DETACH))
> > +                     exit(-1);
> >               // This triggers a detach in the other namespace
> > -             rmdir("/a");
> > +             if (rmdir("/a"))
> > +                     exit(-1);
> >               exit(0);
> >       }
> >       wait(NULL);
> > diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-not=
ify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-noti=
fy_test_ns.c
> > index d91946e69591a..d6a6a7ee87028 100644
> > --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_tes=
t_ns.c
> > +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_tes=
t_ns.c
> > @@ -486,12 +486,17 @@ TEST_F(fanotify, rmdir)
> >       ASSERT_GE(ret, 0);
> >
> >       if (ret =3D=3D 0) {
> > -             chdir("/");
> > -             unshare(CLONE_NEWNS);
> > -             mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
> > -             umount2("/a", MNT_DETACH);
> > +             if (chdir("/"))
> > +                     exit(-1);
> > +             if (unshare(CLONE_NEWNS))
> > +                     exit(-1);
> > +             if (mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL))
> > +                     exit(-1);
> > +             if (umount2("/a", MNT_DETACH))
> > +                     exit(-1);
> >               // This triggers a detach in the other namespace
> > -             rmdir("/a");
> > +             if (rmdir("/a"))
> > +                     exit(-1);
> >               exit(0);
> >       }
> >       wait(NULL);
>
>
>

