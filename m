Return-Path: <linux-kselftest+bounces-38058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 720E6B153A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 21:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6D818A816D
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 19:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA96298981;
	Tue, 29 Jul 2025 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jNPES/N6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A1A29551E
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 19:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817850; cv=none; b=WtH0sqv5DXRwVQ8r4QNKg19h7hfY77wn8V570XYJG4RXXGhoiLQX5C3I9YSwr4YHc2FO034F8amJ0afhIWpR+RcVaSWQuULDipQ9Krq49Ck7AAeaNnzBtZd5awiA/oLytuG+H5tjrzLPJps5PJcD7t9U4nDl62jL7i6TWxdJ3Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817850; c=relaxed/simple;
	bh=SZc94WgT3oH3BVba65A5Q6CTpCyfy574wO1W8pERtAM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OSG49yaajX6ocoEMCd9FltfM7wdHvYCs82277nb74HPl1FbdonrgmtrhOF4D/calKrA8QKVQ4LO0M4zUMnjBv06bRli+iGNJTUMm/4asGr6RHMwWZ7rGj2g9Cyw8O9aOG7soToKqyK7NZOWOp4s0aqVJlKdbzONTriD+HJqk+1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jNPES/N6; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7e36e20d700so35475485a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 12:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753817848; x=1754422648; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1gbKWHstsqjpQUrskmEj35TBdlQ+Ks8m0MsBKhxomQ=;
        b=jNPES/N6jclAmASv/H7XjBmu1Tok+e2hnXWuIRSCO8ZuYbQCWAa+YvCfLklZmEK5hX
         K8ZXDgsleYJ/IT8Itmlpnq/919VdRkOQpQB4LifGmqlTlB7BK/6f82O6WitmSenw/09H
         hMGQFMs+9YqN8pEWv3c863d+K3GasOz+ytvpgLKRdLVz1Jlxp6nVzDbv4QXF/Xlr24R2
         Pw43LhkEJxTYNMXkR06TS2pznSE2w07vO8/Hu8JrtP3wjAIlx1GdOBA0fF3ikLcgmavE
         o12uD5I+3MFJczXhlQRsrotVVWMbmIAkiRY7PzttwUqzC0iNE841+YBSEpismSYiG3Q8
         pO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753817848; x=1754422648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1gbKWHstsqjpQUrskmEj35TBdlQ+Ks8m0MsBKhxomQ=;
        b=ATw1P/Mbh4y82dnk35iEW6PCmB1oIH/vUPN0lWwo7oaASdyX/BRp244Bp+/EbMa3mX
         IeMRcsegNxUWplKzMKE0tuVvIvj9wOeQVXRIoMQMeMTOWtU6kz4zvwTmBAUfJqiLl32r
         3Gy5EfniSjXwqeqE/DBBYMFbi6gganIaHaG8fV08MmZCCY5YscINrkEouoNy9AGtrpHf
         I7778awiWyGSLmL1p5B7gOwTRqTQUyHz//+NHiPzDmxrJLFfE2Nh/Z4CeFfJVAWf0UZ7
         wpFEs1mpw6LJPlnOLlFfIUwzBsGY8pbY8oLictPOGuOiNeo+y6cvS1ASWi0TTAbbDRXe
         h5CA==
X-Forwarded-Encrypted: i=1; AJvYcCUELOQEHVCYJFscQISOXGbMrPGJWlfO4IJgTLJ1is4IIFRP9mlC3TIbMzR/sy4HWuiGEvA+PCZqs5nYEr9OBvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG+EzF/JpslRU12GDwwnAo7SjVwNWkTmYg/IlP+YL2xNRCZZ+U
	N6BSFEpmojnSkgz95sqajBonHIDdk6j1s42xxjOfRPAepHDBphjUJltHOox/zoalNHG5D0L8vF3
	H6//+7Z9T6/XfOQ==
X-Google-Smtp-Source: AGHT+IH49q8FwE/ekxv3FeoZfBKO45/GCZY6ANFvVAwiH31rvsPrQpAAJiadtmnkP06wHNdCbESTk/zdijXtfQ==
X-Received: from qkkh15.prod.google.com ([2002:a05:620a:10af:b0:7e6:4e45:e180])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:57d8:b0:7e6:5f1c:4d78 with SMTP id af79cd13be357-7e66ed5c00fmr119271185a.33.1753817847731;
 Tue, 29 Jul 2025 12:37:27 -0700 (PDT)
Date: Tue, 29 Jul 2025 19:36:43 +0000
In-Reply-To: <20250729193647.3410634-1-marievic@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729193647.3410634-6-marievic@google.com>
Subject: [PATCH 5/9] drm/xe: Update parameter generator to new signature
From: Marie Zhussupova <marievic@google.com>
To: rmoar@google.com, davidgow@google.com, shuah@kernel.org, 
	brendan.higgins@linux.dev
Cc: elver@google.com, dvyukov@google.com, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Marie Zhussupova <marievic@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch modifies `xe_pci_live_device_gen_param`
in xe_pci.c to accept an additional `struct kunit *test`
argument.

Signed-off-by: Marie Zhussupova <marievic@google.com>
---
 drivers/gpu/drm/xe/tests/xe_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_pci.c b/drivers/gpu/drm/xe/tests/xe_pci.c
index 1d3e2e50c355..62c016e84227 100644
--- a/drivers/gpu/drm/xe/tests/xe_pci.c
+++ b/drivers/gpu/drm/xe/tests/xe_pci.c
@@ -129,7 +129,7 @@ EXPORT_SYMBOL_IF_KUNIT(xe_pci_fake_device_init);
  * Return: pointer to the next &struct xe_device ready to be used as a parameter
  *         or NULL if there are no more Xe devices on the system.
  */
-const void *xe_pci_live_device_gen_param(const void *prev, char *desc)
+const void *xe_pci_live_device_gen_param(struct kunit *test, const void *prev, char *desc)
 {
 	const struct xe_device *xe = prev;
 	struct device *dev = xe ? xe->drm.dev : NULL;
-- 
2.50.1.552.g942d659e1b-goog


