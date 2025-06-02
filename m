Return-Path: <linux-kselftest+bounces-34127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F575ACAC98
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 12:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D947D3ADFC8
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 10:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E172036FA;
	Mon,  2 Jun 2025 10:36:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDD01A8F60;
	Mon,  2 Jun 2025 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860614; cv=none; b=rzFH+BT4xl7ul7VJEkXm9yZUtujARxVQnLbvvDIzYqbhN3IHH9QIK8oukVs+92VgHcfXZwNZ9/gvqtg5JBKhQDy9gDf6Jfs4lpJNWOSxbiupR6PCp9+ih1nptnxuPYE5SkwefzpcILMlqN3HqYWutfOaSZOw2ILjUZwpUYuzVhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860614; c=relaxed/simple;
	bh=nvE9yPETJ0cMSZMbyble0XWiAJ5+Ig2FHrelAm52G1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qZXClDHebtDhufzA/xReawGplSRXYU69L7AbIxNar8x0laAWYB6IEI5YyWQ+HuIUo1OM4a2Oabp0R3hy/lALVyWjde+rgthKaXwYvKl8s8Ku1A37InmS/jtzVTnSqVyci5qQhIoH56xtpzDDda8XkI6WXEAnmAe+/EEhqDl08hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad89d8a270fso1101740866b.1;
        Mon, 02 Jun 2025 03:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748860611; x=1749465411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6K5ax7dZlM1ceqO80t37SY5RGau3fBKg0lIDvsG7A4=;
        b=MSpaJ80YjOXlxc4rXDA1kUijIV4wBgymAtZ4DpCK8ac8X+jJpzXz2+i3+ECeE9mIcO
         00gT49FwBR5LUoAlUNrEeaOuaOxdk9nRWhsWTVn6/oRbUyhke5Ro5EW1s/RK8lsaV90t
         luC0I+SSQpP+ldY5uTb/4/HdY9X9gTwWVX4DXnkuYyU7ZnTsJkQuFk265y8bXLm3Eui0
         mzXdAp141+9JU30k6stehBtdkJywCS407EeBGMjPCO0XPSbZTYVvysUIw+NIHDPBQwNj
         tzrLZDhGc/wvrj1KPHe9fPR2UqFeWOlbSe+xh8pfnex7V+iQlQifvkefl+ykpF9gBC1n
         RaWw==
X-Forwarded-Encrypted: i=1; AJvYcCUoDrHqfmWzYu+f8foVPaML89hw8RGc806JKSaL5ojtNir2mfbFCfxdiE61XPTSsOZGMquQhQaSW4rV2/Y=@vger.kernel.org, AJvYcCWxK8vPBS7/cIEZ0KVqdjO4pkI4AAxprC8j0u2cHfGL0/cHOxVathuekfB0Mx4PnL39NbnVe5+AsOr6NkF4cMNE@vger.kernel.org
X-Gm-Message-State: AOJu0YwX2Ud5qfof/moXpAhAvGwVhqKg3rSMjZcLpFeK3MsZG75wgtbe
	qXw7qvmlYpeP5t0w+zDoW/444O+HunWY4iiU5lFHOvGAU+ilhOXV05OP
X-Gm-Gg: ASbGncscACZUpR6CwAtfHE8rwDk2WOOKn3GE5yxGMmXjhAdPYa3YYley5tVqVj37K6X
	71cJ18i6GLLdCGWjzkcn55MF7P1ODzB63CPvgGkymF/wuNUDY8Kq0NIbWqKEFraEFI9p0oQcZkH
	p9HGwObXB2bSzKe399k+O2+nreXV67ZQQgdUu0ixXJHUuxdfQP8Y6jnp54wEmgebihjIe8sc0fn
	mORjrWBTEFsp3fxe6VtnHz9bb2a+0JfKXLpk4JQE8IdrSZS0dE+E8VUo3lc7WWHXQbDEV+y7BWz
	DNorkT9aMtTM7HjykEKst3lhF53kYn2ugRi1lA/vhA==
X-Google-Smtp-Source: AGHT+IEwQQmGG7JmanYi87opGtIkboqE4/2lSSj8MW9omCOguF2wAB+ABqXp7QIZHS0yFQUlknSPwg==
X-Received: by 2002:a17:906:c103:b0:ad8:741c:c527 with SMTP id a640c23a62f3a-adb328eca22mr1253781466b.6.1748860610879;
        Mon, 02 Jun 2025 03:36:50 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82d6fdsm772618166b.49.2025.06.02.03.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 03:36:50 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 02 Jun 2025 03:34:41 -0700
