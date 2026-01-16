Return-Path: <linux-kselftest+bounces-49198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BEED38815
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 22:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7738E3002B84
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 21:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D91264A65;
	Fri, 16 Jan 2026 21:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2jeg763"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF231A9FA8
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768597288; cv=none; b=aU/bIpkEXITWG5d7vSvwN9o6CIQn1gggV8MNno99TISVNoxrjqergLHhCGAnVXtwR59vDYTfKIbmrPZf4w7LY6TgW4svWQLGSlgRDJX23ma6jAu2QWSeqR5XeQ5G86SX/2dlQCNA91ulyXNU9AI1dybMv1f7r/JHdd/mVhqyax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768597288; c=relaxed/simple;
	bh=/Xh071rFobUifp9vg+391OtG1/GHsYcuoKH5i8JyjOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQLzeYKMwwjmQQA+rRd4fY+7Kxs3wY2x+5XMbKh68K2cpu5XoKwxFeTvy/QRzb1beRRozovylNlLEGxnb6++oCNMiln7HQk227W1F9CYVdBgy4e7OtLBKKgjv8iLvpLwguqadmVcpjOGiPmoGorno57S4o5rXNHhJabwzZccZeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2jeg763; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so1844086f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 13:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768597285; x=1769202085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aXlyykM87bz8EPPmErTX2/nMizjLMi1IDXeb9kqCDiE=;
        b=S2jeg763oGMvOb2mBNJhei7xpYnLP7JJO66GgwHTeN85bumqS2b4dc894XOOzLYvqg
         gPRydq+IVVHDlLMhM5iqlwbYJXKnagmyqvhdgJkwVtZ+rnh163dPCKuWvnrQ7fbdvpFH
         2gKrou1g7aEL96c1vqsUZH0opdGQr8GQePf9PB6cuoUl6NF7Vrvp7xfCH7DTaXqlbBmX
         GB5Jii7QHPgdQaYb8mjfNaxIpHfOxJ1GViFgE639IhwyfHnotfSjAy+4NDKFYlp4oakA
         8FRQcMZrI9Qrw5f9IPO8G+tNKYOcA/0S+FTCZhliTfvsGiP23Ao7HLPvusxldDgsGkY2
         QAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768597285; x=1769202085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXlyykM87bz8EPPmErTX2/nMizjLMi1IDXeb9kqCDiE=;
        b=XzTEQYZNR3OFhroc61ov30gTVrm114pgHTSpkwNT3uyg5BFqMzesuPaZrD5YNM4nAM
         eBSotXnpVWlU+aNG88oaZEVLONhpqLWouk/AcMREVJBTNAoF4yfRHVOqtF81nC/6mezC
         5X9BIGOpNQeQhiOQu9FVYqKBg+MRwL+LdcuawIGj/cKFTBWye/cd6aoVcPYot0J1UzbQ
         6Ma1+wn4xrQlI+xCmW8nkLK4cPLpIZnO23YnVtOx1ldDh6mp12/83Z+OwnXRBy3tSL8x
         GYVfmiGJ+9+sfjCD6fWeIAjXEGayexqZvqJca8h+//oZCczhhVjox3yIXp084DUSLMZk
         l3HA==
X-Forwarded-Encrypted: i=1; AJvYcCXsQkghUqNr8m4uemq4hfD6iRvI4T25OOPTIQPpeCUcj7zOkgSH72J0mIoLLvOWeYkfQAoYbzbtdDLP7diJ9mU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7lLnicMntLF3yXYlMwOCXqiqjwZn+68FwDifB7eu72uBIyd/G
	q/lNIYazEUmBCDIZQnvOymGn85AtKq183PUUpoDO1l06JESvZ2nCknLQ
