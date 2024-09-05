Return-Path: <linux-kselftest+bounces-17210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E8596D624
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 12:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35EFD1C22369
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 10:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93018194125;
	Thu,  5 Sep 2024 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxugF+tI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CA91EBFEC;
	Thu,  5 Sep 2024 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532349; cv=none; b=K9fBZwNS+MJo5x7hsoSjo5v4MOw2EdLc6s3VMfTMvVYt/44QjvOcI3BJF5oejcjPwhFCGrQrT9RBlFQSPMQg/bxJb6j7OaASl8UFE/mNXuOA4IPoyCFXPpDERoER5MnP5a0zazQuMj+ywZ3puOUhfBJJdJiT4gyIyI8oTbKVguk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532349; c=relaxed/simple;
	bh=xlNr4tLgdjuXyQS+F30A95mPCNRvaUl7/UIv5aWlG2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZF9yd4k0XBCStH1QpZFfd731cAIcLHh3y2jxotMUGO/vvA6yALWtUYM9Q81MHTgRP5YQwADSthbJ4OSo31RJVTrGmjdWDIsDXKlpxDdmDNl2L+//ipQ9MHBkG+llR44VWrs7KnAlLczFP7v2iW61iRFRCw95TM41dt18lg5DAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxugF+tI; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-39fd6a9acb6so1944585ab.0;
        Thu, 05 Sep 2024 03:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725532347; x=1726137147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TroQIzNqEjxBCseUHru6LValsIoM+uwDabvjlwAU0aU=;
        b=lxugF+tIQmFNjQddEmi+zg3mwXX00f4soJcXtTXGuxnbrCnq6a5H8VIY7GTCo29D9G
         9j6Yck6+9Oh1OIHevn0VT7eBAXk3jhhiIXo/MK64sMsLebG7+gZV7S/leumyS89BSHiN
         jBLl1X3sDMeGWmitMOYsSPWdzPNLUqxfWvI5kWCxxbMNEwOFcIllxLV3H1tFqltFO/67
         AI66CgDmBCMsN4WupsnEarFUIexCSN5HW06DrPqvMCYd70T7zYlwZGCxBDlu3o89h8G7
         XvqTsxCsskxqSn0GzLw9j+OemIP/xT8FkbzK+bBmD7nFkJCIRDHEa5KQV9iQpCTFsF7J
         eibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725532347; x=1726137147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TroQIzNqEjxBCseUHru6LValsIoM+uwDabvjlwAU0aU=;
        b=ITpLLeCyWHeziUbNXjd+hp/R/IDprb8/Nbxs7VYu0mNGOuhnXY9nE9LkD5yTFxWBFy
         JLveqmKJ2b9bxvdYZgeOUO7RiuPPwL3GQOh85ydTrJv4MRT+3lL9FPvj6IJretaE3Swd
         79TpF1aqpzPNfRIQQ13Htiqcrrgzcu+Qv1l+1AVG1IMH3sAEt4ZHNYulARhL255XiPZU
         FVLYZq8snmQojGmNorVzYKRtyTV076kZ+tkIqDa22kuZ3lM8594O3CuMtDMNpxVoh30m
         4RfMidmirRVSyM3HA3m9luBbRo+mSf8dj+uKbkNcnbZW/1dhVc827nY2ufjELzRiOF/5
         hVnA==
X-Forwarded-Encrypted: i=1; AJvYcCWCcLwvF84oJdTT+NTi+ylmJNvrjUNAeogcE6KfdX0wigUKVoRGSRVXMtgT3I0czCyowmwJwF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyojIu0mPEh6o6vYZxpvMzX8Baqz6e7XWUTWC5BP6of4iBaje9H
	KrCVwcU2quRBF52RjPbJ1kf2hOJET6ihtXdS1b2kdP7wP5lEBNaTht50Olg+piR4JSwW2vloOCp
	SwJDY+0Lb9wVm0E5KIdH+I16BUDY=
X-Google-Smtp-Source: AGHT+IGsw50fSVhSbmOZK+hG7nhnE6/A/2RRUbvmSjqarB5F8eiBODLZQLQD/odeGv29NKwS3w5U3Bbwzedfk9DBj+k=
X-Received: by 2002:a05:6e02:1fc2:b0:39d:25d8:43a9 with SMTP id
 e9e14a558f8ab-39f6a892175mr130716495ab.0.1725532347223; Thu, 05 Sep 2024
 03:32:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905071738.3725-1-kerneljasonxing@gmail.com> <20240905071738.3725-5-kerneljasonxing@gmail.com>
In-Reply-To: <20240905071738.3725-5-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 5 Sep 2024 18:31:51 +0800
Message-ID: <CAL+tcoBQLSeYfK-5F3wFDPNHOkLOGfn=fZiqgCmTLH37frd2aQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/4] rxtimestamp.c: add the test for SOF_TIMESTAMPING_OPT_RX_FILTER
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	shuah@kernel.org, willemb@google.com
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 3:18=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Test when we use SOF_TIMESTAMPING_OPT_RX_FILTER with software
> or hardware report flag. The expected result is no rx timestamp
> report.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  tools/testing/selftests/net/rxtimestamp.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/tools/testing/selftests/net/rxtimestamp.c b/tools/testing/se=
lftests/net/rxtimestamp.c
> index 9eb42570294d..9760abdb6e05 100644
> --- a/tools/testing/selftests/net/rxtimestamp.c
> +++ b/tools/testing/selftests/net/rxtimestamp.c
> @@ -57,6 +57,7 @@ static struct sof_flag sof_flags[] =3D {
>         SOF_FLAG(SOF_TIMESTAMPING_SOFTWARE),
>         SOF_FLAG(SOF_TIMESTAMPING_RX_SOFTWARE),
>         SOF_FLAG(SOF_TIMESTAMPING_RX_HARDWARE),
> +       SOF_FLAG(SOF_TIMESTAMPING_OPT_RX_FILTER),

Ah.. I missed adding SOF_TIMESTAMPING_RAW_HARDWARE :S

I'll repost it in 24 hour.

>  };
>
>  static struct socket_type socket_types[] =3D {
> @@ -97,6 +98,16 @@ static struct test_case test_cases[] =3D {
>                         | SOF_TIMESTAMPING_RX_HARDWARE },
>                 {}
>         },
> +       {
> +               { .so_timestamping =3D SOF_TIMESTAMPING_RAW_HARDWARE
> +                       | SOF_TIMESTAMPING_OPT_RX_FILTER },
> +               {}
> +       },
> +       {
> +               { .so_timestamping =3D SOF_TIMESTAMPING_SOFTWARE
> +                       | SOF_TIMESTAMPING_OPT_RX_FILTER },
> +               {}
> +       },
>         {
>                 { .so_timestamping =3D SOF_TIMESTAMPING_SOFTWARE
>                         | SOF_TIMESTAMPING_RX_SOFTWARE },
> --
> 2.37.3
>

