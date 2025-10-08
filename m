Return-Path: <linux-kselftest+bounces-42872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A86CCBC51D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 15:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D53C4F7729
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 13:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202ED276052;
	Wed,  8 Oct 2025 13:03:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C042727E5
	for <linux-kselftest@vger.kernel.org>; Wed,  8 Oct 2025 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928584; cv=none; b=r4yIE35uif4ojsurgx1gau/eFRGwrww/YW6ss9Z2lnFrKAfwanoSTgGAwO1uj5SVmv9qI5Ri6JhykVJPF6kYPbVWcftgXchPWcZCEBSk330pmFAQHfVOOo4aoNctn0s5K08I/NWP0cOwQNUy4SAyYPmq1t6brlo2zKdouJt/O+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928584; c=relaxed/simple;
	bh=EIAWGhW8A2v+ZxqAjP2xba0nfScSMoScw5np+T9vffE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qp0QqPhvC5qxWR17qA0dm9oZZ0NXj6lNeRgyraPBlA1nlE2y4hBqq7+k/3WLWauC+pQgrQteoK4RcwVwCSYEUZflaTMjbuG9GmqoTpbaujqBlE67d8ka2nml4MIH3nDZtarSTx93GmTsbBbRbxzvthPhM9KFOeeK5DnbD1Cqr2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b00a9989633so211252766b.0
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Oct 2025 06:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759928580; x=1760533380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddtNPUJibRxzuhh3dSgUV8Un+ayK9jnQFI5eAYadmU0=;
        b=Un8B9tEm6/SZUAVQLTY4bqfTkf1vWIGtWXzQSoWt1sgb3VOXAYkK2AXZqc0Gnw4GYB
         R7y2a5PHkIVZ7JVY6pTZEAM3IQKJ8pRWcMVnC0VRtiZb4/ldVtIQgz2y2VisL3e2H2mP
         f0vxocIhWg/qTIAcoLBdjEg6GoIXUVpDIu42TetWq494FbtLR1tFc8r9noA4pSQEdmL5
         h8Z6qU3LxTF4DAiQ4Y7frBxpakSsUdLzQQXOkJNtTUWApo4BuXmLZdPamxboI5MCscYR
         R1F5rIolXbaOxnHa+s/tR6ghiP1L9FhPbLVbqmpXLWVyf5Wj/HaYSf58O9E0LM0v4Itk
         EFrg==
X-Forwarded-Encrypted: i=1; AJvYcCXaKrDkw+UtBohS09rSlcPmDCUgzFtJ6THI/xTyS1MENF+7iWwE2LlmAPlv8BBtpg9p8XIzB21aAbCh4FBBsTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWbJ5eCoKM3y/U+u0xyeuaF7PlD1q8hGiiFT7o0VFGg00Gv7nQ
	W4NnCtjAkMNFxJ4YtWtUD07Shiqp7+/WKerU5nghPybhbUGuB64YIGne
X-Gm-Gg: ASbGncuk6sjIPBOUVy1QCDcZDng49iU7sTyD2DUkBqhI6wHnRctwFrQeTUE/JYHCDXN
	yEYN4pcO6WsucSctk3GO5DDEJZZGXeALT+0oZIShvbKPBEGHGQcGZaU8JP5nakz5Ctz3tGNe5yd
	IQ2uVdApWOPigJwskc6PIiW6Wz+TRx8V6+ARd3GcnIH9pOFmF8dBYDlWfNk4bAYuzHmI4EESiZp
	hlPMMGA5u1B8FP28A5J+8dTH4RyoEWXlq9glw477bXTwVzmIxUD1QbYZNo9qxkKd7VVIDLw7xWI
	mun211IegvOm+Fj5f/iqRyVPtOMN7PT/4FW5XbpU2RWyvISKv1SoAJGlFo0tBE6GIu6wI2DzBYF
	CkGdArKr5HRyhW8kfq0IZber3kw7vArQdTw2WphISPQ==
X-Google-Smtp-Source: AGHT+IFCsOv+E+hkE/ODWPwUMsik0P5C7r77C29nZTRyMVSRUaIvoxt5GdpsOgvdOE/VgE3kaUEYsQ==
X-Received: by 2002:a17:906:6a1f:b0:b04:3cd2:265b with SMTP id a640c23a62f3a-b50bcc09d8dmr365835566b.5.1759928579841;
        Wed, 08 Oct 2025 06:02:59 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:40::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970a60dsm1631679466b.63.2025.10.08.06.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 06:02:59 -0700 (PDT)
