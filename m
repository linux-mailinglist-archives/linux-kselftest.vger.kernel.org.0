Return-Path: <linux-kselftest+bounces-46902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F36C3C9C9EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 19:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBE124E3B8C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 18:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9DC2C21E7;
	Tue,  2 Dec 2025 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKjuJtle"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3025C2BDC27;
	Tue,  2 Dec 2025 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764699884; cv=none; b=IsLE4uEos7Lj7kJEeuL7ETdCCdI667V4KM34RhdvLzV0tvwVVMkjwL6vHDW6DeyJeuQTyxfYh/mJYe1WzlFRDchwAxYFVFTTTm22CNkdnuMLyiwdQYql5ov28NUYBDPpPAdhKfqU8z2Lekkydx9L/hjZ+ZTCvFvbbzmA6i4qsQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764699884; c=relaxed/simple;
	bh=k3V28RTPY5VT9Tip6bfIi7nFwEC9oVqpNiX9i4oiutg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r4vXEZkXOwwLvrfqUMJU/3X2CZurqmowmLwRH3g5g2AYthd6DPlJXi1tH3Wu1szcYoV69n+SDAOntDN0O1jIUErGqTebQ6Qjkhc9t1a2NsZ5IBuBx/kGkgRaEd8wKN1ZpVJvNg4WRlsr6zLNFVIomKlOBopipn1WETSwIsizgt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKjuJtle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030D4C4CEF1;
	Tue,  2 Dec 2025 18:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764699883;
	bh=k3V28RTPY5VT9Tip6bfIi7nFwEC9oVqpNiX9i4oiutg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VKjuJtlebsqU1wxAFrfYexPIfAcvTXXtBEqBPW8ssRyVDr0fSTiJya5iBDIKEc7dR
	 xwjeqRgHYetaMUxQNd6XlvXadXjqH9Tqa1RunEOfbGvppKupqWHt/qWKwJ+wXLk8v2
	 bqvi853QckYiI2324evqJMguxknwU11O8a0Cyh4PMFNIxVUv8bj93gb72uasIox7QC
	 vDU6HGAEZtWe5WqXO1qa2ked15He5cI5W8YiGhrkXZ4HY+9+VD1/sxPt2gmuEEnctx
	 XNS4K7CYNFri/flfg65EY4HwAY0bRQhX7MZNfXUAsKaromXc0ClKy8RejhEQwNh0NO
	 pi1v1fGedEELQ==
Date: Tue, 2 Dec 2025 10:24:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org,
 kernel-team@meta.com, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH net-next 0/4] (no cover subject)
Message-ID: <20251202102442.568f91a7@kernel.org>
In-Reply-To: <4oybtunobxtemenpg2lg7jv4cyl3xoaxrjlqivbhs6zo72hxpu@fqp6estf5mpc>
References: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
	<20251201163622.4e50bf53@kernel.org>
	<4oybtunobxtemenpg2lg7jv4cyl3xoaxrjlqivbhs6zo72hxpu@fqp6estf5mpc>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Dec 2025 02:18:44 -0800 Breno Leitao wrote:
