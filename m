Return-Path: <linux-kselftest+bounces-35503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B025AE2623
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D227A7AFDE7
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E554A248F41;
	Fri, 20 Jun 2025 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v5KhJG/b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7426B242D6B
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 23:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461678; cv=none; b=LBlYdn83wQLoIcHKpyKXXMWWFlmnhR04220B9ATYDtCs+dkIju1zxu5uwDv2kZJROTo/0xRIkcgU8ZohrqXMCtmRuIGjVEm/JC6Y7sNr6281CHTCPn7eTJrwnNAF8vjl8MHRBNqck8uLusTI3Owz3XaRz6gZDYWV2wJ25LEx6QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461678; c=relaxed/simple;
	bh=GCECazfby9C7Sfo4AIvrRW5D6g28njFUtXYSv94ZK6E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CRNGCttWevafnsqDQJPcjG5T5zC4OKOCesXGKHS5sZUz9hboyUyP2WgGvJ1X7Eo8szILxqTOA7tktZfPNkU5zbXPkoZQbXgjy7ZIgRIGY86TPSsJ1VV7xQCCflsapvFBTKAbO0lg/Knvzdz7bkQXIaKWOpZppzrCYUEV3eNb1Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v5KhJG/b; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3138e65efe2so2001740a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 16:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461677; x=1751066477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PvClDGTsV0nVxKJRC5mJjifd6UvnizVaVJrdNpMJ3Oo=;
        b=v5KhJG/bsZTVW9B+SnNl1JLeE+1rTQl+B8bwqcZj1+cy6ZvkpwXcBT4uWdyXrOI8X9
         9WFEJgKDuCxzM8om4gsYmaR1WgZ9BvTySAUpuHLRci+FOVjV177y3fE9+2fYyEcFqt67
         Wydu5PYbZx7m7bfJWsB+l5x6MCbNZ0ui50MY8w2vMPVi+8kCGYpEH6BzkbHgrSKXkbYe
         3/pnWCJp6Rz5BPitQNlpfEgR+/eLdd5Z/1BVq35hORDlTOv5EX22e18/2I/BkPiVV18y
         OsTZ58I8zFNzzmrQzPQ++JwF8yxfcMqFcHyuiVuP7K/K3CEDXzT5XCp1gmKEAbxP4UBF
         O8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461677; x=1751066477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvClDGTsV0nVxKJRC5mJjifd6UvnizVaVJrdNpMJ3Oo=;
        b=akG9NN1h3ikmnC/yep1z2Yy282SaT/sG5ErU0OhWaQ3fRQjQwmuyi2ygtA6/xILKQu
         x8MJP/NQV1gVKWeojCAe5aSdsSHfz52rHPNKekmDklUjNxC7pAlZ6oecOtqahaueWN6l
         sPd/n2jZSgr45QQDTyTm0FIYZWiJ2u+dyJQj0L2UUIs1BBfdvu34Li9u/lZM24CiFaUe
         +G7WHJJHHwd3xYuAXbmda/p6NqbOwRqsfYrQyCykIT45IpyKv6d6kMHfTHCjL6KSypio
         C+/U1vv6wKI4GEyqaJvH6YCxbhlzC22hy59LtiovUwLO17q8NI8nSNcc7Qz46L9oruZ2
         EFWA==
X-Forwarded-Encrypted: i=1; AJvYcCVGxD2JDS1/ZDEUlBqCeQWTr52wO0z/mEVtJ6SGSZJZ5mRP/wENTEAhTUF3T2H/jfAT7C4QuLl5WuKOCWSNCQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBwijqRNUioXujg4erQEne+Rde27SbBKmjd0JXrLM2fWZDzHmM
	rVHbyH00Ga5FGhvW2k/wE3TvxtHOvChcLFalhzsVlSwApLNlZbaJ1eBAvgxEtenDQ9jvj9m7JKD
	TPQscjLqcDANefw==
X-Google-Smtp-Source: AGHT+IESBx6jlke0ktMNRQti3tZH62mCQ+ym4g2KsoZFQe4jIm6qAxSgXKPHUbhbtRcB9Ib2saZy4ww6bNCBlQ==
X-Received: from pjj15.prod.google.com ([2002:a17:90b:554f:b0:312:14e5:174b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:57ec:b0:312:1b53:5e98 with SMTP id 98e67ed59e1d1-3159d9116f1mr5879971a91.34.1750461676802;
 Fri, 20 Jun 2025 16:21:16 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:07 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-10-dmatlack@google.com>
Subject: [PATCH 09/33] tools headers: Add stub definition for __iomem
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Wei Yang <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add an empty definition for __iomem so that kernel headers that use
__iomem can be imported into tools/include/ with less modifications.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/include/linux/compiler.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index d627e66a04a6..bebed7b06b91 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -138,6 +138,10 @@
 # define __force
 #endif
 
+#ifndef __iomem
+# define __iomem
+#endif
+
 #ifndef __weak
 # define __weak			__attribute__((weak))
 #endif
-- 
2.50.0.rc2.701.gf1e915cc24-goog


