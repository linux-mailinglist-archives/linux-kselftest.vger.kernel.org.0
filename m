Return-Path: <linux-kselftest+bounces-46438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9E9C8575D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 15:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 512F44E15BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 14:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEDB32692C;
	Tue, 25 Nov 2025 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLGezGAr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXXRfgZc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152DE32572F
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081610; cv=none; b=sL9l95Ynlc8ssLK5Lh6OojUB2/hZQ16SZHDxGn6Bdkc/CD3hmmVoB5M30jSSMtASvh4iE4CSD0wi6C1+dZPSP32ZR/ajFc/5qlvKQlPsQx18ASSBlFjindoekK70LjQZzP+lN+/K77yAX1emKLvwvmG6gcqpSqbE/tmdZaUeJTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081610; c=relaxed/simple;
	bh=q1IiVjIt9YL3X0z8+fKySuASLmhHi9xnE3naPm0SRvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3BExd9rXtKovYvl1E5mO3BeBws9BlbxUvH52igOzzIi/A3//7tXUupcTmleZx0I4YYuRbKR/sL/CQ+rTfcH4ZkPxVcmK56+ZNrPcq8EI4Z1Ej0+88zosRieOtGO+Gm1VY88mIfp3KX9Kyu/W6Yatf5JGXpOBOeGzEYA46MPCY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLGezGAr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXXRfgZc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764081607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5ogNRULO41Q+K2Bde0Qs6KvHkLMydku4fyWWl5Godc=;
	b=GLGezGArDoab4oisS2Uz3NfHjIzBOQbwHxnYxLecMlHtZhYtlA/0X+vSyOyIilJpf5S01L
	xWHEAJQ6YdUqz+HH/I1BF0Ru6Zj83ITWFxv7yRtfb5VAJruyRRUK3eydIg7MTwITrjyVdR
	9rHn3a/uAs3IOuzpSUR5CaIXCxSCsI0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-cxAsyJBvPWyLwvUgz-Fxpg-1; Tue, 25 Nov 2025 09:40:05 -0500
X-MC-Unique: cxAsyJBvPWyLwvUgz-Fxpg-1
X-Mimecast-MFC-AGG-ID: cxAsyJBvPWyLwvUgz-Fxpg_1764081605
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b2fb13b79so3464507f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 06:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764081605; x=1764686405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I5ogNRULO41Q+K2Bde0Qs6KvHkLMydku4fyWWl5Godc=;
        b=IXXRfgZcsU1+Uz4qtQrADSydmZ287JYOI9olOqRU18srx9fhg0KbwdjBM23rJbSOBK
         aKyi9z/J/P6nZuXzWZi1PDf7xGNnaOM5LhKt3YggR3/VJr+w3C4sw5No6rXR+PU+iOba
         hG15RnBi5BRxZJuUqlpsPb0KqqDifTIg2aXKYmuyrxelx0HP0aS4k6Jjx9Dc41O/dab9
         mp1C6jRq/5yAFHwpjU0jZbQ1VYREg0bO8tmCBeXFJLY63bjoJ28+Q/KKA0aQSqf2YSco
         6LXvS1ELwBoCnbpllRWRNMzJMkAjlmRyxug3z4TX3FcSSneLGPYfisC/midhuaChRiC3
         nnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764081605; x=1764686405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5ogNRULO41Q+K2Bde0Qs6KvHkLMydku4fyWWl5Godc=;
        b=vTcvYukKWGPIlCXlyokf8O2EvEOsmhVaR72Q++VYHx3ybXwbTAHewOWFwAgZl8nAyo
         YmG6qS2tPCTHcopPaCmUM548uljmgEHvWp9lP/wA6JxvYsAwqx1AfyM34mzw0Vk2JtPd
         bYRrm2DSa67Kj766Lc4jY51tnryO3XWCJ1JDCZNNQ+B4jULMf5824q4t/XXEkxVmzVX4
         qbmLxObOREIgClv/mg2MfSM6faeK9sq9X9Y2M0EeUeLUWx7IRtREgUqYaeK1SedZ25Cr
         fxJwtEAdLji+ePqC2Ei+KHzu94ZWT/WkyL9Wr+TV8Cw4K+8OY1GbwnaErUZql+dpuQ9E
         6/9g==
