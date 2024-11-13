Return-Path: <linux-kselftest+bounces-21947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F9C9C75C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 16:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74D1DB31BF1
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 15:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E191EF956;
	Wed, 13 Nov 2024 15:11:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB271DEFC1;
	Wed, 13 Nov 2024 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510680; cv=none; b=h4gh7OIv6tlWwZU9qDDSvZs+hh4KrUX8/2P5HOPCkFlFrMUaajrcmYZsAES00ijTIWpgqBpkf480MX9ABLDvRDyaQvxJM5+mJ4YHxNtDFuxRYcHCCZoQH3Xoaaf0PLw0ZtNhZdENvWXYqVdh/usWDKWYOBMAvC5vYq3o9YZXAZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510680; c=relaxed/simple;
	bh=M9uDuQTAde8qumiV+TT94/net7Txx0TCYMg4owgJhXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ey0bjzGHtZ+t2OMFVIAeNxuCH90dkGHlBwj0UVwTZsoM78jWimkrBzoNXe5w48Z47TIATshesKiC3Nxfdni86XWNGY1MoH/FAJIxQIDw+9T25WqFgox/aiJSdDrxSWvnh2zWXfgf+/LZnRsm7Fnhxot600fHciHJf+G+WHaXCEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa1f73966a5so197484866b.2;
        Wed, 13 Nov 2024 07:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731510676; x=1732115476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suvmTaEnzl11zjg8cnygNcxRnDm3roxsjMJva7RhPLI=;
        b=taLDEtAHsll4aCs4bXjjv1Vbbpxor2RG5pQtgH0URDsSnCLT2XGg97UKyiDdmyjc1n
         pqCxa1i5KeMutxQwPu8y+dDxlqpqlGG3UL2gg85SdhM1Z7WlAKA73/xG8uj+ufnu7Gum
         /XQL5RpgA9Ei4owSsWk9a/FLOy/cfSJt8j6IPVw9irKPj1FOw4sopQjyc2lOPHtOJi6L
         9rcy5p0pJJj2upXEWEcbc3tSvtuNmhS5ElZFUG+7SYq6Vc81TnkNP4R3mp8zgIfrEbql
         +lSiDknJoN6yv6hA1W6bKu94+LsQeHwKZRb/qBiRWCm8Q8ghWNdbC904cbG46JR+eJzO
         wOkQ==
X-Forwarded-Encrypted: i=1; AJvYcCViOfiM7FpcrZky/EQ0NvYqnBdL9+iutNsCr5VTgscfkWUP+EJfxMcoI3XSqzFECmsu2LYTK5gUa5pmsalq@vger.kernel.org, AJvYcCWyvW1V6K3wjNmgMf15kPxxxWRY1pSkxZHGBy0ynKE9IWDZ8xH5bl8cjGb3sPhI26fF3MB5r6wZTQlh/QDQbhLh@vger.kernel.org, AJvYcCXfZlQ4ixmH0dCbhjsLY/D/6UghWoSIL1sutC9BDoPRUmOp19rphlYdMLY5u269VdvNPkaORlRh0ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZZ6WTMLKH2aIracwlD+MAfO7yr4p23moG+u5sY87X7ejEDMtq
	0oNqpPnAUwCrWWPTfAmH+Qw9JqI8Bcj2fmqg6zP4Z6JJ+aUDzIsN
X-Google-Smtp-Source: AGHT+IHr6qfcpHRDGdLKsLFJqQ9xks/fGPsz80h7XFddq8GevD34SOc4JX6iLzFGCnx1q2sNywl7Sw==
X-Received: by 2002:a17:906:6a19:b0:a99:d6cf:a1df with SMTP id a640c23a62f3a-a9eeffee0e2mr2122340166b.46.1731510676404;
        Wed, 13 Nov 2024 07:11:16 -0800 (PST)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0def50csm879414366b.154.2024.11.13.07.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 07:11:15 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 13 Nov 2024 07:10:53 -0800
