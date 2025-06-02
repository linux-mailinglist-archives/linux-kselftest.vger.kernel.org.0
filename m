Return-Path: <linux-kselftest+bounces-34128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3384FACAC9B
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 12:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FE117C3AC
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 10:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1060720B806;
	Mon,  2 Jun 2025 10:36:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C59A202C34;
	Mon,  2 Jun 2025 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860615; cv=none; b=UCmP3q6cFw4WX7tdLvf25UVYbk6NdoxuSuiiYq3cvLF1Yq7Kpo2KMJwZ3cLd8GXhpM0JBCZeoG0rprOBwZtOQzbQ7aPKZ30JZdThBB9BUiKJfgVlUfTXV/rTGy0HLYezeuhmXGo9MYdnH20HNb5hfsZJhA8Risx2SXYaKtNd51g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860615; c=relaxed/simple;
	bh=4fD26MgQ5lb4J157h0MaYK6UsFfxmQwlwDbLF3g5O2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fjQjJEM3tvAdmtDAODsLtypR+VJX0q8dv6qF6T8tYLxSIXQL+CPr6k8sieCnf6NvmgG45wN4/gBE17CTZCfIM2igUHIACNjWIPBMxxFt7/c7a7lt5yJwg8Y/3U+s25xclSQzHxWG+jws5ktmTnUsDvJVzZ69jcYIfojlqMlWuLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60410a9c6dcso8703805a12.1;
        Mon, 02 Jun 2025 03:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748860612; x=1749465412;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cx81AE+yKh5cQqt3R1DXjYj022vNRnA5zaqxXKNyhHs=;
        b=twDYCStcOm3MRQneRAkSswmgumpsa93S+DFpm6DQQtqho+a7Ok0l1KrhKSIAh7TIrF
         OUskWtIVafz5BN9uJBwlWfVx+EuogrcG0PfXiYPTnZvoF+WLae4urdbQvsv8uW9SicY0
         6MsK5fkm5E6Fi01OdBIg1PZTDDXAvomgxmdYTEeKn8xP3lDIAWTyG6HM4GpPlu3ELBtP
         f4LWyYsKa19UcQ8hGRhZ2SuGI4Y/oYYp6B3PYVDz5J+R2nytWWa+o1X5pI/m1Kc1EY61
         RgX58yF149oftcl+jyBdFqm3YcH/DAkKYkI65CKKy6kTKsj0SpxWuolT5WmJFSSR9dij
         7gCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx2M/AK/RIKQ6fdMjvoQMLXSkxcEXyccgMt/iQbFWL90luqkIAqGs0tPFKgAPbV20cSqkWbyuShR4q5sc=@vger.kernel.org, AJvYcCX/vX38OSrsCAk76PAgJttizxsF/DFOkp60CNglonxmTKWKkCmiUypq9xfXMtPZuiv2c99aOEPo+j5+q6aM0SsX@vger.kernel.org
X-Gm-Message-State: AOJu0YzHfL0CaHbSU+Qc0EhB0WfmzHDMCeoYlzWhr9LJ8VNFo0EZBjaD
	+7gXBUod2gu5HbtoDkO2BaQMdoHVuWQKAgRjH/BJ0EMuS9SZPCtFGJzq
X-Gm-Gg: ASbGncu0dQqLnQXkjMCZ7WHqGPKaOnlg0D8Qi0LIL3MkBWt5uzo94Qy7RDuKYCo4l/l
	QoXPSB9VibDBLn1zeX7org3JRKdGCNMyqxkZy4LJf7KT4VRGByETFkpy+Mf9qrKNQxj7Lha2Dgp
	x5wjQH+I2+FHw3BVH460I5qEvi8YigPu4/ha1i6ie/EyHSlgyyqPvxpYITX9cQyKbKOCQsMCkBQ
	OPgZlO/q+v4+2g90Q57mnzOIdz9Z5cN1dHYFYZaQJYonRflUgzaO6P1JZbZ2+OoE4c3vIP4k97K
	0KmdVDsURK9BkDqhBsKEiz6w0JPUIrldhleG8mXdFw==
X-Google-Smtp-Source: AGHT+IF09qxRKkGFS3XgMXHPACO1RFby7HBxhKRCrh2dpHrPZwLFYB8SEJpeAppJlzb7IjuyqXNQow==
X-Received: by 2002:a17:907:934a:b0:ad8:8529:4f7e with SMTP id a640c23a62f3a-adb3243a48fmr1228517066b.53.1748860612240;
        Mon, 02 Jun 2025 03:36:52 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5dd045b0sm783593566b.101.2025.06.02.03.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 03:36:51 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 02 Jun 2025 03:34:42 -0700
