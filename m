Return-Path: <linux-kselftest+bounces-5530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 507D186AF44
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 13:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FC21F2682E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 12:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1EC145351;
	Wed, 28 Feb 2024 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWb17mhK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F0C73515;
	Wed, 28 Feb 2024 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123837; cv=none; b=tnMyjkA4YkPHC1H9debBhwxn37JPh2CqBOapOZdXpOCLfSlDrsjO1jX6cleq6SVffcq2GzhhU4FtMtwWEEUE+UUTVzzd0hj0hdNcZHinmzTOQVhaikgHo1tvc/VCYArRmjoPwFYEMSYyYsXoi55VFt9rH4weA0oZyipzREuqjrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123837; c=relaxed/simple;
	bh=OiCrhkAImdpoKzsF7o8mkmuy5/VGiIrPcYWm0Rn/A1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCriiYDbLvjky63nA37+7hGNLBbbPg7crDyDGO0Jw8I5hsLb/DgAmdAeLsTYD8meQsOe5GaYDMf27tj/IL8IjctE+1Wt60huzIoeaNoL2ELiESnGvlXppCedYjko8hUuTukzVwwsoGyqF3h2PNusUqYgRQboxFVb4evtWPCITGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWb17mhK; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-565b434f90aso4980784a12.3;
        Wed, 28 Feb 2024 04:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709123834; x=1709728634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JudlYv7kq9yuUXRQ/PvG4bnskD9Dxwze5xbPVzN+2ng=;
        b=FWb17mhKZQNgPPNRPNCZOrIanbIj+q42DbPmuqYMF2v1EGowjqJW7QDuYC/M3tj3fy
         G4kDoBNRSGhxIzbquKxg0S3ALjtfdwdklJB6JitRoaqJAGmdxtqMEngpmwxVhpHohpK5
         gYWnzjJaZKGB66yMpm+1KLAZJsdSRELGel2yWumShwX4wsuSGEo0F0sj8z+DwbVm7grm
         rNMcnN1U2U1U0H7a4FzWWoazV22bew/IGy4zEEJ5UA5Yhz/tyRr8gITgvPJLt3b3pWJL
         QgXbEBsFK7jOh9ygR+9PHCVMphMZXL2DQHDZf218B62/3mYPO1aMjAM7e7i9L8A+sQGm
         +Dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709123834; x=1709728634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JudlYv7kq9yuUXRQ/PvG4bnskD9Dxwze5xbPVzN+2ng=;
        b=hehhtwhB0wBN3epNIMbk4PRujwIxVllVG2aNtYV2JUnYVkzQETYrtJO9BAHAPJyXbA
         6jpVcW2AC5IYEQUnknF9GQiz6Ccz5ArcfoDDRg4v7l1y51Cq2WWIinni/WbRpb19HAzx
         4ZybptSoFtLRq0tVd1cvRK2yf7eAlYCLn4aC8gVadFw3YGWlEr7LWFDZfdd7repRntmC
         BtaY5fBhSS0eOpHb93XoLi1HV1uAPyJ+53EsPGXeviIaPxKDWxt9QJPDnLYzjs9wrbV+
         DCPPWIuMr9rZWg/3PmW8cfbUb7VgGkibkFVVWvALYuqPUQkaXtiSwQbW1s95VBgmkF2T
         J7PA==
X-Forwarded-Encrypted: i=1; AJvYcCWYbXrw9pIFXQCLUxDpZZnKkjJCWrOSxPqqAXYp6H76uZbl1OSBQ76ifrVsYAQlhP0P+X4p33yOIovIseXZ1TIoU1SA1pSsSqUsHc9p6G8o0VNEvui/Xji2skmXWGdvFxJdUtmyn33laHoPqcfwctnFy04g0NDEqIsoouWgVWCVa+0AlvaW
X-Gm-Message-State: AOJu0YyVXyUPgy6osRxtGXj4/P/QPDSzefFoOSC42LhlJiKkvGCIN1/W
	vaITrDgRDioxQ46TwfWRpx+NOp4RMcx7Dt7ItmTvsYdh/Q71VDu0T5hp4t6CWU1uWMtRYIzbSWe
	Y2lU+DBegBXdZyv5I8sQ9QrFVSdw/5Efa
