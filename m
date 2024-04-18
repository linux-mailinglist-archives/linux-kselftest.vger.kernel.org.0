Return-Path: <linux-kselftest+bounces-8295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2618F8A949D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 10:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54861F218CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 08:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110377C0A9;
	Thu, 18 Apr 2024 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c50DuMZX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABDC2C68C;
	Thu, 18 Apr 2024 08:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427763; cv=none; b=t3U65U0lA6jJTNYfOOHvlVed87Y3sQv6zBpyYN1Blr4m61jFbU+L5QCgrF27azmPz1w0oU2S3rlpZE6ZLEpLvNRFc8gSJN6rPt92cKOW0Ljxx8/tOwXOpQ4N+3Q1ciC9dZWhVSYUqP6oXX0umLOgN3jXF2oOnNTV0o0DqRSVJqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427763; c=relaxed/simple;
	bh=GgBu/265OwPK3B0kJT+e5NvpOr2SjWvsiC7uIxYDomw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UCyd6wPxEEB6pxAWbbq4XHkMgKf6FzbteQ2jqqqMPD9uMbsU8Rh1YxqmW5KJ6TpDKF11gY9bRRO2KWF87Rbc6TZX00iqi1qrlQ8uzWDmt72SGWb4knGWvHAb+v7PFQD1EjF8W4bYbIlUbj3NEiQHBYnv0TI5HkGWmkztilMbE9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c50DuMZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8158DC113CC;
	Thu, 18 Apr 2024 08:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713427762;
	bh=GgBu/265OwPK3B0kJT+e5NvpOr2SjWvsiC7uIxYDomw=;
	h=From:To:Cc:Subject:Date:From;
	b=c50DuMZXWAusQmseGfOucdQfhthQC+HMmeUs5q8JaSN374vrm+6G7ApC7A0KU3tv1
	 RNz/O2WQbf8zy0QkpwmaFjguF9lg3SNBlcm9GodI5KMf9l53n1g65+WCPFy3n1y0L+
	 t71uPH49J6HElEtglGAhZIjiPdl3hauYRPBj4Ne1rqSH1553cyKl06AhFx3I3hQshW
	 7oXAFSPsiqNBBbuxNpi363KClFTs5DL/eCX9bEfQKXkaG2ITA9vIXd82A9olBv/9P/
	 dWHhPs0HXOZfjeKTwaNzeKHwDNkJBtopkQjFPTffE1R93T1ACyOyZ1O3avWqQoZdo7
	 oHScQGlp2wSHA==
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
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next v5 0/6] use network helpers, part 1
Date: Thu, 18 Apr 2024 16:09:06 +0800
Message-Id: <cover.1713427236.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v5:
 - address Martin's comments for v4. (thanks)
 - drop start_server_addr_opts, add opts as a argument of
   start_server_addr.
 - add opts argument for connect_to_addr too.
 - move some patches out of this set, stay with start_server_addr()
   and connect_to_addr() only in it.

v4:
 - add more patches using make_sockaddr and get_socket_local_port
   helpers.

v3:
 - address comments of Martin and Eduard in v2. (thanks)
 - move "int type" to the first argument of start_server_addr and
   connect_to_addr.
 - add start_server_addr_opts.
 - using "sockaddr_storage" instead of "sockaddr".
 - move start_server_setsockopt patches out of this series.

v2:
 - update patch 6 only, fix errors reported by CI.

This patchset uses public helpers start_server_* and connect_to_* defined
in network_helpers.c to drop duplicate code.

Geliang Tang (6):
  selftests/bpf: Add start_server_addr helper
  selftests/bpf: Use start_server_addr in cls_redirect
  selftests/bpf: Use start_server_addr in sk_assign
  selftests/bpf: Update arguments of connect_to_addr
  selftests/bpf: Use connect_to_addr in cls_redirect
  selftests/bpf: Use connect_to_addr in sk_assign

 tools/testing/selftests/bpf/network_helpers.c | 27 +++++++--
 tools/testing/selftests/bpf/network_helpers.h |  5 +-
 .../selftests/bpf/prog_tests/cls_redirect.c   | 38 +------------
 .../selftests/bpf/prog_tests/sk_assign.c      | 55 ++-----------------
 .../selftests/bpf/prog_tests/sock_addr.c      |  6 +-
 5 files changed, 37 insertions(+), 94 deletions(-)

-- 
2.40.1


