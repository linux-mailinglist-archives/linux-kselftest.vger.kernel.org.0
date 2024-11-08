Return-Path: <linux-kselftest+bounces-21704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C38839C22B1
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 18:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12741C236FF
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 17:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E436A5B1FB;
	Fri,  8 Nov 2024 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1xOKqM9+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C631DFD1
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731085548; cv=none; b=KAEdfgSU14z5V4+iwxckXqcazmlzaUWUIm8FMQBtKgmF3ri6sqK6MNX+bygdGUAlzQdTL1X9C4/j+qENpj/Lvc3+GigWlrEyWpEn1Bx8kS4xkxlnbocvRZqxorjsAv1uTdTsBAu287gaxzAliKUTehq5plvNjIHXox/CjdUCfa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731085548; c=relaxed/simple;
	bh=ExREy/Y+J2HZhVN0Mg9YnNdDDuhxJa6JcKLOLQYV/Sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwZwUzeJEWu9/1RzjCazRUqSDq0R6TyG+eKJKzLT4dSHHmyhsmtyoUhwoXtUCid5s7Cv1/knFL5xM99sLQRDIGgw/I3svlAbNEgNKZtupLWeTMQD6xClm9OC/V7lmu/WiTB9LEcCR5avvwt7/obRP04wJIOhOC7iXR9JedQK3MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1xOKqM9+; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e3f35268so2748543e87.3
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Nov 2024 09:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731085545; x=1731690345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExREy/Y+J2HZhVN0Mg9YnNdDDuhxJa6JcKLOLQYV/Sk=;
        b=1xOKqM9+T/oHJb80Artd9SIrOJ7Vw2jDInlJBmKx8RhvLhnXyj1syiOsSpvKDfNd+K
         zkPer32/ypwKoAbK/ERcO1jENj9G4ObXTs2D7U19EY5thCOANufi3MjHDr7L4UAAS19N
         nz5PdHx38anRqW0jLgVhQq539UAxT0vvxYMl44V7fgIZCMuiJkgJTs2+v4Lh5LqEtnxx
         ek0FTnOl2rCDBpMWMXxLFzyJUHtTa6LhmgLq+7w1XHk+JuAmu1XwsESsuC9XWq319KDM
         yoLNvMCPVSvfbLZknFkT/P1/PquHkBNcApS+T76X3irDQxuUTWBf3MRxfJiujthiqhAw
         d/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731085545; x=1731690345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExREy/Y+J2HZhVN0Mg9YnNdDDuhxJa6JcKLOLQYV/Sk=;
        b=KR0xurwTc9JPLWQlpCyJ1yL7pyIg1fnXYZLvrClGOI9J2awlbe/sNbzrdKTU7BFplW
         JBsNNbDpByK9XpJU0KWhRnuLemT+ReizV0zQFkxM003AwXaXYkl1l8nCKRwJsitgGTnE
         RQlY6da0FFdkJ8QRgr+tUp1MBhqpUdj9vJcluuSWRsPY/oJi9MH+ebaQD8xThwZEElJZ
         ihqVoLBDOV9e68pxgbpA6dVrvy8pIS+EVIQB+BeJX5SFiK8RmJJyNfb+Lg6ixtmDW6wi
         SLkRA3qIv/0pX1mzoWTkZ4UYTnrwfj5mT8GneuU9YKZvejNFatP33eijD5UM6pfrPpi6
         h/cw==
X-Forwarded-Encrypted: i=1; AJvYcCVKN+iY3KKHbczXcE59wWqaKA1NZEkXNlmNyJyEyXOtq1Rrd2Or1a2QhEwUx18Tv4AEYSEPW8VfViKh1o4R0PI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFssFxIBzQSwL9Fwy3+U9zYw8se8weE/hj8tPtmpco3rHNVCv4
	B/JmP07E6/1Lz7b+dh/HdaEfqCTH3kWwsmMi+IUE6bnPOpuKDaK0Qry+BCwAatdDaZ0PbPEpu3m
	Pb4KqLgPe3Px/AEgI2t7F+EWRwX/WRTMfEf+sqVmmAbDnoaN6u+8N
X-Google-Smtp-Source: AGHT+IHWILQr9wHDg2LqgXB6Q0pXhpjYSVXPTCnaNBLt2NOwH5GFoBXP1m73m85xBZFh+iy8ro53aKhvlQ5CUW6C0O0=
X-Received: by 2002:a05:651c:b0d:b0:2fa:ccae:d1d3 with SMTP id
 38308e7fff4ca-2ff2014ec03mr23023821fa.11.1731085545000; Fri, 08 Nov 2024
 09:05:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+i-1C2-PGPcfSJB4oLqHN3jAE9CDY+iNaW9WCiRB6zF0fgQ3Q@mail.gmail.com>
In-Reply-To: <CA+i-1C2-PGPcfSJB4oLqHN3jAE9CDY+iNaW9WCiRB6zF0fgQ3Q@mail.gmail.com>
From: Daniel Latypov <dlatypov@google.com>
Date: Fri, 8 Nov 2024 09:05:33 -0800
Message-ID: <CAGS_qxo4vWvYeK5QSoQib_CxX=RdwNY_GCPdkY-bcWdTw8NmxA@mail.gmail.com>
Subject: Re: "stty sane" in kunit.py
To: Brendan Jackman <jackmanb@google.com>
Cc: Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(resend, gmail decided to switch to html email :\)

David would know best.

As you probably saw, this was added in 021ed9f551da ("kunit: Run all
KUnit tests through allyesconfig").
This was specifically for running on UML, _not_ QEMU.
I vaguely remember it being along the lines of #1, but not what the
details were.


On Fri, Nov 8, 2024 at 2:49=E2=80=AFAM Brendan Jackman <jackmanb@google.com=
> wrote:
>
> Hi all,
>
> Does anyone know what the 'stty sane' invocation in kunit.py is about?
>
> The other day I ran into an issue when running it via watchexec[1]. At
> the time I believed that it was there to clean up after the firmware
> that QEMU runs potentially messed up the terminal.
>
> However, I just realised I'm not sure if that makes sense - stty is
> about setting terminal settings via ioctl. I don't think QEMU or its
> guests are messing up the terminal with ioctls, they're just writing
> funny control characters.
>
> What's going on here? I guess one of:
>
> 1. Terminal is messed up with ctrl chars but ioctls are the
> easiest/only way to reliably clean it up.
>
> 2. Nobody thought about this unimportant detail so hard before and
> there's no particular rationale in place here.
>
> 3. I made bad assumptions about why the `stty sane` is there.
>
> If it's 1 or 2 I wonder if there's an alternative way to clean up
> without getting the SIGTTOU issue.
>
> Or, maybe it doesn't matter and the fact that this was ever a problem
> is just a bug in watchexec (maybe you can tell I haven't actually
> taken the time to research the SIGTTOU thing properly). But thought
> I'd raise it in case this points to issues people might have using
> kunit.py in CI.
>
> [1] https://github.com/watchexec/watchexec/issues/874
> [2] https://gist.github.com/bjackman/27fd9980d87c5556c20e67a6ed891500

