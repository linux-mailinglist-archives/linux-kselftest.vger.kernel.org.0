Return-Path: <linux-kselftest+bounces-45582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D7FC59E3F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 21:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03BD1355CAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 20:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A542A3176E6;
	Thu, 13 Nov 2025 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="iu3ho0Ep"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862892EA490
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 20:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064010; cv=none; b=KuFvddgp547KmefS/1K5shPkirQUxjPYYypl0dKUGHBA1CmdsdTjx06muDossGxOjhK7GslE5C5471e7OG0REB2cqEn8hSOKHfbYcAz7r4Xk7qQRkC+Z7UNdC2jVCPdUE6xZvwKjBiRQBokHaufp/Kgjhm35pIGEcom0HcSJTzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064010; c=relaxed/simple;
	bh=ubcfM/vdnmF3Fn8WQauxBdSJk3P5U3zcUAEWBR4yO74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGFo/7F6oJw+Lxu3LuLKPFjFlQix7R0Dgh9Xmzi7diKAelYdCWnUbsXHeLJY1n2u2Vy4PfeqZVMX+Cxk1NeE/xc8TpIkJPKYJxstC5yKGD5R/DMRUBTU/h+kCaIPvjPbJNmPeS9TDf7wxHmUZGEPHKPrFO8EYXwJTp6OP782nEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=iu3ho0Ep; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso2131831a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 12:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763064007; x=1763668807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8UPfICDEEgZp4uB+X0RyA3ytCQQbxJjsb+km2/EZ0I=;
        b=iu3ho0Epcl2dtQI5ZoF/RgFqtOtRsg4o9Ai5xrltGc/6xXhWUoOENoEGo5vDzbUEBf
         Yjvk7/dklFvZ4i6zHwieKcNBGvRJRVcdEFuVUE9WtMnYcYKlftsSTtQvFEYfJ5m/LDjX
         i4Dq2pfPTwt1lPO/q3Kxho4V6nuOUDEYD/rz0eq77wZob81zeMdLdTtE6EKmpSehWd2F
         DyzXv9AQE/WLTkNNHIF2D/SAgnIP4xAmn3utSnUX/bJxMzzhCXJ9DwnDj3AJeuadX5q4
         zPL2hAYxEf34fsbuThvXgDS3EGPEDWzQXykykWWq3d1kOABCy85otmPHGXfoXXeuLQHi
         VYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763064007; x=1763668807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y8UPfICDEEgZp4uB+X0RyA3ytCQQbxJjsb+km2/EZ0I=;
        b=OaDWOeGN6hGXTl8jtG31U1zm7Y3PgCyvQM4yYOllgN7h+Xee0YrcHf1zAuedlsg71u
         SpOqB5sxrdbASZlXkqHWO4FJh2YJgp2mjqiLIJp+7kn+3VYo9ksnHf7JAXpn/JfM3Rve
         WSnuosTFz7gcthl5mVcbAgai1fJHDlPuPHbxcZiZACJXIwHBzrN1dKYDbUXcdO8xAKuV
         s6glwGU8afg4sofEvlu2enyL+liqEAIn6g7rGe7BMx2LBGfspcEZTtiyHocIhMUay+uy
         GSwdzxo2x1zdiKm0KsECtDmw3ejNC67VvtU9b2xK4vxPQgo7QSJg3rR0luImJV5/o6i6
         LKGg==
X-Forwarded-Encrypted: i=1; AJvYcCV5jXCmSkf82zsagbhXyOUJ3BDUyZefpSxknyUbksoILwRuEqRBBYhqA7YY7JqDtNOPgz/HxbWJD080GDTHnXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS3f1y9pNruH3/KpXZLjztTTNLEDGTXpbUX2jOitSsRIJLBSlh
	M5JEWjbh5fX74kKgPpA8LEIsqfDF5tCWa6ngTRIOCTdq4q+SWL2dp/4QzNZ4B0mu3LseaAhwpyb
	wZrMT2j54czTBB6g0DRpOasXqy7kceOwC+T5KwuTO6A==