X-Forwarded-Encrypted: i=1; AJvYcCUvtgI11iNp7ZiXeayx4EylPOwTIk3Kd/GH6q8NC8e2uvGP0+wfIz2m8+KMaCyomNpGS5SfqOjlpKP1AsOTJ7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7frpcaGex8BeRQKppnsmxrT/ha+5iGSBjWY8AUNs/r/Ajkchv
	ILH37g5OaPs2192iivlVCIldde3guuJ5HRKBsazuOywLoAIdwHdMvganCl+KX8jJymi4junMg+3
	xQ8xV0JKpTMs9Q6Zo2s2h1vfUr5/+6DYGT2Vk2VHJJEf9BmyY0R8ZPD8vcpf1xBcl6NEsDA==
X-Gm-Gg: ASbGncvh6hTTKHSW7B12W3IsvLSAMk45e7uJxPsv1YxgqmP3PZAYNeIDJAonGU2s5AM
	TWn8iebW6efRurHdSvyhzBHa0QbfQdXL0cG2dIYW2Drz02fKPVbv3Jdfl0jajjgu6LQc92/+fVK
	XysuiP1Z0yryRCkbhDGrhbKejY4Y4lF5gwVs4UeycH3+Y9P1Xfb13Glea5DDL2e9ni9wQiNlF25
	+eeUfYqE9iSBDV/SoQ54ol7R1ccQRvM4qbVysZrFzAn1Vs0zBNCpcHtXMqiGOyT+jw7j05VpLH7
	JdFev4duiiKG9ly1jwedVjEbZe+MKCb9pLxyGtFzGZKm3p8jyb8uqlDsIrxdiZWHBhe2ncktPhO
	nsyQqjqHWDSbLPw==
X-Received: by 2002:a05:600c:840f:b0:477:952d:fc00 with SMTP id 5b1f17b1804b1-477c0176752mr182829105e9.12.1764081604586;
        Tue, 25 Nov 2025 06:40:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE61ZQMvheL9QSNtpZPlW4HtLiNOD7Dc5SwbcJjYNes5UJ3YLVDfBHcBGJWoI19GxB3WPyx7Q==
X-Received: by 2002:a05:600c:840f:b0:477:952d:fc00 with SMTP id 5b1f17b1804b1-477c0176752mr182828715e9.12.1764081604183;
        Tue, 25 Nov 2025 06:40:04 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47906cb9715sm15413665e9.2.2025.11.25.06.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 06:40:03 -0800 (PST)
Message-ID: <0550ee33-ce43-4703-966d-c112e774e6ce@redhat.com>
Date: Tue, 25 Nov 2025 15:40:01 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 12/12] selftests: net: selftest for ipvlan-macnat
 mode
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: andrey.bokhanko@huawei.com, edumazet@google.com,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>
References: <20251120174949.3827500-1-skorodumov.dmitry@huawei.com>
 <20251120174949.3827500-13-skorodumov.dmitry@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251120174949.3827500-13-skorodumov.dmitry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/25 6:49 PM, Dmitry Skorodumov wrote:
> diff --git a/tools/testing/selftests/net/ipvtap_macnat_bridge.py b/tools/testing/selftests/net/ipvtap_macnat_bridge.py
> new file mode 100755
> index 000000000000..7dc4a626e5bb
> --- /dev/null
> +++ b/tools/testing/selftests/net/ipvtap_macnat_bridge.py
[...]
> +    TAP = sys.argv[1]
> +    IPVTAP = sys.argv[2]
> +
> +    print(f"Starting TAP bridge between {TAP} and {IPVTAP} in {ns_name}")
> +    bridge = TapBridge(TAP, IPVTAP)
> +    bridge.run()

