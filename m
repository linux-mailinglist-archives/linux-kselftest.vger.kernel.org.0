Return-Path: <linux-kselftest+bounces-11749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60B3904EF8
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 11:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD452878DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 09:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC2716D9AD;
	Wed, 12 Jun 2024 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHthljbr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C08A2AEE3;
	Wed, 12 Jun 2024 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718183958; cv=none; b=eWszQPnp7M9a6HSXjI9uN8sXoj++yhWLbnzzApuuhPCdJqeoi/hgn6rCpUx2RFGCoJNAjIvP2KLqoVjoivdxc7FGnRk3m+kEKqq85qrw0qr6N6vAiHcmq4A7WEhCOsBQ2Uami4T64UdjFRGZZkKsANLFStC1ud7LFAyu+phWVO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718183958; c=relaxed/simple;
	bh=Un3bdpi2BY22AHaD7aZa2LiRUQUIUI2YWxRPWmPu3CM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YFMmKKZGRHcrIOJdEoPAso+h0sPK+2PCeWOpITFpIIyhYsmBPpUShyd8KHrKZv4xG1fZyGEBwc4xFXRsFRs58dKgEScEfLLzUZGh552eV1ug+Xa94m7yrAwHiRyQKoRTnxKENazBcWwJwry2SyhqjvNVzWham5BSN7Fg1RTHgvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHthljbr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EBAC32789;
	Wed, 12 Jun 2024 09:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718183957;
	bh=Un3bdpi2BY22AHaD7aZa2LiRUQUIUI2YWxRPWmPu3CM=;
	h=From:To:Cc:Subject:Date:From;
	b=rHthljbrMULQ/fu2CK/NCPF4bCEfiz4LExs6Fj9r9wZy3KHTyky9Z1a9VzjNKEAon
	 Fi2FmT/uSf/oDWK8SgG/muuAyGufmYG9A+yf/kfZg5LERXCTS6a2ysN7wTNt4NJeqO
	 n+cXHKvjS4rc7MpKlgWsQV7/IWQLaZ3YRpr2FW6znqBG7ftWbff6p3OrO3zv0mFkEH
	 FX2yXt7SqingWYuroxoWGq895fEHzxSSDS/QEKnPJMcEHtn0YKx6qNv5nyvvEbIUUd
	 fOOZK56fcfKr5QCQxPhXsyDrfDP8XisHsOTaD1KmupuRcxxWfwZ5RahYp058KcbLPd
	 9vY/dnPVnzExg==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v7 0/2] Add F_SETFL for fcntl in test_sockmap
Date: Wed, 12 Jun 2024 17:19:02 +0800
Message-ID: <cover.1718182183.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v7:
 - a better fix for tls_sw_recvmsg.

v6:
 - add a fix for tls_sw_recvmsg().

v5:
 - add a new patch "Check recv lengths in test_sockmap" instead of using
   "continue" in msg_loop.

v4:
 - address Martin's comments for v3. (thanks.)
 - add Yonghong's "Acked-by" tags. (thanks.)
 - update subject-prefix from "bpf-next" to "bpf".

Patch 1, v3 of "selftests/bpf: Add F_SETFL for fcntl":
- detect nonblock flag automatically, then test_sockmap can run in both
block and nonblock modes.
- use continue instead of again in v2.

Patch 2, fix for umount cgroup2 error.

Geliang Tang (2):
  tls: receive msg again for sk_redirect
  selftests/bpf: Add F_SETFL for fcntl in test_sockmap

 net/tls/tls_sw.c                           | 3 +++
 tools/testing/selftests/bpf/test_sockmap.c | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.43.0