X-Gm-Gg: ASbGncuTqqgNyGD4NfYmBysugWSrBxBwgbRx7SUoRN5J0C7ZzfG8sH4Ev2EmubTM+8d
	7UwO6DQTuD70tRwoXdQlJ4h3mAxHoVGRx2hMD3f/Tn6WqQkFSETdOC6qXm4e5vIOJhyGA4jHclj
	IVzVBmko5kpRgK3g7RWryJyYYiRRkwdm9KJCV9I8hnTbNEWe+g5lBDXHk/dRcF2FCn1waTOeR5H
	TWx/F8m2rlWDkfjU2WNgCABFhMzUG70M8QEr4EW7f4xjjok6JXBN49Pbw==
X-Google-Smtp-Source: AGHT+IGtgb5lqtXrRSejuSHsDHqiIlxt1wqIGMSt45RvvTjAlTo2PtIgEUYmRcunbv8MILvS8OFEKnjDlBfvJk22ITE=
X-Received: by 2002:a05:6402:144d:b0:63c:533f:4b25 with SMTP id
 4fb4d7f45d1cf-64350e2091cmr477401a12.15.1763064006737; Thu, 13 Nov 2025
 12:00:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
 <20251101142325.1326536-2-pasha.tatashin@soleen.com> <d7651272-f979-4972-ae41-bab2faa8473a@linux.dev>
 <CA+CK2bDSvtuwrrXGOC07Rj42yGFHWR4Sse7Q5z1z8f1ZFHWQ2Q@mail.gmail.com>
 <CA+CK2bC_+repP-q183hjAuYYB2-Yx7fr_U3zr2cxysAWx5hzpg@mail.gmail.com>
 <029090cf-9a4d-4f79-b857-04c3ada83323@linux.dev> <CA+CK2bByYPJXSNOh6R3swqFrGsS02m3Dfh=ZU7YhNjNX6siyqg@mail.gmail.com>
 <442fa82e-16ef-4bde-84eb-743450222468@linux.dev> <mafs0qzu69gei.fsf@kernel.org>
 <CA+CK2bBEe16x0em1gRxQD3jhfV9t3QA2vx5ifk2pKb_WEoMTeg@mail.gmail.com>
 <0735e1ef-2b65-4a54-b4d5-964fb875cd09@linux.dev> <CA+CK2bBnnGyQ-N8-XS3W3tnSRwvFbstOdo0oDSdkF70KP1AVxw@mail.gmail.com>
 <475ed48d-1f62-4983-94a1-64e41c463c36@linux.dev> <a1aa7736-d014-477f-a516-2281a70fc8c1@linux.dev>
In-Reply-To: <a1aa7736-d014-477f-a516-2281a70fc8c1@linux.dev>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 13 Nov 2025 14:59:29 -0500
X-Gm-Features: AWmQ_bnRlxMOTpjJYa9c1wkJd45YYnIOQytdlbCIfP7YmJM_Ee4y6ZWF-j5IBYQ
Message-ID: <CA+CK2bCwqCHr6oecmL6R65qjgXZNuzU7SJ9diVkYX442tUdU+Q@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] kho: make debugfs interface optional
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: Pratyush Yadav <pratyush@kernel.org>, akpm@linux-foundation.org, brauner@kernel.org, 
	corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 9:11=E2=80=AFPM Yanjun.Zhu <yanjun.zhu@linux.dev> w=
