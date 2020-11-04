Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A281F2A6C94
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Nov 2020 19:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbgKDSTS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Nov 2020 13:19:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30633 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730061AbgKDSTS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Nov 2020 13:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604513956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I1fdCJPYIPXbd2SBDUaXIgOsXxGZIfqs2uV1OkjLCHg=;
        b=iJAimpanfkCVPO3DOzUU88de+CJWPVt3+hwAxwx2Frqxo7maDBc9RCMBlgQ9wuG8BX2YTg
        0avA/UBlhMBC5AJ2A56tn8Rci63zz5OuFvJX6DMkHgXsF3NVWzGrxHdYz+jMfmZOGh9Ix8
        q6EZC62+6NVuaiYjYMIFvuSeqbjhJXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-mHHtnIZVO9mdhbUFx7KpiQ-1; Wed, 04 Nov 2020 13:19:12 -0500
X-MC-Unique: mHHtnIZVO9mdhbUFx7KpiQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4942511CC7E9;
        Wed,  4 Nov 2020 18:19:10 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 998F75B4DC;
        Wed,  4 Nov 2020 18:19:09 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 1DC91416C894; Wed,  4 Nov 2020 15:18:48 -0300 (-03)
Date:   Wed, 4 Nov 2020 15:18:48 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Saeed Mahameed <saeed@kernel.org>, netdev@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net-next v2 0/3] net: introduce rps_default_mask
Message-ID: <20201104181848.GA227702@fuller.cnet>
References: <cover.1604055792.git.pabeni@redhat.com>
 <20201102145447.0074f272@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <86c37d881a93d5690faf20de3bccceca1493fd74.camel@redhat.com>
 <20201103085245.3397defa@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <79c58e6cf23196b73887b20802daebd59fe89476.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79c58e6cf23196b73887b20802daebd59fe89476.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 04, 2020 at 06:36:08PM +0100, Paolo Abeni wrote:
> On Tue, 2020-11-03 at 08:52 -0800, Jakub Kicinski wrote:
> > On Tue, 03 Nov 2020 16:22:07 +0100 Paolo Abeni wrote:
> > > The relevant use case is an host running containers (with the related
> > > orchestration tools) in a RT environment. Virtual devices (veths, ovs
> > > ports, etc.) are created by the orchestration tools at run-time.
> > > Critical processes are allowed to send packets/generate outgoing
> > > network traffic - but any interrupt is moved away from the related
> > > cores, so that usual incoming network traffic processing does not
> > > happen there.
> > > 
> > > Still an xmit operation on a virtual devices may be transmitted via ovs
> > > or veth, with the relevant forwarding operation happening in a softirq
> > > on the same CPU originating the packet. 
> > > 
> > > RPS is configured (even) on such virtual devices to move away the
> > > forwarding from the relevant CPUs.
> > > 
> > > As Saeed noted, such configuration could be possibly performed via some
> > > user-space daemon monitoring network devices and network namespaces
> > > creation. That will be anyway prone to some race: the orchestation tool
> > > may create and enable the netns and virtual devices before the daemon
> > > has properly set the RPS mask.
> > > 
> > > In the latter scenario some packet forwarding could still slip in the
> > > relevant CPU, causing measurable latency. In all non RT scenarios the
> > > above will be likely irrelevant, but in the RT context that is not
> > > acceptable - e.g. it causes in real environments latency above the
> > > defined limits, while the proposed patches avoid the issue.
> > > 
> > > Do you see any other simple way to avoid the above race?
> > > 
> > > Please let me know if the above answers your doubts,
> > 
> > Thanks, that makes it clearer now.
> > 
> > Depending on how RT-aware your container management is it may or may not
> > be the right place to configure this, as it creates the veth interface.
> > Presumably it's the container management which does the placement of
> > the tasks to cores, why is it not setting other attributes, like RPS?
> 
> The container orchestration is quite complex, and I'm unsure isolation
> and networking configuration are performed (or can be performed) by the
> same precess (without an heavy refactor).

Also for the host side (no containers) the same issue will have to be handled 
for PCI hotplug for example. So this fix  will have to be performed in 
every tool that decides to create a network device (while a kernel
solution is global).

> On the flip hand, the global rps mask knob looked quite
> straightforward to me.
> 
> Possibly I can reduce the amount of new code introduced by this
> patchset removing some code duplication
> between rps_default_mask_sysctl() and flow_limit_cpu_sysctl(). Would
> that make this change more acceptable? Or should I drop this
> altogether?
> 
> > Also I wonder if it would make sense to turn this knob into something
> > more generic. When we arrive at the threaded NAPIs - could it make
> > sense for the threads to inherit your mask as the CPUs they are allowed
> > to run on?
> 
> I personally *think* this would be fine - and good. But isn't a bit
> premature discussing the integration of 2 missing pieces ? :)
> 
> Thanks,
> 
> Paolo

About the potential race:

0) network device creation starts, inherits old default_rps_mask,
network device init sleeps
1) set default_rps_mask (new) 
2) change all devices across all network namespaces (walk /sys)
3) network device init wakes up, new device shows up in /sys/ using old default_rps_mask

Why this can't happen?