X-Gm-Gg: AY/fxX5Kn/wib1joaM7JLkMqMTKd34NVe41kqtWjS/obFR2PIHp4voLeqnJNo4QBxwj
	gBKT01ghCviovIRtM8Ia5NPNeRzxu4C32MGWPzKNBiBnUMe9wpVwO+ClR5C2cGnrQi9frvvzW1c
	DOnp+f/RmfwCAoLbQEmMwEWoyMvzgqs9CVkPGI8LucYCcktpj6mbCfFnYhunNI7uPceBto22jfY
	Y88Nfy/Bgq9o+3EzWb8BnOD9gvPD4PP/tsH67D/Gso/9Bxzoit+vJ3oGNwSHTF69t98kP3aaUjP
	HbheJ+suElT+yhURgrX1laE9hpS+pxLih1ZLQcm+YQDx8Pz6UE5swCQ9G5k992LuZqXQHD2Vkhf
	pIO+EPH+kEfhlxjClKgCf+aFOPjMZ9bmOgjkfDwcrNR7EtHMk3zZZoqy84rXRCXNKVzGP/AtT40
	nMGvO3Cg==
X-Received: by 2002:a05:6000:4387:b0:431:1ae:a3d0 with SMTP id ffacd0b85a97d-435699810a1mr5156199f8f.25.1768597284962;
        Fri, 16 Jan 2026 13:01:24 -0800 (PST)
Received: from archlinux ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699982aasm7545219f8f.42.2026.01.16.13.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:01:24 -0800 (PST)
Date: Fri, 16 Jan 2026 21:01:22 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v10 7/7] selftests: netconsole: validate target
 resume
Message-ID: <aWqkhT_-4UoNHX6F@archlinux>
References: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
 <20260112-netcons-retrigger-v10-7-d82ebfc2503e@gmail.com>
 <20260112061642.7092437c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112061642.7092437c@kernel.org>

On Mon, Jan 12, 2026 at 06:16:42AM -0800, Jakub Kicinski wrote:
> On Mon, 12 Jan 2026 09:40:58 +0000 Andre Carvalho wrote:
> > Introduce a new netconsole selftest to validate that netconsole is able
> > to resume a deactivated target when the low level interface comes back.
> > 
> > The test setups the network using netdevsim, creates a netconsole target
> > and then remove/add netdevsim in order to bring the same interfaces
> > back. Afterwards, the test validates that the target works as expected.
> > 
> > Targets are created via cmdline parameters to the module to ensure that
> > we are able to resume targets that were bound by mac and interface name.
> 
> The new test seems to be failing in netdev CI:
> 
> TAP version 13
> 1..1
> # timeout set to 180
> # selftests: drivers/net: netcons_resume.sh
> # Running with bind mode: ifname
> not ok 1 selftests: drivers/net: netcons_resume.sh # exit=1
> -- 
> pw-bot: cr

I've finally been able to reproduce this locally. The issue is caused by the
fact that the test currently expects that mac addresses for netdevsim devices are
deterministic. This is the case on my setup as systemd enforces it (MACAddressPolicy=persistent).

I was able to disable this behaviour by setting up /etc/systemd/network/50-netdevsim.link, with:

[Match]
Driver=netdevsim

[Link]
MACAddressPolicy=none

I'm assuming this is also the behaviour on CI hosts. I have started working on a fix
for this test and will submit v11 once that is ready. The approach I'm taking is saving and
restoring the mac addresses once I reload netdevsim module. Example code below (needs more testing):

function deactivate() {
	# Start by storing mac addresses so we can be restored in reactivate
	SAVED_DSTMAC=$(ip netns exec "${NAMESPACE}" \
		cat /sys/class/net/"$DSTIF"/address)
	SAVED_SRCMAC=$(mac_get "${SRCIF}")
	# Remove low level module
	rmmod netdevsim
}

function reactivate() {
	# Add back low level module
	modprobe netdevsim
	# Recreate namespace and two interfaces
	set_network
	# Restore MACs
	ip netns exec "${NAMESPACE}" ip link set "${DSTIF}" \
		address "${SAVED_DSTMAC}"
	if [ "${BINDMODE}" == "mac" ]; then
		ip link set dev "${SRCIF}" down
		ip link set dev "${SRCIF}" address "${SAVED_SRCMAC}"
		# Rename device in order to trigger target resume, as initial
		# when device was recreated it didnt have correct mac address.
		ip link set dev "${SRCIF}" name "${TARGET}"
	fi
}

The main annoyance is that to test resuming when a device was bound by mac I actually need
to change the name of the device after restoring the mac address (since when the device 
is registered after deactivation the mac won't match).


-- 
Andre Carvalho

