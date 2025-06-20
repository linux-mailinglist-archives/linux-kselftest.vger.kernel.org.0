Return-Path: <linux-kselftest+bounces-35394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDC2AE10EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 04:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5BB3BE1E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 02:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272CA15574E;
	Fri, 20 Jun 2025 02:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="dBy+VZn3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5A514F9EB;
	Fri, 20 Jun 2025 02:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750385233; cv=none; b=iGVXabIPlEuUskDif25pccjiVGG1nsU38vFAtDLCiWutpAOiGZZmz9YH8/7xWWwoDZZZPPUPF3zbfV/Lby5hyHJzM1t6VGzv3xA/zlHec6Ut+2OUQa8JTNOqM7HNM8Cyi2kM2ST4chBSkkVPB4qRX9pufZCoOJuuKbf+in6fRbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750385233; c=relaxed/simple;
	bh=kYNKNmk6YJhkY5ahWJHqPWl9frwIrTQY4JiPKuXITvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CyzunNmL6/uqqFdx6hsELjzwTWVf/mJhO0AxPShnf+rsHY0CJhHaCTBvRWX5W9LCqga6LNye1xpTi5hzYz0nVSZs9+w2yv283/vuRRaw1mHtLPHGk7SVth1J+2032XYzVqji9MzvfYNVt3C3zz6BhfnZhI1uZMKE6aXhKfruzmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=dBy+VZn3; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1750385214;
	bh=b7wJ/bqV+s097aiwL/uQ42PKXT60gGGw54i379c/L/k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=dBy+VZn3r+Ap8LvUthCh5zC1u41b+a8by+32IFtte6g6Z4ooi44XHUmpX8f+XWPYP
	 6f+MzX2mu8y5Wg5L5VMNFsW53BbKMp+p68BGcmBWBd6BSD86NrYPeqeMy68BIeMfEI
	 5DtCYSuBhfVILkuIX2AhbEpY+yMbMnxn0/svAq8E=
X-QQ-mid: zesmtpsz9t1750385208t3897f19b
X-QQ-Originating-IP: cg7FGxWJmLEfZWjIyhD73nBa2uYPvIjGl0K+HayZnYA=
Received: from mail-yw1-f172.google.com ( [209.85.128.172])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 20 Jun 2025 10:06:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10565298664502637221
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70e302191a3so13114227b3.2;
        Thu, 19 Jun 2025 19:06:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZ7wIDPLB9jKHGcg6s9zlIqmiVK3QJHDpVOTfBwCyRPsp8Ziu66eZpNEcl++KgBn46PbY/V4+rkitXcOg8FHOC@vger.kernel.org, AJvYcCXxv59aiLZqXOqJR5NohAluVNRTjhKpqLPjzFLwapKffdPrJytP4O1zbL00cNumSI7k57rA3uA/vXeE8lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUTb/Pr1wmtfx1SQfF9SYfazoNgDbSyuxpWo6j3OUzI295Rri8
	jq5k+AbHIN/q5W8aH0mi5F2F58UkoZwOBuhegbL+LnKO9igKphbRnUiWPkSTd65arAkXyKRAyeZ
	hckXwgrzb6MiX4VGWgfUFJaOncF0nkHw=
X-Google-Smtp-Source: AGHT+IEuCT0NfTStQwX1w1oAE43j3dpE6iffgZEEN2Sc4FCect6ZxQcJb+R0nE1Iql9bHLN19lLPDxtazvv569ESkhw=
X-Received: by 2002:a05:690c:7447:b0:70c:b882:305 with SMTP id
 00721157ae682-712c68d0bdcmr17286227b3.36.1750385206198; Thu, 19 Jun 2025
 19:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610020758.2798787-2-chenlinxuan@uniontech.com>
 <6972404e-0237-47b9-8e3e-15551bea3440@linuxfoundation.org>
 <CAC1kPDPg0AN9Ft3SNM6JDcZf=XD1oinqeAMzuRpZF3nzemZ=Kg@mail.gmail.com>
 <265ebc1f-b0c0-4c57-92b2-41714469c7f5@linuxfoundation.org>
 <91817e12-54c4-4241-b895-2e452a00e0c4@nvidia.com> <f73fa51e-87e5-4805-bbbc-a7af9b50a1d8@linuxfoundation.org>
