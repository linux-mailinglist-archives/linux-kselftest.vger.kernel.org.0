Return-Path: <linux-kselftest+bounces-35596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF72FAE3494
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 07:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C6A3AFB26
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 05:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4AF1B85C5;
	Mon, 23 Jun 2025 05:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="GuUqK/2o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E610623B0;
	Mon, 23 Jun 2025 05:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654852; cv=none; b=p865j15mopCWOXLIQdC1u3cLMt6FKTzixJ3fCNJas0s0OeHyEcKdsSfWYnfMbb44bdUFcq1GNpqyY5gn56G+6mg6zqajKFGxq43zSe9dmRfj9Znlft12dl+8kRq45jFQaRKOqZnXViYUxvQwjhq9Id2DfGm7DW2SZr9uk3vMzU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654852; c=relaxed/simple;
	bh=MBB+JGesTWbN7CxmaepHTUnZVx/db0WFdPILRJswbMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwAObWzopVu4oJwCHYy9z2H2jxuXgHhXeVQUS7D07CyvnGqSVdaCQCGCg8iyr6glwE2EQ+Afr/S8DM0iwun/sngXEdwGOVBo3ktTKsdSaYt1Rffnf1U5KF3ODN/V2N0BSMoyo0ptImmpzB1uUFAaw7NhipEMBAntP5z/+NmPrTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=GuUqK/2o; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1750654838;
	bh=7Vr828wLS31uvImM0k9i7td6sdaB7H7rLvF+XPEU8qE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=GuUqK/2onUgVFAZ3KL2C9yILQc8ng7z8V3ie66NAFVTipP06/220SB6LTMsbreU9m
	 IR9x0lX6yDx3JT8djDZOjWftHTZzq+aopd24e7lUoqyt5A/dJUW1THnyri4hpzUJGa
	 RYGR4QhmY6B4huVLIZw3WvCGF/llgRLcZtM4Y2mg=
X-QQ-mid: zesmtpsz1t1750654833t47d52526
X-QQ-Originating-IP: HcWqoOSL5kx9xLCP+Xxg30WnIZ3MBZp+40CMi80XV4U=
Received: from mail-yw1-f178.google.com ( [209.85.128.178])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 23 Jun 2025 13:00:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6300870357941378852
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70e5e6ab7b8so34007817b3.1;
        Sun, 22 Jun 2025 22:00:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVd+5m29r3vdR1kQQs0dbdIIhwKea3hTwdS2cCFDWzyOcUjC1kHlaJYsmRnyRMBLUBDFMEKVZDuTtSdOktYDp/G@vger.kernel.org, AJvYcCWrH7gaMjX6vXTqDIipQGSJN+eMT7mmSrTcJIBntuIKYI+3enDAAJ90T4p58QLjx72xLBdQoZUZFM+0C8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5YKI7uCrr0ZLbSdWGO+0LCCc/zbqdFwuFV+lT2cwPKDt6EtXo
	Qf2l7k16dj2gahgElgl4hnxfaIe64dYym73jvox2hMVrl7iPFOc0GQkBy6oZrMj5+HLKddIYhim
	Is3yuMTld8fukNGpnjB+u+1DfCPkBsyA=
X-Google-Smtp-Source: AGHT+IEx5eF8biVJ/e8eubY8PMZL//Igp4IgPXRDFhFCqshgzYl6uiyqweU1TI/7LXoXNaQPImcxza/jF+U/MAW+Pk4=
X-Received: by 2002:a05:690c:fca:b0:710:edee:74d1 with SMTP id
 00721157ae682-712c63b278emr152881187b3.3.1750654830851; Sun, 22 Jun 2025
 22:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620035125.2938774-2-chenlinxuan@uniontech.com>
 <213adda0-1db2-46e7-9342-cc97fbd58d96@collabora.com> <CAC1kPDMUUc3c7Ofyr7vXiW_Yt-kwrAOHK=9kQd5uCm2vv4h1gA@mail.gmail.com>
 <f9b2deab-bdc4-4fd4-be1b-cb6617060086@collabora.com>
