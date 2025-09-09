Return-Path: <linux-kselftest+bounces-41053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4A3B4FEB1
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 16:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C40B178702
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 14:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F907227563;
	Tue,  9 Sep 2025 14:05:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C7F219A8A;
	Tue,  9 Sep 2025 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426727; cv=none; b=Nbid1huvmeec1LUsvBhXbrbbRcysRQXgqRu7c0+6Y3C3gaAkZCXe84993WzTRpOVTSjifS+GQp1kRuncSWG4Ivi/iVeJ9MGhoW2nYEjgphXv+zqL5G6N6NcOkrgiJOXWm//fGgVzXDOYQg3InkYKEdvVuNUgaPXBa8yG7QokvPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426727; c=relaxed/simple;
	bh=Ef/o63fa0masGVW6LXLDrfhVG0E3d9qRlWy+TXcJK/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJGbOS17g6GCaJTZ1tH4IMyl5Gj7HtGTAPnySPd7LNPjzJabPkDIrL+aiAQbhqgpulhlOiWXYTyz/E76T65lo3INsQPHzmt5tjUUbs1TlkbKJwQGkFh0axyHSB8mJJPe89XGqgPmrMje8ztparWuOLc5maZF3H1HOPWH15StSYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0449b1b56eso830188666b.1;
        Tue, 09 Sep 2025 07:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757426724; x=1758031524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqchANUIGE/sj6VRIfAwwJ44T5VmasDpNHPpYvqds6g=;
        b=hKZR/rxZaBbGcm6530GkqbTrDQfrwPOyStD2PoiMGOT0PqLy3i3DYyk9Zl8sZc5VJO
         cLn7RZx8l6DGQFRDOlUo9uMp7sw2Gv8yOtLeK8XjnuVxMmIyz9BxgLjiDhrxrJLqiOYi
         IrOYLCGL280WC1HO3VpTK4euZp1tYihz1KZYxnhbNzdGJjqerpBzS2znPQEL9IEFoAsD
         UbILmwOj1Zd+U2WiISaZDHuqd8oHSGnLNoenr4O+MFD/XsyskhyBUvEYQSVfoLsNIme/
         SOlz4y4gk86sgKU9EALOUTFZjNthG9W6FjQtmC42mGwBKESMzfFI9XIrjgfNXqtvQumw
         YbNg==
X-Forwarded-Encrypted: i=1; AJvYcCVcfxYOPAmj1k0gbBHDEn+x+lJmfQlxJtUNc8dr6j4n6VdDwo33d1LYGoqpVXVAngbsxtT7jsOI@vger.kernel.org, AJvYcCVo2m7+AtHUPXF8RAwVmMAzQWYIMPDhtBWRwnK5nvqp8BvsNNL/LM8mIiKOoJUhScs2SovBulbVVyKA6Zo=@vger.kernel.org, AJvYcCW74FKMmJKBw3qI+SqrSA+c7kukPb3/5yqdCGItTVBIizqL1ncifP2JrlgHAT4cDs+BZuM2Zyz9@vger.kernel.org, AJvYcCWY7V4lVj/8AjxQGcrcHp8euJwy39H+ZHnKSVuwsOyuKevL1hkaNMp25I9ySoSHMEcYpgSNU9oLvTJb8f9KyLpl@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc6sscIHnU5f1uzBs1Esq5Abujfyf82G5YP+5d+IWHrgIAshFW
	P91mcTgxvlkQryVt0M7HVDTSG0dGWW/18RnQoBueC8PIQvryUBIhwGoP
X-Gm-Gg: ASbGnctt6UDgVCf7K6m8U1KvM3oGvzuImXyFdPY1TxWHWf2Vcrq5EFessZWC6eE8I+w
	L0+MCmIxusUQEfDXNBkTw13BTcZu4xkVarj7MHAv4lvA65Hu47yHysUGMntCKzsx+tUb4xGLQCy
	YADTo3JZZp6z3gC/7BYIT4kLkF5FBLV6vwuCW/kGKfYybIh+HkIPR3WxeBKF2uxJ3mH0AOObc0U
	k4ITpS3BohelWV73ry6UrysNcghuYSIi+8p1EZ/NCBpneuBOZSMEdpvH09DkPW5dGY1dTdOiOH/
	/PYRiqZQM4LkEv7InZSZhALfAYRO0Fk3BzxnfemKEMrUsHkD4P7+R2H6FrHJZHu4K161BJo8JGA
	FCowl58NSGaSMFZ44yEs9Fm+u
X-Google-Smtp-Source: AGHT+IGhqT2I7DdCypovpU7ZJAPVGBYA2DJkn7hBqzx4iz5C75D/6jcLz61ZT4q4xwwX5sS3AHf/aA==
X-Received: by 2002:a17:907:25c6:b0:b04:5895:fe8e with SMTP id a640c23a62f3a-b04b16c4aa5mr1005811966b.36.1757426723359;
        Tue, 09 Sep 2025 07:05:23 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b042fcae867sm2062997366b.58.2025.09.09.07.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:05:22 -0700 (PDT)
Date: Tue, 9 Sep 2025 07:05:20 -0700
From: Breno Leitao <leitao@debian.org>
To: Calvin Owens <calvin@wbinvd.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, david decotigny <decot@googlers.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	asantostc@gmail.com, efault@gmx.de, kernel-team@meta.com, stable@vger.kernel.org, 
	jv@jvosburgh.net