In-Reply-To: <f73fa51e-87e5-4805-bbbc-a7af9b50a1d8@linuxfoundation.org>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Fri, 20 Jun 2025 10:06:34 +0800
X-Gmail-Original-Message-ID: <9BB87B5BE7E0A790+CAC1kPDMW=htR_4EHCz6T=GVTOvfq6urqzUWDGev9MEfi26deWg@mail.gmail.com>
X-Gm-Features: AX0GCFumwtCnOIIPi8b0T3Xu7a243MLsXhutl7Hmd9KazaB5QGtU_DEXeoliyo4
Message-ID: <CAC1kPDMW=htR_4EHCz6T=GVTOvfq6urqzUWDGev9MEfi26deWg@mail.gmail.com>
Subject: Re: [PATCH RESEND] selftests: Suppress unused variable warning
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>, 
	zhanjun@uniontech.com, niecheng1@uniontech.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NCjYbQ0FTrEVuaYYI+06ZdbCxVC6SvtE5cuf+bjIPthEUcFsy4YAwW5j
	B1paOYneLLAnHvv3YFJoZ218IZ3UyegDBeDl5srbxeY/poBxYam1fq+V+LYAak8ghJY2iHQ
	neHbQVjx0UQ45acrkq44zcC28ncIf6K1SgeQhlI1Le+97ptl10e9AstkXrEOpGTUrHkeFAp
	JDRdYnUaj2o4muCXmuKnpybjxRXbS9GY+Dw+q3RZZ3JDRkAuRix0qdWhZB5KazctZ8Vbg0/
	HnflBDhOI5wnADCoDvejd7JGnjWauGgViJd1VISDWMNCrqOmpYCtJbtvhTW1X112UvFRIDH
	IUFjExWPxJmjAjDLyZufy6StfWGRHQ/c55r2xMsx7CVnI98QeBRVpFi1SR4oL5zno1zRGMB
	Ew9kdkzRgq5hxTX8z5c9yMw9tq+Y96AQ8vptIyjJ0TyR5oyZYnKlMe284FBzP87u6B5tHOO
	bNkR2qwzjq8iPzZLDgOEXYGZYyFcD83kEOPI48V0k1xT7f2OxQGSFRpJqFB0rwXbx8Uflq7
	wqTgEPMjqDiJwscdfCNOhywrWUMFIr03rh50OrrL87yA7vFUVXCv0frBccqzWj/MD0WzD4d
	irfjkvCf0Qaa94xW1dCGvBtdZivnCb46+StSQ2z8/GLdbTy7JOIzMBoYTDy7H1yb29y+lLE
	H5lwIlGroUze9wnv8/W2qKY9FtNR1awoT2PyYTQkYf6TaMi2CWzvMCZ04FuBwWfKpcrrolm
	6aaX9YY9ZiQ/hBauJGmsVNAPqL0LE5Bk5lWA1lnJuVjCY5zf3JbtrbOE8yzPKINJMQpnFa+
	46jxWmRlloqZDx3D7RsGtyk86P30Y8h5M5sfELWZ2W2Ia/XQkDU8Ta2PlOUi03DKSlP3tZP
	BUHVyZwkNHROs+bQl7j5mFBWrIOUheiDxrwWsXRePh8Fz3azYCw/aL/Gk40jSbzzN7OOcnQ
	c706L44STa/ekM5nxAj5NizztNqymkwVcK/SKW5UAAoHukk2L+hch0+oWWnNWLzc2km6uEP
	WMzzMMmhKU8NKSmvqlNTIClB+rcowj3Cs9V/wO0WxGyQUsmP4iyW6N8ODq/dHErKdgyx/RR
	A==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Fri, Jun 20, 2025 at 5:41=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 6/19/25 13:00, John Hubbard wrote:
> > On 6/19/25 10:00 AM, Shuah Khan wrote:
> >> On 6/19/25 01:46, Chen Linxuan wrote:
> >>> On Thu, Jun 19, 2025 at 5:23=E2=80=AFAM Shuah Khan <skhan@linuxfounda=
tion.org> wrote:
> >>>> On 6/9/25 20:07, Chen Linxuan wrote:
> > ...
> >>>>> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount=
- notify_test.c b/tools/testing/selftests/filesystems/mount-notify/ mount-n=
otify_test.c
> >>>>> index 63ce708d93ed0..34afe27b7978f 100644
> >>>>> --- a/tools/testing/selftests/filesystems/mount-notify/mount- notif=
y_test.c
> >>>>> +++ b/tools/testing/selftests/filesystems/mount-notify/mount- notif=
y_test.c
> >>>>> @@ -465,7 +465,9 @@ TEST_F(fanotify, rmdir)
> >>>>>        ASSERT_GE(ret, 0);
> >>>>>
> >>>>>        if (ret =3D=3D 0) {
> >>>>> -             chdir("/");
> >>>>> +             // Suppress -Wunused-result
> >>>>> +             // Ref: https://gcc.gnu.org/bugzilla/show_bug.cgi? id=
=3D66425#c34
> >>>>> +             (void) !chdir("/");
> >
> > This is quite ugly. :)

I agree with you. :)

> >
> >>>>>> Why not fix the problem the right way by checking the return value=
.
> >>>> Suppressing the error isn't useful.
> >>>
> >>> The code is already handling cleanup in error cases,
> >>> and I don't think checking the result of chdir would be useful here.

I think I was mistaken earlier. Here we are in the child process after
a fork, not handling an error case.
I think simply calling exit(-1) here when chdir failed should be
enough to make the test fail in the parent process.
Maybe we should do the same for other similar calls as well. I will
send a v2 soon.

> >>
> >
> > Why not just fail with the appropriate test result, if chdir() fails
> > here, instead of making a bit of a mess with odd void casts to a
> > negated return value, and a reference to a compiler bug report?
> >
> > Really, Shuah is putting you on the right path here.
>
> Ha. I didn't ask to suppress the error with the cast. I asked
> to check the return and fail.
>
> >
> >> We check for chdir() in several tools in the kernel. Add a check for
> >> it instead of suppressing the [-Wunused-result] - suppressing doesn't
> >> do any good.
>
> This is what I said.
>
> thanks,
> -- Shuah
>
>

