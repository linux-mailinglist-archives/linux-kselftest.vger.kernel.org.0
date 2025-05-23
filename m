Return-Path: <linux-kselftest+bounces-33705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E13A6AC2C38
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6052B1C06C49
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3AE21CA1F;
	Fri, 23 May 2025 23:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z3qLNnRZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6A521D58F
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043045; cv=none; b=UAFtJFoo4Tmyp8Ki093cxECPai9n1GBaGOBe6lzn7+Mml6QZeh3/SUpYUmJ9FWxt7QrT19JOReKGD4tD7ovRrT7ZPBrpMcRiAgU1ksW4I5wX8fGaioFMXiMwP5n4fit9ysOQZz9FQx5beQbq3ZKlpmnXs/mNhI5PijjlVUu9Qko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043045; c=relaxed/simple;
	bh=yS8geeqjAUls9UiEIvDEsZ7tIg4douCZvryUO6q26k8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IDv5L4h7WrsQYeaZug4xviaXTSvB/KNfdSRPQiLkxwD6fSMrOkfJo8T8DeGr0vfMpfyLKh4IjQ5dXgafYT4SeChRt+45JGOu/8VxUOmf+DGazEGLkeY/wbNlBpOz5LWQOgiWlkncDQt8GU3blQjiqXtf5+Z2sfLpzfm1ibqxavA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z3qLNnRZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30ebf91d150so547938a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043043; x=1748647843; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I9ZBqtvM1a+IA6geHqKdkRcQxTFXplx9jl6g2ELrQv4=;
        b=z3qLNnRZTEM+KVAMEyAkFbyOhTFQXPt4trMh4jOw7SMzeX3NGLt+FCBs6SN5Fh/8Xx
         kZkxHbzFjjPlOovzLZYiFYIfbaTfP0YiXTrGTpquFHXmYZfXerz2OSgMgOsDfNaNDX+E
         q4sen513cU2iL/L2F3g00m5EOqTS3bgYZPwRyxBEsHwTP1UE7/+GgZKGDdcTBpnv3rUg
         mGdaNlan4i0UenXH1msijmD9iJkBtyVBKNCFlQN/+67wQIjNb7psdyBcRZVvGsU3k4DN
         NDsplZRJrfJ0jno+jnjK01PRKejQc8e6k+3+86N0FObh4OpIxYwF9eyXZgeAvfM7DQdm
         qQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043043; x=1748647843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9ZBqtvM1a+IA6geHqKdkRcQxTFXplx9jl6g2ELrQv4=;
        b=szqXeWuyqZHePG7qQHH1yjTiyj16rPwjQec5TD/n5IJkVZWjWX0VG+GU4FRZzLUQ6G
         4xIGXGXwzF4u6f+cKNmt5TWmaaIOHu/itSu4rlWixa/UWBc7G4pLdOZ9bypCXbFcX6uX
         oGhUosg5LtBkhGZ/5+BrViSE1wAGFW3nS/BBvEQ2fyPEl5hh4fZVmS9npHo66NcH/Zwf
         6iXmR5999JIRGi0wV9dc0SKZWiyHuzpgywSZ9/1CHDejqG2nXb2EB+uZE5DYkLlRc0y6
         1ueev3LDrgNnlA8OYniC1RJWsrSuFWM1qjxbi2yZsQCnlw/f9SoE6d80uggpD7nQZfCF
         M8vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOqoodHjw54gg61HFJE34PvBWWrT5M0J3Gjkfi8iWn1JGNzj6EqAaAd3iVYMbCnTPRZQ9W4Uko1MjdtqnpGxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YygpdtOKww+2KeLpqfxSf2FnG1sOyVpQD426ct0QZG1BCFN54eW
	iSmNHEoH293rlceg6IRT+ffRTpTYPuJ72ox+1Yl+z7bE52rJxO46+9yv/u/YZJr95y0WhyiuRHt
	c3eCZykIxRWFhuA==
X-Google-Smtp-Source: AGHT+IFuhaighmM5rbtJX90BYn6ywhpqCWSktMhRSkKEnzlRxIqBZQ88WOm3xXBf6Fevs9snK/xotR61OUtxnA==
X-Received: from pjbsr13.prod.google.com ([2002:a17:90b:4e8d:b0:301:a339:b558])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:48cc:b0:30e:37be:698d with SMTP id 98e67ed59e1d1-3110f72e206mr1183238a91.31.1748043042952;
 Fri, 23 May 2025 16:30:42 -0700 (PDT)
Date: Fri, 23 May 2025 23:29:54 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-10-dmatlack@google.com>
Subject: [RFC PATCH 09/33] tools headers: Add stub definition for __iomem
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Matlack <dmatlack@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghua.yu@intel.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, WangYuli <wangyuli@uniontech.com>, 
	Sean Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add an empty definition for __iomem so that kernel headers that use
__iomem can be imported into tools/include/ with less modifications.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/include/linux/compiler.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 9c05a59f0184..df503ed8e038 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -116,6 +116,10 @@
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
2.49.0.1151.ga128411c76-goog


