Return-Path: <linux-kselftest+bounces-26796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B32A38AC8
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 18:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84983B43FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 17:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCFF22B5A3;
	Mon, 17 Feb 2025 17:39:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3DC22A4E8;
	Mon, 17 Feb 2025 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813989; cv=none; b=QoYbCsgjTriOiOs7BvnMlFV1xTEcUIpPBHONaN0MkCj8vHm1308o60akzBxBWkK8b7LeJyTYHFfQArfQig2waTLFVyf15DLFIjZ6pwak2PMTnEsGhs+K26cAPWxv/MTgB6cHIfMxVvnoOM9b21+npzHfRRc0HyR97QRdaqr67uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813989; c=relaxed/simple;
	bh=PRTZbIsGA8Nc0ATeWU+MuKCsNsmGvZmADdAnNmIhl7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lpti0uX467h21SK2NlrlI+qmCWG7LYlCrS4ELrU0DjfJWMByYsZjNMDR5TT84YSIPM5OGFxJqlo7/MTb6CnjIISVqHytqvDzk4neb7JdYe2s70UQlzdhTg/cE54WTVZGhxjiJeLS6MrfsWi2NwKr4rbttwsMr8PhbO4tSyY5S5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tk4pt-0001we-HZ; Mon, 17 Feb 2025 18:23:13 +0100
Received: from [78.47.5.107] (helo=sdn-nic-test01..)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tk4pt-000Opa-0r;
	Mon, 17 Feb 2025 18:23:13 +0100
From: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	hawk@kernel.org,
	marcus.wichelmann@hetzner-cloud.de
Subject: [PATCH bpf-next v2 0/6] XDP metadata support for tun driver
Date: Mon, 17 Feb 2025 17:23:02 +0000
Message-ID: <20250217172308.3291739-1-marcus.wichelmann@hetzner-cloud.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27552/Mon Feb 17 10:47:21 2025)

Hi all,

Thank you for your review comments. Here is an updated patch series with
the requested changes.

To add a selftest for the metadata support of the tun driver, I refactored
an existing "xdp_context_functional" test which already tested something
similar but for the veth driver. I made the testing logic behind it more
reusable so that it also works for the tun driver and possibly other
drivers in the future.

The last patch ("fix file descriptor assertion in open_tuntap helper")
fixes an assertion in an existing helper function that I just moved and
reused. Somehow the file descriptor for /dev/net/tun turned out to be 0
when running in the BPF kernel-patches GitHub CI, so the assert condition
needed adjustment:
https://github.com/kernel-patches/bpf/actions/runs/13339140896

Successful pipeline:
https://github.com/kernel-patches/bpf/actions/runs/13372306548

---

v2:
- submit against bpf-next subtree
- split commits and improved commit messages
- remove redundant metasize check and add clarifying comment instead
- use max() instead of ternary operator
- add selftest for metadata support in the tun driver

v1: https://lore.kernel.org/all/20250130171614.1657224-1-marcus.wichelmann@hetzner-cloud.de/

Marcus Wichelmann (6):
  net: tun: enable XDP metadata support
  net: tun: enable transfer of XDP metadata to skb
  selftests/bpf: move open_tuntap to network helpers
  selftests/bpf: refactor xdp_context_functional test and bpf program
  selftests/bpf: add test for XDP metadata support in tun driver
  selftests/bpf: fix file descriptor assertion in open_tuntap helper

 drivers/net/tun.c                             |  24 ++-
 tools/testing/selftests/bpf/network_helpers.c |  28 ++++
 tools/testing/selftests/bpf/network_helpers.h |   3 +
 .../selftests/bpf/prog_tests/lwt_helpers.h    |  29 ----
 .../bpf/prog_tests/xdp_context_test_run.c     | 152 +++++++++++++++---
 .../selftests/bpf/progs/test_xdp_meta.c       |  56 ++++---
 6 files changed, 215 insertions(+), 77 deletions(-)

-- 
2.43.0