> On Mon, Dec 01, 2025 at 04:36:22PM -0800, Jakub Kicinski wrote:
> > On Fri, 28 Nov 2025 06:20:45 -0800 Breno Leitao wrote:  
> > > This patch series introduces a new configfs attribute that enables sending
> > > messages directly through netconsole without going through the kernel's logging
> > > infrastructure.
> > > 
> > > This feature allows users to send custom messages, alerts, or status updates
> > > directly to netconsole receivers by writing to
> > > /sys/kernel/config/netconsole/<target>/send_msg, without poluting kernel
> > > buffers, and sending msgs to the serial, which could be slow.
> > > 
> > > At Meta this is currently used in two cases right now (through printk by
> > > now):
> > > 
> > >   a) When a new workload enters or leave the machine.
> > >   b) From time to time, as a "ping" to make sure the netconsole/machine
> > >   is alive.
> > > 
> > > The implementation reuses the existing message transmission functions
> > > (send_msg_udp() and send_ext_msg_udp()) to handle both basic and extended
> > > message formats.
> > > 
> > > Regarding code organization, this version uses forward declarations for
> > > send_msg_udp() and send_ext_msg_udp() functions rather than relocating them
> > > within the file. While forward declarations do add a small amount of
> > > redundancy, they avoid the larger churn that would result from moving entire
> > > function definitions.  
> > 
> > The two questions we need to address here are :
> >  - why is the message important in the off-host message stream but not
> >    important in local dmesg stream. You mention "serial, which could be
> >    slow" - we need more details here.  
> 
> Thanks for the questions, and I would like to share my view of the world. The
> way I see and use netconsole at my company (Meta) is a "kernel message"
> on steroids, where it provides more information about the system than
> what is available in kernel log buffers (dmesg)
> 
> These netconsole messages already have extra data, which provides
> information to each message, such as:
> 
>  * scheduler configuration (for sched_ext contenxt)
>  * THP memory configuration
>  * Job/workload running
>  * CPU id
>  * task->curr name
>  * etc
>  
> So, netconsole already sends extra information today that is not visible
> on kernel console (dmesg), and this has proved to be super useful, so
> useful that 16 entries are not enough and Gustavo need to do a dynamic
> allocation instead of limiting it to 16.
> 
> On top of that, printk() has a similar mechanism where extra data is not
> printed to the console. printk buffers has a dictionary of structured
> data attached to the message that is not printed to the screen, but,
> sent through netconsole.
> 
> This feature (in this patchset) is just one step ahead, giving some more
> power to netconsole, where extra information could be sent beyond what
> is in dmesg.

Having extra metadata makes sense, since the interpretation happens in
a different environment. But here we're talking about having extra
messages, not extra metadata.

> >  - why do we need the kernel API, netcons is just a UDP message, which
> >    is easy enough to send from user space. A little bit more detail
> >    about the advantages would be good to have.  
> 
> The primary advantage is leveraging the existing configured netconsole
> infrastructure. At Meta, for example, we have a "continuous ping"
> mechanism configured by our Configuration Management software that
> simply runs 'echo "ping" > /dev/kmsg'.
> 
> A userspace solution would require deploying a binary to millons of
> machines,  parsing /sys/kernel/configfs/netconsole/cmdline0/configs
> and sends packets directly.
> 
> While certainly feasible, it's less convenient than using the
> existing infrastructure (though I may just be looking for the easier
> path here).

If this was your objective, instead of having a uAPI for sending
arbitrary message you should be adding some "keepalive" timer / empty
message sender... With the patches are posted you still need something
to run the echo.

> > The 2nd point is trivial, the first one is what really gives me pause.
> > Why do we not care about the logs on host? If the serial is very slow
> > presumably it impacts a lot of things, certainly boot speed, so...  
> 
> This is spot-on - slow serial definitely impacts things like boot speed.
> 
> See my constant complains here, about slow boot
> 
> 	https://lore.kernel.org/all/aGVn%2FSnOvwWewkOW@gmail.com/
> 
> And the something similar in reboot/kexec path:
> 
> 	https://lore.kernel.org/all/sqwajvt7utnt463tzxgwu2yctyn5m6bjwrslsnupfexeml6hkd@v6sqmpbu3vvu/
> 
> > perhaps it should be configured to only log messages at a high level?  
> 
> Chris is actually working on per-console log levels to solve exactly
> this problem, so we could filter serial console messages while keeping
> everything in other consoles (aka netconsole):
> 
> 	https://lore.kernel.org/all/cover.1764272407.git.chris@chrisdown.name/

Excellent! Unless I'm missing more context Chris does seem to be
attacking the problem at a more suitable layer.

> That work has been in progress for years though, and I'm not sure
> when/if it'll land upstream. But if it does, we'd be able to have
> different log levels per console and then use your suggested approach.
> 
> Thanks for the review, and feel free to yell at me if I am missing the
> point,
> --breno
> 


