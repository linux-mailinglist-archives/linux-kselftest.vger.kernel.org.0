Return-Path: <linux-kselftest+bounces-26376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B4EA3101B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 443AD7A11BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFB91F9A90;
	Tue, 11 Feb 2025 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM9CU/5r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6C11C5D40;
	Tue, 11 Feb 2025 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739288864; cv=none; b=uHoiVUw6xWvh1r60eLAsn9UPc1iJdV707UzOW0AI8pqp49uruNPjpcTNfGK9ol8K551b6F2Zki/6HCmWoZS93CotQPW/c6hnIsh0Uib3lGaj8FtsGH5F9JDICNpk0VAjE0pyl1SBcrgTNxN9ExC6QZX/Xv+93wsVjaxNUCxOkH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739288864; c=relaxed/simple;
	bh=0e6gXvOv8OI52OvPTOmHbHQ5p+C0D+mKuiB+PrIKeRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ezrm82/d3kcLCOAjaz6DzlBSdLROq39HsTq8Z9P5KaOu+qg/sjAcBf75KB88yV7yvrA4B4g3a1WQLbD3nGPxXMH9czk7h9qhMZrtiVVU4GyP48KpzDR6/8D06BSBuCXnl9OezxcMRj/px9Pb0not0ThwovCOwhn7/9A4dkzsHGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MM9CU/5r; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so53628581fa.1;
        Tue, 11 Feb 2025 07:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739288860; x=1739893660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qW3MupCMT6q3NXqxHwZCkq1Fmmx28yOZRXsGS5KHh1E=;
        b=MM9CU/5rpI/ZxA4G4ja1aKNWGxA2MP7j+HO2+3W6O9YlBhVJLaVcN2kwc5prbAe+xd
         jm/OMUNtNQTw+cib32cd+cVpDNsBg6rgIAWeZE0Wyvup9IXZbUUek8P4LS7mk2Nny/cf
         fRa6CxVvx6b1NVZ3ZptrCq8QeXl4gEHMFRxJhlKxHh9NiU1sLngFzixe7KE9XvzKxBti
         C73Fs4WoLrhQmpxz9E/zEOnPtru6tzIuyIoiT5ZgdkPCGPo6Vbjm5dQ2vjCTvRHKKzq0
         zJS67ZWbGrwcoIbzI8jeeqRY583gEBmgsOy2HsUuTd+eMw3uXJ08l9pjt9lx0Ohx86jv
         /8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739288860; x=1739893660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qW3MupCMT6q3NXqxHwZCkq1Fmmx28yOZRXsGS5KHh1E=;
        b=H6LcdFFY5bUWzu5pZ09Zql4DP3fXpZ5zoPTTdoDBv9p9pBC3Ejlv7KpW98U1hc5npA
         YBYHafgsOL0PIg1jqk1O6H07F0VoSJwWlW86AmRbF+rmeF7Zz0MB6seGxC1vf4pF0N5m
         E+Idt7FNI4fMCTtofgumLDaqx/o2CTDqxMIJHjtD38W2X6hyOpTb0u9H0NR+y73Ybosf
         lLMdXYso1wXNYWflkUpUbSA/LDcziyIIlOJMtTZARfNGt1HcVY+ishCqgOqRkgqGyFMS
         ASEwUqU1wxuIOmUA71MOCq+OBqSGL+RqTUMKLsUlDO4fupUDaPYRBHIrrJit5nnpbyP/
         vMEw==
X-Forwarded-Encrypted: i=1; AJvYcCXzZQPBp2BcYG0JNcasRDrhnnasgxghO6YqiFud3cxt2NLwHe+Z31DoivhthtD858aUBIMXeeUj6x1RWLfh1lK+@vger.kernel.org, AJvYcCXzrh6MNCEuEl4oq6ealjUY9RnlrbBY7thLfskBY4GoUAczD66xTsaS8KDdhmerCDMJlfQjGmN4dE/3mTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIge2eBZF+kXpqrsdDvTnK3NeMSrGOJGdf1Zsl35G8746xjNjw
	0WfAPZDlq21D1K2WPXnkqgFbOYmiFClJFqEJ/7hLyKatSmA2hGu2gnDqfBYA0/ViQhfIrfOJKzH
	SU0Ve8FjM9aQaXzFHcrowKGJ0N8w=
