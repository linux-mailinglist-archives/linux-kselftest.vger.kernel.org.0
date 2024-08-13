Return-Path: <linux-kselftest+bounces-15192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFB894FD80
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 08:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D9CB22EA5
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 06:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98E72E644;
	Tue, 13 Aug 2024 06:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzChrwou"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303151BF53;
	Tue, 13 Aug 2024 06:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723528857; cv=none; b=K9uhbt01/5ef203Hu5h0b/J7V5C8YrUT72/jnWDo+1U1LzpU86XsVFPQiH+EDi1WxJDdJDMEALVtSRZzdgEsCvMV/rgjqIcdtnHtNdDpgG2bQj8I9jTjf/27AavhAq7D8Fev+4GMIMlHCkhxtcLzdNQBoJG4Bx8R0w2AvQr6MQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723528857; c=relaxed/simple;
	bh=eoz8SypQVeUi7S44huxs+5Uqa8k0/GfMVkclaeuBME4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tcFszQyvhBVW4VEqgq+vvxSntrb1hsdnOqENxHrlNbkpAIkABHZwQlfxD56MLbLNq+ZH3fGSIOo9BSkySZlei1yNS4ym+4Pk67zM5v4neLCgZnzx8XjNM/Fmvqz++sLO7jquVJctEZIjmxzfaHw6u7+Do78yRn3rPIzfg5YgwkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzChrwou; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4f6b8b7d85bso1749792e0c.1;
        Mon, 12 Aug 2024 23:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723528855; x=1724133655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y2QcXZLiSHSC9Xh+N1wM5xwm7PSlXvs0f4mmP999nFg=;
        b=UzChrwou2imwo7J563uCrqggrfOkuGjgaZDR0IkNmMIU0b9SehFRdybjJj7ynEdTRK
         KZjp7BxjJiVAKnimZf7mbA/4yEzEekHz9q+sAE8P1Sy4EsEHo2j4NaFzCS1H+jX7kIDR
         c+8fB/rcg32ExDeNhrvpaLcZhrEf0A+wXLMhFUhL+b68CGTKENUqLSYGaptgf5ZR48RS
         J/zuqQEipExAtuSjVaz/LYNVhOER2RWkIIq7B8/DVLhClL9ofb50r8CgLKvZWvG1YuWp
         /BiU4kG2oOAKiwPrsJNx4+ZOe2QO0A6396veg5NjgLu7TrKukLhTdrM14hVIEKn3hPsr
         m2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723528855; x=1724133655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2QcXZLiSHSC9Xh+N1wM5xwm7PSlXvs0f4mmP999nFg=;
        b=nRfFpY6WvQ4pUsqFQ9DTgCE5ld3Bzv+TYiiP49j5a22dg26ZJ7OJZjIg8BnezcZYlF
         ScHFE7y8dEo6fWQ+PZ2rYWXlxfnCvUZ1I1Fxc30M/DFvVbgSrz6BCawWkQP+lQ3f2VGV
         Vt8VHz0yv/Pkc8up/HLhwKkUI0L4q49S4QNh9SQ41B7K00JapyFSY8BazrRInmNpbROq
         mi2F4pJagk1FIHwPJAg5kzti+QaxYuGYp1ZUYbAaJcQJNLkby0YDY73qIgzvLGTUx+wH
         lq/68n4zNrect8lmDDFvGS3SdZxwumNtGW7m1h6X65wepAyVFJlM9wzqdQqC6kCeLeWC
         xQCw==
X-Forwarded-Encrypted: i=1; AJvYcCXAcV/eaU2gaV3maArvZ/l+jNs6v2VfSRRLnhh3hOGHyyFQ7zOtudeyvoi/ILG/2pNTCeyyG3DWePSTNp9+gM38jzPzl90QUrLTwikRUDHeqpFQmdzYP4wPxav7ELCd+tlM4JVmHmTen6HacSoKWqRjj5qsC9d/iBtaFs5HgbaS6lwTzaYW
X-Gm-Message-State: AOJu0Yw0s1vcVsk2gOfbcSLKbOsF7P/6v4pdaKnVK73262ocrhn84s/O
	uCAILVQBZT/hmI7wzBNqIEhn23JWs+FBUZ7IOTIIcvlQZj+hZmki
X-Google-Smtp-Source: AGHT+IEj+VoLjm5/vLvrxYFGVDuef8pX7BrNKsLxM7K2tmngP8ETL3B04OJJnLrqKd81Zf/cwm0ISw==
X-Received: by 2002:a05:6122:312a:b0:4ed:185:258c with SMTP id 71dfb90a1353d-4fabeec0d21mr3337865e0c.2.1723528854832;
        Mon, 12 Aug 2024 23:00:54 -0700 (PDT)
Received: from localhost (57-135-107-183.static4.bluestreamfiber.net. [57.135.107.183])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f91f1192fasm867098e0c.0.2024.08.12.23.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 23:00:54 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	kuniyu@amazon.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: javier.carrasco.cruz@gmail.com,
	David Hunter <david.hunter.linux@gmail.com>
Subject: [PATCH] Kselftest: msg_oob.c: Fix warning for Incorrect Specifier
Date: Tue, 13 Aug 2024 01:59:57 -0400
Message-ID: <20240813060036.754213-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Change specifier to %p to correctly substitute type 'const void *'. A
specifer involved with a macro is causing a misleading warning to occur:

In file included from msg_oob.c:14:
msg_oob.c: In function ‘__recvpair’:
../../kselftest_harness.h:106:40: warning: format ‘%s’ expects 
	argument of type ‘char *’, but argument 6 has type 
	‘const void *’ [-Wformat=]
  106 |                 fprintf(TH_LOG_STREAM, "# %s:%d:%s:" fmt "\n", \
      |                                        ^~~~~~~~~~~~~
../../kselftest_harness.h:101:17: note: in expansion of macro ‘__TH_LOG’
  101 |                 __TH_LOG(fmt, ##__VA_ARGS__); \
      |                 ^~~~~~~~
msg_oob.c:235:17: note: in expansion of macro ‘TH_LOG’
  235 |                 TH_LOG("Expected:%s", expected_errno ? 
			strerror(expected_errno) : expected_buf);
      |                 ^~~~~~

A second set of these three warnings occur later for the incorrect
specifier at msg_oob.c:256. By tracing the various macros involved, the
correct specifier (in msg_oob.c) can be spotted and changed.

Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
---
 tools/testing/selftests/net/af_unix/msg_oob.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index 16d0c172eaeb..87090ebda2a7 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -232,7 +232,7 @@ static void __recvpair(struct __test_metadata *_metadata,
 
 	if (ret[0] != expected_len || recv_errno[0] != expected_errno) {
 		TH_LOG("AF_UNIX :%s", ret[0] < 0 ? strerror(recv_errno[0]) : recv_buf[0]);
-		TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
+		TH_LOG("Expected:%p", expected_errno ? strerror(expected_errno) : expected_buf);
 
 		ASSERT_EQ(ret[0], expected_len);
 		ASSERT_EQ(recv_errno[0], expected_errno);
@@ -256,7 +256,7 @@ static void __recvpair(struct __test_metadata *_metadata,
 		cmp = strncmp(expected_buf, recv_buf[0], expected_len);
 		if (cmp) {
 			TH_LOG("AF_UNIX :%s", ret[0] < 0 ? strerror(recv_errno[0]) : recv_buf[0]);
-			TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
+			TH_LOG("Expected:%p", expected_errno ? strerror(expected_errno) : expected_buf);
 
 			ASSERT_EQ(cmp, 0);
 		}
-- 
2.43.0


