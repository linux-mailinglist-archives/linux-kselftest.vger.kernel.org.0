Return-Path: <linux-kselftest+bounces-10488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE828CB6F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 02:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C2DDB23592
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 00:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277A46139;
	Wed, 22 May 2024 00:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nfBM09op"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C4E4A1C
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 00:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339571; cv=none; b=XHmyQZrPJmt64Jz0WcUvM5YXh6exmr3IW2ei6I6XHWWYRfjVOZZXF+qE6RORWyKaoNIYqOu9qVrpxciloqTwaPJfZo3yV6MLxpTrXhfLO3k8C0SEolzzJzGPpT0Yr/iYLm1EPOUU+gSLZWjfV4iJMYLu4jzD3NqVTMQiOERS1ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339571; c=relaxed/simple;
	bh=aZVHm0DBgwBFcctm+iRf2rlUq1vypMjcU0HhukUAAQo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l95LUhgjhHIvEsPMo3+DidDdUQMJmsedhR1Cy8N5Soh6477XcLAlGyECM2bY/UGb7JJ+VJ9jp/7QT8SP26XEeF3vWL7P3IYsA4vOMswXSWV7Rjj+tFfdS9k7bEB5vdXBPaWK4phmtz1wfXb5PxbAW5PPHtfg8LLnLXd1nC8Nnz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nfBM09op; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df4dfceec00so539325276.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 17:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339568; x=1716944368; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iZfRAHT6JEYkQgkQi9RSt0VBBFkg9g20KHoFp+lD64Q=;
        b=nfBM09opQPdrL1s6/+dgUWVw8LeegKq2F0gVdFOSAWybIZJIs8PRtHEqiTI7fY8V4p
         wKqQ0va/ZuP9rGE/l4rjXu4jWr3gm4gRNBomU3kbvpcFahQIwkg/l9dXwIVX8n+gB0VJ
         fDUiiIvdPCYqoYE2JKuvCJl35HDNsqb5I9FVmgqBtxDbmt5W9AGKTsuNdghwXKNoR9EH
         9AymOOgbdy5Ufsol9iT+z/XlkPQgRTtS8B38TGRbGY2OxLtKHiEGyI6LFZ+qPGlYrctO
         u4nddiqrGUfdYEJkgKBYOF0XcBv5oFNCxOrOrTQjFbKaH8lzyixxYFDdc7EHMn89r5KK
         epVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339568; x=1716944368;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZfRAHT6JEYkQgkQi9RSt0VBBFkg9g20KHoFp+lD64Q=;
        b=aU2o2xc9MEKH3vqmXHXcnSXCU40/4l1Xi996KQE+R2jIZqTO6x+AC4viZTiAELu+GF
         xiLI2KD8DJxCFBVajdbDX25pAQPXPUSKKP3fuBrUdzShXR0wBYC+5RA2qXDGNK0U91AP
         AtFjHN97FA/NjCH8IFseGGvOyM7PraYRjCEtTLNM76Cj4DKSARwrRz3fYa2wQkjFX3bP
         Ld1uBg05kY7bHK98a7FXHuwjq42aqK/nZR1d+4CosTKWwiiAgU0dZsgYNF/4BytLB4J4
         fyN5Ykh8B2QD0GzX+rxz9ai/wg67M/st+7zed9QgRglw7+9bTgX6WztyA8ZxBr9DSDRb
         EzLw==
X-Forwarded-Encrypted: i=1; AJvYcCX3yxbBJOkYS7rw23mEhn4AIRJwqpRGZrhoA6GRHiDzFT9613M06cz4AwS7rxOI0LjSwo1SWMBoy/PrisX9CZGjE+/n9XzFY9/v3+Q6bHj9
X-Gm-Message-State: AOJu0YzJXjEigpzgJ4C1PsYJlWY2sCeVvUqQc8raZDApGVaOtfaKZlBp
	IZqCFUWLOzP2uok/hh5DjbkHeU+hXJra7zrr/EoFa4KrZclhNnceCG/oXoOQaw+cWr550XQJLRP
	0yA==
X-Google-Smtp-Source: AGHT+IGHXu+2VGmFaeast6zhMZ19NE5/92wXoClK1c06+eobhw7P/LEdr5T/7eLijAwtdqou/skFpj5TJBE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:70a:b0:df4:628c:3045 with SMTP id
 3f1490d57ef6-df4e0e130ebmr75748276.8.1716339568433; Tue, 21 May 2024 17:59:28
 -0700 (PDT)
Date: Wed, 22 May 2024 00:56:47 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-2-edliaw@google.com>
Subject: [PATCH v5 01/68] selftests: Compile with -D_GNU_SOURCE when including lib.mk
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

lib.mk will add -D_GNU_SOURCE to CFLAGS by default.  This will make it
unnecessary to add #define _GNU_SOURCE in the source code.

Suggested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/lib.mk | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 429535816dbd..e782f4c96aee 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -188,6 +188,9 @@ endef
 clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
 	$(CLEAN)
 
+# Build with _GNU_SOURCE by default
+CFLAGS += -D_GNU_SOURCE
+
 # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
 # make USERCFLAGS=-Werror USERLDFLAGS=-static
 CFLAGS += $(USERCFLAGS)
-- 
2.45.1.288.g0e0cd299f1-goog


