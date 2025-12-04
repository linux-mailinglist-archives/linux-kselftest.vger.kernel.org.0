Return-Path: <linux-kselftest+bounces-47047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BC4CA4BF1
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 18:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B3743070200
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 17:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266772F691C;
	Thu,  4 Dec 2025 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdlcMULK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154BD2DEA98
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764868922; cv=none; b=IbGLbml+MoO27083G7tMZ3JXavUUIuGNCwooY01LOpmKHzuN+y9CDOoVzTYDZi5ofvGShEKZPQjA1t0jJtqhcpDvaXpZrakYDvky6v3vv4LePiMKnznC7MKpECJ69lfCg3zmduzDaeegVa98PJ0X3zQIwvENpZzPVGbd/w9+6Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764868922; c=relaxed/simple;
	bh=D1LJURvCqBD19tHDb/ZAcUeEQGw9iRvK41XJcVnkOf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmfGCEyMEe6JGwJyJYB/cCnjG8DC7y5FacWrXEGO+A9pX5HHNPSneyvZ98+LosV/eIM3VgJv4IoWBZHLy5Qhrk+yJGxQiN0BuCMkVfaVCTt8d3yr6z45Hq3yg1awDnNVIQ+SwEEHsnKjaSVQc/prfiTL9pWzHPsx4PAbTwFc3+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdlcMULK; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso966586b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 09:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764868919; x=1765473719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJXfDszGjsCT48bZrhFtIknmAdGQdI9xd+KhNwA4Sp8=;
        b=IdlcMULKLoa/0qhG1kUDaIn9fc8R4Y9F1qVIKIy76hYA3gNl+1B70CS0Wttq6e+nK5
         iKpRoAL0RnYrJ0TezAmPE7Ar2qA2SQ/coXRLAr1LWGcpL+M82DedqP81LuL/WTz6Zw3j
         o/wleYEChKYWDDlIMYXFHO+LNak3s4fISubo22wDY72CTTBp1f2NOY4Vwgl8ZFsL0T1d
         re9B4p245pwaL2kBd78c5T3rwzvP5KYGHZ3LNL0AUYShqormGAApDLm4Y+ttNQ+8DPQi
         X8ama5stnsD1/NOgUuJNWgMSf7VTqpm16BcqwQMh42OocGNtL/F8DPJN0LtX7vKvC1Qu
         JW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764868919; x=1765473719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SJXfDszGjsCT48bZrhFtIknmAdGQdI9xd+KhNwA4Sp8=;
        b=Uq2t3poksKkt9yyeXh/CtH585gbwA6hnfF+SRwLSOf/akFRYBXUaoIEmc7OZnKaCDo
         P/PAD7H1YnKeBnL8ISKx/LGXpn/8FFm2DJW5U26H6pZPaK9OLPi0C0oKOjMIdj+1hoKd
         q6TFFFbpitDPvesPWz4v8TncfaC0AGX1MfKMwzVA7V8z86n/KCmC2QPQ6ypvwSnT/Z3/
         p+4sC4bvf6sFPbrjUpelh72lhLg2TZhzykBr1Fj5yCm1Ts/DnHuq2PGbHuvlapL5V4QC
         oQaCndrhPrcelrhLqJne48GeeOxEOLQZ5fvTavXowK+a2CvlqZOulSBqMqOA9qKxx8QN
         6SEw==
X-Forwarded-Encrypted: i=1; AJvYcCUNJacbzRXBoWjb82WgTtQOK/g/2wcKTbDOeMLD9e5sHECIn5cVM2Aiaaho/PuK3RGwHat2b1az8nCrPBZTUVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxptkltrTpBJ/n9/syzl0QAc1yLX0yXVA5ENEPL6rGT5DBffWsu
	a6Dcz7g3QgEqUEq+b7dpj7xVb7SpKxcFz1LR4MqBWxXTb5cublfazZbg
X-Gm-Gg: ASbGncuiQx3CstSfb8YZmMh7p3YkEW99P7OTHHwAg+J7zkrnLMudzsrHxRLGRpg6Rl8
	1USBquz6PdrVDe8VkMbwtWQqm5TikJyoDTan9X9ik3TrYVNSgiFkX4RXqisAvguoOf5hR8uc+/A
	qrf69amx808JZ4IY8/3lLtWjGv7qPQWe0fWE+qMjyR6qvmmAlhDI0+2oXxgr2CM4eI37ly1Au7+
	AIdorpuErtbluzbfjKZeZdGBCPJMnnmDmDgqx2XGy6sDSk/n/YE6gDeyTnskUIeGuLPHp/BVhK+
	90zotZzhuAZAQdMj6TSTyun6B+jglWJGRxts3f+IcsKuWPLfI2eiuQsU0PEuRzgTnQMQ8u9Wm+N
	CvIdzV85d7Dp4FLdAhEAcJ+Pi7CAXaFUhpTGG4mpnewlxPxuHMvi42Xpzm4S7kJQDmFupir4S4/
	AWeCJebp6EPurtGa7ZZ/IlQug=
X-Google-Smtp-Source: AGHT+IEZEurfwDNB61dWVp10IYOlyd6SF/U/w/lTzFcqv3k5XiH2udV6gEaIKRdEMzDFljcRgNTaNQ==
X-Received: by 2002:a05:6a20:3d08:b0:34f:7454:b98e with SMTP id adf61e73a8af0-363f5cf427bmr8613133637.4.1764868919140;
        Thu, 04 Dec 2025 09:21:59 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf681738a29sm2388211a12.3.2025.12.04.09.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 09:21:58 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Dec 2025 09:21:57 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: Re: [PATCH 10/13] selftests: net: Work around build error seen with
 -Werror
Message-ID: <7df3f306-1bf3-477e-990b-a76e2c2396ed@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
 <20251204161729.2448052-11-linux@roeck-us.net>
 <20251204083029.188cd7a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204083029.188cd7a0@kernel.org>

On Thu, Dec 04, 2025 at 08:30:29AM -0800, Jakub Kicinski wrote:
> On Thu,  4 Dec 2025 08:17:24 -0800 Guenter Roeck wrote:
> > -	write(fd, msg, sizeof(msg));
> > +	if (write(fd, msg, sizeof(msg)))
> > +		;
> 
> At least add an perror here ?

Makes sense. I'll do that in all patches unless someone has a better idea.

Thanks,
Guenter

