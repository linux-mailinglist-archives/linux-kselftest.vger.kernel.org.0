Return-Path: <linux-kselftest+bounces-19584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD1B99AFC0
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 02:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6911F22D74
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 00:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FD7C8FE;
	Sat, 12 Oct 2024 00:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PksYnyMa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD82C133
	for <linux-kselftest@vger.kernel.org>; Sat, 12 Oct 2024 00:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728694037; cv=none; b=EzBknqS4DQkmqHIuNH/Ccnd9/V6aFqzHSx3EHQTSEZ1sIjKqt545ImUSKggBvTrpenzDfD/Pl8c5Xp25kqRSiGD3G9ZEWMJZg5RPCKC7PumTHlm3WvoeEEXJbxHCVugGem/To3RfLoQfCf4ulSNRWBgpfs4fPTaRwOZdzULCK/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728694037; c=relaxed/simple;
	bh=elK4arXE3PLqEXfBV35FUCHwXvIKoCAJCxvkJfOpH2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNadi9yfuYrEg87nc5yTI+LKIfAk0cUyajPZll9D954bYIFKebskkFjbEaI/GTIdcF+NKjzVb16G8hLnkDpqjSJ4OS39rOyc+3zP+FbD8+MYG/QMMi4G4CDEqz2t5P6ax+nK1MgZOiSUWoW5h2/EcOB7yxIPe0FNSf1fveKOaL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PksYnyMa; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a994ecf79e7so404811966b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 17:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728694033; x=1729298833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UF9yU3bM/YpYwHN9NW0ByqrDPxrNlfJUeyayEQzW8YM=;
        b=PksYnyMaot/uL8+bCDFRORqf+NwMmEw3VVztPVuIat5fTZyFrVFXs6qqYT3YptiOJD
         bh1D6Q95zCVk1ahi9TGF0QBOkA0jft7mfBUhBNE+hf4DVeN6uKTjSgTDvCjgFdph8EJD
         ZEx54yMfyn07Gn1KI6TWEVq4bpEj9GOfLC9TC2+A0xgEMrw/G+p3HmfiZMkAsvrteZ4i
         0ir/lS+Zhv1Vrcx+gIJsrJW2O/KgR83izxKzdfP270hCnsSjWs0mw8u1nqJH+4YuZg3I
         n6ulFQppM4gr8gPgk6F9xqgPJAnIq4XaYwOLlB+Z+k2IqsPSvbgPIUhTRXhjHgesHEwr
         s+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728694033; x=1729298833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UF9yU3bM/YpYwHN9NW0ByqrDPxrNlfJUeyayEQzW8YM=;
        b=Tm9eVaRu0YP05T3ncvYmqQiTTwp0uQxA+lcUYjiuAo1U07d1OR5Ux9l4RxIU4MX2zq
         9AxdZBiJrVur7P1UKIddZgm6JzmyG2UWZZ/KM0dRTSrs2stffQF5u7bv6wUrXdn4GdVI
         SO7VS0wrjsd1MoD4qHjSM1eSIshUtpo64ikKVdzXNF4xy7GACaRd+PlliDXkUk8fsWpx
         0NQfdrlMVbhOjHx4VYRlIpavtDLmca2uWR36m2VIjMhFJF6PBtcwojb/sYFSE+fn49MR
         dJX21bu7GVPvzve/OitgHVKpTC2qB78UbhstovI/StMCZDLhO3ULCca8UbAAMi24zjww
         KS6A==
X-Forwarded-Encrypted: i=1; AJvYcCXsmn3MiwGgmGH0ZjHawNY2J01LgiyNfa4r9FpcQ+XwHlrGk250/SZD4VBqvrwk1D7MQpEYwwZVsIeOx4ESg5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya4PF0yGSlcqJbzaG52lvLEEa89wd/ENxIpwcyy87nfn/bzE6q
	/epe0bXqOo1XEk331KXOnNRSUcwUzI850mHjFeR92juIyyGCZByo4jNY2qiq0pt/efA+2+0QxMQ
	mKa1jdsSAM48DdtvvneilMVUuVPH5/Yt1jGA=
X-Google-Smtp-Source: AGHT+IEyY0JIrQtGbOHuIYBoV6hVfrIwU1kvm8tiuGUlVkb9c8kyNLCuLC/DVScC9zSBcWUFQ/+4c4sksPrL+Ae6kj0=
X-Received: by 2002:a17:907:c8a9:b0:a99:d52:4518 with SMTP id
 a640c23a62f3a-a99b945ec2fmr387727966b.21.1728694032740; Fri, 11 Oct 2024
 17:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010073707.4038081-1-nichen@iscas.ac.cn> <87492b3f-84d1-426f-ad71-7784a1c1dfc3@linuxfoundation.org>
In-Reply-To: <87492b3f-84d1-426f-ad71-7784a1c1dfc3@linuxfoundation.org>
From: John Stultz <jstultz@google.com>
Date: Fri, 11 Oct 2024 17:47:01 -0700
Message-ID: <CANDhNCr5X3gkSRR7cWZ13DDbepV3Nb1tQ5E3XuAaJx_5vZ=PCw@mail.gmail.com>
Subject: Re: [PATCH] selftests: timers: Remove unneeded semicolon
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Chen Ni <nichen@iscas.ac.cn>, tglx@linutronix.de, sboyd@kernel.org, 
	anna-maria@linutronix.de, frederic@kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 4:00=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 10/10/24 01:37, Chen Ni wrote:
> > Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> > semantic patch at scripts/coccinelle/misc/semicolon.cocci.
> >
> > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> > ---
> >   tools/testing/selftests/timers/set-timer-lat.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/timers/set-timer-lat.c b/tools/tes=
ting/selftests/timers/set-timer-lat.c
> > index 5365e9ae61c3..7a1a2382538c 100644
> > --- a/tools/testing/selftests/timers/set-timer-lat.c
> > +++ b/tools/testing/selftests/timers/set-timer-lat.c
> > @@ -79,7 +79,7 @@ char *clockstring(int clockid)
> >               return "CLOCK_BOOTTIME_ALARM";
> >       case CLOCK_TAI:
> >               return "CLOCK_TAI";
> > -     };
> > +     }
> >       return "UNKNOWN_CLOCKID";
> >   }
> >
>
> Looks good to me.
>
> John, I will apply this for next of you are okay with it.

Acked-by: John Stultz <jstultz@google.com>

> Also I noticed clockstring() is defined in multiple tests.
> Any thoughts on removing the duplicates and adding it to
> a header file? This will add a dependency on another source
> file, but might be good to remove the duplicate code.

Sure, no objections.
-john

