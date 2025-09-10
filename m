Return-Path: <linux-kselftest+bounces-41084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDE6B509F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 02:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EFEE7AB62D
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 00:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64FA1A3142;
	Wed, 10 Sep 2025 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="PAZaoO8F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274A819DF4A
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757464813; cv=none; b=CgERVhDVmALwClR2fXunMYdAZ2SaIbFGHtp3osNR6L1qbgulvZ+qh+MDi0BuPZtqkcbFaEf0vC7q/R00qP9zK3waAIXv4UyFP6MMBy1wiAOSenRANfMSuvDK/QAbU5+HOtCZq/rxdowMTDhqZuonymoa3Y52a/6/95CrFDgL3OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757464813; c=relaxed/simple;
	bh=7Cb5u7jncLcFhLiVnCTY8Y1qEYzK9rvuSJcpTxKvSS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxaoEISysEYn3bD3Oy9p/p7Mvc0OQpPgt9szZtccRHAdQtiojl+DKorDD+WbN8R+2lM0Zu18wu/x42MyhFJKMFg9UwGkB7LOcbv/12cnvDKgu5Ek+wT9Lxuf1sCAEW4DBQH1apGmPV4o9SmCcUtTf2iiff3H9AQEs4ztVd/y6y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=PAZaoO8F; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77238cb3cbbso6567418b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Sep 2025 17:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1757464810; x=1758069610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mss6uQGd55J5igKePLGZ8MRE87EtXTRkrLicTbCnVC4=;
        b=PAZaoO8FupiaKyCAO3ep6QLCS18VoZoPvPU4IDivyLi5JRj9EpIuCMS5oqA5+eonqm
         KziMxJHUdNK/1HWzcnC/I9pEnijpkOa1iYPhfZdTjppte+BYNeN3n5i3xLOwNcPCXGJ4
         FBJyeeKZzblSHiMZSjbZzn8nHVwFFVRE0O/93d0jOhCPD/UsnaEP8Wekyg8EfDPIBzht
         JzLifi2EVWvm228Dnp0A57Ad08oFm6/q76Y5ALef+VhqVRz7SFt1CrCMR6bu7RWfiTzz
         xc7jeEgV/DcffCX36LbTfd7HiPBpPcBWHlmauFZj0dLky9LUEnaYC3OFWBrX6+bbx7nS
         G8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757464810; x=1758069610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mss6uQGd55J5igKePLGZ8MRE87EtXTRkrLicTbCnVC4=;
        b=BiwavGxjcaPmNIKkrWTJedShqX/t1UcR0kkt3w22aIM9gw5t9zaT4RvUmheIzvPHDh
         m+wP9SgkTTloy0TQvhn9hlLx4mGMPKirtYlNp+NxMi2tpAO0uFfrUZywb9CJbP0wW/GQ
         rLLhhDSjDhe1pi05lcSYU7dcOoDUYfcMMU2JO3Ool3JxDldefc7C7IwRzM5pR/cygr9U
         0igC+aclulhOIdaSnt8dfrSoy26Fv6kfv9KEOGAFgb4dwcS6yLp8Wpax54ngcWhxxf+K
         z6uJfuk0lYeFyRedJWQ+c/Sk2HZsl/MoQx/lESPOLrh6SriWxi0W8toT1NvPDkgVkR5M
         JuBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuf+ZlOSlRMu14tEqNik366UoYSwWRB03mb667lrhfDdWLBIw5bUp05mY0zIchFWv1eW0Kv0b71gWlm1Z2LAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO1mPs5jmBkp01W3Xwa3FfNVrzhfWcZu8sF6cRACigaHB3Wa5p
	VZ2XrV03BDUe3pEjGtL9Az3sgemeKp8y5Ff35YlRKRiXR1sNvFBqxxkgmzqTAdOn4M4=
