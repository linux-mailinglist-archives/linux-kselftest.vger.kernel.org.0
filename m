Return-Path: <linux-kselftest+bounces-9280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F8F8BA1E1
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 23:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6431F22960
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 21:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372A71BF6C8;
	Thu,  2 May 2024 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Uv4gdnJ3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20EB1836E8
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714684191; cv=none; b=Qkh7iOtjPr0k0up19X+ekMYMEt6xt3VWEXRjl/xx0KTaoxV60UFydHWseHvzhFRN2FnRhyfGffBlVV2NhNTMp32r3CGcwKIv2La1AHT4MX9YnzxvNPqKCJXxYMk/p79w4ejoLVnsjbd3Pnjv8mJW+emA+CSmRvn4qpiLbzc+cy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714684191; c=relaxed/simple;
	bh=az9zR1I5qxRjcteW1qetSFlOKHg+o9ve4pPybdRPw6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rM+omHaJ30XZylWoMAfaYaFz7V/yPdUVysRugAx6CyN2Tgo7sdcimeHIMavWrDiPKl4BPalw3kB8Q2Pk7ZXCmPiWBU/8OZxmsUkkDdye5Z55LhLsn+VDuG1NimQj5Wa4Z35fRHQQE5f2IvW2HmIEBdeNx/KOWfcYzxil63BnT4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Uv4gdnJ3; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VVmlv04ZPzNNf;
	Thu,  2 May 2024 23:09:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714684186;
	bh=az9zR1I5qxRjcteW1qetSFlOKHg+o9ve4pPybdRPw6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uv4gdnJ3WUerzih5lRzuwnJrsLP1Mpvv9mzgAnCrZl1Ej955qJtiKGyrfW2mL7+3Y
	 kTMXx0GOEMH2tUAUMnAB0dkdAs7q3v7Nd9KA9eCYUaIaj/M9m5NPynmRf8XeqrBoU/
	 kk6SdWZRE5fImjNgvFS3qSuOyPbHH3HyQHfyN87A=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VVmlt3Bw0zLNh;
	Thu,  2 May 2024 23:09:46 +0200 (CEST)
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
Subject: [PATCH v4 06/10] selftests/harness: Constify fixture variants
Date: Thu,  2 May 2024 23:09:22 +0200
Message-ID: <20240502210926.145539-7-mic@digikod.net>
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

FIXTURE_VARIANT_ADD() types are passed as const pointers to
FIXTURE_TEARDOWN().  Make that explicit by constifying the variants
declarations.

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Will Drewry <wad@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240502210926.145539-7-mic@digikod.net
---

Changes since v1:
* Extract change from a bigger patch (suggested by Kees).
---
 tools/testing/selftests/kselftest_harness.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 9d7178a71c2c..201040207c85 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -338,7 +338,7 @@ static inline pid_t clone3_vfork(void)
  * variant.
  */
 #define FIXTURE_VARIANT_ADD(fixture_name, variant_name) \
-	extern FIXTURE_VARIANT(fixture_name) \
+	extern const FIXTURE_VARIANT(fixture_name) \
 		_##fixture_name##_##variant_name##_variant; \
 	static struct __fixture_variant_metadata \
 		_##fixture_name##_##variant_name##_object = \
@@ -350,7 +350,7 @@ static inline pid_t clone3_vfork(void)
 		__register_fixture_variant(&_##fixture_name##_fixture_object, \
 			&_##fixture_name##_##variant_name##_object);	\
 	} \
-	FIXTURE_VARIANT(fixture_name) \
+	const FIXTURE_VARIANT(fixture_name) \
 		_##fixture_name##_##variant_name##_variant =
 
 /**
-- 
2.45.0


