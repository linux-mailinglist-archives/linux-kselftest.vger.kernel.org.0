Return-Path: <linux-kselftest+bounces-9851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8624E8C166A
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12CED1F26EBD
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE6913AD1C;
	Thu,  9 May 2024 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qklWiiEC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3013AD06
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284928; cv=none; b=G7OWvVcgI30p8mmuOmq6N8w3lWuhjhcUkNJZnaueQUY6ZvWXCmAX9rM28DeCOnC0A3bPCJBFVtiPtn2h0p1kQEn33oaQ9+ahaeA53adHBulrK0FuDRvC5PJ1X911Ibiim3fiyOLfrT5OE47FjePXGlU8NXC8Ab80+OUk6GNm6e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284928; c=relaxed/simple;
	bh=MBnUBnXl3zEAj3vZOiUxTPCFOo3TWUaU8CdIxhIziDE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aGVRuscrhykYwOynqRCfy0attV7u+LUP1zfW9CfStnbSuSqn1HJ/jjK8SUhpEW4K3+y9/t2E+Cth5vE5uw8yRJpRtZ0L7rIRbPVfq7q+kPFGbRR10zRKuc8QqpImKc2yslyJ8KdCvQ0A1TqVdO6M9fugeaYQPJGzYoJQas1CzsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qklWiiEC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de615257412so2189605276.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284925; x=1715889725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/29eLalWXltsNx6hndyMfgq88NOnPPHN/xxraS+3xSI=;
        b=qklWiiEC0naT5JPU8cieXF0v0icyvd7q9dSVjoLZsm5oirBaJCP7H7m07D0/Ryxv/D
         xIhNFtPNZ6pno9aM6gnjA7XPrv3NZXLpWa4fMN5gEMDarj4CxvW0FcDsH9/EWQg+IWSg
         UI9Ibcn8UHXlbrk/diL0m6aes+ynSssmncOOuZFdu6VUstYGQoeBVUbdpbFgmsMCd40h
         Q/eaFl/U9FKrvP37CBPPvcqZmJZxweArSD0pJqFH234P28buvFst3nROme39ak6y58H1
         2N9XhnAPp9bhR9SMAKgEMcsNjGnlQTHWk8DVlyuMYsWlTyIFxcr/IwOVRk/iydd0KXRy
         qVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284925; x=1715889725;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/29eLalWXltsNx6hndyMfgq88NOnPPHN/xxraS+3xSI=;
        b=Bboj2pVLAr8xs7pwfKAYtxUxcr25G9rGf6h4R5UfGEDZVAprGRv7JvqCcTbNzE7EqA
         2pNiDA5oMZmjKjovOeWFU1J0RTZMRWI9+XTplJgFgLOswbjru4utM4Od77aRHcF6MiyY
         /2FgtCdT0M6FXwmndDGQtMtO7uIex43yV5xYBMCZx9d2GucWCUHVzqP46qbnvOHgqQWs
         uWzpsePHUTkJ/RWhnY462mQnJGsAg7zmaZhZnxGxiXT1g5SUJIpNOXkJnQTdONbCRwMO
         1CLFcuP36qrvUahgRYh1HajtlWL2a62akDVf0XEruE1OXDXuSYcb6m8RRerso07pW1qb
         89Tg==
X-Forwarded-Encrypted: i=1; AJvYcCU8qDuldRFtg6n9rRcUgFohxL0pmDf4MgXbj5g41CsiAlwoqRm60wO7dK9mLr/zjm9PbEzshu8jQOEQI0743tnHZ6CwiCqSvqG18NR4T2Df
X-Gm-Message-State: AOJu0YwHnU8OSCoVnBkGPnghua2IEPFeBo+gnhz1f8IQzfWFMIkVyFKW
	QLdfxyTTs+WwRvVFbbVIvXhAf0tin6+4n4mTnQWhQnl6Kx8yhWxY/2IDzP2R05hk/aC//d4I55z
	RFA==
X-Google-Smtp-Source: AGHT+IHvqhsF1a5vqVTCdhk4BVGmr9KgJSWsLeuEaufB/KOZhiCXbICCSASR6EHuCwVmjU5b5BugSo/1wyE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1027:b0:dcc:c57c:8873 with SMTP id
 3f1490d57ef6-dee4f3659c5mr141916276.9.1715284925582; Thu, 09 May 2024
 13:02:05 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:20 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-29-edliaw@google.com>
Subject: [PATCH v3 28/68] selftests/lsm: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Edward Liaw <edliaw@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/lsm/common.c                 | 2 --
 tools/testing/selftests/lsm/lsm_get_self_attr_test.c | 2 --
 tools/testing/selftests/lsm/lsm_list_modules_test.c  | 2 --
 tools/testing/selftests/lsm/lsm_set_self_attr_test.c | 2 --
 4 files changed, 8 deletions(-)

diff --git a/tools/testing/selftests/lsm/common.c b/tools/testing/selftests=
/lsm/common.c
index 9ad258912646..1b18aac570f1 100644
--- a/tools/testing/selftests/lsm/common.c
+++ b/tools/testing/selftests/lsm/common.c
@@ -4,8 +4,6 @@
  *
  * Copyright =C2=A9 2023 Casey Schaufler <casey@schaufler-ca.com>
  */
-
-#define _GNU_SOURCE
 #include <linux/lsm.h>
 #include <fcntl.h>
 #include <string.h>
diff --git a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c b/tools/t=
esting/selftests/lsm/lsm_get_self_attr_test.c
index df215e4aa63f..7465bde3f922 100644
--- a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
+++ b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
@@ -5,8 +5,6 @@
  *
  * Copyright =C2=A9 2022 Casey Schaufler <casey@schaufler-ca.com>
  */
-
-#define _GNU_SOURCE
 #include <linux/lsm.h>
 #include <fcntl.h>
 #include <string.h>
diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/te=
sting/selftests/lsm/lsm_list_modules_test.c
index 06d24d4679a6..a6b44e25c21f 100644
--- a/tools/testing/selftests/lsm/lsm_list_modules_test.c
+++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
@@ -5,8 +5,6 @@
  *
  * Copyright =C2=A9 2022 Casey Schaufler <casey@schaufler-ca.com>
  */
-
-#define _GNU_SOURCE
 #include <linux/lsm.h>
 #include <string.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c b/tools/t=
esting/selftests/lsm/lsm_set_self_attr_test.c
index 66dec47e3ca3..110c6a07e74c 100644
--- a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
+++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
@@ -5,8 +5,6 @@
  *
  * Copyright =C2=A9 2022 Casey Schaufler <casey@schaufler-ca.com>
  */
-
-#define _GNU_SOURCE
 #include <linux/lsm.h>
 #include <string.h>
 #include <stdio.h>
--=20
2.45.0.118.g7fe29c98d7-goog


