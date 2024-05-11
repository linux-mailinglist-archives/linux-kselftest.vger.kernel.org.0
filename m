Return-Path: <linux-kselftest+bounces-10097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C3A8C3042
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 10:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7041F21AD6
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 08:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991434E1D5;
	Sat, 11 May 2024 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBZ3V/JB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEF8FBEA;
	Sat, 11 May 2024 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715417437; cv=none; b=EI84xr5kLGax7R2jBfjOMvS4U/RTOi6/3VFvNzSGYppvw9uHggFrX0p5rKlBWYCdH2qFctgG7iq4u2j0LCJJ7+p9kCve7OdAeYa4TALA0WRpvU3s8w1jkkDcX1yJq44qJKl98zrtdNbn3Frg6Fwe50h2DtFlsiVUdw/yj7Wa0YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715417437; c=relaxed/simple;
	bh=7OguetOiT+Z8CgMkKCjbz3+cqB8iRaQlGIKeWQiGTJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NlUQbkczrzfkFg6cUsHAwAJzR6fGB77RRRXA5xGVmyElDaT71swvAAh2jUledwftbh7Lv7jgPxSmBa5WYNt8MZ+h6iynVvs+qiUpY970cSZPxzuIP/yDc9Lmusd+rNm9aewpwL39jplMEYOtm/l+5GnePDtDNxNzC9Zkzu+Jkv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBZ3V/JB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046D4C2BBFC;
	Sat, 11 May 2024 08:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715417437;
	bh=7OguetOiT+Z8CgMkKCjbz3+cqB8iRaQlGIKeWQiGTJE=;
	h=From:To:Cc:Subject:Date:From;
	b=NBZ3V/JBhkVF/6v+gg2H5HtRT5KDIhy29myDTWvsPmBQKiho5bq/n0EfIfaT1Syg7
	 t1GjIHkh8vUnWXToIbHlqckn5UGDkNPXzh8Zjdri08T9a4ttDpCx+qNOwCj6xrYsNy
	 f007Lc/EIfKOlXvlLWdCDGY7PSgwtzrBheTEOljNyhpyOu3RV50P2cK+ZIWUlMpGlW
	 Pe7ut/bfEI+u1QURhUirR2CNA5EuW3KQcS9YfCrZpS/M3q1OqDVgFNnAr1wVjEuFGd
	 b1xQdq4HQLug52QiNaLG6Qtz6iJBklsDFtxR76wExR6IZ7xP+LTQv+edXL0UlOaqHZ
	 MwlcsDCSdFwNw==
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
Subject: [PATCH bpf-next] selftests/bpf: Free strdup memory in xdp_hw_metadata
Date: Sat, 11 May 2024 16:50:24 +0800
Message-ID: <af9bcccb96655e82de5ce2b4510b88c9c8ed5ed0.1715417367.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The strdup() function returns a pointer to a new string which is a
duplicate of the string "ifname". Memory for the new string is obtained
with malloc(), and need to be freed with free().

This patch adds this missing "free(saved_hwtstamp_ifname)" in cleanup()
to avoid a potential memory leak in xdp_hw_metadata.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 0859fe727da7..6f9956eed797 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -581,6 +581,8 @@ static void cleanup(void)
 
 	if (bpf_obj)
 		xdp_hw_metadata__destroy(bpf_obj);
+
+	free((void *)saved_hwtstamp_ifname);
 }
 
 static void handle_signal(int sig)
-- 
2.43.0


