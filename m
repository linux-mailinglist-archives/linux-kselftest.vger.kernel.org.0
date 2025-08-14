Return-Path: <linux-kselftest+bounces-38953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6446B261A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 11:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDE53B2FB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 09:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEAB2F6593;
	Thu, 14 Aug 2025 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="It8inmM1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7957D2EB5AC;
	Thu, 14 Aug 2025 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165307; cv=none; b=CnsZACChDHQRdYt0+JtO+leEplRjw2f4XipSyGHrjt7b/WntZZqgA20ROx/YJk+efqaK0c7Y7/IJGBKOfw4+f4/e0szJFG7fH9Jcdmhcgvutt3FdMm5xXYYFdlaUTSbYOUX1N0Lq+8Y6d3dF51fmjoyvpxP0MroKyNZQJE9nLzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165307; c=relaxed/simple;
	bh=k0Dkor+lAuESBdrXHwfz3W5uPZwR/A7phgbA1Jwbx7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UI0dilPWOcloFpSbPFbVXALRIWo+Ax3wh/U9a6LZMMhM5XYI5lRVayxW3VDQl7ZQm6CmsfiOwrMrL2vWOIL6oW99agGEluy48HIGAJ3GrLDQQ32ZM0sVehQ20Gt2qTCePUP20RII9UfJs+wIToheX0YouzGwT9DMfaWydYp3qX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=It8inmM1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2ea79219so942150b3a.2;
        Thu, 14 Aug 2025 02:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755165306; x=1755770106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IyolPvvJ5P5Cfgv88I/zz9kiIYKt1sA4xstTXvKCEao=;
        b=It8inmM1iwhI308yAU1FqHQJHLxzMLFrpAeI2mt/z8pMzwCN/l15Ad/m2/VuG/KdB6
         VpVDKHD3N5I4K0vRuIn7bauZKZ+fZUjoWFJBInB3oZV3CIkzrTWGujMGkvScCEoHDBuf
         AODy20QAnZ3XYIq85RnQ4MKmJHlMtJfsaSOz/nxJvQ7dPBdrIbPDCqAgqSvqB7WrIrUn
         I2LAsqDSCBJxeGmrWcRWuLHBcvB+rM4HilVC+eCEGWKJgqasbfGMFiIE9htwZsxhncoD
         1dRZZHAznnt8vHJPBeqJID0WV9FmEp9GhdO7VHdQbntlx0mjlkVCW/+2rspJPX3V+84+
         Zsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755165306; x=1755770106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyolPvvJ5P5Cfgv88I/zz9kiIYKt1sA4xstTXvKCEao=;
        b=M4bKAXjR9G2tGCs6NkqNvFHEakYbjwcwU8pLRX696T2Da1xfHVNr8Jo4XP1cXLyI0V
         vSwJbd2IJ2k/+VG0Ys6N5FZOnvi5Ojn288LyaAM4Aa8pTABPSolfaId80ioXZO69lACs
         JahED8dasJ3dT44kkJnz1Ujysm+M8tGMT93XoSKg3ubOy4fNKuc2TWVh46Mo30Rx+hIo
         YvNxKAbeI3pVi+8AQQ2zYyfQNdfzzoeWtbXlqLunIKaDRWXF19wTpL1jgyzPnayKQyd+
         gVga2WPiEYCjH8v7Yes26D5NBDzTiXnneEKe/qXMjb1wJUh1lw3hJ8cUbZdZUTtfTUOe
         0+Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWIIoFkADjOGwn0MUTu0/84g5r7i2QFGybNQgRAL5R07lmpbpYqxRPkMcnqNQ1rVlCsuMt1G47N/3YyRlK8VGtN@vger.kernel.org, AJvYcCX7aGTM3OMdT5G5AvojASyP7Yp0xQ1ftLHr51bI4eu+Xq/nwkwDXZ8KBc6cOx++prviOqlbwvqVYU0sujs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkA9dP4fTWtHO3aWhpwkRtAeS/qU5GGP0HbdtBABvYCKF4LuO3
	jPkxjulhqwYOwvyRiqdBPkCiqw9FhXaMopUwTNRpNJwXY0KtT35ahywN
X-Gm-Gg: ASbGncvzXPqVHqw6VX/p3d7Vun5KM+V5uCZdaq4VTvUN1/OxfDTrapTqSj6cK4yxrn+
	Q9mrpSmSsNxagD1jZ22QqR7n390g8wA4kv1W+g7vJoyyLOzYFSQlQIv7zTddRjf5v8dVNyR4z5r
	jqYyGPFTVmBvsM2DrYci8825VeQV6QTHthwcCAYOLRo4VaCvafrelJD9Ae68bHDDjs6a8ZESEmr
	VGDe7AiKa/rm9HC6MhzkT0XNu2BqkppjNSlmQYiRT+cpWrNZ+1iBVnK3kP9yh/Q4tD6slJQv2iR
	q0Nh4etGsfTEL9pOjGWy6xbSRXNKVlvGy2BynBM2JvNsJhI1d1cK2fYFRd0TklUAUi+M9t9h+l7
	TmH1kNumXj/sa7ZJzQk9xbBEO/zY=
