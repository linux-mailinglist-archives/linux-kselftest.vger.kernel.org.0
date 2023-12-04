Return-Path: <linux-kselftest+bounces-1041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B16802FF6
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 11:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606C4281DE0
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 10:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9505E200DA;
	Mon,  4 Dec 2023 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj60O4w3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580E21EB58;
	Mon,  4 Dec 2023 10:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9B7C433C7;
	Mon,  4 Dec 2023 10:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701685017;
	bh=NvabCPUoEeNgkHlQOh++f/IpiYrFxijeYof5NfRPONE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gj60O4w3gXfZMoRfR6TVuuBMVNHiyEh6nUNydfFfRtKH2vJhhhVuUfP9Y4+rhdY5B
	 zjCUTsbEh5i2w9D6MgQWx68op4BJuUViJcr9vihhIQ8pM0QJhsxRJLcvyPKCr6mmvh
	 2fi5L0nxX4kFshYlSuzPTS0BbZwOLeu6gZ3GQp0LhzILev3EvwzL6CIBTA/cDwOP5S
	 DE1a4L0ovYgsibC0R82gwV80GU4EzfF3khZdF8IufKrqTVx7GteEKxJT8Lh7qC0oMP
	 fXKPG9TSggDDEaNpqmO1xTH+Yafxw1vMknRluaszrrr6d4GsKEX1oH+EnHBEKjkV1g
	 wSPOvEgh46O1A==
Message-ID: <8e20031c-83cb-4927-ab6a-e6b4840e1e42@kernel.org>
Date: Mon, 4 Dec 2023 11:16:48 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: add Launch Time request to
 xdp_hw_metadata
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
 <20231203165129.1740512-4-yoong.siang.song@intel.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231203165129.1740512-4-yoong.siang.song@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/3/23 17:51, Song Yoong Siang wrote:
> This patch is tested with stmmac on Intel Tiger Lake platform. Refer to
> result below, the delta between pre-determined launch time and actual HW
> transmit complete time is around 24 us.

Is there any NIC setup (e.g. ethtool/qdisc) requirements to enable HW 
for this feature?

--Jesper

