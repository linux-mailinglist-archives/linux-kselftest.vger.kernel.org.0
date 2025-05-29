Return-Path: <linux-kselftest+bounces-33972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26529AC7519
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 02:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49731C05B48
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 00:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7FC1519AC;
	Thu, 29 May 2025 00:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQul/jay"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A163D81;
	Thu, 29 May 2025 00:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748478891; cv=none; b=VghPYLsdvmve+hsV/+F5I0v/iHJgud+rUGPEF1o5FDL3rq9C641N/SnlatBfhSLhiluF0eBX7azfELwYnDTrqD/GGyTTKdixhU4Me8h7obndSGvn4DYdzyhThP/aSka0/xVxo1f+HT8NlmGQ3jPqjofIPDvMlLYYCC/6fAwymKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748478891; c=relaxed/simple;
	bh=et8BQHPfuIOihW3pxNT8F8nns/wLQ1/wWQ1CwdJO4lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oMBYgvgsIPTofXhK7dXPqbt9Ur9mwzKtum3/+mjlrABJZG29isiggzpz45yjQuWvMMTJFhoTtDVsmw1VuVH0Z1Np1KMhrOStbPT0pV87PA9rDLi5iEgTigAU6WIivTE21jcFF/KldN3uf6zJjrxHYGRNzJ5vShZ4yLQv9sBgCwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQul/jay; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-60be8b6f1e2so36824eaf.1;
        Wed, 28 May 2025 17:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748478889; x=1749083689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ERglwhE5E/w6EsEgiGx9ksfEVnryvmo5As3wii4rmHY=;
        b=ZQul/jay+WE2uJSe/Q1vb2Kip+QbtPorFPXJrof3JZI9DctILdEoReY7aC5maKXbuQ
         UmZu4zv0o5yAxaXpLlQhff/ww6JVvjVhfv2V5XsOb4PHR8yu04A8mA5fg+laCzzT/tST
         r2XtnoroNlTN8uEvKxIucV6k04nV/6C29gNd0hllMkHun9c7JadabTc1mvfltXB6GHiP
         A5gxLzHaA4E7fLn0KHYOjv6w221a9mOQJjFYqTm+1fQyc7WIrmOc4No8SGVQbFJeNVlh
         86Dj6aqSpsdPrU6oLnu1no0OSGQjL7LYYkvqEMoM2Uq8iYTeEPhcCqa8mMaaH4O4FiSd
         p5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748478889; x=1749083689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERglwhE5E/w6EsEgiGx9ksfEVnryvmo5As3wii4rmHY=;
        b=Mq7npTlpZs8geDM8HiUsflr76FwSdWu8EjdU0aPTbjwkrSeHOtgxBqbcIDo1kMDIUy
         Mb6unAJA0CLof5jwsSAD1CohCvIfdzcjEp6IEy79GghE7tpCqlm7NLgaE+RAV0TDhiwb
         eGnzc1CQV0+ngPEsX8b7GA0ZzTlbSXHNOwBqbMuSO2Dr9o28CrjDcuUYeB6DASLZeoxZ
         LSyuzH6nmPYPAtrxBlekwAcaye7g5EaWVkW2nhefnLZMY71+D7ec3//7IlnCmHVFoQGk
         Uz+C5zQRTGApMPXQMHLHkBBMdCv+f2qzoTm9Z8iJTENDzsIm8vz3ndozSypZWAMtfcWL
         70qQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3hTubfOw7pkLNRoOR2TQ9ztMnErnh/Sf2BSGYgApYox1yBPHbwQ/gdogoktdWvW5/DLo6GqnMyua9GdE=@vger.kernel.org, AJvYcCWndCMc51VWBN9N1YgZVYamhhMaJlbdmbOdIs9uMwjYoCR1odbhMLtAzqEeWb11xtRe4xoGjFSj2DJubE9AJ4di@vger.kernel.org
X-Gm-Message-State: AOJu0YzR6hoTrxrMWHeyWRv9gDAAuJfZi2i8DFXy4zSIWvvAPtvVD25m
	KR/um0AMTUXTWF5G4hce3AihqYDLxqiZUwX/P3TKvNlE/qNiJZNlAow6
X-Gm-Gg: ASbGncs+6Xat6j8lvTVc5pcLP/QTTxvCtmSdjF9N2CwFrXk4TPxm81diNYj4WQicM6p
	iI8YJ5GF/Ivxyn3xG3eaERQjgiYXuIwTJ/X2dPV+ku1obqhAXW+7ayMOdDAJ4j12gSLuaqbSQoc
	MlcINCieLcOUgvH6QV2lph4ZUGTwzhluYpQz/faJQy9H70dr8G+dBgiSstAQZnSwF+Uo0FIxxA/
	f8GA9HpiimQfM56Zl/dV8/dW8NAGFV5ljlaljtzPfuhQWqhejN9fCHH+QVYKPR0+/5F5wz2mF+J
	HGrm5N3qaXDpKsbZZx6wF7rV/WQD1xqIz3i4byFnS74=
X-Google-Smtp-Source: AGHT+IGQbLJXcwFxwTH4rcjVv8bjk5YHD7H4HOpr18KLDDrWRuJdkA/O6jpOndZnydVN2vZqafSgBw==
X-Received: by 2002:a05:6870:1f17:b0:2cf:bc73:7bbb with SMTP id 586e51a60fabf-2e86219357dmr10237081fac.25.1748478888623;
        Wed, 28 May 2025 17:34:48 -0700 (PDT)
Received: from localhost ([2a03:2880:11ff:73::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e906457afesm63981fac.1.2025.05.28.17.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 17:34:48 -0700 (PDT)
From: Tianyi Cui <1997cui@gmail.com>
To: shuah@kernel.org
Cc: Tianyi Cui <1997cui@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: Add version file to kselftest installation dir
Date: Wed, 28 May 2025 17:33:54 -0700
Message-ID: <20250529003417.468478-1-1997cui@gmail.com>
X-Mailer: git-send-email 2.47.1
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
 tools/testing/selftests/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index a0a6ba47d600..246e9863b45b 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -291,6 +291,12 @@ ifdef INSTALL_PATH
 		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET COLLECTION=$$TARGET \
 			-C $$TARGET emit_tests >> $(TEST_LIST); \
 	done;
+	@if git describe HEAD > /dev/null 2>&1; then \
+		git describe HEAD > $(INSTALL_PATH)/VERSION; \
+		printf "Version saved to $(INSTALL_PATH)/VERSION\n"; \
+	else \
+		printf "Unable to get version from git describe\n"; \
+	fi
 else
 	$(error Error: set INSTALL_PATH to use install)
 endif
-- 
2.47.1


