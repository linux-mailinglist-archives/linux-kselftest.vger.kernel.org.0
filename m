Return-Path: <linux-kselftest+bounces-10610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7B38CCC82
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 08:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBCB4283406
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 06:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4F313C901;
	Thu, 23 May 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HblURiMY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B2413C8F2;
	Thu, 23 May 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716447063; cv=none; b=D5X4JS2ubqI3jk/MmRlOFSMJNLWPw+ChM11MWEmaUAwHRB/52Eb1+1BeRNSOWstVMNxvQXiYjo809UtP1Q474TDwOLG9zTbi2y+ltHshsMK5vw0X5eU+IUTnvzZas4J01eQA4Dtcqr0L5vV35o50g4/9CerRVSR4IeYt5Y9kn0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716447063; c=relaxed/simple;
	bh=0LAI2gSq/78VUmPVnhaSZfCl2xOHD0Zb0z7FrKUwl4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VN7T3WwuxTZdjgrsaghRg+qJE0CxGljOFHzYkDrixPeYyBC7F/aqAYEzWw0KqFx4yIXAKDf+ffS3yoM1zgjEzN0yxaszWuVYM7Ek/E4HpZcp5ZB6RatL8TI+/AJLsmvXfQQozNOeTVdntE4JRjC1rPGRPbKS5QBRhWZtm7JIJJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HblURiMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41950C32782;
	Thu, 23 May 2024 06:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716447063;
	bh=0LAI2gSq/78VUmPVnhaSZfCl2xOHD0Zb0z7FrKUwl4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HblURiMYwX88M9GZxVJ+LeazU0EFypTaWEIovopa7SuowVhSo0Ak44JVvQ9FbQxic
	 RHKVRCmubgmJQsPCpIybr7ytKeURTIRcW82Lq0WH2h2oSdTlcP6SkV4ZCppfrxN8I9
	 6tJpziAXMy11ynj6nxQI7vL3qqj8x7NaPT9F2AyODbbChWqGkPOxjgxIr8zKOJSlv0
	 UqsgZNIdYmMHH7esMeHR3IjiYgyphxOyPA3XVV8t3vquIIoQH/OHLWeB1MscSIuXmG
	 kH4uUhNMQHoHiJPEnXHCENIieLnwdkp3NG9YGfbF/f497auG6KOQgFVwn0pUQDUWfb
	 gJ2PpXXckWP1w==
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
Subject: [PATCH bpf-next 7/8] selftests/bpf: Check length of recv in test_sockmap
Date: Thu, 23 May 2024 14:50:03 +0800
Message-ID: <5172563f7c7b2a2e953cef02e89fc34664a7b190.1716446893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716446893.git.tanggeliang@kylinos.cn>
References: <cover.1716446893.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The value of recv in msg_loop may be negative, like EWOULDBLOCK, so it's
necessary to check if it is positive before accumulating it to bytes_recvd.

Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/test_sockmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 3654babfac59..4c7cb206b31d 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -681,7 +681,8 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 				}
 			}
 
-			s->bytes_recvd += recv;
+			if (recv > 0)
+				s->bytes_recvd += recv;
 
 			if (opt->check_recved_len && s->bytes_recvd > total_bytes) {
 				errno = EMSGSIZE;
-- 
2.43.0


