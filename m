Return-Path: <linux-kselftest+bounces-6735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B9188F0EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 22:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0796B22948
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 21:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F2B153812;
	Wed, 27 Mar 2024 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S4etqny1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7E215359C
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575093; cv=none; b=k9ql4TOg89Xk5MrcqrEqEXdipKgZ2N2Qw0ufGUp6LuMok1pGumhqcEAyC5rZJQ1duoeshgUL/jHZrubjAYGzfN87VED+MbqhyiC7pePzXrgslKA9T1GF84A7xi4hLRDL0yLLP7iv1BcsR6XhIznTTV8OXYTm1xTS0Cks02NzojQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575093; c=relaxed/simple;
	bh=NB7Q6As5LCuC5IWAkmAIMr9K7a1mke7uPnTHkJnbklI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k1M2Eo0iXg7unBnC2V0EGA2Act4uBHlxdwpyrnqOVgaF0gO8P1/IYR+svXt78iKsXFxxhj3KQPUnnQwwJ93uhqHDYlYd4VApKMPWq6jtpX1H8tb3NS1+KwLv4yDkr+8wH/CP3vGO38VLW07y6ou/hz22ERAZUIw2Y9vXXmyVbOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S4etqny1; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso379032276.0
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 14:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711575090; x=1712179890; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J7Eobqr0LFBQ4KWjEX1Ii2cj/j9a00dqkQu19UHFfuM=;
        b=S4etqny1LdnIfyfzpyk2YSUzXWSmvUC7xsEss2xNipHRbf/fhB/MCe/OMJWvfy+lIS
         /9QIldAWBdbcSLKYDwoADXt2CnhpwjcJ3h1WxbtY49Sbh97kIb4J9aeMHEJltDGhucQO
         ijKZcONCUZGSKvajoGqrYL4hh0Cw4lD+h0WsZet/KD514cF7eF/0CNl97pNB9TAkdRKT
         bJ9LKWeqwVThDGUEI9vuqUpgb+SWx9dJHMRdtcvswfNn7GiUwfzp4U/DyfseM7FYwkBw
         kzPdPKJ4U+NjoIfEOzZuOjcj7BoPzIPd7pC/aq43X/1lgxtXGGLqmVAfCvZfYD/5kFjR
         tCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575090; x=1712179890;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J7Eobqr0LFBQ4KWjEX1Ii2cj/j9a00dqkQu19UHFfuM=;
        b=wz5gaAELMr40G6AzFV7qI3dhWK9DZCe9ngzRKOaj0tsfIS5GV47qSBna71EGzKwL2x
         eWbs2xmH7rYqU8F8JZkRQ6JIpcGQ2Cuwh+5EDACDvX779iWYFNx5t9w0iMLD2VyBeDi9
         WncqsBc+SLYsU5PEMtWywl/V2Ri3i8bjNwu3kBWGhqhdJ1WLQIq0lXg/31AjkPej7wKS
         yXCvsls177ZnuTngjYThGroUFyKeUfVSpbU8zA55GeD/UHPlVJDdQbkPAvrYJxI3pQIu
         OKZxXFTR6i29kybSmUoWwOEDZwRLNhztYi+RM2XC+q9X3TuXVU/jG80YEoDiSH2DBFog
         HtiA==
X-Forwarded-Encrypted: i=1; AJvYcCW/GSrKY0+CNWAc7mU5m9M5atOqFOXcAMOkXf4Wkk6YamVkn5A0GVPOpkQfyWamiEUEUBd/XKtBPT5SsnP/wVlaS0f1ajCbrWRmtWtDT/AZ
X-Gm-Message-State: AOJu0YwEeXM/GP2AudkpMt4paTLxOzgsnz2LSK/LMmJrC+46DSUC9AwY
	IB1EIxlk3O9t14CtOfYmtrz3pydYx4qLUIkINvz/vYPjOnQ/JRg9f4+bl9Sjmk4kkljV0QZsF4K
	zJVUpZg==
X-Google-Smtp-Source: AGHT+IEtjKFm0aB/GkGE7TLyxEpzw6bgXLiicKkfzUR/Ki0/1kiBkWenomFbSpLy63KHaGIYhCLu0OSP/VuU
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:6df3:ef42:a58e:a6b1])
 (user=yuanchu job=sendgmr) by 2002:a05:6902:2311:b0:dbe:d0a9:2be8 with SMTP
 id do17-20020a056902231100b00dbed0a92be8mr116972ybb.0.1711575090119; Wed, 27
 Mar 2024 14:31:30 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:31:00 -0700
In-Reply-To: <20240327213108.2384666-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327213108.2384666-1-yuanchu@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327213108.2384666-2-yuanchu@google.com>
Subject: [RFC PATCH v3 1/8] mm: multi-gen LRU: ignore non-leaf pmd_young for force_scan=true
From: Yuanchu Xie <yuanchu@google.com>
To: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>
Cc: Wei Xu <weixugc@google.com>, David Rientjes <rientjes@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, Kairui Song <kasong@tencent.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yuanchu Xie <yuanchu@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When non-leaf pmd accessed bits are available, MGLRU page table walks
can clear the accessed bit and promptly ignore the accessed bit on the
pte because it's on a different node, so the walk does not update the
generation of said page. When the next scan comes around on the right
node, the non-leaf pmd accessed bit might remain cleared and the pte
accessed bits won't be checked. While this is sufficient for
reclaim-driven aging, where the goal is to select a reasonably cold
page, the access can be missed when aging proactively for measuring the
working set size of a node/memcg.

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
2.44.0.396.g6e790dbe36-goog


