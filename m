Return-Path: <linux-kselftest+bounces-8881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 482928B2951
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 22:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0E1328485A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 20:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF77D15252B;
	Thu, 25 Apr 2024 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="goRD5rco"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114AC1509B1
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075217; cv=none; b=ldM6d/57xpLrftLMpKgLvYdlDBzSpWaA9pVZYcOkCATZHdmXPf7BCa4JMODAUbftszs2MQyLAVMb39U7s0FYFR/ZucNjtEkF9x5og6sV/FJe/rPdMSdRXS4X9nBs8KeygPXzemYLgzFKqf6VSqUhFxOHPt7uD+D0VNjnMNpc5xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075217; c=relaxed/simple;
	bh=4SBHmlM/DwLN6vjzmDy32/v///NdTA56+HqE/M7aIFA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uvFlzrKiA4GmyxH+6HVfte2NeF0qIn6PDP6MCusP+/P3sdRuYgZBjYIWY00DXxjo5DE63A1Rx+lnOPFUzapwJ2ys3XPl3ewwJ/781mRZcf07m15aIfAteIsciVGbNf2DRySLBXHutWlXlGalfhQN8Jd9AD05q5adOfE9+AEI1bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=goRD5rco; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714075215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VewSKM/1Xq58jPkl/ASD8uFVpdzrHreTvytM9E8o4gY=;
	b=goRD5rco/mZgtBdEvQy6MX5aTNeJXVcbpIhWVzDpS7oY47oYMZVM0wXcHY5sl0sV14DqEU
	CqL/LBDGhUJO+XRkNocdBAaVxDhCxMlspOIa5+YGbBFMG/0HdJQvPGRNNdSFYgE3SKXd5z
	VjftrxqYfVLZoAhPXN4QDWmY4Jcezik=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-2N3koFHRM6OgxN8s2SU1mA-1; Thu, 25 Apr 2024 16:00:11 -0400
X-MC-Unique: 2N3koFHRM6OgxN8s2SU1mA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7C0B80B3DD;
	Thu, 25 Apr 2024 20:00:09 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.33.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 77C0A6958;
	Thu, 25 Apr 2024 20:00:09 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,  netdev@vger.kernel.org,
  dev@openvswitch.org,  linux-kselftest@vger.kernel.org
Subject: Re: selftests: openvswitch: Questions about possible enhancements
In-Reply-To: <20240425074027.GT42092@kernel.org> (Simon Horman's message of
	"Thu, 25 Apr 2024 08:40:27 +0100")
References: <20240424164405.GN42092@kernel.org> <f7tle52aary.fsf@redhat.com>
	<20240425074027.GT42092@kernel.org>
Date: Thu, 25 Apr 2024 16:00:09 -0400
Message-ID: <f7twmol8b7a.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Simon Horman <horms@kernel.org> writes:

> On Wed, Apr 24, 2024 at 02:14:09PM -0400, Aaron Conole wrote:
>> Simon Horman <horms@kernel.org> writes:
>> 
>> > Hi Aaron, Jakub, all,
>> >
>> > I have recently been exercising the Open vSwitch kernel selftests,
>> > using vng, something like this:
>> >
>> > 	TESTDIR="tools/testing/selftests/net/openvswitch"
>> >
>> >         vng -v --run . --user root --cpus 2 \
>> >                 --overlay-rwdir "$PWD" -- \
>> >                 "modprobe openvswitch && \
>> > 		 echo \"timeout=90\" >> \"${TESTDIR}/settings\" && \
>> >                  make -C \"$TESTDIR\" run_tests"
>> >
>> > And I have some observations that I'd like to ask about.
>> >
>> > 1. Building the kernel using the following command does not
>> >    build the openvswitch kernel module.
>> >
>> > 	vng -v --build \
>> > 		--config tools/testing/selftests/net/config
>> >
>> >    All that seems to be missing is CONFIG_OPENVSWITCH=m
>> >    and I am wondering what the best way of resolving this is.
>> >
>> >    Perhaps I am doing something wrong.
>> >    Or perhaps tools/testing/selftests/net/openvswitch/config
>> >    should be created? If so, should it include (most of?) what is in
>> >    tools/testing/selftests/net/config, or just CONFIG_OPENVSWITCH=m?
>> 
>> I have a series that I need to get back to fixing:
>> 
>> https://mail.openvswitch.org/pipermail/ovs-dev/2024-February/411917.html
>> 
>> which does include the config listed, and some of the fixes for things
>> you've noted.
>> 
>> I think it makes sense to get back to it.
>
> Thanks Aaron,
>
> I was hoping you might say something like that.
>
> WRT to the config itself, as Benjamin mentioned elsewhere in this thread [1]
> there is a question about how this should be handled consistently for
> all selftests.
>
> [1] https://lore.kernel.org/netdev/ZilIgbIvB04iUal2@f4/

Yeah, I think it makes sense.  There are probably some other bashisms
beyond the substitution noted.  I'll add it to the RFC and rework.

>> 
>> > 2. As per my example above, it seems that a modprobe openvswitch is
>> >    required (if openvswitch is a module).
>> >
>> >    Again, perhaps I am doing something wrong. But if not, should this be
>> >    incorporated into tools/testing/selftests/net/openvswitch/openvswitch.sh
>> >    or otherwise automated?
>> >
>> > 3. I have observed that the last test fails (yesterday, but not today!),
>> >    because the namespace it tries to create already exists. I believe this
>> >    is because it is pending deletion.
>> >
>> >    My work-around is as follows:
>> >
>> >  ovs_add_netns_and_veths () {
>> >  	info "Adding netns attached: sbx:$1 dp:$2 {$3, $4, $5}"
>> > +	for i in $(seq 10); do
>> > +		ovs_sbx "$1" test -e "/var/run/netns/$3" || break
>> > +		info "Namespace $3 still exists (attempt $i)"
>> > +		ovs_sbx "$1" ip netns del "$3"
>> > +		sleep "$i"
>> > +	done
>> >  	ovs_sbx "$1" ip netns add "$3" || return 1
>> >  	on_exit "ovs_sbx $1 ip netns del $3"
>> >  	ovs_sbx "$1" ip link add "$4" type veth peer name "$5" || return 1
>> >
>> >    N.B.: the "netns del" part is probably not needed,
>> >    but I'm not able to exercise it effectively right now.
>> >
>> >    I am wondering if a loop like this is appropriate to add, perhaps also
>> >    to namespace deletion. Or if it would be appropriate to port
>> >    openvswitch.sh to use ./tools/testing/selftests/net/lib.sh, which I
>> >    believe handles this.
>> >
>> > 4. I am observing timeouts whith the default value of 45s.
>> >    Bumping this to 90s seems to help.
>> >    Are there any objections to a patch to bump the timeout?
>
> Regarding points 3 and 4.
>
> I did a bit more testing after I sent my email yesterday.
> I have two test machines. It turns out, to my surprise, that one is
> much slower than the other when running openvswitch.sh with vng.
>
> I am unsure why, but that isn't really on topic. The point
> is that I'm currently only seeing problems 3 and 4 manifest
> on the slow machine.
>
> I think problem 3 is probably worth solving.
> But the timeout question is more subjective.


