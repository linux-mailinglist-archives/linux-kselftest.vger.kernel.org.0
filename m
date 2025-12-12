Return-Path: <linux-kselftest+bounces-47471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 813DECB7C11
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 04:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED9F8301FA40
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 03:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772022F8BC8;
	Fri, 12 Dec 2025 03:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ZIYujaWg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60852C1598;
	Fri, 12 Dec 2025 03:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509918; cv=none; b=d+iyI8hWN89Dn+vn25mc1ba7D2WbXeTv+se+tKpu0KmcTBy+ibp2QBM10sMSHfgg+q4mW5mYoETflTuKcprP5rQmSs54ERDJb2BhbqQxDLVrdylFqOt8RrZ9P5cJhmL3z1YhB4oVo2pZ5m7ufVolarXcIGcwTbL7szC/mYfZ+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509918; c=relaxed/simple;
	bh=C+08LbzQ/z+34cND2oLqaoWybgghg1e04b/dmySNlAk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=WoeERImTEG5MLsRMiRGAJiQcpacf3K0hYhSYhQd9iuyeRQRwl4maUVyBD6V97h6RyEegZuw2xEQtGvLUQBhvs78ZrBPLS42kwki7sFPoB0JGAosFhGTh8JswpZVAXPvITIhZLYU56WnwaxHIs0p62/pi0HxnFbLHck6ArwPjkAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ZIYujaWg; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1765509900;
	bh=v2V53COHy+vq93ovfqBudNjOizsywx7dvc+nT1DYRpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZIYujaWgQmn/LpUwwUyH0cJVvu1IJsctI4EqImwaaWJcVhYQqtK2dSsZKgcZDQ8hR
	 /1a9+7HIMAi+GI7igompagc6jJ3ITuIhixXf0Mg4XF283z6m06k4Q8P/mx+17CDAt4
	 ThW+IWGTqbMlfPuWpnQUfvnWSLYGMSuQsdXBECBE=
Received: from meizu-Precision-3660.meizu.com ([112.91.84.72])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 639364B8; Fri, 12 Dec 2025 11:24:57 +0800
X-QQ-mid: xmsmtpt1765509897t464m1gzz
Message-ID: <tencent_1C17775758511477F4F8A8ABDCB9461EC306@qq.com>
X-QQ-XMAILINFO: NEu9ADsh1Y9sOKFMIuv4j33dDDqP7g9GHHq8WERml/ySRXobvwTnRraj8ncXgN
	 sZ9M0WcLuRb5Eethok/SQp82bz0Z9IewjhhJuXAJCVr+k0S1cPf2pPEITNePBLWjXQciuayUV4CA
	 c0XAsmpGicpRTkhWgkhoj8NkUBhim7fQp0z3VZL9xCXqJzMJNuYjQZGRvgW6IQ3wSVahPZ9dmv8/
	 reDTiOFUyGGKD996Wty+ltxw5AU8CGpBcywKMVBQ01Ck3t7IcfiU38hMkyOwbIx09pgibmPeaj6h
	 avA2E5E8KnuRZvng+E0ehulaab8GnjIGN/53IEU51l5Dw8Oqkb5jIIW3cHCRnEoQL0sBGWMSg6c6
	 EBt+eD+u8du2526OXg43jnCHHFKsVQw43Tqx+TKVrVayJHSyyfwXpoSfaGZCIf4q8QToVnpHc3zM
	 ObI5dnum40jC0M9rOPCzt9KF5baKQNdMAlKDEIjuXznMxcV1foZDPgOpgF45a1u9vglHfQReNjfc
	 8uqex6liy/poMALMFt6BapL+iBa2gWb/jOECQhrnsb4vIBJXFaa1LtOlA6McWdcjDcQ5FZMECppU
	 pIVVl4Q2mnndxi74upHzvqpTs1djjUkB4fPRCODDsn6RRKAYUjr/dLY5IJcM8tHDjo4332yfHnaz
	 BjNHURiqVFVrylT3YCgFZQnbORqDubgTrJE6rIyML1h8Eit+IzBWaqP0vFGO7LxU2oVO4bldGzjB
	 TWB0WU3Aq+ZBxPq/GQtlxYlQhO3Qo7lxzb3psInEOKj8hkRKRx2n/dFTRcjWn7BKQK03uhs+A2Lr
	 zHBGgkQiUb38Uqua2nln6yAKgQYFxvbGmphXY+5eAVyYyM3UO8Y6y26gsdg6+Qc0vA+j4JIYr24X
	 SJ0V/kGfQ+cjeRgkx0yxKtk4mZpr6t/wRkCLPcAbKQcgxqfncvtevhiQKOEf54CRgM0KV5Fen/7S
	 YUq73+R1v0jiAYt0YymsAfVNVB4DzYF9nYH1AxroCq0xhcGx3PfAoUJtuGLQF5A0U/ILXsb1Iuh/
	 xB3tl64DNOEM3ByzMmnMr3uIMiwyD3eqpqAIVxTy07Y74oP1DYnh1YZbDPOxTFpqpLWcm0RJpsKv
	 J1dtNL8qnyo93d8vtJS7xXE4C86RMCIG8Tpgs15uGo4mL1cOq8ejKKhyShlOoEkYHzfADs
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: ywen.chen@foxmail.com
Cc: andrealmeid@igalia.com,
	bigeasy@linutronix.de,
	colin.i.king@gmail.com,
	dave@stgolabs.net,
	dvhart@infradead.org,
	justinstitt@google.com,
	kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	luto@mit.edu,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	shuah@kernel.org,
	tglx@linutronix.de,
	usama.anjum@collabora.com
Subject: [PATCH v2 2/5] selftests/futex: use pthread_join to reclaim thread resources
Date: Fri, 12 Dec 2025 11:24:56 +0800
X-OQ-MSGID: <20251212032456.1842402-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_E8629E1FE67D7F457479179170238F07B90A@qq.com>
References: <tencent_E8629E1FE67D7F457479179170238F07B90A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating a thread using pthread_create, you should use
pthread_join to free its resources.

Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
---
 tools/testing/selftests/futex/functional/futex_requeue.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue.c b/tools/testing/selftests/futex/functional/futex_requeue.c
index 1807465de2144..7a22458c7fc96 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue.c
@@ -62,6 +62,8 @@ TEST(requeue_single)
 	} else {
 		ksft_test_result_pass("futex_requeue simple succeeds\n");
 	}
+
+	pthread_join(waiter, NULL);
 }
 
 TEST(requeue_multiple)
@@ -101,6 +103,9 @@ TEST(requeue_multiple)
 	} else {
 		ksft_test_result_pass("futex_requeue many succeeds\n");
 	}
+
+	for (i = 0; i < 10; i++)
+		pthread_join(waiter[i], NULL);
 }
 
 TEST_HARNESS_MAIN
-- 
2.34.1


