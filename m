Return-Path: <linux-kselftest+bounces-15239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AC2950A22
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 18:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ECFB285A58
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 16:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CDE1A0B0E;
	Tue, 13 Aug 2024 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jy34e68H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E88C19AD90;
	Tue, 13 Aug 2024 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566547; cv=none; b=Rmz6p/4vYSIZlVWQRjpeZS86Qt/wnD4mO8Jlc2DszwcS+l+T03Cofo/MMoNQ5OyHlDy8DVI3TY3kyJSuLzuuPdbcalnmlRF8zqQakRHsumkfE78MFxPwJi2QiVuTl2XgR2uHO32zSkHQsLCT9icUMWaJfMnfz/LyMAbPEYG0tQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566547; c=relaxed/simple;
	bh=JGh9VB5dzq5Ts+lVa17EXNj6slFzF9LotVeHXIQDwPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bOqMHVUyOZty6pPPFA6w6ZfuZwO6KNndJUtZMEEIf5mErhlOp6Zi5qH/g/eptA7YxMvu+IrCXD2tJMyK7DhIMTm0ngd3blthX7T9UmkVEFDdVuEKOjRREDlFPcl9rKf1FelrvFQtFYnnTgXYpFdiwwIif+0aZ7yHJrWuz8TIzEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jy34e68H; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a611adso6691530a12.1;
        Tue, 13 Aug 2024 09:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723566544; x=1724171344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MsbiuRUlmo4RLNQnmGHI8pchnz0f5Sp6onkgIW0DlX4=;
        b=jy34e68HB7yvy6qkLBKIS1L3FGI2FjTL/vFLQ6dURmeTq22dp7gmp7+QtkxzSxaL/9
         qm39u4iE14WX5it0/PmNtr6M8CUScX++SuElRySrtgUt61bRWShHIxPmr/EdNEsIjpHr
         u4t1Cv2TaZMG7qB6v9nDsZlAc4yuFv+ATD5iOXsgJwPNkgks8OodkY63hkHVUi9bH4og
         zUfvQ5R78DouIO+FBsUIo58e1J8oFgcrz7fvRTmeehOFMd13FZJA9EvqPq07Ah1SYtxA
         PB+AWce2LviB91Z9rCbQ0dmqa+Mlu+50+kAAfZrVr37eoxSpu96QGE/T1sVrfZvya5Er
         xcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723566544; x=1724171344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsbiuRUlmo4RLNQnmGHI8pchnz0f5Sp6onkgIW0DlX4=;
        b=njCcuQhzNiN+47tm1vcVlhK6rEy5jWYdPkQrwgHVBIArQ68aaQGifeNu3a3a1T4J3w
         aB5p7ncb+Di8mBh+M/66jzH7Uch3Y7fqq0lC2W/d8/lxVL3SRQVYTT11Lup8zqBwxud2
         46jgGe3cN8S6s89g9X01s2Czd1RdJCjgCIQ1Xg94rrGTh8aRMak47Mc1zRJHRCShDsm8
         c1DLp6E/6NUhHap5PSTpxktH3bGkHiTVY5/y/viE8CWhl03hc3fuxDskOkxSwmm/Bs1N
         GQyw6F8nDZGfPjPPOpxiWpnmZCThGYmJKMNMf4lR+/B/O7U6wqEm9i8FaVwbnQQ2uxw6
         NSag==
X-Forwarded-Encrypted: i=1; AJvYcCWVw5oI670GNSE06J7JZulLsDamUCPp5YxRSHLgZvWe6z3z/kohebhPWpcrp9z5gE2SkF7Y7fTYVySdChoxZTI3+LD0iX81uoxMjmUQ+1OZJ8227QxnTXKpEzHQ9tKKcx8A3WCUhzsDqF8UiieUepLnZvRpPkmEaTyXq1FjKlh0TJ0ngVof
X-Gm-Message-State: AOJu0YxOSKbqrPABb+3eAw99tBa1cC9E/N+UB5X1WkoQKbgfhPTDeh1n
	H9TvXQU1uxR4Nu/zFn9AQk2V1NYVvJUsZ+4N3WvzZr1/ruXJGLrT
