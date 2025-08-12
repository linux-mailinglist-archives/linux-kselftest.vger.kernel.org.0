Return-Path: <linux-kselftest+bounces-38766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB632B22312
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 11:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF408506557
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 09:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67FC2E9EDF;
	Tue, 12 Aug 2025 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1f39NI4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9772E9EB3
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990607; cv=none; b=N9cmeVrHhnZ15/og2bU/CL8gMNb3n+Ly8OkFA+j0sNjB+USCAsikN8E5GFwPfhpTfbSwxNQuwEsMeB1qyIAavrIrRJg10137NlxEH5NMk00awLlQ2K9wZh/fFkugbIIUfpXqfwTFLYyCGP2MzxJiNQK5+J47lmQHiYzSXXjR71o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990607; c=relaxed/simple;
	bh=9UjwDurw1nUTJra9i5P6+81yOgQ9oABvAHUxnXc8Kx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJp6XbrM0qqS82t411vcmF+EayL/Fm9mRwhB1xogbnTxX7iXzAg6BLlkvgtQIWNg/UkeL9LrURn0vpp0ndSiTOxZjsXPE/y6uO+CoH1A6MpBSoCokb/T8EJYEgTx87JOnLWhSJf9QTLlazxnV7UVKRflNy6wm42UZCwk60kE4eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1f39NI4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754990605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pz1ojHO8eyf7HqxNiN54zlh4fLIlVQ4LDosH11WtvzQ=;
	b=G1f39NI4HahAUK4zePeAJbYvgJN4wsFRo/wXs6XpH0TsQ1Lub0HmYxO+37KWmtdq2t7uZW
	JrAkBY6T6SwKf9mbnQhGLqxvzYFTkRRKWuJLnEMMS1bVBkikMUcxCoPVc0CE1F0eW61SNJ
	fPJhjSavp9xkJ+jz1tAWQuNv7YwscBM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-EJBqygduM9yNZoMRyKqFxw-1; Tue, 12 Aug 2025 05:23:21 -0400
X-MC-Unique: EJBqygduM9yNZoMRyKqFxw-1
X-Mimecast-MFC-AGG-ID: EJBqygduM9yNZoMRyKqFxw_1754990600
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b7812e887aso2542038f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 02:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990600; x=1755595400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pz1ojHO8eyf7HqxNiN54zlh4fLIlVQ4LDosH11WtvzQ=;
        b=OGzBErFFRT6T6YP4h1xnuA0rnMezIJ2X4HMmFpiYL330xykJlLOtTciK3wGEU+O6bJ
         ccDa6V/+dc8ipAg7PkABkSWE2KBxA7F0pwLTDYcbRyTZQgG7M0sjU4lxVY8+0FIOOjcR
         pEPHkiIkSZUZ5ZpTsUUGNVX0EeKXqUFHYHFX+NXDByldPFlMqFiP/GKJC9NCP84IktHW
         QBqz8jDLZGqQX+9ymDBjCZEsFOsK3fKiBjRf8dZa+xDs+QjKOLWUW99lb2ZzjuMYVtOQ
         6aPPqiLtLfl2aCkHQRbn5r0RWWKf1n3mp4RbB/Ah9GjAyy4lx+zGChIzg2Nc1Sg+9v8a
         uOzw==
X-Forwarded-Encrypted: i=1; AJvYcCUSpg14v1SvTR0Ec5qeFyo1yAyXx1Xhn/ujL81VYkH/XoFOlNFHurpAzwE0ivXn1J2rE+jhM+IVT9MNLSMeeXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr7d4gNGp9+rsxZymVqFkSObusvrkNHOPgQQ+1Rvoi68s26HJi
	bJ+9b1UmWnbZxgUzQoBC5S2Uowf7O2F89c/HulaqMiDDavjGkGlrGfsUdTNyi8P56fyLCmAGfdZ
	ML2O77LL7Br25feiZY795usvUszrdWYUCS3ySP874TH2r3jbN8QKehVdVrq5wCxN5h2+I3w==
X-Gm-Gg: ASbGncvshgh1IaSwLMNn08DGOhtQbEoS3skz/hJtRvKLmAs1guTPTix12JDnW0/LsVE
	81fYeGy9YwG3mpwCOmGd9U7WKS0wqdKtlCrKhj7ugWEFvInLglCHnBczIXG1eAeBwXEP98ybtxG
	Yn5xC7iqo1MeWsx9NQNTQxljW8XPbEQRKztU5uProihkqCTvBMPWsKahrOtPLOEMfEN5A2GZzLJ
	zPTnEB2l7XDfMXI7vzIuyg+82as/LVVR/WtaJKRw3wC0p2uWODPzeIBb2S8V6wlKWKUaiNRExda
	cO5n8589agoUMDI0DJ0iW+MSNXDTlZz6g+Dgqg5bC6s=
X-Received: by 2002:a5d:64c3:0:b0:3b7:974d:5359 with SMTP id ffacd0b85a97d-3b900b50441mr13785207f8f.32.1754990600307;
        Tue, 12 Aug 2025 02:23:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE75vvLuAwqhrfvMgiTAl2Xg6NM58jFLAd6KwXmS+pVefqn91SHuQHbjFMHg1LHMpKDBWwnbA==