Subject: Re: [PATCH net v3 1/3] netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Message-ID: <frxhoevr2fd4rdkhiix4z2agnqaglf4ho2rj6p6ncjwmseplg7@gknjhh23px4o>
References: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
 <20250905-netconsole_torture-v3-1-875c7febd316@debian.org>
 <aL9A3JDyx3TxAzLf@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL9A3JDyx3TxAzLf@mozart.vkv.me>

On Mon, Sep 08, 2025 at 01:47:24PM -0700, Calvin Owens wrote:
> On Friday 09/05 at 10:25 -0700, Breno Leitao wrote:
> > commit efa95b01da18 ("netpoll: fix use after free") incorrectly
> > ignored the refcount and prematurely set dev->npinfo to NULL during
> > netpoll cleanup, leading to improper behavior and memory leaks.
> > 
> > Scenario causing lack of proper cleanup:
> > 
> > 1) A netpoll is associated with a NIC (e.g., eth0) and netdev->npinfo is
> >    allocated, and refcnt = 1
> >    - Keep in mind that npinfo is shared among all netpoll instances. In
> >      this case, there is just one.
> > 
> > 2) Another netpoll is also associated with the same NIC and
> >    npinfo->refcnt += 1.
> >    - Now dev->npinfo->refcnt = 2;
> >    - There is just one npinfo associated to the netdev.
> > 
> > 3) When the first netpolls goes to clean up:
> >    - The first cleanup succeeds and clears np->dev->npinfo, ignoring
> >      refcnt.
> >      - It basically calls `RCU_INIT_POINTER(np->dev->npinfo, NULL);`
> >    - Set dev->npinfo = NULL, without proper cleanup
> >    - No ->ndo_netpoll_cleanup() is either called
> > 
> > 4) Now the second target tries to clean up
> >    - The second cleanup fails because np->dev->npinfo is already NULL.
> >      * In this case, ops->ndo_netpoll_cleanup() was never called, and
> >        the skb pool is not cleaned as well (for the second netpoll
> >        instance)
> >   - This leaks npinfo and skbpool skbs, which is clearly reported by
> >     kmemleak.
> > 
> > Revert commit efa95b01da18 ("netpoll: fix use after free") and adds
> > clarifying comments emphasizing that npinfo cleanup should only happen
> > once the refcount reaches zero, ensuring stable and correct netpoll
> > behavior.
> 
> This makes sense to me.
> 
> Just curious, did you try the original OOPS reproducer?
> https://lore.kernel.org/lkml/96b940137a50e5c387687bb4f57de8b0435a653f.1404857349.git.decot@googlers.com/

Yes, but I have not been able to reproduce the problem at all.
I've have tested it using netdevsim, and here is a quick log of what I
run:

	+ modprobe netconsole
	+ modprobe bonding mode=4
	[   86.540950] Warning: miimon must be specified, otherwise bonding will not detect link failure, speed and duplex which are essential for 802.3ad operation
	[   86.541617] Forcing miimon to 100msec
	[   86.541893] MII link monitoring set to 100 ms
	+ echo +bond0
	[   86.547802] bonding: bond0 is being created...
	+ ifconfig bond0 192.168.56.3 up
	+ mkdir /sys/kernel/config/netconsole/blah
	+ echo 0
	[   86.614772] netconsole: network logging has already stopped
	./run.sh: line 19: echo: write error: Invalid argument
	+ echo bond0
	+ echo 192.168.56.42
	+ echo 1
	[   86.622318] netconsole: netconsole: local port 6665
	[   86.622550] netconsole: netconsole: local IPv4 address 0.0.0.0
	[   86.622819] netconsole: netconsole: interface name 'bond0'
	[   86.623038] netconsole: netconsole: local ethernet address '00:00:00:00:00:00'
	[   86.623466] netconsole: netconsole: remote port 6666
	[   86.623675] netconsole: netconsole: remote IPv4 address 192.168.56.42
	[   86.623924] netconsole: netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
	[   86.624264] netpoll: netconsole: local IP 192.168.56.3
	[   86.643174] netconsole: network logging started
	+ ifenslave bond0 eth1
	[   86.659899] bond0: (slave eth1): Enslaving as a backup interface with a down link
	+ ifenslave bond0 eth2
	[   86.687630] bond0: (slave eth2): Enslaving as a backup interface with a down link
	+ sleep 3
	+ ifenslave -d bond0 eth1
	[   89.735701] bond0: (slave eth1): Releasing backup interface
	[   89.737239] bond0: (slave eth1): the permanent HWaddr of slave - 06:44:84:94:87:c7 - is still in use by bond - set the HWaddr of slave to a different address to avoid conflicts
	+ sleep 1
	+ echo -bond0
	[   90.798676] bonding: bond0 is being deleted...
	[   90.815595] netconsole: network logging stopped on interface bond0 as it unregistered
	[   90.816416] bond0 (unregistering): (slave eth2): Releasing backup interface
	[   90.863054] bond0 (unregistering): Released all slaves
	+ ls -lR /
	+ tail -30
	<snip>

	+ echo +bond0
	./run.sh: line 39: /sys/class/net/bonding_masters: Permission denied
	+ ifconfig bond0 192.168.56.3 up
	SIOCSIFADDR: No such device
	bond0: ERROR while getting interface flags: No such device
	bond0: ERROR while

