Return-Path: <linux-kselftest+bounces-33346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF79BABC85E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 22:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787BC1B64C33
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 20:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637DE2165E9;
	Mon, 19 May 2025 20:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEnJZOYJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D289E2135D7;
	Mon, 19 May 2025 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747686415; cv=none; b=cIrKUvLvatUqoEHok8H9ZdphFQr23F0ZTZQUel3+9HrGBJDHIytxLGY0zAn7LR9Ghtjlv3C3Qj0v6hhCMB3UXJbjczhm6vnShp5u64wyu91x+IbtQ4hwdYy5sNrEJyHnerP5ha9V8YaA9dkJpHEz66yKrA4DIf897FKA8LawdIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747686415; c=relaxed/simple;
	bh=Xfgi/huhRD3QKFohIyYcC2vXun+kKeP4iFdyd7cNWwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/2rLcDHJ0MmRB1t8Y7EV9akyDwpG86gqTCef5x+8VRSzQu3q++CyLELbFz2kIfpwfpaAZdDCW9HbxeTF0ItP4OT18LBqfE6IJlkbV0v2N8uRAIsAiCOaOsHfMdGfBN2cEOgcCCBDtNVZC4QrscQ10HaHmQanxtaviG8NtfeAaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEnJZOYJ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af5085f7861so3205442a12.3;
        Mon, 19 May 2025 13:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747686413; x=1748291213; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dTkaky/nRg9EbtmKa6hM+RsjLSVrfB0T6dQZXKXV1eg=;
        b=XEnJZOYJ5uz92JZEVCmjQoVppA5w5I1fyM0mBRHWEpvfCLV+y1MJTUAuKXVjNXhhCO
         hua7XbDV+jELl10lWU7jAcSqfoMqNLfSaGp9+udddawRutUzxds8/Yui9BnbtZ8jBtth
         5ZxkuVV6fUqNkqhX10uurqEb5iOzfLWgHyNg+lnZc8pxPmXfFM2egB75QWI5TZSjuUM3
         czwhEk4oXWwf0s8qte9ta59AJTXvat2m0MJN6dH24wQxjYp69FiSmxP7ah8DuSE6E+SI
         iVtB7NABa3fEFVyMW/nCBoG063keYsYnEO8rk0y5o5fyrZM6OIsRIwFJsMhYEuq5HZni
         VXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747686413; x=1748291213;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTkaky/nRg9EbtmKa6hM+RsjLSVrfB0T6dQZXKXV1eg=;
        b=DByvabV5vPKPM4QyxYdBdcK4xlr5Znd5xZUdrIjwcIF3ldXkF3f5kYBM3c4FxF0RHr
         LiFmomoqogapskwE0/GzSA7FFsROLyPUSiiV9k/Y+xQJrsnafb0SpAQHhRbiW6t0TMlK
         RMzocs8shHSACHf1k7yHjWDF92CU2gw86xg8SqikTBy+Wr/dIM0fh/jBl5Zq1NBI51fv
         vZkLzNKF1wr70TGoF6KdShCfPgXewX0pqvAqwqlj/thGolCa+zSO8vxsJTVFOxoGwtp2
         30+qqqUIk/dHSsUFNT8sYshZECmUPQdwJs8K2g44/CmR573FSzKFc2mmXJ5YqMa0rhkg
         ZCtw==
X-Forwarded-Encrypted: i=1; AJvYcCULGnmCzd04NAtdYF5n7E1Xmqr7lPOjtJpmfOVFe2rCoeKP+//NKwA+W24rktHcrZek21DmFCQt6RAKuEo=@vger.kernel.org, AJvYcCWBGIVbPAgjec0qLtuSR9wyGnUqpkwnse62I4HxdPAg1LMXIMPz+fpVq7onWZ2d/2ejVRhjfrxWhvSnFz3OrKYW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl+D7JSzOBRh13HSes00bLv1IjOQC/htdq3hOIHgBCiEkTat2u
	vR7TOYTCtYgX1p7IESv6LECN8aIoxOZ/SGJRxDz2DP2c0LFXDgzCAVw=
