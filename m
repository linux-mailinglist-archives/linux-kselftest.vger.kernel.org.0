Return-Path: <linux-kselftest+bounces-24010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F3BA04795
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 18:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA7C16155E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F421C1F3D4F;
	Tue,  7 Jan 2025 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrNAd2iX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB3618B47D;
	Tue,  7 Jan 2025 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269663; cv=none; b=IaYADUd+TQnpTou7gDALUNTYPJoT1PtKnXgoKlRuhNiBwfa/6/SX+GEjd5JpiPIp6qgxYxgWWrW0+S0PKwUfpqem10BvKuASUu+IYMqxS+UHqOZcTUQKtW111HrEuBcWKOr1JIINc0yCIoCofnD92zQUAwF8Ii4CbXZJfrfX8f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269663; c=relaxed/simple;
	bh=uhLxoMhIxsCUyDi5ICic7xl1VPBctvcjCTJ8sYAxDL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pe4A85NwUvcomjBXnx9ZHZlauYHGTJmHMAbuXCjhBHA18GkiU5SCliq6nSLlhGXDwNxRY+kPlp/522KyUSgBg11KYx6NI5GQh9K925I0gIcGM2WXADB+HlW8e1eGITCDqVY6bOa1U923k8L9XmyofbjstBi9sQNfZRtzxhfzUb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrNAd2iX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2164b1f05caso228213545ad.3;
        Tue, 07 Jan 2025 09:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736269662; x=1736874462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H6IgG8TBqPF+D4hNW02w96Pdr6FXNShPU0XiGtGLP2U=;
        b=nrNAd2iXBbdI6w4TUPzyADwHCTEoeJGL8rFkllL318pQSS9fOTlCajJL/VifEs2gRq
         EWsLEYEC4g9gP7JYSQNrpU2fFE+b+q3F0loZoWDyRufy07NPd/QmjmWhE/s7F6L+I45H
         OGP2Rjy448vifQhTmUq4kaAVhj30JTuzHZMwjLEs1wMF9ywwASBaRko0ut5vOK9ZLkrN
         2hSymh4Tha0OuPYJ5VpEIrylhdxp1pSDQ85LsY2DusSCIO+xSYZXuN9QLPvcDr0BO4qa
         9PMuqY6+e0WQcwQg+QWFtuLqehvzBEdHKjuSW9Czot80BKnrVu3cWoBNmfBmRXGDKii4
         LSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736269662; x=1736874462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6IgG8TBqPF+D4hNW02w96Pdr6FXNShPU0XiGtGLP2U=;
        b=flLujTEk9Dr1hSzQfp5Lc3UTbhpDmEJ2Uahh+VD3Q7YcwmZwnmCAYJmMkHvrwUx1R5
         6lK9hKIjlNwEBKzKe34nvyqvr5fnJvqIFCcd4bwRQiuiHqzL4gdXjOV3JcViR7vJPkOp
         HddTd9p7Hqgva8qQsolmd1FBvoJWcPpLe2TAC3wN5CnP4EiLb6tFRXdQFo4qySAB/7tX
         amHNyfZli9sY7nexV62gCCEQ35fXMUhh7NYua8xUXuhsAZngriR0WrP/kiMhRrygv+aC
         lwN5bMsUn3S6otIJTSCNZI2pzrDwCqcfNjmvNYMwj2ovJ/OL5k+VBd+QuwadVrQmAYxe
         HE+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+PalGOlyK2oAOXatH41GK1C5gLCBam6LOTJYwGweGLqGxwYMTm7g+UCyLH28LBItl1uySfWKa8h6O@vger.kernel.org, AJvYcCUc3QEyr/LpUmtU6HToJED6DsNRuBJltAmWywuIb3NuMf4tjxJqJb47gaxoxlKlq0JV4oigRzUKmINoGfQJnwDS@vger.kernel.org, AJvYcCW/d4wkMvVAf2O5kWdF5P3drfYrfp1ufbLenWg27HwujDnllBbdQV7SQ896pg5+HHYd2fHc2YI6@vger.kernel.org, AJvYcCWF9LjRJHLx6R5V4YmXtfQHSX/FFDxW2rPSbN1veXBmxOBwFafVoYHVJ8hy9cLBLnK0JYsPlmn9IPGKhvzv@vger.kernel.org, AJvYcCXzHr1w0f5zWjONbwnR19Y3THfOnComW8K+mnQMhmHbGK6JFpIPLZO0UgBUlDYrcOLwGcI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0vmAwPaKa3zBSD+kiWR3gHmxBl/b0XuRmflexKF7cdvVHyUnE
	SX4vKeM6S+DApvFYTLP6XYK4Xx9vkdsrIjOJzhw8zGX0hUKtWig=
