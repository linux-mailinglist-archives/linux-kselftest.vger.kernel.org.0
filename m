Return-Path: <linux-kselftest+bounces-35396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4128EAE112B
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 04:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76E019E2DFA
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 02:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115F71B4132;
	Fri, 20 Jun 2025 02:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="CunWgZUI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549611AD3E0;
	Fri, 20 Jun 2025 02:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750387257; cv=none; b=h5+L8rSrgPBXl+o6hwfgjHPfdDM2pEq4eKq4EMbm3Kk7Zbq/YTp3rZT2g03qTfr2xc+o6Ojm/ZpTWL3m2ml9PBfe2SbK2xo4fwWhlDCvUw74ZsEA3vHdcro/xmstASR4CjAM+xrxdVtmulWtQhMT7omwfjX4A79qi/Y6H8eyQWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750387257; c=relaxed/simple;
	bh=EjqxtfKeYd5SZGfAnOKcEh4LXL2axs1uONwF3fVUNPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=maeKCsKugFBhmxG/EM+dE6gaSzJ1lraOsl9mNYBtvvbldISMjrt/WLUPBdenP3e8uPS+7QrJNhuoryNUHBY1gHg6xr3JfPGAEHG15k+n7OqGyLOYBSoGoXT0JhV+mKNALG0cOC/dJMhFiFd5vfU0y6VWRotIZw753eqVlQZS+Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=CunWgZUI; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1750387237;
	bh=EjqxtfKeYd5SZGfAnOKcEh4LXL2axs1uONwF3fVUNPI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=CunWgZUI3xVZQ247hRVJX5TLG1E493ycX8obkbtm0ODj2JURZ0TzFXtBATnWv9ToY
	 Z0Bs4WN7Oqd+cgTDjnreQy2yfxwKW126BR3djD6d9JKpSQWWv9sG5Jv7h6bnswymeW
	 6NuDwArqoYfuQcj7p5JOnbgyK4uK0TUaoeWSrL7M=
