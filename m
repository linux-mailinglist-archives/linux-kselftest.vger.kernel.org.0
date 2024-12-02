Return-Path: <linux-kselftest+bounces-22716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 635379E0DE0
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 22:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C63281D9D
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 21:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C10E1DF26D;
	Mon,  2 Dec 2024 21:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="detERBFD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DCC70800;
	Mon,  2 Dec 2024 21:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174978; cv=none; b=CUVBle1r07TsPRUHvUTFCb/uL/I2jCJBos9HRxkvStluXicDOC97vup3l6DUWo6k+V0DR+hk8ZMOvQl2jzopVjFdhxDbuY0G7Svu2od7nphpQaXRZztoZ88Qrup8lUMn9fOErXWXJZnMu5kcChJKURFDbz/+XgJmNIeeJ7fBtgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174978; c=relaxed/simple;
	bh=pA01rzy1p4KoYHbstqvJ68ET4WBA8g/7Ngoejgshz5I=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKAktzLQxmxRvIp3mTHAuYfswgSjmtGPPugZOaGlZIr+ZWfNhhuElSJUUeOV6k7Os6PN8J+SsPvIDKUWp/6nQJt72nPsDPJV7wwUVZlNIY4X8suyX4WlYU6Wk/OdI8v2w7ZsFpqVfBEtx2pcp9hse2qalXfk67lL6FAxkZ161jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=detERBFD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a95095efso33999555e9.0;
        Mon, 02 Dec 2024 13:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733174975; x=1733779775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tKXIynX3xTMREOQazrR7/7aFnk6WYKVc0ZZCHX0QziE=;
        b=detERBFDvRjL0GmXC36Kx6HIExF8g01taLbOCCTYHXEka+1ERS70xrcqM+XZ+xHmTJ
         aPnvVQEl750roEadzPNIiCvvoc3KJ97qBtalgIuFkfwZgggGBcWfpFLaKef0yOjutAVo
         +fHHkfjMCfb8pteroiStPnjElW2ak34Rs2IR5NcHpQMNJu2jposBk2WIXtBNnelOIrJC
         gCWHZJ/TJ5s61axp41dqukqHnLJia4FGZzks1FACNrv5t/OBL9vUHv34R/2AltmUWrNE
         l0XMyowiWmjmQr2REWglEV46qPlyWhkJ8qQ91Y3MbO9KEU2QBfg7xOw46XkLNRqgbWlZ
         RWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733174975; x=1733779775;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKXIynX3xTMREOQazrR7/7aFnk6WYKVc0ZZCHX0QziE=;
        b=DZ5owSuNa4HJnXQVApB5nsAlsYZ8lRl/RPln01EvNdAU01VO+dlJQkxOEX5MTNHeVP
         veZ4IoLwJrdNpgTVCS82yk8q4sBqqvupPE8sD21qzV11A8yNvUauAJs3lP0DfamnbKSY
         l0/wdzaQ40ZnhmwqzzQECHxCHqqSa8gyOuaXoY7L/x0j13J6Squ9X4D1I+yJFOKLvpGt
         f05mEnByzOOGwMvxoHiS/RdW83eFjS1hedpbabn1QdUXo/OlOjvuX+ksTvnRe5BH+HKX
         c3yjDEaqmfYWhdRmmmapkgFrqsa3DregIpVI4A5CV235wgJqHm/Xv2DMmI79JckXHy8y
         IQsw==
X-Forwarded-Encrypted: i=1; AJvYcCUBGgelhFOMJPW9nwvylEdEW8TbqXwJukDmjR+QDldmzacNRYAKbrAsCbefYU3XF4IeqHsZqS/J@vger.kernel.org, AJvYcCURYDYWENQJh9ARi8mwY7y7xyTycEGaTj7Jm0kj132+jbmCz17q6gxYW2o3380UmnLTVWhDNULjjQflofM=@vger.kernel.org, AJvYcCVtWyxbsGoSegDK8SPW44iY9A+IILbzg9/GJOXcTTolb5JbkvtuLR4WgCdwVnmjHxgENUNzfkNSsJQiS+/RMTZs@vger.kernel.org, AJvYcCXZ8yp10l8CZOr+mmm4nf6Z3d+DF/bCikiCBWrIUtW4BtKqSUeDCuTIU603cDkpds23aoOI7dXV@vger.kernel.org
X-Gm-Message-State: AOJu0YweNvEVHSkAJYw1YTIfio/5HjiLQJ+TJ2sI7qDuC5BYY1dUQ/AA
	yzOUuBHvMdBPWzg007je8cRQeQBI6Qz683vlkuNYoXudZOxVPXAL
