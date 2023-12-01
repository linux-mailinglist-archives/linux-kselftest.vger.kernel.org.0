Return-Path: <linux-kselftest+bounces-967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A51D800DDB
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 16:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC80281B9A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 15:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6A33FE20;
	Fri,  1 Dec 2023 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnzIEJkg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A906125D7;
	Fri,  1 Dec 2023 15:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DD3C433C9;
	Fri,  1 Dec 2023 15:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701442950;
	bh=HCKgkvZM3p9a1PhMU+0ZdI63NNj7rU/pKhx/Px4fVKY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZnzIEJkgcQPJ9EhwbA+QMxmLvo7Vb5mFoKAoNXH6yHgW+nms/wyXGXewhlB2+aaMv
	 ggRc0WCfAnmF4J1gGXJNsVm00we+Ush4nAHaDY6/aboqP1YpJAeXkD97yaQm8LF8DA
	 kcLJiTetD9+tqyUXfvHMuhZjY2ZJFxqDcxvpvNstZflcgXy8ZgkfwU667pQAlZks+n
	 JLx/dRpoe81S7cz16xFnm3ay1eGU674lCQdb1zXCGrUTHqAKRJwjbY6ZS9z8d7fK1o
	 4iwBWtKKzMnCl2rC99z3RVqUB/XbA4ZBM/7CWSyEJ5gV7SbzjnjMTZ4SljJxZUkoLX
	 rN/ROb0OGkmhg==
Message-ID: <5a660c0f-d3ed-47a2-b9be-098a224b8a12@kernel.org>
Date: Fri, 1 Dec 2023 16:02:22 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/3] net: stmmac: Add txtime support to XDP ZC
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
References: <20231201062421.1074768-1-yoong.siang.song@intel.com>
 <20231201062421.1074768-3-yoong.siang.song@intel.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231201062421.1074768-3-yoong.siang.song@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/1/23 07:24, Song Yoong Siang wrote:
> This patch enables txtime support to XDP zero copy via XDP Tx
> metadata framework.
> 
> Signed-off-by: Song Yoong Siang<yoong.siang.song@intel.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 ++
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++++++++++
>   2 files changed, 15 insertions(+)

I think we need to see other drivers using this new feature to evaluate
if API is sane.

I suggest implementing this for igc driver (chip i225) and also for igb
(i210 chip) that both support this kind of LaunchTime feature in HW.

The API and stmmac driver takes a u64 as time.
I'm wondering how this applies to i210 that[1] have 25-bit for
LaunchTime (with 32 nanosec granularity) limiting LaunchTime max 0.5
second into the future.
And i225 that [1] have 30-bit max 1 second into the future.


[1] 
https://github.com/xdp-project/xdp-project/blob/master/areas/tsn/code01_follow_qdisc_TSN_offload.org


