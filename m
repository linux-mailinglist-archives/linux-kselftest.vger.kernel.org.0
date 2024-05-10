Return-Path: <linux-kselftest+bounces-9968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258838C1B6F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81CD9B2233B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA8713E04F;
	Fri, 10 May 2024 00:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cEPIyq+z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5294013E034
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299910; cv=none; b=ByVQZKnoECptxc3DD/SyCYzlFsdAFKMwAq3Dw6ccSpj83bafzzFneAZTlJCvOjWi3TG7ATjgQg5nSio9StgwH2zKV4uQcS1KmEJpnjpBTAS34JN1B+iCw/cPM6wRe5pltAKt1Nfsqmq2fIYHN1LUwyz5Q8t9ZWJ7brAQ9S4fE+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299910; c=relaxed/simple;
	bh=RSI/JrDkqeLiFXbwGZXmlplREYE9MXWOTM+xIBMUD/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ca1A/tpK/ig2rBu8rjR5BxQe4D/lCjNJR28BjfKyQfDhwJJXUknFzT1hXiW3szB+Q0/RSqYXlGMMPgCuWBaVNSX9V44f1FlJ5QSBW5soppwqATGKnqvl2FSA4KmqzMtvM+/FMi0VlH2ZrCtPdnsJuAZkshQcIbxrMdqs0CJ0du8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cEPIyq+z; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so2009528276.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 17:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299908; x=1715904708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GO1gcoPElveUSPvl43PtsRVjcacyZcZsNQYTuVuo160=;
        b=cEPIyq+z778gY3NHPMSB53kuYDT60IfQ5i+6Y+mHRJF0u4VfuYZZol4oiUQIeE4EfB
         MPldSRUBGd9mjoruDzOGo07j22I6zbNpEJaelnEtOpsEJhQE6JYPUt7VWygEoEfY1+8E
         H129w04PxpBdSjq0JHZpT56A91qhIPI2y5p2NiNDCyEa7zUkqxbehoG+vIAmIIZdMdCF
         IrSdyDCVialv7mcpUelVzm75hgIiRpJNwIrRDTnw0EbajtPDNKHzyIFqSHzuhu5KGe+d
         B/baRb7zUJdDLMQEyJTj0BsMsG+0MTXRUBef8ep9DYIaXFpBVp+c6qmoC2ptO2Zpo4qK
         cRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299908; x=1715904708;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GO1gcoPElveUSPvl43PtsRVjcacyZcZsNQYTuVuo160=;
        b=Wk9n8Uend0H00Bh/gNjqYd4vrKsHZOhlDtn77f5JUxvMo3WWB5rAAmaXI8xpxNz5vT
         2tQv+9d8ApgJ/aTthcTCkKOy1saYQWHrAJs4fPi6Yo4DwMDRV0lE8jxkqu5LHCMSP/2V
         RXKzQVqj3cqBz/5tv2Qs+hNTFJOgDSaIzD7x0QLX8rF42kJP/rtY/FSm45KgExlejWYP
         jCwY2Tb93y+0CXHcN1dMBQ0FtwQs9qYPPAWUVpJh3E/EtM5S+Ai2FxEhOqH+fPLWDY6Y
         Gf7o7EcWDWvnkJge1PHB8i4I3E9y+mk6f7ro+7wI7RY9BuXzLvAP0kfiQ0PyP3dNCmxK
         kw5g==
X-Forwarded-Encrypted: i=1; AJvYcCVhou4EhQcbUQCahZWPg3usjDT8n78mvCJJRP8tEzZ/ukCDHS3zOf9A8rUBBv5OpvIV4UdbHkRfiIFs44A5vPC2C7r/IZosftyEPPKs5VxS
X-Gm-Message-State: AOJu0Yytq5HSF1ImKDJlG17VeenJeDfMf23I5Q7xr60u9BNsKMURLeDQ
	RkJt69jF/y3jDmeVXazc/LLsFRDAgrSRo6k8jsnLRdR3fMqci+DpE+1U6caFxk+on/O7jr8nJyp
	k1g==
X-Google-Smtp-Source: AGHT+IFqVM7jCc9e9vcxx6yDQfRIV94q7wlSc89OLSLIs1UwhsdSZiFockGfx7o6DTxJG5odCLelmrAmBDU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:1982:0:b0:dcd:2f3e:4d18 with SMTP id
 3f1490d57ef6-dee4f364f84mr105630276.12.1715299908304; Thu, 09 May 2024
 17:11:48 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:14 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-58-edliaw@google.com>
Subject: [PATCH v4 57/66] selftests/splice: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/splice/default_file_splice_read.c | 1 -
 tools/testing/selftests/splice/splice_read.c              | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/splice/default_file_splice_read.c b/tools/testing/selftests/splice/default_file_splice_read.c
index a3c6e5672e09..a46c5ffb573d 100644
--- a/tools/testing/selftests/splice/default_file_splice_read.c
+++ b/tools/testing/selftests/splice/default_file_splice_read.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <fcntl.h>
 
 int main(int argc, char **argv)
diff --git a/tools/testing/selftests/splice/splice_read.c b/tools/testing/selftests/splice/splice_read.c
index 46dae6a25cfb..418a03837938 100644
--- a/tools/testing/selftests/splice/splice_read.c
+++ b/tools/testing/selftests/splice/splice_read.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
-- 
2.45.0.118.g7fe29c98d7-goog


