Return-Path: <linux-kselftest+bounces-35342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72000ADFECB
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 09:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E11189A229
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 07:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA46258CC8;
	Thu, 19 Jun 2025 07:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="O0r7lF7E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9E31624FE;
	Thu, 19 Jun 2025 07:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750318442; cv=none; b=KACeU1OHgVXKM9YcqSaWXsspQ/115rfOkHddv0vVejwQqb1JzPs3S7KK2f3EfuNfhZnPhszeK+k1RmODeAI0l/ZbwFSegKre45BfiIVZZqrRhS6DTTBD47MKs3DTvSLyzmqj5eaR6dln5SYYmWZrrvMOGZNUVyZpnpQvs0F5QXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750318442; c=relaxed/simple;
	bh=GfGhA+9BgJLWdxEEyGYLEPTOg6xOavspybJre2KB3mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uoFmytat6Z4CQrUnJvPTnCbkjEsQ7i809wubV/Wys/uOKFpCYEfsZ9XsN6nbG8asUO5RMi74vHi+bSfbFx4EeWj71AesTgbv89eFsA2esrByOpMZh9WUiquXFlDIZafkJEbxs9c5oUoxZbpHkrEkoEBeLqH1B9La6WgtI57JgZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=O0r7lF7E; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1750318431;
	bh=F9x8vQtF5/HAvC6Pm4BkuKVu7Q7161FXmb/umg6pHt8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=O0r7lF7EaKfpab2+tK31CK5xjHSkoRnnS5Ez5V7Tl36xY+Wl2/p7YVyNvwhprPlug
	 oVoeNMGF1COo9KBC8jpsjF2pVRgzk7jo10m+nLEcLJJ7cLhXcjLd0IqIkQCK+yGNQL
	 eFTWszWabjJ6h1WFQluuLganN1qSbNoJf063fFbA=
X-QQ-mid: zesmtpgz7t1750318427t7ac61a8b
X-QQ-Originating-IP: /z3pOFgnPzYPCFbw8XLhn/juIMLNqhzHBvo8pfioP7Y=
Received: from mail-yb1-f182.google.com ( [209.85.219.182])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 19 Jun 2025 15:33:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3112811725008939486
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e8276224c65so572691276.0;
        Thu, 19 Jun 2025 00:33:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUf2xVwyJncyH8qhlRIy2h63YTgLqU/jWhxNwMa2CQZJpXcBPM4G/Bt/eQ9dWpmrAVnMcUI6qMZLrnTodpd6WY6@vger.kernel.org, AJvYcCXez+o8CAkr0pxI6V4Po4jXJWpucMbDM3NLpKXyB+dam9/b2PiwHj4Ryg4Fh4nWY/8QfrOpuM4Jl20E8ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOdN5MWS6dOsSW9liYGSjbqVwA3wtyfNxqfhDDhAes66ocSwDu
	KS648h03+RHdBQwAR7pKlSMilro8FNaXMMBjlPCMk3tMyIteLD3LMr4sOWMDxK79q/e4gw2UYzm
	1cgcBw9PPTSxQ4eovc8NnI8jMUaPmkjM=
X-Google-Smtp-Source: AGHT+IHx54myZHmX7V9zXhgF60oE+/lCJNrSneHDfsn0CV/nVmt6MCigr11arJhOT18srEv39NJppdELYbYPpEu2fCk=
X-Received: by 2002:a05:690c:350c:b0:708:cd31:88a9 with SMTP id
 00721157ae682-71175521e51mr306133637b3.37.1750318424157; Thu, 19 Jun 2025
 00:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610020839.2799222-2-chenlinxuan@uniontech.com> <97e0eae8-954a-40dd-91ee-4a0a7cc4b9b4@linuxfoundation.org>
