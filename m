Return-Path: <linux-kselftest+bounces-18376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68DC9868C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 23:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4562822DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 21:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714E217F397;
	Wed, 25 Sep 2024 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vkw1WoPT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C055A17CA19;
	Wed, 25 Sep 2024 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301332; cv=none; b=flYqFUh+Fp0CmYYXKTQ1SWGsU9yxfVWlsv7BVmKpNk3RIhIaBfCXKaVYotJLJ2zFWMedSmL0rUkH9lqBiNvA0KUdA51fHWls6TnLaDtLYssVbHBF3ou5l0VoSWb10TozE5quUtcvQnh2M57ZDPSO53wk0rfc6jIKxagD2L1mEtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301332; c=relaxed/simple;
	bh=hI2BPsKn6Fb7xDapPbHxt54KAin5kF1lKUkbh087EgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SsSNS/35ImeZ2TS6qA7urhOFDlMBM8EsmKuKt4YY4A+qZXwKHMPjIL4/V1JO6KcWS5YrGt/jlX+RqPrsab+jP0/3e34lFtEoFwbRP2EiLuVve2XdR0LFrduqGc8SCfh+8cs/RtFdJZL2qF/UWVfTIYjidgYb0g5hReWJAfQtcCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vkw1WoPT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so2370705e9.3;
        Wed, 25 Sep 2024 14:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727301328; x=1727906128; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kNhACyHju1qZ/sENCdrWjPN9bm5n5NCjJOZx++DT6c=;
        b=Vkw1WoPTi/dfP3kyt6mjlWhSi1xEyeXoQJrZITOQXPjRTwhxB3boDBehK3MViQhEkW
         aC3LtitEkQpIiXiIcPDtFQh4zlXYMF9hdJ5PkboZgBL+uNOJ5CtOuLN4Yt0YChbC2cTq
         jvJDYrHaQQC2bjIN2imsUjjUPhGdlgjEMALTs81NwUbvwQeMFWOC8JfpiutOT2WRVgbO
         NJPSKeqoQRt6L02VKLsFI8+hABSNO7lJkIDYTpigIQZO4kV8ohjp+VNvK+ll5UexOCzZ
         Ym5NFF4123T2SXir5qCj8lV4lFdxctpejUg6DQ3ofVLvQz4q0xEuFjPA2dIEY6yUBQoz
         daaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727301328; x=1727906128;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kNhACyHju1qZ/sENCdrWjPN9bm5n5NCjJOZx++DT6c=;
        b=JU9vzJCSBLBP/toeFzhPZ6WzbiPNyC+kOCZKdTiGQEGAqZaeM4uueLrhWeyapIjgwG
         qll+L7BmK7MS7X/O+jPBt5oz4zeK2noYUbAiM/5UINdQZsixufxHQeO9phSMJSJQZ8se
         DmIvaaZLEzFSiBLjusJ5Qa38PQIqzLY71EEh8dWoX4QrTCHisnPIgHSdnW+arXu9nfZM
         igF3LOAgLKEe5wJYOqdqJcoJnDnB2nSLRobw8wb5hxhrCGr6B+NcovKibPtWTv/ajWh+
         MwV7uvqHAKh3X9LTz3Lro3esB1OFheLUbAHPP6oN5Dew6+157gQv/DKnn/IodSMWGSuK
         qJug==
X-Forwarded-Encrypted: i=1; AJvYcCU04IwK9cfLPWZPGrHlqs5S7rLSAKsENol8V6xyl7NGdh6ZhkHMI5sTr0JZGQFAs/qjE44amKLa@vger.kernel.org, AJvYcCVNPXHxGGVMkMHzI9TVijplKIOjF0QsoFFY3Rokg81snNtB91z+Ej/ygwbK85ZFrQVpG5i2EaXdlU3lIZY=@vger.kernel.org, AJvYcCXi1RWQXgdb4IckOhT8nOSQzatbqIIu5Uf70PQQ+Cz0HidfSeGhMwcSpkIOvU3so4FZdctEDQnMa/SZng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2KnLi82BcHYgj90IP0X7vz11FPtEj7nM4bBdH7QAsuINBR2T2
	T+5VtQ4HK8wdL3TmazLllfcDpgG3nn+wYK5XNhMd0D5w9rgjjcVOndqmKQX+
X-Google-Smtp-Source: AGHT+IGzGg/nXc1RpuWc+mvdWNw2z9wStHdoAppdKb7lBNY3slZnLyBpBp5bzf84V6oWFLMEQkrzTg==
X-Received: by 2002:a05:600c:1e14:b0:42c:b58d:98ad with SMTP id 5b1f17b1804b1-42e9610fd51mr30078725e9.14.1727301327812;
        Wed, 25 Sep 2024 14:55:27 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-370b-ca26-d622-f1c3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:370b:ca26:d622:f1c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a165fdsm29129385e9.34.2024.09.25.14.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 14:55:27 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 25 Sep 2024 23:55:14 +0200
Subject: [PATCH v3 4/5] selftests: rds: add gitignore file for include.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240925-selftests-gitignore-v3-4-9db896474170@gmail.com>
References: <20240925-selftests-gitignore-v3-0-9db896474170@gmail.com>
In-Reply-To: <20240925-selftests-gitignore-v3-0-9db896474170@gmail.com>
To: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Allison Henderson <allison.henderson@oracle.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727301314; l=593;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=hI2BPsKn6Fb7xDapPbHxt54KAin5kF1lKUkbh087EgQ=;
 b=6P589nUtDMdAKjpk/XpvjeslRvbS78zcPvuL8dLqsWqbPDdT+pUXYi2ki+qyr3BrQAC2MAkZT
 d/HuE8ySgaUDKX8AC++NYn+igUnwgFCZ+MdXe9YKQ6IRlTCPjv2C+fZ
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


