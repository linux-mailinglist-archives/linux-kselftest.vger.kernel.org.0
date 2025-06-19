Return-Path: <linux-kselftest+bounces-35344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 482B0ADFF11
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 09:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96BDA189A1BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 07:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2D5218596;
	Thu, 19 Jun 2025 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="BQohErDd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C011A2632;
	Thu, 19 Jun 2025 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750319229; cv=none; b=mL2lqhU6AHUEXBFsZTzgMR0ggo2+YNgsn+LLR5jNsIWqia61qlDqQbca2iBaB9ZrVfAAR1IzO/sFI64xppHuIYK0OJwYGSs+7z/K53TFpunIUjsvehbmB29ZqN0cwOouGbMLofpAtE7dmlRTS1zwfspCQE3bdDvhyiDnAue7qqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750319229; c=relaxed/simple;
	bh=m8L0B5r5UqVt92IJSeeKTS2UGbxaqNEBCnEUz11hDc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MnY093ONvYpYFUWIGVhhXpM4OQnJQBTn0nliGTx7za0ATv/fxEBnrH7tURiP+JMMy3lIRwPI2fFgx73oDUYISbCIUNYKLR4s5i0ZpQe4WFcX1KEOm4dQHEqIaU/L2tkZbjfq4ulK2vs1bSmTRDlF9ivReakvd9Ds6A+vugYoirs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=BQohErDd; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1750319221;
	bh=0tEHb1ckfuwZJAmh8Sa7b0HkTWtQOHH25+P5khzmMqo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=BQohErDdgc1TRfI4mx8r+1oaSzhi9PdqePZqHU5VNoGflVNfAYhjo5bJ5KfA2ldt8
	 6B91skJfoBUh6NLzIDgYkLMAHZwAotVlvW43kq/TozbHmkvgD8Q3GDfGfcb+Y4/aJu
	 NBZyQJZXmCHIASpwO9KDGaL/JSjQWuMD1M0qN030=
X-QQ-mid: zesmtpgz9t1750319217t3101341a
X-QQ-Originating-IP: 9zXuvjAgzDTQIkjZ9rjrZ0zSambbCqCCLXTWWMFRLZI=
Received: from mail-yw1-f169.google.com ( [209.85.128.169])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 19 Jun 2025 15:46:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14689093333625918728
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7113ac6d4b3so5049207b3.3;
        Thu, 19 Jun 2025 00:46:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUO/ZuXQS4KjEXUchnpULlfiVcCjR2pClIm/Fvv9WCj6f/hsBBIPMfQ5ziKR/Pgo9G4IDUoAs1Z03t5PL8ulY6I@vger.kernel.org, AJvYcCUzDelJpzCj9N5RUeDNJZ6SW+P6uWzdy8ZCxuUJHIPgDZ/wEw9I+oaclPO9wWuHr1EjgOXxl6JISOirw7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhtQQHZeNr/ZieiPftkc911D2sKGidyGD0jntqsiL08QOYyoFL
	Oh5DkVJW6pgeSaqhk7X7mC8pgi1CPRrPi+BXzT9BFa1frUghhYLqsqR/CgnG/JlRaL27z5bTWPj
	+ye+zRn7eyLx/qQ6MXd5Jv3Q1NgCPWv4=
X-Google-Smtp-Source: AGHT+IGDJ5INl7g7v3aPIzD3hVjJa6I2rLo/PSwMtulgBz5JPXsZ6+6q34dBrokpAe5x6f+npaFv0NpFedAIMP/Jm3M=
X-Received: by 2002:a05:690c:6e05:b0:70e:128c:3005 with SMTP id
 00721157ae682-711754df646mr280859027b3.21.1750319214312; Thu, 19 Jun 2025
 00:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610020758.2798787-2-chenlinxuan@uniontech.com> <6972404e-0237-47b9-8e3e-15551bea3440@linuxfoundation.org>
