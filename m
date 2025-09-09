Return-Path: <linux-kselftest+bounces-41071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBACB507EB
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 23:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842D8463164
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 21:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6B5262808;
	Tue,  9 Sep 2025 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiq9GFnU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C46255F57;
	Tue,  9 Sep 2025 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452370; cv=none; b=fc6E4oNfLW99pyNZeSEpUjoZHf15Y16rm2RiE01DrXpqKNb1lWjmE25QWMQlC9r34jac8v53J/Y9xNxb1ufxHageuIKU18ZcLSSPAp0lc+JPu+dz1Rs4LppBEf3wxxGdDosTZseBk5zoIM5R9KlvDNpxABautzWse+05lvhwRvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452370; c=relaxed/simple;
	bh=opQUQP9zUqOgPxXg26hq+yrVXAyCG9IkDejdHA+WJ14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o1vVoS8UV6W10wCrpkcE4So3Gqlo+ky5a/vlfaeYDA5FdMXv9v6J7ptRnc67ePGw/uCT6+SCLgD5no3arwZn+AJa30RVdOfSn3/oirytqT81uROR73294rLCzOpL96ms0EXDnWCZeZuLPz42IVgLlclk83gmnQ79jg524/NQx3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiq9GFnU; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f78e3cdf9so7430629e87.1;
        Tue, 09 Sep 2025 14:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757452367; x=1758057167; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVyHAPg3FO0HjHYvN/1HgPTa9DwQTlAlNLzU4rc7wAc=;
        b=jiq9GFnU5aWchRuJ+SM6RTh//7K9q/8cd4I6qV6eMIEbriAGCodB5ySeq7ssgH1eUO
         Me3MFYyzsDXg+BE5P37ue8+LaXTFaPOqj2wORMeEmpWRX16/H0Ov9+8wN4Mf25W34lr7
         dVJQ5f6VQwOo1psyG8ph8uarcjM5bVC22ZnCygFEG6fVlltKgwolszj1o7e5n85Ih+Rc
         INzVMYSJ8P4tt7MGbUGwz0HtPbxJX8NQHSA7I/7e45d/85lKoRpwr3Pl+RTDmGlbhm9R
         8GFm5SPSWeRW46k5ne17HhVoie80K71Dp2Al1KsoKwIugYeoueXcXvZ+8+zVRbi1JOF9
         3lIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757452367; x=1758057167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVyHAPg3FO0HjHYvN/1HgPTa9DwQTlAlNLzU4rc7wAc=;
        b=QuXahBj11b5b5EinDtzLQsNQAE3ZIVdn2byUf8fLT7HaEg0c4TmPoYgsSjA6x6ILlh
         xwEJ2/M0cCTzyyKpKQ4JXKU0nCFfyiUQEYLXedHAtNLm9sixslBtK3dkryHiBYgYqWyg
         0OXGROlL4WWV0fVd7l7PDIULj2WCQm5lWb3wrj6O9PXNiOIB10VS3qxhzh8ykhMlwuKh
         w7fXA1Tz1sS3WoadOMXCFwt8RfX4vUUJDtWfD4ZSof9VpPmG6uMrrxG4rkbBdC+vt6A+
         VhLmiTNmbp6klbWU8KEHZhQ3eohYOukaXlmMksSrw5DWoeci4NLRND8NDtYN3TElQKOV
         1Bug==
X-Forwarded-Encrypted: i=1; AJvYcCVjmngqW3V+Lz7rqHdedu3TZ3+98wKZECP1YPEZ77hnK9O4Zxdm8H3Bk52/yeYLrGCJwzj5U0uXdqMxOAU=@vger.kernel.org, AJvYcCWAhIT/s5Fkmfi8psSlB7buMNl1KQNwQ7Izp6EcV/TtbUm6hB3LOvsYBQF4kN6IJFWCsZhGdVCUzBN4DnnhdhGO@vger.kernel.org
X-Gm-Message-State: AOJu0YyzhrK51w+VTWXFlPz1Sc3dyzh3vqwk2RGgZlMPcdifb72B/KaX
	yLZgaLMyJtz37D14vCA6RHIHIZ73igHHASDKN7qa2R3vtrLwAfu2dqzS
X-Gm-Gg: ASbGncsFr17n7pV6MJRPqEYe9RcRc5kNrsjPmCoiKClbvlCccjXZKNv83f/Xh7P25bZ
	UvCqkHSmgsCWYBef2z9HByh4TDrzkFqRQmJne1tzJPFswPIhr8hO4r5438eQdWegm8fvaAxPMmZ
	zY/+5ETk6rvo0tdkiUj6nv2450lZznD0moxoGRWqKGnimBqABp/iOyZmiVr6IvqywoYQ1oNgWZA
	EDd8MQhRKwQ0oQfdVA1SpkMYvUhqYmPZAs1Wch7wzoFXtc13e4+QauTBHOJS7Jz19syHjYVgPDL
	gdGCuDuNK4KoN+ywMrLdL/6DPXVBU+YVJfN8YEKIhOSCOoSduzEtR2WgR2amgGjPrPolpgBZGLN
	GbUxy3vvvJ7pUSoSUh480RRe92fc=
