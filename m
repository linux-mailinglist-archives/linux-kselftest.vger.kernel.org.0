Return-Path: <linux-kselftest+bounces-43994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D7EC0733C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 18:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A6319A7786
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A29333746;
	Fri, 24 Oct 2025 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="VEHDXw+h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC722332EA3
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322207; cv=none; b=jqQKudHhOkH3PWcvPSqCqhTX+2qSo6G0NBcbs6ECe17/+a/ng5sLj4webDkFJAfjlE+Qt+xOk+zo4BQg5yRfh0lKKRR9v+JLcMiwkCI6AqoacphFsIbNtq3QHbMIfLhIRvXz0lJC9hc2bP++iQRdlBkfvAaQOVm0dd853GHDD6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322207; c=relaxed/simple;
	bh=7Ctj7U8/5C4UX61ox/HAuuPfBskF5Q9DSmh/7EoeFe4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edvkq7oRh9kvPHPOHEA+20PbM99DTN6kLvkj+aTlV9wy2tIK93SKJDhCQ46Itg//chLpmZL5XXQ5jDpLWpSaYRM4SKtE5NZIc64G4/8OVG68cUftNjyxA90W+ODoiUkMYWmrLAUulWWI41SlrzkdH3vAr/KIyp+IWDiM148xX4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=VEHDXw+h; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78488cdc20aso28634517b3.1
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 09:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761322205; x=1761927005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SbWqW9Qai+Lun71fJPV2ZvcU3Evl3TvbhEARlh+dkw=;
        b=VEHDXw+h95jrzqb+ExCf0AKQIjbTt3kIghTdCoQVAqWa7ZVG47WZ1wKafk0fxJbkBp
         DE8XdhmjYf+53q+hQLFBFkzTy/f7VdsX2b8JgcrsHlTavQZZWMyXiBl4BcEeXD+2Ke0F
         H5OKuQ49+RL8ahG+kvxvJYUm2J6Guw1cLldFLHkbmsB6ijQw8aUfp7BwsZ5D3kxNlpqT
         3TsIzVCrbE4rq9xyxAB+PrEGy3stCbE9ONaiQkQgXiBu03TV/IIs3nmd5tTegDWyiMno
         3zv5WFj8NEOrypTtDLPJq8zFH61VzGEjdPWV5S0dhT0gczHSF+1jY42Xfm2QWRkIpD0f
         d2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322205; x=1761927005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SbWqW9Qai+Lun71fJPV2ZvcU3Evl3TvbhEARlh+dkw=;
        b=ibzA0kuq2nXHyVQ2+iK/PmBebVAXrHrOp6Xs8T0d85RviWMxCegzpCaVMAeGVuuKln
         QDFG+AfG+7OPn1rbDDSzW+amoJAqZ8ufR6jUFjwNw/1XlH2S+Oqg99/yE36mYAYOF7CK
         wf962TrwfOLMBfMg0F1T/PjTaLsqA0INU/F9sugPH+wzEWWVmZqKYWEEjlNrA6mtHiGE
         e4MYP1Wv/k0/3e6uCp8TGOqFwFQGYMcO0/evVDHLOdwOqGmUVtieygRIv0wBXFZQb75t
         g31NhAA2BhLOkYkZGgZfCUU+NlvAlBaLiUjiOWeUo2oTfHNFmv5FV+uqDVZVsU4MzFgT
         VBUw==
X-Forwarded-Encrypted: i=1; AJvYcCV60LI/Wd2je1tdofoQl0sJBfzc3MQh/xSKBSP7qzOhcVGNajJv6eNWd9X1nNxul9GsaliQ5sbgg4dztOAx5h8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLezbo6a19JdcVKjfxG/OCmWd2bFgRkBhYy/YBkICCfuurnwvk
	vwg7Ru22LwyBjzYDr2zcBQRbpXKP8LB4IAoF8WzFLgaO73PeOCQ1d2LXjraIbUIJvoI=
X-Gm-Gg: ASbGncvyBHdwmTrWIeOBFC2Ik9iF3cTaxXRW9KDiwhsDNgPXTM6SmZhTsfEoVwLW2a6
	uWK535wC70+Xl7FeE1sgTb43tkUpXNyQtn5KoGkvH5TnEhlwFeIutZaq7rlmIH7wB8IZHcx+rBo
	9z6joxabo1IAPJLwFJBwZWqTn1SPT0JN47QsCgRmrvTfqogOUdG1cZGLen/PCRatk0Ql567rhzt
	5N47f3hhBXMhmdwe2jE27FVCid3rjbERN0tSKxPz4MJykWcqGzga5YqdMotz9mPqrBflXiTJuCN
	ouvhGt7ZcV8TRihLd4KYuZdm1GX7/D1BV93m2mQDm16pjiQIFXyugoDuM8RirfsI/dcVkBwBkt2
	sUQRZRrq47NiSIYFpmIK0qilytH/vjnyAAAuU/u3yt14off7FihYR7v6lxm24uhecW+VfHd7+JB
	cuQGqS6tcCt1845N4M3W6gyputgl2xkQWK9G/pDj6I/Fm/nH6Zdu/REb+9wtr2Gra7fSXisUBdM
	gwZPnPTVpDiiiVQSUOic9nsoFf3DVsLEg==
