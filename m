Return-Path: <linux-kselftest+bounces-29938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E237BA75E33
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 05:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2477A188A4A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 03:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB0F86349;
	Mon, 31 Mar 2025 03:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u00bTW4x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B8113D8A4
	for <linux-kselftest@vger.kernel.org>; Mon, 31 Mar 2025 03:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743391618; cv=none; b=u+Ulb5f6+p15Gfx6/cQCIlEyPAlU8w/qoHzDaa5+pvOu5OYE+1Bj/XrRoX8u9A9Qew9OClUtqtLp/FXyxVPKyL1MsNaSHR4e47HROUTPC53OqEXtStZI9YJ5byhaKwFtsUniZw9DMU3xwyaTQtzHlpMMk0GYC5CE0hUcN8O/vSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743391618; c=relaxed/simple;
	bh=oP/qAE0ISo2Hd44LLcQo8O1Z+cux6205Kr3iC0Onwzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TchYT3CUI8yoLX/qOxZu6qwcX9FDRAacKcIbApyk9YiHTM28uDeqfuUVPb8JQXPdUzvHp4Yq7rdtemikoSXyCajm/8oixjzY2OXjiyJd25Ut90Glj/uaOoGFv4yg0w2P5zHp4Z2atVMoPTul/uoU9/7xC7iMijFTTixD+edCw5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u00bTW4x; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743391604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iENPp3LijFa+A7OLDZZ7hkUZawrs/WHbGdevCHNli/s=;
	b=u00bTW4xD+qolsQvKMENKBpx2kIkXWjw9s9wiHh3bPBmLsqYsWA3bkSaWBBtmkZAfM9D01
	m2RaqVzgFSk+aOuFgqZxJVhtlRlM3o/DH1n2fvRclONKQiZv4KV8CLUk8oevpAaqWq4iaM
	HP+At0io+uuRhdV2gSFqTSonsS51Kjc=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Jordan Rome <linux@jordanrome.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 0/2] bpf, xdp: clean adjust_{head,meta} memory when offset < 0
Date: Mon, 31 Mar 2025 11:23:43 +0800
Message-ID: <20250331032354.75808-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patchset originates from my attempt to resolve a KMSAN warning that
has existed for over 3 years:
https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64

Previously, we had a brief discussion in this thread about whether we can
simply perform memset in adjust_{head,meta}:
https://lore.kernel.org/netdev/20250328043941.085de23b@kernel.org/T/#t

Unfortunately, I couldn't find a similar topic in the mail list, but I did
find a similar security-related commit:
commit 6dfb970d3dbd ("xdp: avoid leaking info stored in frame data on page reuse")

I just create a new topic here and make subject more clear, we can discuss
this here.

Meanwhile, I also discovered a related issue that led to a CVE,specifically
the Facebook Katran vulnerability (https://vuldb.com/?id.246309).

Currently, even with unprivileged functionality disabled, a user can load
a BPF program using CAP_BPF and CAP_NET_ADMIN, which I believe we should
avoid exposing kernel memory directly to users now.

Regarding performance considerations, I added corresponding results to the
selftest, testing common MAC headers and IP headers of various sizes.

Compared to not using memset, the execution time increased by 2ns, but I
think this is negligible considering the entire net stack.

Jiayuan Chen (2):
  bpf, xdp: clean head/meta when expanding it
  selftests/bpf: add perf test for adjust_{head,meta}

 include/uapi/linux/bpf.h                      |  8 +--
 net/core/filter.c                             |  5 +-
 tools/include/uapi/linux/bpf.h                |  6 ++-
 .../selftests/bpf/prog_tests/xdp_perf.c       | 52 ++++++++++++++++---
 tools/testing/selftests/bpf/progs/xdp_dummy.c | 14 +++++
 5 files changed, 72 insertions(+), 13 deletions(-)

-- 
2.47.1


