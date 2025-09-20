Return-Path: <linux-kselftest+bounces-41992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A24B8C7C5
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 14:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E091BC24F7
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 12:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1538E30102A;
	Sat, 20 Sep 2025 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/JB0FbB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0891E32B9;
	Sat, 20 Sep 2025 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758370878; cv=none; b=Z9bBud8o8JIm+IdVQf06TKhrQp5WcsYRtEkYVApW5xwbNRha/6D9dmXQsMEgyr/nDbD/6WswFjEwoLKKJzc8TvIwPrT9lXY2vPH6e1AXVlUKTXknFguo1VtZsw0gwlhbEhwpDS5Bn5gUjEHSvZTnd2ehjLo7gfU3PJpY39xpIsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758370878; c=relaxed/simple;
	bh=NVkdqho2RdfTtEnWss8fjPZFDr1k2Eqt+Ul7r1LYIuk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BQ8aa5ML8XW8VEB+WCy/tRF2Y7oOoDoA2E3IvI5f4rF+wrLZq0h35FTwp36RyW59aFkolxdaB+lFTOUWXpQosJops5HgCSr5KQe2I/DQqUmAJvseAOesVHB5Eu0TAzEmgyeN3KyNkMivK8Mam4gBymnTibbZiKJCS55NMGwFy6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/JB0FbB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0FFC4CEEB;
	Sat, 20 Sep 2025 12:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758370876;
	bh=NVkdqho2RdfTtEnWss8fjPZFDr1k2Eqt+Ul7r1LYIuk=;
	h=From:Subject:Date:To:Cc:From;
	b=q/JB0FbBMl4rB04+QGbeN8J4+rpknWk6BuHkq9rFseP8jSMo/5S1Od2sjkKni4dL4
	 KUopOuyc7VpDlvBZkBUeJZREtGeMzsYCIxUQ8a0IaLiiLhw1g64PQV5/vDHlvZBetJ
	 VC0fi0HFghH3uzqVmZwnreqeNdElcvH4+kseI1zBNnUwBpjb24NIo2hY98Pq9YQJ7f
	 uKsj4eRAWfd5iQmcV+DqMcKqvB5tBrQnfuXYQiDznLyL50q5QlJPsTU664c1dEiB7n
	 yqQe/lK01oiNl+c0+l88NAyMKK+adcDfaxpqhwKuYP3vUiMy529F5Zp7S1oO3o0fZV
	 dfAfalQxKCstQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH RFC bpf-next 0/6] Add the the capability to load HW RX
 checsum in eBPF programs
Date: Sat, 20 Sep 2025 14:20:26 +0200
Message-Id: <20250920-xdp-meta-rxcksum-v1-0-35e76a8a84e7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAqczmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0NT3YqUAt3c1JJE3aKK5Ozi0lxdSzPj5CTjRHNL41RzJaC2gqLUtMw
 KsJHRSkFuzgpJBWm6eakVJUqxtbUAj3v4u3AAAAA=
X-Change-ID: 20250915-xdp-meta-rxcksum-963cb3a793e7
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce bpf_xdp_metadata_rx_checksum() kfunc in order to load the HW
RX cheksum results in the eBPF program binded to the NIC.
Implement xmo_rx_checksum callback for veth and ice drivers.

---
Lorenzo Bianconi (6):
      netlink: specs: Add XDP RX checksum capability to XDP metadata specs
      net: xdp: Add xmo_rx_checksum callback
      veth: Add xmo_rx_checksum callback to veth driver
      net: ice: Add xmo_rx_checksum callback
      selftests/bpf: Add selftest support for bpf_xdp_metadata_rx_checksum
      selftests/bpf: Add bpf_xdp_metadata_rx_checksum support to xdp_hw_metadat prog

 Documentation/netlink/specs/netdev.yaml            |  5 ++
 drivers/net/ethernet/intel/ice/ice_base.c          |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx.h          |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c      | 82 ++++++++++++++++++++++
 drivers/net/veth.c                                 | 19 +++++
 include/net/xdp.h                                  |  6 ++
 net/core/xdp.c                                     | 29 ++++++++
 .../selftests/bpf/prog_tests/xdp_metadata.c        |  7 ++
 .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |  7 ++
 tools/testing/selftests/bpf/progs/xdp_metadata.c   |  1 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c      | 27 +++++++
 tools/testing/selftests/bpf/xdp_metadata.h         | 13 ++++
 12 files changed, 198 insertions(+)
---
base-commit: 315f423be0d1ebe720d8fd4fa6bed68586b13d34
change-id: 20250915-xdp-meta-rxcksum-963cb3a793e7

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


