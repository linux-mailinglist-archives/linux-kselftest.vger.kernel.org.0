Return-Path: <linux-kselftest+bounces-8804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6CC8B1132
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 19:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB531C22C78
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 17:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2D816D4C5;
	Wed, 24 Apr 2024 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOFsRLZk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BC616D30C;
	Wed, 24 Apr 2024 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980240; cv=none; b=R26MwGzDqh98l87upN1jQZ109Qoamc8DOb8Ru87YT9dpvCU9vklC2ErCJ+8x0WerE38INkT+YotOvFrSTyuUkMFlhfvTeqfgdq2QqfMMFzpQ/+w1zqvqQ9mEASQB902euxH9InZU81k+Up0SIe3ud2TeQKYNqcr5kFyWaM898i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980240; c=relaxed/simple;
	bh=JnovASLeapfhZvV2fH8by4Rx0h4Y4TLWSbfxwjcOz80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFoWz6AzmKlHMT9620003VnFGd9CQv3oXr6oQIg3EPtuDzaRLhaw5aa3LYYf7yiLshl5YBpMgQF0nNNz9/PyhsSLIAjjqPK7i0ZUhbILSqtClw2C6ZxpjDFniSpsES2sfdrE2qDTiIGFKkaAKUd/kz2WJnmgRq5OTMnoowh5nGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOFsRLZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91637C113CD;
	Wed, 24 Apr 2024 17:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713980239;
	bh=JnovASLeapfhZvV2fH8by4Rx0h4Y4TLWSbfxwjcOz80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SOFsRLZk1ZXCgEBL65AqtKNy4F6nkllUs/LXZQE71UVuAmFRLsQHKJp20FQW3veY/
	 +U/d5gTpoWsCeOEp89wVP/5tC5+DLuXZbDazvCnEhNyz7d+ciVT8PGcMN5avf/xIvE
	 P0UrCU9VkKUbyMpLfeux0xIRi1ciPmgb4fC2o4M1FXDr5zlLZxGbFmJwW+au2rbP0Y
	 TPDHK89PtI7bJ33Sr2kHErKy06mUMXXHmDcCnTUfh73HRgn1lr8nJ9M9DgkB0C5BSH
	 oTb3wxDanEjSMRMDXeAhP6xb72nm+6Gbv9pBfcWp4CAxVQqiA6CfANCQTU7FmNQ+60
	 ApPkduo0kzaOg==
Date: Wed, 24 Apr 2024 18:37:16 +0100
From: Simon Horman <horms@kernel.org>
To: Aaron Conole <aconole@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: dev@openvswitch.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [ovs-dev] selftests: openvswitch: Questions about possible
 enhancements
Message-ID: <20240424173715.GP42092@kernel.org>
References: <20240424164405.GN42092@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424164405.GN42092@kernel.org>

On Wed, Apr 24, 2024 at 05:44:05PM +0100, Simon Horman wrote:
> Hi Aaron, Jakub, all,
> 
> I have recently been exercising the Open vSwitch kernel selftests,
> using vng, something like this:
> 
> 	TESTDIR="tools/testing/selftests/net/openvswitch"
> 
>         vng -v --run . --user root --cpus 2 \
>                 --overlay-rwdir "$PWD" -- \
>                 "modprobe openvswitch && \
> 		 echo \"timeout=90\" >> \"${TESTDIR}/settings\" && \
>                  make -C \"$TESTDIR\" run_tests"
> 
> And I have some observations that I'd like to ask about.
> 
> 1. Building the kernel using the following command does not
>    build the openvswitch kernel module.
> 
> 	vng -v --build \
> 		--config tools/testing/selftests/net/config
> 
>    All that seems to be missing is CONFIG_OPENVSWITCH=m
>    and I am wondering what the best way of resolving this is.
> 
>    Perhaps I am doing something wrong.
>    Or perhaps tools/testing/selftests/net/openvswitch/config
>    should be created? If so, should it include (most of?) what is in
>    tools/testing/selftests/net/config, or just CONFIG_OPENVSWITCH=m?
> 
> 2. As per my example above, it seems that a modprobe openvswitch is
>    required (if openvswitch is a module).
> 
>    Again, perhaps I am doing something wrong. But if not, should this be
>    incorporated into tools/testing/selftests/net/openvswitch/openvswitch.sh
>    or otherwise automated?
> 
> 3. I have observed that the last test fails (yesterday, but not today!),
>    because the namespace it tries to create already exists. I believe this
>    is because it is pending deletion.
> 
>    My work-around is as follows:
> 
>  ovs_add_netns_and_veths () {
>  	info "Adding netns attached: sbx:$1 dp:$2 {$3, $4, $5}"
> +	for i in $(seq 10); do
> +		ovs_sbx "$1" test -e "/var/run/netns/$3" || break
> +		info "Namespace $3 still exists (attempt $i)"
> +		ovs_sbx "$1" ip netns del "$3"
> +		sleep "$i"
> +	done
>  	ovs_sbx "$1" ip netns add "$3" || return 1
>  	on_exit "ovs_sbx $1 ip netns del $3"
>  	ovs_sbx "$1" ip link add "$4" type veth peer name "$5" || return 1
> 
>    N.B.: the "netns del" part is probably not needed,
>    but I'm not able to exercise it effectively right now.
> 
>    I am wondering if a loop like this is appropriate to add, perhaps also
>    to namespace deletion. Or if it would be appropriate to port
>    openvswitch.sh to use ./tools/testing/selftests/net/lib.sh, which I
>    believe handles this.
> 
> 4. I am observing timeouts whith the default value of 45s.
>    Bumping this to 90s seems to help.
>    Are there any objections to a patch to bump the timeout?

  5. openvswitch.sh starts with "#!/bin/sh".
     But substitutions such as "${ns:0:1}0"  fail if /bin/sh is dash.
     Perhaps we should change openvswitch.sh to use bash?

