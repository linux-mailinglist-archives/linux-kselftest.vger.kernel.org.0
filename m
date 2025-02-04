Return-Path: <linux-kselftest+bounces-25636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6A7A269DD
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 02:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74B23A4EF4
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 01:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933E7537E5;
	Tue,  4 Feb 2025 01:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ke09ZpVk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B00AEC4;
	Tue,  4 Feb 2025 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738632877; cv=none; b=nCCJe7+NHlsME22FRBwZVWw2tmbh5nkjU5aPoQrKHBEuNpg6FcE6CamlOzE0JFUUzNDAW1f6tg298/8C9OR4VS1Kgc+ogd+6TuCGHT5ztSqv/UoI0EcbKcSkY88EuRDCURgz2JlbmNpT14YbTUXk9hBiAYPD7Tc58YbdlSIw4Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738632877; c=relaxed/simple;
	bh=cTqZc7KMQfir834dyF7dto20NWb+pLw52qL9bC6G4tA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2YTTv1W+h2YCof0qVPoQ/fmEUKHGR0C/Uudw4xL8o+rq5GiSr+1f8UV3BQGKUCYhALaC57/kkTUJSHlHbB8W3lEkRkfEdq8bdEvbH8P+Rn2yKXENx1eG6apIG0UftTnx3pv+zeobTq7K5cA+0niFSmsbKoPUq/3772V/eg30aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ke09ZpVk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738632876; x=1770168876;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cTqZc7KMQfir834dyF7dto20NWb+pLw52qL9bC6G4tA=;
  b=ke09ZpVkdy1U6DPZo1SL0b5+e/FMq/Am8+KXiU3vo5WDMx42rYdf4RZG
   SUcsllelXGG1HCHKD3j1YD6LcHtPdmBb7LACDvNgtNyQikfK51GYh4+PB
   3TLIaFOTc6m3g3mcyfkQmMscwggqYwugRGyxkdxACJSpPWZKxOiPmuW68
   NOa9azDdaXNfw6nARYfUTj5fBx+H0HOEBOuroAyXFQBKUNqw6bmaaSZ/y
   rpBxqOZj/Ys+LXaKRA/4PDKaWVlDbFklQbv8thbJvVojUe7ry+RiJ1/Kg
   reZ17PUPr+1yHYP6gdklhu6NiDskD6c/rxYw66ZdRQadQchc1imYIVioM
   A==;
X-CSE-ConnectionGUID: Tag1N2hORI2+DE2n+rR1yg==
X-CSE-MsgGUID: P87jdiaMTjKPjnq1PtVJGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="49795734"
X-IronPort-AV: E=Sophos;i="6.13,257,1732608000"; 
   d="scan'208";a="49795734"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 17:34:18 -0800
X-CSE-ConnectionGUID: 4tSta66CTFq8So3/FmHf2g==
X-CSE-MsgGUID: 907kdKGuTAyI/dVJbUURBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="115441422"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.124.71]) ([10.247.124.71])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 17:34:06 -0800
Message-ID: <e0d34c88-dd8d-402d-bc67-6b9c4f8effaf@linux.intel.com>
Date: Tue, 4 Feb 2025 09:34:03 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 3/5] net: stmmac: Add launch time support to
 XDP ZC
To: Song Yoong Siang <yoong.siang.song@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Topel <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Mina Almasry <almasrymina@google.com>,
 Daniel Jurgens <danielj@nvidia.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
 Bouska Zdenek <zdenek.bouska@siemens.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
 xdp-hints@xdp-project.net
References: <20250204004907.789330-1-yoong.siang.song@intel.com>
 <20250204004907.789330-4-yoong.siang.song@intel.com>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <20250204004907.789330-4-yoong.siang.song@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/2/2025 8:49 am, Song Yoong Siang wrote:
> Enable launch time (Time-Based Scheduling) support for XDP zero copy via
> the XDP Tx metadata framework.
> 
> This patch has been tested with tools/testing/selftests/bpf/xdp_hw_metadata
> on Intel Tiger Lake platform. Below are the test steps and result.
> 
> Test 1: Send a single packet with the launch time set to 1 s in the future.
> 
> Test steps:
> 1. On the DUT, start the xdp_hw_metadata selftest application:
>     $ sudo ./xdp_hw_metadata enp0s30f4 -l 1000000000 -L 1
> 
> 2. On the Link Partner, send a UDP packet with VLAN priority 1 to port 9091
>     of the DUT.
> 
> Result:
> When the launch time is set to 1 s in the future, the delta between the
> launch time and the transmit hardware timestamp is 16.963 us, as shown in
> printout of the xdp_hw_metadata application below.
>    0x55b5864717a8: rx_desc[4]->addr=88100 addr=88100 comp_addr=88100 EoP
>    No rx_hash, err=-95
>    HW RX-time:   1734579065767717328 (sec:1734579065.7677)
>                  delta to User RX-time sec:0.0004 (375.624 usec)
>    XDP RX-time:   1734579065768004454 (sec:1734579065.7680)
>                   delta to User RX-time sec:0.0001 (88.498 usec)
>    No rx_vlan_tci or rx_vlan_proto, err=-95
>    0x55b5864717a8: ping-pong with csum=5619 (want 0000)
>                    csum_start=34 csum_offset=6
>    HW RX-time:   1734579065767717328 (sec:1734579065.7677)
>                  delta to HW Launch-time sec:1.0000 (1000000.000 usec)
>    0x55b5864717a8: complete tx idx=4 addr=4018
>    HW Launch-time:   1734579066767717328 (sec:1734579066.7677)
>                      delta to HW TX-complete-time sec:0.0000 (16.963 usec)
>    HW TX-complete-time:   1734579066767734291 (sec:1734579066.7677)
>                           delta to User TX-complete-time sec:0.0001
>                           (130.408 usec)
>    XDP RX-time:   1734579065768004454 (sec:1734579065.7680)
>                   delta to User TX-complete-time sec:0.9999
>                  (999860.245 usec)
>    HW RX-time:   1734579065767717328 (sec:1734579065.7677)
>                  delta to HW TX-complete-time sec:1.0000 (1000016.963 usec)
>    0x55b5864717a8: complete rx idx=132 addr=88100
> 
> Test 2: Send 1000 packets with a 10 ms interval and the launch time set to
>          500 us in the future.
> 
> Test steps:
> 1. On the DUT, start the xdp_hw_metadata selftest application:
>     $ sudo chrt -f 99 ./xdp_hw_metadata enp0s30f4 -l 500000 -L 1 > \
>       /dev/shm/result.log
> 
> 2. On the Link Partner, send 1000 UDP packets with a 10 ms interval and
>     VLAN priority 1 to port 9091 of the DUT.
> 
> Result:
> When the launch time is set to 500 us in the future, the average delta
> between the launch time and the transmit hardware timestamp is 13.854 us,
> as shown in the analysis of /dev/shm/result.log below. The XDP launch time
> works correctly in sending 1000 packets continuously.
>    Min delta: 08.410 us
>    Avr delta: 13.854 us
>    Max delta: 17.076 us
>    Total packets forwarded: 1000
> 
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>

Reviewed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>

