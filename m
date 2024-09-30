Return-Path: <linux-kselftest+bounces-18624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C0A98A2B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D98281F48
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E379018EFD0;
	Mon, 30 Sep 2024 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zo/RAEUq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3464218C00E;
	Mon, 30 Sep 2024 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699833; cv=none; b=J6y299Mpc0LJyu9EOAny0Gt+p+dLS1wmqRSVWI+r8KU4W36aApGSh/D9uQVQzX7z1W6s3YzlmRPCBNIXC/d38iDUliwutqZ9Zz4Me4e1/SDKUAnEBl8xLxKrAE4F07gygbhIeSrnh1MyNiR8r5xVUwIvcrKDv0UFycGrbRgomz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699833; c=relaxed/simple;
	bh=+MnBeiIsP/XGlyzRSDY2a7cwuf9hMtkLjixwEJrGWIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMNSL1QC8ePNI+r/wU6WTakgDCYFLOMRlcnPYQhLKr9hh3p96ZEJldy/3JTvneZETd//eM6pAt0oIbxE6CN2gaAZAn16f9wUe5irLNNZ3ED0D12AbAx3d9s0hUK1YLQa/bUSAIUmAi0Sey2IFPEwp0ZLGOQFYeCSCfCswDaDEXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zo/RAEUq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so34920575e9.0;
        Mon, 30 Sep 2024 05:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727699830; x=1728304630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRI6G1zgxxf6ByUGqs3lmNwTcdt012WbdG6WrxIrfn4=;
        b=Zo/RAEUqEgZm4xp4jtSbvHqFvSLOgMvzrr9a+8AtVsz6lP0LVMRnmJ3VPkog9NkiAB
         /gT3eaxf7Lf37eokp/ukxharcnqxAvtvIpA1eBZIOJ9kr4fOLDwPz388pypcAPLm5LuY
         SPWcLt+fKbampIe3TuPQhgMXSmRKzejvPcwjq4wmu/7FypLk05Z6Cj6Ly/663uB5s9cf
         IU59jTAPwzI+cuClqlI1IToF3n+nrV+zaavTf2oRU83mEmrdhXKcZGi6Qp5iHITEh5mh
         /LDMa0Sit45ZhNVGMRhreHldQEzW6vxbvzHcINfYN/6MagE+LLpy0EqTTivWzYCYwtfR
         TLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699830; x=1728304630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRI6G1zgxxf6ByUGqs3lmNwTcdt012WbdG6WrxIrfn4=;
        b=vhwuE44ueKIOOIqg2IWH63hFSuffaIbI2lVg8xRlEXcC0QxbNrZU07OQQzvVPJshTv
         fd44p7lMOhR+4meVL2+OVZdlcaOfBK6iU1y0lTEW628ORxYjmGEHHeK+6R59EJARGSGa
         4wGmZOIJRsWvjLsNfBNBbnB6MT/IzSIxGo5SCiBCCPyhxyAHkIZDL1bzPRLeyTSGTwnQ
         DZOqxfZr9+fXz+BNXCmXDfOPlO9/10J3vkxSrimosL4aXyaCXsNB9nW4xKyHMcHbeo/W
         kgHJ3p+CjkKSnz8+ghI+rY1aT5y30vdUpU/ckI5Jbkyp1aKnuE1zjMHXvG7/Cf5IDnN1
         BV0g==
X-Forwarded-Encrypted: i=1; AJvYcCUQjaxvi7DdwC6g7zmmwE71KywWPrpfMLH2Thmp9IsauwLDQiDMlRjSOYjjqoGTIBbbq6PbXs5qEnUxzEY1@vger.kernel.org, AJvYcCUY8TxNHVjxUds2CHwD0waamwRXwmQsaXc390KBmTIWKAHfaEkNLhMfnBQ8kn+Rm6XDqHbPmvdjA89AH2aG@vger.kernel.org, AJvYcCUg7+X9PFDCuQU1bA5rgn9nNtbS0+YSXDpI5Xr/5aUMENWpAGlFV8CdHj2whdqZa+uNGINmmiwsGmiHmt0Npg==@vger.kernel.org, AJvYcCVePECb0nJkrRaDIw+rMyx4RV7iab1sXk0VYdomnVELRxufpXDkyhf8KUw9s1Qyohq0nAhKS7hk6WxFJ9bqb6oe@vger.kernel.org, AJvYcCWyr5/zMi/mM2DkZOd3R6PkxGbhU13gY8jfsPLhdhXZxgLqhZD+p9FUYTfcsT8NmwXpObI=@vger.kernel.org, AJvYcCXTyv2v+r5gWq0tPB7SX2ZtuuVw+496OUAEFKFl7bd8joMtVkxgcduk/rJvQZo93nAdY531NYpYNdyaUA==@vger.kernel.org, AJvYcCXuOfBQQ1fLXx0o13SrGQaP7MFdXl/Ti7MElpDO6FSKR3nDiENL89qsnK/psWiF2jXCdTo9F3XrzO6HRl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoLP5r9INXPLnkWkWO5T9s1IrM6EWC4I4RNTBsq4XV1LLraHyD
	SZyKZhtV6/NoiScrPVK8GDYHy0DhiENpfM4dU96tY3saUVuh/caB
X-Google-Smtp-Source: AGHT+IFu5Oiwuj+i68aKGbWWitLMicT3QOqH4yvr2CkBBlw3Y4l78E7VTBxoGWeYODKBQH4FUNaUOw==
X-Received: by 2002:a05:600c:3b17:b0:426:50e1:ea6e with SMTP id 5b1f17b1804b1-42f5844c301mr92255225e9.18.1727699830327;
        Mon, 30 Sep 2024 05:37:10 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a52308sm149011355e9.43.2024.09.30.05.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:37:09 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 01/19] x86/kaslr: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon, 30 Sep 2024 14:33:12 +0200
Message-ID: <20240930123702.803617-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930123702.803617-1-ubizjak@gmail.com>
References: <20240930123702.803617-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Substitute the inclusion of <linux/random.h> header with
<linux/prandom.h> to allow the removal of legacy inclusion
of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/mm/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 230f1dee4f09..e17e6e27b7ec 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -22,7 +22,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/memblock.h>
 #include <linux/pgtable.h>
 
-- 
2.46.2


