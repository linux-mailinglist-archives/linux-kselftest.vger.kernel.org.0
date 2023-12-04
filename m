Return-Path: <linux-kselftest+bounces-1042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30820803072
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 11:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B81FCB20A42
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 10:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55306224DA;
	Mon,  4 Dec 2023 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYuJbBEO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2402022333;
	Mon,  4 Dec 2023 10:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B651CC433C7;
	Mon,  4 Dec 2023 10:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701686198;
	bh=+ErQN2WS12/khFYfpQDZFxvXogAuk59InCRmaNowfS4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TYuJbBEOWc7KkHydu2jfldkno0up5yHsG0uUho4wBtYHENJrIhEzopw828B8nYR2y
	 /Bq7E40/MYPd1WbSuMXOvrTR5LHNu4Nyf/Kw+gB/7gkQzftmk1CpVYV9eJwBzY35J7
	 xEUZGCUu5mNhYCftzglLku0Qv8rqkxUO3hFH3lqEzc07PY3VLfg/jHqko9fsaF3gZi
	 n60G9Q65Bc1Acq6pmo9DI1XvzmOdhIgAhp4s7D3JCsTjOCRoMf5DFu4Adbt8rs1jkb
	 JUYwE//FlD7965G/pbx4+GWSA9D9XyXOvGaEDUVAyM3lQkuP2ld5EEhAtkvcn/6u8N
	 p2QNPiNTkbN1g==
Message-ID: <43b01013-e78b-417e-b169-91909c7309b1@kernel.org>
Date: Mon, 4 Dec 2023 11:36:30 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/3] net: stmmac: add Launch Time support to
 XDP ZC
Content-Language: en-US
To: Song Yoong Siang <yoong.siang.song@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Topel <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Willem de Bruijn <willemb@google.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, bpf@vger.kernel.org, xdp-hints@xdp-project.net,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org
References: <20231203165129.1740512-1-yoong.siang.song@intel.com>
 <20231203165129.1740512-3-yoong.siang.song@intel.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231203165129.1740512-3-yoong.siang.song@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/3/23 17:51, Song Yoong Siang wrote:
> This patch enables Launch Time (Time-Based Scheduling) support to XDP zero
> copy via XDP Tx metadata framework.
> 
> Signed-off-by: Song Yoong Siang<yoong.siang.song@intel.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 ++

As requested before, I think we need to see another driver implementing 
this.

I propose driver igc and chip i225.

The interesting thing for me is to see how the LaunchTime max 1 second
into the future[1] is handled code wise. One suggestion is to add a 
section to Documentation/networking/xsk-tx-metadata.rst per driver that 
mentions/documents these different hardware limitations.  It is natural 
that different types of hardware have limitations.  This is a close-to 
hardware-level abstraction/API, and IMHO as long as we document the 
limitations we can expose this API without too many limitations for more 
capable hardware.

  [1] 
https://github.com/xdp-project/xdp-project/blob/master/areas/tsn/code01_follow_qdisc_TSN_offload.org#setup-code-driver-igb

This stmmac driver and Intel Tiger Lake CPU must also have some limit on 
how long into the future it will/can schedule packets?


People from xdp-hints list must make their voice hear if they want i210 
and igb driver support, because it have even-more hardware limitations, 
see [1] (E.g. only TX queue 0 and 1 supports LaunchTime). BUT I know 
some have this hardware in production and might be motivated to get a 
functioning driver with this feature?

--Jesper

