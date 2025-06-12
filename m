Return-Path: <linux-kselftest+bounces-34841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 104A7AD7BC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 22:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8791897D6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 20:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E402E2EFF;
	Thu, 12 Jun 2025 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIs/nKXH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092DF2E2EEE;
	Thu, 12 Jun 2025 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749758601; cv=none; b=dO6Vn8xpRHxTLDg/fq6Mno694czwWFS9YfMbwVTRZRTHccHKgLMCvgqs+B29MNN88+vhxPVCv2VOYdZ8fcMkTcQXTa452Hy4k2gY+v1ENA8pB/9b1IZMTX+AWCSpX/WxkjBlYY+J3jkbq/5rjfmvqMjEZWg1+MvRpqmIEBQXT/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749758601; c=relaxed/simple;
	bh=mfkoUBQgABU7lMjOTs7x+P4cuvWas3SbIkz2Wq0vfk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E50zalSXvRyr8k7YSp3OpmU4TPOj4r9mJJc/FgwIaPIaAoZX9qWBqMeQ3+qSRfhLHR9NHSYa+w31zY2raD0lbJOHt1mtL/K5ZZA/EQoxUYMsxqjySpBmLPR6EuSduI+kDcaCemCydH39zPwac/3CCViDKzfy6iFUxe4ayvUNxCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIs/nKXH; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d094f67777so21600285a.1;
        Thu, 12 Jun 2025 13:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749758599; x=1750363399; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YfkFvrTGiA83jTYNLbHNHZ9OUEi+RY62zinuEM1ItI=;
        b=TIs/nKXHT70WNdif7fsRt6NhOFAJcHdviYVrbPGa6X3T4bXYFi+XShbxO2rIFX30wX
         GSnHDwgpd6Ol1qNpzV9p1vjsBJoD5aodDAHb9coJfm08tY1u47xsb08GTUqvoxeVzl8v
         uZXUBxTruYTUh95DzCmE8aMHukn8QWIR10qNtadDg+c3D8am/HuR2BnWBIk4JTaoIoKI
         8ABQGXx5xH2SvGsttb34AVt90fSLyTxJQU7AEcNeNGc7GISXtEbXuz/9gPiaYik6idKk
         peOf/emgZ+dwSvJb8KMYfrrWG4Ij4IX8t3h6Wf02DzdtNHXyNOhZ9YmDky9UUVd3A77p
         NSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749758599; x=1750363399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YfkFvrTGiA83jTYNLbHNHZ9OUEi+RY62zinuEM1ItI=;
        b=KEd/ybjHS+596q8EAtgjbY3zhBQuPUk1/O3c2bFyPHmmY7URM7DpSEeM4Jwo5ac99h
         VtsPwkwWp4zc9oh/V6JUJ1HSKx/FjUuWkZ4wFuGlKOl1KFaaHIiaNHcdhKSwej/GXk8Z
         EZPQHGcYHWCGy4kRdjcsjvDgSXOS282smjHlZmzgtaWErcwB/WgSgTLhRfktm4EG0tcL
         Jdw+tuJyLJimjeR7aA+uMjSyY0ZCn3Xlgd0q7jSacpY8BryF5iqoFORkLPO9uils91DS
         skQQsxh3Fr8Ymt48L2tprg+MrTfEi8f7izZfS83Ci+uKPHXCy0IH/cXqlWVDN55O5Ita
         4OcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7BJyamGdic1Sw5VMfEmoG6fd5d4KmVpl9rb6wVBxMu/MC6ODMvMkyih4qcWBSYTYvfWlT9PpcRbTyT7Bm@vger.kernel.org, AJvYcCXEBSJskgpuZHBTdwq6bDyLBl3e6X0sv2D1FitMwUuB1zqh2aQIC+bX+fgMtT2sshbh3t+ucPI/cqE=@vger.kernel.org, AJvYcCXY9NMM6g0vZdHv04uSrJpxX6mheUKyKmViTEKbZHxcCQFhqUUeLZQ/4goCGap+3WBGHdtu0B0SQLnEt/lnq3Zk@vger.kernel.org
X-Gm-Message-State: AOJu0YxCUXW8Oq4wUlX1IilHhms6ND5dBAWWOMQ5qqvROkdCRnHqPFyl
	TdzRaQ7XP3A9RdMuKqAVAJoJP6nw2YUk+PQ5UHR+wC6rfcg9FZp+mDN2
