Return-Path: <linux-kselftest+bounces-28930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD396A5F337
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 12:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E203BF4D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B790D269AF3;
	Thu, 13 Mar 2025 11:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RW83EQv0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807382698BC
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866287; cv=none; b=pcjxkcnZYT3xKipCkq+7OfA4v9oopIIUfxaapMWdbTcjVUL2sfCFptNBk3TzqS55ChPVW7DLb9P8fKFuvoo8cuqDIRL0tkQENyQoBSn7733Jc/qfwcOOZuwuOESUi4+tChuotGAUhxmFvQLXmeRTlbfiudEgcabgdZABmFziusQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866287; c=relaxed/simple;
	bh=0zAXw8Fu4pWyrls3J/qZaqJC0Q8LMMCdN0t5bJavxBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-type; b=iZTc1WpTOyg2k87ZzvJjqfftGVHrc2IRfAWUsU+RZ5zylfbUrXbY8BBiEzArYKubQ2WxfcMtqwoQE5If4HSGG4gObatgFdUgZC+HToGvG6zoAb6jyW4lCF5YzMQf/+gMfcrg4+SrmTk+AWjtUlTI8Q05WR2s8+jceu6Per0wtm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RW83EQv0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741866283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:  content-type:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3r2g39Wllme+8/IppJMHdqpnHPlgxpExHUFAvvaA/g=;
	b=RW83EQv0m9U7Kt8rGIWcei1mellTDeoY0OvNnJ8UuLylvv6Y/wONcmAxbU8Ts92tFm2UH/
	HFnc/wfX8XlKyzwIeWSrlTqXQ4UBHXEwB5bWHdjzckQwRIkXlCMEkT6jEdmH8yhm4Nc9X4
	bzsDv0rthTzSRzMLl+V8UEEV6YXHFiQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-6zr0niXZOmOakG_5XyAK-Q-1; Thu, 13 Mar 2025 07:44:42 -0400
X-MC-Unique: 6zr0niXZOmOakG_5XyAK-Q-1
X-Mimecast-MFC-AGG-ID: 6zr0niXZOmOakG_5XyAK-Q_1741866281
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43bd0586a73so5903115e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 04:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866280; x=1742471080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3r2g39Wllme+8/IppJMHdqpnHPlgxpExHUFAvvaA/g=;
        b=bHDnLgurltbnQ5tK3dOm481NCkPXELigo9rOfUHjdjWqvGmQ/r4AGlf2TP/f/pT1HT
         i43a7OaKJQ+sMVVdJVzVD5TGE9sPLJ/7wN72oQ9Gkx12IAE8PVa8rsddq68IXqHxdrDc
         rVj4HvmXc6Bb74tHhO9IaO/rV2V8DIlRx6w2HyfbWyhR1666UlXGIKm6kMYlNi0nqvZp
         t1UBLTJhQDiNXvdNTM6YNpg/Q6XYSosRWj5KAWhBna2kKsObY3DsUnixBw8wD+RK6hZ/
         GZy9k8nIUZRCsjzmCJRrJbOLhdwFFELMY32R+uQWTtus8OXq3likt7TNeY4OGErxxYlm
         5LLg==
X-Gm-Message-State: AOJu0YyMfw7F7WgbrehQO8Jc9uZ7dxPAOCcoO0SaP66JLoLdrDt+Wr7S
	jJ/EZfNR3e3pPzKsjvLwyVKOWucSQmJ4ZXrd2KaVBgldUdLMFqSwqBVRnVbgEN3KbBY2iemu8jR
	Rjutf8QtUjywE4g51FtJ947wa7dz+BBX9WQkuQVoRaqMAbxYVrDglXVWw97yEB49hWYCYTQQg9q
	3t3317oq6Vx0fWIsRSjDxFg77Q7eYZ1XD22TpO/6kouCAsHXM8SDFK