X-Google-Smtp-Source: AGHT+IHZAItAvq+Ap/Z72KhPLfQ8TowTJ5+sfBUaR7iDrNtO0b+4ThX0ZIHOf9SDvkQBFhT4ShLEEg==
X-Received: by 2002:a05:690c:22c6:b0:784:8286:fde3 with SMTP id 00721157ae682-78482870f7emr209860417b3.42.1761322204728;
        Fri, 24 Oct 2025 09:10:04 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd6edd87sm14099197b3.51.2025.10.24.09.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 09:10:04 -0700 (PDT)
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
	tj@kernel.org
Subject: [PATCH v8 1/8] kho: allow to drive kho from within kernel
Date: Fri, 24 Oct 2025 12:09:55 -0400
Message-ID: <20251024161002.747372-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
In-Reply-To: <20251024161002.747372-1-pasha.tatashin@soleen.com>
References: <20251024161002.747372-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow kernel to drive finalize and abort without requiring triggers
from the userspace.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/kexec_handover.h | 15 +++++++
 kernel/kexec_handover.c        | 75 +++++++++++++++++++++-------------
 2 files changed, 61 insertions(+), 29 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 25042c1d8d54..04d0108db98e 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -67,6 +67,10 @@ void kho_memory_init(void);
 
 void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t scratch_phys,
 		  u64 scratch_len);
+
+int kho_finalize(void);
+int kho_abort(void);
+
 #else
 static inline bool kho_is_enabled(void)
 {
@@ -139,6 +143,17 @@ static inline void kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 				phys_addr_t scratch_phys, u64 scratch_len)
 {
 }
+
+static inline int kho_finalize(void)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int kho_abort(void)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_KEXEC_HANDOVER */
 
 #endif /* LINUX_KEXEC_HANDOVER_H */
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index de4466b47455..6458f369a346 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -1087,7 +1087,7 @@ static int kho_out_update_debugfs_fdt(void)
 	return err;
 }
 
-static int kho_abort(void)
+static int __kho_abort(void)
 {
 	int err;
 	unsigned long order;
@@ -1120,7 +1120,27 @@ static int kho_abort(void)
 	return err;
 }
 
-static int kho_finalize(void)
+int kho_abort(void)
+{
+	int ret = 0;
+
+	if (!kho_enable)
+		return -EOPNOTSUPP;
+
+	guard(mutex)(&kho_out.lock);
+	if (!kho_out.finalized)
+		return -ENOENT;
+
+	ret = __kho_abort();
+	if (ret)
+		return ret;
+
+	kho_out.finalized = false;
+
+	return kho_out_update_debugfs_fdt();
+}
+
+static int __kho_finalize(void)
 {
 	int err = 0;
 	u64 *preserved_mem_map;
@@ -1163,12 +1183,32 @@ static int kho_finalize(void)
 abort:
 	if (err) {
 		pr_err("Failed to convert KHO state tree: %d\n", err);
-		kho_abort();
+		__kho_abort();
 	}
 
 	return err;
 }
 
+int kho_finalize(void)
+{
+	int ret;
+
+	if (!kho_enable)
+		return -EOPNOTSUPP;
+
+	guard(mutex)(&kho_out.lock);
+	if (kho_out.finalized)
+		return -EEXIST;
+
+	ret = __kho_finalize();
+	if (ret)
+		return ret;
+
+	kho_out.finalized = true;
+
+	return kho_out_update_debugfs_fdt();
+}
+
 static int kho_out_finalize_get(void *data, u64 *val)
 {
 	mutex_lock(&kho_out.lock);
@@ -1178,35 +1218,12 @@ static int kho_out_finalize_get(void *data, u64 *val)
 	return 0;
 }
 
-static int kho_out_finalize_set(void *data, u64 _val)
+static int kho_out_finalize_set(void *data, u64 val)
 {
-	int ret = 0;
-	bool val = !!_val;
-
-	mutex_lock(&kho_out.lock);
-
-	if (val == kho_out.finalized) {
-		if (kho_out.finalized)
-			ret = -EEXIST;
-		else
-			ret = -ENOENT;
-		goto unlock;
-	}
-
 	if (val)
-		ret = kho_finalize();
+		return kho_finalize();
 	else
-		ret = kho_abort();
-
-	if (ret)
-		goto unlock;
-
-	kho_out.finalized = val;
-	ret = kho_out_update_debugfs_fdt();
-
-unlock:
-	mutex_unlock(&kho_out.lock);
-	return ret;
+		return kho_abort();
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(fops_kho_out_finalize, kho_out_finalize_get,
-- 
2.51.1.821.gb6fe4d2222-goog


