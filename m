Return-Path: <linux-kselftest+bounces-19089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A27F991483
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 07:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0C51C21F8F
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 05:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC3613A24E;
	Sat,  5 Oct 2024 05:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YF5RZ/35"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EB782D91;
	Sat,  5 Oct 2024 05:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728106194; cv=none; b=KqI9FMjpSO3RBaTmpDMlHT7pZeaM9bFGmQZYy63UCRRmpQc14nKt6Mr9Dgjn0QFufCGPaibhoVn8D7LJM+nZ87icauSY9aDABpacu5vB2nNgYIXJouS4xCYclcmzcQ41n5fM5V5Mc8ZgFMbm5doK0EHJfr93du1HoupwCbHGDzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728106194; c=relaxed/simple;
	bh=hI2BPsKn6Fb7xDapPbHxt54KAin5kF1lKUkbh087EgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n9bk0c8DdKgVjCM1qc2k1dNFZ8N7vHNu3wlmyZKz04ctUijiBdbzzPIa5COKZvDZ1H9vBfUUUkY7ZKALImakaMPUCMWFEwtG+vnvZCOEGNoWqTA9S3ZXBioYy2IQrXY/0i+FQfDLMhes3To8V4SWq5XeNcJQMwN7Xqlf9a+RjBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YF5RZ/35; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so28326345e9.0;
        Fri, 04 Oct 2024 22:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728106191; x=1728710991; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kNhACyHju1qZ/sENCdrWjPN9bm5n5NCjJOZx++DT6c=;
        b=YF5RZ/35aZ2BtHafx70/DXl7Lx9IfseXr29AHE4X/OUnEzJM2RNgxz2OCkWHIq1m6A
         v4ofAONRmvViWiNep0tHlJspDmygY4zZcYgi5iovTQWguCe90dsgPVj1nPHe9QuPMHoQ
         HatpvIVRw8KVbJ+4NnXlJRc62Wu38a8x4TJtkHCXsmUdIJGGbE6nNsJ/OeKg0csx4vAp
         ND0abJrS+oj5XFZ5GM6G22BXlF3FO+JMcAkIYZenp8X5ZuxsHFzTOnQmFP2TvrA23loF
         Bf7fvXrMbjJ+gXybK9yTcTWAyrAkY/MwXuAVspNqcvcOYyDuVchpGZ+rh9jpfVWQKOSX
         oZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728106191; x=1728710991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kNhACyHju1qZ/sENCdrWjPN9bm5n5NCjJOZx++DT6c=;
        b=HL5VztSq/BErtmACn1TuaVKd/G6MROddVy/ELZ2UyT3WteMASh4Tmj666YBw6X3ku7
         +EOlynNKdBl4cLLwnOlSy0b+jdGvC1/AVo4yPlCSY8HHY0FKspx7NdGTVwiHzbGElSLp
         8W6FDvn1P7aniqjCjC6Qjnd/glpHebbYfIQuJIs8AV7q+qSwqUZ6gwWIRHASCcDvqmEu
         LaRuxOz1Bnjpvfpi++tH9Q3zDSmy4NHH0iJEaSevStXNlZ4BPTC4ECO+FWL+xHFZqGXS
         8Vvc7W3jtMi08HW7iEFO37KDXkTXeovWIVdabQ9POORQ0y/6WBPVKLq0WkIFPtrGt+8c
         TT8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGSCyc5QlUyOu+XxLnRYqip3dXTVpyexEM5k/RStYwy8u9g8b0wB54H7HVtE7nZCsO8UT/CN21JnEURqU4oiFt@vger.kernel.org, AJvYcCWJyyHEednwb6no2ecObbgBRsGba60yMe78OCH8bzuSv10sxegYXQk1lVE2blOugpU3MRBi+9Zd7rvpkuU=@vger.kernel.org, AJvYcCWz8SmyxAGydtJGT6GbdcqL1/ONnDcjnQbvVQIShHx0yWwaJdPEOfTnFC9ovu3Tz3T9hiJSJCI9XFH9Dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxLpzrsCsMA0rgdHsHrvA2gPKVKjA0TLrwLyIdVp26Q2zofhag
	3DJPcLbNZMv3MtDPGhc9W5XqVtcf8yC/iWKC+sopVrk/ipKrN+WF
X-Google-Smtp-Source: AGHT+IFbHEahtJM/4oQLiQWsE0/yXl9jJTCY/tUAnYEbQXtKGctZkwnf9pKoj9zbsCmehWVFi23MXw==
X-Received: by 2002:a05:600c:350c:b0:42c:ac9f:b505 with SMTP id 5b1f17b1804b1-42f85af0486mr40560545e9.31.1728106190858;
        Fri, 04 Oct 2024 22:29:50 -0700 (PDT)
Received: from [127.0.1.1] (ip5f5ac341.dynamic.kabel-deutschland.de. [95.90.195.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ed952asm13103105e9.45.2024.10.04.22.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 22:29:50 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 05 Oct 2024 07:29:42 +0200
Subject: [PATCH net v2 3/3] selftests: net: rds: add gitignore file for
 include.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-net-selftests-gitignore-v2-3-3a0b2876394a@gmail.com>
References: <20241005-net-selftests-gitignore-v2-0-3a0b2876394a@gmail.com>
In-Reply-To: <20241005-net-selftests-gitignore-v2-0-3a0b2876394a@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Allison Henderson <allison.henderson@oracle.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728106184; l=593;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=hI2BPsKn6Fb7xDapPbHxt54KAin5kF1lKUkbh087EgQ=;
 b=pT+6E328HKIjUdbdkDAosTr3J+V7wFYwJi5z2eGK/67vVTaV605PDzzxzT1dA/BPxh5lFR3JA
 8dQJ+dvVQLIDeoOJ7OKMijmF70kazaCgZzSYvmf3K020dp4Ho7G7EKn
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The generated include.sh should be ignored by git. Create a new
gitignore and add the file to the list.

Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/net/rds/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/rds/.gitignore b/tools/testing/selftests/net/rds/.gitignore
new file mode 100644
index 000000000000..1c6f04e2aa11
--- /dev/null
+++ b/tools/testing/selftests/net/rds/.gitignore
@@ -0,0 +1 @@
+include.sh

-- 
2.43.0


