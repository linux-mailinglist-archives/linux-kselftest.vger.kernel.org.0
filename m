Return-Path: <linux-kselftest+bounces-44575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A539C280F0
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 15:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B6C54EC029
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 14:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B8F2FD1A5;
	Sat,  1 Nov 2025 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="EfpmVhp6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374962FC880
	for <linux-kselftest@vger.kernel.org>; Sat,  1 Nov 2025 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762007031; cv=none; b=mG+gcHl4x+K7JyGFfU8TZh202yAfTxkuJbiauMyJRcooHB4gr97P/b+mtSwjmVHBiKwlfZiFLUVT7VpsESSSFanXQLG0xqXSHrRC2aao/fgDczmzjUKBGbgrbvAsZ3PbpCP2Bsm/UpB4MqJYEV1Mj0EmGSzqMRBelvrMpaCGPvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762007031; c=relaxed/simple;
	bh=Oqtj3JWIeCIubS0ImzITam9qN03yIsBoqb2XmRHV0gQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbTjjBUKmjox95x86v/J6N5Xa/3El1Cbbrp/RiIGNhhZ5sXRIrvcu+14MzCPBzYu/ObHwqLSakg/G0BGV+CXkXP7F7puaJwXadBl3vXnywteDt+GvxBwsRasXwxiuWnTPm+hA8qSehmhvbWVCLnhAICzy4/1JnC+LaT79Hqfx4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=EfpmVhp6; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5dbaf2b0bf4so1081151137.2
        for <linux-kselftest@vger.kernel.org>; Sat, 01 Nov 2025 07:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762007029; x=1762611829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y89e1Xc3DS2D9wc25qIhLt1elzzrVrlmI1KWnbpgyDg=;
        b=EfpmVhp6JcEhxU01fAVXy3zpa5VJopT6YsxUmzHJ7HTQhogkzVqTZVNPzaZROChJcX
         NjdqnoHaJTval7JoQS+TMXg6UtWtIlpflZVjWpiz047RUgnR83QLHzYN3naKo4AR4uvT
         W3+XatYzNkj1xoXhh7wUoPtiDwljaAbwtzMZ6yRUQkXjCVrQpTpFr0ZfoKmu5ZY5Ycq6
         zEqHvLuiZ6XA0I7TNz8vVsA3c66dkAjXJIRjMitPwH0KOJmVP9ERAuR/7HdyW2GHVDXz
         H1/l6OrNlbe63RpZoP6LcLzvf92w9NZ1QnwYjhohRSFObLvVYCSZZ6uxnNU3n8X4Rp/s
         j4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762007029; x=1762611829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y89e1Xc3DS2D9wc25qIhLt1elzzrVrlmI1KWnbpgyDg=;
        b=YBoxnTXOvCL7jhR6THUBA46VF+wtvUPFPrIOkrxsm12OlmmklZBtL3o2GT+vH/FNjw
         60F9a5/Eio7hbFBfSXjdu2w7CmAU2zTSHucRrkLcv5ApBEb4Wzpm15JjjiJCvvXz4BAI
         lr7yXek/5M/GBdEObdibLJGZsseokGS5USHNoH7dCSGfD4Vw6AKH2tCWoDM3ronvLxEV
         6iWvAoI+FZF2haD3B8455Iyeh6fk0aNOVYhQj6M+ZQnX6PbdPGGWQNRvGNmL7Aya7Jqs
         ANycdaITi6FfIDW34s7JnugULowSm4XuVaRRnmpH6dRvHW33MqVjycaLOo7G3SQ1HH9a
         cWZg==
X-Forwarded-Encrypted: i=1; AJvYcCU7DmBqTfjtI8ggdvDeXKsz4rOyrZN7v9W0+Nd2j77mYMtJ3A98w8lb4v+yoSvHV6xdXEG80qxkmkbI+2JzAnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtouLYHhEA8fZR4SGGn4a4xWNp+jQNL1VxEnvKkeuek66l/v5q
	PQtt+eVOxhPK7rW3bErrwo73KbuUvO9B+ElIbOLIVsG8FJB0brHPezgmnAbtbhoBq70=
