Return-Path: <linux-kselftest+bounces-27129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFB8A3EB72
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 04:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71BA27A8E79
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 03:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA701F4182;
	Fri, 21 Feb 2025 03:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qVzS1xo2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E48D1CAA8F;
	Fri, 21 Feb 2025 03:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740109022; cv=none; b=tm4yPVIcAt8rovbN/C/nxmkeA7MFe07pfWBsXaIFYDAPgRvCM2srE/iTV/E3N7TaJxOtBn+SfZ45+dJz9LDBvTzhdnG9DTO05za9OCOo3nyY7FANqSYyZ+kXWeCqMMZq9WNtlX9AWv9rH3zHV24aVVzjWLxk7beWuT19s+iEYRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740109022; c=relaxed/simple;
	bh=aPmIO52MuMK8kpfGsJu2MKpZSkIOKSnxIKud0xEljbU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=C2U2qOmM4fSny5aa5t393UT5PaZUN80fM4KB7RHEkVHWHfKvF8X/2Uxr4wcgicEd1xZ49g+dCgaM2ZuWzD7RBTSxgnN9Hrs11QgRGygvmVB2s+uN4aSQLb7Wmw28E6b0ATsEgo38Eon2lVIfWlDaqs3Z73/tgQzP2rBDFPPEVzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qVzS1xo2; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=V6IIFUk1yCKblo5rvsLc152QfuMUOxVNWCE982Ddwtc=;
	b=qVzS1xo2857k3KSGaC30t1bwEW8HX4BT+qAS6J4EclURkdha/papRipMbUus3E
	iMO+uyjC7P8JdDVRrwW9xCfQ1pYQPOUmXEyfqt5B6HtFdeYAtp5fxctHI7oLvouD
	c4pGPIX+pWIiFvoGyQeVdfLDbGPo/dhzdFs10q/M0PMy4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDn3qjJ9LdngIuVNg--.16295S2;
	Fri, 21 Feb 2025 11:36:42 +0800 (CST)
From: realxxyq@163.com
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yiqian Xun <xunyiqian@kylinos.cn>
Subject: [PATCH v1] selftests/user_events: Fix failures caused by test code
Date: Fri, 21 Feb 2025 11:35:55 +0800
Message-Id: <20250221033555.326716-1-realxxyq@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn3qjJ9LdngIuVNg--.16295S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr1UGw4UWry8Ww1Duw45Wrg_yoW3uFXEvr
	4xKrykAFs8AFn8Xr1qkw15KrWrCw4UCF4UCrW3tFy3GryUZF45GFZrZr10vF18WFZ3G34a
	van0yr4agr129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8OVy3UUUUU==
X-CM-SenderInfo: huhdz5x01tqiywtou0bp/1tbiXx76O2e37x2CqgAAsK

From: Yiqian Xun <xunyiqian@kylinos.cn>

In parse_abi function,the dyn_test fails because the
enable_file isn’t closed after successfully registering an event.
By adding wait_for_delete(), the dyn_test now passes as expected.

Signed-off-by: Yiqian Xun <xunyiqian@kylinos.cn>
---
 tools/testing/selftests/user_events/dyn_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/testing/selftests/user_events/dyn_test.c
index bdf9ab127488..54c9412f8dee 100644
--- a/tools/testing/selftests/user_events/dyn_test.c
+++ b/tools/testing/selftests/user_events/dyn_test.c
@@ -127,6 +127,8 @@ static int parse_abi(int *check, const char *value)
 
 	close(fd);
 
+	wait_for_delete();
+
 	return ret;
 }
 
-- 
2.25.1


