Return-Path: <linux-kselftest+bounces-24215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08473A093A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 15:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C6D1882A02
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 14:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001C1211282;
	Fri, 10 Jan 2025 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3nviM/P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEF820FABA;
	Fri, 10 Jan 2025 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736519728; cv=none; b=mknoa8G5ZCdrpO6Ae9k8J6VI1aQ1wA8YzTfmEuVyXz5luMpV3MKZAj5R3+w1u3eeOvwzL2q3reIuuLf3WT8yK/s3ZCNDR+mESX7UTFUemHXtIqF8yIf8+VH7Y5sqX0//CjJpHfxgy90T+BRzixHKd2cE617eUz4CfC2pgXw7fmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736519728; c=relaxed/simple;
	bh=VwZAwlQ05j9JCSRqtCgH/3hOTx/jyPGLqe03SRJTzpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFu9u8rywIVq3GkoVtTc4cI/2KNlCqNmiVWMxxzQABjqYZ6ChHH6J9R7Depe8tjbZQeXY+otdjiuMXjlyOv4S89Q4wyVP3f4tJCQsvQF7M2svruakdvLOwqTMn3b02eOfFvUxavKz+rQhPvWs6Is3GscJDhmakoPNO1GlvH2PsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3nviM/P; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3862f32a33eso995602f8f.3;
        Fri, 10 Jan 2025 06:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736519725; x=1737124525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nxjyU8yZswI0rAK4YmLu8c0WjZr5aARNDWVbS1xSnog=;
        b=K3nviM/PqDd124BK3prWBvCZr7xPBSPKVkd52o4Wgm1CTjDud0UMBLCPm1kIFmGxQB
         EhgKxSkqjascsmqxSDUdYSnMv9+U9EuA9ALpGw2JhEl5iKC+E7vnvjr7hWtgC646EYaj
         aAwyfqMv4YqdVtALTq8lFQsI+xoBr/QDLORsuAxelQgPSPd7RIo9vWk5OcnXxA+dfb0A
         DeWChA/xJHJBhaRPqCCsCLGgbk3msmu97R4eDc7RMMLK4dcCwMegKTbS+1Q3XIiAzU7S
         JXRe1rdaaH0JuC4l44gOIpR6zfE4X6cePNW34CxthKibdxalrxTpGIMhqWqz7PFmwkSA
         L9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736519725; x=1737124525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxjyU8yZswI0rAK4YmLu8c0WjZr5aARNDWVbS1xSnog=;
        b=fOYB8W/Du8t06m1tVHoAir8SIOvi2rLW/CXCrkKtQlDpcFm2CZbP0AvjtRJ30jW/4D
         scE/wFkXQoMKr0G1Of4ZoJq3VxcWgQjAcsfRSJ97o4vjW176JSIk+hsSzFOUMc/oQbZn
         GNwqTO9Q+d+tMTCd1/D1wXuRBW+iu/TwSFEJMGEv3g9RUAH2liPEyr/nT1k2qnbnared
         ILcN5a1cBY/pw/jzmsm2XcDLuU2vhpywN/4g3jUJQVNeQgywAyg9Uo7D+ay+4u04yzD/
         DNuvQnzDodQL/qT4WMBvGawejTmy+T16d5yLrDptBkLM7qjtpaco+5Cav3T2fOuwfmDI
         9kKg==
X-Forwarded-Encrypted: i=1; AJvYcCVtR6nLh0ldGU9whDDVQSBWkLJXk1jmoDe4551SnJL7VYJM7VDh4ilMRmRwXr1m6ImUQSuM6eni@vger.kernel.org, AJvYcCVuqMliUi+vxJVg6HRzid6MDcS2R5cmLsJLBYu9QmGLR2NkFsbxrvyXXv3Hv+XC229kbFq2a4FI3BsXiuMspeQW@vger.kernel.org, AJvYcCWLf8FSONWV+w/M6auL0oxQOIY9UMCCu5JZj98zfR7MuqXTy9xvoncwrDwb3/TBb2tZfolDdtDZnqcdhDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaXLDecXHSzAkmhUtBzwc37oFclAq3byZWF7m8xWOaKw/6pA2q
	x43wpGy+nKjuslIPB8Jgh7cgE/3L9W1mlkgIqwIpG/p+8e0vK5UZ
X-Gm-Gg: ASbGnctBYqD7CyZ5k8OkLGyqr3JUib9sxqY5oo5zqKeBNH9gtgGwuXuwDxSEVhpB0ms
	toujLMSk0K1UO94nRX4Hs3/fucRZ3DDiNLYJ3Zt2ZziKmpUyB8VqnYRl+kDxEgu6EDrg5WP++0M
	22snMQajKlQDHC99Yjj3fS++c63nwBb3gZAJXaDmL/Ind6zLU2otC46EANPFDDP4Tw381WM8PVj
	i1G71Cos7tuOgHjizjZ8+3lQKQg7KcVkkMth3vGieiHFCY8Ul41b4VzTsoraBdvXv9UlTa9qlkC
	dDZOTgL0NqiNlUP2Idur4B6hP0sgw5HX
X-Google-Smtp-Source: AGHT+IFzx2a/VwoogHps3IEtSZK03mUfkTAD/RdWr5SZo8aKa+CaHEX1W2HVTzEv2c338yV3wZlXyA==
X-Received: by 2002:a5d:648b:0:b0:386:3e3c:ef1 with SMTP id ffacd0b85a97d-38a87312f36mr11033177f8f.35.1736519725236;
        Fri, 10 Jan 2025 06:35:25 -0800 (PST)
Received: from alessandro-pc (net-2-37-205-162.cust.vodafonedsl.it. [2.37.205.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c6dbsm4773693f8f.55.2025.01.10.06.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 06:35:24 -0800 (PST)
Date: Fri, 10 Jan 2025 15:35:23 +0100
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/net/forwarding: teamd command not found
Message-ID: <s564xh7c2xtmjz2cfwqq3zl4krjxiy4hqjeuvjpa6uhabcgvcb@k662t5irg2yi>
References: <20250110000752.81062-1-alessandro.zanni87@gmail.com>
 <Z4CdYzmSn2cySE_h@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4CdYzmSn2cySE_h@fedora>

On Fri, Jan 10, 2025 at 04:09:07AM +0000, Hangbin Liu wrote:
> On Fri, Jan 10, 2025 at 01:07:44AM +0100, Alessandro Zanni wrote:
> > Running "make kselftest TARGETS=net/forwarding" results in several
> > occurrences of the same error:
> >  ./lib.sh: line 787: teamd: command not found
> > 
> > Since many tests depends on teamd, this fix stops the tests if the
> > teamd command is not installed.
> > 
> > Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> > ---
> >  tools/testing/selftests/net/forwarding/lib.sh | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> > index 7337f398f9cc..a6a74a4be4bf 100644
> > --- a/tools/testing/selftests/net/forwarding/lib.sh
> > +++ b/tools/testing/selftests/net/forwarding/lib.sh
> > @@ -784,6 +784,7 @@ team_destroy()
> >  {
> >  	local if_name=$1; shift
> >  
> > +	require_command $TEAMD
> >  	$TEAMD -t $if_name -k
> >  }
> 
> I saw team_create() has `require_command $TEAMD`. Is some test called
> team_destroy() before team_create()?

Actually, the errors seem to raise in the "cleanup()" method.

So, first, during the test preparation the "team_create()" method is called
and checks if teamd is installed. 
When it fails and skips the test, the "cleanup()" method calls
the "team_destroy()" that raises the errors.


