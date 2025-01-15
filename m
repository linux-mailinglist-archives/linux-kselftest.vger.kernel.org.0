Return-Path: <linux-kselftest+bounces-24574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E54EA124D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 14:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295E41667C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 13:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA2E242274;
	Wed, 15 Jan 2025 13:35:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA57242250;
	Wed, 15 Jan 2025 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948141; cv=none; b=FAraTJvpBbJ51E69zX/r+mtSdwCdRQo0yPN4TJWrteQy3sSNnsTkHMh9HyPRJVQ3gvLJ5T11AjsQXR405aTmWMZSH9HR1bWCgSpWMAN0fplNrf6MCgZjVTFGHoDe1+Opn5hojlTH0M5TafUd8phF+WyrlkdyygfVWG/J6JYRh+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948141; c=relaxed/simple;
	bh=+5zPit+6w4Q87PebYLLQqICHMl8W7vM3JOE4biu2VRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rXKu8/NVgNX0iu0ErBrTqVBl/zq/9tb1HHXjyEF9IXztavphxN3rCiVXv5Z1LkaRhrDavSumOT3lgsUrdLPg4JNW6lhY1I9F3j8k1eW5SESnQZWyYXrZSaDmmTGPPfg+h+OtSGYMBUDm2oZYj2QXdWjvYOFN1YXZwyr08Fu349I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5da135d3162so912675a12.3;
        Wed, 15 Jan 2025 05:35:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736948137; x=1737552937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ec7/MpEi/atSJrAfxhBY2CBnYVqA9MsTtmzPCtszyDs=;
        b=b7rrZJWBjygi8FLdDMuuw0xm3JgetqvX5P2rMHi5l4mBcImpOl/Xnp1+Le8vMYPChs
         n9r3LLUbPfVJDyW2/z7ho3sj3/5ww19qtoF8i76gw1z4Hr/QWm6ZMz1RB9d/zxh4M2OL
         xgANfsuCQMkYAFkR3KUlj8tRDjDYB84JjijSMx6U9XzvGBm/kWTYvfgJicZwXhc+jefy
         awhZ+RT7Xkn31N4NY1vCQG4g4A/RDvwsGL7ig1w5tvhTGcRpW+NxOabk45PWFzLEt95e
         drrMl7HtmWgnXIBfZ4yheFJC7izFMG7M37K/tqMTvbhBcXUZNKWR50WmSNBbFrRTpBMz
         Cm3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKntCjvsBYSvigdZuUjd5kg7s3k+3KLNBOo66i8jv/5EsKIRjhEen3uk5qF1NdCmE025oXGrj9Yeqi4HEBeJ6R@vger.kernel.org, AJvYcCUmDzX1FbSZeaDpf9fAHi0MRDcnSF7GxzJaUaK9ZtZLx5dSBH8CSts40x/bLh2iyhG4ZKriN5OzUKdp5jo1@vger.kernel.org, AJvYcCXrclpNq6eV/KUq/JBjeKdvR2GoVYL7do65o/Vzeg0HCQQvv9ZEDWBZymE8OcYQvkKZLRplYObwXXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxia6Bi53oq4JxtNfurH22ZsrY82IBlAr+fADi8FvmkpyB5l56U
	E8U2YXnZHAkcoc+plAKFvpFt52Yj0cFFj6Rnzcve2DcAv3+MPEXm
X-Gm-Gg: ASbGncvPEAlQuKid4O6XxMGu2ndHig7R4s+LjvKCI5ckd/yGaKb217qUN2vLua9Mvp2
	G2IDmtrSQCc6og+//FK4nyCuqc0LbnHI5yB3KJU0xUNKRhWJkMmIefNzWEhvDH5CccBcQd/I3Rf
	ZyUcqZ5Zhmdh+YMGMjUMTDYeeoHO4oBOBYgpX4ZIBuPaUMWjZB5qTFDkmrMrsBdfODAoe3ZrTOg
	+pLNvfo5stsaR63J+Ipx7Q0I9on9fW+5Dr+Df/L3wpkAeU=
X-Google-Smtp-Source: AGHT+IH09HBaE5F9R+1j7gXj0uFhR8rhyxsE5IJFKPryqtPDjj7EmdMPOhto+lldRrb+zhknk2Yo9A==
X-Received: by 2002:a17:906:d555:b0:aa6:7b34:c1a8 with SMTP id a640c23a62f3a-ab2ab70a5a8mr2744648966b.55.1736948137238;
        Wed, 15 Jan 2025 05:35:37 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c906200dsm756580566b.40.2025.01.15.05.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 05:35:36 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 15 Jan 2025 05:35:19 -0800
