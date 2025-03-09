Return-Path: <linux-kselftest+bounces-28554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD17A58448
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 14:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F9C16BA2F
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 13:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021DE1DE4DC;
	Sun,  9 Mar 2025 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="EKe08A8V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4313A1DE2C2
	for <linux-kselftest@vger.kernel.org>; Sun,  9 Mar 2025 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527001; cv=none; b=sWKHT5EIKIxTb1Vw+x3MYwa81G4fiooy3rO1v92OJh5XUHTWVmWR8922N98Irhw+Hs/4O1QWWJY99+ebbD2bKJEEgTsWwNXPHu9Ri/YUP5t69f02mAGYKTXlYGhRnH9JkYNsoXq6In5IIV+2qemL9T1sY942sPVlCDtdSsjFA/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527001; c=relaxed/simple;
	bh=HBzrftBgtmyJjSlrkubZ14+wzgBNDhuJgvNUC0ysav8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYgUJxEOXSRt/GEfZ8SOo2NIKW7cwB3hVnElm+Un/ZgL0TnlBkzBhjNrFv5ua9pVQcOrMhj2TcCXRQrUpWW3+xPngipHcrUuZCJVgzxceXDARPqFoclGLWy30t8NejF7OZ0w3sWUD844Sh9s7KNOBjoI8xCrkWRTO3sbi6tyLUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=EKe08A8V; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E08BC3F5E4
	for <linux-kselftest@vger.kernel.org>; Sun,  9 Mar 2025 13:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741526992;
	bh=De9T9eT10I0LuI5V7o8PivgIMdFcydoHgbUnBTWTEUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=EKe08A8V3AB6xavWqusHkCNfY41018VKYCeRg1LKJCS8U+jWhQrnyWykzQGxe1h0W
	 2yKRq18BkSb9TJnm4JgjUjaChQjU+Tk74rMrZ0XRwUMPzDczD4Q2AqbUeZc18Cos5m
	 EOrB+VLmROcCeg7BIYdvhIlVfvw2u0MQFEk5s5DrdBYEHi4aBN5/TwBA78kHoD0niT
	 HFI8ECnCacgE5Y1+e/25d+aQsi6OkyX2WlCz9cN7976rhaZ66BHPu3XJWZKq1KUlZr
	 GjCz7fktPwC9HfURXmYJplmUMa7zNv93u+agfvWPE8y+S2yOf2eNBTUrxHWow4kcAB
	 PM/QWswcYBchQ==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac1e442740cso317835066b.1
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Mar 2025 06:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741526983; x=1742131783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=De9T9eT10I0LuI5V7o8PivgIMdFcydoHgbUnBTWTEUw=;
        b=FXUkq/ncNZ2Ld/z/ng2TRgu4eAiBA+IJ6gI+wyReIGzTdQo+Ui1aipw716syp4IirJ
         Z8DVrd+bCXAKMi4pL+Hs+lBea1LD0FHbC7qOvoNfp+B392FXP4fBRjf0BMj+0Q7O6yqM
         LqcEOjD18FuASrQM3C1E19HAX6bHFmALGk7UlJLtbd6sguwbRMKcqsb3AwsqnxhqP8iI
         pllO8Uj/ekisgxLQI/vfMl0cDtnMmhfWSAov1dEIUso5aHOhTd0YT6avaYTiSz0v/bjX
         Rxc0kCPNTIUnrp/dPQ9R8y6LLeZq4q7VMeTWQRFGxazI74chQMPRbOZJSPaO+dnxlmsc
         YSMA==
X-Forwarded-Encrypted: i=1; AJvYcCVe4eYg5UoL8StcNfyRLwsMqkm+uY3ZP9wYaR/3yF4BIxnF0SILoMt9MMyS5MZ7bsf1lJT63jgla1aiYVcaLsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9m0M9RPwFjrCG+8uF+T0FVOaQkYpiN9RlENJLftaM3JDeM5q0
	YAX/CPMPYRZhGRmmdt5MU8hbq30dNnxDejcrFpD8vZsnzi46xwZ/IugEBt1tXMZcmKnwvxhqJQw
	g3tUnfDUsCQ05+SzfsJzOK09LaqcLux/XeeuumOx9V5ScUM1PtE3Sn77rYusfq4mn9IAG9leQ35
	z/cqf49g==