X-Gm-Gg: ASbGncvL5mg/UjCK0B1f7x85FfTCKUGRXqLJ8/klBdyElW32DaHWNih0fciUhumws1N
	NZMynRmdstfbAy8WBoGmtZo3lZXr9x5RUijN8Vuj6pKMyKBskC5syxM+v1df83WdqdhtQ1x8jwW
	bElVQGVuv32OZ/FVdDb8E27FAFcdGHTXkpNv+LrgwAAUAxUXVWIkIyqevNJFmTkJNgjZL9PpEwG
	T1bS+a4VlnwMdRobGqBLYdL4BBNCFBiiJRmdIK2gMPbA9eKLnBUnIHD
X-Google-Smtp-Source: AGHT+IHI4UAilr4fOsWcWRXO8E8vJoNjH2hq0o3vxddLmqIYgmVN8lBTyI8wQrNNttLzXRdwB4KPiw==
X-Received: by 2002:a17:902:ce92:b0:215:5ea2:6544 with SMTP id d9443c01a7336-219e6e8c365mr758236605ad.7.1736269661645;
        Tue, 07 Jan 2025 09:07:41 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca04ce7sm305940015ad.283.2025.01.07.09.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 09:07:41 -0800 (PST)
Date: Tue, 7 Jan 2025 09:07:40 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Bjorn Topel <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	intel-wired-lan@lists.osuosl.org, xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v4 3/4] net: stmmac: Add launch time support to
 XDP ZC
Message-ID: <Z31fXHxWuKNog_Qh@mini-arch>
References: <20250106135658.9734-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250106135658.9734-1-yoong.siang.song@intel.com>

On 01/06, Song Yoong Siang wrote:
> Enable launch time (Time-Based Scheduling) support to XDP zero copy via XDP
> Tx metadata framework.
> 
> This patch is tested with tools/testing/selftests/bpf/xdp_hw_metadata on
> Intel Tiger Lake platform. Below are the test steps and result.
> 
> Test Steps:
> 1. Add mqprio qdisc:
>    $ sudo tc qdisc add dev enp0s30f4 handle 8001: parent root mqprio num_tc
>      4 map 0 1 2 3 3 3 3 3 3 3 3 3 3 3 3 3 queues 1@0 1@1 1@2 1@3 hw 0
> 
> 2. Enable launch time hardware offload on hardware queue 1:
>    $ sudo tc qdisc replace dev enp0s30f4 parent 8001:2 etf offload clockid
>      CLOCK_TAI delta 500000
> 
> 3. Add an ingress qdisc:
>    $ sudo tc qdisc add dev enp0s30f4 ingress
> 
> 4. Add a flower filter to route incoming packet with VLAN priority 1 into
>    hardware queue 1:
>    $ sudo tc filter add dev enp0s30f4 parent ffff: protocol 802.1Q flower
>      vlan_prio 1 hw_tc 1
> 
> 5. Enable VLAN tag stripping:
>    $ sudo ethtool -K enp0s30f4 rxvlan on
> 
> 6. Start xdp_hw_metadata selftest application:
>    $ sudo ./xdp_hw_metadata enp0s30f4 -l 1000000000
> 
> 7. Send an UDP packet with VLAN priority 1 to port 9091 of DUT.

Tangential: I wonder whether we can add the setup steps to the
xdp_hw_metadata tool? It is useful to have one command to run that
takes care of all the details. Same way it already enables HW
tstamping.. 

Or, if not the full setup, some kind of detection we can signal to the
user that some things might be missing?

