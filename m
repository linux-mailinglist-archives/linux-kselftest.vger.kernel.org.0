Return-Path: <linux-kselftest+bounces-47397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEC8CB520D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 09:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AFA4300EDDF
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 08:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985B42D47EE;
	Thu, 11 Dec 2025 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="cn8W+jaW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005AB26981E
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442318; cv=none; b=JkF+QB9axWUzKmcM1ORBCgCduf1ZDN25rQenZz5BiZ6uH5yPkzmtV7vHg/TCCM0YkBqJSGLmZaPY68RZo5VmXG/qlYgtYdNaTuVearo6dNqwTk1PtTYR3qu9NBa35JlMpqo73bl2FudlSe44SZmrgGOPo2xH6BWnRZiYI5qtzA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442318; c=relaxed/simple;
	bh=C+08LbzQ/z+34cND2oLqaoWybgghg1e04b/dmySNlAk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NTcwQ1ajrtrVcWafQubn1pIlpu6XRrcJczlrnUhVLpaWoUiS5Y/eCNvoEbKZ43AEoQkI4aXcBo9hnMm0AGLlVRQHssoP1Wj3eZTNxryEcqylsg/9is/GEKy5vSW3ZgxHYRtZFSnk6iuqRxrShnzG0G2eJTukimVm29md7UeFQEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=cn8W+jaW; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1765442313;
	bh=v2V53COHy+vq93ovfqBudNjOizsywx7dvc+nT1DYRpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cn8W+jaWaxhV5QlBstqNPQHZGfGgLFhEp/B84OVMURmMgaczFb0iA0nEBFEtFpro2
	 09iViF/JBbG4HjlGf3yY3IMshAtPuIj3PByC2XsoO2amn6pLL+/6yeqOfOzf3wsEd8
	 8SevHzZAIoH4DCM7YnxCeunM/ErLgkVaMUSOaJhk=
Received: from meizu-Precision-3660.meizu.com ([112.91.84.72])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 99C86CEE; Thu, 11 Dec 2025 16:38:28 +0800
X-QQ-mid: xmsmtpt1765442308tvdlxcn0s
Message-ID: <tencent_F375DCC595ED7C340FEE8BAE4BA2E88BFB05@qq.com>
X-QQ-XMAILINFO: NvlvDx7g+Np58u07Ay5Ip8QUxx3K07bUObagjxfVQ4igcs3gCUY117pX+PPyYR
	 EL+g1O/mYFxDNYn5Pvb+msMHCg14rurWqXi0I0Xf0AxAPO+gxhxZXX8ED+nKDOBITtG/3uMVDxVK
	 MeFO2giSdhT46m3TkUA0rh6ZkSYVf7SlMdgfpfCLN66MCHlrK2lPGeAzlv4gJTwBW6I9YewNXGo5
	 SZPxF148k+7hkNQhBOF6PCdJGAUw4IOjLQcWKEdFqcfysnnayXI3S/Vb5WsxKEUfNtZ7xIfZlNW6
	 SOSXxdOLN5ao2REQw16SSG/7ENlCP6lSx+8oDIrQ+s3aIF6EeCDgkUzTIQsTZzPSSUL7MebXTy9v
	 XLV84O0wkxXKZTX0IHMGQiZFWO/JuQNphTq69vQeXOL7E2HaY+EmmWCRHS5z+3p69pBOhMu8sTxw
	 uilNoJnNPh2HTtoV4P++gZrQ7NcJ5JHZxHHXYVTUSrejT3EvZkJfw6SSwWq5STst9ps0zjEX4uNP
	 04kmFXhK3sSpjeYAI26TfVwkeATMKnOZYF9JK0dM3K1ZU3uUPbOdGSSh8lkclVnToJL/dgTFR83K
	 qoLJWEAkByYS9+C+IYwi3xWd4BTkePm3zoJ6xS156jycrE30H/mFNT6Xk1vquaEE3n2AunEVT2od
	 lwwYhkal3BnU5gW1GTogqVkOaR57fSelmd4zvNkc/PaDEJIrFcpG6A2zAUYZcVVgpq9bC+9m0FBA
	 EHUXJhlNKL2wBpn9AH+QCW0Hiuvq/BYRO18nhhL1kCiDq1OBclS+qtjctQJmeDLZQphtg3jdzizl
	 HTmZPi3xnjTkQzUZKt4JwkNolJI7Ni+meCQkxnI0HBgHv3xtUk1KgLgcitYC9Xz5LeWotRHCMzRr
	 OhugKtsRmYgAzfjdK5qOmrkQOur1tEf4ougffdXLnAYULZHSrAF38kbiPOeGE1LkUqCqyUBvCyx/
	 MxiAjhWccg0l/KMQBXBzG8hUS7a3G6cwuAMQOFjtuQu4MoSNzHsdyDbMR3TFf5zt60Awvbce3aY9
	 +BOCjRIVKiOmMWi6InXGRKXf+T/Pnx2GD5Xiaii/bSfZ8F+hzTS0KuVVO+UsboJDVjLeaogUMJ3V
	 0cZ/Fx3KMLJM95fijLZ4a8Fh612bWLxIBgSreNXENH7VAIF9cHX963YCESoit5/dXN8PSH
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: ywen.chen@foxmail.com
Cc: akpm@linux-foundation.org,
	andrealmeid@igalia.com,
	dave@stgolabs.net,
	dbueso@suse.de,
	dvhart@infradead.org,
	edliaw@google.com,
	hpa@linux.intel.com,
	justinstitt@google.com,
	kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	luto@mit.edu,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	shuah@kernel.org,
	tglx@linutronix.de,
	usama.anjum@collabora.com
Subject: [PATCH 2/3] selftests/futex: use pthread_join to reclaim thread resources
Date: Thu, 11 Dec 2025 16:38:27 +0800
X-OQ-MSGID: <20251211083827.1795879-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_3739CFB7F300BEAEBB928A0EB8D1C6875C09@qq.com>
References: <tencent_3739CFB7F300BEAEBB928A0EB8D1C6875C09@qq.com>
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


