Return-Path: <linux-kselftest+bounces-20052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7678E9A2E45
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 22:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA4B1C22A77
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 20:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A4B227B8D;
	Thu, 17 Oct 2024 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mx0Izx+d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE0721BB0A
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 20:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729195973; cv=none; b=WyRJhkMtpA3qiibZ2FMDzzOjEYhyt5NMt3+A3j+iLcfV20p299E6HVcZuV645v/fYQk0ZDrQcE1rfHOyVn4OywmrI3wZSnVxDbGxYRjjfGRMWNf0ijied0Qy4nvEiT9a9j0s6KrmVdnfbK2mQI8iJ1p2rs6qRiWv0CKEz4CnBXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729195973; c=relaxed/simple;
	bh=NBozDxQInUDVX/+SAvu1SlyYGKkBJoWGPhOhoYJAyiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=US5MN3jLJ4vzonrwIuDVF1+kiVDWbIgugy9xnC3C35hWipEmi2JDwbQiojalYK63c4oyax/+6SEmcUjiczJl0x/nwUlhRaRuey4ykRC0J/Bs0gS3NSP9QshstsbWoHKMiLU1qU3fz0W5kDdXsrjzXEZKuy5zjTps6b1gSMsCmRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Mx0Izx+d; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c9404cef42so145546a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 13:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729195970; x=1729800770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBozDxQInUDVX/+SAvu1SlyYGKkBJoWGPhOhoYJAyiw=;
        b=Mx0Izx+dLcAQUBj1xLzvAffGpii7glWn3UX+QDziUfgkt89XO9p2bE2Qn2r8LHQGKP
         6SkvkdsujNj2pwyq6qni9IZuEHn41gYNlcD76qz8t+NWMGbLvU0WK4YEKqIQmBvTZA1T
         Zl9Ox1mm+I2c5TvYwzClaKanuv2MSh6FJB4Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729195970; x=1729800770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBozDxQInUDVX/+SAvu1SlyYGKkBJoWGPhOhoYJAyiw=;
        b=fMu9bZlGHZupD1EGK0YG96mZTjgtilAKMukhLVEhNtLnslxugLsU/YaxCWpbEz4UOd
         fxDsGEPYLD4dczPL7gzCehjqcSDMrAtDtFomfyb3m4K/T3bjEoBI/V7Z2ncXWqqoe1mG
         ZlzGNW2bkAbr/wjtQyrGGpo9VKWLIs9of5UMW6KJTd/eofmt2CYJSrUn8X//eWl/EAKp
         OXb2MiUJhJxrdJX1J33VE1SH0YJsaub+03LWSIbzXbfvAKM1rQx/wfbpn2uPIj3VAgeD
         9TV0MkJl/0X7E5L99BGaKEfrYtoC0oENPacsvEyRe4+LZBhiwxNdhhM94Uo/IlSfDpM0
         HF4w==
X-Forwarded-Encrypted: i=1; AJvYcCVQt9Fi/o6kWmZITrfP0tq3/R1PE93qSrqm8xkGqHX/TVLG7r0Ugfn2239aE0tUtEFQxfaS2RRbTi/qi0uZHRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxqSHfy4sCOjM4bz2IMgNmfo3ZEa2RF/8yqCrEssgXqeOyohrn
	4K9iEHbYv/Yhxe5EXy0qNQeDvp7054Yfqbc18jMAray8pRnSTy2T6nNCjNz24dl7TtgW/he/lC4
	wVvO20e0LUV9Ir8qFP1G7GvxfuIqyQygCWKrv
X-Google-Smtp-Source: AGHT+IHMKwVD92dy+ne41XM8ABFquxk2pbEXlPTudUpzl7Zpa7r8kMniYucLBIkvG/gwVEopvNNS96zlSIhybkKunA0=
X-Received: by 2002:a05:6402:348a:b0:5c9:879e:6998 with SMTP id
 4fb4d7f45d1cf-5ca0ac44384mr2981a12.1.1729195969744; Thu, 17 Oct 2024 13:12:49
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017022627.3112811-1-jeffxu@chromium.org> <3a1bbbdf-1281-4f44-857d-58cba583e3da@lucifer.local>
 <CABi2SkU2yX_Pbr6=6uEiQnro88O5Mhq3NLwOsy=A=Qa5xeC6Yw@mail.gmail.com> <zcizwa4wasrq5si6nsjvougg2lt2dklaujpshdmghwg7oejhlj@zxzqhyff4vba>
In-Reply-To: <zcizwa4wasrq5si6nsjvougg2lt2dklaujpshdmghwg7oejhlj@zxzqhyff4vba>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 17 Oct 2024 13:12:36 -0700
Message-ID: <CABi2SkWBFZkWxDPnc6g2odvvNuMQqL4wQcbQSN2cTow2JLMKJw@mail.gmail.com>
Subject: Re: [PATCH] munmap sealed memory cause memory to split (bug)
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	keescook@chromium.org, torvalds@linux-foundation.org, 
	usama.anjum@collabora.com, corbet@lwn.net, Liam.Howlett@oracle.com, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, jannh@google.com, sroettger@google.com, 
	linux-hardening@vger.kernel.org, willy@infradead.org, 
	gregkh@linuxfoundation.org, deraadt@openbsd.org, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 12:14=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail=
.com> wrote:
>
> On Thu, Oct 17, 2024 at 09:20:20AM -0700, Jeff Xu wrote:
> > On Thu, Oct 17, 2024 at 1:18=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > NACK. Greg's bot got to it but...
> > >
> > > As per Greg's bot, no signed-off-by line.
> > >
> > Sorry for confusion, I wasn't meant to send this as a PATCH, but
> > reporting the issue.
> > The diff was just sent as reference to repro the bug, and I forgot to
> > remove PATCH from the title. I apologize for the confusion.
> >
>
> Can you explain what the issue is? I don't get it.
>
The issue is there is one VMA that gets splitted after an unmap call fails.
Two splitted VMA share the same attributes. e.g.

- Allocate 12 pages (0-11).
- Seal middle 4 pages (4567)
- munmap (2345) - this will fail due to 4567 being sealed.

The VMA for page (0123) is split as 2 VMAs (01)-(23), those 2 VMA
have the same attribute, and should be merged as one.


> --
> Pedro

