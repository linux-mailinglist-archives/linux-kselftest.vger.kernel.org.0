Return-Path: <linux-kselftest+bounces-37623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5093B0AF81
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 13:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EA047B641C
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 11:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27972397B0;
	Sat, 19 Jul 2025 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LznxAa4D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0C2222566;
	Sat, 19 Jul 2025 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752923597; cv=none; b=IuVbllqZKNBpBmEfvoETg7scMZxBVInwaPIp3azPPo5TBbsEuMuYB4whprcHb/8EaoPF0ITdH3LX9IqjlnYGw6LgzpW51aSxvk1Th7/+sazK7n4ZaEUS5Pqq6WuNNY1msRPSeNf3HuK6QGaBTg3hVVM1O17xGEKWLtNPrV5swhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752923597; c=relaxed/simple;
	bh=iDJifj/ZhU51RDm0EpQQSmQnGYmcG8haC/LGgI5iLDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KZbqiuQTH6qmsKRxIJ+PqF+gd4jRBka9JRdEjQfs9KCSUUyUxohkV6eYLvW9K/BjJxeThl2xQNutn31G69Il2M1ZvKzZs4SHOsA6B1dFlaygNqHVnvyty044sZrT5mrkrMYMsxRgpSNeMYAdgSf0gjH6EV6DllUvgT3dNcmgKlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LznxAa4D; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234c5b57557so27289415ad.3;
        Sat, 19 Jul 2025 04:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752923595; x=1753528395; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZjByKCvTZEF1xGfMFmwT1JaBMmtSxQ+whOxPUBJ5+Io=;
        b=LznxAa4D8B4Gg41t3vIVWJv80vxIh58FsPuLwamELavP3oJiV+P0UFqlWtmx4MdmV2
         6DN32Krx9PxsJ4Au0fXEHYS2D2yNsoMAnEzlfUMUOP7T1LEsLRKNG8TTk+UM87TRGsO8
         OrHof6TFyTsPD5fxTnZb6Gj30/aJGmogtmJHqEjfKwTqpfO4pIwe6m0ctXmmn2fn21MH
         UGnMkRlrWCk6Ok1vD4aLqdxZimr2Cd0UOlIMSq1YA32sXEeUbNAEmEg3AGMnIvq3Y9XD
         5VjjjPVKcMyo7gIOIyxnlvZUxTKo/cdZ4oRXwOLCUZvGLhHmDYixV12Q0yiBVTdAEp4n
         0QEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752923595; x=1753528395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjByKCvTZEF1xGfMFmwT1JaBMmtSxQ+whOxPUBJ5+Io=;
        b=u95rLHb1WnDwGj0/c6imvxATEM74otJN2WnHze8sx99pssST4oKN1CP5QDD6tbJy1t
         q6WqqDJslprdJVnngk/pOQPJrmRT0464bmwcA2fdQ9GtmO3fM2cKWyK5vXUQVBHPANjF
         yHGsnbS4uQFMtn8PQzthCep3Jw8b9HJJU0lMHW+/9PAe9PJBlNkPzoDZCl8I9/ojtIHY
         I/+3Y1Lsnc88kOwPn4MD0ZwWfEfakr7aDythE3JcZbO7RRWcyy3ArSeHnK7oA4jby+mi
         Mg7zcDYatCUkhpsKxMiBezElVOHGDMKzVpbGVrRbh9V7p+NYW91zzVdeWnP0eoQ1IDob
         ESgw==
X-Forwarded-Encrypted: i=1; AJvYcCW9bH5WYK0Q7fSWoCSZKUgNKLkY3tqAnut6bJGNvFzzuTpQzOSFwHAvq8+qiK0rKtYjg1tf/NXfxLtsqeYcs7kf@vger.kernel.org, AJvYcCXizca/djppnrm/EnZjzerxcezMLYsjLWBbNqEXMPk0EC2aEVN9Fxz99oW3VBS7hNJ9eVwQoyXlAEzfi2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa/roSrZl5kmF4z9NIdlyUSoSXAoSpClwd+ZfX35/0ZUwxRl8H
	bdtGUJ99xP7PgHQEKVLAum5GR3TXIOU2BKuXIyS7sl6d6Y+bw2H7Vet9
X-Gm-Gg: ASbGncvK0Jlkv6l8q9ePC8+Gsd0VaUrc8MgmE//AgCiREFTpbnGBS8DkGVNAlCHxxTA
	xm97Aqpt2QIvW6/S/yzLDxjA6bo1Cy1vU3bkCz0RlgjJZbmLUNCePsPsIyJDSU/J2spbGeghse1
	3CBoJQVBFw5+/M5bC/5nfknR4wdYBLKbXe+clkbhr+SVw0xFWkxV2z0kdgfQp/dMt11TQoMKlWE
	PejIX3j/5eu0QT0YJDLLS5rJIS56tgEdGP5Nhzz6YJLGRsjM/855TSgRgdfJ2naW2jebtSdZ91o
	iIO6iNy0RyoEDbvkJKy/8GI5x0dXc7wj0EKB2ikU/ZsvSA13FsjnT+oKuFxR2He1sTxCnQv+giV
	dGD0k8evSgNtwoSl10l0r
