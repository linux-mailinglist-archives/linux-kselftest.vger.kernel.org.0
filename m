Return-Path: <linux-kselftest+bounces-9455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 943078BB9BE
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 09:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53D01C212B6
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 07:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D331097B;
	Sat,  4 May 2024 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WKGbaUgh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904756FC7
	for <linux-kselftest@vger.kernel.org>; Sat,  4 May 2024 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714807849; cv=none; b=q3oEVmztv0+f8P60xNvIgsJ5oeUUrX/1EkS7uXSSZxsvJ/LC6mtGan/6XT1bdYgW9CmOX1rjq2ZTv4jD25RLWvCKxKxWnNYl9RNhIsoBnIBi4Ne3UwIrgv2n0GvYVM6q2QodCR94/SnQqEw7r5latyoujAWaDvZMy1fWxt06irA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714807849; c=relaxed/simple;
	bh=ZKj25IG7pniPh/0wD4wqB4Mjlk8/8o0tO/bn/N0I1og=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hhgsEL8G3bOXD+m41sJAmfWPRj38PsQE9ulD4ul0kF/jusIjBRG30TBcSoK0od3UuOgj3cYeZnIQbPcRA1D8VvQx5+dzAEbjVQVrVzEZ9DCi1LpSdWEoHh5eM7gSwVbq5Wdhqj2FKV+tayn6ByMoI49a4rwftRMLv01szk6uzFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WKGbaUgh; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf618042daso900466276.0
        for <linux-kselftest@vger.kernel.org>; Sat, 04 May 2024 00:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714807846; x=1715412646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/qRNmge9VPkattIC8VKnofvZP4QSD6CRqtGoSzsf/P0=;
        b=WKGbaUghCePr+7vm8VaXl/hEEFNeDzPpg5jHtvxl4c+dJeKXQytTjo+y7mGJOTAq8v
         kJbHZSat6NpBXYtCJ+6eL79OFyjP7ZLDsMW86hA2SjBtmFov7PytjtvlIDg1wkBNUrtd
         +121aYx6ljjiDUDR6PT/Esn81Nee6Y7Ji6gy06YitZiYLrriLDlijTWMj//0WXK+vALq
         g0nchDQuP3B7+hcOFUe+dNl+xjWnPhvykkRqxoqhuES+qYysp18W6RaSoj/p8ZP6ceoH
         acw39kIHwYUqnwYNVlyX2xB+mvMyDMR/WptVabehO+JHxsp73O7/icXoDFPql5YK2GJk
         M4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714807846; x=1715412646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/qRNmge9VPkattIC8VKnofvZP4QSD6CRqtGoSzsf/P0=;
        b=LRfST+qn/6a8cG2SKQF6s6/udZMJG8qebx+eolpPc6zkleorjINe7vmF09ys6SPwPF
         OW94ey9UrjtXK5zoynaXi2YWlg+BB4FW5dcrYSXpjGzMv83pUSBJ3UAVpBuL2avYSFVr
         eNFgwXQjOcgIoiaTJwr4eyFP4VoaVgc6AfllEw4Te9gKnF3rWhf83JynqLr2Jk+mTCz8
         MZSqjyValMSUSqB0v+/gmtp3n5wb6M0HYclOSrkIaK294GDifUHgHbg76PhtxGwf51FT
         dT5sMl9U68tEjZnRITT1x1K9HEwBJoHcKFUP2z4HOrMwK4ZEkeHRe97zNoP0m5Q0dxOM
         wtYA==
X-Forwarded-Encrypted: i=1; AJvYcCUYNgka8JqC/2dZYKJnL7ptks0UNjpSQ2AldmTWpAONA+uCcfnfnjiMk3vs/ZLIxNfrITn/7ZAdkHVNNFGVOl6bpXotRu9CgKONnYAztLQX
X-Gm-Message-State: AOJu0YzIEmCceff74xRzX3XXyJY4BCc5EjTsP4Dnpdi+KPR7/3MJYJww
	2qd45eyNs5kUEqAC/U5UodnBrDQXFrsxL7t6th2LKfmgF+REt4NtkrEStwRIsip//ZS8nuYDN6w
	lqFkzbQ==
X-Google-Smtp-Source: AGHT+IE9krkIkSbJnvwj2NL+PSHxSR2wSCv1KndjNbNT83C6ldeF/Rb3CC7Y0V2+f15W7Gb9F6OShS6x5yDQ
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:da8f:bd07:9977:eb21])
 (user=yuanchu job=sendgmr) by 2002:a05:6902:726:b0:dd9:2a64:e98a with SMTP id
 l6-20020a056902072600b00dd92a64e98amr544178ybt.9.1714807846444; Sat, 04 May
 2024 00:30:46 -0700 (PDT)
Date: Sat,  4 May 2024 00:30:05 -0700
In-Reply-To: <20240504073011.4000534-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240504073011.4000534-1-yuanchu@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240504073011.4000534-2-yuanchu@google.com>
Subject: [PATCH v1 1/7] mm: multi-gen LRU: ignore non-leaf pmd_young for force_scan=true
From: Yuanchu Xie <yuanchu@google.com>
To: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>
Cc: Kalesh Singh <kaleshsingh@google.com>, Wei Xu <weixugc@google.com>, 
	David Rientjes <rientjes@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, 
	Kairui Song <kasong@tencent.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yuanchu Xie <yuanchu@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When non-leaf pmd accessed bits are available, MGLRU page table walks
can clear the non-leaf pmd accessed bit and ignore the accessed bit on
the pte if it's on a different node, skipping a generation update as
well. If another scan occurrs on the same node as said skipped pte.
the non-leaf pmd accessed bit might remain cleared and the pte accessed
bits won't be checked. While this is sufficient for reclaim-driven
aging, where the goal is to select a reasonably cold page, the access
can be missed when aging proactively for workingset estimation of a of a
node/memcg.

In more detail, get_pfn_folio returns NULL if the folio's nid != node
under scanning, so the page table walk skips processing of said pte. Now
the pmd_young flag on this pmd is cleared, and if none of the pte's are
accessed before another scan occurrs on the folio's node, the pmd_young
check fails and the pte accessed bit is skipped.

Since force_scan disables various other optimizations, we check
force_scan to ignore the non-leaf pmd accessed bit.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4f9c854ce6cc..1a7c7d537db6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3522,7 +3522,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 
 		walk->mm_stats[MM_NONLEAF_TOTAL]++;
 
-		if (should_clear_pmd_young()) {
+		if (!walk->force_scan && should_clear_pmd_young()) {
 			if (!pmd_young(val))
 				continue;
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


