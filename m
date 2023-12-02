Return-Path: <linux-kselftest+bounces-1018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1106C801A3A
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 04:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8FD1C20B87
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 03:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7D17497;
	Sat,  2 Dec 2023 03:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyOxrWYM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E2B613E;
	Sat,  2 Dec 2023 03:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30426C433C8;
	Sat,  2 Dec 2023 03:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701487728;
	bh=5Iznkl7Y/UaOI16u1p9z9TNAVqCqy4L/LgDnEnmoT0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IyOxrWYMs6Tj+TmW+3JjcrBCpnsAtOryyhNLFggtzwjzTTFSihe51dj8JMLpA0CEs
	 vNbukE02lwU+Ozm3SWICClspjaDDjvSFN/AN1z2sPL6CZ3L0UI8EBf8EbHewUl718f
	 8+3F63d8ipmvFP8hnwnv+f2T3VGHF1Bk0FKzm0YWnNx0uTyJ5k4GxWtXg42a0JPoYo
	 M9J1J803EXwuwH8LBrpmYO9gXvyQCA9DEl+lA+8u9dquFdXWh9c18EXDlMlgm2ynfX
	 3LPjdLfYgaQqvobwJ+Qsa+q3Vl3fGmx1gNtzF8r035Wjd1vTDwfE2YMir+p8t1fFvE
	 yOQpikEFSl2NA==
Date: Fri, 1 Dec 2023 19:28:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Bjorn Topel <bjorn@kernel.org>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@google.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Mykola
 Lysenko <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, bpf@vger.kernel.org, xdp-hints@xdp-project.net,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/3] xsk: add launch time support to XDP Tx
 metadata
Message-ID: <20231201192846.15c9e64e@kernel.org>
In-Reply-To: <20231130162028.852006-2-yoong.siang.song@intel.com>
References: <20231130162028.852006-1-yoong.siang.song@intel.com>
	<20231130162028.852006-2-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Dec 2023 00:20:26 +0800 Song Yoong Siang wrote:
> +        name: launch-time
> +        doc:
> +          HW Time-Based Scheduling (TBS) is supported by the driver.

Does this mean fifo "gating" or HW can do reordering?

