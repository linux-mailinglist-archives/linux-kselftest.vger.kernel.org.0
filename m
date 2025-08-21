Return-Path: <linux-kselftest+bounces-39435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D77B2ECCD
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 06:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94F4A23739
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 04:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417BD2C2372;
	Thu, 21 Aug 2025 04:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v3Dw/nm7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE628F50F
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 04:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750568; cv=none; b=i+in3ySftAZkMO9PFUibnkqN+VurHA1Lxhe3Afk7lzvBSmJQ31CjFo2xrWxi0n9wvCzK4BePo0VTCBdcIG/ZVjLmwkd/K8/GRc74iX/D5N5lwI/F37GZb3Jb3h5d5U3aKe+an47TQ0XX/XNy6rFEjP697UfMNL8Vbtj3Ka7noUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750568; c=relaxed/simple;
	bh=CNyH3iLKYyXM2PucLKJJexKys2GtwF+RYJ7BGDIxHvI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qsJ10mOabrH8d7/8RUXoxMRIAxjtt3D/4M5CyFip3nsV3d4FEpVEBXiWJON48G+t5kjk5N8nCjLB2fEciUVl8R103g0ImlbjIRA2Sc5CkQ86wdvheYES0ZdgjSziVTBRiirDjtVuCan67vV+c5++6SOq0iYnCqhoFW4fCKcwj7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v3Dw/nm7; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326bf571bso1408991a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 21:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750566; x=1756355366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SBEsUjopqWPQAb2i5kfB0Dt1bw+I4tk4XbZtWvO+5Q0=;
        b=v3Dw/nm7XhpT2vIgkIS+HxkDU0KefU4c71Ml2M79+EhZW8l+R99SMV7nyzREXe8FR9
         dZGOKABFzriGUxoW2+Vg7g4z/DPgiL1YLkZjCKIBgKz6OZdx6dMf+kq90qCCUK2eoeHG
         O7NQR9Upxd8ZYBokBOevCTCo2cuzJBd+An3w8ntIZqwBqNfjrFxw9lOFaB1YJ/Bn45Ji
         rFQ89z1gRfEYesyeO3r2VKpk/mFU1xAW64uE29J08sdQY+VQMMTUX09juWdWgvJPN+l6
         cWGC2JOIPAcjJEWQKdHF279kJfoj3QQtjI9khoN6emTXHP4ZET7TqvKi0j8r/8eevl/V
         GFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750566; x=1756355366;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBEsUjopqWPQAb2i5kfB0Dt1bw+I4tk4XbZtWvO+5Q0=;
        b=nruMkFNLAXexsopRoSgMGykTpqh3sh5qsCgpluWDPiv5aVHBL1TcckwvyTDarauZUv
         IQPTysr4zf9OuwW+C/CWUX2vhQ5dlRzh2QcQk6WytJF1ZrbHPEeuY66hATGmXqb7BF+h
         /5XyjPVRaDQ9APyDSiCo6NZBT0o3OKMH11UrEn5/dk+39cbFfj55bSrjNWd6EvEPfGxr
         coZYkm/rBvmyZGPzdKruja7wNZ16q9qM/sJS9N9hS/TN6NEjUD54G54H3XvCyNuWa+x0
         BM1lY3KtNGYX+U7OuJm1vWJDpjWxXkdzsUCL9mRR8mFjGYprwfLgtgjWgBvnhYoMpy3P
         pmMA==
X-Gm-Message-State: AOJu0YyOgbRF4A4pRfsCsJJSFM7KlYoj2+fDdLIxIDog4sLGnWDIqy37
	Xr4EDaD/LRdDPQfIstd/3ZdAdvThu1qr0T8DAHRcu0tvrUz8mampdZtAE1FAQmattWdkKJ7gxlu
	BYW23xdLztWVZrop5d9+ydFlQsRFTf8PvUJJ/MhpXIBEVvvsPBH3qi22szSezBlhkKpPTkq9mBo
	Di+XvoCeRyCT9HQMwI3ZmpV+Lyq6kxd3fC1Hs+vRrDH/s=
X-Google-Smtp-Source: AGHT+IFYWwfWRedCl4TaEHt8DsZOpI9aKhsO1LVwtOPR4LokBo0OPUYbdS7T4gGWHlqrRzQ2RYeoQBN9pA==
X-Received: from pjbqx8.prod.google.com ([2002:a17:90b:3e48:b0:321:b354:6b5c])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53c7:b0:312:1ae9:152b
 with SMTP id 98e67ed59e1d1-324ed114c90mr1478574a91.23.1755750565556; Wed, 20
 Aug 2025 21:29:25 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:28:54 -0700
In-Reply-To: <20250821042915.3712925-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821042915.3712925-2-sagis@google.com>
Subject: [PATCH v9 01/19] KVM: selftests: Include overflow.h instead of
 redefining is_signed_type()
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Redefinition of is_signed_type() causes compilation warning for tests
which use kselftest_harness. Replace the definition with linux/overflow.h

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kselftest_harness.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2925e47db995..a580a0d33c65 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -56,6 +56,7 @@
 #include <asm/types.h>
 #include <ctype.h>
 #include <errno.h>
+#include <linux/overflow.h>
 #include <linux/unistd.h>
 #include <poll.h>
 #include <stdbool.h>
@@ -751,8 +752,6 @@
 	for (; _metadata->trigger; _metadata->trigger = \
 			__bail(_assert, _metadata))
 
-#define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
-
 #define __EXPECT(_expected, _expected_str, _seen, _seen_str, _t, _assert) do { \
 	/* Avoid multiple evaluation of the cases */ \
 	__typeof__(_expected) __exp = (_expected); \
-- 
2.51.0.rc1.193.gad69d77794-goog


