Return-Path: <linux-kselftest+bounces-39488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C89B2FB9E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 16:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF999189609A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 13:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D592EC574;
	Thu, 21 Aug 2025 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uidtkiEH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E5C2EC54D
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784494; cv=none; b=hvczG1h9lC5HHjeXcS1xtm971hf2WxduXVmk1oaAFzTNUKFVHkGTUgJTSQSoO5TXapkiX4PYUKz3WedG78vVhz1LxAXjlXRhGfggRgNOdzjX6iIw/uNNP3d5aUD0O3NLRvebqzP4S5ouD0NrzGlfpA9LcDvO+yTx4AF1T9vXdCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784494; c=relaxed/simple;
	bh=TKiEOR58JWBCnRVppYPQH0Vt1aBquwPcNvpC3at4LKs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=khgcEA6j9kWCapx2/9owUzj2eiiRvGMQDwynqKMYuj/bZaAaJHf6+3D9bFICQ4/Ts1k7Jr/9cS0nJUelJ21mvJ08Ce2UuEW9rGqWlmCbZI57DZPQkbH746YZpuiBw53UJf/xSlal/GyntWv1c0KDSidm9AwlAqpSiU23wXfgFK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uidtkiEH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326e1f439so1098768a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 06:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755784492; x=1756389292; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6ti2fCOXYva8ZvL9CMugr5JTuNvLl5q2xqcam/kYJ5o=;
        b=uidtkiEHAeDb5u6ovNeSbZoXst5efN6ZiNkueyuTnDvizR/Kl6uKnIeDWRN+K+dp+u
         mGR+iZEe49OKLQS2CdkDZ9yspelpQd9rGuIK1TUfo4jElvVwXDebAINM/ckmQO/g5RJs
         mEruJlRMSGaa+IRwhkpW2RSkpRmP6JgJLB1f1W5zHcBBgbuHU5qCJIdhusNFlosV7lSz
         H+RUwebgZ6FtOLIWKcMD8YwgzB4X586y0XBbQ1vrYkhwH11fxJCTkp2ya/xXXRaj3KUe
         30gMAhCFFq2pBtmJ4j0RGTlCNkBr9nGGGLtQGjEp+KCsfRt+gYskH1jajbxYMSJ9BBhq
         4hGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755784492; x=1756389292;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ti2fCOXYva8ZvL9CMugr5JTuNvLl5q2xqcam/kYJ5o=;
        b=oTFgkTHMGv+gahhFLdC9qDXKvR8tYODGJtOsFXUEpTtCtlRq4eHBtrmHE0NK78mq6d
         S9loLwPJvQEKrPs5vmcWy6dhc8luE/Km45/bjhSXzeuKPcGk9zOj9hrnAq5ztNzfsiqM
         H0YzZ1ixqarz0yqkptOEqCjwMo3GaRW+wyhlkx19SEvoxb2QMiKBOIalKeQTjVEvW+2G
         QIy3VkZHTe/We7n40BDo9b7xuetHnRrUbBcmU59Y426sBH7BWEcNVxBhZfrUaibM3m/D
         swfZriHIRK03oDM/E9pQA5Ee4pcgkOBll+x0pZ7IEaxDduNAgPSeJM02qhLEgJxZjr4u
         MxWg==
X-Forwarded-Encrypted: i=1; AJvYcCV7h7swkSr+B0V/eA5BhDGaNIgxoohT2HWN2ZlF1LtARd85IW438iXsoiVrTX99ENicYIUE9N6YlShWFprzFvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzol2NOQ3zmruVbbAFIuFAlHt0B5sUj09drw4UaycVFk61No81d
	quB+wRYjQwvWvNM1IFgh7cHJ//n+DJAqJa+TttyOTEzRqufwTOrjybWy2n5BOe+r8zrJR8JQzWO
	pHUkpIREsJZaEhw==
X-Google-Smtp-Source: AGHT+IHqGRrkU47M6IM1/x2E4P3NTyZSlzj29xTt46GT3PC8wiwMDfzgWqXUh2krGXSfc6vq3VH1gAt4thuMHQ==
X-Received: from pjk4.prod.google.com ([2002:a17:90b:5584:b0:31c:2fe4:33ba])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3bc5:b0:324:e682:f313 with SMTP id 98e67ed59e1d1-324ed19569dmr3747107a91.18.1755784492548;
 Thu, 21 Aug 2025 06:54:52 -0700 (PDT)
Date: Thu, 21 Aug 2025 21:54:44 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821135447.1618942-1-davidgow@google.com>
Subject: [PATCH v2 1/2] drm/xe/tests: Fix some additional gen_params signatures
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

Sorry, the last fix here caused a warning (thanks to the test robot for
finding it).

I'm still happy to sqash and re-send the whole original series if that's
preferred.

Changes since v1:
https://lore.kernel.org/linux-kselftest/20250819073434.1411114-1-davidgow@google.com/
- Add the missing <kunit/test.h> include for struct kunit

---
 drivers/gpu/drm/xe/tests/xe_pci.c      | 12 ++++++------
 drivers/gpu/drm/xe/tests/xe_pci_test.h |  9 +++++----
 2 files changed, 11 insertions(+), 10 deletions(-)

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
index ce4d2b86b778..6d8bc56f7bde 100644
--- a/drivers/gpu/drm/xe/tests/xe_pci_test.h
+++ b/drivers/gpu/drm/xe/tests/xe_pci_test.h
@@ -7,6 +7,7 @@
 #define _XE_PCI_TEST_H_
 
 #include <linux/types.h>
+#include <kunit/test.h>
 
 #include "xe_platform_types.h"
 #include "xe_sriov_types.h"
@@ -25,9 +26,9 @@ struct xe_pci_fake_data {
 
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
2.51.0.rc2.233.g662b1ed5c5-goog