Subject: [PATCH net-next v2 2/5] netconsole: Helper to count number of used
 entries
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-netcon_cpu-v2-2-95971b44dc56@debian.org>
References: <20250115-netcon_cpu-v2-0-95971b44dc56@debian.org>
In-Reply-To: <20250115-netcon_cpu-v2-0-95971b44dc56@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, max@kutsevol.com, 
 thepacketgeek@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1997; i=leitao@debian.org;
 h=from:subject:message-id; bh=+5zPit+6w4Q87PebYLLQqICHMl8W7vM3JOE4biu2VRY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnh7mjq51PJL8Ycf9UXn9bXWsFHJY2bHIhz8/j6
 yD2bPtiDH+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ4e5owAKCRA1o5Of/Hh3
 bWkuD/sEih3WhwQkHz5ZBfOd+xWT6WuuCHltCtJPb69SIob1kvyXGrh3WRYEUruuP1BzvglbWws
 OPX+xu2mG3AS+LzWQ9O7thr7/MMUilEKfMCfMe/v2u69awx+wdNNDKpJVg8iigcH7vJuF6bskOC
 yjuLvNQk54JiWQ2IRNKAbfQPXRiNkR9abgzWvTW8P7V4G2KeZ/4uHYuJtihJSLBDScZbHvsdhKC
 uFc2hAkgczwPGSf7GqIve+4vL0Z1b8e44fXUDlRz42BHwO7ua7klFPE1yO+uU1Iy23/45JRRxPW
 FHe4cUDrgg3Mq7VDac3dxKjSnlIx3/Xi+4bkCu8djGIqcD1+w/tEePh6xV53pk8gqVR9fA1hOmG
 GIrN8BwOjCa9StFMUF+DlTX67zcCgOyTruvzPUFAct5N52BoQg5/db3AFQUo4A7WI164WblqedS
 8AbWCSpFXJmXmlxkEbWzaS0Q1x35j686AUlJMF4y8GhzNWW9GU+QfcZtDvSPSv9ToOweJflJWJZ
 vWeCH+oCT6ygA3zEahgTmEyFproaXvqqeixhQLIuW/8ri71eG7wxxHsXI0gus6LI4qjKNs3dEAB
 m3HXfVw2skRe3nRH1QFZvLbC9rgbGaps/SUzre0M6PiWBS36v3Qxk7mykzLqVHLVkJUnGEqBh+f
 r4UA61CyiU8hsOA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a helper function nr_extradata_entries() to count the number of used
extradata entries in a netconsole target. This refactors the duplicate
code for counting entries into a single function, which will be reused
by upcoming CPU sysdata changes.

The helper uses list_count_nodes() to count the number of children in
the userdata group configfs hierarchy.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 5ef069e8277efa87d6f00d08277dcfe97a858cf9..108ec4f836b62860832c601768546c0ecbdb1153 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -659,6 +659,16 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 	return ret;
 }
 
+/* Count number of entries we have in extradata.
+ * This is important because the extradata_complete only supports
+ * MAX_EXTRADATA_ITEMS entries. Before enabling any new {user,sys}data
+ * feature, number of entries needs to checked for available space.
+ */
+static size_t count_extradata_entries(struct netconsole_target *nt)
+{
+	return list_count_nodes(&nt->userdata_group.cg_children);
+}
+
 static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 		size_t count)
 {
@@ -808,15 +818,13 @@ static struct config_item *userdatum_make_item(struct config_group *group,
 	struct netconsole_target *nt;
 	struct userdatum *udm;
 	struct userdata *ud;
-	size_t child_count;
 
 	if (strlen(name) > MAX_EXTRADATA_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
 	ud = to_userdata(&group->cg_item);
 	nt = userdata_to_target(ud);
-	child_count = list_count_nodes(&nt->userdata_group.cg_children);
-	if (child_count >= MAX_EXTRADATA_ITEMS)
+	if (count_extradata_entries(nt) >= MAX_EXTRADATA_ITEMS)
 		return ERR_PTR(-ENOSPC);
 
 	udm = kzalloc(sizeof(*udm), GFP_KERNEL);

-- 
2.43.5


