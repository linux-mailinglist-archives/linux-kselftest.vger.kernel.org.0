Return-Path: <linux-kselftest+bounces-27168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57582A3F67E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 14:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15A818982FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 13:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEC1211465;
	Fri, 21 Feb 2025 13:52:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E591A2101AF;
	Fri, 21 Feb 2025 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145945; cv=none; b=CeYs04V/QIj8RnEm2dCa7nAD2cA8Iux1+fEMgk9jYETA1wJ0Pni3sAMDF8zuM4zNAJBO/Lf0h8py7RzmQneL76fur06iyA5m9Eclf6tWGl5Er5qrmpphOcUr76+5RueUdY/lLWJ1n7E/8Jz0D5TN9wAc1qj9mvfTt5pcl+Qf7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145945; c=relaxed/simple;
	bh=IU6qyy1iFpjo663fbxCoKchOukk6qnpwGi0c7ZPjG10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mX5n6QA1AuOMXkEyag7/+KibtRk/AKlFtDrVJiUxDTgiBt4+qfWwuBu+zNLpTz06bADqWrn/X8n9Fyd2P+dNxQs3YXNcjxJECoTI02sYmF/RnTEt41mh9phSbCbDnhaFvIMs/bh6Wc/syn52HUY16k6uDjdkHh7/On8bHhX8448=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaeec07b705so339278166b.2;
        Fri, 21 Feb 2025 05:52:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740145942; x=1740750742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoqUgw8CK5il/VCYnynrUwMUzbSS7YtelAZ9JMzXTRU=;
        b=iO8m20UYkJPqvXTKViUAI4tZfGTqqZUHiTiACCpM2GW3cHGyjMwLKW6tpj0oeZramM
         WBSZA35/VBa9eGQrKOKa8l3OJkNGJ7vitiUd+zZ4D19DzK0mvcNyr1arlxoVxCR4f0mk
         meVqLyL9n5rajZayA5sGxvzsDc/JdnJLYQyB3CQNXtaPVjVNDiAAyCqW8t1Tax8tLrEn
         n4TJxkpp/J3HjY1h+UN4oJA0nQN64gg22KuaYvDeVS28Ce1L1ORomBjllKccLRcrYSVp
         ps8sBp8VeGngxZpQPEP1rVNtovtFPmP63GLlTWIDeWXCL1dFISUV79hm597lMzAOkNDo
         NFHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAXtJ/bf4z2Tn7p0TqWWYIIF+z3CEF8M7L/DSFbw9siN+fIsfTqTr/ykPsWRg/7XrGhidKlLhsWm6IAhBO@vger.kernel.org, AJvYcCWEMaYZt11uAh2WqcetBxK6SHRlF0scDr1uhLKBLIGD1xA7+fHiOaozuBYxiEpKHnqmzTjgeXs6e3NK8qGrryEa@vger.kernel.org, AJvYcCWVuTIh/GtpTCut1GAj3OhJhzB/TzkypPtt7KLYfcwhuYTjCwFitL0sn/vVBUQegvf1wKoUKaQx+rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5xKPqyua1rdCdYo0d2LvbTj1uvk1iTd1HHa724vCXcFk4ezs7
	X1C4JQq3z03etRSVTAH/suvYK6P/VdSeHAmqpPc2LRvSMmqAaZxWeboR4g==
X-Gm-Gg: ASbGncuE1DUyhPf+CvBSeEtRJdByPo7dlj43yv1cu23+yyvy2j4IxJ4q2Sdl491i+NL
	fpEIqwEck1So7g02YIfFgqMKG5HTne7zUR8/K4z79hgpuRq2pVAuafqdAXaJg1D2/q4vkBb7OuZ
	8DlDu2228txic019+kb28CIVayryBnLx34BCt01qBvNs6/dAMUeILPAnp4nLPhEo81xshItNP4+
	3VPTfEbfzTQ4I658ZSZwP4UbvL8HXyCoQidwxiT4kq59D7ukxCV7tRLSPDm6H4E3z019TeqOhBX
	FQ8mqEfY4bKRb2TrSg==
X-Google-Smtp-Source: AGHT+IHWeHLxvWH0kTgEzlyoV8ZqeDKqrz0soE2mxMN3ulJz83Gmo7xlHHsJjZzpKM+q7tGjTYz0iQ==
X-Received: by 2002:a17:907:d8f:b0:abb:e961:ca32 with SMTP id a640c23a62f3a-abc0d9dae22mr295273666b.21.1740145941530;
        Fri, 21 Feb 2025 05:52:21 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba577d6d6sm885539366b.136.2025.02.21.05.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:52:20 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 21 Feb 2025 05:52:09 -0800
