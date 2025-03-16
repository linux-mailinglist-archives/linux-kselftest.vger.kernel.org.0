Return-Path: <linux-kselftest+bounces-29163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEE3A637C0
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 23:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 989D87A53D6
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 22:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B6719A288;
	Sun, 16 Mar 2025 22:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="QAuAOimv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4211B2F36;
	Sun, 16 Mar 2025 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742165166; cv=none; b=cKfA9uvJYuLQq3oBU9JJa8lvoGfYiQlo2jz2ewOYucQklxTWT/tSmWGXNDu372JOz1afAVhJjhNVh6V9CQyEGhovY1kcyU9gYQjyp6sC7HUDovyp8GigLsIBr73+dBCWhtP0kJT37DQhoZNdcVp7J3fO8Z0BYZ1A8wSN6FNifl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742165166; c=relaxed/simple;
	bh=McSjGIXHh2Av65DgZBMYpMB/ZRpB7P7THV652GDGw5s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=vAFiQB9qeuIo7yEncMpY6NEK6ZeEDU6DtA0CwpZcKloV52WUTrPFGbtWofv7+zsn2JlVoars+Xvjh2t/2pWe/xJ3iG6Y+ZU2LWg7RNohOu1ZjPqSIrO0epQoFcVWZDRT/ULVMntzkbWX4d9WaDOLXvswotYeJasBI5g7/VyM/z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=QAuAOimv; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1ttwjw-00CYLO-AB; Sun, 16 Mar 2025 23:45:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=iUCl0YULHWl7vWJvbzTS4dRqJAjTHZgdzbK+wMY/LZc=
	; b=QAuAOimvOadcMKk1FkrV9MvInc+5xyiaYjQgn8YovY1gLq3AoAEXFnWynWCoH1cnmaEYmYz/J
	OsvkXpC/62LkGxrq9evoeeq3ixtkFBYh9sCfwRx1XZOWW2B0e1qA27D7QLClVHpNcSJfSvKhOqYZ+
	wROp5xUOULmbm4qFefjbhtlNmcHrGud3y2eT6BXZI4cmK8ADfRFidIPP7mShJFQZS6oowkHeqRcgw
	BhenvkxoeS4cRreZbu7nWuqU0fWWSbo1nEGRrOo2o/NxXxkr67l8eFk35UVRNHxYTXeUmXsIGbmMV
	xU9mY55ifYG3dPLf/IO+WdnAR9MciujoPaaiIw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1ttwjq-0007fM-GB; Sun, 16 Mar 2025 23:45:46 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1ttwjo-00AYw2-1x; Sun, 16 Mar 2025 23:45:44 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net v3 0/3] vsock/bpf: Handle races between sockmap update
 and connect() disconnecting
Date: Sun, 16 Mar 2025 23:45:05 +0100
Message-Id: <20250316-vsock-trans-signal-race-v3-0-17a6862277c9@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHFU12cC/3XNywrCMBAF0F8ps3Ykr7bWlf8hLtI82qAkkpRQK
 f13YxF00+Wdy5y7QDLRmQTnaoFosksu+BL4oQI1Sj8YdLpkYITVhJMacwrqjlOUPmFyg5cPjFI
 Z1A2zbUtPmnQdlO9nNNbNm3wFbya4lePo0hTia1vLdKu+cLsLZ4oUuVSSf3zb60vsw3xUYRMz+
 1Oo2FcYEhSMSkFtQ6xgP2Vd1zdkctakBwEAAA==
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

PATCH 3 fixes a related race. Note that selftest in PATCH 2 does test this
code as well, but winning this race variant may take more than 2 seconds,
so I'm not advertising it.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v3:
- Selftest: drop unnecessary variable initialization and reorder the calls
- Link to v2: https://lore.kernel.org/r/20250314-vsock-trans-signal-race-v2-0-421a41f60f42@rbox.co

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

 net/vmw_vsock/af_vsock.c                           | 10 ++-
 net/vmw_vsock/vsock_bpf.c                          | 24 ++++--
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 97 ++++++++++++++++++++++
 3 files changed, 122 insertions(+), 9 deletions(-)
---
base-commit: da9e8efe7ee10e8425dc356a9fc593502c8e3933
change-id: 20250305-vsock-trans-signal-race-d62f7718d099

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