Date: Wed, 8 Oct 2025 06:02:56 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	david decotigny <decot@googlers.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, calvin@wbinvd.org, 
	kernel-team@meta.com, jv@jvosburgh.net
Subject: Re: [PATCH net v7 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
Message-ID: <m2dwihyj3vddvipam555ewxej663brejyv5gdnsw4ks5mis2y7@2mu2gus2o7ys>
References: <20251003-netconsole_torture-v7-0-aa92fcce62a9@debian.org>
 <20251003-netconsole_torture-v7-4-aa92fcce62a9@debian.org>
 <e6764450-b0f8-4f50-b761-6321dfe2ad71@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6764450-b0f8-4f50-b761-6321dfe2ad71@redhat.com>

Hello Paolo,

On Tue, Oct 07, 2025 at 11:47:22AM +0200, Paolo Abeni wrote:
> On 10/3/25 1:57 PM, Breno Leitao wrote:

> > +# Test #5: Enslave a sub-interface to a bonding interface
> > +# Enslave an interface to a bond interface that has netpoll attached
> > +# At this stage, BOND_TX_MAIN_IF is created and BOND_TX1_SLAVE_IF is part of
> > +# it. Netconsole is currently disabled
> > +enslave_iface_to_bond
> > +echo "test #5: Enslaving an interface to bond+netpoll. Test passed." >&2
> 
> I think this is missing the negative/fail to add test case asked by
> Jakub. AFAICS you should be able to trigger such case trying to add a
> veth device to the netpoll enabled bond (since the latter carries the
> IFF_DISABLE_NETPOLL priv_flag).

Thanks for the review. I misunderstood what Jakub said, sorry about it.

I've tried to enslave a veth interface manually into a bonding
interface, and I can see:

	# ip link set veth0 master bond_tx_78
	 aborting
	 RTNETLINK answers: Device or resource busy
	
and dmesg shows:

	netpoll: (null): veth0 doesn't support polling,

If that is the test case that is missing, I will add it as an additional
test in the selftest, and send a new version.

> > +function create_ifaces_bond() {
> > +	echo "$NSIM_BOND_TX_1" > "$NSIM_DEV_SYS_NEW"
> > +	echo "$NSIM_BOND_TX_2" > "$NSIM_DEV_SYS_NEW"
> > +	echo "$NSIM_BOND_RX_1" > "$NSIM_DEV_SYS_NEW"
> > +	echo "$NSIM_BOND_RX_2" > "$NSIM_DEV_SYS_NEW"
> > +	udevadm settle 2> /dev/null || true
> > +
> > +	local BOND_TX1=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_TX_1"
> > +	local BOND_TX2=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_TX_2"
> > +	local BOND_RX1=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_RX_1"
> > +	local BOND_RX2=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_RX_2"
> 
> Note that with the create_netdevsim() helper from
> tools/testing/selftests/net/lib.sh you could create the netdevsim device
> directly in the target namespace and avoid some duplicate code.

Awesome. I am more than happy to create_netdevsim() in this selftest,
and move the others to use it as well.

> It would be probably safer to create both rx and tx devices in child
> namespaces.

Sure, that is doable, but, I need to change a few common helpers, to
start netconsole from inside the "tx namespace" instead of the default
namespace.

Given all the other netconsole selftest uses TX from the default net
namespace, I would like to move them at all the same time.

Do you think it is Ok to have this test using TX interfaces from the
main net namespace (as is now), and then I submit a follow patch to
migrate all the netcons tests (including this one) to use a TX
namespace? Then I can change the helpers at the same time, simplifying
the code review.

> > +	# now create the RX bonding iface
> > +	ip netns exec "${NAMESPACE}" \
> > +		ip link add "${BOND_RX_MAIN_IF}" type bond mode balance-rr
> 
> Minor nit:
> 
> 	ip -n "${NAMESPACE}" link ...
> 
> will yield the same result with a little less wording.

Ack. I will update. Thanks

> > +# Clean up netdevsim ifaces created for bonding test
> > +function cleanup_bond_nsim() {
> > +	echo "$NSIM_BOND_TX_1" > "$NSIM_DEV_SYS_DEL"
> > +	echo "$NSIM_BOND_TX_2" > "$NSIM_DEV_SYS_DEL"
> > +	echo "$NSIM_BOND_RX_1" > "$NSIM_DEV_SYS_DEL"
> > +	echo "$NSIM_BOND_RX_2" > "$NSIM_DEV_SYS_DEL"
> > +	cleanup_all_ns
> 
> If all devices are created in child netns, you will not need explicit
> per device cleanup.

Ack!

Thanks for the review,
--breno