X-Gm-Gg: ASbGnctVrR+BAYI9srEIa3oeNH4UbaYfwlA4aJ6mkQYu9fczztMp+afYt6tAynT+EA7
	khj7tt8t0zCIWZ0xpGoIhLhSs7fwi75ySKc5kgV0xEb0L5RjNR+Kw8eCqzi/Pxd+50/MkS9blMf
	GfXNwQU4fyzmijwo9fClStvx71bW8zK74uDDLQi+eQiIw6NHB8SMTVONaRqqhDD+uHmr8mG/6AM
	ATbXtGWhDbomLnCC/EEeJnNMtR15FmhW8wXuIFcBV2fC0itYdfWB0/ZR6WO2bmlqxGQtOCVAZae
	tG4vfWn/z80xhISX5wwj
X-Received: by 2002:a05:6000:402a:b0:390:d73a:4848 with SMTP id ffacd0b85a97d-39132db1bdcmr22489012f8f.47.1741866280432;
        Thu, 13 Mar 2025 04:44:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX54DwhuuXuiX517uvSUEgVEhgO3UBbgNo/IaPOPi6DbNC92jX9q/7SC3qQwivycyOtbvIkA==
X-Received: by 2002:a05:6000:402a:b0:390:d73a:4848 with SMTP id ffacd0b85a97d-39132db1bdcmr22488963f8f.47.1741866280013;
        Thu, 13 Mar 2025 04:44:40 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d188b754asm17844115e9.14.2025.03.13.04.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:44:38 -0700 (PDT)
From: Alessandro Carminati <acarmina@redhat.com>
To: linux-kselftest@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	dri-devel@lists.freedesktop.org,
	kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	loongarch@lists.linux.dev,
	x86@kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH v4 05/14] drm: Suppress intentional warning backtraces in scaling unit tests
Date: Thu, 13 Mar 2025 11:43:20 +0000
Message-Id: <20250313114329.284104-6-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313114329.284104-1-acarmina@redhat.com>
References: <20250313114329.284104-1-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-type: text/plain
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

The drm_test_rect_calc_hscale and drm_test_rect_calc_vscale unit tests
intentionally trigger warning backtraces by providing bad parameters to
the tested functions. What is tested is the return value, not the existence
of a warning backtrace. Suppress the backtraces to avoid clogging the
kernel log and distraction from real problems.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Maíra Canal <mcanal@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 drivers/gpu/drm/tests/drm_rect_test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
index 17e1f34b7610..e8d707b4a101 100644
--- a/drivers/gpu/drm/tests/drm_rect_test.c
+++ b/drivers/gpu/drm/tests/drm_rect_test.c
@@ -406,22 +406,38 @@ KUNIT_ARRAY_PARAM(drm_rect_scale, drm_rect_scale_cases, drm_rect_scale_case_desc
 
 static void drm_test_rect_calc_hscale(struct kunit *test)
 {
+	DEFINE_SUPPRESSED_WARNING(drm_calc_scale);
 	const struct drm_rect_scale_case *params = test->param_value;
 	int scaling_factor;
 
+	/*
+	 * drm_rect_calc_hscale() generates a warning backtrace whenever bad
+	 * parameters are passed to it. This affects all unit tests with an
+	 * error code in expected_scaling_factor.
+	 */
+	KUNIT_START_SUPPRESSED_WARNING(drm_calc_scale);
 	scaling_factor = drm_rect_calc_hscale(&params->src, &params->dst,
 					      params->min_range, params->max_range);
+	KUNIT_END_SUPPRESSED_WARNING(drm_calc_scale);
 
 	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
 }
 
 static void drm_test_rect_calc_vscale(struct kunit *test)
 {
+	DEFINE_SUPPRESSED_WARNING(drm_calc_scale);
 	const struct drm_rect_scale_case *params = test->param_value;
 	int scaling_factor;
 
+	/*
+	 * drm_rect_calc_vscale() generates a warning backtrace whenever bad
+	 * parameters are passed to it. This affects all unit tests with an
+	 * error code in expected_scaling_factor.
+	 */
+	KUNIT_START_SUPPRESSED_WARNING(drm_calc_scale);
 	scaling_factor = drm_rect_calc_vscale(&params->src, &params->dst,
 					      params->min_range, params->max_range);
+	KUNIT_END_SUPPRESSED_WARNING(drm_calc_scale);
 
 	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
 }
-- 
2.34.1


