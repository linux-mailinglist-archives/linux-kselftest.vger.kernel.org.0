Return-Path: <linux-kselftest+bounces-24767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF632A1674C
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 08:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB73161BC3
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 07:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A96B18FC80;
	Mon, 20 Jan 2025 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yy4zCkjS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767B818E76F;
	Mon, 20 Jan 2025 07:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737357915; cv=none; b=r5kFVHcquIvPE41bGQAHtmzyp7aKAjpgp4XKU/UZW0ad0YtZdZymzMBZLkfK4edXZjph4IAzfFnrJrZ77Qz4hsX9jGoYI4vdmRbnx+pRjiGPix6gxwcEOtKSDFqhyTmL9OTslICoCMXPtAj843gT19f23eSZoT2SyCMyokQnpl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737357915; c=relaxed/simple;
	bh=k4ykqooUPTL/roXw/fFpliH2XGWlf7OfDPK35rRh9HA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIePsndoVQMTt/rKue3No0ShgbX5sEofY2RfKzNIynwokt1USkMSkDvvbuSG1CpZmbSEesbc7FGvisZ6Zk4qXSAIV9sJgUWdNbncVayuENLudw+OgEH1JYooiFBjT8igsvrVbKPn4DfxM1iqejO1LyzH7lF8Siv77FAXO0fWpjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yy4zCkjS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737357913; x=1768893913;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k4ykqooUPTL/roXw/fFpliH2XGWlf7OfDPK35rRh9HA=;
  b=Yy4zCkjScxKE/31Z8LuC1hzfDmi3Ba3qksEZBqe3zzAOTkQJPZny9SIG
   Xv24gcEtk5tQ4YKn98a11s/pOonob70UcPV1Qfq1IGEsFMJJHQUh7xkvL
   zPcpnXghJ6ccDihKLiTO2jsXjDvgeofT9l4xhxqAoROr75/LKvjEGf8M1
   JlwQnP7Yj556oVLnGgKuTnzrvDyBcXXbPx4zXg7SmHXFwFWMuxjj65zQT
   Ela2XeHkh5o9FLHPpNTc5phEw9SVK9wPMQEKCLf9qKcedOFXWICGArhyJ
   SmMqCbUcpfEbNXhOooPJYFrMLtCMFXRtAEoOzh8nhNijZUpqAF5Mdya6M
   w==;
X-CSE-ConnectionGUID: ULi5aLoRQOC6Qix1bbBL3A==
X-CSE-MsgGUID: CkL7rpwuT8aK7RbN+EKUpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="37601860"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="37601860"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 23:25:12 -0800
X-CSE-ConnectionGUID: vyQrnkD1RKuZNocxarZucg==
X-CSE-MsgGUID: 4NfaGBcnSKmXfEo/7NNF7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="106224522"
Received: from unknown (HELO [10.107.2.109]) ([10.107.2.109])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 23:25:02 -0800
Message-ID: <20fa0b55-405c-4b7c-8c10-1f8d71c956b9@linux.intel.com>
Date: Mon, 20 Jan 2025 15:24:46 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 4/4] igc: Add launch time support to XDP ZC
To: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>,
 Song Yoong Siang <yoong.siang.song@intel.com>,
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
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
 xdp-hints@xdp-project.net
References: <20250116155350.555374-1-yoong.siang.song@intel.com>
 <20250116155350.555374-5-yoong.siang.song@intel.com>
 <84770113-2546-4035-8bd4-bf9cedcfb00f@linux.intel.com>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <84770113-2546-4035-8bd4-bf9cedcfb00f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/1/2025 2:25 pm, Abdul Rahim, Faizal wrote:
> 
> To be cautious, could we perform a stress test by sending a higher number 
> of packets with launch time? For example, we could send 200 packets, each 
> configured with a launch time, and verify that the driver continues to 
> function correctly afterward.
> 
I agree on this point. Could you perform the same stress test on the STMMAC 
driver as well?

