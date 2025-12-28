Return-Path: <linux-kselftest+bounces-47981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91915CE4B87
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Dec 2025 13:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D40F53004E32
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Dec 2025 12:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC9D26ED28;
	Sun, 28 Dec 2025 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6Hpm5WT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ojd+fYAW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EB72C11F5
	for <linux-kselftest@vger.kernel.org>; Sun, 28 Dec 2025 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766924069; cv=none; b=nFxnc/v43P9t4pBFsYItk9V/94Zmr1d2dh/p5V+ZOXbBqlWu9q2FHXn3KlaOHgATf6ZwVqqHto2hGfEvA3tXyj4ph85ppxolXeAYqi9vqYot/bgu5ZJP5go6/pZ0W1vJxll66cg1j0UNdh/kqw34OacaNr3qZbXwp9iy9Orq/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766924069; c=relaxed/simple;
	bh=FtVcvjSqO79VVhAexiQ8Tk6eQRe2bnLHlHrLLXC2qLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBtM/kAOIn4FdCGOaQOm+DTiXaPbe1M/EJ1RxHkMpsPZ2uBpNzXgHlC+5/4x9Kozl4x5OLJUR1tCWSTEmnI731nabxk0WO47EqfsXQ/IMxZ16FBmtTsxpXl7FV4ZcDqlzsovKN7GM+v4pyvHjS0nh1gBYxGmo3PfSzmqcqNtfiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T6Hpm5WT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ojd+fYAW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766924063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hb94p/3fW6d+zrjNPqtXlJMQflYVyrGPy+23bPGAbt4=;
	b=T6Hpm5WTRHY7hHYTdBIPiypwSh5zdmRY6iIvFOJ0nxR2M/3a0XqlAwTw9/oAv0iCup2eBz
	cOBsHWE4/lpuk3EFBlt54MirvGsUJWeQaXGZ+pWCOO3hdWz9Ux6Q/ZTO9G+AuaZbidSnI3
	c0kFtaRWNL3mIcPxLIsR3eczlKkH/mo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-CkIqG_UkMdqBuPiFfhST7g-1; Sun, 28 Dec 2025 07:14:13 -0500
X-MC-Unique: CkIqG_UkMdqBuPiFfhST7g-1
X-Mimecast-MFC-AGG-ID: CkIqG_UkMdqBuPiFfhST7g_1766924052
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430f8866932so6757220f8f.1
        for <linux-kselftest@vger.kernel.org>; Sun, 28 Dec 2025 04:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766924052; x=1767528852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hb94p/3fW6d+zrjNPqtXlJMQflYVyrGPy+23bPGAbt4=;
        b=ojd+fYAWW18I3d/0CJqUhGSxyzzvsReXbb7acrRNDj24AO18YJ1dIa/8akDyNkwc+9
         neaRI2S1oYkvDXygWJ2Kpjp2NfPlea8UczGg/ZDhhGN26w4x0HQQpVHO7Ip71NqfrBLF
         fCaSG6lVak9PGwnb6wfGV1MwismkuhjpIp3Kv5OY7y/GybW0X0ZupAku02tJwdLeJGMQ
         Efqb0aumCgoXOrtLRNMH07R/WAj4Wobl/IDyL3l2dikGKSr5cNfQKzXwlO+/I6PXkxkT
         C04y/7svEuimzDg+ODpyym5bHMx2pqK06dXoHjQjCFYXCLBIMkS3N3xdERbgx7HTnJoi
         KRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766924052; x=1767528852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hb94p/3fW6d+zrjNPqtXlJMQflYVyrGPy+23bPGAbt4=;
        b=oGs3aH/I5G07RqL9Hk0v57ajH1xARXXX5CwvzusmSgdERhpMqEd4++753ty796Q13s
         IPKquwcL9KUBj44OfR9tVk5bDptgnHrQiQg3sdeK+dK6swY7sdPFZsXWZryGseVtZaq0
         zxNRzIAIG0PbjG0Y/Vsxfmb3FriErHOg0PeiU61dET6/xnb/zGqeJkdkTtr7DLmuy663
         rmJtvDnS+hIjWCE1HzjHL/04E0cKjyt6HwtvJw6rM6qfatOzvL8/+5J3Bzsh6IgZXcLe
         aOUDbK0GV1O9xcDJoqop1gmtOjP7FNEaOgScDvDxxj8a34GC7MU2A6QTTHkY0U8CLsoa
         2J3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/BYwPBx/QuJoiDvEmWugMqrPBRHmwBrA6w0qRSWmIoKfENYdlaejKgnFAlE5m8JJ77/kW8u99kzJDBj4k2+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP9MGpvSixgeA5gtDwxOzUfiyOIPxwSI3pP6Fcyz3X50I5BBFl
	IJzp+JiZyzeWrmmloDKqo00b3l4KkRLL3wplOEIaujkjrC+A/1vaH5jQLKcHc9aJe8/ADwFGFy3
	XM7D1KlzMeEmFwNN9Nr0QNnubzwQY39F1OkR/xfdeeePiIQg67osZ8duEyzxqWkMLxzZK+g==
