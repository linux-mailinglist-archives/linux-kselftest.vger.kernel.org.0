Return-Path: <linux-kselftest+bounces-27899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C78EA499EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6E918991CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF78A26FD9A;
	Fri, 28 Feb 2025 12:50:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C851026F441;
	Fri, 28 Feb 2025 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747053; cv=none; b=Lf2DuKin8O7OVaYRqstVqSPwfVur5JP4t+B4C5P3YkaABqFCjKIjIZ2wiI6TXXABzFuHMxWjkspTLATHsu1Ynwar68rPJA+EzaUqA8fR7w7dAwjbTcbnywttDiy0wD8gW0XdxtmxKEzj1QWeAgYWpeOKd80aVZR2HPeZ1a67bTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747053; c=relaxed/simple;
	bh=6gPxy+Gjzs0wtcrZZOp/7nfOjVhRNXXz3rwJKT27e5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oix20Nq059Pv/40dBsK6A+65GKr0AVPbdlrXofFiYF5fGSh+qQ+2vuf9TD3GldTIHYbcEwQQ2YrfZpOhkiTjce4hmKz7QqyznB4foSYc2XXBhcObkeDy8o2+VLXaSYJKT/MdbfS2svYcoOpgm+iv+LyDg1yIFbBPw4gbFv8QxRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e4c0c12bccso3664337a12.1;
        Fri, 28 Feb 2025 04:50:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747050; x=1741351850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8a6FhlghUrkXdJwJYjyNKaoQUw1iyGn5+jpZ4MoQ6W4=;
        b=BP7U9akxsHCvrae1uirPtQbW/XHMMxjIKMaX0SUPrKIp5LwveAfHe/R70fSCYZEDni
         RCycEnhzqI/7+L+sRQlYctkqJcKEGAshrsKUPFKw0lQ/FHOrhMX538b4j0DhQRlJ+85Y
         wWHFsrOU0AbCOKtXnDKFPXb4nAJdQqdoDT2eRc1zU+6rASgoqFF4am9qBKLsap+wDxkb
         J44VLLabo4wY070nYI7wAOn4/VzkauVW/eps7Nv5JZVa0DR0qy9iYURqezsJQ1h16np2
         daD6l6iIe+DNjmR4/jlNJwkCzPLJLj2xBpGtuhiCkTF7UOXsVWCHQf35x86u3+ZWcDr+
         4BaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuQVFBxbMMoVAFxEMFV41xvPkCAUdLWkT7NzdWXE5qXApHRVXXGU6eqzf5r6R/LBfPJAyAeTW8S/L+0dNE@vger.kernel.org, AJvYcCVytPw5G8GD1qW9u/d6Y4UJoubMB0O7CxbHU+b7ydAnjI67TuqJDBfjtfYfbKO0tNVTyqE0jbw65Xc=@vger.kernel.org, AJvYcCXnbba7muZZm7tC2U071PXFAAqwENqIhJDW2jXWvaiNKL/YUbccYHZGt1rUt/eBIF4DbziIj8lJTCDywxbtf9qJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzef/XoV2Mrtl+covHpE8EgMVUCg9XJ5+22ynetRsSc5a9U9cQN
	4mmi2kYCOKNo7Fqyw/igLLVs8tM2JRGj7WDEP1Rv74uC0XIg2Aye
X-Gm-Gg: ASbGncuDweY+dTCreEq9QaZbKS86/mPxG1/rAp9VjOToC7Ea47UcMtePEpc1D9/Fj4I
	Am3Z6rEaV5humsHHNAzy7CbBqlVZf5eP+pj+aLKdGs0u17ZrJdWmxy3iqJl8NVHevo/hL6MDG8F
	imW2wlfZJAfwYo+G2U9mMzjidnL1RJtgyRX+DBU88IPjf4ZIoKL+j+iCPJkIg4kw3AizeKzQQpd
	KfEyi+M/RW+SvKEqZf+h0CFIKn9YOs6c1mb+fpoXUjmicJXISAJwA3OIa4dxEuTt6siLJkkQzxy
	+3PeJ0gKrKU3WpU7IR7EPmndjiIRng27vHM=
X-Google-Smtp-Source: AGHT+IEwFaPAZwLlfLkdwrNciHUkfDfFgnI0vwbefabU5i8t6X386u+vVeEb4vUI4AYNcUgaNFc52g==
X-Received: by 2002:a17:907:940c:b0:ab7:9a7a:d37a with SMTP id a640c23a62f3a-abf265c7b56mr305244766b.43.1740747049881;
        Fri, 28 Feb 2025 04:50:49 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0fc974sm284984766b.75.2025.02.28.04.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:50:49 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 28 Feb 2025 04:50:21 -0800
Subject: [PATCH net-next v2 5/8] netconsole: add configfs controls for
 taskname sysdata feature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-netcons_current-v2-5-f53ff79a0db2@debian.org>
References: <20250228-netcons_current-v2-0-f53ff79a0db2@debian.org>
In-Reply-To: <20250228-netcons_current-v2-0-f53ff79a0db2@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=3179; i=leitao@debian.org;
 h=from:subject:message-id; bh=6gPxy+Gjzs0wtcrZZOp/7nfOjVhRNXXz3rwJKT27e5A=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnwbEeXNnoVTCz2rq9W/ujoXQfIB3iP8VkT0mJD
 UQrj1oiq4iJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ8GxHgAKCRA1o5Of/Hh3
 bazuD/9FeXy178qfiyh9R/iSxXW85qpKMDMbXVAJf+OzcClwNDQ5CUI2fThkMVQLJM8Tk/xF0od
 7zCB2SEGxkqLh5SrQPc4tebs96kC3e+wOFCOGezzw6lNmUOruZqrOUGl/aNrikamOpRHkQw+M4K
 YOhjU2Za771YAgv5T8RrulwOPLoqAf47sOjiIF20yi73lok9Hxx4gnEwuJeh6rxOliYCIiDOwt7
 Tp6kQAOZZZpBC9m1N/Q9wNn/2UvpuN/AH6Gq419h1mrJOenKdTCYR02yEAxR4VZZK2lh47FBpOg
 0umViRkhvMvG4AAvfEsehwC10B/fW+/pWkD4Q7O6ol3/WQn8wWc2c3vih4mMWP1o2mpCvcnMsdL
 /KRAiQK7BEEp4WmijRPhfLzpdN4jYdkGKXS1OEO0Mtvn0Zr1g6ES7/D3f3ZcveFRE9DqgBxvoA9
 gNMbDAS9e6NYu6CmEQgNhl+BplYhgn5fIINZp0jjEBv1ybCYdZ1hcvbcDEsw9/D5naYkCjSdcnu
 KGYk9QytFX3c/xgVFQAZEJCjpD83ZPwtZbg3tQI6ty1S4OiNfnVyGi4ipNaXXsWBSRq6wtUNgeA
 IvA45PPc3/CUEmqM9HxC48I3rN6YfcTwhFqoGmb/wrZQ188ACUzSKg2hfauH0d0NyegPeIr0sb9
 7WtYfC0jpp/vcIg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add configfs interface to enable/disable the taskname sysdata feature.
This adds the following functionality:

The implementation follows the same pattern as the existing CPU number
feature, ensuring consistent behavior and error handling across sysdata
features.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index f46a0edf9c11e..9798b2b409e26 100644
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
+	curr = !!(nt->sysdata_fields & SYSDATA_TASKNAME);
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


