Return-Path: <linux-kselftest+bounces-47307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 725ACCB0BF9
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 18:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 733C030185F4
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 17:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDCC32ABC3;
	Tue,  9 Dec 2025 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="OA8fOHnh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753E22FFF94;
	Tue,  9 Dec 2025 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765301806; cv=none; b=gjnWLuatlCkP/osyDBVPp4PlggPpq9eGBT6PQFE2pl+W8PNt9YfCAT+UR9NqHP1dcktXJztr3fBT3pSp+2gcUwmC548dSUqYbF+ljVMhsWDd8gAsZAKsQs3MeZlCQECL+Cs6YSxjstCavAul30BBxVbkf8EbP8O2+3tVBxT62cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765301806; c=relaxed/simple;
	bh=uEs8g4lbBl16nCil/0VaFZ8Tx3FTjw6JajWYkKa785g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+FFmG/zf/09g6ZTeV065ysSptPUvbux5NKfEN4NlteYqD3WlnwLM00Zg6EU6aw9h4pIVNysdZ706bo5d3uwhH5R68iIr7jtq7M7LD7pv6S8B2udrsmgxQjtFVryHW6/2/EKFFl2vP9EvRNbj6KxZaa99zDPTOHZsMjFp3PLS6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=OA8fOHnh; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f68wF7OB69BukyOPMGR2VjCj4FHQhmjsFLJjVz2yiQE=; b=OA8fOHnhyh1PN9DS8V+gPOLbhx
	mFfoZuG3RlIN8/yWbt1EmHpkSUFI0NqHEleMHM4ii5OfKa52jYLJyFAlWBbQ+tfPA/E9pQZ8W7hgu
	vYRo9As8dyI8KHoAm5kct5+nFhsr0yrvof/0maXZ0xkpUwj1Qmf2eUPSiRv8/2lvRW7PU0j4al+vm
	fdDCTdXaaxA1+MrTCzapnjMCIVsF/6sKIoZ1qKygZ+JG/ClQGX8fq35DaotIbrScKasMlQJl6B9tp
	3tCMaAMa9/1uIqHIY6Abxejbj8luJkyGTaaAapHc2wtvy2+CjlvivKo1XgBMxYHnMZcfBizQsdIwg
	kei7kJvA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vT1dO-007IDs-UM; Tue, 09 Dec 2025 17:36:23 +0000
Date: Tue, 9 Dec 2025 09:36:16 -0800
From: Breno Leitao <leitao@debian.org>
To: Petr Mladek <pmladek@suse.com>
Cc: kuba@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, gustavold@gmail.com, 
	asantostc@gmail.com, calvin@wbinvd.org, kernel-team@meta.com, davej@codemonkey.org.uk
Subject: Re: [PATCH net-next 0/4] (no cover subject)
Message-ID: <qepvadqfuskb6d6q6rkxvxhwo4lsjgvbygdav6wtp24pdranjc@ou6gadd6iohy>
References: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
 <20251201163622.4e50bf53@kernel.org>
 <4oybtunobxtemenpg2lg7jv4cyl3xoaxrjlqivbhs6zo72hxpu@fqp6estf5mpc>
 <20251202102442.568f91a7@kernel.org>
 <aTFmew5trILX3RpO@pathway.suse.cz>
 <aTFnzmc0ZtBvGg4y@pathway.suse.cz>
 <7jdruzcpkeyhuudwi6uzg2vsc5mhgpq7qz4ym7vqqmgs7j3524@cvtnzneddg2d>
 <aTbmNdilvUq78bjc@pathway>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTbmNdilvUq78bjc@pathway>
X-Debian-User: leitao

Hello Petr,

On Mon, Dec 08, 2025 at 03:52:37PM +0100, Petr Mladek wrote:
> On Fri 2025-12-05 02:21:08, Breno Leitao wrote:

> JFYI, I am going to review the last version of the per-console
> loglevel patchset later this week. IMHO, we are very close to
> get it merged.
> 
> BTW: How often do you ping the netconsole, please?
>      IMHO, adding a short message once-per-hour might be bearable,
>      once-per-minute might be questionable for the kernel buffer
>      but still fine for journalctl.

It is not very often today, about once a week. This is mostly due to the
pollution of kernel buffers.

Ideally we can set it to multiple times a day, but less than hourly.

> > 4) send messages only to netconsole (this patchset)
> 
> I do not have strong opinion about this.
> 
> That said, the location /sys/kernel/config/netconsole/<target>/send_msg
> looks a bit weird to me. I would rather expect /dev/netconsole_msg
> or so. But I do not have strong opinion. It might be an overkill.
> 
> How important is it to trigger the ping from userspace, please?
> It might be sent by an existing watchdog.

Medium importance, I would say. I am inclined to distributed design,
where each machine detects broken netconsole and report itself. Instead
of something else (a service) finding broken-netconsole hosts in the
"fleet".

Something as:

	1. Machine boots
	2. userspace sends the ping (or knows that the ping was already
	   sent)
	3. the configuration management (chef, ansible, etc) makes sure
	   that the message got received.


So, step number 3 needs to be executed only after step 2. Initiating the
ping (step 2) from userspace is the easiest way, to control when the
machine can go to step 3.

Thanks
--breno