X-Gm-Gg: AY/fxX6989WHUtjhK8io5smHRN5Wi4xF8OhoZfWNiHZpmxsaDuDcmDq2SelWLZKXcO4
	POIhhQ8/yz5zFO3Tw8eea8psz+cqrGFN066uJsN5DSQF79vY30/sGUKZHt0+6SLVn6tN8z12HU2
	jV87O1wz8E7ZeetNasN9WwvphcvmqATlsjN1Ktu6te4K+7TRvQ1n2qBVLftDJAJhV4/xipd/nZX
	vyw5XI1fPvCmjvZGT5IcfEVq4KzlMpvDBbkdfEh+zvQHssL4WHCPsldvL75lUZNgBVMw27QIWis
	PX3ocWvmXQu8rFOypt3XibDbuikZNQk0kluJLpZrjpYQTN1SM8FB+Gaj4enC9rN1AKicZ+Fu8o9
	3LflrBEC+YpZjrw==
X-Received: by 2002:a05:6000:40ce:b0:42f:bad7:af76 with SMTP id ffacd0b85a97d-4324e4cc00amr39273453f8f.15.1766924051785;
        Sun, 28 Dec 2025 04:14:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9s6P8gOpSpbWlos80FLDLxQgg0IlYWd5InaHc47tKRrvQ/Asn43slk7o17Wv+jnvFEa+z9Q==
X-Received: by 2002:a05:6000:40ce:b0:42f:bad7:af76 with SMTP id ffacd0b85a97d-4324e4cc00amr39273422f8f.15.1766924051343;
        Sun, 28 Dec 2025 04:14:11 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa4749sm57106837f8f.37.2025.12.28.04.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 04:14:10 -0800 (PST)
Message-ID: <16fa929d-db04-48f5-a350-a31d23f8327c@redhat.com>
Date: Sun, 28 Dec 2025 13:14:09 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftests: net: simple selftest for ipvtap
To: Dmitry Skorodumov <dskr99@gmail.com>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20251225185543.1459044-1-skorodumov.dmitry@huawei.com>
 <20251225185543.1459044-3-skorodumov.dmitry@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251225185543.1459044-3-skorodumov.dmitry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/25/25 7:55 PM, Dmitry Skorodumov wrote:
