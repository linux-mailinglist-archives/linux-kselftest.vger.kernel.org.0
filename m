Return-Path: <linux-kselftest+bounces-10603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101CF8CCC74
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 08:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19F91F21845
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 06:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623A513C832;
	Thu, 23 May 2024 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBOMAU9D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EC413BC0B;
	Thu, 23 May 2024 06:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716447021; cv=none; b=KJW5QyyU5xWFh7ZeEFp1jQwJe1rgs2A3vniJQwL4Qvlt7RCdVJjE+3VyZeFh6j7bhU+xn+MvqZ5IiQx3AbrCQpCdHWvbASJT7Groe1accm6rRGyrhJz2c1rRMUax2MyFKUxaimnL6eUbOigkXGEjmlV49Q6grwhKjUHV/0Odi7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716447021; c=relaxed/simple;
	bh=QpVEYZWT6MjWy9a74eltpfFBlmBPT9ahhBEfVpJ1hK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C8m/R9Ikl32Mh+T/Qu0ioy1k1arJwNbtfaKe/Zu5hWhXrPPS3NeTE4kkVGLJqi2iPtj1+G6Pa/SG7aCI4XkstbmhjYkQpTYwIWdNYsE6s7u/CNqlOfXtYOXzTUFvappJKwpa0NEFYySvPygrZlFL3MR2uW7Yr07PVRlN15/2Bzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBOMAU9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582D4C2BD10;
	Thu, 23 May 2024 06:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716447020;
	bh=QpVEYZWT6MjWy9a74eltpfFBlmBPT9ahhBEfVpJ1hK8=;
	h=From:To:Cc:Subject:Date:From;
	b=DBOMAU9D7cAlAHhf2K3v7Z7pB9EJmHbMDRJ+3hF/qxRGbXBanI1fHOEDgfhClkeax
	 NuXiAgBFqYmkbkcSdUREEeeWoMZK7qtGtgM02o+AsO2m0oJmsHwCDZUHi7MBJ5WTY1
	 OxCg7WpThIUFbw2iBPZHeMJwgUPxm0tQDxdIz6JqN91JbqvKyhfzsX655jIPJE18+S
	 EyT1qlHhchOqJGe6OnRttnA3TBiMZErviJ96zLyswHfeF2E6g7oud3cmrWIxWDxFfN
	 KdSy/r1uRqo3bvyc/6Myu5wTzPQEruS8E3jf/cs7PV6GAdG4ua3D752CtetfZBbgMu
	 9WhRhg24NmDUg==
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
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 0/8] fixes for test_sockmap
Date: Thu, 23 May 2024 14:49:56 +0800
Message-ID: <cover.1716446893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patchset contains some fixes and improvements for test_sockmap.

3-5: switching attachments to bpf_link as Jakub suggested in [1].
1-2, 6-8: Small fixes.

[1]
https://lore.kernel.org/bpf/87zfsiw3a3.fsf@cloudflare.com/

Geliang Tang (8):
  selftests/bpf: Fix tx_prog_fd values in test_sockmap
  selftests/bpf: Drop duplicate definition of i in test_sockmap
  selftests/bpf: Use bpf_link attachments in test_sockmap
  selftests/bpf: Replace tx_prog_fd with tx_prog in test_sockmap
  selftests/bpf: Drop prog_fd array in test_sockmap
  selftests/bpf: Fix size of map_fd in test_sockmap
  selftests/bpf: Check length of recv in test_sockmap
  selftests/bpf: Drop duplicate bpf_map_lookup_elem in test_sockmap

 .../selftests/bpf/progs/test_sockmap_kern.h   |   3 -
 tools/testing/selftests/bpf/test_sockmap.c    | 101 +++++++++---------
 2 files changed, 51 insertions(+), 53 deletions(-)

-- 
2.43.0