Subject: [PATCH net-next v2 1/4] netconsole: Only register console drivers
 when targets are configured
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-netcons_ext-v2-1-ef88d999326d@debian.org>
References: <20250602-netcons_ext-v2-0-ef88d999326d@debian.org>
In-Reply-To: <20250602-netcons_ext-v2-0-ef88d999326d@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gustavold@gmail.com, Usama Arif <usamaarif642@gmail.com>, 
 linux-kselftest@vger.kernel.org, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=4242; i=leitao@debian.org;
 h=from:subject:message-id; bh=nvE9yPETJ0cMSZMbyble0XWiAJ5+Ig2FHrelAm52G1A=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoPX6/q3dg41fc1Rwz0Jt3W6QWkdSlDXNqTODPi
 lYehKSg/oiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaD1+vwAKCRA1o5Of/Hh3
 bRHED/4yceVRRbgMWjujBTzXh/hPqv4DOjexxQ8uzdHE5H2wg5vV8HigfT5i2uFnlek72GOFmum
 spw2WEteAt6WCSkAXrUgiM/iaaERSSd5BVLQvxyemqJKY1+/BwLmOH/NcBt87t0lJOm/NdqB6iP
 er4zEzx/y8itP14SZXAI8CMymqTcA3OQ59jFQMxXvv6MUHU2hcS7DH7tq4dWtrWvhG/U+ERVeom
 DK6Sw4OkTHyxeSr9bbr4WCEUnmXmNkUBtQESvpMTBrjyJykTFTuNAKky66VJARaxH/P/DvXxrmf
 Sahnl4SPgOPprwO3LD3iD6q/EWzUD56Bs+fAPVeWYHhZA0hfCg7lCnUX+y9/nRLkJzqUp+T80EY
 koMhwcrEslmd0W2HVegKNIDFDUX5MBNEohtUHf6dl2FOZu0QkdUEHFrCcGLR3g08cR2//PBCIZO
 dYHIk3up7GXtLNLrdCfV4fBDlnGVoWQh2Zpd6yWMlZAJOiatN0vAfptjHMdeF12XBGlHygZe6im
 l1UeQRu45v/nSVT9emFpcqxnidgY8iTQZ9i6/Rs2dVXD/bn3uWsGDnhO6sfwANnwAz07nzRmS6Q
 naGmYN8HW0URxbsrI+9+1S78XPj31nK/u+l3qAPJtIfUUmwU2z56k6QPpLmgaRvUNpip+Ze2r0z
 5ntGgo46p/Y/Iaw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The netconsole driver currently registers the basic console driver
unconditionally during initialization, even when only extended targets
are configured. This results in unnecessary console registration and
performance overhead, as the write_msg() callback is invoked for every
log message only to return early when no matching targets are found.

Optimize the driver by conditionally registering console drivers based
on the actual target configuration. The basic console driver is now
registered only when non-extended targets exist, same as the extended
console. The implementation also handles dynamic target creation through
the configfs interface.

This change eliminates unnecessary console driver registrations,
redundant write_msg() callbacks for unused console types, and associated
lock contention and target list iterations. The optimization is
particularly beneficial for systems using only the most common extended
console type.

Fixes: e2f15f9a79201 ("netconsole: implement extended console support")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 4289ccd3e41bf..01baa45221b4b 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -86,10 +86,10 @@ static DEFINE_SPINLOCK(target_list_lock);
 static DEFINE_MUTEX(target_cleanup_list_lock);
 
 /*
- * Console driver for extended netconsoles.  Registered on the first use to
- * avoid unnecessarily enabling ext message formatting.
+ * Console driver for netconsoles.  Register only consoles that have
+ * an associated target of the same type.
  */
-static struct console netconsole_ext;
+static struct console netconsole_ext, netconsole;
 
 struct netconsole_target_stats  {
 	u64_stats_t xmit_drop_count;
@@ -97,6 +97,11 @@ struct netconsole_target_stats  {
 	struct u64_stats_sync syncp;
 };
 
+enum console_type {
+	CONS_BASIC = BIT(0),
+	CONS_EXTENDED = BIT(1),
+};
+
 /* Features enabled in sysdata. Contrary to userdata, this data is populated by
  * the kernel. The fields are designed as bitwise flags, allowing multiple
  * features to be set in sysdata_fields.
@@ -491,6 +496,12 @@ static ssize_t enabled_store(struct config_item *item,
 		if (nt->extended && !console_is_registered(&netconsole_ext))
 			register_console(&netconsole_ext);
 
+		/* User might be enabling the basic format target for the very
+		 * first time, make sure the console is registered.
+		 */
+		if (!nt->extended && !console_is_registered(&netconsole))
+			register_console(&netconsole);
+
 		/*
 		 * Skip netpoll_parse_options() -- all the attributes are
 		 * already configured via configfs. Just print them out.
@@ -1691,8 +1702,8 @@ static int __init init_netconsole(void)
 {
 	int err;
 	struct netconsole_target *nt, *tmp;
+	u32 console_type_needed = 0;
 	unsigned int count = 0;
-	bool extended = false;
 	unsigned long flags;
 	char *target_config;
 	char *input = config;
@@ -1708,9 +1719,10 @@ static int __init init_netconsole(void)
 			}
 			/* Dump existing printks when we register */
 			if (nt->extended) {
-				extended = true;
+				console_type_needed |= CONS_EXTENDED;
 				netconsole_ext.flags |= CON_PRINTBUFFER;
 			} else {
+				console_type_needed |= CONS_BASIC;
 				netconsole.flags |= CON_PRINTBUFFER;
 			}
 
@@ -1729,9 +1741,10 @@ static int __init init_netconsole(void)
 	if (err)
 		goto undonotifier;
 
-	if (extended)
+	if (console_type_needed & CONS_EXTENDED)
 		register_console(&netconsole_ext);
-	register_console(&netconsole);
+	if (console_type_needed & CONS_BASIC)
+		register_console(&netconsole);
 	pr_info("network logging started\n");
 
 	return err;
@@ -1761,7 +1774,8 @@ static void __exit cleanup_netconsole(void)
 
 	if (console_is_registered(&netconsole_ext))
 		unregister_console(&netconsole_ext);
-	unregister_console(&netconsole);
+	if (console_is_registered(&netconsole))
+		unregister_console(&netconsole);
 	dynamic_netconsole_exit();
 	unregister_netdevice_notifier(&netconsole_netdev_notifier);
 

-- 
2.47.1


