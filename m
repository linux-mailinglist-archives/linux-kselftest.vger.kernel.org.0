Return-Path: <linux-kselftest+bounces-35343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48671ADFEFE
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 09:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78BF87A5818
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 07:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964BD25A34D;
	Thu, 19 Jun 2025 07:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="btFDrMc8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7912D25F7BC;
	Thu, 19 Jun 2025 07:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750319046; cv=none; b=AU3o5d44Ejpz2AYVtQzsQMN0cSUbbjb4Ao3SkA/83PGYHGMt7tQsGSEkih0yKuCvdUfN2FLQtb/sVNK51NKCsTJN8fhyZo5WKndxAWXd8iJbLhKzFWzPrso2HWSHZM79g3tjcWtIdaZJTYw0pc/AUjVQ5sxRHvWc0Yx5rQ0bo9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750319046; c=relaxed/simple;
	bh=6Z0HZsFZmuTX/vuM6Vx8E4uacrew6L+K8YIi+PZnOhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEot8SEt/T41c9D/QyWn1A26jNlHbFjTMsIcyYRrWhwVkpCZtml040ujDg/LtI5JFJaOdTRKFlXu3sWpfk9p2BN6DbGrYNMub3Yg5nQ3nOj7lsSXk47sOiGCveTC6A3azsaSie7qrhluh6+kBCZH10c53yI/0dPuD6ncaewlmp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=btFDrMc8; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1750319031;
	bh=PdAJ7XW6WFKbkSbzeFGLxHXUKKVLvlM5q8OEKyJ+9Mc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=btFDrMc8oOCY5dvGklrrFA65i3VaE2AxuiOD2uXrT/dgvj7kpP7nC1fwD2Bp4V7YO
	 E5KkbhyUhK3k3S0dbiYQNKBaiKQFI5jpsJP/JCBIKf5I8chi76Dnm1Wz6SgWgyxpA4
	 SfTk7rmPbodbwzfcuvFjFX8nSNUPBr0/cnh6GBAA=
