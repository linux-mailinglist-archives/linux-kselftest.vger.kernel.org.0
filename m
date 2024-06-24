Return-Path: <linux-kselftest+bounces-12554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC1F914E64
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 15:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE891C220DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 13:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3BB13D89A;
	Mon, 24 Jun 2024 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXB+HlCv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305591311A1;
	Mon, 24 Jun 2024 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235689; cv=none; b=FGJA7AgXBMhW5GfmG7zJVcrR6ikxbNHlEBbq1DWmGGGGWLVrw7UjtlD3xevyyhJx5cWRPrRrCjBOMtn4dyusOoOcXnOFNt5PeVgPBJbMyO79XlBuIYlyj1h+IC5GyCTxbxgBg3hovMs9fJJiXR07mcXkMfLYXK/sBNbHEMbwgII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235689; c=relaxed/simple;
	bh=Zn2Kd04iJelTbJ0C0rm+TQpRo5c6Rg3np49R/GQosys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EhoiFW4Wwtu/ieRbOFbbsVYbCKCDFv5gqU4yCgKWLp2P0yWkXLwUTycW/dPWNrw+yUclOtawbz0r9ioEH1xExDvDDLlU+xA3jBP+rBMAHU6thgJaoNJfw+7FCIAY2zwznJ8A4gYvDtYxx4oxilY6mTkf0cw5MDQRdidi33IqJws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXB+HlCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFCBC32782;
	Mon, 24 Jun 2024 13:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719235688;
	bh=Zn2Kd04iJelTbJ0C0rm+TQpRo5c6Rg3np49R/GQosys=;
	h=From:To:Cc:Subject:Date:From;
	b=PXB+HlCvLUIFyEAfztGxKcY8Enc/NVWxkKorr1dqr0QQ/7yTz0w2nVHXiUsL6xqz8
	 C2rLCHj+45+nByrm2TG+G5bwTdRBX7p79PCjK5PZMH8J0W2ngiXrjxHLTBop8CtKEF
	 2zMIGHgDsBIE/yeFxI/l/ySlXnnA6oQthFlI8WyJ9yiwtGsV6x8H3z1CdjofOsraAz
	 mnVFDGkyUBXMdUBoSP4N7yyjBAxzx9+vS7apOiRa2mrAHOAv0gW96RLSvzDxXpWICf
	 foSZFZIVkvaHuARysyhWXThhjV52GhLe3jMJ1W/8u4/GDejGWxMYwXf1Mb21mUqnO+
	 jqSZs+uwcsPUQ==
From: Geliang Tang <geliang@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Miao Xu <miaxu@meta.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 0/3] Fixes for BPF selftests on loongarch
Date: Mon, 24 Jun 2024 21:27:54 +0800
Message-ID: <cover.1719234744.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When I ran BPF selftests on loongarch recently, some errors occur. Fix
them in this set.

Geliang Tang (3):
  skmsg: null check for page in sk_msg_recvmsg
  inet: null check for close in inet_release
  selftests/bpf: Null checks for link in bpf_tcp_ca

 net/core/skmsg.c                                    |  2 ++
 net/ipv4/af_inet.c                                  |  3 ++-
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 12 ++++++++----
 3 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.43.0