In-Reply-To: <f9b2deab-bdc4-4fd4-be1b-cb6617060086@collabora.com>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Mon, 23 Jun 2025 13:00:19 +0800
X-Gmail-Original-Message-ID: <D7B3E803F9106094+CAC1kPDNPGdZzypz=a7N-dtewxRzEJBPZKOGm5iFkj2o9uk5XsA@mail.gmail.com>
X-Gm-Features: AX0GCFvRKEOzOKgfHGlq639HbGfpnO4sVI_H4S8Fio8RJGUFA2IILm02U28g5xg
Message-ID: <CAC1kPDNPGdZzypz=a7N-dtewxRzEJBPZKOGm5iFkj2o9uk5XsA@mail.gmail.com>
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
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OTX1oEdaR2wQ7OgjI/grYZ48f55RcJFPXpflPAs/seYPCX3tvkQN5rSS
	4XxmQrJwTgChEyVq6ddZXGNKGmE4vj3nfnqafehidumCkamVxeHcUzrhB8DPmC5uGg+PtPn
	ObWdrYwWX1asHGkq600CWGHA4ZKphztSc3FzgEwuQX6iL2n/AUAEYpZ7WUvTwzUfbJt6Rut
	0NoGuEqn8YRu6HmFOhw9Qpgpcicx9Zd/eqFk1IcmWxWoYvtI8XjlkuZ/I8rqVmn/4kyt66C
	tATK274eBXGjstPul0ZfZSZUL5IHmq2kZC6ao+L0OZLZC9xalgu1gZ5ak7+m4zGIKJG5JUF
	RHsQRLg9gDPQrtfyp/N3No0ai0Hi+UOXRHu6LvGv1TotQbH7j8yUUOR57SBCKKalMg79l72
	b0WhxcBHo7LA5b1E/j/i4FQculWIx56iDkKib8wo+Z4u6YLIO6liCsX7PqT981G/jLY2wWE
	1EvumFns7he2PvNYL1xzH98pe/WlbRSPurbZRDHduAnR7spw7x+TtkZDGNqhtX2bqFwVyzB
	TL30M/FEhEAL7gCRza7gmi5ihhPNMv2HMo2Ms5Z27ily+J/KQ5hlFC5HFX4dx3hR0ednh+Z
	16+EBhy0glC21OXU80r7QKQdkNmcoamqmZKtMMQUUbib/neJs0civr//Llm0OCItpGT9308
	N+h6548misXcqK4xKXSsnAL7DZDVTzfl/pxVuyTvfNT+Ev0eamBiU5WWG6HQGVxfH0o9Vv2
	re/LBNGdYAsAeba6B9jf2kf8yLvYF6tRaM6UdEWBY8PLSw5zs48Xvm4Nx44kO5ghaP51Fsl
	pjtQgUQqlEjJ1ulAYrUYDfXAKNdeOT3GpyRM8GAVjf3AjHOv5mUcFWAUNelQO09kHkpanbR
	o2PIfRsY/CLMVbb0LWTzFW7XarCZqKpXJX2wgXgcyAxNi4IkoKEDPpDEsUEc37soHxeXp0T
	ubyrYThTBjWDt2lKmfH0DK+yqdQUJ44J+deiOt1ADmVRjhz/T4NjDszbYufyj2LKko71NaE
	WlIR5z8k/T39yzgzm5AKhTvsI/ARYeHoC1ZulqOFk3OUz2SamcTITUAjFA4F1qSZNpowZM2
	SQS7SVqON8yNapWjP/Y0Fg=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Mon, Jun 23, 2025 at 12:22=E2=80=AFPM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 6/20/25 7:55 PM, Chen Linxuan wrote:
