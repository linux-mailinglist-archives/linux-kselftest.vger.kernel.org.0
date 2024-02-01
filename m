Return-Path: <linux-kselftest+bounces-3924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA358452A8
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 09:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546FB2822C9
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 08:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5516115A4B2;
	Thu,  1 Feb 2024 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izkQ1vgd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B49015957F;
	Thu,  1 Feb 2024 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706775985; cv=none; b=uZxfYGWdvBu3bzBD0xW656/U6XJnyec7zD9kzAHsQBwz2tEvgsgFxnGMqGqHPX95yh6U1NP2NfSXk4eTheiwBXpr0UdbkT4PtXwT0nU7eaNhxrNaN7MYCZzOd6ulAa+6uG8B3hfPzOwYZnI90AJDXjgzynt3AgKXq+ihnbkZ7Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706775985; c=relaxed/simple;
	bh=knJJzWChot6X2VFh0WEfUeOlcQaLFTlFMogt5kBThYc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OcidzaC6Wc5sTb0NSJ9MxM96IH75tZEZ8yIhzBsIRNluDUGF/xWkuW2pU7bl6m1XvUFhPImM3Jyk1Vo9WV8hkTckCG/OG4SC24/C3Nh8QAlfy3RttwDoYOYDMF6Z0caQ5Rofa05VqyhjGwHBCHtqIw1AhHmecHUj3XpxxSAYK5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izkQ1vgd; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a28a6cef709so85899666b.1;
        Thu, 01 Feb 2024 00:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706775982; x=1707380782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wknF7XfhG8tU0qg5dVgdBNdPsQJNDA0DXfRviA7Oev0=;
        b=izkQ1vgdlJblx9CBD05gcWTAW9RFD0oNeZAtA7ih3akowI1EQbYvbloAXCM/JNv9hl
         HGY3uqgOeGe5Vi28Kd1Fwfwr1Wzm4pZbju1Tr+PU1Rr01qn2zCL3csOnc4dDx0Qr78bG
         mf5xyzSoF9UqOxiZWfOeRK76XW9GTbPzSP2nYKQ4ei8quHvxtj/Cb7NWgXso/m6QGkm5
         1JgxOpRy5rFps635s1W1xYN5uolNx75bo6qVWgVDnnFzmu93D/iklVdiZSc+3u/2gF5F
         q9ik3klixMgNJv57iftEX9CPkl4oayZ7ZkwEGzIU6iPx7GUQe1mYiyhcZeaP9NLN8+Kw
         hmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706775982; x=1707380782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wknF7XfhG8tU0qg5dVgdBNdPsQJNDA0DXfRviA7Oev0=;
        b=oTjj/osuYaEVQxneX7ROmZBFbWF2HiRjapUQARaRAJ04+CrpVrk0ERql09r1QBaUmf
         1xlIjhOKmycObagBLkm5Ph9ZKBsGfzYdd+G50BT971TfejQcwGmYfuIvCYv4ICpzNYRe
         Bi6mIVOoITY88oP38M3sw9XzZNiDyd7H1mxNEiDy5bPPHe0b+OvLnN+TfekL5U+1gB/M
         sm/5iA+aO2qhLyMO9cjrmP3mKDOIinjtIi3WaarCVgKn+gnl4oIw48ae7eB7SWgxz+Fd
         RUPUuev68YmmySa/V6FeJf3HqxdJzotvbJf6FLtNTPhe/Kbip26GIKPpPYQNT9S+IU2O
         PRDA==
X-Gm-Message-State: AOJu0YzDfzTnncVmTRN4pA0B0k+GuXB3Q8Dpq4dIHjtisQp5MZg4UGLp
	5sz8HKIWFgv/wDJqj9HIbGhy1xP3jiqxwE+19v2thM8xRI+R0SrT
X-Google-Smtp-Source: AGHT+IEh3MZ9iHUhPviRYTlqzQo6tIbLK5NyJ10RL3fuXuHdtpdrprze52LPElRCtt+oo3YbL/CGIg==
X-Received: by 2002:a17:906:278c:b0:a35:d914:c33e with SMTP id j12-20020a170906278c00b00a35d914c33emr2652050ejc.52.1706775981529;
        Thu, 01 Feb 2024 00:26:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXmnA3fbWCQG3HQHXGYZ9KzJdOqAkX/clkebtqocjZDoKxNhiPpEHbdbtRjfriOSgP9godqO6S45NtH+l3zqP7g7P6xM3jjBhYG0AulYL1U+WVH2t8RSrb5BrzTyEZ/En8Ha+3tOOLIgrqq+gnmmGtOutDWFhtQZEmFvgxLvuaE45cJITCHLp8p6HW7ER6zN2kZjrXwusdY+iqSgeb0rq+HoiRje7m/NOZLMsJ+z/5TrSlRJEqINveAx1ErRkFFiR1T3ExOJEH4tDlXB8tKSsE/WEikRpWAgQE=
Received: from localhost.localdomain ([213.55.221.11])
        by smtp.gmail.com with ESMTPSA id pk27-20020a170906d7bb00b00a35242f5976sm6171849ejb.164.2024.02.01.00.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 00:26:20 -0800 (PST)
From: Ali Zahraee <ahzahraee@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	shuah@kernel.org
Cc: Ali Zahraee <ahzahraee@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: ftrace: fix typo in test report
Date: Thu,  1 Feb 2024 09:25:57 +0100
Message-Id: <20240201082557.15965-1-ahzahraee@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is just another trivial typo fix. The typo shows up in the final
report after tests are done.

Signed-off-by: Ali Zahraee <ahzahraee@gmail.com>
---
 tools/testing/selftests/ftrace/ftracetest | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index c778d4dcc17e..25d4e0fca385 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -504,7 +504,7 @@ prlog "# of undefined(test bug): " `echo $UNDEFINED_CASES | wc -w`
 if [ "$KTAP" = "1" ]; then
   echo -n "# Totals:"
   echo -n " pass:"`echo $PASSED_CASES | wc -w`
-  echo -n " faii:"`echo $FAILED_CASES | wc -w`
+  echo -n " fail:"`echo $FAILED_CASES | wc -w`
   echo -n " xfail:"`echo $XFAILED_CASES | wc -w`
   echo -n " xpass:0"
   echo -n " skip:"`echo $UNTESTED_CASES $UNSUPPORTED_CASES | wc -w`
-- 
2.34.1


