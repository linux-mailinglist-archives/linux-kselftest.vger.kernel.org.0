Return-Path: <linux-kselftest+bounces-43331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4130EBE3FC4
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 16:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E33E504C47
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 14:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895EF345724;
	Thu, 16 Oct 2025 14:47:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9338C3451A1
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626027; cv=none; b=bbUPph/114pXqPfVEOVHRSYgKPje0w7iR85NWHZad9xr2MqEV5k6U13JQoVaAPddxMZy4aDGtEwrgN1iURc9JJkc6iidqC2F0p/8Xvp0mw/eSV5oFkmJL4q+ZFexZcVVY/KXwvCB0RjXUva7c0VI0ZyDmX4F2le3JeYLousZWVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626027; c=relaxed/simple;
	bh=5Mr6LH7k/o5N9dQgkLvHYmi0+jVFwD/oBoWEfwCDc/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+vh/ilqonzqhnZDPmKj/VgMspAInGPGDcNQ7MSNnxmHl+HqHb/3qUzHtgeeDhRoErWpfz/msZaeWp04e1/3S6K3m89C8VVqnhGpB0LuWSpX1z+i4XD6gtkUjV5vYyxn/FYgPY52fVhkSyH1KBfZy1vPoNC3tB7Gjm53/t+FNq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-43f86ddb3f4so286392b6e.2
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 07:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626024; x=1761230824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ChrD91ZzeSyIGW13Mo1kwbcyPzEVs4Rp2LDBd96Ha0=;
        b=VC/8QNF0+4t1VSN0sNf5WN+q7BG5AZBd6FPVDrnv/Nijjq4U/zQQz7bq23H3e0Djun
         zwT9XAwr2MEjMKAEF/xvxEDO08vgYk3Y85kCTz5ha0pHSizTJfZdqr2nNWwTigYHPe8U
         2xwYzoeIKtxO7tT73sfJw5hFKp5WtCwwkc0qmx3bIWJt0fplNKo4eWpbjSfJeHPXguW5
         fIf1ecMo7F16+esDhWbbtA+DmidUZFIHi+wiklJ3JDpmJNvSElvL+bCnW6+sqMcgb/WV
         z/oN08NsQUf04dSZJ8AdiT1sR8i0NkUZEM/NVZFQdWVrq7xJrXGZiubv+37lnME/hc7k
         iCoA==
X-Gm-Message-State: AOJu0Yypremfw5np6G2EoGhnVVmCm7gDBotljEse1JV7vSv8IXXytVUc
	epYDnezgvw2MqWjzvXOih3ea9Fp5jkc2vWxYd82eX5rISs+DE1J/Amkt7ifzNzRuDVSnGQ==
X-Gm-Gg: ASbGncvd9Z7sFSvGxP4exMYHqO8DSaTnYivTGVS86gor5k6HBy/Dsdk+0ILdEVN8PjE
	chm1iIF4x2O+PZiDIXKbZ8xH3I748Dinakun0F8HQtPu4fBPnZRakNynwrlk1INtfmA8MxU/yGJ
	i0m9q5EMDmPtEcfEmqCBWaQ/yemcqKVbtA4opEU0NXPSUKFkTOgpQ7QhWr+xz08UdSm3dGMFPWe
	Q/HwU1LJR+J5H6otaI++rJwVXo5DAT66TFCoeUbV1xTQujz/T8n05B47PJNwhVodSM59T6qeo/z
	pSwc0O+Y8Lm9spdIGzurMoUK3CHvZ5jwKVgXArW5TMl0Wlbe5N1eOK7i8C24Z6IKlCSGQq9UCPF
	7y1yERD6HqhDklH99XDpXRfM36D0sp0H63rgHk+lsr/J8Zp8npBIg2N4qadhMp4EnJnTBE/AEmu
	YXD18aXuKwH+TOz0cz5zegFlPGwQJCjNKQZxMOVmVMk7aX3fz0bla848kYQrPk0OAfETZ1VHkY0
	5fTCQ==
X-Google-Smtp-Source: AGHT+IGuFXjZd7WjvD1BFyxWZ/lTP2idxYYov/LGI6HCXqPlTW9NLsW1AmAB2FZK/Y+DjuFd+yYXvg==
X-Received: by 2002:a05:6808:1512:b0:43f:7a07:44d7 with SMTP id 5614622812f47-443a305da05mr102589b6e.47.1760626024580;
        Thu, 16 Oct 2025 07:47:04 -0700 (PDT)
Received: from localhost.localdomain (syn-067-079-108-173.biz.spectrum.com. [67.79.108.173])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-441cc812f24sm3678018b6e.12.2025.10.16.07.47.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Oct 2025 07:47:04 -0700 (PDT)
From: Jonathan Perry <yonch@yonch.com>
To: Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	James Morse <james.morse@arm.com>,
	Roman Storozhenko <romeusmeister@gmail.com>,
	Jonathan Perry <yonch@yonch.com>
Subject: [PATCH 3/8] resctrl/mon: Select cpumask before invoking mon_event_read()
Date: Thu, 16 Oct 2025 09:46:51 -0500
Message-ID: <20251016144656.74928-4-yonch@yonch.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251016144656.74928-1-yonch@yonch.com>
References: <20251016144656.74928-1-yonch@yonch.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor rdtgroup_mondata_show() to pick the appropriate CPU mask
first and then call mon_event_read() once.

No functional change intended.

Signed-off-by: Jonathan Perry <yonch@yonch.com>
---
 fs/resctrl/ctrlmondata.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 82f8ad2b3053..f28328c49479 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -607,6 +607,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	struct rdt_resource *r;
 	struct cacheinfo *ci;
 	struct mon_data *md;
+	cpumask_t *cpumask;
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 	if (!rdtgrp) {
@@ -639,9 +640,9 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 				if (!ci)
 					continue;
 				rmid_read_init(&rr, r, NULL, rdtgrp,
-					       evtid, false, ci);
-				mon_event_read(&rr, &ci->shared_cpu_map);
-				goto checkresult;
+						     evtid, false, ci);
+				cpumask = &ci->shared_cpu_map;
+				goto perform;
 			}
 		}
 		ret = -ENOENT;
@@ -658,10 +659,11 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		}
 		d = container_of(hdr, struct rdt_mon_domain, hdr);
 		rmid_read_init(&rr, r, d, rdtgrp, evtid, false, NULL);
-		mon_event_read(&rr, &d->hdr.cpu_mask);
+		cpumask = &d->hdr.cpu_mask;
 	}
 
-checkresult:
+perform:
+	mon_event_read(&rr, cpumask);
 
 	/*
 	 * -ENOENT is a special case, set only when "mbm_event" counter assignment

