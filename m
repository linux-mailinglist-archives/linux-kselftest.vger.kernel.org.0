Return-Path: <linux-kselftest+bounces-47308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F77CB0C53
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 18:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4949930191A1
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 17:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02C523B60A;
	Tue,  9 Dec 2025 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="cgdOOaPO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0656E1DF248;
	Tue,  9 Dec 2025 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765302428; cv=none; b=EgXBIg0sRF86khrD+3oIprvxzvsDKs2Y89G90318gG+YK407/3EGnu2/86O1/0HqMJtBLQGx8xnwkvU7fqVss1E+b6XEf3OKjdMA1cRN36b8ZBWoHuTDsPkksO/10+yEdewEwXBlBLWkyeijpGPn+ILziIzD7DI+3WDMlk593E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765302428; c=relaxed/simple;
	bh=xz+3QBGORDWc4nUGQFkFWzRbLLJ+ECCdKFkHKqqRVsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0C9xI0//V27xYbgND+pryoxrriE/PZwU2OHHMjIiqZ4MEiDtkAaIfXNrdgH2bgltqssOsgKix9xwit7rUod78RW4OPN7ZH40R7SpC6YJvEahB894mC4etfGQ8ywvWH99m1twtLnA00ZkWEEKkJHIBHtq2KtsZjN57jqZpI/o50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=cgdOOaPO; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nDbkCvbumVt/JXuMSApvso7Kk+anWI/zeUGcDxpNtLQ=; b=cgdOOaPOV8oGOVGnlgWghLZBIC
	8pBhHRnKzJ9XWZXwTxExGR0uicxsCEj41Qt7nz2JZci4C1ZhMB/wZ6p1+OmKUU5vmOna4z79LK9dk
	+RUHm0H2ve5ITTwBBpxR2lwr5eTnGKM63S2e6Lp07u3nWQpa9z/QtE+t1nxkO90RRXUsOSiTuf+on
	rfggwHvisD4qGGjeZSpTW6HrlOa7l9U0H/IBlMhBtmLl0ShIfZI6057uuHVshl/hSOk4ebydbo89U
	e1ocX21DC5RyWjXfEkdOD4QNG8grWEGgKizrTSsJsYVOSPD46+TKjYcNYG9bB3xYJpcsxZCk2C2Pr
	CrkwYoTw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vT1nd-007IZV-5l; Tue, 09 Dec 2025 17:46:57 +0000
Date: Tue, 9 Dec 2025 09:46:51 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, gustavold@gmail.com, 
	asantostc@gmail.com, calvin@wbinvd.org, kernel-team@meta.com, davej@codemonkey.org.uk
Subject: Re: [PATCH net-next 0/4] (no cover subject)
Message-ID: <snoxl67npkzfi63l4ndh3d6qvx2lyxthtrwhfnharhf5llrv4j@zhyzxm3tegia>
References: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
 <20251201163622.4e50bf53@kernel.org>
 <4oybtunobxtemenpg2lg7jv4cyl3xoaxrjlqivbhs6zo72hxpu@fqp6estf5mpc>
 <20251202102442.568f91a7@kernel.org>
 <aTFmew5trILX3RpO@pathway.suse.cz>
 <aTFnzmc0ZtBvGg4y@pathway.suse.cz>
 <7jdruzcpkeyhuudwi6uzg2vsc5mhgpq7qz4ym7vqqmgs7j3524@cvtnzneddg2d>
 <20251209163745.3d0fcdfe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209163745.3d0fcdfe@kernel.org>
X-Debian-User: leitao

Hello Jakub,

On Tue, Dec 09, 2025 at 04:37:45PM +0900, Jakub Kicinski wrote:
> On Fri, 5 Dec 2025 02:21:08 -0800 Breno Leitao wrote:
> > 1) Have a binary in each machine:
> 
> > 2) Send a ping directly to the console
> 
> > 3) Using per-loglevel patchset.
> 
> > 4) send messages only to netconsole (this patchset)
> 
> I think I was alluding that another option (not saying that it's the
> best but IIUC your requirements it'd be the best fit)):
> 
> 5) Add a keepalive configfs knob, if set to a non-zero value netconsole
> will send an empty (?) message at given interval
> 
>   Pros:
>    - truly does not require a user binary to run periodically, netcons
>      would set a timer in the kernel
>   Cons:
>    - does not provide the arbitrary "console bypass" message
>      functionality

This is a good idea if we change it slightly. What about a "ping"
configfs item that send sit when I touch it?

Something as:

	# echo 1 > /sys/kernel/configs/<target>/ping
	
And it would ping the host with a predefined "ping" message, and nothing
else.

That would work, for my current problem, honestly.

One drawback compared to a more flexible "send_msg" is that I don't have
complete flexibility on the message format. Thus, if I want to pass
extra information such as a Nonce, timestamp, host state, interface
name, health state, it will not be possible, which is fine for now,
given I am NOT planning to use it at this stage.

Thanks for the idea and discussion,
--breno


