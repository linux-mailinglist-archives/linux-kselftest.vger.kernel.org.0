Return-Path: <linux-kselftest+bounces-28018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEC4A4BAAB
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 10:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C30F3AD3E1
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 09:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305B71F0E27;
	Mon,  3 Mar 2025 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="dHwPO15f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D5D2E630
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993629; cv=none; b=ZBoqIHbFRVbhd0NhJ0mSTne2O6XazW1iEm73Ypj3iNB9gOrjzDdFLMCds0dB+62AsdZzDaEIasYopWETCUEsVNjGC/gO9M50UbS58+dhgxSR3jq5zb2G0cJJ8ku6gfdMI5IU9KieuWALVVdT+bVLrof/nZBXIeq7q/NJBlv0YyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993629; c=relaxed/simple;
	bh=0mkbi+pWV9lNgC4jdlK5EkBndlyRwDkcJnjagi0x4kM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=S8PgpMNJRObHFHTiU0pYH/8qdxIZDqmaO7sQqdJwAEiWqLYHTN75IzJ395ziTBHAcUxrbHnHzEzI3tO5osUijRmgZ0Z0/QVbGkpkbC80Mrapilnf53/2Drefxr0k0X2LCiBvF/ZfXeDXHO0HFb6OtonYeAikrekkPNC7rJpzzVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu; spf=none smtp.mailfrom=kragniz.eu; dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=dHwPO15f; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kragniz.eu
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-390e6ac844fso3691872f8f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 01:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google; t=1740993626; x=1741598426; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tn9NiVtrc/j1OIcqH+L0OnKwaHLUjUZ0cVMF/aqFASo=;
        b=dHwPO15fgz5KFpaGbGvG+Hg0woLiNPtusZ0Ta6EYfBoKtgVJlLeHWLrSINcDIGvJjm
         DrXgUWAQReGlfpr6lPMtgXrLv9gCK52rLpJcWaNd55Ti+n86ho3xREcSttbZL1M2IyLT
         2WW7DBLJ8Eo4zHLila3Uo7ZFtSyvxG61FYd3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740993626; x=1741598426;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tn9NiVtrc/j1OIcqH+L0OnKwaHLUjUZ0cVMF/aqFASo=;
        b=oXNbfZ0FUKk37aYpMD+wdoe2V4LhjyFtQnG54tEFA5nWs16Kvf+HV8McS8twzI9svz
         huHQZYquH7jIzrSBoTfsjTLORNLCmNOH5zCIER6P6FGkkp+1kS8Zifsj5bOBf6yuB/dH
         m0PfM8E4UnQvsZTOpTqdNBJpOPdfHWM0oZ89t34N1pXeMPEIdvFDwzfjrCon7uZqWx4v
         UGe1vqf+Ok6gscAH7Ua8g/duEv2JJ2L/jFs3iH7cmYLtec++7fxS592i+OuNCIB9BiTM
         Gv97TuqSX4/lqaebo+3j4ZvtPEcZWjN8bihwVRERTI1Jx7HFUvJxks/gUlR8h95oBuBQ
         6Teg==
X-Forwarded-Encrypted: i=1; AJvYcCVjeRCMIAI80hONQNZXqAIKJIYehwmsdxZTVlp9SMhJqtwGSiTLu4pZvOT532IuVKsgbZaSkf5GYI7cGviDSpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh6mnt6UQlly6maZ9fGT4OfjmNFIEsZNmSPJF01h6d/0KOhK3K
	pP/33CGqJzlnzRpTICDXcsHofq13bnE0qiTcYYvm0+U/g4rtjRhDouR1jDddPSg=
X-Gm-Gg: ASbGncsinrCQ5z+OsOIE7gjgKS8zPrP5owwaXyVFBvSXmDOdZkJXH46ksZ994xhGkR2
	XIYCo2AL9Ii3vxr7YllNf3WbmFAkfZcdqihftmcU6u344b7A7r/jEPfCQja7UalJYCJ4AmZk3y4
	Z2FdiTov4OC3SUjx0OP6Q03XYyNHAB5INSKueMkoOKah7YmMN8pEdL/4fsWM7ksUTqCymyzTODX
	YyFd38vVdp1kNvrPSdlLuxktpsD4AOfkzeCpAH5J72JAZbYOZJiJu44ynn4nBJQ1M+A6fc9zEo1
	jPfEBx7ThmFgUbHui4lPB5EeslEDWmPtN2X6mEpF+EBeu2bsCIZJ2x1i/yfksY7LEw==
X-Google-Smtp-Source: AGHT+IHpvVAe1hiW/Kg+NZizFxiZQdKOkluPFpQNOe4kEmLp/oqdczH77+lMwgOhbtWKNPNlqPrwWg==
X-Received: by 2002:a05:6000:20c7:b0:390:fe05:da85 with SMTP id ffacd0b85a97d-390fe05dc1bmr3970057f8f.16.1740993625669;
        Mon, 03 Mar 2025 01:20:25 -0800 (PST)
Received: from localhost (161.26.169.217.in-addr.arpa. [217.169.26.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba52b947sm181416395e9.2.2025.03.03.01.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 01:20:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Mar 2025 09:20:24 +0000
Message-Id: <D86IQDQZRN67.95DLK0YYQE1A@kragniz.eu>
Cc: "Willy Tarreau" <w@1wt.eu>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] tools/nolibc: add support for openat(2)
From: "Louis Taylor" <louis@kragniz.eu>
To: "Louis Taylor" <louis@kragniz.eu>, =?utf-8?q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
X-Mailer: aerc 0.18.1
References: <20250302202528.4169024-1-louis@kragniz.eu>
 <d0ed3b0d-4b7d-40cb-bbce-1f2a6605db7f@t-8ch.de>
 <D86I2TBQIPLZ.TCUUJWWM5DMO@kragniz.eu>
In-Reply-To: <D86I2TBQIPLZ.TCUUJWWM5DMO@kragniz.eu>

On Mon Mar 3, 2025 at 8:49 AM GMT, Louis Taylor wrote:
> > > +}
> > > +
> > > +static __attribute__((unused))
> > > +int openat(int dirfd, const char *path, int flags, ...)
> > > +{
> > > +	mode_t mode =3D 0;
> > > +
> > > +	if (flags & O_CREAT) {
> > > +		va_list args;
> > > +
> > > +		va_start(args, flags);
> > > +		mode =3D va_arg(args, int);
> >
> > mode_t instead of int?
>
> This implementation is yoinked directly from open() below. I have no
> opinions, but if it should be changed it should be changed in both
> functions.

Actually, maybe this openat function could just entirely drop the
varargs since compatibility is less of an issue, effectively going back
to the interface before a7604ba149e7 (tools/nolibc/sys: make open() take
a vararg on the 3rd argument, 2022-02-07) rather than copying the
current state.