Subject: [PATCH net-next 4/7] netconsole: add configfs controls for
 taskname sysdata feature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-netcons_current-v1-4-21c86ae8fc0d@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3183; i=leitao@debian.org;
 h=from:subject:message-id; bh=IU6qyy1iFpjo663fbxCoKchOukk6qnpwGi0c7ZPjG10=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnuIUMuJnGxWYBi44JmUbllgqr0bFIXZaygKw9A
 I3OFMmxoX2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ7iFDAAKCRA1o5Of/Hh3
 bTqvEACcB7Q089Txgfw4pMpIrGgsDLZzhBuVhIsZInSBClWUhG9TfI7MybMop4nUlSqy7VsOQY1
 Fq/QUomj1N4iWknvPetjZkoPgGpsavvpwihlPKUSSulhhO6QKIE9ro4fWMXSAT37vE5jy9uYFEq
 a1c6oyGWbNLrKQbcpi2ALLuKqc+YabLq797Kue6n9WfdcVbgZTP3+b4QoFcTdEEpL9h9nylDhnQ
 csE6yBuQs6p5EnvC9KGvl9NyRs+2h+Md8nehmnPNbjN3R3q40Qri79iiC0VoUJUuKYoHiP48uZd
 COEC0Sp/CS0vqwCBNJOpRCV/Amk9oaGpUSwZXIzYtFtio1ODjjtyUQ55u60oAOeRruxJacOQRDH
 yvFzTbwnTtMYwZN92zrAGRnzWd66ALREOVr9o3V+IOf8Z7OmyXaYteSPxeeoy6t9UdrJ2QbgaVl
 2zEr51kcEKz0Eu8S31jsYFIrJ8vJY3q3kxLf/tb+EgBNpJUVKXy08gjN3fU1sxPN0j6xv6Tn/tz
 WeRBhT1jBPeSdITFlDksIxuZhH2uBmvYc2jhHOFLLhlPB3uwWibf255F+G0v4S2X2rn8eOtS0gd
 GaukkVVhUQtJ5a1/rlrGmaMW2Td3cwGizLDEwxqsnkfS4iy8iJDIuZ7EHS347wUdGn+cFEfwq8R
 8su059qNa043okQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add configfs interface to enable/disable the taskname sysdata feature.
This adds the following functionality:

The implementation follows the same pattern as the existing CPU number
feature, ensuring consistent behavior and error handling across sysdata
features.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 1b109f46512ffb7628c6b34c6efdfc301376dd53..5a29144ae37ee7b487b1a252b0f2ce8574f9cefa 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -426,6 +426,20 @@ static ssize_t sysdata_cpu_nr_enabled_show(struct config_item *item, char *buf)
 	return sysfs_emit(buf, "%d\n", cpu_nr_enabled);
 }
 
+/* configfs helper to display if taskname sysdata feature is enabled */
+static ssize_t sysdata_taskname_enabled_show(struct config_item *item,
+					     char *buf)
+{
+	struct netconsole_target *nt = to_target(item->ci_parent);
+	bool taskname_enabled;
+
+	mutex_lock(&dynamic_netconsole_mutex);
+	taskname_enabled = !!(nt->sysdata_fields & SYSDATA_TASKNAME);
+	mutex_unlock(&dynamic_netconsole_mutex);
+
+	return sysfs_emit(buf, "%d\n", taskname_enabled);
+}
+
 /*
  * This one is special -- targets created through the configfs interface
  * are not enabled (and the corresponding netpoll activated) by default.
@@ -841,6 +855,40 @@ static void disable_sysdata_feature(struct netconsole_target *nt,
 	nt->extradata_complete[nt->userdata_length] = 0;
 }
 
+static ssize_t sysdata_taskname_enabled_store(struct config_item *item,
+					      const char *buf, size_t count)
+{
+	struct netconsole_target *nt = to_target(item->ci_parent);
+	bool taskname_enabled, curr;
+	ssize_t ret;
+
+	ret = kstrtobool(buf, &taskname_enabled);
+	if (ret)
+		return ret;
+
+	mutex_lock(&dynamic_netconsole_mutex);
+	curr = nt->sysdata_fields & SYSDATA_TASKNAME;
+	if (taskname_enabled == curr)
+		goto unlock_ok;
+
+	if (taskname_enabled &&
+	    count_extradata_entries(nt) >= MAX_EXTRADATA_ITEMS) {
+		ret = -ENOSPC;
+		goto unlock;
+	}
+
+	if (taskname_enabled)
+		nt->sysdata_fields |= SYSDATA_TASKNAME;
+	else
+		disable_sysdata_feature(nt, SYSDATA_TASKNAME);
+
+unlock_ok:
+	ret = strnlen(buf, count);
+unlock:
+	mutex_unlock(&dynamic_netconsole_mutex);
+	return ret;
+}
+
 /* configfs helper to sysdata cpu_nr feature */
 static ssize_t sysdata_cpu_nr_enabled_store(struct config_item *item,
 					    const char *buf, size_t count)
@@ -886,6 +934,7 @@ static ssize_t sysdata_cpu_nr_enabled_store(struct config_item *item,
 
 CONFIGFS_ATTR(userdatum_, value);
 CONFIGFS_ATTR(sysdata_, cpu_nr_enabled);
+CONFIGFS_ATTR(sysdata_, taskname_enabled);
 
 static struct configfs_attribute *userdatum_attrs[] = {
 	&userdatum_attr_value,
@@ -946,6 +995,7 @@ static void userdatum_drop(struct config_group *group, struct config_item *item)
 
 static struct configfs_attribute *userdata_attrs[] = {
 	&sysdata_attr_cpu_nr_enabled,
+	&sysdata_attr_taskname_enabled,
 	NULL,
 };
 

-- 
2.43.5


