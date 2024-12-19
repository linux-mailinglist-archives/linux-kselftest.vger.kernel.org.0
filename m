Return-Path: <linux-kselftest+bounces-23546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6A89F71F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 02:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8331F169CED
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 01:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16BC8633E;
	Thu, 19 Dec 2024 01:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="F5AEf6az"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508D81369B4
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 01:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572531; cv=none; b=omw0Dx0bo4oEONuPpy/Clj8nrx1Ej1oxdbgMXqGnPG9YZ4O4z3HZ+/AIqRy0iRfj7CYxuO1Bo/WupemhPF/Lv/lvPmFgbqI66y2R/irn/5borI37sJq3L0R1N0MQAGdyd9XAoBYkmIc25bbt4kO746MRpTthZy6F7s34ShucIPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572531; c=relaxed/simple;
	bh=56OMCOtIfKnQNHrq38KOG3mRt69b807FX7c4iC7LK5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tqKnzAKjtrf22f6NG6czlLSendAnasqioimYJCjN5vnEP0Jtd+3DOJ+qEvpsr3il/17CwBxes3g9aowOochrcI/mMwjPBWayB/Rd6eBG+QGvLtW+84/zEoh4VWlb2aG1Ik/DhckcjHM4S1mkEPYHkjPyNUqsc2jayHSotI0iBls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=F5AEf6az; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so2581065e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 17:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734572528; x=1735177328; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ROf1YO7U7YRPhtUQjic2RobQOCF579EfU3vleZMCDQ=;
        b=F5AEf6azmTtK4P656oiQdtUtkfs2wQoxdtbmlMb2Ywd2p69vClcQHfaGO/NvRS/opO
         6pn01HuPV/tZLTORzZDFAajpJ0i1UGjhCKLsCArYryxGDT2W30vFCU7dvJJ0c4aCsXtB
         lYdcrLrT5k/lH6379S6KW1asUwk3BJZZRv/IifNr5n0ydO4NkWiEEJNyVCqGRv53FzRb
         Nb6/9Vqdjuej7oloQgXpoA8TEjHwisde1XzOb0ppBqyMm8xqT/MSnysBBkKw/7hNdDBH
         d4a+6OZRKj7kwK2Jc1m4gNRVOj7+nKApxT3T1KPDUkRjEUtooSQXN35tJBjggDO2YxlX
         M3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572528; x=1735177328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ROf1YO7U7YRPhtUQjic2RobQOCF579EfU3vleZMCDQ=;
        b=WHTytBhHPie0Z0T/sszHsQt6UpDq4vjT62bnh6h8FcOibA6L6FPMnP/22B2Wvt1UT9
         XNhFj69ToEM/DBJ+hGRc0y/oOjInyGmwIvjcjOOCixWND6C+S+X6G7OcB4F5pHSb9aIP
         QK0Fe/B5e3VZIPVXDGobM7EF90fh73nI+l1r36NdJRMWplgS8hhlsGeuD+SNsDwZHjeT
         h5fwLwycpbQotzoUt15xlEYBEDay/cugFCB7DxLKxjN8EYXBEhFRNVk2k6mRuI+X9Mov
         oCmqtKzYDil44sYUz8PeiT3zu/GzU5bNx0TNftxn7t/gkiohfKFVMTCLVRSuQY9Qe1Nj
         IETg==
X-Forwarded-Encrypted: i=1; AJvYcCUK75IQPeWqoLO/zUPJfo0MX0QepOBp2ViJE01CheGe3hLoGZlGh481ZNNbJsMfVJ/mD6RcedbCkG7OMU+Ep+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSX4bm1AEax1HxISvaYvNCtQcQyfAVM9HN+D3kzyGbUoC9drP0
	czqBIn6ADuPOUWb1jDc5u2wNxZ65x7B5QrbCHgy8AdGP3p59lJjzT9+CUr7jYFI=
X-Gm-Gg: ASbGncuoPLEbuBMgK6Mt5ufGbn8dTv1AdudvsL/V26DRjlqikNTJOWFAhqFEc2buT0P
	GPdMDap7fgSp9Z46TxkyamK5TIopRCK5t5qKs0yGmJE+UaMgDnhpneSjblo+QqcGmUXXjPp2P9m
	KRcoIOoq3ehbTMyR7Q8OyliQIXBFFSJf33ExNuRXLG2hRH5Mac3wcA4D/asIbaiGxxqdxuXghrn
	USKpzJU9hbsIejTNmqBqDPTUWbO8piPbdYBV6NqYr6GZBuVulPAgODlXEVC3+uJFGcr
X-Google-Smtp-Source: AGHT+IG7fKpqD5vP1CVkGXlvNC8Q7yruJaxqstBMPxf+PdFkWzsaQyUPnfHzCDQijTDdV/IFUp/pQQ==
X-Received: by 2002:a05:600c:468b:b0:431:93d8:e1a1 with SMTP id 5b1f17b1804b1-436553f533emr39925195e9.27.1734572527730;
        Wed, 18 Dec 2024 17:42:07 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3257:f823:e26a:c3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a376846sm63615715e9.0.2024.12.18.17.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:42:07 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 19 Dec 2024 02:42:00 +0100