X-Gm-Gg: ASbGnctwujIt50G3E+KWLSziCLzErw/Uw17rRP3s+BlHtRn7XFZujN8caihl+szoLZB
	PzBj9Pg87Y+5oTb2zSHuPIGyiwJIalzHEeKffiHUKwNuiKjeW6Vl1L48Zc8sLnOQv9FCpLqAAKN
	k4hUf67qCz51SHNXJ3FkPg/Q819OQqKjXKxVUNvKxpJ6pvJu+uD87koo1HSBcCwDO9DrimquepT
	2mhdvoKpwkUYo7S3i9aBZwT78HBeM2AuhQGdHWc1S5WvzPP8jJ5/nz4WoCtMI79Zcgn98MGHtOG
	jRJ9dqeTPdT+9ep6Gcf664BiKi7L4fhlXWnij1k8zdYgMAxhNDdZTSpMCT4yaMLkPgQ5IpkLmbm
	MwdN5zQs2fYS6
X-Google-Smtp-Source: AGHT+IFUYkHuhjtDrVkEAjwa2HBW4fkXFodXqyRvW8H3uqxNuVa91mgNdEMV5UXY9aQSAx4RnxRuug==
X-Received: by 2002:a17:90b:1f90:b0:30c:52c5:3dc5 with SMTP id 98e67ed59e1d1-30e83216dc2mr17507550a91.26.1747686412885;
        Mon, 19 May 2025 13:26:52 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30f365b158fsm85644a91.8.2025.05.19.13.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 13:26:52 -0700 (PDT)
Date: Mon, 19 May 2025 13:26:51 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	sdf@fomichev.me, ap420073@gmail.com, praan@google.com,
	shivajikant@google.com
Subject: Re: [PATCH net-next v1 7/9] net: devmem: ksft: add 5 tuple FS support
Message-ID: <aCuUC7gGj4pzDO0R@mini-arch>
References: <20250519023517.4062941-1-almasrymina@google.com>
 <20250519023517.4062941-8-almasrymina@google.com>
 <aCtQIK-vFm6j6o9w@mini-arch>
 <CAHS8izOKZBtDQT7zjd81v8X5sAXB0NAsL8iXYg3_0zurwF1WhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOKZBtDQT7zjd81v8X5sAXB0NAsL8iXYg3_0zurwF1WhA@mail.gmail.com>

On 05/19, Mina Almasry wrote:
> On Mon, May 19, 2025 at 8:37 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 05/19, Mina Almasry wrote:
> > > ncdevmem supports drivers that are limited to either 3-tuple or 5-tuple
> > > FS support, but the ksft is currently 3-tuple only. Support drivers that
> > > have 5-tuple FS supported by adding a ksft arg.
> > >
> > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > >
> > > ---
> > >  .../testing/selftests/drivers/net/hw/devmem.py  | 17 +++++++++++++++--
> > >  1 file changed, 15 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
> > > index 39b5241463aa..40fe5b525d51 100755
> > > --- a/tools/testing/selftests/drivers/net/hw/devmem.py
> > > +++ b/tools/testing/selftests/drivers/net/hw/devmem.py
> > > @@ -21,14 +21,27 @@ def require_devmem(cfg):
> > >  def check_rx(cfg, ipver) -> None:
> > >      require_devmem(cfg)
> > >
> > > +    fs_5_tuple = False
> > > +    if "FLOW_STEERING_5_TUPLE" in cfg.env:
> > > +        fs_5_tuple = cfg.env["FLOW_STEERING_5_TUPLE"]
> >
> > I wonder if we can transparently handle it in ncdevmem: if -c is passed,
> > try installing 3-tuple rule, and if it fails, try 5-tuple one. This
> > should work without any user input / extra environment variable.
> >
> 
> This seems like a good idea, yes, but I think install a 5-tuple one
> first, and if that fails, try a 3-tuple one? 5-tuple rules are more
> specific and should take precedence when the driver supports both. It
> doesn't really matter but the 3-tuple one can match unintended flows.

SG!

