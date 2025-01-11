Return-Path: <linux-kselftest+bounces-24276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E2BA09FDD
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 02:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4F6188F7FC
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 01:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FDDD517;
	Sat, 11 Jan 2025 01:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDi6wDIG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67711634;
	Sat, 11 Jan 2025 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736557884; cv=none; b=jODETy/c5TAxE+bOchbB1jY1CqKDxfbvJFmFmoCzTKF6KK9bV2x2CgbZELdrDaJ45VxIONM0Rasnw2VybsmS7XY9PwZY3qiI5IUd2zMYF41rqRojf2ExFrT9xqiDU55cSBHvpCpbKJxwM+cD/hSNd3pW0YPkWXVZAl7M9nZcYrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736557884; c=relaxed/simple;
	bh=x9pp5BVE7VeV4mrB60HwswXEnE+44OKsQjFmxm4AWok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+W/7HC4+AZMxQkuzYChKt2p0+AvSf9UZ4BPq5wZXyeHXLq1pTgBUFQVXB2ToEHzM2Somk5gCONPPI164Zp4Pmqspdn9pa7HKInFAMN5Ff9EitSvuaYrdhwMcyg7j8qx7vTHLR/rtp02y/2iVIEUHJZnl9Dp64xNbflO4f/i2Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDi6wDIG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-216281bc30fso52651215ad.0;
        Fri, 10 Jan 2025 17:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736557883; x=1737162683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MPuHKL67WHXD8OeQ40CcPe/QjzzNKiTwVvyvmuioHQ0=;
        b=VDi6wDIGGdxmX4+/4Mfy4IDOOYLJ+uKtc2tk8v6BNTyMigEeK0LDCclbqm0XF22xua
         J7Oaincx+4flR3vY/nsOl+ZU7Hp6MXVoWxxyLdTWjD4/ILHJfPWksOAunrE7usFLHwiu
         iY4yvm6tDVRLxgCHUaL1TARwnSh/5Xf4ZyurA58MdIqrT+pVpPRM7/QjhFbFH9uy6y3V
         Z40LVf+0+pVZZwHEDZI9yD/3NHW6E90sOZrB3i/BqtZIr6C/RGQvsMb4S908eDYL04Jq
         Bw1kLUOikz9tT8YfwV8oz7kVBZtRoRadkzbdfKLCBmVdglJ32/fkywjie4SAtxN8OzCw
         7ZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736557883; x=1737162683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPuHKL67WHXD8OeQ40CcPe/QjzzNKiTwVvyvmuioHQ0=;
        b=pwBAOAxFtr3gVdsqXA4QaCle0ehuhshyevSYdXAGRahyz4JjdayG/LGxDIS7vq12c6
         YvAzt9aktc8ZtTk9X5syzBMFpj1RTqEXPd0+CDklrEyOTi1QSw+0C2haUkXxChpVpjpa
         J3rR3PrJEdEGCSYTusyRfUwLzUuKJw7mCiw3sHFLmUXxPxLhtaKqN9E0kmH0OC/j/WFh
         Gr03fsxQ3Vq1Qplw9Yc6bYbh4rU9HqiX5p5V6OKqFVexbQQHz7vkzhiRGxiywU3bODny
         F+/S/hwgQ2+DxL06DDQxoqsOEHDby3Bdx+xf4q43qqx14+0zXsrr3S8RzMTcFrCXvB5n
         SI+g==
X-Forwarded-Encrypted: i=1; AJvYcCVHlJd3WJbM4gTBvzPWW58Z4MHn/gFVVXsZkGx7nky7CWInpn0zuAVojbgBrTMmB1xwvTM7tEr9uZrs+dY=@vger.kernel.org, AJvYcCVMk4Lp4HCLQbi31LMyxF3pBzmAOQx92b+6e76ejrI282wCmgl2S5a2Fh0Fb4I3OjL/TL/7eBSc+WuqVOQh/JCi@vger.kernel.org, AJvYcCWExBqDFihE5O2zN+M8i+qH2gIzD6u0Mte7PwxQZhePXPMKL0db5tuTDCkTh18jd/C6CgAfn5FW@vger.kernel.org
X-Gm-Message-State: AOJu0YyJBEUg3klNV1SCw5jTt5JI3Kd+XcLVbPa6pON8vFaV0P+R8XmU
	+psKxMXSdYtQw6Ycv/RUbGxqf6knudCpChb9YrSna97rvWBp1buZQrSlujbqL4U=