X-QQ-mid: zesmtpgz4t1750387232t27f5bb78
X-QQ-Originating-IP: mdMWF8Xl6ldCYAWmmQYeYsh8Z0cs4iFsgmm+UPFPKcc=
Received: from mail-yw1-f181.google.com ( [209.85.128.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 20 Jun 2025 10:40:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7853770561198746144
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-711756ae8c9so12026447b3.3;
        Thu, 19 Jun 2025 19:40:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2wBznbzDJp6Ez9rfjPSyOh/UVb6JxI0DQ05Xiy4u6YRGm8Lx75viZt4ECK9szF0Jozd2xqtsgS++anb0=@vger.kernel.org, AJvYcCXDN0P3wSWseFdToSx/lpEE1an2BqRKwKTgQd+72Hw1ROkE0mOZDwfPn7pOjEoh0bgfy1OPllOEoIsr1XvL4NOQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe12OVaAWjoNFV6OkMxEaCZyvojNRVvILNrDZXY9xHQAAbW83N
	oilYETr57xxmRblv3H6tBTBuNXUaAc6+bzIT+huasW8KirlirgXFlHbf3CbHljaSIAuckl5dVvE
	s8cMSincYlzo9H0p3d91YocQYJh9nz/o=
X-Google-Smtp-Source: AGHT+IFbTgwgGgJxxllMeEw6zB6uF0hIP8cZmN1Y7cnNjlzc6gnOH8Ib33yko2jpn/O3NR7wu4m5wOXVrnKEyVsTBYM=
X-Received: by 2002:a05:690c:7345:b0:70e:18c0:dab6 with SMTP id
 00721157ae682-712c64fc8fdmr19315007b3.23.1750387230026; Thu, 19 Jun 2025
 19:40:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610020559.2797938-2-chenlinxuan@uniontech.com>
 <96c46d3d-0e0a-464a-b64c-15c2a544a974@linuxfoundation.org>
 <CAC1kPDM76fLgE-cbKvMO3=B1hKhjTNMYmJw5XpOPV5UAxXx=Yg@mail.gmail.com> <72998015-c571-437b-a77a-1c49a2787fc7@linuxfoundation.org>
In-Reply-To: <72998015-c571-437b-a77a-1c49a2787fc7@linuxfoundation.org>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Fri, 20 Jun 2025 10:40:18 +0800
X-Gmail-Original-Message-ID: <C5E9BCF84096B471+CAC1kPDM5bbWZGZucqSS46NDZO_br6ypcrUNjXck5-CMNzJU34g@mail.gmail.com>
X-Gm-Features: AX0GCFsTMtegNom_H642drEglCCzL3lW0k2032zGkZROuysBhL05UbzE3GIY2WM
Message-ID: <CAC1kPDM5bbWZGZucqSS46NDZO_br6ypcrUNjXck5-CMNzJU34g@mail.gmail.com>
Subject: Re: [PATCH RESEND] selftests/memfd: clean Makefile
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, Shuah Khan <shuah@kernel.org>, zhanjun@uniontech.com, 
	niecheng1@uniontech.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OCnNLGxuhE2oxhzBHU6PDJmnJbZidvOg8r79SFy2Ski5zzol3wSCdQRs
	42D3nDelHMTMZcoPWkJ2S+xplLN+DbALrdXtMS4d+3Ea8Sb+Wq8GIuuxlEsfoLb96ljZIjk
	8ER3bwTYjde/wsSCghe+TSUL01RqgV5XLEB8pwgBHMUBE6TwLXic60mpTCkXppKlFY8RjJ+
	pLaD/H81oZm41ofLxxj6GePfAoWCZ9UTwuMu1seIJ1uLXHOKItvM8cBrBGi1Cm/DwAPLrNH
	xpHIAr1SnDpAs67Dhw4Ax1x4ailTd85JvlD5CjWX2SlZoxz80hENSgb6Fu729YYHX3yneaH
	v11oW0VMdbt28QW5OqU6AJKQple+lB6L7774YgqnLv6sey9FeVqoylCs6UA9rCjYbwTjxlI
	TR8jEn176FcoA2eNawlNd2ew5Ole8ZfT4swNBh80LJVEwMFnJForNy7I+FQqE9Kcn0PlWgQ
	CyMLHCFd0xoJqTbWud4jFmuiWbMMK9jBE/XpvrE8AP6qkb732fi18JOfcJf7jvylWw2cHFV
	Tpiw4K1/hwAjVXS3VUd4ticsr7fbpGEv2oa4uepJrIXmt5tPNfRLcc7ukqtU6SxMpgNSO6L
	g6Lg5Pa4XzK9cP9xHqKsmdAPdZ9f/GVFW8Zp0fbL8spvIQWCDc44jIiLqrdE9w9V2HrSkxX
	kDcckYXCuQFSZ1AvVAphxdHZiQ3JfeNX7Q5F4pW57c71h9cTfkeaxV59ZW2PEmwHUnfO+lW
	YDWJ6tyvetQSc8d9y9pedl5OUHT2nqP04jb0OEE1zdsNtrXnLZjZOB1EdqylNoxBoyqGCBs
	zbIGxLGiM2Fh/rpF0MZ4AY80Zlr8xBoNc6ufrfexF4YTWqash2y0zcXKY/nIR2/l4CSUdOe
	usYE/2LFwdkxP1HeOIerD8/bzhp9FW9rqumW3q1IxnDXLb9dQE+cWgay0V3k0RlvbNrmB47
	TNSiYindwoFXGApGE3v44WgEAp2WkkXSfkUecy6BH96JHa8y9ndD2wWzfbrMElYxPsYZ8jS
	e+aXWz3+Z8Mn5oggbL8ekf2cyklaP40geuW79AKyWhzBZLWhLF3xmbdF1MmJGIP7SXHdoXz
	nV3NsAWwB6e
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Fri, Jun 20, 2025 at 1:02=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 6/19/25 01:43, Chen Linxuan wrote:
> > On Thu, Jun 19, 2025 at 5:21=E2=80=AFAM Shuah Khan <skhan@linuxfoundati=
on.org> wrote:
> >>
> >> On 6/9/25 20:05, Chen Linxuan wrote:
> >>> When writing a test for fusectl, I referred to this Makefile as a
> >>> reference for creating a FUSE daemon in the selftests.
> >>> While doing so, I noticed that there is a minor issue in the Makefile=
.
> >>
> >> What happens if this change isn't made?
> >
> > Nothing will happen.
> > When I was writing tests for the fusectl filesystem in the kernel repos=
itory,
> > I came across this file as a reference.
> > Then I found that the process of passing CFLAGS was not correct.
> > So, for the reason of not wanting others to be misled again,
> > I want to update the compilation process here.
> >
>
> If there is no obvious reason then let's not make this change.

Once https://lore.kernel.org/all/20250612094033.2538122-2-chenlinxuan@union=
tech.com/
gets merged,
there will be another example of compiling fuse in selftests in the kernel.
So I think it's not a big problem if we don't make this change here.

thanks,
Chen Linxuan

>
> thanks,
> -- Shuah
>
>