X-QQ-mid: esmtpsz16t1750319026t495c5fb0
X-QQ-Originating-IP: 3DbXRB9nhPXMTuvRtUZcwtO9Yq6Kft7ecjQRD63hONg=
Received: from mail-yb1-f177.google.com ( [209.85.219.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 19 Jun 2025 15:43:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2888044492780007741
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e7569ccf04cso472171276.0;
        Thu, 19 Jun 2025 00:43:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVaHhm5HJkhWdozHr1t41q+D7yn89NhYkSugyo2tGGk4Jut8VtbhhwlFXKHB1VnBQX0JFsQwe/40vX+DRY=@vger.kernel.org, AJvYcCXpWgG1LQtNVf/tPEr/m98XP7qX08I4RoL7gz0BTlDZb0C5nhKtLjV8KbC2SMcIfOLrcgzTHWGw5uhUOGEEqPfd@vger.kernel.org
X-Gm-Message-State: AOJu0YzKjjwRPts1unODRhqmWWRCd0urc+Moq8E7z6UEgms/zo7rFpZQ
	vm+fGIAFM7ygpZyN/4klso9q/eH8JMDW9SrdWUFjmonwULwkiV5f/pXe471b4XeM9JOZeK3rgk/
	b4EDactzvFh/43pprS06Cafby6fogkrE=
X-Google-Smtp-Source: AGHT+IEfZub8gy2jnZbdLcKSkmLr1O4BmFMGk4pDPzXq1+akqLOXYE5F3PLiilZoY4rSCiykRKOzABKYqNAY4dc03Pw=
X-Received: by 2002:a05:690c:4d4a:b0:70e:2d77:3cfe with SMTP id
 00721157ae682-71175382ebbmr318625957b3.2.1750319022448; Thu, 19 Jun 2025
 00:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610020559.2797938-2-chenlinxuan@uniontech.com> <96c46d3d-0e0a-464a-b64c-15c2a544a974@linuxfoundation.org>
In-Reply-To: <96c46d3d-0e0a-464a-b64c-15c2a544a974@linuxfoundation.org>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Thu, 19 Jun 2025 15:43:31 +0800
X-Gmail-Original-Message-ID: <E331E4A1E44CA282+CAC1kPDM76fLgE-cbKvMO3=B1hKhjTNMYmJw5XpOPV5UAxXx=Yg@mail.gmail.com>
X-Gm-Features: AX0GCFsPEvPn4k_4SEuYgTBSBqxc9xBq4ybEKn9PA6xW3y3kIBv7aDr_GYIcAlE
Message-ID: <CAC1kPDM76fLgE-cbKvMO3=B1hKhjTNMYmJw5XpOPV5UAxXx=Yg@mail.gmail.com>
Subject: Re: [PATCH RESEND] selftests/memfd: clean Makefile
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, Shuah Khan <shuah@kernel.org>, zhanjun@uniontech.com, 
	niecheng1@uniontech.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: M6ncIRVC3gAvOz1VEvZL4HgEyipj2jBAZ+wY92nuPRvBcbZA8XyDafdq
	NCM7BSPIebI35DEYYfCu034zUgUH5ljCd7WZYLElfV3wsg7mPVfW7lSJJZqCisNh0QnFS8M
	dfcHgbFokCVJOApzffm+4S1fPo4Qw8wvkeJvwG8nDpZbTznf8AVlMAtEHJsNskr8BHIkYwc
	pViwLiMTWj6JAIbxz9zTO4ZjHOLPOZOueHclb3f/jz+VNHIskqcdUx5b2bF/YzaB3geEuHD
	LzowtuKJ245iAg8xReHT9odF4+Pp1NFOY4OVwbPndh18dhsPVXBPkx5xJufiELnF4NN8MPF
	uaBbdsoSWOVAQCL7OdZM6VuDTLvXp7x1z345lZBEbMLlduKbGFpvQRyFp55iPUd6HSR4hun
	wQEMkeImwSSUudK1DmKaZM2qAfg6Nt5MtrCpOyatMEZ54iAp7t/kNM0m7takt2NeeIniAkZ
	43hl6Z+5gcpbC8hFPPe0TKs3uXLT45bUazhW1zoQR3WL1pR3Vjsg3dzzoz+bOciFV4FRcIp
	0NMf6w6VAXgAg4s63iWDEGxlUjwTr8DC2+b8/Va3kVZZOEgkbQ/mWW1le/Law/COhQv9nvi
	goOa2RKDUbU6bro0GDxVu1tOPopEYY+YU3LzYEL48wKGs/HThvCvwk47/ysRp1ImfkApgld
	Q7fkDpGiNnYhhO+ULza73IyEpbm/nh5Vo38uHICgmmFgxQXuNrsAWLSNSqcKjsdnNxzSVhE
	6J/2RWnnbvdhue1JXS4Yt6U8GPYemWzk8XHULpfpNjaB9PMBEoweFZobQT0LIHZGumsveq8
	E06LRurW5DQxdd//tyNo07cBNP3VQ5u0wzZvDb1ou202TiqvE29UuaQORNnPUdkADQLbsOG
	Bf90LZreWJopTGyigqQ4iewjT99xwoCQFC/8YPsSVICvX3cFaMztR4taN5nzBt6TRutODrB
	EE+w1zZNXtTWxCW2EHf5y5ZPXsHMi7yVL1BAYNvWfdlxUYCkCpzu3cwOXWYhgWJ5hxfn96V
	UA8rbJJS3a7iKpICouHusrZ92Aj0urj5jvp7xVYhYWKzwvyG1VmISj4QAQu6xHGVgr79miI
	/jn6BWQvCCjGIeTSgBnVWuB09THI//8Sg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Thu, Jun 19, 2025 at 5:21=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 6/9/25 20:05, Chen Linxuan wrote:
> > When writing a test for fusectl, I referred to this Makefile as a
> > reference for creating a FUSE daemon in the selftests.
> > While doing so, I noticed that there is a minor issue in the Makefile.
>
> What happens if this change isn't made?

Nothing will happen.
When I was writing tests for the fusectl filesystem in the kernel repositor=
y,
I came across this file as a reference.
Then I found that the process of passing CFLAGS was not correct.
So, for the reason of not wanting others to be misled again,
I want to update the compilation process here.

>
> >
> > The fuse_mnt.c file is not actually compiled into fuse_mnt.o,
> > and the code setting CFLAGS for it never takes effect.
> > The reason fuse_mnt compiles successfully is because CFLAGS is set
> > at the very beginning of the file.
> >
> > Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> > ---
> >   tools/testing/selftests/memfd/Makefile | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/sel=
ftests/memfd/Makefile
> > index 163b6f68631c4..e9b886c65153d 100644
> > --- a/tools/testing/selftests/memfd/Makefile
> > +++ b/tools/testing/selftests/memfd/Makefile
> > @@ -1,5 +1,4 @@
> >   # SPDX-License-Identifier: GPL-2.0
> > -CFLAGS +=3D -D_FILE_OFFSET_BITS=3D64
>
> What's the reason for deleting the above?

The CFLAGS update here actually doesn't take effect.
I believe it is the -D_FILE_OFFSET_BITS=3D64 in VAR_CFLAGS that truly
takes effect.

>
> >   CFLAGS +=3D $(KHDR_INCLUDES)
> >
> >   TEST_GEN_PROGS :=3D memfd_test
> > @@ -16,10 +15,9 @@ ifeq ($(VAR_LDLIBS),)
> >   VAR_LDLIBS :=3D -lfuse -pthread
> >   endif
> >
> > -fuse_mnt.o: CFLAGS +=3D $(VAR_CFLAGS)
> > -
> >   include ../lib.mk
> >
> > +$(OUTPUT)/fuse_mnt: CFLAGS +=3D $(VAR_CFLAGS)
> >   $(OUTPUT)/fuse_mnt: LDLIBS +=3D $(VAR_LDLIBS)
> >
> >   $(OUTPUT)/memfd_test: memfd_test.c common.c
>
> thanks,
> -- Shuah
>
>
>

