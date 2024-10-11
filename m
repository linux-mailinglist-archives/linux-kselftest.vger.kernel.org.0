Return-Path: <linux-kselftest+bounces-19562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBA999ACB2
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 21:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3721F22E08
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 19:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ECE1D017E;
	Fri, 11 Oct 2024 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lkvb84yC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687BC1CFEC8;
	Fri, 11 Oct 2024 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675185; cv=none; b=uBlmKhcAwwXxQfW+RUEO5nBpYgqdZKS6xWwfXQbf+ROi3GghlhWVzeF/FbeYTxJ02s0VnsJ5W0a4eeN+LXBccPeVglyfFYW3p/aEpg0ReSWF9dxx3GddXkSmgs8BWLBLDh7tw0AfrG07NPlNmrqYt8xV5uKsXQnadoSKa+xMEsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675185; c=relaxed/simple;
	bh=ipzMIamMroJVib8WZKOfbImQgAiOGGAWnBtSO52PkAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FlB2CxYlkDUM7a2pBYvgCr6BQG3BhxSrZcnZ0z0wxJW8ZJFYX4UshxUJorG1/++QxfTgOBpIcdNDJPt81gyGgJVnHLWJ63stUZoZY8dClQmuU6+oa02ez6C5Q77HDIuYWcQS4ESmqQ91MM7RlqS6eyyBQx2q7PjWAnQqORQL4zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lkvb84yC; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e2772f7df9so22101187b3.2;
        Fri, 11 Oct 2024 12:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728675183; x=1729279983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cnRAe7a+r04KhLzqcnP2xNTdSejhtipAKUJmwQ7OKDY=;
        b=Lkvb84yCQrmR+LGqjd7QsMMOU8uKBIg2+RHKrKdZISU2ebUzRdWPvnl88+2aFf8Ejj
         fU4KXqUDEOCbOaaH7Zm6OmHxlx5OFoaXApxJkKlRPjKRoc0vszNFmCntAw+/lIhkHlKO
         EmQ3OmBL2PWplPTQEwkf4ahouOBO4lsZKM8kT2PrLWh/k8np7MkklRdFfEv6DdbjbWdI
         Jh4OBwu0Db3glYqKkdG9GlpPkF4X5WtlcLqlTE13LRAix0T8Rd3P97ZC1u05zu130QUw
         WRYYtDA5aAWO9rlnjLHFGjarhD6t9DMWx811P4gHvAUHJRiEIu+8dcR6RNVTbOGsHx5D
         OgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675183; x=1729279983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnRAe7a+r04KhLzqcnP2xNTdSejhtipAKUJmwQ7OKDY=;
        b=imGV7jMl3jilRsvKsbmnDS3qg9LEZFZKglRqxYQUdDJ2MIZSElL4oqmFCar3qyAEW9
         8JPYXz5Z2eR8+XUEOf02DJY6kPXE6W6gDVAImQhKGdj/0leGqiBWEr5+fbqzJ+Vo+DSv
         U8qhSVhJ70MNTe5yniMigKcrnmsYs9PTTQh8z7f0+32u2cXaiDSx20Kffoblby7XZFMj
         t5+U8ZdhGxjEhkYGg4gvuy6sg9PPZECY2wQgFu7FSSkQbCk3fKBhqYa3tI7YFzyh3nuO
         t37gtXkNdAS1NEOQ+ypVH/+mYliKchbKoY2d/r46Npe2ozUwj/Oqg64+9gnBmGD0iMob
         NIYw==
X-Forwarded-Encrypted: i=1; AJvYcCVFcIw9BkVwjPThNujwwAjFM4Kg6sc7aZt+69F/QeCGNQ9KAmpPRvGRWjTD+A2PINWL2zivru4spKP6VIeU5O0f@vger.kernel.org, AJvYcCVuto12Lp1+/J6bF/F59GMMPqIrRcuO8XfYbTc6uZJqG1G6raJXV32l9e8/lcU9zTJnpT/bczjnaxyZ4xAgv58Q@vger.kernel.org, AJvYcCWW5huPf0gzqgax/vzKPTYUeQfdlyj9B7DzXvzq43GwmXEprDB2zEAIDzkoUWLxIqEnvbZV6vtv@vger.kernel.org, AJvYcCXloGj2nUfjvGPAX+NTDe/lVDhCOroer2dDb6KrqpVQVgl063P7wjqykfd8QFKhICg29Tqt8Mcb6HY1sls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRuo9H5yK3U5wD1GrNgjYZLPDuRep+po78GnnwMEGNcv+gYHoV
	V3fUapa9/kIHIEoFPH/du0HqVQQWS2KMAl/aaL53JajZNn/00RqkiIPx7AQS
X-Google-Smtp-Source: AGHT+IHUPz0/Ui9FHEUoyCsEepGvC04qtfgoEazw4dYTo7Nv26hgnb+DNJN/rIvMcadhU+XpZWty1g==
X-Received: by 2002:a05:690c:56ca:b0:6e3:1487:8554 with SMTP id 00721157ae682-6e347c6b70emr26611997b3.37.1728675182822;
        Fri, 11 Oct 2024 12:33:02 -0700 (PDT)
Received: from dev-ubuntu-0.. (104-15-236-76.lightspeed.rlghnc.sbcglobal.net. [104.15.236.76])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-6e332c6f3b6sm7199127b3.115.2024.10.11.12.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:33:02 -0700 (PDT)
From: Tyrone Wu <wudevelops@gmail.com>
To: bpf@vger.kernel.org,
	wudevelops@gmail.com
Cc: pablo@netfilter.org,
	kadlec@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf v1 1/2] bpf: fix link info netfilter flags to populate defrag flag
Date: Fri, 11 Oct 2024 19:32:51 +0000
Message-ID: <20241011193252.178997-1-wudevelops@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch correctly populates the `bpf_link_info.netfilter.flags` field
when user passes the `BPF_F_NETFILTER_IP_DEFRAG` flag.

Fixes: 84601d6ee68a ("bpf: add bpf_link support for BPF_NETFILTER programs")
Signed-off-by: Tyrone Wu <wudevelops@gmail.com>
---
 net/netfilter/nf_bpf_link.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index 5257d5e7eb09..797fe8a9971e 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -150,11 +150,12 @@ static int bpf_nf_link_fill_link_info(const struct bpf_link *link,
 				      struct bpf_link_info *info)
 {
 	struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link, link);
+	const struct nf_defrag_hook *hook = nf_link->defrag_hook;
 
 	info->netfilter.pf = nf_link->hook_ops.pf;
 	info->netfilter.hooknum = nf_link->hook_ops.hooknum;
 	info->netfilter.priority = nf_link->hook_ops.priority;
-	info->netfilter.flags = 0;
+	info->netfilter.flags = hook ? BPF_F_NETFILTER_IP_DEFRAG : 0;
 
 	return 0;
 }
-- 
2.43.0


