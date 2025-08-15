Return-Path: <linux-kselftest+bounces-39022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E21B273B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 02:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A442718890DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 00:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371C42A1BA;
	Fri, 15 Aug 2025 00:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jy0G7w/i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB6B3770B;
	Fri, 15 Aug 2025 00:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217242; cv=none; b=l/9sgF545hA5bBSSPQ/BCd1O0vhMnK/hTc/pPgSMpyjLtO6LjiT/566x9kG+WooT1DzunptJqmwyXmtHiM5ODopJQjQbiKkkXU5xlJ0DdN2BR93LtZl54z4EZWRIxlbntz4Nl9V9NirDco9ZeschdxHqzP2/TunbDb4bzm8a3x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217242; c=relaxed/simple;
	bh=hFs0cLWyxqAwZK34s7vXW7yh2tJtIViqqYlP5dO38Js=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Piuq9MDjAHkdIPK0JWIFEqeY0cB9YW27d9vC6ajXT9ljhYZx194GTfLjUVSAGTNvDORIML/FJwaalGH8VMdA6a+cCMTPbLMZl6Os7/dYZDLvfmyiUPlP2VjDjdODELrHV44fGdC52roT1EFJ+5hIIEXojttf5tcp06tMtTICwXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jy0G7w/i; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4717390ad7so1102321a12.1;
        Thu, 14 Aug 2025 17:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755217238; x=1755822038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLbE6JCY9Ni1brmHRZ4l8BhTOmOqCVNI+jbKD72cn6c=;
        b=jy0G7w/iwG71qhEkeSz4b8P+mXOsyFA4UJcH+vGOyza73PGG53EZC1iEcz7i1XyTSh
         Zu68lQNt2jaDgotUqSygzcrNHf16hvfB8CoCF42lQntTv//LQxd/05lrS9iVJlo36FDI
         oDwmLzSHfOYIJDY4V73E/3dP67YSJJXgCRHnokx7QjbxzL5S9a3gsewvCHqA25qO7+7L
         LN/SozdFLGckZH3w4+Sf0zzvKvenJEVDHqulQQOVtL2PNvM8xIarMZv2G076c2qR/8d/
         rlFbwY24Z3UReLmc3xYvqo2qrfNLeW4hUjfbsvp1KykWeVIm7AV1E2LdjPc8JirJvZY9
         h/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217238; x=1755822038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLbE6JCY9Ni1brmHRZ4l8BhTOmOqCVNI+jbKD72cn6c=;
        b=hKmjljmW7Mr09s/ke2D+a5lBFO0/gW3LPMaImJ6AsIGEXTA54zyS4L2OF3J46C+e3Y
         n+MZV4cJd9l/B2WZmZOdjjIqOGWp6epakwKYSQeBMWtRreLS7Nsv9IB0qlQBqXQaVnCt
         Mqu7sSU9EF0DH4uLZBxlP5pbQjMwOajwNLMQsbKtcSqXwOkVWoW84mLeQCdyYrMqkBl5
         AIIM+jN6ugOaNmJqLrmGTneRkLHFQ/NHq+22T87JJGzCjKin7uS8jn5SDUIYRgaro0xY
         GFUQ/eGiQZw9fsS0heh1SUNNoJ7uwDM8skIq/VYB3InV0GRf/GsLhMJ99OdxOED+tiUV
         C0Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWXyaRi2tbGXw2kPp1vKTOHf2Uvt/hNjSUHuMFSzwo4MizZdYg6OC3Wx1ItfoxrveAuBE0=@vger.kernel.org, AJvYcCXY9wxzhJq+sG0Fiz1JXFiFeQNyWpsqAEyigeSwjbpsAkv3ApTJkj46wiJScSgXtlN8/oZlNYIsPYd6r7md@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtv9E6EtwCEiki0AxMRtqJCXyuKAIH+esUxjh1wP/h9OfJnIgY
	ohHcMLg226ga4uak/Bu+Bb9b6DVhmNwYejZt7J4RkAgyN6PYRaLsLUYlq2eEpMAx55g=
X-Gm-Gg: ASbGncuwtkiMv0bRboRI+1JOI2Is+LGPw+DUkUrSeoBnsmfSIDSPo7umNvg3WvbCY+2
	LLOGWy8SPubIJLwGBSqnzV851P7xM4v/oP09e64ny9wQ9fqVHmg6ZF7CabeLbkMK8F81eHCwnWx
	dEEDNHoAqqkqTtGbfpaYkOBDjQMCn7VxTI5q7FlSqU3bfFFBDSsBryoUA/78JkBy6AyOSJ2Xyvo
	WzCJ2DFCXq1GJaZOO1MgIL5eTpCMYhaIqsql6P2UsfLzw7XrCl2Xf2ytOmCrSO2fVmD7rvTzE8N
	xv5aeSZB7BkDiYSaXiWAl10HVhEN3zVh6sGZv9JV0L0oCh/8+aqtvQxj2lreeVmih/Vw3s3ICpS
	tJcE2VeTbVfVlCO3CBp+CSuE7k3qLBhI=
X-Google-Smtp-Source: AGHT+IHImhF7ByRjCismIkKBnfVsotaqnqH+AYXv4duGZMCsez4RBkt7nElgUuAdHYzKpI7YQbWz6g==
X-Received: by 2002:a17:903:2285:b0:240:49bf:6332 with SMTP id d9443c01a7336-2446d939889mr1456305ad.47.1755217238323;
        Thu, 14 Aug 2025 17:20:38 -0700 (PDT)
Received: from soham-laptop.. ([103.182.158.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d5a451esm700745ad.165.2025.08.14.17.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 17:20:37 -0700 (PDT)
From: Soham Metha <sohammetha01@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Soham Metha <sohammetha01@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Subject: [PATCH 5/6] selftests: kvm: s390: fixed spelling mistake in output
Date: Fri, 15 Aug 2025 05:48:02 +0530
Message-Id: <20250815001803.112924-4-sohammetha01@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815001803.112924-1-sohammetha01@gmail.com>
References: <20250815000859.112169-1-sohammetha01@gmail.com>
 <20250815001803.112924-1-sohammetha01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

found/fixed the following typo

- avaialable -> available

in `tools/testing/selftests/kvm/s390/cpumodel_subfuncs_test.c`

Signed-off-by: Soham Metha <sohammetha01@gmail.com>
---
 tools/testing/selftests/kvm/s390/cpumodel_subfuncs_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390/cpumodel_subfuncs_test.c b/tools/testing/selftests/kvm/s390/cpumodel_subfuncs_test.c
index 27255880dabd..aded795d42be 100644
--- a/tools/testing/selftests/kvm/s390/cpumodel_subfuncs_test.c
+++ b/tools/testing/selftests/kvm/s390/cpumodel_subfuncs_test.c
@@ -291,7 +291,7 @@ int main(int argc, char *argv[])
 			ksft_test_result_pass("%s\n", testlist[idx].subfunc_name);
 			free(array);
 		} else {
-			ksft_test_result_skip("%s feature is not avaialable\n",
+			ksft_test_result_skip("%s feature is not available\n",
 					      testlist[idx].subfunc_name);
 		}
 	}
-- 
2.34.1


