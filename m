Return-Path: <linux-kselftest+bounces-46872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3456C9B182
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 11:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B86F4E4647
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 10:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E257B3112C0;
	Tue,  2 Dec 2025 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="DZIUy2Iu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F064030E0E7;
	Tue,  2 Dec 2025 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764670755; cv=none; b=ICS0AIqkWD1EJ0ui//+SKHy6Ljsf17sDB5FC+SXRP0xXsxpHOmNbHF0TyPz660vyQmCeA021Zu7rQ0xfuPi1OFY2hDQegYVCY4v75VCDNa2g6SxrzvaaIY3SAJ/lO0qvuH4Hsyy3deNOWmInEWIqED0VUkdtZklt6fUkhJdKAL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764670755; c=relaxed/simple;
	bh=WW7ulNSqOQJ4VbgVrP/uSoBS4yhn1mOMMBbkZgzXOoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5L3aSsuQfAzRSS2/mvbyVFeQnUQ6gSzLZCLYgVLuz3hYHTKPDrJ3vsbOm5We0Z93Xd49dbf+/eorE9X2QoSeLOIPMkr1rlkkj+kdr7nq1ftELZ/dsbE7LxBuncW76SWrSTUNt2H3cawcsOnoAgX8sUmZgNy+vgvVfn9Z0TITKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=DZIUy2Iu; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pg7arLvqaoUi1FEUGhQwxZl9BaIYhsi4GY1RbOJM6g0=; b=DZIUy2IuIH9DBnH4CLx46z9+1P
	VSnmY7iU1sfbTy1yDu4YkYmEU2gVA4xNxjUZT4IUvfPUFkXBxXryojYZ8zfwLXJzKfkP3Kbq04HqO
	EMx69hDo3iU+mRj2rBfwkq60sTKb0Fy/ACnAuXNLZ1NdmNkqTDjQ7/qP0i/y7w+2ZZVMgbLkYGQJy
	AcEHVHtFafYxlti1jpIxD8kknyIgq+CsWgPpHPEe5SJeF0g/Hsg4bxaQ3tya39yks0GFAAEzBz02u
	IYU/dilkiVglnbPC2HA4k/+y2eyZwnphzdD+W/OiNH6ixHHlG0Qhh6y4/4L/qTrkrXqnnCLfUpjKT
	474VetYA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vQNT9-001Mwy-6t; Tue, 02 Dec 2025 10:18:51 +0000
Date: Tue, 2 Dec 2025 02:18:44 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, gustavold@gmail.com, 
	asantostc@gmail.com, calvin@wbinvd.org, kernel-team@meta.com, 
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH net-next 0/4] (no cover subject)
Message-ID: <4oybtunobxtemenpg2lg7jv4cyl3xoaxrjlqivbhs6zo72hxpu@fqp6estf5mpc>
References: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
 <20251201163622.4e50bf53@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201163622.4e50bf53@kernel.org>
X-Debian-User: leitao

Hello Jakub,

On Mon, Dec 01, 2025 at 04:36:22PM -0800, Jakub Kicinski wrote:
> On Fri, 28 Nov 2025 06:20:45 -0800 Breno Leitao wrote:
> > This patch series introduces a new configfs attribute that enables sending
> > messages directly through netconsole without going through the kernel's logging
> > infrastructure.
> > 
> > This feature allows users to send custom messages, alerts, or status updates
> > directly to netconsole receivers by writing to
> > /sys/kernel/config/netconsole/<target>/send_msg, without poluting kernel
> > buffers, and sending msgs to the serial, which could be slow.
> > 
> > At Meta this is currently used in two cases right now (through printk by
> > now):
> > 
> >   a) When a new workload enters or leave the machine.
> >   b) From time to time, as a "ping" to make sure the netconsole/machine
> >   is alive.
> > 
> > The implementation reuses the existing message transmission functions
> > (send_msg_udp() and send_ext_msg_udp()) to handle both basic and extended
> > message formats.
> > 
> > Regarding code organization, this version uses forward declarations for
> > send_msg_udp() and send_ext_msg_udp() functions rather than relocating them
> > within the file. While forward declarations do add a small amount of
> > redundancy, they avoid the larger churn that would result from moving entire
> > function definitions.
> 
> The two questions we need to address here are :
>  - why is the message important in the off-host message stream but not
>    important in local dmesg stream. You mention "serial, which could be
>    slow" - we need more details here.

Thanks for the questions, and I would like to share my view of the world. The
way I see and use netconsole at my company (Meta) is a "kernel message"
on steroids, where it provides more information about the system than
what is available in kernel log buffers (dmesg)

These netconsole messages already have extra data, which provides
information to each message, such as:

 * scheduler configuration (for sched_ext contenxt)
 * THP memory configuration
 * Job/workload running
 * CPU id
 * task->curr name
 * etc
 
So, netconsole already sends extra information today that is not visible
on kernel console (dmesg), and this has proved to be super useful, so
useful that 16 entries are not enough and Gustavo need to do a dynamic
allocation instead of limiting it to 16.

On top of that, printk() has a similar mechanism where extra data is not
printed to the console. printk buffers has a dictionary of structured
data attached to the message that is not printed to the screen, but,
sent through netconsole.

This feature (in this patchset) is just one step ahead, giving some more
power to netconsole, where extra information could be sent beyond what
is in dmesg.

>  - why do we need the kernel API, netcons is just a UDP message, which
>    is easy enough to send from user space. A little bit more detail
>    about the advantages would be good to have.

The primary advantage is leveraging the existing configured netconsole
infrastructure. At Meta, for example, we have a "continuous ping"
mechanism configured by our Configuration Management software that
simply runs 'echo "ping" > /dev/kmsg'.

A userspace solution would require deploying a binary to millons of
machines,  parsing /sys/kernel/configfs/netconsole/cmdline0/configs
and sends packets directly.

While certainly feasible, it's less convenient than using the
existing infrastructure (though I may just be looking for the easier
path here).

> The 2nd point is trivial, the first one is what really gives me pause.
> Why do we not care about the logs on host? If the serial is very slow
> presumably it impacts a lot of things, certainly boot speed, so...

This is spot-on - slow serial definitely impacts things like boot speed.

See my constant complains here, about slow boot

	https://lore.kernel.org/all/aGVn%2FSnOvwWewkOW@gmail.com/

And the something similar in reboot/kexec path:

	https://lore.kernel.org/all/sqwajvt7utnt463tzxgwu2yctyn5m6bjwrslsnupfexeml6hkd@v6sqmpbu3vvu/

> perhaps it should be configured to only log messages at a high level?

Chris is actually working on per-console log levels to solve exactly
this problem, so we could filter serial console messages while keeping
everything in other consoles (aka netconsole):

	https://lore.kernel.org/all/cover.1764272407.git.chris@chrisdown.name/

That work has been in progress for years though, and I'm not sure
when/if it'll land upstream. But if it does, we'd be able to have
different log levels per console and then use your suggested approach.

Thanks for the review, and feel free to yell at me if I am missing the
point,
--breno

