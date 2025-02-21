Return-Path: <linux-kselftest+bounces-27169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CEEA3F680
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 14:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C0317F58A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 13:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B8A2116F9;
	Fri, 21 Feb 2025 13:52:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D23720E027;
	Fri, 21 Feb 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145947; cv=none; b=YU4wKNeLno4l1wNU6WVSsxLnSaWHzfV6ouMU1BcE5buY+D7sxLELjt2vg7afV/xqBUAsYLgIttUbw8+RSYEkgqbWdM9JF7Vs+s2QxN9uKYDxdkctVstK/dGdX3kW0fKgME3640pRXl57W+XJh89kFn4ktx2kjyLMfX4olvSqLDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145947; c=relaxed/simple;
	bh=4d5F9hw/MC11IojS+Ua6223OipgO2ANKHuJKGY8jDf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AAaRyaeiswBpvO4OLfDn1WY6hrG0NYrlozIdFykpUcEFs2/aYuWkMItCb7Tub04PSC97OE0atRW5qegL7qb5Uuu+LwOqjrqEaZP+zwbOjxO+veQjJ8O7K6V+WjEUXFtfyk1JUQAtEvjjGmXoBuNnXN3pJBfsczVb2gDq40FcG5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb90c20baeso285027166b.1;
        Fri, 21 Feb 2025 05:52:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740145943; x=1740750743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFytzJ1XN5zmdiS1teTibU1DKqNU5XabnaEcWVaGmeE=;
        b=Tj0/fmItlnINIlZO8LrZkf+QqZZr90UijF6mNxiWtnV1n4npWq3ddN5P+94s866Guz
         hmFWL+aRqA3ck1C44lRj1Lajdbh23qTDoixbh7SO1pEZhZddodPkKMS0wx1iLEdqlGwR
         jzcgTnGRc4wi9QmYhofxy8Fmb/jRkbSobsNg7VuKz0TJVsxMCWq2UYzoH2TwGGuUQOQK
         1phD9DLJzFTN2LGzCLzGoCgvlVZIEbFfhOwp3jYJHzWPCpS4hT9VXzg7FBZUK4o8oUtM
         ppZ8WfG0Ijtcb7hqjMcFKq+k4YO0y2xHzGZdaVN6+cN2ZdBmqpVA0A5QtcBxDmH+OI7j
         tG4A==
X-Forwarded-Encrypted: i=1; AJvYcCU3TXZBqMQqnJ+Q7T9x+Ddld138tDf63HVXeYL6U0dGtRNcr1+dO5fXCz8wQm9RrH0OHLwlfnE61pvY/Na775Nq@vger.kernel.org, AJvYcCV6p6/HAf2q5v+RKnnxUczXgprrqz4UyW+k7eYkqMAX52ymTBJ34BX75xJOSZGptEJJLd0clR6ydGtG5Qln@vger.kernel.org, AJvYcCVAIj/aV+2VkwEi6Prf1m2duGHRjcRbyqiOLUn1Vdmi0sHOtJR/Gt2mGxWWKlHraJ6ga7mva9Z0JuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvSAZ/c1sgdM5ukkLI2tDExyIlemCZRBBrwsRWUPQYXUj0q02D
	7IvwE2fch183sogRJy7kRiy4aIULewjbAJuZPxFGMUh4Yv7HVB2Orz14GQ==
X-Gm-Gg: ASbGncvfasyEVTUQFBQWSJ8CERmAcTmFhy7PxdoCB3VFbEnFLN5BhvDr1GZ++U/uuzw
	JLGd8zcKU3g/9yo27BmVVD2XBHn/s6Oa0Qt4EWwUzYmb2DJ7tAEjUDHu4vfsfCGijknFgOOHsz0
	VnPWSCr5SoFjKsrnrabbuRU1YaOYapjzqkSY9CyOwEjUYZtufy5FoSHYH3jvvesNgGGn9JnlMHm
	zx/OVGmVv9jeDCS4X+Vo+/8mtNFxjFWZn+nWaF4mmT3yNOM2tID7j0eMZ5vWt+VlmaaCJCaPXbA
	EXs5dulNiE0aaA==
X-Google-Smtp-Source: AGHT+IGlZ7okfxBb+is8wq3VskHdM6A78aGWUaoh9njORHgf6Z++fXR2qZP4IE+QfuFrPzT/tYIK8w==
X-Received: by 2002:a17:907:d22:b0:aba:a81c:f972 with SMTP id a640c23a62f3a-abc0d9d7a7cmr346617566b.17.1740145943153;
        Fri, 21 Feb 2025 05:52:23 -0800 (PST)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9acb9acdsm987280066b.66.2025.02.21.05.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:52:22 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 21 Feb 2025 05:52:10 -0800
