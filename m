Return-Path: <linux-kselftest+bounces-33788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36817AC4065
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 15:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E361740EB
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 13:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F12320D500;
	Mon, 26 May 2025 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHBJ63MA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5F11876
	for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748266109; cv=none; b=H9susa8TU2ofGVZrq/TZnGwIN3MqRJF4/fO6bTdF9+ANcB5JXDmvleOa88a+7vMZwTa9+n1E3EURA/2zW8HPLEdmSQUZe/Athub25nr8hDolOJPlxNjSEoQqBz1pO5qb6hY8R6iIUkJ3FFhG1cLR7fxOuW66gYmwb6u6Np/j70A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748266109; c=relaxed/simple;
	bh=6t3eRY7hkJvKtTZGuaky3RihvRWdFfWK3lVmchxIyG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-type; b=Gwo7z7UXA8UPZXLjApMp0rDJjF7DKnhLkWSsYmLj/NSOa5F3lL7lem+9w8aaOvE96fgFqcPHCgA6cGq+dxcah/3n472q9yHHY8IEb+0HqaGoyWLpcWgj/F6nWnyAXgNe+mAMXZS2CbqvwJYJehHRerNrr5IE2Efw847RIWMT4mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHBJ63MA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748266106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:  content-type:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tIJNc4z+prl6uqE8TJXFoIi+LuDA64zLV+jmBQfkFuc=;
	b=SHBJ63MAezDlWaWS16E/FCqn3k8NQAM7y1uVnVIWejwIKUj8Wb/7T/+zRvO+seO0U9HkIK
	3tDZdVAD3PTwWFOF7DUab7DznRiZzpnqvI2XpA1u9KRHXqugtwiKX7FC57QHsGW764l822
	apt0pF2LY5nivNszT1pYXV89SL/iaaI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-sa0P0sG-NEO2q2cVTJhwQg-1; Mon, 26 May 2025 09:28:25 -0400
X-MC-Unique: sa0P0sG-NEO2q2cVTJhwQg-1
X-Mimecast-MFC-AGG-ID: sa0P0sG-NEO2q2cVTJhwQg_1748266103
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-442cdf07ad9so12627095e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 06:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748266102; x=1748870902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIJNc4z+prl6uqE8TJXFoIi+LuDA64zLV+jmBQfkFuc=;
        b=KUMcQro1uxD2Ol4mhsBWxzSoebEbymVAAszbd0VqC+2mgDuVG4wqnQsmORA3vzIq1+
         sMUPiJmXn9izcuygpBECWQLYtjPp963JBsm2CmiuRFkx6iBVBXE2Wx6fvnGoT0PyvnLT
         AvNPRTS56Mz7vRLWQwx0E/zjkOcPPH2VA+T5xZSbq/kM1GyFGFCJgAFTmE20fXfjgUtz
         XfCPeOCLcVOAhwKqeNwoUY7sZJzZmwIX9/L4MLRqfopFTgZcA1TT+Pmhv/o5OJI4lpUd
         Xja/MdJaFgPa9xSDoV2+A5Knqk9i0nmBax41sPzg/lwDHW7BLGyS2GArhJDs7+ER4G87
         JOFg==
X-Gm-Message-State: AOJu0Yw02IJzhFwT4YGYhQ/AEhljJ9aNhpW4FmLLcVw8EyyXqT+eMV4g
	4iNxqHMDbW8iH3n5pGY2OAXqjK4M/zI7ZGunXclP3B0DpFtpPjv4F+5vGxNf80rMEDGNhA2XEAX
	dRpGwEvq/IjyU9ozva8W6QDDSIa1mb7w7d4fcyjWsHUqX4ldMEIdVwEURcfauzImLAoE0G737Gr
	Jgca0swkxgqIxpKwcJ4TEws3XOBkMmsfXItEivCt6OA9wwV1U/7rZqgKvK
X-Gm-Gg: ASbGncuday7BNz26AVvrwRwd4iz1f0iQJzfkM+0FVnrqDejo8pkHCPzjPa8JrS6b/JM
	q1bETy5dhpB9B719oFSuiKjlatqxZ21NNdafUG8I0hEnyuMoYSqI9QN7caOb8hNqKLJKbTvRF9I
	YMtyGqpRv4yYENSx9+MafMGMEkwP/eOChZ+1+iWeUZ3/f0BwpZwNlA77NFBs+RvHFOf7QUf3IE1
	JSTj7TlrYVZAddJeKCW3T7qOINOSM+6SUy3NDIufuEYhtvLX4ptrQ1heI+rbu+F0SCHb4VxqmTe
	6VK4E0LuMCq4OrYJ
X-Received: by 2002:a7b:cb0e:0:b0:43d:8ea:8d80 with SMTP id 5b1f17b1804b1-44cf6d81628mr43597865e9.5.1748266102565;
        Mon, 26 May 2025 06:28:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr19bNHeLuqPTA70dJ3loiMHnX3Wbi8DckD7ViZVw9xearBz01pBMAJtm6RFOqVblZmf8Afw==
X-Received: by 2002:a7b:cb0e:0:b0:43d:8ea:8d80 with SMTP id 5b1f17b1804b1-44cf6d81628mr43597425e9.5.1748266102096;
        Mon, 26 May 2025 06:28:22 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a4c8455e7dsm8836663f8f.9.2025.05.26.06.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 06:28:21 -0700 (PDT)
From: Alessandro Carminati <acarmina@redhat.com>
To: linux-kselftest@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	dri-devel@lists.freedesktop.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH v5 4/5] drm: Suppress intentional warning backtraces in scaling unit tests
Date: Mon, 26 May 2025 13:27:54 +0000
Message-Id: <20250526132755.166150-5-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526132755.166150-1-acarmina@redhat.com>
References: <20250526132755.166150-1-acarmina@redhat.com>
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
index 17e1f34b7610..867845e7d5ab 100644
--- a/drivers/gpu/drm/tests/drm_rect_test.c
+++ b/drivers/gpu/drm/tests/drm_rect_test.c
@@ -406,22 +406,38 @@ KUNIT_ARRAY_PARAM(drm_rect_scale, drm_rect_scale_cases, drm_rect_scale_case_desc
 
 static void drm_test_rect_calc_hscale(struct kunit *test)
 {
+	KUNIT_DEFINE_SUPPRESSED_WARNING(drm_calc_scale);
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
+	KUNIT_DEFINE_SUPPRESSED_WARNING(drm_calc_scale);
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