X-Google-Smtp-Source: AGHT+IFhM8MfQy/NKffVoj7J9CoSEpQI9NXHY4jV8akjJkOPDrXqH/6wlV6/772rcL7gJR8l95SVmg==
X-Received: by 2002:a05:6402:84c:b0:5a2:abcb:c4cf with SMTP id 4fb4d7f45d1cf-5bea1c7f2c7mr31901a12.22.1723566544025;
        Tue, 13 Aug 2024 09:29:04 -0700 (PDT)
Received: from localhost (dh207-40-227.xnet.hr. [88.207.40.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1968af77sm3005390a12.40.2024.08.13.09.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 09:29:03 -0700 (PDT)
From: Mirsad Todorovac <mtodorovac69@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mirsad Todorovac <mtodorovac69@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2 1/1] selftests: net: af_unix: convert param to const char* in __recvpair() to fix warning
Date: Tue, 13 Aug 2024 18:20:06 +0200
Message-ID: <20240813162004.2464421-3-mtodorovac69@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GCC 13.2.0 reported warning about (void *) being used as a param where (char *)
is expected:

In file included from msg_oob.c:14:
msg_oob.c: In function ‘__recvpair’:
../../kselftest_harness.h:106:40: warning: format ‘%s’ expects argument of type ‘char *’, \
						but argument 6 has type ‘const void *’ [-Wformat=]
  106 |                 fprintf(TH_LOG_STREAM, "# %s:%d:%s:" fmt "\n", \
      |                                        ^~~~~~~~~~~~~
../../kselftest_harness.h:101:17: note: in expansion of macro ‘__TH_LOG’
  101 |                 __TH_LOG(fmt, ##__VA_ARGS__); \
      |                 ^~~~~~~~
msg_oob.c:235:17: note: in expansion of macro ‘TH_LOG’
  235 |                 TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
      |                 ^~~~~~
../../kselftest_harness.h:106:40: warning: format ‘%s’ expects argument of type ‘char *’, \
						but argument 6 has type ‘const void *’ [-Wformat=]
  106 |                 fprintf(TH_LOG_STREAM, "# %s:%d:%s:" fmt "\n", \
      |                                        ^~~~~~~~~~~~~
../../kselftest_harness.h:101:17: note: in expansion of macro ‘__TH_LOG’
  101 |                 __TH_LOG(fmt, ##__VA_ARGS__); \
      |                 ^~~~~~~~
msg_oob.c:259:25: note: in expansion of macro ‘TH_LOG’
  259 |                 TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
      |                 ^~~~~~

As Simon suggested, all calls to __recvpair() have char * as expected_buf param, so
it is safe to change param type from (const void *) to (const char *), which silences
the warning.

Fixes: d098d77232c37 ("selftest: af_unix: Add msg_oob.c.")
Reported-by: Mirsad Todorovac <mtodorovac69@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
---
v1 -> v2:
 fixed a typo.
 change funct param type rather than making two casts, as Simon suggested.
 changed Subject: line to reflect the modification.
 minor formatting changes.

v1:
 initial version to fix the compiler warning.

 tools/testing/selftests/net/af_unix/msg_oob.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index 16d0c172eaeb..535eb2c3d7d1 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -209,7 +209,7 @@ static void __sendpair(struct __test_metadata *_metadata,
 
 static void __recvpair(struct __test_metadata *_metadata,
 		       FIXTURE_DATA(msg_oob) *self,
-		       const void *expected_buf, int expected_len,
+		       const char *expected_buf, int expected_len,
 		       int buf_len, int flags)
 {
 	int i, ret[2], recv_errno[2], expected_errno = 0;
-- 
2.43.0


