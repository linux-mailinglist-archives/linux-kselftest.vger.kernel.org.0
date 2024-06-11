Return-Path: <linux-kselftest+bounces-11635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 372DE902E55
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 04:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C17628205C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 02:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA63A15A87B;
	Tue, 11 Jun 2024 02:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmOSL/OD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA9FBA4B;
	Tue, 11 Jun 2024 02:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718072862; cv=none; b=L+BgR1JoFTYOUupUhwWHwSMmNOSG//srZJXYuhsx+grA0MKGNEVDpdOgcFcfPfYWpThzGcZfHKeUfozzNo6n4iLlZJ7Gt5MloVfB8oSVwLCSU88A/zOupHi+AXYG4jzLn7VaxpOcxBXkb7UMF/nAX6COGWR7+6qySEAI4JgskjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718072862; c=relaxed/simple;
	bh=z0m4g9iEfrsewDnHZgo6tDRz36et0pyWtVOWMqsxKXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eTibEth1ABCqcZDE2qJMgBhgRY5HXPDVNizk8EPx9HsNHYRCZr/i5FGMtNicTnCRXuCbhkdFd0wMqN3cZ7Ufr+5o4ui3aYeE7MtlZ8ESDH0kCNqJtQpVt+HlfGi4vLGQiTsqsdGlosiD8ZxaGwM6D7n+VirGLhlh/ECsbvLUCoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmOSL/OD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B79C2BBFC;
	Tue, 11 Jun 2024 02:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718072862;
	bh=z0m4g9iEfrsewDnHZgo6tDRz36et0pyWtVOWMqsxKXg=;
	h=From:To:Cc:Subject:Date:From;
	b=BmOSL/ODdx/BcIxzjmRmsGiIxu5rCR46AEltz1riHLJ4e0+wjYOMgKmK8m2QIR0bd
	 7r9cbU3giSZUs4T4hVCFsJ743E6vwNU0GcJS2FzQGaJGx7cMFZ+o/0QGoLzx7SqOj8
	 pNja9i10/RIGvTHwylJY0RjlSMcV42K6p2f0Amj4kyOurxQ26oJt4J+WdKlo4LD7BJ
	 iBXurU4ZzyGxKjqM89n8D0mi0cZyYfEpT5gRADxNzS9DckNW3xV9wuSrklHJfnDEhS
	 L11yZK30Iro+2MlDPOUCwhXnyD+DM73gtswyy9A89QBHHEz+RPHuIhPn9pHw4flIRC
	 qWdqU+j5rcaUw==
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
Subject: [PATCH bpf-next v2 0/2] Enable INET_XFRM_TUNNEL in config
Date: Tue, 11 Jun 2024 10:27:26 +0800
Message-ID: <cover.1718072698.git.tanggeliang@kylinos.cn>
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
 - resend patch 1.
 - another fix for test_tunnel.

Geliang Tang (2):
  selftests/bpf: Enable INET_XFRM_TUNNEL in config
  selftests/bpf: Close netns in error paths in test_tunnel

 tools/testing/selftests/bpf/config            |  4 +++
 .../selftests/bpf/prog_tests/test_tunnel.c    | 27 +++++++++++++------
 2 files changed, 23 insertions(+), 8 deletions(-)

-- 
2.43.0


