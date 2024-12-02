Return-Path: <linux-kselftest+bounces-22712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289E09E0D15
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 21:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB68161175
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 20:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1D61DEFC0;
	Mon,  2 Dec 2024 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKtWy9EA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A05E1DA31F;
	Mon,  2 Dec 2024 20:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733171963; cv=none; b=QN2ECvSoK0h8X67mmjvkgfN4knf/GIQc4nAmAzeYIUMZ6nMpZ0bV/x34XBgiF15WGkHj5LX7gWIPtC4aoD1oGA1yWCJDBA+3rxjtGIRT94DpCjglQRYrX9XKHRS9o/uApqaMttfae2jHr64GrlCkgx9MnqpYfpaOaeAo996+J/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733171963; c=relaxed/simple;
	bh=UexIPcOVmGVtDLsOPzsWm5VC6gwGUpKxpThJKXVNMmQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMw2EJhdWEoqKoBq+eO4d5vzDcj6DYH8nt4F2kH/LagX42ewpC/hg9RO1jLOEQcrtp+vigkBDKOvmQyfABiwbnTFxbxvScO0C9yJtbGXkOSv4K/IGkmNPzGT+SODUo3EYqvOfJcDQw6inUWUyiE96rT3ZFgL2MBXnEbYxtbuuw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKtWy9EA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a736518eso59429405e9.1;
        Mon, 02 Dec 2024 12:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733171960; x=1733776760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wPC2r+i+iAeBWO/IBUjUrbII91BfRRAgBAKLUzGncwU=;
        b=NKtWy9EAMRZvbSKITZqifHAk3fIo3I2lgEc+8A59wM1pboiSu1+PlfeHDKLCdq9stN
         ICv2xWJxxJArVmcqwj3+nlH1nLT0GfFaW9C1Qvzd/Mcfr658ACXc00KTswqN/+gyY8yY
         0z8acO77asewseZ7ql1NxLIeqZcjjVrXdjb+lAf/US7lIFe665O0W+V3d8UOQNCOyE93
         6sK9w6q5+128J2LAA3nRHc8AhA+CHTjF0V+3XUonxvZjsRvKsFvec186VAoGk4EHCPKw
         AmeacP5CH507VxRL5VOT/nrxBArJr5lbaHt/mjfWcSh+0TGK6GTskaq7MPf9peiOS1Si
         IAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733171960; x=1733776760;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPC2r+i+iAeBWO/IBUjUrbII91BfRRAgBAKLUzGncwU=;
        b=JJXprV9xwdrgU45whJeTWbbCbJvoqywcA4a6jsdSTY3nVvOmh6WBu0Y/fElRQ6NcuS
         t8Axd4IskexwZQwMjyD+pIeMH5ScN9AAFvsIdRu+UPSYMBnDuCMvJvzfesp4cbhckMcG
         M1+3a3bvKKgKHF5xYtEHrrPQyZcJ2hPwiJfK044iDoIt7j77nFYUPSi4akIuy0VlD60G
         XDrXN0q9P0tBfJ7muXRdeiSqWBP/+J7qjSjYhM/xyXjObO6QuuQT1Uj4kNRNvu2409tm
         qPIoRCeCE1nuE4iqdvD/kyZzZ/nDuzGdj5glzbF0Bwmr6mTN3BJXciNnlayVcnQmXhx5
         fAMA==
X-Forwarded-Encrypted: i=1; AJvYcCUzizjj5ZwRxM4j2piyFvEo5VV2AqlggzPi0vvbaEP8yeOP7eJ2OaBupCH5ZRpOYSE6nDcGupigWUkhcBI=@vger.kernel.org, AJvYcCWALj1Tgqfqb+ItvCTTnx1irgTWNcWFW/Q1hP5zVJ/ScR9/wP2MHg7xeHz+J9PcShVRqOtkcgYO@vger.kernel.org, AJvYcCX/T6cL8i8VeaahO0u93EmtoEBo1uljHyXnVDRTvDyg+RWShhW8UgTWlOXcg4jd4hnst4kGrW1N@vger.kernel.org, AJvYcCXCqp/99lJC+uawEHWrJNII4M5+cBo35HqZEiQbCUC+NoQIjVfhkEuwq83QEqm4OLe879l8PHi/6X7+QI4aZU9J@vger.kernel.org
X-Gm-Message-State: AOJu0YwGQgJ6ZABCmA68DBKQJ5FZOL2JtrnMlQ/MPzpIWfbbeKb6QPMI
	fTz0rTNZEQuAYHrqfzSgIVVrmN3hFDOvOrzC7mlv4Qg0AfMaldz6
