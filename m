Return-Path: <linux-kselftest+bounces-18142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B5397CD70
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 20:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8181F2332A
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 18:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DA41802E;
	Thu, 19 Sep 2024 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW0Y30pm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C133814A96
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726769150; cv=none; b=HzTCWjuMOxSRGiDb7T6/ee4kkWiLIZd4DzzwPg/p3WEh0fePr4yFFHXlUYB9q6sc0RYMHP95dOHXfmRsKqexAoStSLHd13RY48MUxDo+HiUrvaFe7o/S0vWyZfsIsF5+SXgLb2qPe4mqwV3uriuvAQJerW/cA2tamXYOnLTwckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726769150; c=relaxed/simple;
	bh=tJ9VwAsABL5YscqFjpR5w/AZcfP0RF3jS9ktZJ/WMaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glhFlMjWDMq2GX2Iw4Q/mdbdaPfbAg6yenWzJh1exuIKEN1llJoBINnz3OQayP7K65WkRA7nRlVnJJpUF1xumoGZEDQzydD8FLpNRbmnh5ZqHBOCgwclLLbd2LGB2TGK9XnfBov6ZtLLH0eMoP0XZPtvlcKUVJY7sGn5gTFYZUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LW0Y30pm; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-710de2712eeso439670a34.3
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 11:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726769148; x=1727373948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJ9VwAsABL5YscqFjpR5w/AZcfP0RF3jS9ktZJ/WMaA=;
        b=LW0Y30pmfPHAxXjz49jhInm5ybNRQrEke+k+6uhuPzneUQzu06ooxXdnU8nN2uvGL+
         EwslMHUU4eaouqSdZfTvWqOKlLXd4utXDRpa25WAqjCS0GAVUFvPl7yRBDa8ffMKYD15
         87IG4JD9Csc9H9Hx0pJnC7Ykcm4pR1INdB3SqY/sU6whDfk94AmSkuJkLrJhVpvR8Aep
         HgSw+y4cqkAMpOx2tFDbxonIelPEGMDTTgTOwIxynRUhcd4YKsrmJxNHSHmniv4tPG9/
         94I143pc+W5vr1kZr37qjCNPdxQc8CYkzmRlTOoPRfM8y81wekueBYxeJHNZ38j6Gybs
         bGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726769148; x=1727373948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJ9VwAsABL5YscqFjpR5w/AZcfP0RF3jS9ktZJ/WMaA=;
        b=qooPdBvjkyjCCsOYmeJa/xdtjnhImkGc94KV5GL5hbW3/rTc03/U9K0cau05+yHc0P
         3p+My46TrdIufk2iY2Jlco3KtQfVuSlxyzclx/aTraAwBHOGtWAbcSLvnXjEPEUAyxW6
         RQPBQn3uOsno6OJBvSvPr7gkJNpy51LLo5I3KYtgjiEuQZMhlvOhYD3THYLobR1np10T
         KPuEo57ZmWiy5MqP1h6Ky5z1j5A623PFg0OMHHe4SbqqPi+WPuGeLMK8NCJZsDRKzhay
         Zce/2u4nqhwP0Luo0bxyC9jlC0mF8Ha3HbdDSL4ZQkZDSSSwWvRxrPNpa55tbWzuDq8c
         Ro/g==
X-Forwarded-Encrypted: i=1; AJvYcCUwodpFPfJjJjPa2qyx16Wy3nRBMtYkf0ydQ+hOFudYzgoX2zTlsaBmYOarkTU7J2WaEQ9deIA+klsGPZsc2ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCfZtoRTUn5JXtSqtf5o1AC3UrXVlarYdw0UXuCLkajM5NFaW0
	/nP8NcbI3vJpmzWlSGEmHOznExkB4jpYTZjlIbapJuAgUGd2PcGExar7Kpka713yI/ZUXHck7q6
	OH5dsfT7lEJDWqQK2awCypDKvkxI=
X-Google-Smtp-Source: AGHT+IGKFjCBJ8TEQsnw9XgZMTASeeiRgzJ0Td7vC3lVxHkzzMCk9UI8Zjm6kLSLNTmtrJpIZDx7gyXFw0bs5FM5pXY=
X-Received: by 2002:a05:6830:2b13:b0:710:fe18:37c2 with SMTP id
 46e09a7af769-713923b0efcmr364796a34.6.1726769147749; Thu, 19 Sep 2024
 11:05:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918004731.3295870-1-raj.khem@gmail.com> <CANDhNCoY=tvhWFmY_dZGqPdCiTZSDX3cet7qQ00zvSUBFHXLNQ@mail.gmail.com>
 <713d7e8d-e6d1-4438-a47b-6bb95a4e1c61@linuxfoundation.org>
In-Reply-To: <713d7e8d-e6d1-4438-a47b-6bb95a4e1c61@linuxfoundation.org>
From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 19 Sep 2024 11:05:20 -0700
Message-ID: <CAMKF1soeS6hOtP0JTByNG_zA0GDq7dFRiHwM9OC1vK56+spgGg@mail.gmail.com>
Subject: Re: [PATCH] selftests: timers: Fix clock_adjtime for newer 32-bit arches
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: John Stultz <jstultz@google.com>, linux-kselftest@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 10:54=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.=
org> wrote:
>
> On 9/18/24 02:58, John Stultz wrote:
> > On Wed, Sep 18, 2024 at 2:47=E2=80=AFAM Khem Raj <raj.khem@gmail.com> w=
rote:
> >>
> >> Newer 32-bit architectures e.g. riscv32 are using 64-bit time_t
> >> from get go, they have not wired __NR_clock_adjtime at all
> >> valid-adjtimex testcase fails to compile on such architectures.
> >> if this condition is found then use 64-bit adjtime syscall
> >>
> >
> > No major objections here. Though I'm feeling a little forgetful as to
> > why the test is calling the syscall directly instead of going through
> > libc.
> > I suspect it's likely due to the test being written prior to the libc
> > implementation being common?
> >
> > So I wonder if a better fix would be just to drop the local
> > clock_adjtime implementation here, as I'm sure the libc has similar
> > logic to what's being added here?
> >
>
> The proposed solution works better than adding local clock_adjtime implem=
entation
> here.

Thanks, I will prepare and test a v2 by removing the local copy of
clock_adjtime.

>
> thanks,
> -- Shuah
>