Subject: [PATCH net-next 2/4] netconsole: Add option to auto-populate CPU
 number in userdata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-netcon_cpu-v1-2-d187bf7c0321@debian.org>
References: <20241113-netcon_cpu-v1-0-d187bf7c0321@debian.org>
In-Reply-To: <20241113-netcon_cpu-v1-0-d187bf7c0321@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, max@kutsevol.com, thepacketgeek@gmail.com, 
 vlad.wing@gmail.com, davej@codemonkey.org.uk
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5057; i=leitao@debian.org;
 h=from:subject:message-id; bh=M9uDuQTAde8qumiV+TT94/net7Txx0TCYMg4owgJhXw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnNMGNJX7xXHZAgpJIfJkaljoPuxitBTtwVin+2
 eqZXgy8NaSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZzTBjQAKCRA1o5Of/Hh3
 bZGDD/0c59dMjmJwCS7LsDusvfT1ekJUy9yMjzh0Td7k1uQ7WvAjIp3pkkxjFieoNEhadz90pCY
 5YjFyg4tNWeJiQ/kowuP/g+XKjE0bZJ6qjdDw+MZAb+BtN0KqqAYt7C2ltkRpUJEMgsOJUc92+/
 mGIHad+NYzKc04QUzrwg6MLOLzj7fW2Vzu948suirUBSH60qM1o4elCPnC+86ZJDkCHkctEtcXn
 SPv9C8g1pv8KQ+Cvt/v9PlkmLcyIR6c2CQR+l4rHck5V3n/He+CnMAon648tt4bPyaxev9JQDWp
 6yR/GSLUtBIxCg2oemY+s5R/p7aQdo/W69YPCeRo//Rq3MCtVe49vywKZHRA/2eGfFtRR7e7LZZ
 ZFHOav+Kr3iwb4gTxV40qHnUkK5WGwhsSqhXSAduAGbNT4dNO7zM4lPVl+c+3zr/v6UuotoEiII
 uxQOdMGdxsd+XTLjS8E6zAnwenivQBopObbfZFeXQqMSQ2ooP+dvKfCSALjlr79SDobrpdVsqZ3
 zm6sdfwhF2R/cwrfWEWNNdGF50BqJcaBFqoUK4KOjuOksUq51dhAmwuMrAyCOAQxLlDJ9Q9Vlca
 BSmRF6+knzyLTw3ZIBWpyuCId7CBxlHYyAbGXCx60I9udpCwIPC8yQacDdumpZU2+CblNZrFfKZ
 n/rtrlHcq+pMtQQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a new option to the netconsole subsystem to automatically populate
the CPU number that is sending the log message in the userdata field.

When enabled, this feature will append a "cpu=<cpu_number>" entry to the
userdata string, allowing the receiver to demultiplex and differentiate
between messages sent from different CPUs. This is particularly useful
when dealing with parallel log output that gets intermixed on the
receiver side.

The new option is added as a flag in the enum userdata_auto and can be
controlled through the populate_cpu_nr sysfs attribute in the netconsole
target's configfs hierarchy.  The main benefits of this change are:

 * Improved log message demultiplexing for parallel output.
 * Better visibility into which CPU a particular log message originated
   from.

Create userdata_auto as an bitwise enum, since I have immediate plans to
expand it.

Since the CPU id doesn't need to be precise, do not disable preemption
when getting the CPU id.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 965712d65a014c60f91bf35e48f1b112f66b8439..861e8988b8db4f29ae3de02222c9131059694aba 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -90,6 +90,14 @@ static DEFINE_MUTEX(target_cleanup_list_lock);
  */
 static struct console netconsole_ext;
 