> diff --git a/tools/testing/selftests/net/ipvtap_test.sh b/tools/testing/selftests/net/ipvtap_test.sh
> new file mode 100755
> index 000000000000..751793f26fed
> --- /dev/null
> +++ b/tools/testing/selftests/net/ipvtap_test.sh
> @@ -0,0 +1,168 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Simple tests for ipvtap
> +
> +
> +#
> +# The testing environment looks this way:
> +#
> +# |------HOST------|     |------PHY-------|
> +# |      veth<----------------->veth      |
> +# |------|--|------|     |----------------|
> +#        |  |
> +#        |  |            |-----TST0-------|
> +#        |  |------------|----ipvlan      |
> +#        |               |----------------|
> +#        |
> +#        |               |-----TST1-------|
> +#        |---------------|----ipvlan      |
> +#                        |----------------|
> +#
> +
> +ALL_TESTS="
> +	test_ip_set
> +"
> +
> +source lib.sh
> +
> +DEBUG=0
> +
> +VETH_HOST=vethtst.h
> +VETH_PHY=vethtst.p
> +
> +NS_COUNT=32
> +IP_ITERATIONS=1024
> +
> +ns_run() {
> +	ns=$1
> +	shift
> +	if [[ "$ns" == "global" ]]; then
> +		"$@" >/dev/null
> +	else
> +		ip netns exec "$ns" "$@" >/dev/null
> +	fi
> +}
> +
> +test_ip_setup_env() {
> +	modprobe -q tap
> +	modprobe -q ipvlan
> +	modprobe -q ipvtap
> +
> +	setup_ns NS_PHY
> +
> +	# setup simulated other-host (phy) and host itself
> +	ip link add $VETH_HOST type veth peer name $VETH_PHY \
> +		netns "$NS_PHY" >/dev/null

It would be better to avoid creating devices in the main netns.

> +	ip link set $VETH_HOST up
> +	ns_run "$NS_PHY" ip link set $VETH_PHY up
> +
> +	for ((i=0; i<NS_COUNT; i++)); do
> +		setup_ns ipvlan_ns_$i
> +		ns="ipvlan_ns_$i"
> +		if [ "$DEBUG" = "1" ]; then
> +			echo "created NS ${!ns}"
> +		fi
> +		if ! ip link add netns ${!ns} ipvlan0 link $VETH_HOST \
> +		    type ipvtap mode l2 bridge; then
> +			exit_error "FAIL: Failed to configure ipvlan link."
> +		fi
> +	done
> +}
> +
> +test_ip_cleanup_env() {
> +	ip link del $VETH_HOST
> +	cleanup_all_ns
> +}
> +
> +exit_error() {
> +	echo "$1"
> +	exit $ksft_fail
> +}
> +
> +rnd() {
> +	echo $(( RANDOM % 32 + 16 ))
> +}
> +
> +test_ip_set_thread() {
> +	ip link set ipvlan0 up
> +	for ((i=0; i<IP_ITERATIONS; i++)); do
> +		v=$(rnd)
> +		ip a a "172.25.0.$v/24" dev ipvlan0 2>/dev/null
> +		ip a a "fc00::$v/64" dev ipvlan0 2>/dev/null
> +		v=$(rnd)
> +		ip a d "172.25.0.$v/24" dev ipvlan0 2>/dev/null
> +		ip a d "fc00::$v/64" dev ipvlan0 2>/dev/null

It's unclear to me why the above tries to remove random addresses
different from the ones just added (possibly not existing)

> +	done
> +}
> +
> +test_ip_set() {
> +	RET=0
> +
> +	modprobe -q tap
> +	modprobe -q ipvlan
> +	modprobe -q ipvtap
> +
> +	trap test_ip_cleanup_env EXIT
> +
> +	test_ip_setup_env
> +
> +	declare -A ns_pids
> +	for ((i=0; i<NS_COUNT; i++)); do
> +		ns="ipvlan_ns_$i"
> +		ns_run ${!ns} bash -c "$0 test_ip_set_thread"&
> +		ns_pids[$i]=$!
> +	done
> +
> +	for ((i=0; i<NS_COUNT; i++)); do
> +		wait "${ns_pids[$i]}"
> +	done

This tests fails quite often in debug build due to timeout, see:

https://netdev.bots.linux.dev/flakes.html?tn-needle=ipvtap

and i.e.

https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-dbg/results/447821/5-ipvtap-test-sh/

You should likely decrease the thread and/or iterations count, at least
for debug builds

/P


