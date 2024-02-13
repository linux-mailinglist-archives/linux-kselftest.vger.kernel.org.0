Return-Path: <linux-kselftest+bounces-4602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4574B853F10
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 23:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98B11F237EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 22:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF75B633EE;
	Tue, 13 Feb 2024 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvQXNgPC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141646310E;
	Tue, 13 Feb 2024 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864421; cv=none; b=dbCfASOgs/Sx3f26HfrmGuBwgcpQlZaije0WYzU2ghIIfj5vSUx8mM/rBUHWbXUOi8tT4whg7iTCZVQhOeN5kTNoAQycISr4o0tmPH7H5KmR7EHqVAN69aaRdldRYEx386hLtCOPk2ZnyAPQlDby8kXk8lqS5OhWCprY3xv0rOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864421; c=relaxed/simple;
	bh=79sVC2xwZcWf9em7+im8l8pxbyWTZViteqZQC3s1w5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q2f5fZp306be/h4lu0dtFa0XDj/QQJJ56dxCMFoyAVA0OHplUvWpt8qvrczcWk/TfcIB6tx5xTKxsiVIoTE7xrAxzgwrFGNAIfNrdtqSFgimIIZnDJ02wcHinTMQb+D/e+/7KJPj2onHAPDcBr7AP/qO5uLE8kpZwqlM01pNOdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvQXNgPC; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3d159220c7so123531166b.2;
        Tue, 13 Feb 2024 14:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707864418; x=1708469218; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPG8iWh4xmglJXdCUV2hXb98YGfDYIZwCuRxjUIHlFc=;
        b=VvQXNgPCuM5zM/fYlDKqsqH1zsfFVyCD00SXAfNZup5m/c3V22kgHvHOkkBw9YihQw
         UOX7sRBlrWmG2PmW+PU98bJaEaHVBe5Z3AVg9Jqb9aB+ID4LDw4g+VyEgRW4vnXU/WLu
         PnVrx/MfGKHL9KlbxDrIAmQe7HpG5I7Ltp1SNzhNu31EkwhpFp+As3IYu5ltMNLCSU5y
         BZaY/gRnnvv+0618vJNjRAmKlc27/q80nlijYh0c0jze6G9eWTrQcDTD2QW/ePMEKeXI
         HKTiRbfy2gAwMY8y5S8xPs0TPYJRqVUtfHiavagwKZlIVJeFSJLRL+p/VZVd0srlkOE4
         sdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707864418; x=1708469218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPG8iWh4xmglJXdCUV2hXb98YGfDYIZwCuRxjUIHlFc=;
        b=pFz/6xajtJ8pLgtRLN1gjdjZz3OvYssTnmCTHBFKsVSpbx4K8L8V0lrLZxwlLRViGE
         2vxU0wnJsCC0iaBuwh+FS1cqtkbo0aZDlN8vHaTViM5I2XIMRdXBdMXNJQTNJz20BChp
         tcZ6e8Y4n3W1zYfVT5omtfpy5MaoQWBEwOA8NuVrQ97FFmbW2qRzC7tpQ9fk634t40C4
         DQxeNPoIu/P/uKW+rHIyatRuk3P29KcyEARkSmp1TzezDno9kBcpfc8Q4HwdV4q/Dksd
         ++qOZquCNMm/iNTpkaDcPP6mvpXZD7Zh31dFaA541xtTuv8f9rC3d1DJ9/UHRRGLZY0x
         EbbA==
X-Forwarded-Encrypted: i=1; AJvYcCXAl7ygOlVLwpbZYOKU1YrBTkJydDKGtK/fu667kxFvbnLdw79Vh7T7mlVg2Ux0ZaEcO1RnpMfzB0AZVh2ZDd3pONys90+ixNHIxM1prw91
X-Gm-Message-State: AOJu0YxeVzW+meFlO5f1YyhTciz6DrgQOawkPekN0nkykwQHQRDs3hbM
	tIErbTJi7kfI9QaDdOAXt0OvSxRSN6yfRgr3KDgtGy2PmIC1nE/9
X-Google-Smtp-Source: AGHT+IGXiOrzqlpXBA+LtH3COe62AS9Q/cecLumpGLO9H0eR0Hz99/rWvxobh7sl5zAkl3fv9XSilQ==
X-Received: by 2002:a17:906:f158:b0:a3d:1458:5e58 with SMTP id gw24-20020a170906f15800b00a3d14585e58mr456500ejb.46.1707864418399;
        Tue, 13 Feb 2024 14:46:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLZJNZpLWzk+pfh/liSwNPjMprY7Fr+uyOu5A8HW/YQ1k9kI0OOPUcoiw0XHxrNKTF5gi51BoqpYFSokyWV8d8qHFpOXDlNz34RnGloWjFfN4AhoHCGcKSNWC0l2mq1g+5z7jAvEXWI3/8Y/aYYLyDIdl8W2uq8g6Of9jqm6tWr8ZA/9EL3bKTm56UZnzzutUDKqAXTst1wuh/6kV6EMCdkFSAPLcW/eGmFpWYZ6ppFPe3h3a6GmGOTa46Nsl9McgvgmY4
Received: from [127.0.1.1] (2a02-8389-41cf-e200-6ae3-bc23-bc27-2247.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6ae3:bc23:bc27:2247])
        by smtp.gmail.com with ESMTPSA id b17-20020a1709062b5100b00a3cd41b3c19sm1700077ejg.199.2024.02.13.14.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:46:58 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 13 Feb 2024 23:46:52 +0100
Subject: [PATCH v3 3/4] selftests: thermal: intel: workload_hint: add
 missing gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-selftest_gitignore-v3-3-1f812368702b@gmail.com>
References: <20240213-selftest_gitignore-v3-0-1f812368702b@gmail.com>
In-Reply-To: <20240213-selftest_gitignore-v3-0-1f812368702b@gmail.com>
To: Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>, 
 Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 damon@lists.linux.dev, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707864411; l=762;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=79sVC2xwZcWf9em7+im8l8pxbyWTZViteqZQC3s1w5c=;
 b=rxVm0HCSYW0Mmc5c3paZJG4pRTvet2GvlViV0bYprApnV++3xoyxHgO3PdRK/jpj3ep2zXhdO
 oiSwRnhrlZWCjOWSn10NugDSeKIiB4PVLdmB9GHTVZM9IOJXj/oJyVp
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The 'workload_hint_test' test generates an object with the same name,
but there is no .gitignore file in the directory to add the object as
stated in the selftest documentation.

Add the missing .gitignore file and include 'workload_hint_test'.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/thermal/intel/workload_hint/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/thermal/intel/workload_hint/.gitignore b/tools/testing/selftests/thermal/intel/workload_hint/.gitignore
new file mode 100644
index 000000000000..d697b034a3a8
--- /dev/null
+++ b/tools/testing/selftests/thermal/intel/workload_hint/.gitignore
@@ -0,0 +1 @@
+workload_hint_test

-- 
2.40.1


