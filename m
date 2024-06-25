Return-Path: <linux-kselftest+bounces-12622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87BA916104
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 10:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29BA1B20CD5
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 08:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB524147C82;
	Tue, 25 Jun 2024 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhlyOSPw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4DF22313;
	Tue, 25 Jun 2024 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303902; cv=none; b=CF3zaZvAhcpfp2rYnQq2nBeJeVvHc0HfV++aJ3jKMzZyjyUEQ/u/Zri3rQrJENU8HrCeY1vdLo0b1LdJE8pId904/wA5Xqd2Go5nYHdbjnKqR8j6hKrd3FOAaDdVP0C7y7q5VthsKx54F/RBclHy0sO48Tq/zGaw/at8/9QSiu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303902; c=relaxed/simple;
	bh=IJz4K1NpgKiO1D1uxenWzANl7YLOM8HyLsqnN1DRtzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LONBZ/tbXxSSsUwcDM6HmIHwGcwhYVFpf1GT4+aX9MPCkfnClCKPgFjZB4epMnEHWtcdqsXnhzfKhmgHiJYY12s1t/DOMTRGjjk8cgY5iQTPFKVg4RoRlEAKGpPOFVU3lDXqE8GxUxR+Mh44NPfS/c78CeL0RZ5yCVpJj2WQ7jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhlyOSPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E581C32786;
	Tue, 25 Jun 2024 08:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719303902;
	bh=IJz4K1NpgKiO1D1uxenWzANl7YLOM8HyLsqnN1DRtzU=;
	h=From:To:Cc:Subject:Date:From;
	b=uhlyOSPw9qCovCouKC8yk8qCn00YzUufDt4hki1ncby7paMSY2G1cOLOIa0ScTiVk
	 2LP1tYX29i7mmsbaso/CwqaJDrTjTGnjxObbGwlC/zbLdSyqLV2c234fTmUqIyqrBn
	 R5eLjcOfp5MoiGJSXLMmINgfJtBuVBBRTOBU0ad6Vsu/DRjDFeimzewV+B+Jyrlfnf
	 FBR+TJYanQVa4VoAEFy8c+ebF/xLjl3fJ/c7PQGZ9ZPD5Tk5qvMN58VBU/DpyXUmyl
	 7pcLuR4sKr+ZhHAbTN7oEwR0Urai/OqfKP1vBoq+/BJIM5jEPo3MJ30Bb5Fg+C3uZo
	 gVIOnibIMMySA==
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
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 0/4] Fixes for BPF selftests on Loongarch
Date: Tue, 25 Jun 2024 16:24:35 +0800
Message-ID: <cover.1719302367.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - add patch 2, a new fix for sk_msg_memcopy_from_iter.
 - update patch 3, only test "sk->sk_prot->close" as Eric suggested.
 - update patch 4, use "goto err" instead of "return" as Eduard
   suggested.
 - add "fixes" tag for patch 1-3.
 - change subject prefixes as "bpf-next" to trigger BPF CI.
 - cc Loongarch maintainers too.

BPF selftests seem to have not been fully tested on Loongarch. When I
ran these tests on Loongarch recently, some errors occur. This patch set
contains some null-check related fixes for these errors.

Geliang Tang (4):
  skmsg: null check for sg_page in sk_msg_recvmsg
  skmsg: null check for sg_page in sk_msg_memcopy_from_iter
  inet: null check for close in inet_release
  selftests/bpf: Null checks for link in bpf_tcp_ca

 net/core/skmsg.c                                 |  4 ++++
 net/ipv4/af_inet.c                               |  3 ++-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c        | 16 ++++++++++++----
 3 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.43.0


