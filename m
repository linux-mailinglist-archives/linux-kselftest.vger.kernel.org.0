Return-Path: <linux-kselftest+bounces-39288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B82B2BAD8
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 09:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E5D5E5806
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 07:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E7E2F9C3E;
	Tue, 19 Aug 2025 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I0xHpxeq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAF726E6F3
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588879; cv=none; b=Ed7dgRTEMxNK0pzMrXjrZJSPpoJw2tFiuTbdvgsyu1duH47Pf/ALl8mdjGFFFJ3WzzkrGiP/OScgPe4go7nktpTRFcDmizWzH4KZL18Qdg3XGluz20zcVX/iEtCrkJInFj0iDTw2SffB56735BQ5qZDJ8wwZFSOaUJnDyEuNfsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588879; c=relaxed/simple;
	bh=mo6QMFKDxyh3t+yNV9NKO9AzDGESDf5V9BefxEECWhA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hMK22KyK7pkboK+ZUdIT2FiFYSrboqn8VyJhZdgUdWQ3fA4y/0OgDqpWMnmbGRoDKKKQ47P2ij/TYviEo6F6mqc0eEC4/ecAP3Gd0rYnViiLxbRusrFgZbNgEPYlOvasnvwuMqGNGvWA3+N5ZECIimmc3TmYFx4GVNyuVyRTUXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I0xHpxeq; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2eb47455so10349787b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 00:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755588877; x=1756193677; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0gjQmJyLWyyM34EUsK6b+yflZfBy/ykkULtt1gmp0aw=;
        b=I0xHpxeqAh+IXQhF7OW+Z6mlEj03Q5XhDn6qE/6roPBbNQzN+OgDjP+o+48mRY+wSG
         fv3A9WlgtEyDLQ1qfiPCCdHs8/xPS5/w5UjHs5FrRVDNXdy2SUvR03RfYtC6dODNtDKW
         daBnTJ1EAGqTCenEquu3PcQGril4pj1TRSVTzkWlDpXoOe0K69xwIGDCLvFHfoBkpB9N
         ZcFirVJ3oLy5Jdlce12EFdWrHNe+/+SZk7I20scgkYGzBF/VDA0WC7hjNIkICM7GKx6y
         coBvfOclsggnp6kOGdJHn40hXUH/OMRnazWD7zUC/48b9obg9VJm7wabQSRUh6re8D4p
         qJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755588877; x=1756193677;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0gjQmJyLWyyM34EUsK6b+yflZfBy/ykkULtt1gmp0aw=;
        b=NSKXOsp5TLOtKNzhyYr0SAQWgpE0AEU8d7EpM1MFDyDW14355qRiDBPubPyho0bkfl
         59JXoP/iYpy/jeVGGZnyATl+541gb7k0g5HK/VmGINJ5YUvJr9ji91YIhO3Tnip/32tr
         165dm0hlGYZu3xkY8KpPjmL77pbBTFTxUbYBRiHXXjSIq1l60VAUNUhkVtqftwWTV2fX
         1M9pMgZekC+6yYrYHfUc02MJP7e/sIPj3syt5d68t0S1YMp3T2O+hdrPuWKw48zxdqGC
         +7o2gEm7H6aX8Elirbc64wIiLoIWM6Vej5qVJBwoHLYTign3QvobrsOzuK9EYR5M6PHm
         ezNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeQvP+SMdsNH27hfi9I1Er01RgySLXzHs+ApQ1KVK9s/po2GsEwEiM3eUx1WxQ1WSHmfIChrRd/Ggn2vSfTKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX7A4jrYz4WgGUeO7WHKqEpivXeSAjA1T0cagW6LGYHjfUQL2M
	dsI/LbFkGlutNuUmneT29KTZ3AK5QEHSwU3WMZLIEh8eOFfRM0iIflnmbRNjO7OI7YiJCExs1Os
	3fxEaecqivZfYxQ==
X-Google-Smtp-Source: AGHT+IEQNZ2+f6e9TNwetvOQ+hPmPxwMV2Wzkl2ILCeYpSP1rxXPD78DlfuwZr89GPZOqtlPyVjHcqV/V+GqUA==
X-Received: from pfbfy8.prod.google.com ([2002:a05:6a00:8288:b0:768:7cb5:740a])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2184:b0:76e:7ae5:ec90 with SMTP id d2e1a72fcca58-76e8111212emr1805413b3a.26.1755588876576;
 Tue, 19 Aug 2025 00:34:36 -0700 (PDT)