Subject: [PATCH net-next 5/7] netconsole: add task name to extra data
 fields
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-netcons_current-v1-5-21c86ae8fc0d@debian.org>
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
In-Reply-To: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2177; i=leitao@debian.org;
 h=from:subject:message-id; bh=4d5F9hw/MC11IojS+Ua6223OipgO2ANKHuJKGY8jDf8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnuIUMukz11k9tZaWs9ipUN4NpSO4HL4ODjAcwf
 3fUG+ePofGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ7iFDAAKCRA1o5Of/Hh3
 bU2ED/9Uk1b+wXGhGwGDSjLAWhfFKNYzImdiGZD2b3DCSPjjA/d4+cD2jfP/SMKzW+eAnHJnZHU
 43GfbfKm9JKQHSsKG9t1uuotgQ7GEbHBUcHRKaXiHqKmbpbaOn5idQ0kGHONF4pT+qQyLR4/N1o
 pylQc/NboJI/Q2mWl8rH8dBWGw7kJXmJJYIltUsVgiTs0/NwROZBBFJUPsynbMbgDMHU+cKPnS5
 YK5Wni3zpfIlO3x+tsJMkuk0ErcqlMl2k1Hu5XjzOhwCaL379hFoJ0LAYqR9LT9cbzGsJoHFkoS
 Dk4S78uw9m+a14i/6usP7TGUDELShTnrFygmO8WDBp3BqFSiFX+NT6EHw/Ic1uZHflOtW9mu3Yl
 Tu6qvGeMYMV9hz41haLD+03BqPYy8TXI4hYbBLSocEeR2GCF4q0M1XqPvjO15HsVWTuvbhGhSQC
 NCfGuuPsFb846CXw/0Fp+A6hD20oTwYPRlGkLohpXeVvuPGl5DMIkKtnf2qjic8mh21Qp720Lh2
 tpGXaL+zaA99nyZgEHwaLVK6E9ZdHpRWpxNN9/Q2klSbKvXShtR+GDAtjsLyQSWJqmHGKUAfxVC
 Vunea6tAS/b4I9fmiAWQQcm1Dz/8SqMnxFSIhI3YIQZV7ougQIqDn+RYSwZK65v6cQuJsnfOuGp
 SLqG4eWKWO5zjzA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This is the core patch for this whole patchset. Add support for
including the current task's name in netconsole's extra data output.
This adds a new append_taskname() function that writes the task name
(from current->comm) into the target's extradata buffer, similar to how
CPU numbers are handled.

The task name is included when the SYSDATA_TASKNAME field is set,
appearing in the format "taskname=<name>" in the output. This additional
context can help with debugging by showing which task generated each
console message.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 5a29144ae37ee7b487b1a252b0f2ce8574f9cefa..625f4c0be11d8deb454139b1c526abc842697219 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1179,12 +1179,22 @@ static int append_cpu_nr(struct netconsole_target *nt, int offset)
 			 raw_smp_processor_id());
 }
 
+static int append_taskname(struct netconsole_target *nt, int offset)
+{
+	if (WARN_ON_ONCE(!current))
+		return 0;
+
+	return scnprintf(&nt->extradata_complete[offset],
+			 MAX_EXTRADATA_ENTRY_LEN, " taskname=%s\n",
+			 current->comm);
+}
 /*
  * prepare_extradata - append sysdata at extradata_complete in runtime
  * @nt: target to send message to
  */
 static int prepare_extradata(struct netconsole_target *nt)
 {
+	u32 fields = SYSDATA_CPU_NR | SYSDATA_TASKNAME;
 	int extradata_len;
 
 	/* userdata was appended when configfs write helper was called
@@ -1192,11 +1202,13 @@ static int prepare_extradata(struct netconsole_target *nt)
 	 */
 	extradata_len = nt->userdata_length;
 
-	if (!(nt->sysdata_fields & SYSDATA_CPU_NR))
+	if (!(nt->sysdata_fields & fields))
 		goto out;
 
 	if (nt->sysdata_fields & SYSDATA_CPU_NR)
 		extradata_len += append_cpu_nr(nt, nt->userdata_length);
+	if (nt->sysdata_fields & SYSDATA_TASKNAME)
+		extradata_len += append_taskname(nt, extradata_len);
 
 	WARN_ON_ONCE(extradata_len >
 		     MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS);

-- 
2.43.5