X-Google-Smtp-Source: AGHT+IE96ZWkre7JVXpJhyMlgo+IHpI1hOKcxl71SkWQaICp/+hmUTxPfiwoqMZshS5hFp43nVH0QUrSoFDjJIgAIdk=
X-Received: by 2002:a05:6402:3126:b0:566:4e7a:fa2b with SMTP id
 dd6-20020a056402312600b005664e7afa2bmr2110728edb.36.1709123833969; Wed, 28
 Feb 2024 04:37:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227175513.8703-1-pvkumar5749404@gmail.com>
 <Zd7lqr8Cz4XrNoI8@nanopsycho> <CAH8oh8U1KLxY95DQW9duU30VC5hdQd1YKs+8USuuz0k4JWtBSQ@mail.gmail.com>
 <Zd79vEsSp7wlJWQy@nanopsycho>
In-Reply-To: <Zd79vEsSp7wlJWQy@nanopsycho>
From: prabhav kumar <pvkumar5749404@gmail.com>
Date: Wed, 28 Feb 2024 18:07:02 +0530
Message-ID: <CAH8oh8W9hzWV-fajb-1OoR8dZEbqhrCGL=3bcDRhaDObbacDDA@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: net: Correct couple of spelling mistakes
To: Jiri Pirko <jiri@resnulli.us>
Cc: shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, petrm@nvidia.com, idosch@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 3:02=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Prabhav, I'm not sure what you are trying to do, but you have to
> re-submit the patch, preferably using git-send-email or another email
> client you use.
>> Sorry for that.
>> Re-Submitted the patch.
>
>
> Wed, Feb 28, 2024 at 09:42:01AM CET, pvkumar5749404@gmail.com wrote:
> >On Wed, Feb 28, 2024 at 1:20=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wr=
ote:
> >>
> >> Please fix the patch subject to include appropriate prefixes and
> >> rephrase a bit like this:
> >>
> >> Subject: [PATCH net-next] selftests: net: Correct couple of spelling m=
istakes
> >>
> >> pw-bot: cr
> >>
> >>
> >> Tue, Feb 27, 2024 at 06:55:13PM CET, pvkumar5749404@gmail.com wrote:
> >> >Changes :
> >> >       - "excercise" is corrected to "exercise" in drivers/net/mlxsw/=
spectrum-2/tc_flower.sh
> >> >       - "mutliple" is corrected to "multiple" in drivers/net/netdevs=
im/ethtool-fec.sh
> >> >
> >> >Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
> >> >---
> >> > .../testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh | 2 =
+-
> >> > tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh    | 2 =
+-
> >> > 2 files changed, 2 insertions(+), 2 deletions(-)
> >> >
> >> >diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_=
flower.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.=
sh
> >> >index 616d3581419c..31252bc8775e 100755
> >> >--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.=
sh
> >> >+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.=
sh
> >> >@@ -869,7 +869,7 @@ bloom_simple_test()
> >> > bloom_complex_test()
> >> > {
> >> >       # Bloom filter index computation is affected from region ID, e=
RP
> >> >-      # ID and from the region key size. In order to excercise those=
 parts
> >> >+      # ID and from the region key size. In order to exercise those =
parts
> >> >       # of the Bloom filter code, use a series of regions, each with=
 a
> >> >       # different key size and send packet that should hit all of th=
em.
> >> >       local index
> >> >diff --git a/tools/testing/selftests/drivers/net/netdevsim/ethtool-fe=
c.sh b/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
> >> >index 7d7829f57550..6c52ce1b0450 100755
> >> >--- a/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
> >> >+++ b/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
> >> >@@ -49,7 +49,7 @@ for o in llrs rs; do
> >> > Active FEC encoding: ${o^^}"
> >> > done
> >> >
> >> >-# Test mutliple bits
> >> >+# Test multiple bits
> >> > $ETHTOOL --set-fec $NSIM_NETDEV encoding rs llrs
> >> > check $?
> >> > s=3D$($ETHTOOL --show-fec $NSIM_NETDEV | tail -2)
> >> >--
> >> >2.34.1
> >> >
> >> >

