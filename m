Return-Path: <linux-kselftest+bounces-29061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E48FBA618D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 19:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED373B4796
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 18:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFFE204C37;
	Fri, 14 Mar 2025 17:59:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6474F204C0B;
	Fri, 14 Mar 2025 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975196; cv=none; b=KcFCEK5b0Dov3qtX2dLNaVBihpuUgQM4zGGyBy5kWebfq6f5nTkruVGLu+biAg3mIqZ7r9/7iaGX4qREXw58S64LjLdn5Mos9lsTHgQKumOZh0IyQTYNDAHVMRdifzgLT/7dCast45msFoWomAl/8zXxiJrUTt9Uzcpj0neteek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975196; c=relaxed/simple;
	bh=BaRRFyndeptPtTPlgfrAgt/14X5vfYem7RCE0fqktCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Efb2gqt+lFIdF391BROZtyHcx/p2qzQQBkrqGaZnzVTBbHq/HyjdkIU6xgQHTrxPwPPbkrJa08VGGelwg3IXC6Tgy3iZCsmnjxSpTP6Wr6CzkzvOVXKYsXtJLmBV0EoBlEz8ZR5XtQgvvvLZLyKrAfukHw24kJidu48kDpkOvW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac298c8fa50so449604766b.1;
        Fri, 14 Mar 2025 10:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741975192; x=1742579992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moWrd5k5XQTiMZmqhtTkeH+6sN2JizEsqHKfD51m9W4=;
        b=qVmzywFjfJ1TczJuJ1NI/g1dGwsQli6Jmh7llVc3TRY9aiPOyHN/fnerBUjuOksZ6k
         Pc6z+2BvnrH3h+45ql5UcJXV4Dwm7HBEQaqcemBvOrImrqCIclhFZvtjHyWlnAa5TL/Y
         +9Qjbg89AvLqyilgeEVMDE6kvz/AIWtzxejDQNKtMK+/zWFoED3hi7Y6Z2mXq9Eujzba
         xX/9Z5ARUnFkej6s7w2qvH62WmUhTNrZe+pxAvQ7hbku0REP9kLd8q4kfn+up+eZWNrs
         OUWE29mt/y7EkeJAmJWBzr1GR11+zWOpN2ynpDfy3sGVXJTyetSLbNjqTp2LKLzdOrAn
         Fpyg==
X-Forwarded-Encrypted: i=1; AJvYcCUWkY0+SOw/FSWY9/cwDfwdNJBqCpKcP/MoFpQ6NLvnPx49NDqQsSs2GypeUr9p8wZDPAi4bSIbY31sfAug@vger.kernel.org, AJvYcCW3XHRcry5cwHSJsMeWYjHCmL/3gUYv/8x2oOc+YT4omlk21RITiRD3C1YcY0QYEkEV7Y9o3Qr7sag=@vger.kernel.org, AJvYcCWpyGy+s//0npPbEvntXMTxsUKTL7+zOITBU/ToaQ4nlzsx++hKZT1XlVg8Pxplv/vSDq27nIysPndvvg/hna41@vger.kernel.org
X-Gm-Message-State: AOJu0YyTXm2x5FokO5mb8kncaUobkjiVDYE0XXKnkP7aCwbPlElbZwos
	V8XBk7swi/PnwVQMAC/AVWPAdVO/UazjHLPbIuXWuLwN/JsNZ+DhR99cFQ==
X-Gm-Gg: ASbGncsdbIpvu9kUbZv7wV7sxf1mEKGrHSPCLcrkKTbDGccA74YZoQ4chAvBk7H9Jad
	SFYGk88Bce04g+KXfDkqrKMvROFjnPGVE46qgP4PD73ZQbnEjdCWsQrogulPNkwhm2GR14uQmwg
	62NtgH18jB79w8atryJoB8a/ffIoEVUSZxkzBZKGtoPuhDjHXhryxca2anCevmUthK+0UXggpMe
	+vKv5wcfMqzl0EdnSJli5ct+IFLSzxF+P9fAmAWiW/LQ5UrKNgPGoLB6ntD42jjk6/14olNRFZx
	DkpfMaaBmFy14MbeOMNR0/ZKUpjb0YWbUVrsUJpqjEjyT4g=
X-Google-Smtp-Source: AGHT+IEy1iUaNdyPU2+u1d8/0s8YFDtw8qkyJWL7jfwKAHjzyXus72/8V+9TXaelNbq2rdjEHSal4Q==
X-Received: by 2002:a17:907:3f9f:b0:ab7:6606:a8b9 with SMTP id a640c23a62f3a-ac3303f75c6mr362665166b.42.1741975191945;
        Fri, 14 Mar 2025 10:59:51 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147f0ecdsm251523566b.73.2025.03.14.10.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 10:59:51 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 14 Mar 2025 10:58:46 -0700
