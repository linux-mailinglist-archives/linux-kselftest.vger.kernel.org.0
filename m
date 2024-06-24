Return-Path: <linux-kselftest+bounces-12586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 780A4915A8F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 01:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40351F22FCF
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 23:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4E61B3F15;
	Mon, 24 Jun 2024 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O4dsoSOj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59A21A2FDB
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271783; cv=none; b=b6mhYzcL/4Gk/DkuZ8aoygh4idNdiy48xH2rQAazLIHfRorjil3piQNXFlzkQp7gR9O34kIBRcITkXv6YVhdPz+j9L0szlmkBENDIFF3Vl2eTja1vl70URGet9Ss0d/006jZBP8MGOQ3Ggodd8ApyBZRFM+9GNnTtZHZvUtBKS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271783; c=relaxed/simple;
	bh=Vn2wAzsGFTLvBvD15AbUZj/MnMw/n9DKUySpFM3EEW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CsJHowuSgoBj9WQTZmcJ8La0ihaFKZ1tQE8ZGKA9tDfYyDTzf9vd9yYE30+zPIPjUBRU3EGt6dbvbpqpTHozYq4gaN7xDT8zc+A9aF2VUoBOHOHPWQYFtRlqwigehiMzvk7JiNjJdgCDdD0roYXVEZndqKWwtEg2YgIQujdyfnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O4dsoSOj; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-706694428e3so1770641b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 16:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271782; x=1719876582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QrZ+5Kk2oEbgMtgXaDgXkxLOd4phuQ+pRNBukp2bFkg=;
        b=O4dsoSOjpyiHFcciSmYjD8wUNpeXnEs8YzqzrRhRTW9+hxzktaHrxPNp2H2kPj3+Jp
         s7n1lOZ10pfSgkaaCzxbd8oos7b4piw6DQJPMeNa19FPQnfRK9rL36H3tFS8ON7WJd4O
         eUeD2EYGGgbywgpWrKa0369WylRPMX/pzPwY52ehzPFXSt/wWe2ug0U43Dw4PfMb/6Fi
         5r3WZ36igtDS8+AM8/dQkHUXtuo3pcrpf2iwbnCc/rmHaaRNK+R/Sfhqqibx1KHbeP4M
         FFJl3R1NxTGD+Iy2l1SWPczd0Rx3Z0+jy+D2cqUAdbFRl/KRC1ppp6nlBJgdyd/ryNO9
         jv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271782; x=1719876582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrZ+5Kk2oEbgMtgXaDgXkxLOd4phuQ+pRNBukp2bFkg=;
        b=imKiJOMY+wOpZAf8oQX4SBRswxZlNJ3Jb2lCyw7zOXLENE4xfPkjjWr0XO3I54e3vi
         LdZLMKXhrCKaHUlij9BSFc/qJUH+4XZP5TEzXP7Am55HNNvFBe6Mc/LDue2z4+tuHqjy
         D7/KPLX7Xzdlbu+UWsinmooGf5ncb+0+f6iTDbTMNKgQBx4HVxHlYahuHrn2wE6deoHE
         RWF2gWr1YmNuXluzFfdjn0s/Rjg2ZODb6UeFwUegsfaRlJ/So202BSy1Qt6hnRlOLo/C
         0FX3mV3QJZ1cBpMbHUzw1WfmzKBNq3YCoaGbz3LaI727XvdjBoAZobwTB1TAqemtVrS7
         hSkg==
X-Gm-Message-State: AOJu0YzcVMGenxfezufJTDLmduXM7A3dQ7uTXmnSilXko0ogHdWjrq0z
	w+3wznB7bT45DHSMdyCVTSF4Wyd4KWuQPKCUJmbmz4WsYkrEvl3FOOe3pEZJyKVWbVjnBzDtLB5
	Zi35VQsinh6B3qqEEegx4YbYIzEYIxhMMPoHVklbzP415xUoPexdAYjAkrQKZClzdFz2H3dGqE3
	U2J6iiXD340hecv93zODVz2t+umV7UKbYYiG8Q4jIGa+Sf
X-Google-Smtp-Source: AGHT+IHpQrIc85Iwvne/JtUL74k7CtaEnEbXK9UND6RiBewc+A4BXz2SYDvXCOVunV74/hhFEZKy/c23brg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:4309:b0:705:d750:83dd with SMTP id
 d2e1a72fcca58-70669e5e132mr244774b3a.0.1719271780764; Mon, 24 Jun 2024
 16:29:40 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:17 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-9-edliaw@google.com>
Subject: [PATCH v6 08/13] selftests/kvm: Drop redundant -D_GNU_SOURCE CFLAGS
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
 tools/testing/selftests/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index ac280dcba996..4ee37abf70ff 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -231,7 +231,7 @@ LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
 endif
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-Wno-gnu-variable-sized-type-not-at-end -MD -MP -DCONFIG_64BIT \
-	-D_GNU_SOURCE -fno-builtin-memcmp -fno-builtin-memcpy \
+	-fno-builtin-memcmp -fno-builtin-memcpy \
 	-fno-builtin-memset -fno-builtin-strnlen \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
-- 
2.45.2.741.gdbec12cfda-goog