In-Reply-To: <97e0eae8-954a-40dd-91ee-4a0a7cc4b9b4@linuxfoundation.org>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Thu, 19 Jun 2025 15:33:33 +0800
X-Gmail-Original-Message-ID: <D658C2D54E0E0375+CAC1kPDMNc8fwUaWy+cNcXMTU0LxrcdtEQbDBKU6v=+C+R8mb9A@mail.gmail.com>
X-Gm-Features: AX0GCFsH-lz4bo3_InGlwsafMBL1toGcYR5GYc6_0YQg5RDPMrgnejgbRMoiuBs
Message-ID: <CAC1kPDMNc8fwUaWy+cNcXMTU0LxrcdtEQbDBKU6v=+C+R8mb9A@mail.gmail.com>
Subject: Re: [PATCH RESEND] selftests: add missing include
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, Christian Brauner <brauner@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, zhanjun@uniontech.com, niecheng1@uniontech.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NXGaokMyQa+wdsdwF5wLb0Xwfdet/QmCYa0xyzqfWIACzroFAMeRCN1a
	+HJpNuRxfQRO36D4V/MxLJJAR60Zn+fT0BtPCrXNR/hh3pGbfaNolEbmlShyyHeZvUTjLJ7
	ssbvHasMps/0DlPJCd2i3n4sqmQZk9V3CheIvZWz1Irjnw5Vi2xvnnbMjgQoA6Pesr3c1j0
	olrVI5gPmzpDFk/2aUaAn1RNSSFbXUtzgF+wa2WX04BLctBc/9BxJHKveeYBFcJsAz510fo
	q5FZs5yqXQA/2e54oRxYsIIR9C6SaC2f/QjRfIBs5HynrHb9rdhg90J4eY49Bi5PF0vQ5oe
	Xz0DNaSrXtoDCf08/H9lu2dvf+THR5mkvi5SYzZisJpjHGE1zOy7OdksxZHziZKZZElvMv9
	uxMT5gNJ7kE7GYp0Kx6t8FMXLDQ3FBx/pE+ss/ioZ7eYbi8B1hJTGo5Rf+ugOlbjVEH90UW
	fuj9sNHnj84cy6P8Je+IB/ZOcRfnw9f+PTH2YNB3o4czim2wG6gWNlfXr2H4xe6x7r7bIkf
	t5F6+WKlwN7O16TtJdLa0PyRn1gMeGGMW5el8MpPTLBST4WLw0V3Ud7CCLmp3f8FEkWLQLE
	pGQgu+hBUle3VPZ30PqTVCe56F0JI08Zk5Y+6d2qqWy/uRVHrHbelCXqUw2JZOCiNh0R4X4
	pfwjjcsKrL4CU1XEV/B4K+WuOgxYnxlhsij5K+135ymKUr/zthyFoooprijgONDGeBHO7jS
	GRe56zc27PNTRe1tW4Q2CV+t+7cSg15Lkbj0huT6EITxyfGoX/hg6h2Wo8XP+81f17Hjcd6
	HlbOw21qKwQOpxUzOiNbg1WtcviutfzEnAdMPPjEa3DxSDPELX01bE31FwSOwj3al8bI5f8
	RHUTblbOEfzmJ+lOKH44Du6QZcZGUO76YoI+2bVHBGZR86s1O44PCPFm3e8WJdObSB2sdqn
	Jk44JB9y/9DwhcE9JxL5CirfJFNEIUb6tKSBsrFx44pZlqqQbKr1mothOHNISTAkCopuWfO
	QstwYakZM5mvbjTniPtG+jT/WDHHA7v8FLBG84CdN9sesx1T67UWqZ+XsYAiHgiO8wMCFqT
	xZ4i5foTojdE6lBKUamWzYIXhHx/iDWHXfeyN/FkPueE6RNx/sIWw4=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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
>
> >   #include <sys/wait.h>
> > +#include <sys/mount.h>
>
> You are adding a duplicate include for the same file?

I made a mistake when resending the patch; this patch has already been
merged before. Sorry.

>
> >
> >   #include "../kselftest_harness.h"
> >   #include "../pidfd/pidfd.h"
>
> thanks,
> -- Shuah
>
>

