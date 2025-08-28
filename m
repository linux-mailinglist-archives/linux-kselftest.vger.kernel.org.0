Return-Path: <linux-kselftest+bounces-40137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEE0B39207
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 04:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEBFD4656EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 02:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA29284889;
	Thu, 28 Aug 2025 02:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="M3eG66oK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6924227C158;
	Thu, 28 Aug 2025 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756349948; cv=none; b=oGCByzjjKpBsabYbFbWVtfKLHc/7ULVD+349u+9DKBrdFMf7KYEjpj+9ee2IKuT6dNrbXRN+iupe3mpJ3runkIJOEzfaW2j5gWnbKht2vIJjsKZUS5niRcbZ7t5EWVpJz+PLuqbEN+jb8cFh1USa6tDf3KBIFjldK/ZpLfrYYsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756349948; c=relaxed/simple;
	bh=c/lXw1sC5mJHaO8msACLWB4EsF+7z/nKMyb4PEdLM9k=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=mCbmYsL5xvheiChCf2NxnQsVHJQpg/p46sOP+ZGTnF47LUvWe37gf8IPBIZey48nkf9hEx5uZvWgxpF48zHMh0ZWOk1eri+u2RIFph7FmJ2wZF6YGTzOWOUJmjAfctGaM5XQloJtB1Gyr6CbMec8vK4DqiQ7Q1be8p5qmk0u7y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=M3eG66oK; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756349643;
	bh=LZVhn6BK7rxIqwcwVk6ASyAdIBsuUFL/q2EV3tE0yFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M3eG66oKxd5BZZ6I0RMK2O3h5lR41dbhYcYTLc9gP+93jXjllRzVAg7ipna7sQzX/
	 cGsiqms9LMwA8a9Nm397RyZxxNbZspk+3yadBLyyPxK2eFMSYwZiDsE/WrMard5wSm
	 p2MmHJ3J/kQ+++/yClfhuiWAaryfnecq9zqHiYvA=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id D79210B2; Thu, 28 Aug 2025 10:53:57 +0800
X-QQ-mid: xmsmtpt1756349637t0nyoi3x6
Message-ID: <tencent_952D95A0D7B8D15C4434831621A2ACCACB07@qq.com>
X-QQ-XMAILINFO: OeJ9zRfntlNPiKb5kbzoPQTX2LTvjSLhVNZLoM5G9/5+eucXXvBSbue5Pb2uzp
	 8z8/QMag0I/SCKxCy28f9bwUul3wpbxsAYG4bUKBtRcqZYLEHDn4I7DnF09VYPZixmVcKTtDDqlf
	 XzwX2+L6untt3rcWPIz1gqRYqC2qUbdLoa/JcrG+SRKNJkmboAXTwDl7pMkrFAie1IlkRgnNA8sN
	 PNkq85b2K8gz0YD0S51LBIDR8DZLgmHnX/Ztgzt8qdBIuMv/GHDRfBmsbWanV3+duWLoL+MKM35v
	 PCJ8u0elsOSL6xm/AobsM/b/N+BmVzOZd6RAFdVZKBo78gwNpe87Ka70V/Mj3ELpd/rKkSqlcdNl
	 3a8eB46VeS7Q0c+6HLFW4jVsdKLuquJBhWsGcxSfGiwV7qLu/qG+8PPvtBpTBvlNHStFFXWYxrHS
	 0JoavfvpvHEF6HndDB5oQxFlWyLJMPzrfTKCvmThG+NPmauU2DIXcjpODsngM6Bg5rBwZY8b0Piz
	 Hv1z9bl/SsKbkVkLPYBAcWo5vURG9Vb0sS/VJ577YsyIRamwmqs7oK+CIuEIEVNPKWV91V1X9mY6
	 AWzYM9UKiAYUF5c7i+h17N41gchmNk0FAslziS8nt/Tz6p1/N7jmymsKYXr1rgldOh9kwK5psGyI
	 A8+XBbF5gPD6CrW9qaP3UygDTOX2Nn1wePWJ2KK2w3wGeHMNxGx7yPpW+l11mrnYQT5eVwXY6/1O
	 N4Zz8PHXI13z4QiWOLuycOxbri8Ipa3eGZD7DEmwVmOLd9ZkwFRp+/2b4d9zny+5ixTOJ3ZqtpnU
	 yvHLNBTupUZ2ScM4bmzUdgb0uiy4XaXq1YfAD+ITpV+uHpfmJooSrSXEpBLfMHW2brVuqQHK7EKa
	 7zm7AiBFOPKes29ZN4fGDp80s5NugYyelohBwoCos+2/ucZHTYPyDoKjCK8gKclV6pXkKfMmtBpr
	 jpXwIqeCcYDHFOh28JWGdmUaOa/9FNf65EW1Wd0hVwvh+xkhAvKgW8uCTMuPwQ+xJB30d0OVlkU6
	 RHTBw3eCfI8S+MpRgfNmX1AXPFLgWBCmopEyKy7DGvOTrR7TDUdxEcpcbOjTg=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Rong Tao <rtoax@foxmail.com>
To: andrii.nakryiko@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: rtoax@foxmail.com,
	Rong Tao <rongtao@cestc.cn>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Viktor Malik <vmalik@redhat.com>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [bpf-next v2 2/2] selftests/bpf: Add tests for bpf_strnstr
Date: Thu, 28 Aug 2025 10:53:41 +0800
X-OQ-MSGID: <b5965757c3d14276fec1ac96bace13f05d099e43.1756348926.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756348926.git.rongtao@cestc.cn>
References: <cover.1756348926.git.rongtao@cestc.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Add two tests for bpf_strnstr():

    bpf_strnstr("", "", 0) = 0
    bpf_strnstr("hello world", "hello", 5) = 0

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/bpf/progs/string_kfuncs_success.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
index 46697f381878..f8fe14787b2e 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
@@ -30,6 +30,8 @@ __test(2) int test_strcspn(void *ctx) { return bpf_strcspn(str, "lo"); }
 __test(6) int test_strstr_found(void *ctx) { return bpf_strstr(str, "world"); }
 __test(-ENOENT) int test_strstr_notfound(void *ctx) { return bpf_strstr(str, "hi"); }
 __test(0) int test_strstr_empty(void *ctx) { return bpf_strstr(str, ""); }
+__test(0) int test_strnstr_found(void *ctx) { return bpf_strnstr("", "", 0); }
+__test(0) int test_strnstr_found(void *ctx) { return bpf_strnstr(str, "hello", 5); }
 __test(0) int test_strnstr_found(void *ctx) { return bpf_strnstr(str, "hello", 6); }
 __test(-ENOENT) int test_strnstr_notfound(void *ctx) { return bpf_strnstr(str, "hi", 10); }
 __test(0) int test_strnstr_empty(void *ctx) { return bpf_strnstr(str, "", 1); }
-- 
2.51.0


