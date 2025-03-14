Return-Path: <linux-kselftest+bounces-29052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13825A614AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 16:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B9A1746B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A19202C3E;
	Fri, 14 Mar 2025 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ZaKdfTcQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A81E200BA3;
	Fri, 14 Mar 2025 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965644; cv=none; b=FbYBg2cnQutYnovBHucYlSJygHIAHM1P70DebHxwhn0My0wso0T12z1a3+4zpDmySV85lSjhj1tvc6fpgj0kuRQxwA80bmFJ+7phyO8Zvyw2Y227EzGslQrOUO7ADjlbzRJnBoNO2aaa9wlaajgKWAO+hZr4NCnAsCvYexKjiVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965644; c=relaxed/simple;
	bh=NTuhSRcIjIKwu/EhWlBaePFWOMZukrVSx2sagJ05bQY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AR24VkGhsESafa2/ZxhGmhCAg5U0cGoF0tnXDsv++/L9f5ItTpYA8wZLVTk3kmSuxLycl5m1zDoCQFpNNw5t/yNG7WOTW3u7xKamfUt+0tpETHIsOPL8fl81M9zrxWcKD9/2ksibmk0w08GpcLIpFtNFpLriVjMYk2B3A1UxR7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ZaKdfTcQ; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tt6pt-006UWb-Gh; Fri, 14 Mar 2025 16:20:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=V3VbFr18RuFUXg+1KPmBQkgSb64jtIsc05hljXlhkhE=
	; b=ZaKdfTcQGOKnSbvx3bKPtjhJaxiKejhpXrvSJcVNDGReRW53gI0eFsK26uY2Z8oEOUwpTKZLA
	VoMawNVj7zYVpqq0xoeBx6cEHqA/TMgZvESKoBENynb1BPU19m37Lpq8t53d0MZnBNihRx+jFbt0E
	UZSsPL69OdpugpBbrAy6+anCT7CwplfFu0QB+4MHRnD/V0nO0a7197dqyJyTbZ980bxSaH1z7i9OL
	Um5IOtVY8SjYhP3wa8nPuDlyuLnMKc9q7csmiTbb8YUijWN8TsreeEVAGwGeWAhPbW9kEeb/toktH
	CAF1C/s2JS528bVkoOz8mjGq1z9W4xoHo3i0CQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tt6pt-0004Nz-15; Fri, 14 Mar 2025 16:20:33 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tt6pZ-00H06E-PD; Fri, 14 Mar 2025 16:20:13 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net v2 0/3] vsock/bpf: Handle races between sockmap update
 and connect() disconnecting
Date: Fri, 14 Mar 2025 16:19:33 +0100
Message-Id: <20250314-vsock-trans-signal-race-v2-0-421a41f60f42@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAVJ1GcC/3WNwQ6CMBBEf4Xs2TVtCaKe/A/DobQLNJrW7JIGQ
 /h3K/Hq8c1k3qwgxIEErtUKTDlISLGAOVTgJhtHwuALg1GmUbVqMEtyD5zZRkEJY7RPZOsI/ck
 MbavPXl0uUNYvpiEsu/kOkWboSjgFmRO/97es9+onbv+Ks0aNtXW2/vqH3t+4T8vRJei2bfsAc
 0bry8EAAAA=
X-Change-ID: 20250305-vsock-trans-signal-race-d62f7718d099
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Signal delivery during connect() may disconnect an already established
socket. Problem is that such socket might have been placed in a sockmap
before the connection was closed.

PATCH 1 ensures this race won't lead to an unconnected vsock staying in the
sockmap. PATCH 2 selftests it.

PATCH 3 fixes a related race. Note that here the race window is rather
difficult to hit and I can't think of an easy way of testing it.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v2:
- Handle one more path of tripping the warning
- Add a selftest
- Collect R-b [Stefano]
- Link to v1: https://lore.kernel.org/r/20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co

---
Michal Luczaj (3):
      vsock/bpf: Fix EINTR connect() racing sockmap update
      selftest/bpf: Add test for AF_VSOCK connect() racing sockmap update
      vsock/bpf: Fix bpf recvmsg() racing transport reassignment

 net/vmw_vsock/af_vsock.c                           |  10 +-
 net/vmw_vsock/vsock_bpf.c                          |  24 +++--
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 111 +++++++++++++++++++++
 3 files changed, 136 insertions(+), 9 deletions(-)
---
base-commit: da9e8efe7ee10e8425dc356a9fc593502c8e3933
change-id: 20250305-vsock-trans-signal-race-d62f7718d099

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


