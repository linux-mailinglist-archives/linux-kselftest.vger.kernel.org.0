Return-Path: <linux-kselftest+bounces-17486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA785970F35
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A581F22B2B
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DC61B1D4C;
	Mon,  9 Sep 2024 07:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iErSWiQJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478F81B1422;
	Mon,  9 Sep 2024 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865721; cv=none; b=H/iz4RV5Fjva89dv9QVLqwEpQz9FGHLOrRmIA22rZ6Bf0qhnsTANLOmhLspFiklW5D6QBqyZdwdW+AmwLuXBTBAUXeeNZZ8Pdt+MKDFeF3amZOwhZg+cblk4APj+u52IMi3SWua/XD0wLM/sMf1+SH4WqXf/EEJCg7Eg8S6CvVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865721; c=relaxed/simple;
	bh=gBbNhFO0BEjuhC56tT9G9xCxb9heG3EotW+MI4AasP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U92KwVfVeyepU/FG72SY8L62dQwDN9NQPZn568nLZfkDvPErESj7OKRSWC0POKO7BHweCrEHHwIk19ygOW37zxcxtJDYAlvEVdfypeno9VnK+I3T76Ybu81Uq6N7NuvZgXC5gH3bkmXl7kKXeP6faN21n8LXWz8WQ9SBltsndq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iErSWiQJ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374c1963cb6so2403105f8f.3;
        Mon, 09 Sep 2024 00:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725865719; x=1726470519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaLYxtWkb9UDRswjf7QQ6H+2Ezg3Jw4reUgYCP+x518=;
        b=iErSWiQJZkovFURAMZRDAQnyt3HMmVKLvqGTPRN39XFivQKRYCwe6EMdgP2vD8p4GD
         bU8g/SQgTzBiqX1HfbPY0VTbXBiBA7FDYcH5CDfjlvyJaLMTx5bI2j+rGLBgTMw/XTD0
         8sNTY9ssIfd87rr8EcyVW62DYkVaK3yFnodpcJpm4worD6a4dDbBOXYEsjgb//fIXTTe
         sHU5qpBNRlWRSXmbM1Rk0VzF9D5hRpsn30/i186DAR6x5uwVpBlHwj9K7PJ/YrmE69xB
         I2AkARtvj3hVPuBQRiTMX5TDG1pLTiQ1KXzd4/VZ+xtB6oP5h+VaHoTGhaIBWWcLbWes
         83Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725865719; x=1726470519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaLYxtWkb9UDRswjf7QQ6H+2Ezg3Jw4reUgYCP+x518=;
        b=odAj+wa7fwdtJyve8pEHC8G6nOqswGSAfBkmhK0ZnH+qvats4P39UTugFLNHM8t7n8
         a4stsxOkgWLmsmMssgFpPw5Mw0pecHPze2o/sKtTz4duhvMWxgK7FE3pNoyMfhn1gnKB
         qOHdQKu3qbLr2Owa3ommbCtKuhtGQHqFyvo/oSkOUlwX20JOWVMFCRjcnZGpcMOwR/85
         5OuiftsxBEvGNh9zs5vhN0CBwg5sdPLG/nPdXsqJu9KGrU94x4FKYpAm8SOyDR+5VWBh
         xgXB403oUE5XNedq2G+iEB9lnFIWAIbNPSrKCEKfnB9imYITQjbZmd63v+hyA7pTzk82
         VScQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKIK8b1wlh7G53SHHTS5y9FasscOMvFZOzK4ZOctOqIGpRu9eiEt1/pqGwZYtqzzXHN3DCf3ndoofGQg==@vger.kernel.org, AJvYcCUOaVmVBTCVTDDQDwtLkjtJkgu5Zij7alzQBwMJVRTj8cSAJGGDvjfI7UwaXl7VfBnI8rXQltUdHz6xc923PA==@vger.kernel.org, AJvYcCUakxcFT11FypeOHp13V1AqzPv+7Z3+S3mO36Wwx7k5ypD6PhQbVT1Z+AMBV+KUFMsWNRuiFziq3uHWSzST7Kad@vger.kernel.org, AJvYcCVAoIca0gUBXohgfw0hQEc+LrSVPTKBtzXvSNwBIEonBb47WtFDmp3RKwrH+j0tukydCgxuV6QTsf/d1c0=@vger.kernel.org, AJvYcCXFUZsWl1kZbRleNvKv7eYp+Ryzh2FrSj/Eipj26lzJ8U0O/EzC3j/ZUOPcGqfDNb7ikfdnylfy9aCd5GVl@vger.kernel.org, AJvYcCXpu+6wHeWgnN/H6D9hN/5RcYZPQ+DexLYbHbWpE8D/2sOq2Mo+Pz53mU8+ij3xpQqPjPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxFauIL9pS7zuvz3XHSWXjyChpaLhQ+SNln4k9IhJxDW4nHT/x
	DM4Y6rq1KByzmB87zVPPegjZOvtCQ4srdOgU+UbFtjATrFVBQz1H
X-Google-Smtp-Source: AGHT+IEQLNSW+PIzTLcAW22XrPAIo5gWgIG/codxPwAybXuXAtbQozQUICUfaqd7uB8QyM9Iess0AA==
X-Received: by 2002:a5d:46ca:0:b0:377:9867:9028 with SMTP id ffacd0b85a97d-3788967aaffmr6190593f8f.44.1725865718527;
        Mon, 09 Sep 2024 00:08:38 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d375asm5178754f8f.66.2024.09.09.00.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:08:38 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2 14/19] bpf/tests: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:05:28 +0200
Message-ID: <20240909070742.75425-15-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909070742.75425-1-ubizjak@gmail.com>
References: <20240909070742.75425-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Substitute the inclusion of <linux/random.h> header with
<linux/prandom.h> to allow the removal of legacy inclusion
of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
---
 lib/test_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index ca4b0eea81a2..eb4a1915e4d2 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -14,7 +14,7 @@
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/highmem.h>
 #include <linux/sched.h>
 
-- 
2.46.0