X-Google-Smtp-Source: AGHT+IG0u/3BM4162UOk4cT8N50hBTxDblT9eqv7wTs1fnB7ULc1mTo4uoyoShWrx6dn8rHaTBHZfQ==
X-Received: by 2002:a17:902:ea01:b0:235:2403:77c7 with SMTP id d9443c01a7336-23e2576e462mr159838865ad.37.1752923595464;
        Sat, 19 Jul 2025 04:13:15 -0700 (PDT)
Received: from [0.0.5.57] ([136.159.213.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4c81sm27388875ad.114.2025.07.19.04.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 04:13:15 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
Date: Sat, 19 Jul 2025 05:13:11 -0600
Subject: [PATCH RFC 1/4] landlock: add LANDLOCK_SCOPE_MEMFD_EXEC scope
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-memfd-exec-v1-1-0ef7feba5821@gmail.com>
References: <20250719-memfd-exec-v1-0-0ef7feba5821@gmail.com>
In-Reply-To: <20250719-memfd-exec-v1-0-0ef7feba5821@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 Abhinav Saxena <xandfury@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752923593; l=3578;
 i=xandfury@gmail.com; s=20250614; h=from:subject:message-id;
 bh=iDJifj/ZhU51RDm0EpQQSmQnGYmcG8haC/LGgI5iLDU=;
 b=ZOXLrGW0W9QEKrXbhoVkDi78LrYBAUNgeQPX7CkuOST32Syj2llRiJTC6HzEjjW1yg5JJkEI7
 uaGLyqCIzXSDFD0uOnqyqVtpbUvGTTHCL2b4oaMaWBJnT4qYZu981A8
X-Developer-Key: i=xandfury@gmail.com; a=ed25519;
 pk=YN6w7WNet8skqvMWxhG5BlAmtd1SQmo8If6Mofh4k44=

Add new scope LANDLOCK_SCOPE_MEMFD_EXEC to restrict execution of
anonymous memory file descriptors (memfd). This scope prevents
execution of code through memfd files via execve() family syscalls
and executable memory mappings.

Update UAPI headers, limits, audit infrastructure, and kunit config
to support the new scope. The scope follows existing Landlock
scoping patterns for hierarchical domain enforcement.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 include/uapi/linux/landlock.h  | 5 +++++
 security/landlock/.kunitconfig | 1 +
 security/landlock/audit.c      | 4 ++++
 security/landlock/audit.h      | 1 +
 security/landlock/limits.h     | 2 +-
 5 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index f030adc462ee..5fa439b65aa6 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -364,10 +364,15 @@ struct landlock_net_port_attr {
  *   related Landlock domain (e.g., a parent domain or a non-sandboxed process).
  * - %LANDLOCK_SCOPE_SIGNAL: Restrict a sandboxed process from sending a signal
  *   to another process outside the domain.
+ * - %LANDLOCK_SCOPE_MEMFD_EXEC: Restrict a sandboxed process from executing
+ *   anonymous memory file descriptors (memfd). This prevents execution of
+ *   code through memfd files via execve() family syscalls and executable
+ *   memory mappings.
  */
 /* clang-format off */
 #define LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
 #define LANDLOCK_SCOPE_SIGNAL		                (1ULL << 1)
+#define LANDLOCK_SCOPE_MEMFD_EXEC			(1ULL << 2)
 /* clang-format on*/
 
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/.kunitconfig b/security/landlock/.kunitconfig
index f9423f01ac5b..a989785df65d 100644
--- a/security/landlock/.kunitconfig
+++ b/security/landlock/.kunitconfig
@@ -1,6 +1,7 @@
 CONFIG_AUDIT=y
 CONFIG_KUNIT=y
 CONFIG_NET=y
+CONFIG_MEMFD_CREATE=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_LANDLOCK=y
 CONFIG_SECURITY_LANDLOCK_KUNIT_TEST=y
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index c52d079cdb77..a439461d1b28 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -78,6 +78,10 @@ get_blocker(const enum landlock_request_type type,
 	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
 		WARN_ON_ONCE(access_bit != -1);
 		return "scope.signal";
+
+	case LANDLOCK_REQUEST_SCOPE_MEMFD_EXEC:
+		WARN_ON_ONCE(access_bit != -1);
+		return "scope.memfd_exec";
 	}
 
 	WARN_ON_ONCE(1);
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 92428b7fc4d8..5a822bc50c4a 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -21,6 +21,7 @@ enum landlock_request_type {
 	LANDLOCK_REQUEST_NET_ACCESS,
 	LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
 	LANDLOCK_REQUEST_SCOPE_SIGNAL,
+	LANDLOCK_REQUEST_SCOPE_MEMFD_EXEC,
 };
 
 /*
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 65b5ff051674..130f925283fa 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -27,7 +27,7 @@
 #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
 
-#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPE_SIGNAL
+#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPE_MEMFD_EXEC
 #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
 #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
 

-- 
2.43.0


