Return-Path: <linux-kselftest+bounces-39372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93354B2DD39
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 15:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D2C6267C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 13:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F1B321F26;
	Wed, 20 Aug 2025 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L23N4am3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A065F31B119;
	Wed, 20 Aug 2025 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755694724; cv=none; b=TiNX+y7QLY7KcTMAUvJXZJxYlsrtdkQ9kuLDBTMIXiHOoEAnSm4wLLfYJuFzoWbcx7jzmEu+GOzPtSQIuZolfibRS66qqo4Bf4O4UMWPUrrWqvSaTwPX+uu/ouyWhcTUNRBvku054iyvKtABzGuObM8ecllTPjTc+Oa7tmvccgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755694724; c=relaxed/simple;
	bh=nHgpINJDHe2drGH5C7PT1dqln6eoIMjXRMAIcisj07A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QEIFtFZTCAFW9ZyUg/OXprvA11FN7RyvtU7bZKinb16Tm1OOalMrOokEvjNd+7jT0pkdBNH+j5T9cF6UjfPi1dOy58i1Vteif8Jjv2ha/ZsIuZf/e2WUI7TgrINVvUddFV++svw895KIWC71QWbX6wGoYScoYQth0ekw/IYtkkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L23N4am3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2e614b84so6097905b3a.0;
        Wed, 20 Aug 2025 05:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755694722; x=1756299522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XPbHub8z2x+OcgT/ZMk4BEFZ+J4GgVBAmy6XyfCQhOU=;
        b=L23N4am3yYZJuZYLMsrC6OedwshZdrD5iX2PZkItk+R9HW7Irug6tGUcwswQxrg05N
         3pcfeKQB+gaOz6fOaUVWN7RQeYJMHKXIfb3/vq3NT8zIsWeb0TjNAZek7UHVRr0wDoAD
         F/WETIGGl2VoUKlQqAsh6XfIaztoj/44zWG2/crQAJ6C9u6Zou9bZPBa8hOZfgvAFWu8
         23W8/YbUWYZOMyiXq1H4vojr/dDqGCqc/aYYyQPLjYGcELLJDP/HltnBXVcfzhZoqxly
         VRY8wAKoW3sb4Qza4XQtpuICppJaOLPDxwhqQWIAcuh3fLgsfY5/pYAykXem/lZxpySi
         J9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755694722; x=1756299522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XPbHub8z2x+OcgT/ZMk4BEFZ+J4GgVBAmy6XyfCQhOU=;
        b=nJENa9LQGEzrBf/i2YuYokp5JgHml2taP2ljiBgMT3X3ntPieXL6UBnzrKijXBLjWH
         TLATSZYiC54W8bx6QUOCZh52vaCbKhB5JfiNrl5VBKV0b3AmrjCPUYXGeqE+ETzTARov
         2X4k5MOmKAcoegieFogsWl+Of9af98/eJV7PRzkKWut3V0HMfix8hzCGzd9SLfS9rnvJ
         LOMbzgtZHOURjoxn0qYHVVula1FknhbLlF2IaEfFQ6slYe7cwptyygbpS19drLFg1jyZ
         NLVSRdLykqkqM5WDL7a1NwXYqRLqOp1PATckE3swO1iCxT3AwR8232rBR3LXz+L5rYq8
         J3Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVG75KF4ZbsAEVGt/YIhSfxOBQlB8YmoTJT1xARRQ6McsoaaSaoPQ4YopBTrov7tEdRqsDuOhcpCBEmKBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrYtSc8MakRWLapQLq5abrs0Bs4Cxk46GqWbZdmGxk2tWja1AF
	v2kqOY/FYK6p4/UiwL4TAfjskp7aK51wQcuxomkAJVx00k2hahRjNa4w
X-Gm-Gg: ASbGncu6pzKCsgb/gDA3vKk6YjveGSY3hxsY69zEhAtTRmImqKC8TZHbSInjairA+rp
	giyyu6ZuMCAcmKQnkZ7h4QVkZQXt+VhHfVmtc/+H+1VD3zpXhDUfQpIRZoX++bWFD2QZavhgWhA
	ZW7n47p+n17r8AYDYU8fSShL5gXUnQRzVvVtCT41nVsF9vmlNZKxtdrrgc6BcOZfwDqAjDBRoTz
	lC/MEM9mUhNtFc/d1lD4SsWoJIF0gMJO4+XI8dJUnm3oS+z5TsDSUVRzXvw4vlU9r7vnTdRPS2V
	KHzhbg7o3bVldMIAAJbezMgci+tntjP4GD4sDZoXvIuIvevOUMZFuZEcBdnKFr3bpllk9tRGcFN
	TAVcsaN6LcfO9+rVowog+4szEqLFf3s9YsHjC56PD+HqH
X-Google-Smtp-Source: AGHT+IGQFP37yXu1vsLOE6sFuwAsgV2mRpYnB68ASjcrty2sHgn5SjcD1RYT9gaaDiQdiW/oDrv5Zg==
X-Received: by 2002:a05:6a00:4f81:b0:76e:885a:c349 with SMTP id d2e1a72fcca58-76e8dd590b4mr4105800b3a.31.1755694721790;
        Wed, 20 Aug 2025 05:58:41 -0700 (PDT)
Received: from OSC.. ([106.222.231.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f76fesm5259985b3a.55.2025.08.20.05.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 05:58:41 -0700 (PDT)
From: Pavan Bobba <opensource206@gmail.com>
To: shuah@kernel.org,
	cvam0000@gmail.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH v2] kselftests:grammer correction
Date: Wed, 20 Aug 2025 18:28:36 +0530
Message-ID: <20250820125836.14464-1-opensource206@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

correct a minor grammer mistake

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
v1 -> v2 : changed the "corrected" word to "correct" word in message
           description to follow the convention
 tools/testing/selftests/acct/acct_syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/acct/acct_syscall.c b/tools/testing/selftests/acct/acct_syscall.c
index 87c044fb9293..ee2894e4f7bc 100644
--- a/tools/testing/selftests/acct/acct_syscall.c
+++ b/tools/testing/selftests/acct/acct_syscall.c
@@ -22,7 +22,7 @@ int main(void)
 	ksft_print_header();
 	ksft_set_plan(1);
 
-	// Check if test is run a root
+	// Check if test is run as root
 	if (geteuid()) {
 		ksft_exit_skip("This test needs root to run!\n");
 		return 1;
-- 
2.43.0


