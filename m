Return-Path: <linux-kselftest+bounces-43334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC38BBE3FDB
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 16:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BEE1586A6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 14:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B23B34575E;
	Thu, 16 Oct 2025 14:47:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885743451DF
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626029; cv=none; b=rnEMIaS0P9maH1gA6VHUaGeRAFHR9YkKX7+8U9ftsJz60hZE0/K3fp6yTTBuIyMdi6yXKRTBmFbJCGrd5NCWDCM9Xs7YHfgflOiqxNgNkldeyXVPMWGoL9dqhJM23T3Uc66tEroh+OoMJMu/B7DBM06rYb9gBRyTaLBUb5dRFEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626029; c=relaxed/simple;
	bh=qrYx4OQbtVttMxYPNSKZyKUM/2EziepE/DMT9sZuO9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLAtZVdemhfkkvHUTYDT/LH9wapcZciVLWa4l6rJK+vo7+u33HTptc1EevewlRIzfXc3MboOC2JRE4uy5zc5N3iWcVRxWGmwZQPEmwdNrU41dJXkCZtANCdczzSTNhq0R6+nfzGlwOdNxbwNFLPe+1QNPCOuru729My50/nkPhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-64e84414cfbso368556eaf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 07:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626026; x=1761230826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6FTC4pXxezWlArm57ZmRQwBfAYH7sPfczRlTm0tzCY=;
        b=j8nUB0bL9GWcc3cMYEwzD+7/34NrIEUNHjOLju2668/R2lzz0wTOiXwCh8FB4Ktg0a
         NFcf4FAN6KFqTvao6dVku+dpAqhQ/dmCD/nGqFANux9wtRv7ss66S/k1pWavxhngShVo
         4pjuaGGC5X/NhyIzgfSY+eiRawPEZBfTrC2Jvf+HOnUMTkhI/EhMIDquMMSBLoSgukAF
         oaigboJ/gOLtIJ8nv9UzD/bpePFdvtElgTXNY4Dg6o4JVoFXB+l0aLZcCKI/GhAjzfsm
         MRNH63oabt1thgK7LrMUbZmHsPdGNA11Lof1s+ttd5HO0kCP5d1CovX+HjDrjg3vlQ+d
         ImaA==
X-Gm-Message-State: AOJu0YzgA2mHM+O7VnNi6YbpRtfZphVlnK6XXo2FSwa1aWWvxiN6IOGR
	JlW9zmkIulfgvAVO5EuOUqknuJp7foHgHDDAWfBGuAe1nhxjVc6t65pV
X-Gm-Gg: ASbGncvO0mR6PIVOeHZXzZwlnOniTXL8op+9A+xu6rwzl+87OlgfVS2+adD4WrD19RM
	XeM09Nj00Yxr21YlJ/xJLf/32I7Ygocoyf6EdYkWMmbFhK6z463la9RUiJxx1b/B08MMy9mOxcp
	uksTAzkW0UdBJIp86ePqNsnDE80fK3SoqRDjpY6X6PtyHsDYjr75J3jMvSS8ss96VrUt5o3NzJ+
	VUA5NFuv8zyO013Gbxpaaq7zGCEyBbx/YpdwF+zbqNj1s0YW9jxu5FRVT7cOUZ4+/FuGIYDHqI0
	GnLIbvmOIp6ugAAuTEFwcEBTk3STANGdbUG280FnT0znxgajvGkZhpvcQa6j4ajYaf8fSxaQ9Qz
	g2OHg3t47mt+Bq7+8xlhVY4OI9+K3kNRf9Mfn3zkub9M+iC+jE5KSqFf/wD5tjFUft8BVdbFO0D
	5ayC/6AbyBhBhXVsqupJoVYIuNN4YkSQa7ClvwMBnHpCVkKuKymeTl7Gk1u/OGRBTAp0s=
X-Google-Smtp-Source: AGHT+IEqY0Itcc1XjdzEUHZg7NibgLkNaNHb6IF/rm8TnzxUng5S0hLv2Izsxr0tjhoHkMDieMlXEQ==
X-Received: by 2002:a05:6808:4f0a:b0:441:fb07:c178 with SMTP id 5614622812f47-443a2ed0503mr112853b6e.8.1760626026415;
        Thu, 16 Oct 2025 07:47:06 -0700 (PDT)
Received: from localhost.localdomain (syn-067-079-108-173.biz.spectrum.com. [67.79.108.173])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-441cc812f24sm3678018b6e.12.2025.10.16.07.47.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Oct 2025 07:47:06 -0700 (PDT)
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
Subject: [PATCH 5/8] resctrl: Propagate CPU mask validation error via rr->err
Date: Thu, 16 Oct 2025 09:46:53 -0500
Message-ID: <20251016144656.74928-6-yonch@yonch.com>
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

When __mon_event_count() rejects a CPU because it is not in the
domain's mask (or does not match the cacheinfo domain), it returned
-EINVAL but did not set rr->err. mon_event_count() then discarded the
return value, which made failures harder to diagnose.

Set rr->err = -EINVAL before returning in both validation checks so
the error is visible to callers and can trigger WARN_ONCE() in the
PMU .read path.

Signed-off-by: Jonathan Perry <yonch@yonch.com>
---
 fs/resctrl/monitor.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 4076336fbba6..4d19c2ec823f 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -445,8 +445,10 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 
 	if (rr->d) {
 		/* Reading a single domain, must be on a CPU in that domain. */
-		if (!cpumask_test_cpu(cpu, &rr->d->hdr.cpu_mask))
+		if (!cpumask_test_cpu(cpu, &rr->d->hdr.cpu_mask)) {
+			rr->err = -EINVAL;
 			return -EINVAL;
+		}
 		if (rr->is_mbm_cntr)
 			rr->err = resctrl_arch_cntr_read(rr->r, rr->d, closid, rmid, cntr_id,
 							 rr->evtid, &tval);
@@ -462,8 +464,10 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 	}
 
 	/* Summing domains that share a cache, must be on a CPU for that cache. */
-	if (!cpumask_test_cpu(cpu, &rr->ci->shared_cpu_map))
+	if (!cpumask_test_cpu(cpu, &rr->ci->shared_cpu_map)) {
+		rr->err = -EINVAL;
 		return -EINVAL;
+	}
 
 	/*
 	 * Legacy files must report the sum of an event across all

