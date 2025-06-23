Return-Path: <linux-kselftest+bounces-35658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FF5AE5801
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 01:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48AD41C2605E
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 23:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DB31F8722;
	Mon, 23 Jun 2025 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jgpcyqtw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BC5224AED
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 23:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750721182; cv=none; b=SWTO3WvLQuow5jh3CTlvEnY7aUyUh+6WgwN6wuwGAuwgI6ZQWzkWAsPH7CjQ4wNznZkKhaRUbF16kV8dpIITGBMcLJVJ8gnOx46CwCIlTN+bXJwWvLA8XdjPJARieRACiZ4rFNMKJSovPJ2tFhW1p8rfdWnd7+QRQWXSNwYg57A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750721182; c=relaxed/simple;
	bh=yzqrucYkLkVvgHoItoD/j44DdLcZdVCeT+XajO01nJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l1gpbR4N7o++v46IdxJhqjC1J2319NBV96EfBzh5yii9+xZlFJOCx4ir0lGpnQXTawUiA/NHKt3OeLiuOZB6e9IQUlA1HkGZoXgKtW+zlqIb/sHePrJgK/2sjPM9sceloDiSGujSQkRr0JxKqHyatr7TW/VdgwOR4KPVQtbk99Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jgpcyqtw; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so2289138f8f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 16:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750721179; x=1751325979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5kQvwr4znaeekKGqGYywHoRh23O0X8q6/s8R+gkVfv0=;
        b=JgpcyqtwYhdWlqgZ4liFrMttKmheXyK0ZSLBazR2hY8E8e7KDG/znkdRF1GBEih8o/
         aTkzsmQs/n8tQORgd4AGLiqIzFcA108f3No8HhYEN0MgiGnxtQu08ZanwPdx69kKCI0m
         nh6C5YarQGBXiv0FUCvSpMQTcs3f0y3+IlTD8wOKM3woUbUXeCWOZ/vOrN3bjp2Fm2kf
         eiQl42aTcYoA8z6Ghur1J/hmdUWhVX1GQ/L9vzw5AmASIaQgG0IaSif9uinZ6sENiKPQ
         sIe/Zc9/2i//K44Tjmj01fKkbB0udH5+a7g4sMTuyQXvWeJWKuy1jUjRrRtHRfxNWLvA
         4q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750721179; x=1751325979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5kQvwr4znaeekKGqGYywHoRh23O0X8q6/s8R+gkVfv0=;
        b=kmzYeA+/6V3LdZSJnLi3xOCMS/aZnsOcQVLDgTxmpzOm9gq0QAllJCt4TYgk33BElv
         zbQQun/iJDi5x9EhfsyaIJypQ7NgSoouGFU1+KYY063sc91B9vUG8JyiWUF4BN70suC0
         KpExSqMSd8kXZPjyVQqFRynA9JOuzgdEwVqTjyv8Noig6KGVB2s9kSnOSbRO03CqK8qp
         MBooTHc9qT5TF2h1IQ33GwhKmLLzhP0WxFhmztFXr0EVtIm5bLYDk+71ltnDEdN7K42T
         nBpCENa9bmcZqf9dm9VFcsO4+vfbSAAwNUBC4FVSucQejx9xcWQ8QFIE20NCjgADWPvB
         bnug==
X-Forwarded-Encrypted: i=1; AJvYcCUCJooxfEnW0IA32nd5amkOWzUMzDEJBFsH05q0Ef5nZLJ7Rxr1AleH46qFqTSypXs4maRrnGbeEYPXonBoWEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtKJ5HK0KxjEe21zGcD9MAFpgUQBtGy07Qx2KY12Y2NUBh+YuC
	PQ6K22VkpA9ltr65xWwI0/OTQuzdg45MXPGj05ZCKCEnRowMNsdRZ9Ap
X-Gm-Gg: ASbGncvdHQLtaq57/wAbaPbFbLW7Xz65wWCpneJnKraTnnSLmFJAUKNTiVGPg19UaZj
	LJdubKTIaG70vjY3/DFn069RkQkxaTGyQCuzsWEzHSYgvvGR4hl7wA5KLUb86J4qGC4XWn+5+xU
	LCMnk8W0OxrDOfQkK0wDI37jnZq2N8usZBfJStVpoTmr9lzVXFEJWucPGa9K+6jhOt4xstiQqJO
	VYQjZkdUXAsJPp5Z2PBOOdwFf/4GqodTo12nlN8EKZVh5IAjP3sJmzSTIUhoeH0WNlhNWDdsXOs
	cs6ItmBXPdIR0sb/dgLveeYoiTgtm03QGnLyNeUPxoL0sJcnVcEQztmAmeBgiuNZku7aopB5mcg
	bESSb9G6rMoHnum3ygqufWBu553L79PfUWe6QrvpXHQ==
X-Google-Smtp-Source: AGHT+IGHE8/XYXDoWv1edDBgdZXp7khQRu3HaEVJ14KJWrycHHoziA88Dx83XySgUoVmVMLW4aUYDw==
X-Received: by 2002:a05:6000:280d:b0:3a5:51a3:2ef5 with SMTP id ffacd0b85a97d-3a6d132ca1emr7782200f8f.58.1750721178663;
        Mon, 23 Jun 2025 16:26:18 -0700 (PDT)
Received: from puck.. (watf-12-b2-v4wan-169542-cust1006.vm45.cable.virginm.net. [81.98.219.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e810b140sm342384f8f.80.2025.06.23.16.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 16:26:17 -0700 (PDT)
From: Dylan Yudaken <dyudaken@gmail.com>
To: kexec@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	Dylan Yudaken <dyudaken@gmail.com>
Subject: [PATCH] selftests/kexec: ignore selftest binary
Date: Tue, 24 Jun 2025 00:25:49 +0100
Message-ID: <20250623232549.3263273-1-dyudaken@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a .gitignore for the test case build object.

Signed-off-by: Dylan Yudaken <dyudaken@gmail.com>
---

Hi,

I noticed this was causing some noise in my git checkout, but perhaps I was
doing something odd that it has not been noticed before?

Regards,
Dylan

 tools/testing/selftests/kexec/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/kexec/.gitignore

diff --git a/tools/testing/selftests/kexec/.gitignore b/tools/testing/selftests/kexec/.gitignore
new file mode 100644
index 000000000000..5f3d9e089ae8
--- /dev/null
+++ b/tools/testing/selftests/kexec/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+test_kexec_jump

base-commit: 86731a2a651e58953fc949573895f2fa6d456841
-- 
2.49.0