rote:
>
>
> On 11/12/25 5:41 PM, Yanjun.Zhu wrote:
> >
> > On 11/11/25 7:26 AM, Pasha Tatashin wrote:
> >> On Mon, Nov 10, 2025 at 11:11=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.=
dev>
> >> wrote:
> >>> In FC42, when I run "./luo_multi_session"
> >>>
> >>> # ./luo_multi_session
> >>> # [STAGE 1] Starting pre-kexec setup for multi-session test...
> >>> # [STAGE 1] Creating state file for next stage (2)...
> >>> # [STAGE 1] Creating empty sessions 'multi-test-empty-1' and
> >>> 'multi-test-empty-2'...
> >>> # [STAGE 1] Creating session 'multi-test-files-1' with one memfd...
> >>> # [STAGE 1] Creating session 'multi-test-files-2' with two memfds...
> >>> # [STAGE 1] Executing kexec...
> >>>
> >>> Then the system hang. And via virt-viewer, a calltrace will appear.
> >> Looks like mountroot fails, are you passing the same kernel parameters
> >> as the during cold boot?
> >> i.e. kexec -l -s --reuse-cmdline --initrd=3D[initramfs] [kernel]
> >
> >
> > Thanks a lot. It can work now.  The logs are as below:
> >
> > "
> >
> > # [STAGE 2] Starting post-kexec verification...
> > # [STAGE 2] Retrieving all sessions...
> > # [STAGE 2] Verifying contents of session 'multi-test-files-1'...
> > # [STAGE 2] Verifying contents of session 'multi-test-files-2'...
> > # [STAGE 2] Test data verified successfully.
> > # [STAGE 2] Finalizing all test sessions...
> > # [STAGE 2] Finalizing state session...
> > #
> > --- MULTI-SESSION KEXEC TEST PASSED ---
> > "
> >
> > Yanjun.Zhu
>
>
> Hi, Pasha
>
> In my tests, I found that luo_kexec_simple and luo_multi_session
> currently depend on the glibc-static library.
> If this library is not installed, build errors occur.
> By making the following changes, luo_kexec_simple and luo_multi_session
> would no longer depend on glibc-static, reducing external library
> dependencies.
> I am not sure whether you agree with these proposed changes.
>
> diff --git a/tools/testing/selftests/liveupdate/Makefile
> b/tools/testing/selftests/liveupdate/Makefile
> index 6ee6efeec62d..b226b9976150 100644
> --- a/tools/testing/selftests/liveupdate/Makefile
> +++ b/tools/testing/selftests/liveupdate/Makefile
> @@ -3,7 +3,6 @@
>   KHDR_INCLUDES ?=3D -I../../../../usr/include
>   CFLAGS +=3D -Wall -O2 -Wno-unused-function
>   CFLAGS +=3D $(KHDR_INCLUDES)
> -LDFLAGS +=3D -static

Hi Yanjun,

Thank you for testing. I prefer to keep the '-static' flag because
these self-test files are not executed in the same environment where
they are compiled but in a VM which might have a different userspace.

Thank you,
Pasha

