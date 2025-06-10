Return-Path: <linux-kselftest+bounces-34628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7D2AD45B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 00:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2FE3A6202
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 22:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AC82857F7;
	Tue, 10 Jun 2025 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXScD7Af"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A207A23BCF8;
	Tue, 10 Jun 2025 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749593582; cv=none; b=pkq+dtssBi/Snd3+ZEMJV2c2JzsRqfB8SpTebteo3CpwMqXDT3FjZa65llwH8R0ozY5k8262rQT2jsjtmNqzmViz/hIRLfDvDuSw2CN/wQqwf3F0RRVobtiXOvswYgT/MFNGbGb+ds+DhqaJF0FSI4dI9xMOZ06DM6wdKJPrb3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749593582; c=relaxed/simple;
	bh=dUnGnzC0B4vIJJw5xJW5XmpXYtO+8rFDcTfQdHaZxFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYV1dk1rmGuIl32MuIP5zQEDymogPhls8g+hXQoRaOG1rr/cc15jgx5TYZWPRge6waY2JsRL4VJjsSbXg+KCJJqvfcgpSeaVwJ3J6jm/ThMOB7klyB7eEehYEUeJn648w4b182R/K/Z6Nhn00a1W9yquvm6sZ1KCE4QLyHWMzgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXScD7Af; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72ecc0eeb8bso2069357a34.0;
        Tue, 10 Jun 2025 15:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749593579; x=1750198379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miJIIaQXJwfBDVJT+vNgy7ymqu4g3omH3mBgLBTXCcc=;
        b=dXScD7Af8+XPeP9v5PPm6oQtv4MTXEDY+4vYMLXSB1yu0DVfcaFD2UFL3sMlOXyj33
         04r3z8OLlaZgp1HVXGHxIuQwpSqqQI5IIQM1m3pirLcuNFTanSsqgyniZ6XP24WXsIFH
         bh3xZWiY4a6xjF6WMGhoEqeD9w0M1yQYrmwM1hwuwFkNVxq5EnPLMqmSQ5jbF/2jARUo
         gos25nZ55HbZXebQMkpR9UHJNi6zPPC0CvVI6mmhVmAE7ByPW6Yvoe+yHFBNmFj9tO2p
         /94ti3qmDPPv0zxNYsXvR7npQwekPJvXMolUc3Al0aIX8Umjy7BSDD8tYDgyqliqRDiV
         4Qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749593579; x=1750198379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miJIIaQXJwfBDVJT+vNgy7ymqu4g3omH3mBgLBTXCcc=;
        b=JaSMDlE3INuasZF30VsIcdYl5Nv0Qf7yS4rnPpGU4JpnVMJVzCgNt+rHPa9avKPEQe
         3tBxk7dwqC0H5plLG2+EcM5ITI1GRjcAbcvStzd1CFZfj8Y+K8IYQ/qtpuwRZFWkGVZ7
         AlAdhUPBhVfRJ0fA8mp/P8Z/SNzgCEySTPyn4UC5le3y57s3LLfiElLBJZSal5YNnWlE
         MXcHPwtmk7zOnB9si1sfVE//DdjJAGRKOq69bxOt3uVDAoFahU4GMSJb/vfPljZdQOA+
         dvof4yrvE2VYbd6jtHs9MO/YS2xgWbgI+CGroSN+enTzeQBq1emnPXEnkawavlxGcnDM
         5JKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9UDoEZt/pdqNo8n/6HpMSq9W1s1pIoKhYrrqTTePQ9f/8O/PDBKCD0QAIbt8Tkqx5R/IaTvO1S3H6w/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZYb1uR0wQjTqove/3vXpbwlsjiNpkkpmx6pSg+nHifPK6h2gm
	U9l2RBYW7F2AwDXcNEiDEaX9pJ8YkvqCfxafitt/X2mtYjGdXmjxoUoOhltSaHwo
X-Gm-Gg: ASbGncuiCf6lzzXHIwTQ52mlMaJ/UW6TVmrBnmfA5DVShhDEqOWyIAcoixqtFRBBror
	pRin9fKm02dvcongtjo3A6qJsDJEc4B/XuJksfTKH0DYXSw3jhsXfwmLZP3iakcsSpMlvGRiJES
	IsLowzNqk/VXzXSK44FmFwAzJRMjADOvdYHcpWg/Unx51QgRhEPi/fkMN9Su929XfY44t8watrh
	iq7epq6sn0OiG77sFNTyhAacte27WgHwjMA63PU+NUV0so5ZhtVW7yYlu/T0xwSI0Ps6DYjyf42
	e5Xb2yls9YEnd04AHhiMFVS617TN9DQwYA6OtBXCuJUXSrAaPliE
X-Google-Smtp-Source: AGHT+IHd9+gRIy3z8xzI0EHTDv7lfRb/YIhkGWPWNcx+KYA60K7CbJiWsHeNA/cqqc7bkIZt1/PSug==
X-Received: by 2002:a05:6830:800a:b0:72b:98d9:6b2d with SMTP id 46e09a7af769-73a05974374mr849676a34.8.1749593579352;
        Tue, 10 Jun 2025 15:12:59 -0700 (PDT)
Received: from localhost ([2a03:2880:11ff:9::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a06fdf538sm95334a34.26.2025.06.10.15.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 15:12:59 -0700 (PDT)
From: Tianyi Cui <1997cui@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Tianyi Cui <1997cui@gmail.com>
Subject: [PATCH v2] selftests: Add version file to kselftest installation dir
Date: Tue, 10 Jun 2025 15:12:07 -0700
Message-ID: <20250610221248.819519-1-1997cui@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250610220319.405806-1-1997cui@gmail.com>
References: <20250610220319.405806-1-1997cui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As titled, adding version file to kselftest installation dir, so the user
of the tarball can know which kernel version the tarball belongs to.

Signed-off-by: Tianyi Cui <1997cui@gmail.com>
---
 tools/testing/selftests/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 339b31e6a6b5..9dae84a74e7f 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -293,6 +293,13 @@ ifdef INSTALL_PATH
 		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET COLLECTION=$$TARGET \
 			-C $$TARGET emit_tests >> $(TEST_LIST); \
 	done;
+	@VERSION=$$(git describe HEAD 2>/dev/null); \
+	if [ -n "$$VERSION" ]; then \
+		echo "$$VERSION" > $(INSTALL_PATH)/VERSION; \
+		printf "Version saved to $(INSTALL_PATH)/VERSION\n"; \
+	else \
+		printf "Unable to get version from git describe\n"; \
+	fi
 else
 	$(error Error: set INSTALL_PATH to use install)
 endif
-- 
2.47.1