X-Gm-Gg: ASbGncuXnF6rw7Y5ZFKUorPtWhThn/kf6udO5yW+vvrjYlqF293urFyQOZ/LI48CtBu
	TqdYKJRGBVDmD9E1QfmfV6HguF9OzSbUBMwH66EIfS73G8MkbjMDBxXtNcQvy2IVf8QKd+Suxv0
	ASZ3bzCfnePfhroyMNxkEgp5eNU7m0z2GJlFB/0zGp8Msr5YyCoWfTEqh6IyobNJzjiId+S5qQo
	T5I8ZuwtWMBoHMKmROhXfkjIY8XAsnmKwD0pgXkPfQBjXerpYE7Dyb4VopdyA==
X-Google-Smtp-Source: AGHT+IHz27b07CXUA/h7qCzkYFOjlo7VYpDzKlX/vB/GsvGODtjNxir6CdrG+5sggxTB7OPwNfmghg==
X-Received: by 2002:a17:903:2b07:b0:216:2138:3ed1 with SMTP id d9443c01a7336-21a83f526b7mr227068995ad.19.1736557882656;
        Fri, 10 Jan 2025 17:11:22 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10e2basm18681665ad.19.2025.01.10.17.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 17:11:21 -0800 (PST)
Date: Sat, 11 Jan 2025 01:11:15 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/net/forwarding: teamd command not found
Message-ID: <Z4HFM8V3VRQTfNm7@fedora>
References: <20250110000752.81062-1-alessandro.zanni87@gmail.com>
 <Z4CdYzmSn2cySE_h@fedora>
 <s564xh7c2xtmjz2cfwqq3zl4krjxiy4hqjeuvjpa6uhabcgvcb@k662t5irg2yi>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s564xh7c2xtmjz2cfwqq3zl4krjxiy4hqjeuvjpa6uhabcgvcb@k662t5irg2yi>

On Fri, Jan 10, 2025 at 03:35:23PM +0100, Alessandro Zanni wrote:
> On Fri, Jan 10, 2025 at 04:09:07AM +0000, Hangbin Liu wrote:
> > On Fri, Jan 10, 2025 at 01:07:44AM +0100, Alessandro Zanni wrote:
> > > Running "make kselftest TARGETS=net/forwarding" results in several
> > > occurrences of the same error:
> > >  ./lib.sh: line 787: teamd: command not found
> > > 
> > > Since many tests depends on teamd, this fix stops the tests if the
> > > teamd command is not installed.
> > > 
> > > Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> > > ---
> > >  tools/testing/selftests/net/forwarding/lib.sh | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> > > index 7337f398f9cc..a6a74a4be4bf 100644
> > > --- a/tools/testing/selftests/net/forwarding/lib.sh
> > > +++ b/tools/testing/selftests/net/forwarding/lib.sh
> > > @@ -784,6 +784,7 @@ team_destroy()
> > >  {
> > >  	local if_name=$1; shift
> > >  
> > > +	require_command $TEAMD
> > >  	$TEAMD -t $if_name -k
> > >  }
> > 
> > I saw team_create() has `require_command $TEAMD`. Is some test called
> > team_destroy() before team_create()?
> 
> Actually, the errors seem to raise in the "cleanup()" method.
> 
> So, first, during the test preparation the "team_create()" method is called
> and checks if teamd is installed. 
> When it fails and skips the test, the "cleanup()" method calls
> the "team_destroy()" that raises the errors.
> 

Thanks for the clarify.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