X-Google-Smtp-Source: AGHT+IFN90FouCWG5RAA3sTPY0LKbR6LqVwS75kzpWSAJhnYf/xIkcgYADcBYOiCQRNWlcNz5qCUKg==
X-Received: by 2002:a05:6512:1589:b0:55c:c937:1106 with SMTP id 2adb3069b0e04-562636d5e48mr4204786e87.28.1757452366752;
        Tue, 09 Sep 2025 14:12:46 -0700 (PDT)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680c424fc9sm757025e87.9.2025.09.09.14.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 14:12:46 -0700 (PDT)
From: Andre Carvalho <asantostc@gmail.com>
Date: Tue, 09 Sep 2025 22:12:15 +0100
Subject: [PATCH net-next 4/5] netconsole: resume previously deactivated
 target
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-netcons-retrigger-v1-4-3aea904926cf@gmail.com>
References: <20250909-netcons-retrigger-v1-0-3aea904926cf@gmail.com>
In-Reply-To: <20250909-netcons-retrigger-v1-0-3aea904926cf@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757452359; l=4008;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=opQUQP9zUqOgPxXg26hq+yrVXAyCG9IkDejdHA+WJ14=;
 b=VE8vG+mqtHDU2xhEgKx3nupTyYDeJi70qtU7Qp3UhB22sBJDqQXvXGxZhGSeM957dlLj72td7
 4oV7MA5OYtvCSGTXBPllXZMgohHylfwKRHYoGPr5YF+FhFqJkcek5oM
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

Attempt to resume a previously deactivated target when the associated
interface comes back (NETDEV_UP event is received).

Target transitions to STATE_DISABLED in case of failures resuming it to
avoid retrying the same target indefinitely.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 46 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 59d770bb4baa5f9616b10c0dfb39ed45a4eb7710..397e6543b3d9aeda6da450823adee09cb3e9ae70 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -135,10 +135,12 @@ enum target_state {
  * @stats:	Packet send stats for the target. Used for debugging.
  * @state:	State of the target.
  *		Visible from userspace (read-write).
- *		We maintain a strict 1:1 correspondence between this and
- *		whether the corresponding netpoll is active or inactive.
+ *		From a userspace perspective, the target is either enabled or
+ *		disabled. Internally, although both STATE_DISABLED and
+ *		STATE_DEACTIVATED correspond to inactive netpoll the latter is
+ *		due to interface state changes and may recover automatically.
  *		Also, other parameters of a target may be modified at
- *		runtime only when it is disabled (state == STATE_DISABLED).
+ *		runtime only when it is disabled (state != STATE_ENABLED).
  * @extended:	Denotes whether console is extended or not.
  * @release:	Denotes whether kernel release version should be prepended
  *		to the message. Depends on extended console.
@@ -172,6 +174,7 @@ struct netconsole_target {
 	struct netpoll		np;
 	/* protected by target_list_lock */
 	char			buf[MAX_PRINT_CHUNK];
+	struct work_struct	resume_wq;
 };
 
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
@@ -237,6 +240,33 @@ static void populate_configfs_item(struct netconsole_target *nt,
 }
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
+/* Attempts to resume logging to a deactivated target. */
+static void resume_target(struct netconsole_target *nt)
+{
+	int ret;
+
+	if (nt->state != STATE_DEACTIVATED)
+		return;
+
+	ret = netpoll_setup(&nt->np);
+	if (ret) {
+		/* netpoll fails to register once, do not try again. */
+		nt->state = STATE_DISABLED;
+	} else {
+		pr_info("network logging resumed on interface %s\n",
+			nt->np.dev_name);
+		nt->state = STATE_ENABLED;
+	}
+}
+
+static void resume_work_handler(struct work_struct *work)
+{
+	struct netconsole_target *nt =
+		container_of(work, struct netconsole_target, resume_wq);
+
+	resume_target(nt);
+}
+
 /* Allocate and initialize with defaults.
  * Note that these targets get their config_item fields zeroed-out.
  */
@@ -260,6 +290,8 @@ static struct netconsole_target *alloc_and_init(void)
 	eth_broadcast_addr(nt->np.remote_mac);
 	nt->state = STATE_DISABLED;
 
+	INIT_WORK(&nt->resume_wq, resume_work_handler);
+
 	return nt;
 }
 
@@ -1440,7 +1472,8 @@ static int netconsole_netdev_event(struct notifier_block *this,
 	bool stopped = false;
 
 	if (!(event == NETDEV_CHANGENAME || event == NETDEV_UNREGISTER ||
-	      event == NETDEV_RELEASE || event == NETDEV_JOIN))
+	      event == NETDEV_RELEASE || event == NETDEV_JOIN ||
+	      event == NETDEV_UP))
 		goto done;
 
 	mutex_lock(&target_cleanup_list_lock);
@@ -1460,6 +1493,10 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				stopped = true;
 			}
 		}
+		if (nt->state == STATE_DEACTIVATED && event == NETDEV_UP)  {
+			if (!strncmp(nt->np.dev_name, dev->name, IFNAMSIZ))
+				schedule_work(&nt->resume_wq);
+		}
 		netconsole_target_put(nt);
 	}
 	spin_unlock_irqrestore(&target_list_lock, flags);
@@ -1915,6 +1952,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 static void free_param_target(struct netconsole_target *nt)
 {
 	netpoll_cleanup(&nt->np);
+	cancel_work_sync(&nt->resume_wq);
 	kfree(nt);
 }
 

-- 
2.51.0


