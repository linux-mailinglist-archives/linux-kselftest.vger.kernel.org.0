Return-Path: <linux-kselftest+bounces-47096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 181C0CA723A
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 11:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62407301E58B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 10:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1CB2F0670;
	Fri,  5 Dec 2025 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="GGKeHxIv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B392F5465;
	Fri,  5 Dec 2025 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764930097; cv=none; b=WcoY9Cgfumttn81f8pPwXWaa2J9L96TXP0VhJbaeaGWtoiU/g9pwvNtbR5YABO3rmc80puJqmVPKHeYItSaSIBq7xWvLCaH1XtOn4MynnHwFUiuF3rMxI8dEQP1R83F86fecLE31yF3U6GAw8oTXY6yjgh1DaN8fIn3zEH0cfeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764930097; c=relaxed/simple;
	bh=IEq8a1wGJT7PXJ9siZWiyjc+/nCUkcF8DvozFo9xKp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cc2AhrNn12CslVaukuk/aIAK+3eSMJrIyrMgW1H5vuVC3M+vjsXFiw/2YSCdfgG9ym/elwr71hLtkB+doHM8sbFu1t0ONFdSx0otmf4VzHUQ0A17YaB4FUqVsN0pUn/REY3TDJK/7eKRfICMB4tHOxnk3hhqWJc1KY1l8ZfQdPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=GGKeHxIv; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/la2xG/I5LkMkMDU+d9jR1D+BzTOllha9e9tATdRyn8=; b=GGKeHxIvV3Up/TsRRM8jaDdoxB
	W1Pb1G7beYzNgvdwipruGyqzSGd1HLk7LzraJUDP1TEc50ljf6bKXe1VJwMjxHBeusDJHav7dLfrB
	9YJYxROShzOqnuYJ2nIatxFORlIbpCoRuWgjQitST/3hXD6GvvU13m0fyq4PzeiOF8Q2xlynjrQdO
	QD5iEM7mXqNsEK8sWmCY462X0mhgkows/oEbWs53b18t3+MAOBtKovPlXJNuUbeVNjs1b7D/zmgSW
	S2pHzCtMkkfof0t9w91KNhIv9TiGJphbWbeBbAKmhlqApMJAeZHb34f0melKQv4vu6ZUj6fqyUg5o
	Ew+3Nhcg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vRSw6-003nq0-MV; Fri, 05 Dec 2025 10:21:15 +0000
Date: Fri, 5 Dec 2025 02:21:08 -0800
From: Breno Leitao <leitao@debian.org>
To: Petr Mladek <pmladek@suse.com>, kuba@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, gustavold@gmail.com, 
	asantostc@gmail.com, calvin@wbinvd.org, kernel-team@meta.com, davej@codemonkey.org.uk
Subject: Re: [PATCH net-next 0/4] (no cover subject)
Message-ID: <7jdruzcpkeyhuudwi6uzg2vsc5mhgpq7qz4ym7vqqmgs7j3524@cvtnzneddg2d>
References: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
 <20251201163622.4e50bf53@kernel.org>
 <4oybtunobxtemenpg2lg7jv4cyl3xoaxrjlqivbhs6zo72hxpu@fqp6estf5mpc>
 <20251202102442.568f91a7@kernel.org>
 <aTFmew5trILX3RpO@pathway.suse.cz>
 <aTFnzmc0ZtBvGg4y@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTFnzmc0ZtBvGg4y@pathway.suse.cz>
X-Debian-User: leitao

On Thu, Dec 04, 2025 at 11:51:58AM +0100, Petr Mladek wrote:
> > > > > perhaps it should be configured to only log messages at a high level?  
> > > > 
> > > > Chris is actually working on per-console log levels to solve exactly
> > > > this problem, so we could filter serial console messages while keeping
> > > > everything in other consoles (aka netconsole):
> > > > 
> > > > 	https://lore.kernel.org/all/cover.1764272407.git.chris@chrisdown.name/
> > > 
> > > Excellent! Unless I'm missing more context Chris does seem to be
> > > attacking the problem at a more suitable layer.
> > 
> > This would help to bypass slow serial consoles. But the extra messages
> > would still get stored into the kernel ring buffer and passed back
> > to user space logs, for example journalctl.
> 
> It might actually make sense for the "workload enters or leaves" messages.
> But I am not sure about the "ping" messages.

Agree. Let me back up and explain my "ping" messages better, which
I think might add more information about this topic.

Meta has millions of servers, and all of them must have netconsole
running 100% of the time.

Of course that this is not reality, and problems happen for different
reasons, the ones that interest me here are:

1) Top of the rack switch MAC address changes (mostly associated with
   network hardware (top of the rack switches and gateway) replacement)
    a) Keep in mind that netconsole target has the destination MAC as
       part of its configuration.

2) Netconsole got associated with the wrong network port, which comes in
   two different flavors.
   a) The machine got provisioned wrongly since day one (Most common
      case)
   b) The machine NIC changed and: 
      i) The target doesn't bind correctly anymore (if netconsole
         target is bound by mac address)
      	   * This is easier to detect, given the target will never be
	     enabled.

3) Netconsd (the daemon that listen to netconsole packets) is buggy or
   dead

4) Network failures across the route


Possible Solutions
==================

In order to detect those issues above, I think the best (or only) way is
to send messages from the host, and check if they got received. If not,
raise an alarm (in the common distributed way).

This could be done in very different ways, tho. Such as:

1) Have a binary in each machine:
	a) This binary reads the netconsole target that is configured,
	   and mimics "ping" UDP netconsole packet.

	Pro: 
	     * It doesn't need any kernel change
	Cons:
	     * It needs to reimplement the netconsole logic in userspace
	     * This needs also a widely distributed binary on all
	       machines

2) Send a ping directly to the console
	a) Something as 'echo ping from $hostname" > /dev/kmsg')

	Pro:
		* No kernel changes
	Cons:
		* These debug messages will be sent to journalctl and to
		  the console, polluting both

3) Using per-loglevel patchset.
	a) Same as above, but, setting netconsole loglevel to DEBUG, while
	   all other consoles to INFO.

	Pro:
		* No changes on netconsole
		* Netconsole "buffers" continues to be synchronized with
		  kernel buffers. Everything in the same page, but,
		  netconsole data has one loglevel higher.
		* Sending a message to netconsole-only message is not
		  special at all. It uses the same workflow we have
		  today, through `/dev/kmsg'
	Cons:
		* Needs to change printk/console code (Chris' patch)
		  that is on review for years now. Will it ever get
		  accepted?
		* These "ping" message will be in kernel buffers and
		  journalctl, and are useless in there (!?)
		* It is not possible to send a message to a single
		  netconsole target.

4) send messages only to netconsole (this patchset)
	Pro:
		* It is easy to test netconsole connective (problem above),
		  without kernel buffers/journal pollution
		* It doesn't depend on the per-loglevel patchset
		* Adds flexibility to netconsole targets.
			- only certain netconsole targets receive
			  certain messages
	Cons:
		* Messages sent to netconsole is a superset of messages in the
		  kernel buffer. In other words, "dmesg" and machine
		  logs/journal will not be able to see messages that
		  were sent directly to netconsole.
			- It might be seen as a back channel (!?)
		* Different netconsole targets may receive different
		  messages. Too much flexibility might be bad (!?)

Anyway, options 1 and 2 are available today. In order to make the
problem easier to solve, we are deciding between approach 3) and 4),
which will require kernel changes, either in printk/console or
netconsole.

Sorry for the long email, I just wanted to do the brain dump about my
view of the world, so, we can decide it from a community perspective in
the open.

Thanks for the discussion,
--breno