>   OUTPUT ?=3D .
>
>   # --- Test Configuration (Edit this section when adding new tests) ---
>
> Yanjun.Zhu
>
> >
> >
> >>
> >> Pasha
> >>
> >>> The call trace is in the attachment.
> >>>
> >>> Yanjun.Zhu
> >>>
> >>> =E5=9C=A8 2025/11/10 7:26, Pasha Tatashin =E5=86=99=E9=81=93:
> >>>> On Mon, Nov 10, 2025 at 8:16=E2=80=AFAM Pratyush Yadav
> >>>> <pratyush@kernel.org> wrote:
> >>>>> On Sun, Nov 09 2025, Zhu Yanjun wrote:
> >>>>>
> >>>>>> =E5=9C=A8 2025/11/8 10:13, Pasha Tatashin =E5=86=99=E9=81=93:
> >>>>>>> On Fri, Nov 7, 2025 at 6:36=E2=80=AFPM Yanjun.Zhu <yanjun.zhu@lin=
ux.dev>
> >>>>>>> wrote:
> >>>>>>>> On 11/7/25 4:02 AM, Pasha Tatashin wrote:
> >>>>>>>>> On Fri, Nov 7, 2025 at 7:00=E2=80=AFAM Pasha Tatashin
> >>>>>>>>> <pasha.tatashin@soleen.com> wrote:
> >>>>>>>>>>> Hi, Pasha
> >>>>>>>>>>>
> >>>>>>>>>>> In our previous discussion, we talked about counting the
> >>>>>>>>>>> number of times
> >>>>>>>>>>> the kernel is rebooted via kexec. At that time, you
> >>>>>>>>>>> suggested adding a
> >>>>>>>>>>> variable in debugfs to keep track of this count.
> >>>>>>>>>>> However, since debugfs is now optional, where would be an
> >>>>>>>>>>> appropriate
> >>>>>>>>>>> place to store this variable?
> >>>>>>>>>> It is an optional config and can still be enabled if the live
> >>>>>>>>>> update
> >>>>>>>>>> reboot number value needs to be accessed through debugfs.
> >>>>>>>>>> However,
> >>>>>>>>>> given that debugfs does not guarantee a stable interface,
> >>>>>>>>>> tooling
> >>>>>>>>>> should not be built to require these interfaces.
> >>>>>>>>>>
> >>>>>>>>>> In the WIP LUO [1] I have, I pr_info() the live update number
> >>>>>>>>>> during
> >>>>>>>>>> boot and also store it in the incoming LUO FDT tree, which
> >>>>>>>>>> can also be
> >>>>>>>>>> accessed through this optional debugfs interface.
> >>>>>>>>>>
> >>>>>>>>>> The pr_info message appears like this during boot:
> >>>>>>>>>> [    0.000000] luo: Retrieved live update data, liveupdate
> >>>>>>>>>> number: 17
> >>>>>>>>>>
> >>>>>>>>>> Pasha
> >>>>>>>>> Forgot to add link to WIP LUOv5:
> >>>>>>>>> [1] https://github.com/soleen/linux/tree/luo/v5rc04
> >>>>>>>> Thanks a lot. I=E2=80=99ve carefully read this commit:
> >>>>>>>> https://github.com/soleen/linux/commit/60205b9a95c319dc9965f1193=
03a1d83f0ff08fa.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> To be honest, I=E2=80=99d like to run some tests with who/luo,
> >>>>>>>> including the
> >>>>>>>> selftest for kho/luo. Could you please share the steps with me?
> >>>>>>>>
> >>>>>>>> If the testing steps have already been documented somewhere,
> >>>>>>>> could you
> >>>>>>>> please share the link?
> >>>>>>> Currently the test performs in-kernel tests for FLB data, it
> >>>>>>> creates a
> >>>>>>> number of FLB for every registered LUO file-handler, which at the
> >>>>>>> moment is only memfd.
> >>>>>>>
> >>>>>>> It works together with any of the kexec based live update tests. =
In
> >>>>>>> v5, I introduce two tests:
> >>>>>>> luo_kexec_simple
> >>>>>>> luo_multi_session
> >>>>>>>
> >>>>>>> For example, with luo_multi_session:
> >>>>>> Hi, Pasha
> >>>>>>
> >>>>>> I enabled "CONFIG_LIVEUPDATE=3Dy"
> >>>>>>
> >>>>>> # ./luo_multi_session
> >>>>>> 1..0 # SKIP Failed to open /dev/liveupdate. Is the luo module
> >>>>>> loaded?
> >>>>>>
> >>>>>> # ls /dev/liveupdate
> >>>>>> ls: cannot access '/dev/liveupdate': No such file or directory
> >>>>>>
> >>>>>> # grep "LIVEUPDATE" -inrHI /boot/config-`uname -r`
> >>>>>> /boot/config-next-20251107-luo+:349:CONFIG_LIVEUPDATE=3Dy
> >>>>>> /boot/config-next-20251107-luo+:11985:CONFIG_LIVEUPDATE_TEST=3Dy
> >>>>>>
> >>>>>> I made tests on FC42. But /dev/liveupdate is missing.
> >>>>> You need to add liveupdate=3D1 to your kernel cmdline to enable LUO=
 and
> >>>>> get /dev/liveupdate.
> >>>> +1, kernel parameters require: kho=3D1 liveupdate=3D1
> >>>>
> >>>>> Pasha, your LUO series doesn't add the liveupdate parameter to
> >>>>> kernel-parameters.txt. I think it should be done in the next
> >>>>> version to
> >>>>> this parameter is discoverable.
> >>>> Yeah, that is missing, I will update that in a standalone patch, or =
in
> >>>> a next version.
> >>>>
> >>>> Thanks,
> >>>> Pasha
> >>> --
> >>> Best Regards,
> >>> Yanjun.Zhu