X-Gm-Gg: ASbGncsm9KPAYOK4dyT0FFg3fxMYVcleDwKb2REo//mtx5GbrqjeA5CM2vbsFmlADfr
	LZsOJjYzMxuMLvvTBmZmwVgUKR39I6ucMUaDMabGQ0MgjF211wxZzeWGuhBSiKTadfBtjaV+/wc
	YFEsS5bz4PNrdw1Nub3t3HJNdecpbSg8GfRFhKNsKNM6+ph3v7tM/JT4uyf+bqUAP/eIEHO59Hb
	OGarcKKshG+AQEoSCNrTKcbUu3qD2RdDDpr1YoeYltq2u34oR+DY7zcZKnUy0RYL3D0bQ/giXKh
	KawPwA==
X-Google-Smtp-Source: AGHT+IFahAlhCBi3m7m9fmhDH9u9C/eQnZ+mRYYsnEkCqBZQga5HZs0ZtIB4FdzPU83TXn8xyQASWA==
X-Received: by 2002:a05:600c:314a:b0:434:a684:984 with SMTP id 5b1f17b1804b1-434a9dbb5f4mr280129555e9.4.1733171960116;
        Mon, 02 Dec 2024 12:39:20 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f70d91sm162900245e9.39.2024.12.02.12.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 12:39:19 -0800 (PST)
Message-ID: <674e1af7.050a0220.3799ad.fa5e@mx.google.com>
X-Google-Original-Message-ID: <Z04a835dybKlDLGR@Ansuel-XPS.>
Date: Mon, 2 Dec 2024 21:39:15 +0100
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
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130154840.lv4rmor4dv66cctf@skbuf>

On Sat, Nov 30, 2024 at 05:48:40PM +0200, Vladimir Oltean wrote:
> On Sat, Nov 30, 2024 at 04:46:14PM +0100, Christian Marangi wrote:
> > On Sat, Nov 30, 2024 at 05:43:07PM +0200, Vladimir Oltean wrote:
> > > On Sat, Nov 30, 2024 at 12:33:09PM +0100, Christian Marangi wrote:
> > > > If the coreutils variant of ping is used instead of the busybox one, the
> > > > ping_do() command is broken. This comes by the fact that for coreutils
> > > > ping, the ping IP needs to be the very last elements.
> > > > 
> > > > To handle this, reorder the ping args and make $dip last element.
> > > > 
> > > > The use of coreutils ping might be useful for case where busybox is not
> > > > compiled with float interval support and ping command doesn't support
> > > > 0.1 interval. (in such case a dedicated ping utility is installed
> > > > instead)
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 73bae6736b6b ("selftests: forwarding: Add initial testing framework")
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > 
> > > Do you mean the other way around? that the busybox ping is the broken one?
> > > And by coreutils ping, you actually mean iputils ping, right?
> > 
> > Mhh no busybox ping utility is problematic only if FLOAT INTERVAL is not
> > enabled (aka 0.1 interval are not supported)
> > 
> > Yes I'm referring to iputils ping. With that I notice args are wrongly
> > parsed... especially with the -c option.
> 
> But isn't iputils ping what everybody else uses? I'm confused. I have
> this version and the current syntax is not problematic for me.
> 
> $ ping -V
> ping from iputils 20240905
> libcap: yes, IDN: yes, NLS: no, error.h: yes, getrandom(): yes, __fpending(): yes

Mhh the problem seems to be -c 

Let me post some outputs...

root@OpenWrt:~# ping -V
ping from iputils 20240117
libcap: no, IDN: no, NLS: no, error.h: no, getrandom(): yes, __fpending(): yes
root@OpenWrt:~# ping -c 10 192.168.1.1
PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=0.102 ms
64 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=0.084 ms
64 bytes from 192.168.1.1: icmp_seq=3 ttl=64 time=0.236 ms
^C
--- 192.168.1.1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2080ms
rtt min/avg/max/mdev = 0.084/0.140/0.236/0.067 ms
root@OpenWrt:~# ping 192.168.1.1 -c 10
ping: -c: Name does not resolve

As you can see swapping the ip cause this "Name does not resolve" error.

-- 
	Ansuel