This is not a complete review, but you need to add CONFIG_IPVTAP and
CONFIG_TAP to tools/testing/selftests/net/config.

> diff --git a/tools/testing/selftests/net/ipvtap_macnat_test.sh b/tools/testing/selftests/net/ipvtap_macnat_test.sh
> new file mode 100755
> index 000000000000..927d75af776b
> --- /dev/null
> +++ b/tools/testing/selftests/net/ipvtap_macnat_test.sh
> @@ -0,0 +1,333 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Tests for ipvtap in macnat mode
> +
> +NS_TST0=ipvlan-tst-0
> +NS_TST1=ipvlan-tst-1
> +NS_PHY=ipvlan-tst-phy

Please use lib.sh / setup_ns instead, to avoid netns name conflicts and
leverage automatic cleanup

> +
> +IP_HOST=172.25.0.1
> +IP_PHY=172.25.0.2
> +IP_TST0=172.25.0.10
> +IP_TST1=172.25.0.30
> +
> +IP_OK0=("172.25.0.10" "172.25.0.11" "172.25.0.12" "172.25.0.13")
> +IP6_OK0=("fc00::10" "fc00::11" "fc00::12" "fc00::13" )
> +
> +IP_OVFL0="172.25.0.14"
> +IP6_OVFL0="fc00::14"
> +
> +IP6_HOST=fc00::1
> +IP6_PHY=fc00::2
> +IP6_TST0=fc00::10
> +IP6_TST1=fc00::30
> +
> +MAC_HOST="92:3a:00:00:00:01"
> +MAC_PHY="92:3a:00:00:00:02"
> +MAC_TST0="92:3a:00:00:00:10"
> +MAC_TST1="92:3a:00:00:00:30"
> +
> +VETH_HOST=vethtst
> +VETH_PHY=vethtst.p
> +
> +#
> +# The testing environment looks this way:
> +#
> +# |------HOST------|     |------PHY-------|
> +# |      veth<----------------->veth      |
> +# |------|--|------|     |----------------|
> +#        |  |
> +#        |  |            |-----TST0-------|
> +#        |  |------------|----ipvtap      |
> +#        |               |----------------|
> +#        |
> +#        |               |-----TST1-------|
> +#        |---------------|----ivtap       |
> +#                        |----------------|
> +#
> +# The macnat mode is for virtual machines, so ipvtap-interface is supposed
> +# to be used only for traffic monitoring and doesn't have ip-address.
> +#
> +# To simulate a virtual machine on ipvtap, we create TAP-interfaces
> +# in TST environments and assing IP-addresses to them.
> +# TAP and IPVTAP are connected with simple python script.
> +#
> +
> +ns_run() {
> +	ns=$1
> +	shift
> +	if [[ "$ns" == "default" ]]; then
> +		"$@" >/dev/null
> +	else
> +		ip netns exec "$ns" "$@" >/dev/null
> +	fi
> +}
> +
> +configure_ns() {
> +	local ns=$1
> +	local n=$2
> +	local ip=$3
> +	local ip6=$4
> +	local mac=$5
> +
> +	ns_run "$ns" ip link set lo up
> +
> +	if ! ip link add netns "$ns" name "ipvtap0.$n" link $VETH_HOST \
> +	    type ipvtap mode l2macnat bridge; then
> +		exit_error "FAIL: Failed to configure ipvtap link."
> +	fi
> +	ns_run "$ns" ip link set "ipvtap0.$n" up
> +
> +	ns_run "$ns" ip tuntap add mode tap "tap0.$n"
> +	ns_run "$ns" ip link set dev "tap0.$n" address "$mac"
> +	# disable dad
> +	ns_run "$ns" sysctl -w "net/ipv6/conf/tap0.$n/accept_dad"=0
> +	ns_run "$ns" ip link set "tap0.$n" up
> +	ns_run "$ns" ip a a "$ip/24" dev "tap0.$n"
> +	ns_run "$ns" ip a a "$ip6/64" dev "tap0.$n"
> +}
> +
> +start_macnat_bridge() {
> +	local ns=$1
> +	local n=$2
> +	ip netns exec "$ns" python3 ipvtap_macnat_bridge.py \
> +		"tap0.$n" "ipvtap0.$n" &
> +}
> +
> +configure_veth() {
> +	local ns=$1
> +	local veth=$2
> +	local ip=$3
> +	local ip6=$4
> +	local mac=$5
> +
> +	ns_run "$ns" ip link set lo up
> +	ns_run "$ns" ethtool -K "$veth" tx off rx off
> +	ns_run "$ns" ip link set dev "$veth" address "$mac"
> +	ns_run "$ns" ip link set "$veth" up
> +	ns_run "$ns" ip a a "$ip/24" dev "$veth"
> +	ns_run "$ns" ip a a "$ip6/64" dev "$veth"
> +}
> +
> +setup_env() {
> +	ip netns add $NS_TST0
> +	ip netns add $NS_TST1
> +	ip netns add $NS_PHY
> +
> +	# setup simulated other-host (phy) and host itself
> +	ip link add $VETH_HOST type veth peer name $VETH_PHY \
> +	    netns $NS_PHY >/dev/null
> +
> +	# host config
> +	configure_veth default $VETH_HOST $IP_HOST $IP6_HOST $MAC_HOST
> +	configure_veth $NS_PHY $VETH_PHY $IP_PHY $IP6_PHY $MAC_PHY
> +
> +	# TST namespaces config
> +	configure_ns $NS_TST0 0 $IP_TST0 $IP6_TST0 $MAC_TST0
> +	configure_ns $NS_TST1 1 $IP_TST1 $IP6_TST1 $MAC_TST1
> +}
> +
> +ping_all() {
> +	# This will learn MAC/IP addresses on ipvtap
> +	local ns=$1
> +
> +	ns_run "$ns" ping -c 1 $IP_TST0
> +	ns_run "$ns" ping -c 1 $IP6_TST0
> +
> +	ns_run "$ns" ping -c 1 $IP_TST1
> +	ns_run "$ns" ping -c 1 $IP6_TST1
> +
> +	ns_run "$ns" ping -c 1 $IP_HOST
> +	ns_run "$ns" ping -c 1 $IP6_HOST
> +
> +	ns_run "$ns" ping -c 1 $IP_PHY
> +	ns_run "$ns" ping -c 1 $IP6_PHY
> +}
> +
> +check_mac_eq() {
> +	# Ensure IP corresponds to MAC.
> +	local ns=$1
> +	local ip=$2
> +	local mac=$3
> +	local dev=$4
> +
> +	if [[ "$ns" == "default" ]]; then
> +		out=$(
> +			ip neigh show "$ip" dev "$dev" \
> +			| grep "$ip" \
> +			| grep "$mac"
> +		)
> +	else
> +		out=$(
> +			ip netns exec "$ns" \
> +			ip neigh show "$ip" dev "$dev" \
> +			| grep "$ip" \
> +			| grep "$mac"
> +		)
> +	fi
> +
> +	if [[ $out'X' == "X" ]]; then
> +		exit_error "FAIL: '$ip' is not '$mac'"
> +	fi
> +}
> +
> +cleanup_env() {
> +	ip link del $VETH_HOST
> +	ip netns del $NS_TST0
> +	ip netns del $NS_TST1
> +	ip netns del $NS_PHY
> +}
> +
> +exit_error() {
> +	echo "$1"
> +	exit 1

It would be better to try to run all the test-cases and return a single
fail/success code. lib.sh can help with that. too.

/P