+/* Fields requiring kernel auto-population in userdata.
+ * The fields are designed as bitwise flags, allowing multiple fields to be set
+ */
+enum userdata_auto {
+	/* Populate CPU number that is sending the message */
+	AUTO_CPU_NR = BIT(0),
+};
+
 /**
  * struct netconsole_target - Represents a configured netconsole target.
  * @list:	Links this target into the target_list.
@@ -97,6 +105,7 @@ static struct console netconsole_ext;
  * @userdata_group:	Links to the userdata configfs hierarchy
  * @userdata_complete:	Cached, formatted string of append
  * @userdata_length:	String length of userdata_complete
+ * @userdata_auto:	Kernel auto-populated bitwise fields in userdata.
  * @enabled:	On / off knob to enable / disable target.
  *		Visible from userspace (read-write).
  *		We maintain a strict 1:1 correspondence between this and
@@ -123,6 +132,7 @@ struct netconsole_target {
 	struct config_group	userdata_group;
 	char userdata_complete[MAX_USERDATA_ENTRY_LENGTH * MAX_USERDATA_ITEMS];
 	size_t			userdata_length;
+	enum userdata_auto	userdata_auto;
 #endif
 	bool			enabled;
 	bool			extended;
@@ -371,6 +381,18 @@ static ssize_t remote_mac_show(struct config_item *item, char *buf)
 	return sysfs_emit(buf, "%pM\n", to_target(item)->np.remote_mac);
 }
 
+static ssize_t populate_cpu_nr_show(struct config_item *item, char *buf)
+{
+	struct netconsole_target *nt = to_target(item->ci_parent);
+	bool cpu_nr_enabled;
+
+	mutex_lock(&dynamic_netconsole_mutex);
+	cpu_nr_enabled = nt->userdata_auto & AUTO_CPU_NR;
+	mutex_unlock(&dynamic_netconsole_mutex);
+
+	return sysfs_emit(buf, "%d\n", cpu_nr_enabled);
+}
+
 /*
  * This one is special -- targets created through the configfs interface
  * are not enabled (and the corresponding netpoll activated) by default.
@@ -726,6 +748,15 @@ static void update_userdata(struct netconsole_target *nt)
 					  MAX_USERDATA_ENTRY_LENGTH, " %s=%s\n",
 					  item->ci_name, udm_item->value);
 	}
+
+	/* Check if CPU NR should be populated, and append it to the user
+	 * dictionary.
+	 */
+	if (child_count < MAX_USERDATA_ITEMS && nt->userdata_auto & AUTO_CPU_NR)
+		scnprintf(&nt->userdata_complete[complete_idx],
+			  MAX_USERDATA_ENTRY_LENGTH, " cpu=%u\n",
+			  raw_smp_processor_id());
+
 	nt->userdata_length = strnlen(nt->userdata_complete,
 				      sizeof(nt->userdata_complete));
 }
@@ -757,7 +788,36 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 	return ret;
 }
 
+static ssize_t populate_cpu_nr_store(struct config_item *item, const char *buf,
+				     size_t count)
+{
+	struct netconsole_target *nt = to_target(item->ci_parent);
+	bool cpu_nr_enabled;
+	ssize_t ret;
+
+	if (!nt)
+		return -EINVAL;
+
+	mutex_lock(&dynamic_netconsole_mutex);
+	ret = kstrtobool(buf, &cpu_nr_enabled);
+	if (ret)
+		goto out_unlock;
+
+	if (cpu_nr_enabled)
+		nt->userdata_auto |= AUTO_CPU_NR;
+	else
+		nt->userdata_auto &= ~AUTO_CPU_NR;
+
+	update_userdata(nt);
+
+	ret = strnlen(buf, count);
+out_unlock:
+	mutex_unlock(&dynamic_netconsole_mutex);
+	return ret;
+}
+
 CONFIGFS_ATTR(userdatum_, value);
+CONFIGFS_ATTR(, populate_cpu_nr);
 
 static struct configfs_attribute *userdatum_attrs[] = {
 	&userdatum_attr_value,
@@ -819,6 +879,7 @@ static void userdatum_drop(struct config_group *group, struct config_item *item)
 }
 
 static struct configfs_attribute *userdata_attrs[] = {
+	&attr_populate_cpu_nr,
 	NULL,
 };
 

-- 
2.43.5