X-Gm-Gg: ASbGncslHgdZ+FcuiW0ChjLYOBbc1R9QDMDo5XGaWxk6bZf+KpB241P7/Zu3NfC92y3
	7gMKDJnO38y+X2qAODGG/CcZYRDtac3atB6QXI7z1nNNTCIvbccoYjS3vuWOk9+3752a7BgmBEu
	8s/pvPPEZmc8rA8FLTGK+Dok8PKP01R+3d7HRMD0lGBH8/DRVf7Ljh4LmiPmCGD+FYZdv5Ne76H
	Rk2YWB3xJsF5rItC6Bo6FMH5cRgCkoVhAkRWoziWqcOXKoTF8ewigMK5xpULCBawxY88yA9Oo6U
	0y+F1wld0JbHf089s7IrH3CmgZ6T47BrdAhVJ8vahMKPG9NlNUbelBkcBnOUDbmxChWv/ztt2XW
	goR+iX9buoJegL26jlim/WsNf
X-Google-Smtp-Source: AGHT+IHSK5EEmR6TBrosEOEhDl6rDkA2E4ZqWIoCbjjkEo/IjzID4OBobJs2anobHQNRGAw2j2+pcA==
X-Received: by 2002:a05:6a00:928c:b0:772:337e:3090 with SMTP id d2e1a72fcca58-7742ddaddf2mr18533500b3a.4.1757464810474;
        Tue, 09 Sep 2025 17:40:10 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774660e67cbsm3247520b3a.6.2025.09.09.17.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 17:40:09 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:40:06 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	david decotigny <decot@googlers.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	asantostc@gmail.com, efault@gmx.de, kernel-team@meta.com,
	stable@vger.kernel.org, jv@jvosburgh.net
Subject: Re: [PATCH net v3 1/3] netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Message-ID: <aMDI5hY0BH2iSkdt@mozart.vkv.me>
References: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
 <20250905-netconsole_torture-v3-1-875c7febd316@debian.org>
 <aL9A3JDyx3TxAzLf@mozart.vkv.me>
 <frxhoevr2fd4rdkhiix4z2agnqaglf4ho2rj6p6ncjwmseplg7@gknjhh23px4o>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <frxhoevr2fd4rdkhiix4z2agnqaglf4ho2rj6p6ncjwmseplg7@gknjhh23px4o>

On Tuesday 09/09 at 07:05 -0700, Breno Leitao wrote:
> On Mon, Sep 08, 2025 at 01:47:24PM -0700, Calvin Owens wrote:
> > On Friday 09/05 at 10:25 -0700, Breno Leitao wrote:
> > > commit efa95b01da18 ("netpoll: fix use after free") incorrectly
> > > ignored the refcount and prematurely set dev->npinfo to NULL during
> > > netpoll cleanup, leading to improper behavior and memory leaks.
> > > 
> > > Scenario causing lack of proper cleanup:
> > > 
> > > 1) A netpoll is associated with a NIC (e.g., eth0) and netdev->npinfo is
> > >    allocated, and refcnt = 1
> > >    - Keep in mind that npinfo is shared among all netpoll instances. In
> > >      this case, there is just one.
> > > 
> > > 2) Another netpoll is also associated with the same NIC and
> > >    npinfo->refcnt += 1.
> > >    - Now dev->npinfo->refcnt = 2;
> > >    - There is just one npinfo associated to the netdev.
> > > 
> > > 3) When the first netpolls goes to clean up:
> > >    - The first cleanup succeeds and clears np->dev->npinfo, ignoring
> > >      refcnt.
> > >      - It basically calls `RCU_INIT_POINTER(np->dev->npinfo, NULL);`
> > >    - Set dev->npinfo = NULL, without proper cleanup
> > >    - No ->ndo_netpoll_cleanup() is either called
> > > 
> > > 4) Now the second target tries to clean up
> > >    - The second cleanup fails because np->dev->npinfo is already NULL.
> > >      * In this case, ops->ndo_netpoll_cleanup() was never called, and
> > >        the skb pool is not cleaned as well (for the second netpoll
> > >        instance)
> > >   - This leaks npinfo and skbpool skbs, which is clearly reported by
> > >     kmemleak.
> > > 
> > > Revert commit efa95b01da18 ("netpoll: fix use after free") and adds
> > > clarifying comments emphasizing that npinfo cleanup should only happen
> > > once the refcount reaches zero, ensuring stable and correct netpoll
> > > behavior.
> > 
> > This makes sense to me.
> > 
> > Just curious, did you try the original OOPS reproducer?
> > https://lore.kernel.org/lkml/96b940137a50e5c387687bb4f57de8b0435a653f.1404857349.git.decot@googlers.com/
> 
> Yes, but I have not been able to reproduce the problem at all.
> I've have tested it using netdevsim, and here is a quick log of what I
> run:

Nice, thanks for clarifying.

I also tried reverting a few commits like [1] around the time that smell
vaguely related, on top of your fix, but the repro still never triggers
anything for me either. I was using virtio interfaces in KVM.

The world may never know :)

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=69b0216ac255

> 	+ modprobe netconsole
> 	+ modprobe bonding mode=4
> 	[   86.540950] Warning: miimon must be specified, otherwise bonding will not detect link failure, speed and duplex which are essential for 802.3ad operation
> 	[   86.541617] Forcing miimon to 100msec
> 	[   86.541893] MII link monitoring set to 100 ms
> 	+ echo +bond0
> 	[   86.547802] bonding: bond0 is being created...
> 	+ ifconfig bond0 192.168.56.3 up
> 	+ mkdir /sys/kernel/config/netconsole/blah
> 	+ echo 0
> 	[   86.614772] netconsole: network logging has already stopped
> 	./run.sh: line 19: echo: write error: Invalid argument
> 	+ echo bond0
> 	+ echo 192.168.56.42
> 	+ echo 1
> 	[   86.622318] netconsole: netconsole: local port 6665
> 	[   86.622550] netconsole: netconsole: local IPv4 address 0.0.0.0
> 	[   86.622819] netconsole: netconsole: interface name 'bond0'
> 	[   86.623038] netconsole: netconsole: local ethernet address '00:00:00:00:00:00'
> 	[   86.623466] netconsole: netconsole: remote port 6666
> 	[   86.623675] netconsole: netconsole: remote IPv4 address 192.168.56.42
> 	[   86.623924] netconsole: netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
> 	[   86.624264] netpoll: netconsole: local IP 192.168.56.3
> 	[   86.643174] netconsole: network logging started
> 	+ ifenslave bond0 eth1
> 	[   86.659899] bond0: (slave eth1): Enslaving as a backup interface with a down link
> 	+ ifenslave bond0 eth2
> 	[   86.687630] bond0: (slave eth2): Enslaving as a backup interface with a down link
> 	+ sleep 3
> 	+ ifenslave -d bond0 eth1
> 	[   89.735701] bond0: (slave eth1): Releasing backup interface
> 	[   89.737239] bond0: (slave eth1): the permanent HWaddr of slave - 06:44:84:94:87:c7 - is still in use by bond - set the HWaddr of slave to a different address to avoid conflicts
> 	+ sleep 1
> 	+ echo -bond0
> 	[   90.798676] bonding: bond0 is being deleted...
> 	[   90.815595] netconsole: network logging stopped on interface bond0 as it unregistered
> 	[   90.816416] bond0 (unregistering): (slave eth2): Releasing backup interface
> 	[   90.863054] bond0 (unregistering): Released all slaves
> 	+ ls -lR /
> 	+ tail -30
> 	<snip>
> 
> 	+ echo +bond0
> 	./run.sh: line 39: /sys/class/net/bonding_masters: Permission denied

I don't get -EACCES here like you seem to, but nothing interesting
happens either.

> 	+ ifconfig bond0 192.168.56.3 up
> 	SIOCSIFADDR: No such device
> 	bond0: ERROR while getting interface flags: No such device
> 	bond0: ERROR while

