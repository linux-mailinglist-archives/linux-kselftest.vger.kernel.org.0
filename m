Return-Path: <linux-kselftest+bounces-42279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5338B9E61B
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 11:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684201BC7788
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 09:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97372ED846;
	Thu, 25 Sep 2025 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vhqk1Urd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4642ED15A;
	Thu, 25 Sep 2025 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792649; cv=none; b=BzEtWujI+1vOYlKSSfFQs8ZNO0MUehrPPZKCcf4IoxF2r18kWUyr/tPWwNTQW/FP5b6DfyPBpx2Uy/PNrrpgZzXvMT2TFp+XBB88hZ1wbmGBhad5ZogtuorGQSRpeyJA1GaJkvoKt2/jEBdtXBip+NVRrpj6gmV81nmGo5UF6f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792649; c=relaxed/simple;
	bh=ydju+tpSwXw5mzfVJvHmui6phZSUI1Dnie6FljNls88=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T1H4OMeuvjjmL2xc0XnbVxF3VV8NpLxqnr+sjKwtWCVA9Tw8vRzj7S0Te3zJG7IBWIefShcjvJ7py9XDtFF8621nENhGlc1xTzKmeHGr8uI7l7S3jHozW8u5quRQOE6BaHi06wfgfl7TeyFcHNTcul63yJ9t/QumaUNIEIQFqHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vhqk1Urd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B68C4CEF7;
	Thu, 25 Sep 2025 09:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758792649;
	bh=ydju+tpSwXw5mzfVJvHmui6phZSUI1Dnie6FljNls88=;
	h=From:Subject:Date:To:Cc:From;
	b=Vhqk1UrdoyWEdlEKcvryz+wZQuc1+abq6h07yJqir7W87dZkiYbEiaz/C5XZb0YZP
	 OoTi1Hodp8DeX/x1JeOliZ+dGLy+sHZIL++5Te5+L7t3yHxvxzhjt6G86cEOV8RfSk
	 WGFRbp3C+Q6n9o17jlHnofIz22n4XKuz4MX9DwMVxX6ojaVKC/SaWjdZ9sTpkBSSmu
	 Py8s7V2+OfWzk8AJCw5FGIfvbNwihu5RoR2MYczC3sd1e7lhp4Jlh/zWmzLtdnFEZP
	 Lm7TQr6BBLxZFuQneJesq+7R2TPRFbcT9z146mnkOeY2OSHRRAg9iq+Ba7ooe56sc4
	 nRX1T5Fsqi98w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH RFC bpf-next v2 0/5] Add the the capability to load HW RX
 checsum in eBPF programs
Date: Thu, 25 Sep 2025 11:30:32 +0200
Message-Id: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALgL1WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDSyNT3aSCNN2KlALd3NSSRN2iiuTs4tJcXUsDAzML01QjSwPLFCWg1oK
 i1LTMCrCx0UpBbs4KIF15qRUlSrG1tQAjnIsCdAAAAA==
X-Change-ID: 20250925-bpf-xdp-meta-rxcksum-900685e2909d
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
 Shuah Khan <shuah@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce bpf_xdp_metadata_rx_checksum() kfunc in order to load the HW
RX cheksum results in the eBPF program binded to the NIC.
Implement xmo_rx_checksum callback for veth and ice drivers.

Please note ice support changes are just compile-tested at the moment.

---
Changes in RFC v2:
- Squash patch 1/6 and 2/6
- Introduce enum xdp_checksum definitions
- Rework ice support to reuse ice_rx_csum codebase

---
Lorenzo Bianconi (5):
      netlink: specs: Add XDP RX checksum capability to XDP metadata specs
      net: veth: Add xmo_rx_checksum callback to veth driver
      net: ice: Add xmo_rx_checksum callback
      selftests/bpf: Add selftest support for bpf_xdp_metadata_rx_checksum
      selftests/bpf: Add bpf_xdp_metadata_rx_checksum support to xdp_hw_metadat prog

 Documentation/netlink/specs/netdev.yaml            |   5 +
 drivers/net/ethernet/intel/ice/ice_base.c          |   1 +
 drivers/net/ethernet/intel/ice/ice_txrx.h          |   1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c      | 125 +++++++++++++--------
 drivers/net/veth.c                                 |  20 ++++
 include/net/xdp.h                                  |  14 +++
 net/core/xdp.c                                     |  29 +++++
 .../selftests/bpf/prog_tests/xdp_metadata.c        |   7 ++
 .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |   7 ++
 tools/testing/selftests/bpf/progs/xdp_metadata.c   |   1 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |  27 +++++
 tools/testing/selftests/bpf/xdp_metadata.h         |  13 +++
 12 files changed, 206 insertions(+), 44 deletions(-)
---
base-commit: 5e3fee34f626a8cb8715f5b5409416c481714ebf
change-id: 20250925-bpf-xdp-meta-rxcksum-900685e2909d

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