> > On Fri, Jun 20, 2025 at 10:46=E2=80=AFPM Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >>
> >> On 6/20/25 8:50 AM, Chen Linxuan wrote:
> >>> When running `make kselftest`, the following compilation warning was =
encountered:
> >>>
> >>> mount-notify_test.c: In function =E2=80=98fanotify_rmdir=E2=80=99:
> >>> mount-notify_test.c:490:17: warning: ignoring return value of =E2=80=
=98chdir=E2=80=99 declared with attribute =E2=80=98warn_unused_result=E2=80=
=99 [-Wunused-result]
> >>>   490 |                 chdir("/");
> >>>       |                 ^~~~~~~~~~
> >>>
> >>> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> >>> ---
> >>> Changes in v2:
> >>> - Apply changes suggested by Shuah Khan
> >>> - Link to v1: https://lore.kernel.org/all/20250610020758.2798787-2-ch=
enlinxuan@uniontech.com/
> >>> ---
> >>>  .../filesystems/mount-notify/mount-notify_test.c  | 15 ++++++++++---=
--
> >>>  .../mount-notify/mount-notify_test_ns.c           | 15 ++++++++++---=
--
> >>>  2 files changed, 20 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-n=
otify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notif=
y_test.c
> >>> index 5a3b0ace1a88c..f8e0c6b06e2d9 100644
> >>> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_t=
est.c
> >>> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_t=
est.c
> >>> @@ -458,12 +458,17 @@ TEST_F(fanotify, rmdir)
> >>>       ASSERT_GE(ret, 0);
> >>>
> >>>       if (ret =3D=3D 0) {
> >>> -             chdir("/");
> >>> -             unshare(CLONE_NEWNS);
> >>> -             mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
> >>> -             umount2("/a", MNT_DETACH);
> >>> +             if (chdir("/"))
> >> Please use the APIs provided by the kselftest_harness.h instead of che=
cking
> >> return types manually. For example:
> >> use ASSERT_EQ(chdir("/", 0)).
> >
> > Are you sure=EF=BC=9FWe're in a forked sub process here.
> ASSERT_* are macros. They can be used anywhere. Please give it a try.

V3: https://lore.kernel.org/all/20250623045711.3564655-2-chenlinxuan@uniont=
ech.com/

>
> >
> >>
> >>> +                     exit(-1);
> >>> +             if (unshare(CLONE_NEWNS))
> >>> +                     exit(-1);
> >>> +             if (mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL))
> >>> +                     exit(-1);
> >>> +             if (umount2("/a", MNT_DETACH))
> >>> +                     exit(-1);
> >>>               // This triggers a detach in the other namespace
> >>> -             rmdir("/a");
> >>> +             if (rmdir("/a"))
> >>> +                     exit(-1);
> >>>               exit(0);
> >>>       }
> >>>       wait(NULL);
> >>> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-n=
otify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-no=
tify_test_ns.c
> >>> index d91946e69591a..d6a6a7ee87028 100644
> >>> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_t=
est_ns.c
> >>> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_t=
est_ns.c
> >>> @@ -486,12 +486,17 @@ TEST_F(fanotify, rmdir)
> >>>       ASSERT_GE(ret, 0);
> >>>
> >>>       if (ret =3D=3D 0) {
> >>> -             chdir("/");
> >>> -             unshare(CLONE_NEWNS);
> >>> -             mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
> >>> -             umount2("/a", MNT_DETACH);
> >>> +             if (chdir("/"))
> >>> +                     exit(-1);
> >>> +             if (unshare(CLONE_NEWNS))
> >>> +                     exit(-1);
> >>> +             if (mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL))
> >>> +                     exit(-1);
> >>> +             if (umount2("/a", MNT_DETACH))
> >>> +                     exit(-1);
> >>>               // This triggers a detach in the other namespace
> >>> -             rmdir("/a");
> >>> +             if (rmdir("/a"))
> >>> +                     exit(-1);
> >>>               exit(0);
> >>>       }
> >>>       wait(NULL);
> >>
> >>
> >>
>
>
>