X-Gm-Gg: ASbGncscmRtrKOvFobsDRmUpE9D/aAzT4XV+MucFpvE4TIdPoPO3Qf7UYVffgR4UyuF
	88DV452ELO/qKY9VSQagvq/Za3ySSB3a54Up5H+odBzLrXD/KWVH5YYfuQASLOjAWVBSc/w10zQ
	amOzFHqLbGpl1A
X-Google-Smtp-Source: AGHT+IH84IdHD3B44IA6MhJP3UQ5MSwRzqGk1wJImJwp9uXrXoAhD1qoCzimgMUs2vEqtV1WYo3wlzwvOo498avYaiQ=
X-Received: by 2002:a2e:be86:0:b0:308:ec6f:7035 with SMTP id
 38308e7fff4ca-308ec6f7257mr31568921fa.31.1739288860311; Tue, 11 Feb 2025
 07:47:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211-scanf-kunit-convert-v7-0-c057f0a3d9d8@gmail.com> <Z6tvciJpQgTwYpGx@smile.fi.intel.com>
In-Reply-To: <Z6tvciJpQgTwYpGx@smile.fi.intel.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Feb 2025 10:47:03 -0500
X-Gm-Features: AWEUYZl0EwBHPxNT0OuL4zMG42Pv9Da2xmpkVgxYd6hm0E1YG3vccOySJBHoueI
Message-ID: <CAJ-ks9mcxW7zY33FPB+mZ75dQ2Xqo-viM9CpbL=0i0WXUPJRhw@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] scanf: convert self-test to KUnit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 10:40=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Feb 11, 2025 at 10:13:36AM -0500, Tamir Duberstein wrote:
> > This is one of just 3 remaining "Test Module" kselftests (the others
> > being bitmap and printf), the rest having been converted to KUnit. In
> > addition to the enclosed patch, please consider this an RFC on the
> > removal of the "Test Module" kselftest machinery.
> >
> > I tested this using:
> >
> > $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=3D1=
 scanf
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> > Changes in v7:
> > - Remove redundant debug logs. (Petr Mladek)
> > - Drop Petr's Acked-by.
> > - Use original test assertions as KUNIT_*_EQ_MSG produces hard-to-parse
> >   messages. The new failure output is:
>
> It would be good if you put into cover letter, or even in the respectful =
patch
> the example of the error report for the old code and new code that it wil=
l be
> clear how it changes.
>
> >     vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4hx %1hx %=
1hx %4hx %4hx", ...) expected 837828163 got 1044578334
> >             not ok 1 " "
> >         # numbers_list_field_width_val_width: ASSERTION FAILED at lib/s=
canf_kunit.c:92
> >     vsscanf("dc2:1c:0:3531:2621:5172:1:7", "%3hx:%2hx:%1hx:%4hx:%4hx:%4=
hx:%1hx:%1hx", ...) expected 892403712 got 28
> >             not ok 2 ":"
> >         # numbers_list_field_width_val_width: ASSERTION FAILED at lib/s=
canf_kunit.c:92
> >     vsscanf("e083,8f6e,b,70ca,1,1,aab1,10e4", "%4hx,%4hx,%1hx,%4hx,%1hx=
,%1hx,%4hx,%4hx", ...) expected 1892286475 got 757614
> >             not ok 3 ","
> >         # numbers_list_field_width_val_width: ASSERTION FAILED at lib/s=
canf_kunit.c:92
> >     vsscanf("2e72-8435-1-2fc-7cbd-c2f1-7158-2b41", "%4hx-%4hx-%1hx-%3hx=
-%4hx-%4hx-%4hx-%4hx", ...) expected 50069505 got 99381
> >             not ok 4 "-"
> >         # numbers_list_field_width_val_width: ASSERTION FAILED at lib/s=
canf_kunit.c:92
> >     vsscanf("403/0/17/1/11e7/1/1fe8/34ba", "%3hx/%1hx/%2hx/%1hx/%4hx/%1=
hx/%4hx/%4hx", ...) expected 65559 got 1507328
> >             not ok 5 "/"
> >         # numbers_list_field_width_val_width: pass:0 fail:5 skip:0 tota=
l:5
> >         not ok 4 numbers_list_field_width_val_width
> >         # numbers_slice: ASSERTION FAILED at lib/scanf_kunit.c:92
> >     vsscanf("3c87eac0f4afa1f9231da52", "%1hx%4hx%4hx%4hx%1hx%4hx%4hx%1h=
x", ...) expected 1257942031 got 2886715518

Makes sense. As you can see the error report for the new code is
included here. I'll add the old code's error report if I have to
respin v8.

