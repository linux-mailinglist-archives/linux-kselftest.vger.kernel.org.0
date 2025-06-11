Return-Path: <linux-kselftest+bounces-34728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77C9AD58F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 16:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FAE07ABF04
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C81A2BD01B;
	Wed, 11 Jun 2025 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFzL1/y7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61051865FA;
	Wed, 11 Jun 2025 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652665; cv=none; b=tRXu/wvdgglUu+Rl43okFjMlTWLVyz0rFCsxPm4FGiiFErZFmT5S6/TkbwPiQkNUSeLBf9h8upuUXEx9HJ66bnRKN+OpAXm4PeEnC2u8YAfqqMeMEGbGeQcDZ1vHmTrnE7hOY6eZetyMHA9fnx4AZJyzbVMRg6TXPRp1zAFbdjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652665; c=relaxed/simple;
	bh=OiPRRK5piH3idkJPfTLqCzMAg5A0Ic9Hcu38DBnvdQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tZrgms+IqArznqYlLO0fJ/wRg+cX0krU7Y8l4hJcDLH4HEdj7rgK+aPN20cFfYVsaW9yUsHj01sZtzFXhLgByFYIdZ6pfWSFeczCgPp0dWk0Idlb9fgKuOeUVn9beTQAfwoT94B4kQEAgpOrmHOrykl8A1Fx5JDZlGe6cJ8au+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFzL1/y7; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fae8838c1aso308276d6.2;
        Wed, 11 Jun 2025 07:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749652662; x=1750257462; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFZtFnNSCd6XICWhSL9CTpUln5QBYBY/QPDvCN5iXGw=;
        b=EFzL1/y71r07ZXN7zSXUx4Va/T8iBGZbCs8ReeNcUI/wYMBlCg009dhha50IwfLMQ/
         firBRxjKKcDNsiOKQz8R9M4Si/cnqeG3yQ/nj9Nz9HXJUJ9W7YSZhsgnCTE9CD3smUj5
         srIHkelf2FlVdcixfPNTIIVKsWy9EBqkRpRw/VeeFcy9vco17RJMyVH97uNBDns02fs0
         qZnT1T1OAKuSccFzIvkhWn7HmKo6xdajVl09IViKO6wHrkERcKC7xLF+FbbhL4eOWBm3
         Bir/w4OompcHSp4hJCFc0TAhAHG2h26fbz7ybDbl+xjwPH5guhRncv3EUJktVwJqobSw
         0SVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749652662; x=1750257462;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFZtFnNSCd6XICWhSL9CTpUln5QBYBY/QPDvCN5iXGw=;
        b=IdOXqP6p/DQbzs3qbYnYuLtxswLKTHSEM/UdNvXrHp9k1yY2Y2Wc2DryIlaEuxYYIA
         BV+j5v4Vsn5OVQVcRNV8Mc9OXfllDCP0q/3oaeYTkJZVsQ3QUB3bf66hZaTLMTZP509s
         APtfxe87TmWfwAZRfzvYyIKPSVW0Od9nbsSbCnzOrDajC/XUxgJxE4dDS8YrJNeZ8QrL
         cP4H61B/yuRbtfrAYRijm7Ekrbq4tyro3UO27zUbq7TZIdHfVx3gvSxge7nH6K3JTdo/
         Tw4ntt5vDzxviaDplLxl7MEMd9yECfi5osqPvDgIJ7rR3A0ozt0cVnnJC9aI8KhCbtis
         xtXw==
X-Forwarded-Encrypted: i=1; AJvYcCUD7GYrIZOhEtt1crsrN+6gewSn8zelOTJLSpa1tMHnRBjbMbtdgIHNXsQwXuvva3lZp+fdfA6k718=@vger.kernel.org, AJvYcCWeCn+phG/1ATNLrCkr77zu3txALLObnhQ1D3qT/EqYxyNKWGcHH42e9NFIL4zL18RD6izgtZAeX+5OnIRF@vger.kernel.org, AJvYcCWlCCFJfocNq38miJeOxLMWNRiooEFUyA5/HsHi9/nsxgSlOjmsoW/9QXzUS3KSYTwkvzszmBMMDKCrG4fYhG5a@vger.kernel.org
X-Gm-Message-State: AOJu0YxG0CylGRwoRtuHmhy/Uxuunva8yrvldaJ1alwAE8WorNLyYsxw
	j6bJVlJBhrMrTNY30WpmaXOzJ403AwSPSzDltlKNa7oU8MUPwqZWdIZDiXmtbv0ZsNo=
X-Gm-Gg: ASbGnctxkJMhjxOC/qKjpJkff2f+R5C5iZlR5+3KlMdJTOrkKLsRh55/9VTOgLX05WL
	x5EMcqTHRFd5noqUCX8981HiYltaUpB37eP/oLciRV5U62Qx4rUECj2j2YxIBlXKXhVIeUekfIb
	0KgTU5z2U8OBamuoKfTZ7cWe6LH/c3BhxfG3jdQ8tyQF+45EURZdsHhPlVKCX1ITHRjBVc0uJIy
	B2uVSG3Fbwt1z2X1gvfiylnF/vq5rRIsu5GP9ZANyMHkyRB5knuBGX7RVRCg/NpgvCmdCLB3AZ8
	k16FTo86+zg4jCg323uD3s0xHO7evdfo7ehe8nt4lRF9AMb17meu6Ks/
X-Google-Smtp-Source: AGHT+IFgJ1JvD9zobZmHURaq/FhcLmnzvPhcIvvLrVAE5C1rBTgIPotn5hK9gzflLmngjlfMTXjoHg==
X-Received: by 2002:a05:6214:b6d:b0:6fa:ed19:2566 with SMTP id 6a1803df08f44-6fb2c31ea88mr22245346d6.2.1749652662005;
        Wed, 11 Jun 2025 07:37:42 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:73::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d38c067179sm633968085a.73.2025.06.11.07.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:37:41 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 11 Jun 2025 07:36:04 -0700
Subject: [PATCH net-next 2/5] netconsole: implement configfs for
 msgid_enabled
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-netconsole-msgid-v1-2-1784a51feb1e@gmail.com>
References: <20250611-netconsole-msgid-v1-0-1784a51feb1e@gmail.com>
In-Reply-To: <20250611-netconsole-msgid-v1-0-1784a51feb1e@gmail.com>
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

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 787d170c3a0b..813f50abaf9f 100644
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