X-Gm-Gg: ASbGncvNHuIYntS/Z+A2VCO2yYNWDKENpG6sgm8mLeH6bh8SXpZIbglbnhmYTIW6Ecy
	/Qv10meZTBh2SlMVMuHKbcuxr4qY1+blt63u8GhXxYDcjDutFGnDnpnByIZDUqDHYRXDsi+6cf4
	d+f+ToHfdgxrkGZt0XVvB/3M+DqBMXpqJMoz5XnFyPDHcKw21uN5Y/N4FoPkMzl5TgPFL5FJ+pA
	A/SlijvKIkLh2Pi2yu045UoCKbSIGAYZ7Aywk7JxeMSeQOjW0ZpJuh+IoV/n6S2MGj0lffSakCM
	J2F7JDuA7X48hz29WdQ/i92iTe8J/8e3JK8NTFhagSUqSKbd0l2Z7oLhAGZAiPLXMA==
X-Google-Smtp-Source: AGHT+IHyrEl7B0UchZ89+sL/muxq+x5KSl3fvd5T3SB0HHUstcFpCwcK3KwCx2/oSPA7BZNskpM5Ng==
X-Received: by 2002:a05:6214:2348:b0:6f7:d0b9:793b with SMTP id 6a1803df08f44-6fb3e672734mr928146d6.8.1749758598636;
        Thu, 12 Jun 2025 13:03:18 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:3::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c6b67bsm13465536d6.95.2025.06.12.13.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 13:03:18 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 12 Jun 2025 13:02:15 -0700
Subject: [PATCH net-next v2 2/5] netconsole: implement configfs for
 msgid_enabled
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-netconsole-msgid-v2-2-d4c1abc84bac@gmail.com>
References: <20250612-netconsole-msgid-v2-0-d4c1abc84bac@gmail.com>
In-Reply-To: <20250612-netconsole-msgid-v2-0-d4c1abc84bac@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

Implement the _show and _store functions for the msgid_enabled configfs
attribute under userdata.
Set the sysdata_fields bit accordingly.

Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 5f8c8c6c5393..3bf8777fcd01 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -489,6 +489,19 @@ static void unregister_netcons_consoles(void)
 		unregister_console(&netconsole);
 }
 
+static ssize_t sysdata_msgid_enabled_show(struct config_item *item,
+					  char *buf)
+{
+	struct netconsole_target *nt = to_target(item->ci_parent);
+	bool msgid_enabled;
+
+	mutex_lock(&dynamic_netconsole_mutex);
+	msgid_enabled = !!(nt->sysdata_fields & SYSDATA_MSGID);
+	mutex_unlock(&dynamic_netconsole_mutex);
+
+	return sysfs_emit(buf, "%d\n", msgid_enabled);
+}
+
 /*
  * This one is special -- targets created through the configfs interface
  * are not enabled (and the corresponding netpoll activated) by default.
@@ -922,6 +935,40 @@ static void disable_sysdata_feature(struct netconsole_target *nt,
 	nt->extradata_complete[nt->userdata_length] = 0;
 }
 
+static ssize_t sysdata_msgid_enabled_store(struct config_item *item,
+					   const char *buf, size_t count)
+{
+	struct netconsole_target *nt = to_target(item->ci_parent);
+	bool msgid_enabled, curr;
+	ssize_t ret;
+
+	ret = kstrtobool(buf, &msgid_enabled);
+	if (ret)
+		return ret;
+
+	mutex_lock(&dynamic_netconsole_mutex);
+	curr = !!(nt->sysdata_fields & SYSDATA_MSGID);
+	if (msgid_enabled == curr)
+		goto unlock_ok;
+
+	if (msgid_enabled &&
+	    count_extradata_entries(nt) >= MAX_EXTRADATA_ITEMS) {
+		ret = -ENOSPC;
+		goto unlock;
+	}
+
+	if (msgid_enabled)
+		nt->sysdata_fields |= SYSDATA_MSGID;
+	else
+		disable_sysdata_feature(nt, SYSDATA_MSGID);
+
+unlock_ok:
+	ret = strnlen(buf, count);
+unlock:
+	mutex_unlock(&dynamic_netconsole_mutex);
+	return ret;
+}
+
 static ssize_t sysdata_release_enabled_store(struct config_item *item,
 					     const char *buf, size_t count)
 {
@@ -1037,6 +1084,7 @@ CONFIGFS_ATTR(userdatum_, value);
 CONFIGFS_ATTR(sysdata_, cpu_nr_enabled);
 CONFIGFS_ATTR(sysdata_, taskname_enabled);
 CONFIGFS_ATTR(sysdata_, release_enabled);
+CONFIGFS_ATTR(sysdata_, msgid_enabled);
 
 static struct configfs_attribute *userdatum_attrs[] = {
 	&userdatum_attr_value,
@@ -1099,6 +1147,7 @@ static struct configfs_attribute *userdata_attrs[] = {
 	&sysdata_attr_cpu_nr_enabled,
 	&sysdata_attr_taskname_enabled,
 	&sysdata_attr_release_enabled,
+	&sysdata_attr_msgid_enabled,
 	NULL,
 };
 

-- 
2.47.1