Subject: [PATCH net-next v2 2/4] netconsole: Add automatic console
 unregistration on target removal
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-netcons_ext-v2-2-ef88d999326d@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2422; i=leitao@debian.org;
 h=from:subject:message-id; bh=4fD26MgQ5lb4J157h0MaYK6UsFfxmQwlwDbLF3g5O2U=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoPX6/qORt/303IseM1rl9g9kJT94I4tFJ2i1z6
 pJXzcoAYrWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaD1+vwAKCRA1o5Of/Hh3
 bXGBD/0XgIVhEA3toroMJIQ5gHlKW3k3NqWIhIUGXalhTD4Lmx86w394y8SH+WUA/OEdm5uFxbt
 +NvwFY+68ao/JRTXoYxYfF3G5/+qNsf5yJ9b6YomoDBys2kBBc2zJOezu0Q6C0h6xQTpTmXc4rG
 Tqy3y4DSGa8R1CO0K9IBXyXBOgo8sQNA21J9ILaltJLfmXYGNP8jwCPmNHCftehwsBM6o2y9y5C
 N+ZKGZoX455kJCk8vvHRvlxwgqHXAYtJQomL9HQK73uLG6B7asqoEvZsBGKJsMJcB3zdUJofEX9
 2dgeVPdihjn7p5d9dTuOLomel6DEOufflwbxCT5VxWByugtaeK4OMr5/MOX4DZ42oftZ5GiCK54
 pJMCAdff3W6qpluGGoRJEiap2bSQ/rdh9OXbenRL8fQI90edgFGbcmwfmnAMiDwRlMzDmk/4va6
 fyJ4oXH7JrgIzuwOwoeMt3LBFWFYkOslnV1YrE4s3EKo1foNeHeHHhlIFBJo5YXwSzXYMhrGaXi
 Cwy4/cAAUC12lEpER90sIpuR8DeE0/tgLQMNWNRq3VIbjQp35/cCmz6hQFs8rnVPzlKGW/hnlJL
 qYkDBzH78qjXJ+Ey3MUKAl8fmZNu0FcOFKiJfVIU7+Tmln7moslyjSDvk8FDHuGq4RTOlOotDEz
 INdBMTzPao2NL6g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add unregister_netcons_consoles() function to automatically unregister
console handlers when no targets of the corresponding type remain active.

The function iterates through the target list to determine which console
types (basic vs extended) are still needed, and unregisters any console
handlers that are no longer required. This prevents having registered
console handlers without corresponding active targets.

The function is called when a target is disabled and moved to the cleanup
list, ensuring proper cleanup of unused console registrations.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 01baa45221b4b..524e717a71e8e 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -460,6 +460,33 @@ static ssize_t sysdata_release_enabled_show(struct config_item *item,
 	return sysfs_emit(buf, "%d\n", release_enabled);
 }
 
+/* Iterate in the list of target, and make sure we don't have any console
+ * register without targets of the same type
+ */
+static void unregister_netcons_consoles(void)
+{
+	struct netconsole_target *nt;
+	u32 console_type_needed = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&target_list_lock, flags);
+	list_for_each_entry(nt, &target_list, list) {
+		if (nt->extended)
+			console_type_needed |= CONS_EXTENDED;
+		else
+			console_type_needed |= CONS_BASIC;
+	}
+	spin_unlock_irqrestore(&target_list_lock, flags);
+
+	if (!(console_type_needed & CONS_EXTENDED) &&
+	    console_is_registered(&netconsole_ext))
+		unregister_console(&netconsole_ext);
+
+	if (!(console_type_needed & CONS_BASIC) &&
+	    console_is_registered(&netconsole))
+		unregister_console(&netconsole);
+}
+
 /*
  * This one is special -- targets created through the configfs interface
  * are not enabled (and the corresponding netpoll activated) by default.
@@ -528,6 +555,10 @@ static ssize_t enabled_store(struct config_item *item,
 		list_move(&nt->list, &target_cleanup_list);
 		spin_unlock_irqrestore(&target_list_lock, flags);
 		mutex_unlock(&target_cleanup_list_lock);
+		/* Unregister consoles, whose the last target of that type got
+		 * disabled.
+		 */
+		unregister_netcons_consoles();
 	}
 
 	ret = strnlen(buf, count);

-- 
2.47.1


