Return-Path: <linux-kselftest+bounces-28786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2C1A5D3B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 01:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1EEC175491
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 00:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4E78634C;
	Wed, 12 Mar 2025 00:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CXH1yE2/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5C54CB5B
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 00:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741738889; cv=none; b=k7aUMYtl19wB0DHZg/bdGCeZr9W3+t7nH9QuawsGjUwdugx9Ui9MN5Ywft4+gtmEjkWxb2t488EUre/OVigs5htAbU6vAUtpWoQjPTmaDQ3ubVfmfQhafjNLhwx0gJ3cbdhXgDkSEljHt2hoYdnKrczZPHnEK171FqfVqzOrWn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741738889; c=relaxed/simple;
	bh=e608xdJeqBKKdGNq0v7LWmeQ6DQjWhBH7FxgELGlglQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWO+wsBjMPSzCehm+OOCbWkz0rLrB4M02hP7DSC6bAnUeEvnnupCFycmWjB/gJmxSZBdJiq7+ad2bv3C/DhFyISOcQggp+nhUG1qqcapQisi0TUeG6ME92k8yrDej78PLNZUWatT9SHp26C33jm+XSAul69W5cZiv8s3AVaxV3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CXH1yE2/; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e4d18a2c51so736676a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 17:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741738886; x=1742343686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5xe36OxoXeIkbizVHSnBn4NRndqdFCX6+LlkAnxrvI=;
        b=CXH1yE2/Yl07OH3aRArU2m+/IjBVe/+zr9zByRPaEbjedAoCDIfGAh0DoVSWOCofmb
         a4NdZsHY6r3NhHdFvW/0bGXNQOgQWNrJcT7Z8+tp5RRoDmSXJM+z4jeZRM7DfdY6JWnr
         EahK7rbvE1eD2tdj7kNS1WzhO4SfxplcYj89w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741738886; x=1742343686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5xe36OxoXeIkbizVHSnBn4NRndqdFCX6+LlkAnxrvI=;
        b=ijngtNk4p3uH5TlmTNeAQBlG5dNvxohvhi9MSHNVZmYE5sDQL8TnAiODzGyJZa6dHG
         wkElLnL3ImuMbV5oz8jY+0bOOJGiyQ2IWNQkVYPr9/xqBB1x/rkuNJlnaKWc3h4deDu+
         0vM1O3QzOyop40sLMKsonzgFhvZsGZIo/8Akol3s4Dm7/xopoQmycMFg9wnmeNUEcL62
         82vY0jfymfkzDYUDrjfhSjm9VgES8GkvavrthcttFo3/uiJR5o7/VxCWdO7uDr/VSDau
         YK3bA5tWjqGD5uEssHgDPkODxFWxnATtB2i9Kfi1vqavdACToiwJ3Fhr/FjmXB7d6nzF
         HwrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcQI92K52xzvfFfmlA3KZI4jFVV0LVCJjzhfxYUdChw/L90pRjzq6qk92GQPSTi+21aConbD10HGdD49ToVIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZnkOMLRE6NZUCAjXlg0GQmlIqvJRY97gtpxjTX5ft1ZnF5uUQ
	R/a9wds4jjDK7GPDHbwC7LYPFb54LJxwQzrsTJ/kW5CYl6i9mn70AjtuA3Lhdg==
X-Gm-Gg: ASbGncuBIUHhxZacOvvLVxCWCKLSSDj8h/ZPcjRgfusRI6N/y7s5U+cm9QZBWPdmjI7
	9F/xaqRFxETC6hmYps62QUpwPCITIA3bhuBvk2iPA91glfFmBm+ZDVXZi0Z8jRD5uhGVv1QXa4C
	lzOi8j3YpOLb65xj9vclIeSinEakSVFtmaMLA2zbgWadvBpS4P6sj0ptLFcD+KD6ya79YP1vl7p
	PIJxtvEtHSdMv7QK/heOJL1DfN3yuPMs2JlH1CP7v88ANsRe+o4Os2hj0jq3IadpJHRSt3lzCMg
	0l06luVEYN6ZdXpDUph4/XXk1CZb1fPlTvb3Xl6+xGEgH0/PYDwvxmMxnos7ktR+9WCkQopesZQ
	S
X-Google-Smtp-Source: AGHT+IHtp8ouTXVsgTp2SJJgz2rGEBY4ebI7QJXVPc63NR9EJfuX37UqlqudFu1bAKoYDI0sugwhXA==
X-Received: by 2002:a17:907:6ea1:b0:abf:6b30:7a83 with SMTP id a640c23a62f3a-ac2b9ef11e6mr297381266b.13.1741738886472;
        Tue, 11 Mar 2025 17:21:26 -0700 (PDT)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c7669fd0sm8846503a12.51.2025.03.11.17.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 17:21:25 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	broonie@kernel.org,
	skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	keescook@chromium.org,
	pedro.falcato@gmail.com,
	rdunlap@infradead.org,
	jannh@google.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v1 2/2] mseal: allow noop mprotect
Date: Wed, 12 Mar 2025 00:21:17 +0000
Message-ID: <20250312002117.2556240-3-jeffxu@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250312002117.2556240-1-jeffxu@google.com>
References: <20250312002117.2556240-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Initially, when mseal was introduced in 6.10, semantically, when a VMA
within the specified address range is sealed, the mprotect will be rejected,
leaving all of VMA unmodified. However, adding an extra loop to check the mseal
flag for every VMA slows things down a bit, therefore in 6.12, this issue was
solved by removing can_modify_mm and checking each VMA’s mseal flag directly
without an extra loop [1]. This is a semantic change, i.e. partial update is
allowed, VMAs can be updated until a sealed VMA is found.

The new semantic also means, we could allow mprotect on a sealed VMA if the new
attribute of VMA remains the same as the old one. Relaxing this avoids unnecessary
impacts for applications that want to seal a particular mapping. Doing this also
has no security impact.

[1] https://lore.kernel.org/all/20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com/

Fixes: 4a2dd02b0916 ("mm/mprotect: replace can_modify_mm with can_modify_vma")
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 mm/mprotect.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 516b1d847e2c..a24d23967aa5 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -613,14 +613,14 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	unsigned long charged = 0;
 	int error;
 
-	if (!can_modify_vma(vma))
-		return -EPERM;
-
 	if (newflags == oldflags) {
 		*pprev = vma;
 		return 0;
 	}
 
+	if (!can_modify_vma(vma))
+		return -EPERM;
+
 	/*
 	 * Do PROT_NONE PFN permission checks here when we can still
 	 * bail out without undoing a lot of state. This is a rather
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


