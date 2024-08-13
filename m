Return-Path: <linux-kselftest+bounces-15263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6583C950D0A
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 21:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992F01C20BE9
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 19:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF181A3BBC;
	Tue, 13 Aug 2024 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/neOpbm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E41719D089;
	Tue, 13 Aug 2024 19:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576780; cv=none; b=EU8FqYIzNgh9DPkrXIwZzSgOuwiGBLclQqY7cV6tRJnWII50q/b6d/M/K0Kw6PBHkbLB6LnHYLEcZk9sFUK4yJETibQwfiijvKMZ5CeUlhMycuwFhA7V2k/OU0itU5ltzb7z8injZGXr/FtnJIOXX/v1DNQen5vV4WR61YcscEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576780; c=relaxed/simple;
	bh=IZHBr6nBAgIqDpRpBynDI7Xlqc6bhu/1aMgMA6LlhEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3gzwo0i4TEmiKePT9h/1KZTIIRDTT1RpakxQU5MacwpkFbozDiwWJT1vJN+gsFG5eOn2SIcd6IBSfuoXf8ti2DGZE9J4mewA9vjyIs9um3U+mWST0Zpxm5IMDta0EHKIXE+h11/iTPTnw1nRc/MQ9QJuiNgWmftJFNQi3f+EqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/neOpbm; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-8231d67a168so1807307241.0;
        Tue, 13 Aug 2024 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723576777; x=1724181577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/Zn/h+JQIsHvCLzDZYP0fiItezGPIXw+RuI0U0vrwg=;
        b=E/neOpbmnb75gQPkd9yNNMEY0fEFq9bpDo2yruuxsqkvTEfVcJMECB/tdtIm5w4EDS
         /9NKXg+TUiX16uLfCMOIcXAnRI8R7z2YBeDqKpslTlPjqFOgNdgTzCjuKuNJvzBf23rL
         LKGshHOY44rCUvR8pqS0J60z1/u1ctu+mq89uxh3Wck4/U71rbmDqKsftw3y8ITYWwYT
         QSJdw7lXqAq7cNS9HSRhqzx2vpMY9Tlv9c8CdbYRld3kgxu8HVN6J6WS39q0mWq4egM+
         Lz9qeJKh+5g7hs/Qo08hWUtabR6WU3ntrwEZryTtowfIjgBmXbQYc5l2a6nj1YAAcnaU
         q/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723576777; x=1724181577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/Zn/h+JQIsHvCLzDZYP0fiItezGPIXw+RuI0U0vrwg=;
        b=tGyGYv5Rtfo22c9JBQ0TQJxg8ynyxlFBNk16JpVQSpGJ3RYBvMR6kO8P36aD62BzsY
         OdA0A0BWaVMZuDRySKlR9RNOF6gHOAlpHwDeGjbwLONjvPoDy4cphYIHokVsV9j9k/qL
         AIMmbKrbWJ8jxfhEySBhF8Ktjnl67py/uNZEApsuu6CXfOxegRIhz48Mkpqrw10tf2Oi
         dxMO8X43k6WMRiIlEexzIvM6TVqb8qcTBRM54aGRdV3E7RwDWBINSNECDOiW9tHVyP+S
         U3mF1VL/T4Dirpd6kC9G3AsN6Bxb1nady45XUK2i9INOEUr89vrcvNenT5u+izLfyFio
         ayhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq28u4Nl7AXa0zELUwKEIJhBvoC5pcJXqLrpJ0xLDTWsWSMIEbU2qmbkHDabH7dNTyRk0+YSup5BfSzlpjIaA/PLye2UdJPbSqV91Bjv0KdLUYhuKc8TDED9qj6BINtoLupUDQ1qbLwN6GZrOBhsYk8HHPnyj2odxsGTz/uYsxI5NKS4e6
X-Gm-Message-State: AOJu0Yye2T4lvqjhFbLdGN7j2PawU9mJaMWsdNwfwIxFbjKxF12Frjo9
	p9h1Fg5uoFld4fUExJmZDqkXOlJu1eZicBsFI8wNqGb6eaHBs1Et
X-Google-Smtp-Source: AGHT+IHY3fKEL2gZYzr1fjw0Xkz2Slgu4zpozSt8XU9NibbEYuPMCVOmeXxVBRY37DahLbkM+RQ2fQ==
X-Received: by 2002:a05:6102:304b:b0:48f:420e:b684 with SMTP id ada2fe7eead31-497599f3db8mr694189137.27.1723576777229;
        Tue, 13 Aug 2024 12:19:37 -0700 (PDT)
Received: from localhost (57-135-107-183.static4.bluestreamfiber.net. [57.135.107.183])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-841366596cesm1014290241.6.2024.08.13.12.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:19:36 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: kuniyu@amazon.com
Cc: davem@davemloft.net,
	david.hunter.linux@gmail.com,
	edumazet@google.com,
	javier.carrasco.cruz@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Subject: [PATCH 1/1 V2] Kselftest: msg_oob.c: Fix Compiler Warning For Incorrect Specifier
Date: Tue, 13 Aug 2024 15:19:32 -0400
Message-ID: <20240813191932.991638-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813061254.36825-1-kuniyu@amazon.com>
References: <20240813061254.36825-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Change declaration to 'char *'. A specifier involved with a macro is
causing a misleading warning to occur:

'''
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
'''

I ran the tests using the following command:

'''
make kselftest TARGETS=net/af_unix
'''

I used a diff to examine the difference in output among the three
scenarios (1) before making the change, (2) after changing the
specifier, and (3) after changing the declaration. I saw no difference
in outputs among any of the tests; all three tests had the same exact
output.

For "net/af_unix: msg_oob", all 38 tests passed for msg_oob. I received
this result for all 3 scenarios. Should I have gotten a different
result?

Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
---
Apologies for not looking ahead of time. I definitely need to remember
to check ahead of time. I understand that the other person was first; I
just wanted to get some practice sending patches. This is all still new
to me. 

V1 --> V2 
	- Changed the declaration instead of the specifier. 
	- Put number of patches for this bug fix. 
	- Put in tests performed. 

---
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