Subject: [PATCH net-next 2/6] netconsole: implement configfs for
 release_enabled
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-netcons_release-v1-2-07979c4b86af@debian.org>
References: <20250314-netcons_release-v1-0-07979c4b86af@debian.org>
In-Reply-To: <20250314-netcons_release-v1-0-07979c4b86af@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Manu Bretelle <chantr4@gmail.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2976; i=leitao@debian.org;
 h=from:subject:message-id; bh=BaRRFyndeptPtTPlgfrAgt/14X5vfYem7RCE0fqktCU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn1G6SB38mfCpawekGM/luEB202uVSYezLeWvtz
 ucN/DDQWcCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ9RukgAKCRA1o5Of/Hh3
 bQcnD/43SbPWrk5WRJ8KWO1JiJzp97lFDT3FA9lF3KGZPydZku4IUw8600ih/glXhAkdJw1ga5/
 RodH6Oa4ykT+gP9/GyFnpOBh5uorsz+UyGEnkcjOp9UniIb4+Z+Be7RyDgbVvS7XjGOTKBBV3vC
 3yQl6K6o2D1qUjl1fApakAvVKZZPD6/ucI6FTQysU+Vf/6cLm6xnG/xA4iEXYK1ulcc93RVMB28
 uJIpxcmdk3YPn/Tuff3GTL6c8tmHQTQ9FABQCPpYZRp+0X3Hnp9YQlaLhQiu2xUb8NmbugHfz5l
 yThWNltIJWjIkJXXMXRJDrxKPVAr7cSyIxw7pyA7H10r00znqFvUr46GcmAU0WREkvJ3L3V4CPg
 5gGd9CxP+bXIsTlakH5iGW5jXHCNuWfJAcU0nIhJllinCQMxrZIKfvIHkA9WNvlMicuqGrjRaCq
 j3gaoR77Ort/c8qSoqNKKddN8cjVNdEV13l1QclBJMfvT9Zwzr3088FOus1V814sE77yucUR7Zd
 Gs2o+OTXl7F0aB64yh7uPJdX5YnvIKn7JzyqUV/62hsbXvfEXY2Kw0slCf3WO3ZXUrhCnnPIAAT
 IX3jvtMSHuqJ7yqlWZL6TpNJPAHXas/CHf+yn/EO81fz/B3de0S1cbHjDXhbXbAocY+Wf/+a5pZ
 QPq++noflJuwjWg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Implement the configfs helpers to show and set release_enabled configfs
directories under userdata.

When enabled, set the feature bit in netconsole_target->sysdata_fields.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index b7f7ec39e8318..0914d29b48d8e 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -442,6 +442,19 @@ static ssize_t sysdata_taskname_enabled_show(struct config_item *item,
 	return sysfs_emit(buf, "%d\n", taskname_enabled);
 }
 
+static ssize_t sysdata_release_enabled_show(struct config_item *item,
+					    char *buf)
+{
+	struct netconsole_target *nt = to_target(item->ci_parent);
+	bool release_enabled;
+
+	mutex_lock(&dynamic_netconsole_mutex);
+	release_enabled = !!(nt->sysdata_fields & SYSDATA_TASKNAME);
+	mutex_unlock(&dynamic_netconsole_mutex);
+
+	return sysfs_emit(buf, "%d\n", release_enabled);
+}
+
 /*
  * This one is special -- targets created through the configfs interface
  * are not enabled (and the corresponding netpoll activated) by default.
@@ -859,6 +872,40 @@ static void disable_sysdata_feature(struct netconsole_target *nt,
 	nt->extradata_complete[nt->userdata_length] = 0;
 }
 
+static ssize_t sysdata_release_enabled_store(struct config_item *item,
+					     const char *buf, size_t count)
+{
+	struct netconsole_target *nt = to_target(item->ci_parent);
+	bool release_enabled, curr;
+	ssize_t ret;
+
+	ret = kstrtobool(buf, &release_enabled);
+	if (ret)
+		return ret;
+
+	mutex_lock(&dynamic_netconsole_mutex);
+	curr = !!(nt->sysdata_fields & SYSDATA_RELEASE);
+	if (release_enabled == curr)
+		goto unlock_ok;
+
+	if (release_enabled &&
+	    count_extradata_entries(nt) >= MAX_EXTRADATA_ITEMS) {
+		ret = -ENOSPC;
+		goto unlock;
+	}
+
+	if (release_enabled)
+		nt->sysdata_fields |= SYSDATA_RELEASE;
+	else
+		disable_sysdata_feature(nt, SYSDATA_RELEASE);
+
+unlock_ok:
+	ret = strnlen(buf, count);
+unlock:
+	mutex_unlock(&dynamic_netconsole_mutex);
+	return ret;
+}
+
 static ssize_t sysdata_taskname_enabled_store(struct config_item *item,
 					      const char *buf, size_t count)
 {
@@ -939,6 +986,7 @@ static ssize_t sysdata_cpu_nr_enabled_store(struct config_item *item,
 CONFIGFS_ATTR(userdatum_, value);
 CONFIGFS_ATTR(sysdata_, cpu_nr_enabled);
 CONFIGFS_ATTR(sysdata_, taskname_enabled);
+CONFIGFS_ATTR(sysdata_, release_enabled);
 
 static struct configfs_attribute *userdatum_attrs[] = {
 	&userdatum_attr_value,
@@ -1000,6 +1048,7 @@ static void userdatum_drop(struct config_group *group, struct config_item *item)
 static struct configfs_attribute *userdata_attrs[] = {
 	&sysdata_attr_cpu_nr_enabled,
 	&sysdata_attr_taskname_enabled,
+	&sysdata_attr_release_enabled,
 	NULL,
 };
 

-- 
2.47.1