X-Gm-Gg: ASbGncukDwaycGgURuraqb+mDteTXx/zLLSRlIaFECdOvD7/UdfVan3672fBEYnbpB9
	ySrwHBH8kaI2jxJcbcg9nu/t0JXwSiX3xxJR7mi4qNXg34gaXiAT/w2Pm0mlsowS4vt8onZVKTQ
	M4DfWqDZhyB6dVvPqSYtTdmFEOfT1DIqU3xaLJ/OXEALu8wjbFiFjj58bJPiW53RhyysXfa26l1
	t08t0aIvCwZR6PUeTTb6R+HYWdwf+1NXxK6/Y1T9Xd/AtL9CCPGumJ9OJhh/QF0RQb+P/T//qo2
	xP7a5rhMMbsTQbemhtxOITmAGqS6Ik8yU3HGjVZpOnx79PnyeZhisZOFkOZfOxnPF3NQ1wnyiUE
	h8jbyzGXtIAJjrme1jQ==
X-Received: by 2002:a17:907:97d5:b0:abf:6166:d0e0 with SMTP id a640c23a62f3a-ac252fb9c80mr1252828466b.35.1741526983274;
        Sun, 09 Mar 2025 06:29:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0Jp1lBL5UEDOmoLhr3/1+wDXXnEG000YcKS7uOUaGglmKZVGqoQ8LvIDpjopxUUJhpkTkFg==
X-Received: by 2002:a17:907:97d5:b0:abf:6166:d0e0 with SMTP id a640c23a62f3a-ac252fb9c80mr1252824566b.35.1741526982866;
        Sun, 09 Mar 2025 06:29:42 -0700 (PDT)
Received: from localhost.localdomain (ipbcc0714d.dynamic.kabel-deutschland.de. [188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25943f55csm435897366b.137.2025.03.09.06.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:29:42 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@amazon.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	cgroups@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next 3/4] tools/testing/selftests/cgroup/cgroup_util: add cg_get_id helper
Date: Sun,  9 Mar 2025 14:28:14 +0100
Message-ID: <20250309132821.103046-4-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Michal Koutný" <mkoutny@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c | 15 +++++++++++++++
 tools/testing/selftests/cgroup/cgroup_util.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 1e2d46636a0c..b60e0e1433f4 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -205,6 +205,21 @@ int cg_open(const char *cgroup, const char *control, int flags)
 	return open(path, flags);
 }
 
+/*
+ * Returns cgroup id on success, or -1 on failure.
+ */
+uint64_t cg_get_id(const char *cgroup)
+{
+	struct stat st;
+	int ret;
+
+	ret = stat(cgroup, &st);
+	if (ret)
+		return -1;
+
+	return st.st_ino;
+}
+
 int cg_write_numeric(const char *cgroup, const char *control, long value)
 {
 	char buf[64];
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index 19b131ee7707..3f2d9676ceda 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <stdbool.h>
+#include <stdint.h>
 #include <stdlib.h>
 
 #include "../kselftest.h"
@@ -39,6 +40,7 @@ long cg_read_key_long(const char *cgroup, const char *control, const char *key);
 extern long cg_read_lc(const char *cgroup, const char *control);
 extern int cg_write(const char *cgroup, const char *control, char *buf);
 extern int cg_open(const char *cgroup, const char *control, int flags);
+extern uint64_t cg_get_id(const char *cgroup);
 int cg_write_numeric(const char *cgroup, const char *control, long value);
 extern int cg_run(const char *cgroup,
 		  int (*fn)(const char *cgroup, void *arg),
-- 
2.43.0


