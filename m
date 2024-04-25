Return-Path: <linux-kselftest+bounces-8850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEDB8B1C11
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 09:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B03287C40
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 07:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7D86CDCF;
	Thu, 25 Apr 2024 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPzsPXUb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A00535A5;
	Thu, 25 Apr 2024 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714030832; cv=none; b=kJEWYBdVydVoytvuTO8rRUeyXYegZON4EUWblILQTxavERsvI8+uCrzbQWH/YvKrrOpyjG0VDWTk9+KZow45FZU1AFp/nOS0z8wTFg80FGIiQ4v0ITCf4I0Xm8nnV5b3+ieiUo54cGzZWoX2l1M6L9mxH1mu2qwU9+0+2rUJL1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714030832; c=relaxed/simple;
	bh=jxUjSurJIK9zcEy2xavAu3Z8R4gr7shDw+2MqyhHB4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfHSaFKgatpczBYsDUVW7jJv/AUJNAXUxah3rtK7GqPOncG83mA2iwL2gWCYW2LNH8CEGkbk9NeKmMADqytLYU25nAW7l19miCwxLIHkDseVsKWhEnAFy6byARFfE1UpqwxmWoetHD2ZQp/tOBsB4ySiBxf3X6UVNNGIq2FNsMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPzsPXUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DADC113CC;
	Thu, 25 Apr 2024 07:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714030830;
	bh=jxUjSurJIK9zcEy2xavAu3Z8R4gr7shDw+2MqyhHB4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VPzsPXUbPGnRTaq7+yhC0YWd001j7wrKwnguF+pxWJ82j2XL+5zlbtCvgNY4LXUYw
	 kPj0pXLNU9L8tNRmgWyAz+SH59+63U1fUxim1gcrQbWEX+r/u/+on/FnyJPSONXZOx
	 3uRt58JpkA8azIhO6KpA6AIOEIO6H+mnwB30SVuBbv8/vC7NkoTPp+rgNYUvPE8zJY
	 RFoKiNEvRPTauaPL9XK4yTsmRLFJO7qy4TpOLygC6gf7kgYrH4t1cRYPmDXjQMFFVF
	 GfcIFHfvlCmmGgAwZ5GH6AM7UoaduW5SE0ArBDRgR+mNv+WhuJD6sl2avfdelxqA9S
	 5ohmDpU8bm9bA==
Date: Thu, 25 Apr 2024 08:40:27 +0100
From: Simon Horman <horms@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	dev@openvswitch.org, linux-kselftest@vger.kernel.org
Subject: Re: selftests: openvswitch: Questions about possible enhancements
Message-ID: <20240425074027.GT42092@kernel.org>
References: <20240424164405.GN42092@kernel.org>
 <f7tle52aary.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7tle52aary.fsf@redhat.com>

On Wed, Apr 24, 2024 at 02:14:09PM -0400, Aaron Conole wrote:
> Simon Horman <horms@kernel.org> writes:
> 
> > Hi Aaron, Jakub, all,
> >
> > I have recently been exercising the Open vSwitch kernel selftests,
> > using vng, something like this:
> >
> > 	TESTDIR="tools/testing/selftests/net/openvswitch"
> >
> >         vng -v --run . --user root --cpus 2 \
> >                 --overlay-rwdir "$PWD" -- \
> >                 "modprobe openvswitch && \
> > 		 echo \"timeout=90\" >> \"${TESTDIR}/settings\" && \
> >                  make -C \"$TESTDIR\" run_tests"
> >
> > And I have some observations that I'd like to ask about.
> >
> > 1. Building the kernel using the following command does not
> >    build the openvswitch kernel module.
> >
> > 	vng -v --build \
> > 		--config tools/testing/selftests/net/config
> >
> >    All that seems to be missing is CONFIG_OPENVSWITCH=m
> >    and I am wondering what the best way of resolving this is.
> >
> >    Perhaps I am doing something wrong.
> >    Or perhaps tools/testing/selftests/net/openvswitch/config
> >    should be created? If so, should it include (most of?) what is in
> >    tools/testing/selftests/net/config, or just CONFIG_OPENVSWITCH=m?
> 
> I have a series that I need to get back to fixing:
> 
> https://mail.openvswitch.org/pipermail/ovs-dev/2024-February/411917.html
> 
> which does include the config listed, and some of the fixes for things
> you've noted.
> 
> I think it makes sense to get back to it.

Thanks Aaron,

I was hoping you might say something like that.

WRT to the config itself, as Benjamin mentioned elsewhere in this thread [1]
there is a question about how this should be handled consistently for
all selftests.

[1] https://lore.kernel.org/netdev/ZilIgbIvB04iUal2@f4/

> 
> > 2. As per my example above, it seems that a modprobe openvswitch is
> >    required (if openvswitch is a module).
> >
> >    Again, perhaps I am doing something wrong. But if not, should this be
> >    incorporated into tools/testing/selftests/net/openvswitch/openvswitch.sh
> >    or otherwise automated?
> >
> > 3. I have observed that the last test fails (yesterday, but not today!),
> >    because the namespace it tries to create already exists. I believe this
> >    is because it is pending deletion.
> >
> >    My work-around is as follows:
> >
> >  ovs_add_netns_and_veths () {
> >  	info "Adding netns attached: sbx:$1 dp:$2 {$3, $4, $5}"
> > +	for i in $(seq 10); do
> > +		ovs_sbx "$1" test -e "/var/run/netns/$3" || break
> > +		info "Namespace $3 still exists (attempt $i)"
> > +		ovs_sbx "$1" ip netns del "$3"
> > +		sleep "$i"
> > +	done
> >  	ovs_sbx "$1" ip netns add "$3" || return 1
> >  	on_exit "ovs_sbx $1 ip netns del $3"
> >  	ovs_sbx "$1" ip link add "$4" type veth peer name "$5" || return 1
> >
> >    N.B.: the "netns del" part is probably not needed,
> >    but I'm not able to exercise it effectively right now.
> >
> >    I am wondering if a loop like this is appropriate to add, perhaps also
> >    to namespace deletion. Or if it would be appropriate to port
> >    openvswitch.sh to use ./tools/testing/selftests/net/lib.sh, which I
> >    believe handles this.
> >
> > 4. I am observing timeouts whith the default value of 45s.
> >    Bumping this to 90s seems to help.
> >    Are there any objections to a patch to bump the timeout?

Regarding points 3 and 4.

I did a bit more testing after I sent my email yesterday.
I have two test machines. It turns out, to my surprise, that one is
much slower than the other when running openvswitch.sh with vng.

I am unsure why, but that isn't really on topic. The point
is that I'm currently only seeing problems 3 and 4 manifest
on the slow machine.

I think problem 3 is probably worth solving.
But the timeout question is more subjective.

