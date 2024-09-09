Return-Path: <linux-kselftest+bounces-17476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D658970EFA
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25271F20EF1
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47991AED2C;
	Mon,  9 Sep 2024 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+z96xUQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0219B1AE845;
	Mon,  9 Sep 2024 07:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865705; cv=none; b=h7KlWigR8MwBeJ5QyTB8jdBMsPlbWP7NpdQ2YRWH5eojljcmYnnQvpq3yzhfteV8F84G8GAcEKHQ6i+Uvvcr+SZEF0rh0Wwzg7LlCsd6qjbBZisXjsjDLVg9Uvp9dumj4gmadzm8h77mOAuC1LHCBGtT1Ik5T1mmsUTYisyA7e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865705; c=relaxed/simple;
	bh=dwpD06pHM6cKKxt34fstEUoMKuSyMqg9srk/BNxTwYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZE354D2KR8omTdhafibdwA0U+V4RhQf1HxFcyBT0tQEu7nK5wWlGyurGj5UfldkdBZh0q+uvVuSuXCivGSTlUZSs6JGTS7m+amOPLEd4dwbjpI8JxRY6D69SkLnfz5kcc0urc6Anb5cphN/8rPlH8C+K+G9ETdkM7MKAfKTCfDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+z96xUQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cba8340beso797305e9.1;
        Mon, 09 Sep 2024 00:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725865702; x=1726470502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWDfXNbOPKK8OkK/H/srkd9h9NgocC7Imjlm69NJz1o=;
        b=N+z96xUQ5w+bFfA0o2lYwtuNy1r7x0MIJbJ/ZUtEtIkVh6SaTw8NZcqpXaXileY9q+
         +FQ7QET+YwGEAzIaE+EbJmoOBjKP+K7h5Tal+4Yw+Csj/dJTAvneFdVZByL9tXvetVAM
         R3HC6kf7SAL3ShvgfeJVvjeAbbWi0Bn5688VaXzgkDm/a2Qm7Fo8xVy2VgZ5Oj/6/Tz2
         GGxSws2Lsd1niRnHHuwEiPVvfSoY8kRiA6oiUR7p133d9FbEcvialJja6lnwl0tEOm9h
         LhTyDq1d8KqaqMRjcfcucVHKevFF1f/Rf1RLrabRFGxcMfuPWBkasExJlBFDfvyxZAu4
         Qk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725865702; x=1726470502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWDfXNbOPKK8OkK/H/srkd9h9NgocC7Imjlm69NJz1o=;
        b=DlDugOTSrAETPQ0zYnst3VGBEOsNeyfjoOfaXkUCLWJ5clRCCN87dNojuKslniVg3z
         scyqLLIn2fp1g7xtqS4tST/31sxvs3+5oyo6v1Q5yCYW4PvlU1G5pOYUk5xuhox4fxMj
         kG2CHT2gmG2IoQ8jRdJ/Hqd2xTCRw7p/S0JbdnXFj+/491hALR030eGaMAhKkprxKu5Q
         KDYexcvaWdiiV1CJ0sdoh+cHdoDUHfowW6HL9JlwFC/10/MVtrv8HomurQLEUbNt12CE
         L86eWy+gvq+n3rJRrzkO2vwBRdf0hPRlyU4BEo8YIR+gkKxIZtFMCufkdRxiky6vRG8h
         bjBA==
X-Forwarded-Encrypted: i=1; AJvYcCU6aNMojCpJ9bDTnTKaNd42z+wFlVjzn4p2TERT8cxD1xoTIaSRudgePycKPFQXdF+kxULoSFD8xBUv33ZhoLbL@vger.kernel.org, AJvYcCUA3ETg5uL8G+vPY7zAC2+IEISFRbpmacLDS4o/kjbn6IEvy3D+UOWO//6MKTQ3VdxCuvc=@vger.kernel.org, AJvYcCVHk5KrNL303cXX4uGZYeMw6Q7jNui2FVs19TJaL+PMHrWqPGL7eyfayHJuFuvr5Fs3D5ej6mCYuqJrqPBi@vger.kernel.org, AJvYcCViEUvjO+Pt5gPM7/ejrx9KLswNwniWyn1NM4bOnYEAdHy79OITpUaox3hxJHsCztrx7Sb1/uG7Ii6OVOw=@vger.kernel.org, AJvYcCWo8HZNc70UtIUW4EEnG34khV2ptZ1WEIbVAjJvOaDRmwT6y9zaGg2R3E8BYliWMK2u5aiRQ3MuXgFwJg==@vger.kernel.org, AJvYcCWxfCi8GY09qIqlOXXGtTWuL4uQE1E2tkRrgKT5G6jXbsE0dv//pPG3FSSW9ZkhqJrus1MuKvd9mm8RZ01AsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzONQhwW2zZa/I14dp7eH1QbquiL2v6iXTR6Fjs7XmRRU4MufJZ
	AAQSxsle9hCdv1NC471gVtmANyfOiUdHUMvSmueHfh/oM0MV8plx
X-Google-Smtp-Source: AGHT+IEyQpNRm6Z1Ke3uw6VOA9a0jndOIVoKsF8nIAl4IA619+tgnWwmZALCM8p4dz4tk9TqSiSrJA==
X-Received: by 2002:a5d:5406:0:b0:378:7de8:df33 with SMTP id ffacd0b85a97d-378888478bfmr5359523f8f.31.1725865702294;
        Mon, 09 Sep 2024 00:08:22 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d375asm5178754f8f.66.2024.09.09.00.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:08:20 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 04/19] drm/lib: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:05:18 +0200
Message-ID: <20240909070742.75425-5-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909070742.75425-1-ubizjak@gmail.com>
References: <20240909070742.75425-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Substitute the inclusion of <linux/random.h> header with
<linux/prandom.h> to allow the removal of legacy inclusion
of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/lib/drm_random.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/lib/drm_random.h b/drivers/gpu/drm/lib/drm_random.h
index 5543bf0474bc..9f827260a89d 100644
--- a/drivers/gpu/drm/lib/drm_random.h
+++ b/drivers/gpu/drm/lib/drm_random.h
@@ -6,7 +6,7 @@
  * be transposed to lib/ at the earliest convenience.
  */
 
-#include <linux/random.h>
+#include <linux/prandom.h>
 
 #define DRM_RND_STATE_INITIALIZER(seed__) ({				\
 	struct rnd_state state__;					\
-- 
2.46.0


