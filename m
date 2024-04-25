Return-Path: <linux-kselftest+bounces-8834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2256B8B1964
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 05:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B511F22D7A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 03:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EEC1CAA6;
	Thu, 25 Apr 2024 03:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfG/Pp7V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D051C6A8;
	Thu, 25 Apr 2024 03:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015462; cv=none; b=GH0lDG3m4E/X7Vii9x6XXuFvreNADY+cILxrpMoYjzJmbAZZuWwHmhjQc5lsaNXTjUXnbPt16haXWKdCsH9Um1U6KCoxjZp3N/zGXg5DPv+aU5Y2ii5iVFbQ5axhSIqFrw5Hti4iWIWNwrYMna8xg/s3glsXnjNHnZ6YvwNYPng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015462; c=relaxed/simple;
	bh=LYWNoznwAqbIjH82tdL14xos7Rbx4vG9o/9WhTJVG6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G4KgT/ZnQl5MA8KK075gozAIOANdPDFdfUN3Bx6C8VFJb7fhQe/7hLuOxpdywjN7Nynf8tI06jVTTP0KRYLymtzsCAShVwHG5sZXj5vUk7Vf2Q/bJ65TLl+8Z1/Gq/t9WIGup6xjPLMWmvTzvBfODXCqgdsK/X4AwZbsSJxER+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfG/Pp7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B2AC113CC;
	Thu, 25 Apr 2024 03:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714015462;
	bh=LYWNoznwAqbIjH82tdL14xos7Rbx4vG9o/9WhTJVG6s=;
	h=From:To:Cc:Subject:Date:From;
	b=WfG/Pp7V7A6KledbExjZwCUMIUQlTOxfpqMVI0RyA7JMmhPi7xx06Roc8ctSX3EpJ
	 6u4uMaZAAJTRXVBflC3ebxksMUbOkSbIKn1zT7ttNjWoBos8jXYI+y/PeQ/YwWbvFY
	 xFPpf8ZqAHshvKYTl6+k6gEGSDqRw1odEA0vSHOz4LMZ8eW89L+PzQXJujQL3e5eUq
	 mF8KXSvXaCsT+9t7A5rGO/3HO7rK0b7aivXBAxNiVmmgzp2MWLZELP/+AyNenO2UKE
	 5B8wTGyCfiM1yw2Gp833+Hxpx1jnwFf3JfCaWsQwYD3HPNGfxk1yBQwcQPRLh7Fpg0
	 JdAdnMkZSuIBQ==
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
Subject: [PATCH bpf-next 0/6] use network helpers, part 3
Date: Thu, 25 Apr 2024 11:23:40 +0800
Message-Id: <cover.1714014697.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patchset adds opts argument for __start_server, and adds setsockopt
pointer together with optval and optlen into struct network_helper_opts
to make start_server_addr helper more flexible. With these modifications,
many duplicate codes can be dropped.

Patch 4 addresses comments of Martin and Eduard in the previous series.

Geliang Tang (6):
  selftests/bpf: Add opts argument for __start_server
  selftests/bpf: Make start_mptcp_server static
  selftests/bpf: Drop start_server_proto helper
  selftests/bpf: Add setsockopt for network_helper_opts
  selftests/bpf: Use start_server_addr in sockopt_inherit
  selftests/bpf: Use start_server_addr in test_tcp_check_syncookie

 tools/testing/selftests/bpf/Makefile          |  1 +
 tools/testing/selftests/bpf/network_helpers.c | 53 ++++++++-------
 tools/testing/selftests/bpf/network_helpers.h |  5 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 16 +++++
 .../bpf/prog_tests/sockopt_inherit.c          | 34 ++++------
 .../bpf/test_tcp_check_syncookie_user.c       | 64 ++++++-------------
 6 files changed, 78 insertions(+), 95 deletions(-)

-- 
2.40.1