Subject: [PATCH net-next v16 06/26] kref/refcount: implement
 kref_put_sock()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-b4-ovpn-v16-6-3e3001153683@openvpn.net>
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
In-Reply-To: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun.feng@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3869; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=56OMCOtIfKnQNHrq38KOG3mRt69b807FX7c4iC7LK5M=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnY3oVjPvi2YQNkvA2klxwEEjEI3HDWTnQOK+ee
 pfuifFn6wGJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ2N6FQAKCRALcOU6oDjV
 h1QxB/4kiFEUQTjuQrGTkaanjnV9VKmY1Mn6s8JAM3aC32xWU1ASSkfVFt/KTaQ2Tzr3k8SsF5j
 RmiD8VPrWUDSqalFhx1U3PjLik0OFOrWwPiVR7QvL0clpbHlaO2ewHFy5rLT/O9hSPK1oErs/PY
 mvgR5ccAROUhgiZOhECTOZVpjsP3WkBnSHCCaBn1mLYvNt4rNLlxlkI1t+02Fk4p//ctrbPErOt
 6xxU9a4gdsYHfuH2JBUdOpu22thgUjXhm72JvKqpmZSzPI/DYZvc3dLkMAUZ3l1C8wa4Pw8FZIz
 +h3e0TBE+Of8jgWcpuCNSxAergoImDVJwqBxlSJiXcqtGU0t
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Similarly so kref_put_lock(), decrease the refcount
and call bh_lock_sock(sk) if it reached 0.

This kref_put variant comes handy when in need of
atomically cleanup any socket context along with
setting the refcount to 0.

Cc: Will Deacon <will@kernel.org> (maintainer:ATOMIC INFRASTRUCTURE)
Cc: Peter Zijlstra <peterz@infradead.org> (maintainer:ATOMIC INFRASTRUCTURE)
Cc: Boqun Feng <boqun.feng@gmail.com> (reviewer:ATOMIC INFRASTRUCTURE)
Cc: Mark Rutland <mark.rutland@arm.com> (reviewer:ATOMIC INFRASTRUCTURE)
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 include/linux/kref.h     | 11 +++++++++++
 include/linux/refcount.h |  3 +++
 lib/refcount.c           | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/include/linux/kref.h b/include/linux/kref.h
index d32e21a2538c292452db99b915b1bb6c3ab15e53..68b11b0c9c0fdd17cf706e0eb15f74cfe2efa178 100644
--- a/include/linux/kref.h
+++ b/include/linux/kref.h
@@ -90,6 +90,17 @@ static inline int kref_put_lock(struct kref *kref,
 	return 0;
 }
 
+static inline int kref_put_sock(struct kref *kref,
+				void (*release)(struct kref *kref),
+				struct sock *sock)
+{
+	if (refcount_dec_and_lock_sock(&kref->refcount, sock)) {
+		release(kref);
+		return 1;
+	}
+	return 0;
+}
+
 /**
  * kref_get_unless_zero - Increment refcount for object unless it is zero.
  * @kref: object.
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 35f039ecb2725618ca098e3515c6e19e2aece3ee..22698db1f24fdaf884a508b8a0cd44eb62194a9f 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -100,6 +100,7 @@
 #include <linux/spinlock_types.h>
 
 struct mutex;
+struct sock;
 
 #define REFCOUNT_INIT(n)	{ .refs = ATOMIC_INIT(n), }
 #define REFCOUNT_MAX		INT_MAX
@@ -358,4 +359,6 @@ extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
 extern __must_check bool refcount_dec_and_lock_irqsave(refcount_t *r,
 						       spinlock_t *lock,
 						       unsigned long *flags) __cond_acquires(lock);
+extern __must_check bool refcount_dec_and_lock_sock(refcount_t *r,
+						    struct sock *sock);
 #endif /* _LINUX_REFCOUNT_H */
diff --git a/lib/refcount.c b/lib/refcount.c
index a207a8f22b3ca35890671e51c480266d89e4d8d6..76a728581aa49a41ef13f5141f3f2e9816d72e75 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -7,6 +7,7 @@
 #include <linux/refcount.h>
 #include <linux/spinlock.h>
 #include <linux/bug.h>
+#include <net/sock.h>
 
 #define REFCOUNT_WARN(str)	WARN_ONCE(1, "refcount_t: " str ".\n")
 
@@ -156,6 +157,37 @@ bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
 }
 EXPORT_SYMBOL(refcount_dec_and_lock);
 
+/**
+ * refcount_dec_and_lock_sock - return holding locked sock if able to decrement
+ *				refcount to 0
+ * @r: the refcount
+ * @sock: the sock to be locked
+ *
+ * Similar to atomic_dec_and_lock(), it will WARN on underflow and fail to
+ * decrement when saturated at REFCOUNT_SATURATED.
+ *
+ * Provides release memory ordering, such that prior loads and stores are done
+ * before, and provides a control dependency such that free() must come after.
+ * See the comment on top.
+ *
+ * Return: true and hold sock if able to decrement refcount to 0, false
+ *	   otherwise
+ */
+bool refcount_dec_and_lock_sock(refcount_t *r, struct sock *sock)
+{
+	if (refcount_dec_not_one(r))
+		return false;
+
+	bh_lock_sock(sock);
+	if (!refcount_dec_and_test(r)) {
+		bh_unlock_sock(sock);
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(refcount_dec_and_lock_sock);
+
 /**
  * refcount_dec_and_lock_irqsave - return holding spinlock with disabled
  *                                 interrupts if able to decrement refcount to 0

-- 
2.45.2


