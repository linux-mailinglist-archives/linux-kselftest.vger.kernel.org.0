Return-Path: <linux-kselftest+bounces-12490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C92F3913158
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 03:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55C4DB222EC
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 01:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8843B4404;
	Sat, 22 Jun 2024 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cH0vvsIl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E32D1FA5;
	Sat, 22 Jun 2024 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719019441; cv=none; b=Rpj6uXMvMFUyza2MvzURpGdAFDLc5SEWhuCc+LYfE9bdqr9Ti1GOuLmc8t1dOE3pWNiPOWzQX8CJN7ikLZElk2lKXECqyvx9zpVmFLwOLK0eCkxztvcLV3wKgSwhDUfNBHOXeevCB25aoTD8Ijc/HAVm136WpNmQ5K9ylo9zLss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719019441; c=relaxed/simple;
	bh=reumwBHI1zLQ/5vrBjN15ADi/BArsSzVBlef55rbhsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dfl1GMZf2VDxBKIjD1AMCjaMqwFwUKaCJjvvkcyZnMhGc5iA970MfyCub40JdB1n+FRNGCrNtyF4muBpwpCd4KHRa0yiQG2V2AyXJwhuiRaHzauI4of12pzdS7KzCwNfVkWZaYuWHL4ITGJOM6xPqd9fky55WjswmUeI/oSefZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cH0vvsIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D41C2BBFC;
	Sat, 22 Jun 2024 01:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719019441;
	bh=reumwBHI1zLQ/5vrBjN15ADi/BArsSzVBlef55rbhsI=;
	h=From:To:Cc:Subject:Date:From;
	b=cH0vvsIl4d60ecTIujWoqSxznK39opRj2nx8VxsZIGotJF6qG+C2QUq7eC81izFRW
	 LJG6tXqFKhl9mFlNjsWkq85lvAPx8CKSgSvq9Gi48qsh3MOJZ7eEb7yz2R4U0DRPRr
	 tPYPBfJAPlpIVOpkYXjiVz5voyja/JpsOV2epWKWh/gROONIG4xES/4oxIbYDudzFn
	 uoE7LgFF0zqhyqD8RU7ktSTeuKpxf16/L2bvWAxVKA/VFzzpPlIE3WpZC2eozg37UN
	 ESuQ2bxYCb1qOdfWb563ZnRm/FZxIeEXgv5Kxu4swykImj2AvIFLUU+9NMqjxcHhLc
	 8gpqmYrwqjqwA==
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
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 0/7] use network helpers, part 8
Date: Sat, 22 Jun 2024 09:23:40 +0800
Message-ID: <cover.1719019125.git.tanggeliang@kylinos.cn>
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
 - address Eduard's comments in v1. (thanks)
 - fix errors reported by CI.

This patch set uses network helpers in sockmap_ktls and sk_lookup, and drop
three local helpers tcp_server(), inetaddr_len() and make_socket() in them.

Geliang Tang (7):
  selftests/bpf: Use start_server in sockmap_ktls
  selftests/bpf: Use connect_to_fd in sockmap_ktls
  selftests/bpf: Use start_server_str in sk_lookup
  selftests/bpf: Use connect_to_fd in sk_lookup
  selftests/bpf: Use connect_to_addr in sk_lookup
  selftests/bpf: Drop inetaddr_len in sk_lookup
  selftests/bpf: Drop make_socket in sk_lookup

 .../selftests/bpf/prog_tests/sk_lookup.c      | 138 ++++++------------
 .../selftests/bpf/prog_tests/sockmap_ktls.c   |  32 +---
 2 files changed, 52 insertions(+), 118 deletions(-)

-- 
2.43.0