In-Reply-To: <6972404e-0237-47b9-8e3e-15551bea3440@linuxfoundation.org>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Thu, 19 Jun 2025 15:46:43 +0800
X-Gmail-Original-Message-ID: <13ECF01EAD109F46+CAC1kPDPg0AN9Ft3SNM6JDcZf=XD1oinqeAMzuRpZF3nzemZ=Kg@mail.gmail.com>
X-Gm-Features: AX0GCFvajF8SQjwuml0LDznUZ5ejqurKaUHkMxf-frX4DNDamf3oI29oqUlnZ0U
Message-ID: <CAC1kPDPg0AN9Ft3SNM6JDcZf=XD1oinqeAMzuRpZF3nzemZ=Kg@mail.gmail.com>
Subject: Re: [PATCH RESEND] selftests: Suppress unused variable warning
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	John Hubbard <jhubbard@nvidia.com>, Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>, 
	zhanjun@uniontech.com, niecheng1@uniontech.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NSSdk1DMx7alhgRA2r2kob7lGPdrVPmBKtopjge7tpmqegvEHVl/Ghwa
	bJQXkLi4pRgdNvVDW1mXa2+AgtpBTKf1bsKelK8wTXSlntjOISOtiYnkGfegZGt+PsG1OVn
	wGAPgnjBSw5thmwRqjBDQbLTPLSXqkZe3Vb4136ygPi/exBcFvcpQRr1KVxK9j9ULpXGlox
	Eb8UNVv+9e8Hmmi31OiIZa3xQKzCc4yk077LTcBAbxmnJggH5LbO8k4P1Xjx6U/fzCp7JhB
	9FGOjpQOdh7qaVlPTt+5zjqKX/BoXL6rHNSAlxRdid2aa/GM3MsHydnRRAnyIhYMsaRWTGO
	1Pnhe+2kTEP0hIjepxKaBnVR6Kl+TDJz6gyXmJx0nnzr0ChicP9A/6uz6SP1qNTXwV8fdzs
	87SqjREz21QrzzDQQXIYCj7N3tlrHI5q6FvRTTzbFi2XJf/uSN3D8fGh+ayME7iM0DGoaiP
	Z+HRdULsb59PLknUn91KM4B0w2l3tjLSV1eWRBgMfKeTRFys0on4lWZivAOrRdaAqVAi2BL
	HNjZAFHHrju6rCsepMpiJ40XVMfVt2NdnVoGAn2cFy2uX94xDd+Qf0lJ/GNdd9qNa6TtzpX
	etYP5BXBboldaf4p3cIwt4PUeV57NmTsYEvJpSRXbz6rv3gEC+iUOq3QTnihtBEQWMGTk7w
	pnRaAVZxx7uQXmRl9lYrgM+AoGMv5+jzkBGZA1rWXQSyxqoIyL0J+wfwBoSAGvsWFAfg1+N
	o/5HMprZ5bkQJBTqrNqKv5ecbfiyWAiveuGmWPj2ADfc7vt+EKp5RGdXPC2H+ul1Kk8pvix
	EAGQbSS8BOku//GI8HhRWD3VHFO2aUnU83KTajVNas90b0OwZjrcn4Fq+3GhjYMnstkKFFs
	rnAXzb3NHNV7HLbQSgh/KAyDIkCpxBTAy4wxaqI3SSnqPpPVnKxuofOJeCCUNiCi6MkNC/w
	piUntL892sLtHmRxxiqCtNTRm1YWzOw9Z0CWcEKD7Ii4d0AE2NVaYDmVa4hl2mWDnSz6ENd
	vaXwBOmzFemOexfzRhyXtjcCjrWBguWvwd9UNpbDMcyogHzUwuYURiUfzVKCQuEamhBYUhL
	nQ1c9ZX2SnHHo/8+7hFDFg=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Thu, Jun 19, 2025 at 5:23=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 6/9/25 20:07, Chen Linxuan wrote:
> > When running `make kselftest`, the following compilation warning was en=
countered:
> >
> > mount-notify_test.c: In function =E2=80=98fanotify_rmdir=E2=80=99:
> > mount-notify_test.c:490:17: warning: ignoring return value of =E2=80=98=
chdir=E2=80=99 declared with attribute =E2=80=98warn_unused_result=E2=80=99=
 [-Wunused-result]
> >    490 |                 chdir("/");
> >        |                 ^~~~~~~~~~
> >
> > This patch addresses the warning by
> > explicitly suppressing the unused result of the `chdir` function.
> >
> > Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> > ---
> >   .../selftests/filesystems/mount-notify/mount-notify_test.c    | 4 +++=
-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-not=
ify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_=
test.c
> > index 63ce708d93ed0..34afe27b7978f 100644
> > --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_tes=
t.c
> > +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_tes=
t.c
> > @@ -465,7 +465,9 @@ TEST_F(fanotify, rmdir)
> >       ASSERT_GE(ret, 0);
> >
> >       if (ret =3D=3D 0) {
> > -             chdir("/");
> > +             // Suppress -Wunused-result
> > +             // Ref: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D66=
425#c34
> > +             (void) !chdir("/");
>
> Why not fix the problem the right way by checking the return value.
> Suppressing the error isn't useful.

The code is already handling cleanup in error cases,
and I don't think checking the result of chdir would be useful here.

>
>
> >               unshare(CLONE_NEWNS);
> >               mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
> >               umount2("/a", MNT_DETACH);
>
> thanks,
> -- Shuah
>
>

