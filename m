Return-Path: <linux-kselftest+bounces-22499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8389D83D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 11:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4546628A086
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 10:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0386194AC7;
	Mon, 25 Nov 2024 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="gtFtymY9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35397192B90;
	Mon, 25 Nov 2024 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531967; cv=none; b=YS6o3cnJqhi/fFFIvYZfYxniTvdqnPtU7KJD0Ty6qAnslaSHs/wA2DOfH/8FGGW35Xw42dHWhkhj2lB640dS6rHeq4c7ox6jfEBql7X9cUeJZQda5tqKNP94QlwpdAZIinsGZswzshoMInoAD0MyCKvZXrj5zaVxhWCMynYRswo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531967; c=relaxed/simple;
	bh=JpGjeBjmwwj4tAr/NvIpAh2+TZXeSq9SG3rXs+foLRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cbCi9nul2IlmKLRC1ukyMc5dzfKPBqXDsAHVJRv9wkhfSvjU6OjgPu43EHdodYyb9hlT3yFiLD1LEtJaF2kgCZcZRYC6/w7PUPRu7vtYdsr/+/tzX9A2aLygKGqi1axCssy37xqCk0XgRyEy2sVHBEMTelba/qwQ4sihEEaMKSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=gtFtymY9; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531964;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Bk64MtqGkER1ZMPO0RH9GpVeWujqZYsCThNqF69MyRo=;
	b=gtFtymY9JwUJFkpAL/kSf+Ma/1ghajXUrJ5yxsHGl8kT4QAt4TJkESBUOH573AEerDUtFC
	z5/OInOsdB3Z8GCO+0hzJyWNRIYFq9K58bJ+D4bscwCdlyseZbzE6dpsXE3kbikgzBKKu1
	JNwAgUyM1T1RyphrFdbh3rcY0SSBCMhcEY9GYTrHaJCtsPmjnDPGai7tZWw4X6DdXGUfgz
	TWRDkp82HzI37siSO+cOpuqPB9mCab6S2h+CNEBg+Ejc6DCuyStLVq5GA/e6s1m1ReXKim
	R0NyE/1qMexlD3AhdsLS3cI3GlEAzOSsMal/wFkhE8SoFKmNjPLXIt4j0SVkxQ==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] kunit: constify return of string literals
Date: Mon, 25 Nov 2024 11:52:39 +0100
Message-ID: <20241125105240.44219-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

The function kunit_status_to_ok_not_ok() returns string literals, thus
declare the return value as such.

Reported by clang:

    ./include/kunit/test.h:143:10: warning: returning 'const char[3]' from a function with result type 'char *' discards qualifiers [-Wincompatible-pointer-types-discards-qualifiers]
      143 |                 return "ok";
          |                        ^~~~
    ./include/kunit/test.h:145:10: warning: returning 'const char[7]' from a function with result type 'char *' discards qualifiers [-Wincompatible-pointer-types-discards-qualifiers]
      145 |                 return "not ok";
          |                        ^~~~~~~~
    ./include/kunit/test.h:147:9: warning: returning 'const char[8]' from a function with result type 'char *' discards qualifiers [-Wincompatible-pointer-types-discards-qualifiers]
      147 |         return "invalid";
          |                ^~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 include/kunit/test.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 34b71e42fb10..ae1b57578476 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -135,7 +135,7 @@ struct kunit_case {
 	struct string_stream *log;
 };
 
-static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
+static inline const char *kunit_status_to_ok_not_ok(enum kunit_status status)
 {
 	switch (status) {
 	case KUNIT_SKIPPED:
-- 
2.45.2