X-Received: by 2002:a5d:64c3:0:b0:3b7:974d:5359 with SMTP id ffacd0b85a97d-3b900b50441mr13785179f8f.32.1754990599877;
        Tue, 12 Aug 2025 02:23:19 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.149.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5e99e04sm288071615e9.11.2025.08.12.02.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 02:23:19 -0700 (PDT)
Message-ID: <4a8266bf-5e33-4a38-a569-2a1e13633696@redhat.com>
Date: Tue, 12 Aug 2025 11:23:17 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net 3/3] selftests: bonding: add test for passive LACP
 mode
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250805094634.40173-1-liuhangbin@gmail.com>
 <20250805094634.40173-4-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250805094634.40173-4-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/25 11:46 AM, Hangbin Liu wrote:
@@ -0,0 +1,95 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Test if a bond interface works with lacp_active=off.
> +
> +# shellcheck disable=SC2034
> +REQUIRE_MZ=no
> +NUM_NETIFS=0
> +lib_dir=$(dirname "$0")
> +# shellcheck disable=SC1091
> +source "$lib_dir"/../../../net/forwarding/lib.sh
> +
> +check_port_state()
> +{
> +	local netns=$1
> +	local port=$2
> +	local state=$3
> +
> +	ip -n "${netns}" -d -j link show "$port" | \
> +		jq -e ".[].linkinfo.info_slave_data.ad_actor_oper_port_state_str | index(\"${state}\") != null" > /dev/null
> +}
> +
> +trap cleanup EXIT
> +setup_ns c_ns s_ns
> +defer cleanup_all_ns
> +
> +# shellcheck disable=SC2154
> +ip -n "${c_ns}" link add eth0 type veth peer name eth0 netns "${s_ns}"
> +ip -n "${c_ns}" link add eth1 type veth peer name eth1 netns "${s_ns}"
> +ip -n "${s_ns}" link set eth0 up
> +ip -n "${s_ns}" link set eth1 up
> +ip -n "${c_ns}" link add bond0 type bond mode 802.3ad lacp_active off lacp_rate fast
> +ip -n "${c_ns}" link set eth0 master bond0
> +ip -n "${c_ns}" link set eth1 master bond0
> +ip -n "${c_ns}" link set bond0 up
> +
> +# 1. The passive side shouldn't send LACPDU.
> +RET=0
> +client_mac=$(cmd_jq "ip -j -n ${c_ns} link show bond0" ".[].address")
> +# Wait for the first LACPDU due to state change.
> +sleep 5
> +timeout 62 ip netns exec "${c_ns}" tcpdump --immediate-mode -c 1 -i eth0 \
> +	-nn -l -vvv ether proto 0x8809 2> /dev/null > /tmp/client_init.out
> +grep -q "System $client_mac" /tmp/client_init.out && RET=1
> +log_test "802.3ad" "init port pkt lacp_active off"
> +
> +# 2. The passive side should not have the 'active' flag.
> +RET=0
> +check_port_state "${c_ns}" "eth0" "active" && RET=1
> +log_test "802.3ad" "port state lacp_active off"
> +
> +# Set up the switch side with active mode.
> +ip -n "${s_ns}" link set eth0 down
> +ip -n "${s_ns}" link set eth1 down
> +ip -n "${s_ns}" link add bond0 type bond mode 802.3ad lacp_active on lacp_rate fast
> +ip -n "${s_ns}" link set eth0 master bond0
> +ip -n "${s_ns}" link set eth1 master bond0
> +ip -n "${s_ns}" link set bond0 up
> +# Make sure the negotiation finished
> +sleep 5

Minor nit: I guess the above sleep time depends on some kernel constant,
but it's not obvious to me if the minimum time is mandated by the RFC,
nor how long is such interval.

A comment explaining the rationale behind such sleep will help, and
possibly a loop with smaller minimal wait and periodic checks for the
expected condition up to a significantly higher timeout could make the
test both faster on average and more robust.

> +
> +# 3. The active side should have the 'active' flag.
> +RET=0
> +check_port_state "${s_ns}" "eth0" "active" || RET=1
> +log_test "802.3ad" "port state lacp_active on"
> +
> +# 4. Make sure the connection has not expired.
> +RET=0
> +slowwait 15 check_port_state "${s_ns}" "eth0" "expired" && RET=1
> +slowwait 15 check_port_state "${s_ns}" "eth1" "expired" && RET=1
> +log_test "bond 802.3ad" "port connect lacp_active off"
> +
> +# After testing, disconnect one port on each side to check the state.
> +ip -n "${s_ns}" link set eth0 nomaster
> +ip -n "${s_ns}" link set eth0 up
> +ip -n "${c_ns}" link set eth1 nomaster
> +ip -n "${c_ns}" link set eth1 up
> +# 5. The passive side shouldn't send LACPDU anymore.
> +RET=0
> +# Wait for LACPDU due to state change.
> +sleep 5

Same here.

Thanks,

Paolo


