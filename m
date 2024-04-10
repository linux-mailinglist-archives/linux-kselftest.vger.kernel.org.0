Return-Path: <linux-kselftest+bounces-7532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A88589EBF2
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8931C20E70
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 07:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550EB13CFA5;
	Wed, 10 Apr 2024 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Py/QRe3n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A99226AC7;
	Wed, 10 Apr 2024 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734199; cv=none; b=Bk6jtZu97Udz7sNSvM+tcN7wi5I3jR9Geg1B1lMhmxOoGhKIra+8kBsJnX5JY3/kGJVR6yRNmSj56mCgbeG72fIO+BA/Cry5YXozGtdz0BJrkenuYmyRgPnyeKMGI885OC1eIquCsSak3VpPjGZr25UVHw0u/1fINic41HpkVGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734199; c=relaxed/simple;
	bh=yGub1F3Bu+mxTYX0x4VFM3NixEITqYhefvdT//rtP+U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SjhE9Y+rPsAUqabmstv/oil5J8HYYp2L7iZhfiy5/oN7VqneN8UXNJgZyxI9QqJd3Z05PTeUx6vknhUkBRf/hi6TyJjgbcDKLaNcbo3+Xpzrrrwd6nasYEhrmjUHfwAega6OxrdGPVob7E4RgVfILWLzyNeclNZqXDk91eEsiXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Py/QRe3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896FAC433F1;
	Wed, 10 Apr 2024 07:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712734198;
	bh=yGub1F3Bu+mxTYX0x4VFM3NixEITqYhefvdT//rtP+U=;
	h=From:To:Cc:Subject:Date:From;
	b=Py/QRe3nbz1xB1RbEthdo28hRVBYGcv0ZBJ/dzU5COY9nJGCPuRW+VwLRaQj5QWWq
	 UEqWgiKBGOIK7mCkBSSYUFsQ8kb4Kmu3UpAGNgIbSrQfydnROwuM/zrgScJ9GA4Ggz
	 NVaVMmVjpNbAqmnqeMiLV1xeuldEoEEgbVeAcDbBi4Wk8rvYlzb28wQv3WpvD7vKEr
	 dmN+0oNXHXp7mkG+Lw/hspFodhBOJUlLeBTsvZr/djadc5+FRmNJykp34seWCMLuWF
	 vjEd+ZszAZjMCmD/6EJHCt5CrCnd3VTO2OnmttcjxINarlD5s6M2u/kIOTLGqPPjG+
	 /3RN/qifweSWQ==
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
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 00/14] use start_server and connect_to helpers
Date: Wed, 10 Apr 2024 15:29:33 +0800
Message-Id: <cover.1712733999.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patchset uses public helpers start_server_* and connect_to_* defined
in network_helpers.c to drop duplicate code.

Geliang Tang (14):
  selftests/bpf: Add start_server_addr helper
  selftests/bpf: Use start_server_addr in cls_redirect
  selftests/bpf: Use connect_to_addr in cls_redirect
  selftests/bpf: Use start_server_addr in sk_assign
  selftests/bpf: Use connect_to_addr in sk_assign
  selftests/bpf: Use log_err in network_helpers
  selftests/bpf: Use start_server_addr in test_sock_addr
  selftests/bpf: Use connect_to_addr in test_sock_addr
  selftests/bpf: Add function pointer for __start_server
  selftests/bpf: Add start_server_setsockopt helper
  selftests/bpf: Use start_server_setsockopt in sockopt_inherit
  selftests/bpf: Use connect_to_fd in sockopt_inherit
  selftests/bpf: Use start_server_* in test_tcp_check_syncookie
  selftests/bpf: Use connect_to_addr in test_tcp_check_syncookie

 tools/testing/selftests/bpf/Makefile          |  4 +-
 tools/testing/selftests/bpf/network_helpers.c | 53 +++++++++----
 tools/testing/selftests/bpf/network_helpers.h |  4 +
 .../selftests/bpf/prog_tests/cls_redirect.c   | 38 +---------
 .../selftests/bpf/prog_tests/sk_assign.c      | 53 +------------
 .../bpf/prog_tests/sockopt_inherit.c          | 64 ++++------------
 tools/testing/selftests/bpf/test_sock_addr.c  | 74 ++----------------
 .../bpf/test_tcp_check_syncookie_user.c       | 76 +++----------------
 8 files changed, 85 insertions(+), 281 deletions(-)

-- 
2.40.1