X-Gm-Gg: ASbGncvrK1jkwTR2oOExQchuwo8Z7+rNkrUKsbKUXBRlJ6KZ6hwsEk794va6MzoyKyT
	l/zO6SZCYeqWlOrdGnrFV/p/P1kP2AZn4zVsW5K3LZ7b4sBHcIUJ4bcQycsTlu82LEivbIiBFDZ
	jPH+/cvOJBYkb9XxN4UNEHg/Ixe6LayNRsQta2ufnZezCbjJP0hDux2i0gTWpS2HPBxOFSJ+3sf
	M6bNxHLVIBj2POVgFQKpFrrg2Z2rIG0e+ugPKQS8gRkqNCMWMUPjpqJBuJTL/u36cAZ22/AnKh8
	wgbIiw==
X-Google-Smtp-Source: AGHT+IE0GakqyDv6Fa9rYiQgKyPq8ISDI8KMOPPMBCud5ED+86tSUc516+NQFl9HCZRAh39Mcsmn5g==
X-Received: by 2002:a05:6000:154e:b0:385:f349:ffe5 with SMTP id ffacd0b85a97d-385f34a030fmr4400876f8f.29.1733174975230;
        Mon, 02 Dec 2024 13:29:35 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbe4ccsm164404255e9.13.2024.12.02.13.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 13:29:34 -0800 (PST)
Message-ID: <674e26be.050a0220.2de4c9.13ab@mx.google.com>
X-Google-Original-Message-ID: <Z04mu7C4KDpKRhW6@Ansuel-XPS.>
Date: Mon, 2 Dec 2024 22:29:31 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [net PATCH 1/2] selftests: net: lib: fix broken ping with
 coreutils ping util
References: <20241130113314.6488-1-ansuelsmth@gmail.com>
 <20241130154307.cskk55ecltjkinqz@skbuf>
 <674b334a.050a0220.3b307b.ee8b@mx.google.com>
 <20241130154840.lv4rmor4dv66cctf@skbuf>
 <674e1af7.050a0220.3799ad.fa5e@mx.google.com>
 <20241202212429.n4f2ig6mx4fb27dz@skbuf>
 <674e2674.df0a0220.33ed66.d434@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674e2674.df0a0220.33ed66.d434@mx.google.com>

On Mon, Dec 02, 2024 at 10:28:16PM +0100, Christian Marangi wrote:
> On Mon, Dec 02, 2024 at 11:24:29PM +0200, Vladimir Oltean wrote:
> > On Mon, Dec 02, 2024 at 09:39:15PM +0100, Christian Marangi wrote:
> > > Mhh the problem seems to be -c 
> > > 
> > > Let me post some outputs...
> > > 
> > > root@OpenWrt:~# ping -V
> > > ping from iputils 20240117
> > > libcap: no, IDN: no, NLS: no, error.h: no, getrandom(): yes, __fpending(): yes
> > > root@OpenWrt:~# ping -c 10 192.168.1.1
> > > PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
> > > 64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=0.102 ms
> > > 64 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=0.084 ms
> > > 64 bytes from 192.168.1.1: icmp_seq=3 ttl=64 time=0.236 ms
> > > ^C
> > > --- 192.168.1.1 ping statistics ---
> > > 3 packets transmitted, 3 received, 0% packet loss, time 2080ms
> > > rtt min/avg/max/mdev = 0.084/0.140/0.236/0.067 ms
> > > root@OpenWrt:~# ping 192.168.1.1 -c 10
> > > ping: -c: Name does not resolve
> > > 
> > > As you can see swapping the ip cause this "Name does not resolve" error.
> > 
> > Ok, I opened the iputils source code and there isn't any relevant recent
> > change there. But it uses getopt(3), and that seems to be implemented
> > more simplistically for musl libc:
> > https://wiki.musl-libc.org/functional-differences-from-glibc.html
> > "musl and the POSIX standard getopt stop processing options at the first
> > non-option argument with no permutation."
> > 
> > On GNU libc:
> > $ ping 192.168.1.1 -c 1
> > PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
> > 64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=0.696 ms
> > 
> > --- 192.168.1.1 ping statistics ---
> > 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> > rtt min/avg/max/mdev = 0.696/0.696/0.696/0.000 ms
> 
> Well it's definitely that... As we use musl as glibc is BIIIG and won't
> ever fit 4mb of flash ahahha
> 
> Also I just notice msend suffer the very same problem...
> 
> root@OpenWrt:~# ip vrf exec vlan1 msend -g ff2e::0102:0304 -I lan1 -c 1
> Now sending to multicast group: [ff2e::0102:0304]:4444
> sendto: Address family not supported by protocol
> root@OpenWrt:~# ip vrf exec vlan1 msend -I lan1 -c -g 1ff2e::0102:0304
> Now sending to multicast group: [224.1.1.1]:4444
> Sending msg 1, TTL 1, to [224.1.1.1]:4444:
> Sending msg 2, TTL 1, to [224.1.1.1]:4444:
>

Ignore the last part about msend... just me messing around...

-- 
	Ansuel

