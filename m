Return-Path: <linux-kselftest+bounces-9283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 907C78BA1ED
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 23:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFAD283D5A
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 21:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5454B1C68AF;
	Thu,  2 May 2024 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="me/zohhA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADF21C65E0;
	Thu,  2 May 2024 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714684199; cv=none; b=IJCH+ITFATLrIvcb52MQsNgrvuGwKX/ZHZHkk6SIP9q50QKNHPQ5iju/Glc6CUTQSoFnFwZZKV/OjfoYPWLeBZ6epijzZBu9IlViqdHyNfTBgBm72BMhY0BixeQ7pzRz5sKwnHLLP/38MVXsrsFO6QRh6FtveNLkkUSMlCji6Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714684199; c=relaxed/simple;
	bh=15Py21Y0wiTWxGYN8/FXrHgQsVA/abvkNE37zFQYec8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOpXglCatZ9QmTxoNih1M75lmv6RtgXoO7KS+84wU9SVHeG1SMZefFpvMG0Dy3dwmCObyQRz46ahHlMTbxIj83HKtm2pZ49+nZGKraWnFq0s0ZkIsXjfPTbPuDPV+Q9EF2qPgzxNMSBP/6i+NoB1KdjTCLwTS9qcpRdLlveKtAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=me/zohhA; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VVmlw6pyKzMV6;
	Thu,  2 May 2024 23:09:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714684188;
	bh=15Py21Y0wiTWxGYN8/FXrHgQsVA/abvkNE37zFQYec8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=me/zohhAObZfSouj8HYKxLVfoDGVy4fwktvPiW/nUVS9aJMw3G1n6T81dfmH8G5rw
	 FKzDsnhS5BUV50Lc7E/5JM75UTVhqHokaSNa9tVcmeTJK2lZ8qAmmY0XOBqiDpltn7
	 I2WlZqKMKOXOQVYWA05QSYyI+dSCmMx4vk7DXDNg=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VVmlw3F5rzqpc;
	Thu,  2 May 2024 23:09:48 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"David S . Miller" <davem@davemloft.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v4 08/10] selftests/harness: Share _metadata between forked processes
Date: Thu,  2 May 2024 23:09:24 +0200
Message-ID: <20240502210926.145539-9-mic@digikod.net>
In-Reply-To: <20240502210926.145539-1-mic@digikod.net>
References: <20240502210926.145539-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Unconditionally share _metadata between all forked processes, which
enables to actually catch errors which were previously ignored.

This is required for a following commit replacing vfork() with clone3()
and CLONE_VFORK (i.e. not sharing the full memory) .  It should also be
useful to share _metadata to extend expectations to test process's
forks.  For instance, this change identified a wrong expectation in
pidfd_setns_test.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Will Drewry <wad@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240502210926.145539-9-mic@digikod.net
---

Changes since v1:
* Extract change from a bigger patch (suggested by Kees).
---
 tools/testing/selftests/kselftest_harness.h | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 201040207c85..abf2ffd2094f 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -430,19 +430,17 @@ static inline pid_t clone3_vfork(void)
 			kill(getpid(), WTERMSIG(status)); \
 		__test_check_assert(_metadata); \
 	} \
-	static struct __test_metadata \
-		      _##fixture_name##_##test_name##_object = { \
-		.name = #test_name, \
-		.fn = &wrapper_##fixture_name##_##test_name, \
-		.fixture = &_##fixture_name##_fixture_object, \
-		.termsig = signal, \
-		.timeout = tmout, \
-		.teardown_parent = false, \
-	 }; \
 	static void __attribute__((constructor)) \
 			_register_##fixture_name##_##test_name(void) \
 	{ \
-		__register_test(&_##fixture_name##_##test_name##_object); \
+		struct __test_metadata *object = mmap(NULL, sizeof(*object), \
+			PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0); \
+		object->name = #test_name; \
+		object->fn = &wrapper_##fixture_name##_##test_name; \
+		object->fixture = &_##fixture_name##_fixture_object; \
+		object->termsig = signal; \
+		object->timeout = tmout; \
+		__register_test(object); \
 	} \
 	static void fixture_name##_##test_name( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
-- 
2.45.0


