Return-Path: <linux-kselftest+bounces-16181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2554C95D7A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 22:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B31D5B210BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 20:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24181A0B09;
	Fri, 23 Aug 2024 20:13:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBE2193406;
	Fri, 23 Aug 2024 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444000; cv=none; b=Fd3f7e9EmNo8TRxA2gSLOaEGtJAsC9m5U6OUeln44M22Ap4LLKPrL+vVhnxqdcuE+aVBhpusn6ueLAVEI7hMskISLc45vVoheClMRpXS0GuIPY5bsRPWgN2B4l4NjYNxcJB2uA59/fVcAjcQfKSLbwa/y1ow5tBnTrkSRTWkvro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444000; c=relaxed/simple;
	bh=RCs8061MAHw1Hf3jXWEZ6peQlwmgcoa6k+irlbDKSno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=owNlT4W4b8wD2aZF0N2v4tbs+dZ/GBaCLAM598wTsVX42Y+bs4+WQ6VWKSAD5FU2EXFYgMIeKdUjqZrpY3xhruNfWhSns9cmBLYHEWT4dzPUxZPYkxJC0Otq5MhloUibare5KAq/lzDmoXzomOutiTxyQs87iFxFMR5/tfuBysE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e117059666eso2383315276.3;
        Fri, 23 Aug 2024 13:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724443998; x=1725048798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HRLvSVYoUA3QBwpU3cDmJZgLCkpfSlO1Oln5B6eEg8=;
        b=YM+OjLf+Cm9RNkyZgyAfMoreDNyuLX7/YTYZJLAh/42vWXh3jSIOQRwnuDjxDIr7Hh
         Dbcfhbf9TcZR+AnPQ6jBPjvHfurBuea4oS9l0vpcnbAHYoBJRhxkmfSF8AzL/KGP09Cl
         Tnj5Tn/Qwj8iFW/MM3b0P/m09Xn5cF5wAOqaUmefcDeI68LoPTeUz5SyQ80tg/0d7e5K
         BLwppqjSNzVNQzrWlx0eXmMUsV8vzEYHeLoIH30ZkEGa5PCrT5U2ywv2lUUi+7tQM2A8
         OBSTI/xCILnloPLloO85Ez1EIuheQdzfRvwmHJFabKOXdOUVmFJOOlnuf6FnlP7LdI1R
         X24A==
X-Forwarded-Encrypted: i=1; AJvYcCWLC6S32R4zYkwzhQekmd8M+Tu0FpZZQXDU649WxN0iKiNTj/CyCHzZqqRlz+bAiY5a7IRegV/2@vger.kernel.org, AJvYcCWppu7gmtFSNJCDg1Hcyjo/PSKCaHhAszX5oztUtWe/YUkgisCXj+2n3KbEJzfwajzUC9oLfymwSgzTEq1t@vger.kernel.org, AJvYcCXm8bOSKxU18v6xmXAZ5mnqL+4hX43MY8b1Y9aMojoKAvQC2aAQdX97+AlNppK4A0MjTBItpj36EgmvPhydUhNP@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ92RxbKGbZYcnzdhYZLe7De7ERucZIz3mxvR+jNLw7XwqeIOZ
	zbJYhHO85yyLWTDVzUca7st9SWwDd/ghr1K5I8Ya3hcjX96SNTjZ
X-Google-Smtp-Source: AGHT+IECOE6SN1Kqu7ax53usnoRUpUNPDXenmgckuF/+9zJtSPaJ7fp0Cm2UMgwaXQvFr9ULitx0QA==
X-Received: by 2002:a05:6902:1b06:b0:e11:7578:ffbb with SMTP id 3f1490d57ef6-e17a864e010mr3309054276.36.1724443998254;
        Fri, 23 Aug 2024 13:13:18 -0700 (PDT)
Received: from localhost (fwdproxy-frc-004.fbsv.net. [2a03:2880:21ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e4638e6sm780134276.20.2024.08.23.13.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 13:13:17 -0700 (PDT)
From: Joshua@web.codeaurora.org, Hahn@web.codeaurora.org,
	joshua.hahn6@gmail.com
To: tj@kernel.org
Cc: lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] Exposing nice CPU usage to userspace
Date: Fri, 23 Aug 2024 13:05:16 -0700
Message-ID: <20240823201317.156379-1-joshua.hahn6@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hahn <joshua.hahn6@gmail.com>

Niced CPU usage is a metric reported in host-level /proc/stat, but is
not reported in cgroup-level statistics in cpu.stat. However, when a
host contains multiple tasks across different workloads, it becomes
difficult to gauage how much of the task is being spent on niced
processes based on /proc/stat alone, since host-level metrics do not
provide this cgroup-level granularity.

Exposing this metric will allow load balancers to correctly probe the
niced CPU metric for each workload, and make more informed decisions
when directing higher priority tasks.

Joshua Hahn (2):
  Tracking cgroup-level niced CPU time
  Selftests for niced CPU statistics

 include/linux/cgroup-defs.h               |  1 +
 kernel/cgroup/rstat.c                     | 16 ++++-
 tools/testing/selftests/cgroup/test_cpu.c | 72 +++++++++++++++++++++++
 3 files changed, 86 insertions(+), 3 deletions(-)

-- 
2.43.5