Date: Tue, 19 Aug 2025 15:34:32 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819073434.1411114-1-davidgow@google.com>
Subject: [PATCH 1/2] drm/xe/tests: Fix some additional gen_params signatures
From: David Gow <davidgow@google.com>
To: Rae Moar <rmoar@google.com>, Marie Zhussupova <marievic@google.com>, marievictoria875@gmail.com, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Shuah Khan <skhan@linuxfoundation.org>
Cc: David Gow <davidgow@google.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, intel-xe@lists.freedesktop.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In 444be9072fca ("kunit: Pass parameterized test context to generate_params()")
prototype used for gen_params functions was changed to add a struct
kunit parameter. However, a few of these used in xe were not updated.

Update these so that the xe_pci tests build and run again.

Fixes: 444be9072fca ("kunit: Pass parameterized test context to generate_params()")
Signed-off-by: David Gow <davidgow@google.com>
---

This should fix the issues found with the linux-next merge:
https://lore.kernel.org/linux-next/20250818120846.347d64b1@canb.auug.org.au/

The following should reproduce them:
./tools/testing/kunit/kunit.py run --arch x86_64 --kunitconfig drivers/gpu/drm/xe

Ideally, these should be squashed into the corresponding commits: let me
know if you'd like me to re-send out the whole series with these fixes
applied.

Cheers,
-- David

---
 drivers/gpu/drm/xe/tests/xe_pci.c      | 12 ++++++------
 drivers/gpu/drm/xe/tests/xe_pci_test.h |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_pci.c b/drivers/gpu/drm/xe/tests/xe_pci.c
index a65705814b9a..f707e0a54295 100644
--- a/drivers/gpu/drm/xe/tests/xe_pci.c
+++ b/drivers/gpu/drm/xe/tests/xe_pci.c
@@ -44,9 +44,9 @@ KUNIT_ARRAY_PARAM(pci_id, pciidlist, xe_pci_id_kunit_desc);
  *
  * Return: pointer to the next parameter or NULL if no more parameters
  */
-const void *xe_pci_graphics_ip_gen_param(const void *prev, char *desc)
+const void *xe_pci_graphics_ip_gen_param(struct kunit *test, const void *prev, char *desc)
 {
-	return graphics_ip_gen_params(prev, desc);
+	return graphics_ip_gen_params(test, prev, desc);
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_pci_graphics_ip_gen_param);
 
@@ -61,9 +61,9 @@ EXPORT_SYMBOL_IF_KUNIT(xe_pci_graphics_ip_gen_param);
  *
  * Return: pointer to the next parameter or NULL if no more parameters
  */
-const void *xe_pci_media_ip_gen_param(const void *prev, char *desc)
+const void *xe_pci_media_ip_gen_param(struct kunit *test, const void *prev, char *desc)
 {
-	return media_ip_gen_params(prev, desc);
+	return media_ip_gen_params(test, prev, desc);
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_pci_media_ip_gen_param);
 
@@ -78,9 +78,9 @@ EXPORT_SYMBOL_IF_KUNIT(xe_pci_media_ip_gen_param);
  *
  * Return: pointer to the next parameter or NULL if no more parameters
  */
-const void *xe_pci_id_gen_param(const void *prev, char *desc)
+const void *xe_pci_id_gen_param(struct kunit *test, const void *prev, char *desc)
 {
-	const struct pci_device_id *pci = pci_id_gen_params(prev, desc);
+	const struct pci_device_id *pci = pci_id_gen_params(test, prev, desc);
 
 	return pci->driver_data ? pci : NULL;
 }
diff --git a/drivers/gpu/drm/xe/tests/xe_pci_test.h b/drivers/gpu/drm/xe/tests/xe_pci_test.h
index ce4d2b86b778..690b36e6500c 100644
--- a/drivers/gpu/drm/xe/tests/xe_pci_test.h
+++ b/drivers/gpu/drm/xe/tests/xe_pci_test.h
@@ -25,9 +25,9 @@ struct xe_pci_fake_data {
 
 int xe_pci_fake_device_init(struct xe_device *xe);
 
-const void *xe_pci_graphics_ip_gen_param(const void *prev, char *desc);
-const void *xe_pci_media_ip_gen_param(const void *prev, char *desc);
-const void *xe_pci_id_gen_param(const void *prev, char *desc);
-const void *xe_pci_live_device_gen_param(const void *prev, char *desc);
+const void *xe_pci_graphics_ip_gen_param(struct kunit *test, const void *prev, char *desc);
+const void *xe_pci_media_ip_gen_param(struct kunit *test, const void *prev, char *desc);
+const void *xe_pci_id_gen_param(struct kunit *test, const void *prev, char *desc);
+const void *xe_pci_live_device_gen_param(struct kunit *test, const void *prev, char *desc);
 
 #endif
-- 
2.51.0.rc1.167.g924127e9c0-goog