X-Gm-Gg: ASbGnctRrIHxCbbYXVtW6oFze0NJvk0ru83kGMti1EHJXBnAvAW0H+3saWF+zabjWo1
	HHrGY5AhkXC5fUCW5QvRsYkIfY/FSSspUzEpXJ5oYm+BTVdiWQja5diKAyP71LQiqWgB6H9FfMP
	1YJVIkDKYXiNpdRSVSb5oc4XiA2cxKgR9y4ZR6pWMg2Ilhipk+qFx+tH1YOE+F314DD2wTlGQpn
	rieNsTczvGFihTcznO4VxJSJ6ANwwvrclAbnLnG7Tv/2HBeFYGkizwn9XeIMD5UrX+8WqC5AGJL
	+wPRLAYi3bQDQwiiQH/htjX5sfFGnEVbjHLrpHRjQqxG345B6k3y9NVAFPcSdO6UOabKRIkRnvL
	2C0o3bod9Wbt6TgWrltPHaE4HLkF9HfPzALhe5vgtgog60DlUHgKp+/pURSUJl7Jf7ywV0ULJFx
	447sVLvKQGzgI5EePNuX99TrdzGL3cYiyEa9HzvLZbgYK/kq/bhcU6nFl12Ip+
X-Google-Smtp-Source: AGHT+IGFDCScfqliWb9KcrLwkQzx/ze/7HdLlm3rrxqjpvvjEhbQ+nHt0IFtgECikftA3CUT6aFcGQ==
X-Received: by 2002:a05:6102:441b:b0:5d6:5e9:9e0c with SMTP id ada2fe7eead31-5dbb11f02d1mr1796389137.4.1762007029092;
        Sat, 01 Nov 2025 07:23:49 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-559449647e0sm1776242e0c.3.2025.11.01.07.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 07:23:48 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org,
	yanjun.zhu@linux.dev
Subject: [PATCH v9 9/9] liveupdate: kho: Use %pe format specifier for error pointer printing
Date: Sat,  1 Nov 2025 10:23:25 -0400
Message-ID: <20251101142325.1326536-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
In-Reply-To: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Make pr_xxx() call to use the %pe format specifier instead of %d.
The %pe specifier prints a symbolic error string (e.g., -ENOMEM,
-EINVAL) when given an error pointer created with ERR_PTR(err).

This change enhances the clarity and diagnostic value of the error
message by showing a descriptive error name rather than a numeric
error code.

Note, that some err are still printed by value, as those errors
might come from libfdt and not regular errnos.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 kernel/liveupdate/kexec_handover.c         |  4 ++--
 kernel/liveupdate/kexec_handover_debugfs.c | 10 ++++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index be945c133a2f..167c761988d3 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1448,8 +1448,8 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 		memblock_add(area->addr, size);
 		err = memblock_mark_kho_scratch(area->addr, size);
 		if (WARN_ON(err)) {
-			pr_warn("failed to mark the scratch region 0x%pa+0x%pa: %d",
-				&area->addr, &size, err);
+			pr_warn("failed to mark the scratch region 0x%pa+0x%pa: %pe",
+				&area->addr, &size, ERR_PTR(err));
 			goto out;
 		}
 		pr_debug("Marked 0x%pa+0x%pa as scratch", &area->addr, &size);
diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
index 46e9e6c0791f..ac739d25094d 100644
--- a/kernel/liveupdate/kexec_handover_debugfs.c
+++ b/kernel/liveupdate/kexec_handover_debugfs.c
@@ -150,8 +150,8 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 		err = __kho_debugfs_fdt_add(&dbg->fdt_list, sub_fdt_dir, name,
 					    phys_to_virt(*fdt_phys));
 		if (err) {
-			pr_warn("failed to add fdt %s to debugfs: %d\n", name,
-				err);
+			pr_warn("failed to add fdt %s to debugfs: %pe\n", name,
+				ERR_PTR(err));
 			continue;
 		}
 	}
@@ -168,8 +168,10 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 	 * reviving state from KHO and setting up KHO for the next
 	 * kexec.
 	 */
-	if (err)
-		pr_err("failed exposing handover FDT in debugfs: %d\n", err);
+	if (err) {
+		pr_err("failed exposing handover FDT in debugfs: %pe\n",
+		       ERR_PTR(err));
+	}
 }
 
 __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
-- 
2.51.1.930.gacf6e81ea2-goog