X-Google-Smtp-Source: AGHT+IEuDry18iipUs0pAcn/f5/SjOLIc789bLnnBTt4RNgSoLaESy5EkcCIYW+sBcew4URWmQiN+w==
X-Received: by 2002:a05:6a00:139e:b0:746:24c9:c92e with SMTP id d2e1a72fcca58-76e2fc28c2emr4323635b3a.8.1755165305708;
        Thu, 14 Aug 2025 02:55:05 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c34d23f01sm19035223b3a.23.2025.08.14.02.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:55:05 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:54:58 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net 3/3] selftests: bonding: add test for passive LACP
 mode
Message-ID: <aJ2yckfzToXfCiYa@fedora>
References: <20250805094634.40173-1-liuhangbin@gmail.com>
 <20250805094634.40173-4-liuhangbin@gmail.com>
 <4a8266bf-5e33-4a38-a569-2a1e13633696@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a8266bf-5e33-4a38-a569-2a1e13633696@redhat.com>

On Tue, Aug 12, 2025 at 11:23:17AM +0200, Paolo Abeni wrote:
> On 8/5/25 11:46 AM, Hangbin Liu wrote:
> @@ -0,0 +1,95 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Test if a bond interface works with lacp_active=off.
> > +
> > +# shellcheck disable=SC2034
> > +REQUIRE_MZ=no
> > +NUM_NETIFS=0
> > +lib_dir=$(dirname "$0")
> > +# shellcheck disable=SC1091
> > +source "$lib_dir"/../../../net/forwarding/lib.sh
> > +
> > +check_port_state()
> > +{
> > +	local netns=$1
> > +	local port=$2
> > +	local state=$3
> > +
> > +	ip -n "${netns}" -d -j link show "$port" | \
> > +		jq -e ".[].linkinfo.info_slave_data.ad_actor_oper_port_state_str | index(\"${state}\") != null" > /dev/null
> > +}
> > +
> > +trap cleanup EXIT
> > +setup_ns c_ns s_ns
> > +defer cleanup_all_ns
> > +
> > +# shellcheck disable=SC2154
> > +ip -n "${c_ns}" link add eth0 type veth peer name eth0 netns "${s_ns}"
> > +ip -n "${c_ns}" link add eth1 type veth peer name eth1 netns "${s_ns}"
> > +ip -n "${s_ns}" link set eth0 up
> > +ip -n "${s_ns}" link set eth1 up
> > +ip -n "${c_ns}" link add bond0 type bond mode 802.3ad lacp_active off lacp_rate fast
> > +ip -n "${c_ns}" link set eth0 master bond0
> > +ip -n "${c_ns}" link set eth1 master bond0
> > +ip -n "${c_ns}" link set bond0 up
> > +
> > +# 1. The passive side shouldn't send LACPDU.
> > +RET=0
> > +client_mac=$(cmd_jq "ip -j -n ${c_ns} link show bond0" ".[].address")
> > +# Wait for the first LACPDU due to state change.
> > +sleep 5
> > +timeout 62 ip netns exec "${c_ns}" tcpdump --immediate-mode -c 1 -i eth0 \
> > +	-nn -l -vvv ether proto 0x8809 2> /dev/null > /tmp/client_init.out
> > +grep -q "System $client_mac" /tmp/client_init.out && RET=1
> > +log_test "802.3ad" "init port pkt lacp_active off"
> > +
> > +# 2. The passive side should not have the 'active' flag.
> > +RET=0
> > +check_port_state "${c_ns}" "eth0" "active" && RET=1
> > +log_test "802.3ad" "port state lacp_active off"
> > +
> > +# Set up the switch side with active mode.
> > +ip -n "${s_ns}" link set eth0 down
> > +ip -n "${s_ns}" link set eth1 down
> > +ip -n "${s_ns}" link add bond0 type bond mode 802.3ad lacp_active on lacp_rate fast
> > +ip -n "${s_ns}" link set eth0 master bond0
> > +ip -n "${s_ns}" link set eth1 master bond0
> > +ip -n "${s_ns}" link set bond0 up
> > +# Make sure the negotiation finished
> > +sleep 5
> 
> Minor nit: I guess the above sleep time depends on some kernel constant,
> but it's not obvious to me if the minimum time is mandated by the RFC,
> nor how long is such interval.

We need to make sure the lacp negotiation finished. There is no definition
in IEEE standard. 

> 
> A comment explaining the rationale behind such sleep will help, and
> possibly a loop with smaller minimal wait and periodic checks for the
> expected condition up to a significantly higher timeout could make the
> test both faster on average and more robust.

I will use tc rules to catch pkts and see if we can reduce some time.

Thanks
Hangbin

