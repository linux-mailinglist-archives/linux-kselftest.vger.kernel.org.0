Return-Path: <linux-kselftest+bounces-12908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4B591B67B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 07:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192671F23246
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 05:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E974446BF;
	Fri, 28 Jun 2024 05:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ffa19eT/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D47534545;
	Fri, 28 Jun 2024 05:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553690; cv=none; b=pMLZl9QbyakgR+VVx1Ja7JTyI/4lKlwmO3+LgzxuhM8B9o70exZqjHFaQFHXkOduY4JpIegi2TX9LdtpDGZfulaWPNLWyohDStdLN7AIiua33yoK7H+if71A69uaeG2M2aNO4fuSmoD0zpNpWwIsmdHh5azb707YhGReNJ0PYWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553690; c=relaxed/simple;
	bh=Z76rzcljUONi7dei97knw/kRt0vj5F11xjjT56H6wyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r+8XHGUQB/r8GArSchgIF9xIMa0y/B3XsW5p1mkmYVq8UTJ7Qncqt1KZDr+jlwF6vOJ0ML8nCuxUl7n0dqn6Ps3qoV+Ido+fKIGwx4+Gd1YXM+bjN6abob64UIjVyH+djMxM7frFb1XF33B+9YWTsW+pvvD1MA3V4Zk8LjzkUKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ffa19eT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5B0C116B1;
	Fri, 28 Jun 2024 05:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719553689;
	bh=Z76rzcljUONi7dei97knw/kRt0vj5F11xjjT56H6wyk=;
	h=From:To:Cc:Subject:Date:From;
	b=Ffa19eT/iY9uwQRNut2KnWtx9C7C1Z+YjKpp6t49Glg2pfPn5zEtJTWGkIbvDvZRA
	 m6rwp7W2qyMyz4xtYG1DzScZT8V3V3I/6tWhUAAmzRAF8ewOtiQyriRqQEitAUjbaE
	 2N6FwODgtD+9r4w8vi16Y8NrMakBADunNuABnTr2IYoJ/Gp8/J8T7wFs0UXJvAfNlb
	 Aze+Gn0BHv2LsWy0i0VCgo0WZV2IXOm5nFD9N+lXYJBbwxLLe0vfmXLnlgMAKOh5c1
	 XjQKS41+qa1QmS8yhwWZAWUWkbgAcYc33oXYHZeRcBlqu4kbXOkRA620coqXZS4NoE
	 pYkbDhRy2/FUw==
From: Geliang Tang <geliang@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	David Ahern <dsahern@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
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
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v3 0/2] bugfixes for skmsg
Date: Fri, 28 Jun 2024 13:47:46 +0800
Message-ID: <cover.1719553101.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - modifications that better address the root causes.
 - only contains the first two patches for -net.

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
contains two bugfixes for skmsg.

Geliang Tang (2):
  skmsg: prevent empty ingress skb from enqueuing
  skmsg: bugfix for sk_msg sge iteration

 net/core/skmsg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0


