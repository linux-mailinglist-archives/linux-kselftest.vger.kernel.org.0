Return-Path: <linux-kselftest+bounces-9160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC7F8B81E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 23:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103A81F24740
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 21:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEF21A38F2;
	Tue, 30 Apr 2024 21:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdJljA4Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2318A199EB6;
	Tue, 30 Apr 2024 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714512517; cv=none; b=tyZ0z18VBDes9Asll4QhcnuySy9jmpwdB/GQP/oYd8KQdYqXSL3h2kLScgmFxEWOoXzu9BaH7FVsVa5zQ81j1pk4aZyTzouv8PUtauUneFUTMyNZs1ppiY8PA5ZY6VytHRkRPumciyw3f2lx1NSAABZ5aEqra+jSOT0cCUlkfPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714512517; c=relaxed/simple;
	bh=spJ1X/XVz2l4YxRBB3S8D5s5rTkO52DHF/PDHeGLeOE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hWYOqDS63LWh60pkpKWjO90qyLwaK00yFGCQua0jyZUyDJvy6boUbAfFA0nJlgIs9Byaozu2tqIExv+X4BpX4fyMgXPEOubE7nO5dhVfIK57YvmnfLep95OQSNZnhvDSYUna0yyahT0S6a6l1Jiq21hPQZ5A4B+v7EcuZQ5PeiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdJljA4Y; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-518a56cdc03so7067099e87.1;
        Tue, 30 Apr 2024 14:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714512514; x=1715117314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eEAcAd46dLi8Su/AUSbpch/nv/FSmxZB9FP904cjCvs=;
        b=IdJljA4Yar8DW8Pezl4XUapUK7o0aL2xP5y4lBjRGLCuMrqxsegcCfyq0XJsHqPLg6
         y4MJTr3AVwIaB7fZbP+LB5AO28ERS8+12bu8MUVKRcPn8TZEAiR+IX59RB+BE4yNsQW0
         vy1c2vAjIh65YFkuj8zwwesJXvsapRwIIZSvIvOM0sThFlIhEAkeMpZyokBbmOUwlv+2
         Hr/tGRHdKl9w/acIsv7vN3JTuvcKPAr+ZMDMgBOa+lGcU1ELFQVklQYLP5+UaAbkFWfn
         cO+JMmDFBCW6hcjNwJFR4Kda/yGbjFuGHTjCd9UufuFaAm0VqSrbDZLcqJteFO/c0d89
         +l3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714512514; x=1715117314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eEAcAd46dLi8Su/AUSbpch/nv/FSmxZB9FP904cjCvs=;
        b=nchfML9MJ3APaYuTDP6ovLL6D9SU62KjCn7cQUJrumUFRlRW3fiXdufVQeFadjX79V
         QUzn+vDPPx5Hun1PlghVb/byY3zKCb5oMUfcAYBb9lVAVyc8D3cF2OaydMtLaMpUuT2y
         FjI4z2pfugv7ZWqQQrQwHqf/Oo3hSU5ZTgxCXi6DrkpTcS621S5l2d9hBm6DyBQ/HKjN
         /6t0BKs21fSQfoTYTM4QE5NEeVtVmJU0Jt+oW+aSBwrjYFiIIeVxjq+yCHWA/jB7TqlJ
         sL/HyqMlHLwQVpCWnq3FPmZuQD9yTfm5g+gpM0he7qPBcXuxOVYthlgbCC+3IEBSnZX8
         MS/w==
X-Forwarded-Encrypted: i=1; AJvYcCWk6MAFneyxdG3GutiU83xFNHk4AP8XSWAK73xuZ2KmhDlV+Pv2Wp/UgL3qI5WPnjIMA/Hqd3c57LMqeV8swjgTOGrqhNoZEjYkdnJ3k2Oa
X-Gm-Message-State: AOJu0Yzc5wa1PZHvANBJe+nr64q1JOqA0Kw8FMlM10U4iXIJU12ErhGx
	ysukyumH53UlOBCOTjwSOeE4XKuHsWiYBNKKSutv3gWTQ/7O5Q==
X-Google-Smtp-Source: AGHT+IEunTzQGTWdUwtf2jZ+KujlH3D1v3ImsH6mG7rpwezhNpBLN3ERAfkycYI3S5NAoxMBETw3qA==
X-Received: by 2002:a05:6512:3a89:b0:516:d692:5e0b with SMTP id q9-20020a0565123a8900b00516d6925e0bmr435192lfu.54.1714512512067;
        Tue, 30 Apr 2024 14:28:32 -0700 (PDT)
Received: from localhost.localdomain ([85.89.127.166])
        by smtp.gmail.com with ESMTPSA id x33-20020a056512132100b00516ce6a6f23sm4581020lfu.271.2024.04.30.14.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 14:28:31 -0700 (PDT)
From: Shengyu Li <shengyu.li.evgeny@gmail.com>
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Shengyu Li <shengyu.li.evgeny@gmail.com>
Subject: [PATCH] selftest/safesetid: Fix uncaught return value
Date: Wed,  1 May 2024 05:28:13 +0800
Message-Id: <20240430212813.11910-1-shengyu.li.evgeny@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch captures the return value of the ./safesetid-test execution 
by assigning it to the variable errcode. This change ensures that the 
script properly handles the exit status of the safesetid-test.

Signed-off-by: Shengyu Li <shengyu.li.evgeny@gmail.com>
---
 tools/testing/selftests/safesetid/safesetid-test.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/safesetid/safesetid-test.sh b/tools/testing/selftests/safesetid/safesetid-test.sh
index e4fdce675c54..0ebc6ddc4b6c 100755
--- a/tools/testing/selftests/safesetid/safesetid-test.sh
+++ b/tools/testing/selftests/safesetid/safesetid-test.sh
@@ -19,6 +19,7 @@ main_function()
 {
   check_root
   ./safesetid-test
+  errcode=$?
 }
 
 main_function
-- 
2.25.1


