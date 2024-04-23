Return-Path: <linux-kselftest+bounces-8681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1698AE21A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 12:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8931C217C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA09605CE;
	Tue, 23 Apr 2024 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHdoyO5Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45060381AD;
	Tue, 23 Apr 2024 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867987; cv=none; b=NkHNj7t1v13LyBjo7n5qFcoUuAjg7HqD1hbrjqZ0Fk0KvckXh4eDMvGc6lvjwKqckoT7X8UqjX8gm0Mu3H2bZPDFsuxLrbZdmLByJjzyrJM6OnlUL1qJ9jmaHHNUZCE3AxY4bUfePBt/htF8+d6fwefJFxyT0OsT5j6PSnsBddw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867987; c=relaxed/simple;
	bh=Hw5ZgZxMC5wtOxe928gEwmHK0lsrFZFv7I9w7oJC13Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tn1Ci6oJnTtI6CbB1VM3Nbdl8W+/AyV7Aa564ibsL34OoMkkvh8lcHPPfeKl7y7jnBgp63sFHplgsvcs8VHrJZkZD5HZyfpnkyfq+0RddQrwcdqtcBjT0acI6pEDgd34VjYaagGPpVZ8w7ayTt072WWyVUGhdNYfaAq0rZeILfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHdoyO5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A4BC2BD11;
	Tue, 23 Apr 2024 10:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713867986;
	bh=Hw5ZgZxMC5wtOxe928gEwmHK0lsrFZFv7I9w7oJC13Y=;
	h=From:To:Cc:Subject:Date:From;
	b=YHdoyO5QpqsjbFrJz4SddS+AZWU51X4lVdPxyWXjjZpRuKGJ8AgBjIBeasEjvgWHJ
	 vVLIMnwUh6Px4SgR69DQcPCfhL3WM3T1e8WJ+YN6imV54EZNF9UJahvRbQ+7eKgBar
	 4ooRUFW0vSXHLSXBSY8wTwhwhtYCsBZpdoYJx/an4GTdMp9TKDANjH3AN2Im4YGi0X
	 xu/2jdLlTx6pPRbJz+pzBduYadvgVhV5IsU/QjT+nIXI4N4oKHuqldIoGG2wPl7Ixw
	 4TXxic8aNlNsU94nzOt48X+PdgSjvF7Nqi+MKSazxaJxaqMTsjbv4trXd4D6lWjlj9
	 6rRBNPxxwcFeA==
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
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next v5 0/2] Add F_SETFL for fcntl in test_sockmap
Date: Tue, 23 Apr 2024 18:26:13 +0800
Message-Id: <cover.1713867615.git.tanggeliang@kylinos.cn>
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
 - add a new patch "Check recv lengths in test_sockmap" instead of using
   "continue" in msg_loop.

v4:
 - address Martin's comments for v3. (thanks.)
 - add Yonghong's "Acked-by" tags. (thanks.)
 - update subject-prefix from "bpf-next" to "bpf".

Patch 1, v3 of "selftests/bpf: Add F_SETFL for fcntl":
- detect nonblock flag automaticly, then test_sockmap can run in both
block and nonblock modes.
- use continue instead of again in v2.

Patch 2, fix for umount cgroup2 error.

Geliang Tang (2):
  selftests/bpf: Check recv lengths in test_sockmap
  selftests/bpf: Add F_SETFL for fcntl in test_sockmap

 tools/testing/selftests/bpf/test_sockmap.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

-- 
2.40.1


