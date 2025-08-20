Return-Path: <linux-kselftest+bounces-39361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C9BB2D678
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 10:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9148586C10
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 08:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D2A26C39B;
	Wed, 20 Aug 2025 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNoWRyfi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C026626A0C7;
	Wed, 20 Aug 2025 08:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678735; cv=none; b=H85sq86uCSH7Y24Ig6P56Yu/GMjv31RhkpumEnDwWaHVa0QveExZBOM0oDE75nCylJoJ+EfGOOSyqaeLIKbS/Rcu8GDd6/7lTB1aAjuVM3gRDqSsIEeuamr0L2AKquJJvkrtwyiEdVK959wU2xlA6LGKGGTmcRfFaykOyV1HH6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678735; c=relaxed/simple;
	bh=je5AHg/youKOa+xhCXnHlhnCi4E0rhPm8H3bXUt+7zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pk1ClwMxlbjVFshIQkLiX8W2JwcPDyJMLs7q83YDRq1b64HWFzho0cEhQleHW1qTXKCB1rNMXPrsAW28xQJhT2/q/4MwBycaP4uZl/1iNlyauhqdgLEbnDXaPAOcQhvnxeQ0pjO6uTISHQWUAXcewZVGdtcDMgi5vi3ytizLjH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNoWRyfi; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24458317464so69930855ad.3;
        Wed, 20 Aug 2025 01:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755678733; x=1756283533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=moqMZqhapfuLQfkSPWKxhFFyVYs5GkMX6FHp/4+cuAI=;
        b=eNoWRyfibnNbzoDuDFVZua820uSMEty6JHDEN6wc5xFZpgl/Vp3bnNCJf+hQidkhmb
         avwyAE+NA/YLXaLX+74rhC8zx6cbUXuRC0YwNKX6dzJzOsiqNlnwZfYY954pTpJI2IXI
         jnWqWRYHt/cJ4CqTbu1p22Z2zYPx6yIDq38Rw5aiVtUQIXHLzTRmeaJy2PKeriFnSYfP
         R7vfbXkVgrUNnyijSLW2GQdIXU4jPYjKWI4E3xSENTaIpwbw3eEzvwhzjR+IXjZa6xyj
         DXGCo+ToCpWkNiKsn1p/YtHozImPhuNMOLDt0TbdJkt8URBSVXa4UX5QprULnezRjgI4
         PY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755678733; x=1756283533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moqMZqhapfuLQfkSPWKxhFFyVYs5GkMX6FHp/4+cuAI=;
        b=caANVg6YzYv1TaNY1mtQ83ivFymdXSVPRkQyAMtdkKeWIFIWdGQPlPEmhEkJDrKUP0
         8uEUbbXKeHdzmlBABzHO4qVnWFHV4wnKh9c4IKNCzOSrS143TLKDIvfcwHQO+GwKHtFK
         FxPESP7LQYxUyMo/Yr5qQUGwnmXNFhQcS0rZvMW9R6dT8cxOJOlks8LRZ6umqFqre9Nd
         zcG9qQultxgEYkir+GlJv4IH7Cz3ZKdtJ/BN5lgt3WyBB8ZCk1PqJ07YuF1LwJp5yzP/
         z6otVaRjDQJzzmFwJpFuaFcuHBH60STv7luuQWsRzaDiBsLRjlM0oIuXD7zzZ2ctK4/c
         QCWg==
X-Forwarded-Encrypted: i=1; AJvYcCXxZj7OFNJWXjhZVUNQYZ4rrTER/4hQq6A/XLlP/y1Vp/8ClMvTKxfhKwmsd2OUzIyFYTnNdv9/0YOuzDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKe/RXtR+ijsn3xvqdUVX4bv0z7EUQEJWmDzWBk8N+a8uWc4GT
	SJJ0+jbUWfJm6HXI78P2p+zGZnkcX/MQXr5d6CYmhDOTKmNSzfwK/k1x
X-Gm-Gg: ASbGncvyDJa7fHlQvxuuG0rOJLNJ6Fm1VPyQHB/0/yNu5ZNyrCLzaTZ3wn/mkCtOb5q
	qoIelGJMR4WPdUYHqkAz219Vu5UrubPD1+o8aD46BMXq1PjHFZ7EA9/1O/aShAoFQOPrLWnHkfi
	QN7CyWkYJKZ2exdBcdbf2nKj+/t3a0w+QCIKjCSA+JS+OXryilgWGlU3PcU+RtZuBoRaYZjQzSP
	cYyosT+544nw6keZ8ORSblIPMZN0okZAlHuqdkK//EcMHzbnKKSghfrSOn/SDBaVxIjcoT9Pccm
	npMiJyDApVkrDSyjXO8llBX1Mz+GQvTYI1cD+nSnPZ6kuFJSNH/1l/5ZFmMBQlHejftu0DS/yGj
	Y2xmN/BlCND9M8Sdcump4VJ8hbZ42AipwCw==
X-Google-Smtp-Source: AGHT+IE2eim4SIHkVMULUQJNkHWHvKzqxFkEJGI7jhLDjeXXZOKI9yfyCC35GGikBxqq7/MV7DAhcw==
X-Received: by 2002:a17:903:198c:b0:240:483:dc0b with SMTP id d9443c01a7336-245ef2716d7mr22178055ad.52.1755678732771;
        Wed, 20 Aug 2025 01:32:12 -0700 (PDT)
Received: from OSC.. ([106.222.231.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c7588sm19491085ad.101.2025.08.20.01.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:32:12 -0700 (PDT)
From: Pavan Bobba <opensource206@gmail.com>
To: shuah@kernel.org,
	cvam0000@gmail.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH] kselftests:grammer correction
Date: Wed, 20 Aug 2025 14:02:04 +0530
Message-ID: <20250820083204.10428-1-opensource206@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

corrected a minor grammer mistake

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
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


