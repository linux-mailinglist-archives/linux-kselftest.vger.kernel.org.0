Return-Path: <linux-kselftest+bounces-12585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BE3915A89
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 01:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 091F6B21CD7
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 23:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B8D1AED4B;
	Mon, 24 Jun 2024 23:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RG9WOW92"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21581A2FCF
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 23:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271778; cv=none; b=X5r8EErtDHp9Vv9/KzrvVda8Xu9Ks4dyy2GuhAZ5vpOWYv1fLGnvpmln3VYa2wK5Qbdavg2cGAs+QaD0rVI+k5AJms5Ch5BA3cA5cDhUaiFuWWpDf/9gzYz3UO1T3Intme6foWOnelpSF4sNL5Q7fTqFiJhy8Z4mpDYDezpd2lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271778; c=relaxed/simple;
	bh=CSHVkY0x8U1pXoBBLz646/d7/XSIXGdSs1WvRtCcMQw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GGTSyMCQEcJrb/jQRR3JwYYDV6g7NDws+7wVYbcCN+w0lrmCnxw1+APp58IJGVkaoM7D8dVm4dW8/9/XzK9M89wcvT44t1+uGenxr1b69F+AGPrWmqtz2JIsB+ZMbGYmj4tbLnQXKelYVdN3r4pOTObK9pTLEtTM/8CMfgizeCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RG9WOW92; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6e3341c8865so6341078a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 16:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271776; x=1719876576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eCJX8+VvSnRphReKqOD6AqEhzLc1OgPwFHKFgJpo/3s=;
        b=RG9WOW92CuOu08kdU6IQmRn3UJQkiUWW/qy4NqcjdCAGTb2rNVNJBKX326BsRwC+lF
         iqyLghdY7NQVuI8aILR4YwBy696LQ/LOU5FUOIG08BKwz0delqqX5CBvyJx4npq6+ImO
         O7YW98/VDg2iwZhhcuIYB0UQP7MBsad/TlHLnbd9tStqMUBZh23So7udddzcGpdAvFPo
         MLL7Nx95I+0rkQhzGsVqDlgQ0qBHfMZJByOgHed2f43fEOhyH+/v6d6wVyYZsqUFQqzg
         pSHw3pxQNnUfV0mch1/1Sz5pFycYewxQMVPEgYMqFgNXeLcO5cp76OqEvY5HHA4bjwds
         wfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271776; x=1719876576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCJX8+VvSnRphReKqOD6AqEhzLc1OgPwFHKFgJpo/3s=;
        b=WJo38iOEbQs6HifToX3hi0lEblFS9uKG/hF6PWlOvAYfZcCLV+l0/BCtIr1WBAagJA
         c+Y8EZD2wwi9bqyvoQzsawbpyEYJDAp5l4n0FPv18EECxNLSSNHLBH7o8OONaxBWOOqp
         lvDcK9QIKtX1BTtqLlKS8nO0eQay7dlw0umlOm0hAD+9gg6XZGHUocOQcZCviGL71OmF
         KZoyaY5xMlacQBLfpit4q/ghuqhdvuHWmMB+7TsmPmH8LqGj7ynFQabpqjhhHDJPKSWh
         eWZjznh809pSrNni0w6mSEX3oURGJDZNQvdJ4f87FwVYdTmAZiQIp8DPmx3UwJJAa58q
         nKJA==
X-Gm-Message-State: AOJu0YyUbKAWucMFV+/tW7xxrGanQSEUADYzezEK9sZowYJ/Bnb2zu7W
	T5ztAX0YQSlEsuRe1VtxSq9agp+a7XkJN6OB8dEmQVdXciXok04ucxqoAxopM6Fn2TGyPDLTzJC
	CqOJ+G4Tc7SKVfF1u4UnS5K7T/ntnEqYfx+QFg/5uPadcBxexBEyyLM+tcf763pUFKw5NjeCbWQ
	g37X7rb/wBTmvM/Yspt03dDBEMKonADbFsLTTRH8qKRVTs
X-Google-Smtp-Source: AGHT+IFjD4+usXw1SHxX9b7ePdUBbw8ZgCP2CzCr9wFCk6wJU6Q5+R81P4uygwELRit2itW6ZnfR1hiEObg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a02:91b:b0:710:c65a:7e55 with SMTP id
 41be03b00d2f7-71a35642c51mr18906a12.1.1719271775000; Mon, 24 Jun 2024
 16:29:35 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:16 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-8-edliaw@google.com>
Subject: [PATCH v6 07/13] selftests/iommu: Drop redundant -D_GNU_SOURCE CFLAGS
 in Makefile
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, usama.anjum@collabora.com, seanjc@google.com, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sgx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE= will be provided by lib.mk CFLAGS, so -D_GNU_SOURCE
should be dropped to prevent redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/iommu/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
index 32c5fdfd0eef..fd6477911f24 100644
--- a/tools/testing/selftests/iommu/Makefile
+++ b/tools/testing/selftests/iommu/Makefile
@@ -2,8 +2,6 @@
 CFLAGS += -Wall -O2 -Wno-unused-function
 CFLAGS += $(KHDR_INCLUDES)
 
-CFLAGS += -D_GNU_SOURCE
-
 TEST_GEN_PROGS :=
 TEST_GEN_PROGS += iommufd
 TEST_GEN_PROGS += iommufd_fail_nth
-- 
2.45.2.741.gdbec12cfda-goog


