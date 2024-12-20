Return-Path: <linux-kselftest+bounces-23650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2129F8ECE
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 10:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0818166344
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 09:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8971AF0C3;
	Fri, 20 Dec 2024 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Wm1U6xVB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4900C19DF60
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734686267; cv=none; b=j/hKGPjvQJU3uG5skL+PVgssYehZedXqIPGam2geh2aSDAz3Z47+e2ovto5rNWMH/COKB0he4uei+bqwvpCWF6wX3eF2BJ2/bgq3n3XFKKanRlcl5vlESnwIw4VXZG5FscbNPED5SMfUr+xEcJi950dM+XvgJBnhFwEOhhr2tnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734686267; c=relaxed/simple;
	bh=XYOw/Zc3iXlz3LpjVd2mogDTIVUJXAepgheAaLrbRoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UItvOHVKx64wVqpUQzwra9R5J0TXJZvdK7cz+h797k8UJTAnCEsOBxiX4IpHhmUqd2rCp4jOiUPBE9ceMfHa2jtrsGLLTWP9gHBcSA5znfjDVtQF8w2R5LIGvFrIgSTuz1kSZARgt7eJLdJP2XyPug587VBT7HWPW8GvFkstiDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Wm1U6xVB; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef8c012913so1200109a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 01:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1734686265; x=1735291065; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TP5qOjrI57kWD6zWMzt52g3yBCK0dgwWUIqK6kEf1tg=;
        b=Wm1U6xVBfnpuFvyAw7GAfs8mSQtMuStbs3e7yWyvaWY6OIydE46BjHveo5J6mvSem3
         XnP9KXg+nViiZh7dwJLKy3kXIS2fHGq5GdDUE+er0ShEL7hspS8JIYZw67qRu3gsIp8s
         WB1nWxcwVKnGBxI5iKDopgSQnZ6sbOU3rVoysxA6NgsTTTnM202q2VGfQ0nnfsLzyNJh
         zysTDmS+hvHi9UBdINsDxPwRpJoRLDQRD2OrTYFHQS+5LWpn4exEUTPv/sqNbWub4Dsw
         WgWhUg9dmkR7EtdVJjPj6x28wDdtBHvVrskyZIvRMYPXyG+C6jBLgN8I2WMRVnjbWGXx
         L5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734686265; x=1735291065;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TP5qOjrI57kWD6zWMzt52g3yBCK0dgwWUIqK6kEf1tg=;
        b=hzRh3YzpN9NwEUvG9eNFgZIPdqO/jOJ513HVbre9QDecM59DFx3iWbyjolKsVbUY5y
         +fkU0BuW1/IMHZx4tsi2e1EhO8tGWmOvgQl/eGtrVnj2+rhKHjgrYmr3SqecC2Qzgzmw
         qNEM1kz6bjQ2E6hWNtu/2b7K/pMGDA1EG+FdMKW1oon4FPlKJhHoye1dEgmkMMoGpw0N
         qfqXsjvnn0T+fQdYElmbievSMS0eGRhhIyP7Nu3qUD9f55WfHTPpJowXBh8jywg/jQJL
         T7fQb37HKFRJz7aonEmk052WRqaY2RrgJi4h8I5zdLsNVer3gbxf6dvBaqeE+lb9/WHv
         YBGA==
X-Forwarded-Encrypted: i=1; AJvYcCWaJ3L8+zsnieTL+X7UYDqTFFmkSeTzhrTixmX5w+7JK4CRlwwFRpBNdRY+CfOm+7lQ2k73zPwhe4yP2FcgbDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ChUB1RPy5r8sx9ZHc+GH3nCXBg7B/HXQZtFJ8GufnV04AM4N
	HFQYfVTgJP8sFjfOlejHqC4dxcJ098T8vizbsuO/RpubTRf6wb4CMz+ltTNz67I=
X-Gm-Gg: ASbGnct+BtWxqrH8IkdKP6loTrsLHNVcdeH06UOxX/0tDJfEo4lgtuX6rZ3SZe9Q9EL
	lglP79HOJNyPfe4Xm7nZsz4CsnZ6XTkrT0PKmRacnJAEQh1Y/WRkl/tsDR7MDalg2VkdhJXyPAL
	PxaKgosrvqOL8kffXQ2rHKDVYgO3iep3ZnlRO55cH/gmcNUYGKcgBKULIYY6fDk88msgBW+yHq5
	mynsHpxhO1ypg3akJV/bqFa8Zh/IomD0xQc65Hvu910NxPl2vigImreTGQUWN4ftSPzwH3i8j+4
	dp/D2yZ1qB8=
X-Google-Smtp-Source: AGHT+IH9rFiaKDarDUSmEqp+9KpE/3RMz+i1dnvxYBYVDuchWTO2rEyPkbRw2EmqUNEub9WFrbkr5w==
X-Received: by 2002:a17:90b:548f:b0:2ee:8aa7:94a0 with SMTP id 98e67ed59e1d1-2f452f014f1mr3159829a91.32.1734686265637;
        Fri, 20 Dec 2024 01:17:45 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4478accb3sm2806715a91.51.2024.12.20.01.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 01:17:45 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	andybnac@gmail.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH 1/2] tools: selftests: riscv: Add pass message for v_initval_nolibc
Date: Fri, 20 Dec 2024 17:17:26 +0800
Message-Id: <20241220091730.28006-2-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241220091730.28006-1-yongxuan.wang@sifive.com>
References: <20241220091730.28006-1-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Add the pass message after we successfully complete the test.

Fixes: 5c93c4c72fbc ("selftests: Test RISC-V Vector's first-use handler")
Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 tools/testing/selftests/riscv/vector/v_initval_nolibc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/riscv/vector/v_initval_nolibc.c b/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
index 1dd94197da30..6174ffe016dc 100644
--- a/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
+++ b/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
@@ -25,6 +25,8 @@ int main(void)
 	unsigned long vl;
 	char *datap, *tmp;
 
+	ksft_set_plan(1);
+
 	datap = malloc(MAX_VSIZE);
 	if (!datap) {
 		ksft_test_result_fail("fail to allocate memory for size = %d\n", MAX_VSIZE);
@@ -63,6 +65,8 @@ int main(void)
 	}
 
 	free(datap);
+
+	ksft_test_result_pass("tests for v_initval_nolibc pass\n");
 	ksft_exit_pass();
 	return 0;
 }
-- 
2.17.1


