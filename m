Return-Path: <linux-kselftest+bounces-18223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D00C897ED13
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 16:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89CDF2833AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 14:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B4B19FA89;
	Mon, 23 Sep 2024 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYaLs38j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAF719F473;
	Mon, 23 Sep 2024 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101210; cv=none; b=GkzRwP8s47scM8W8ev47WfTB9XAaxgtO3Xb8rodTsHW5OVGdZAeOPRqNtF8zMjOKe9MpK+7kjZ45yMK3f7i5DM8/315aco4VB1yBqYDSRMT2RnPyMH3Nw3FqAExfwaWd7J7yDG61HZ32SRkXPaoV1eEc6MUhdsmXhPbrzWdE3+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101210; c=relaxed/simple;
	bh=Inzy0DSIliUiUT38rZJgW6rXrcv0CF52ifiuwGOLE7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I4EJFegadzf/QkGAFFVUVaotNZTqt9lK3/iZvgKIMlnOFLsf4WC78oLDN202zo8doRIidPxWdjzxSi+G4u2W0AbwyQzgTz356wafr4PNYVjEnsG31T3WGluj+xqkQiUEQ8vKukuRahe2jOhe16scT98lYAnFubNONGAAqEFNq4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYaLs38j; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso3643037276.1;
        Mon, 23 Sep 2024 07:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727101208; x=1727706008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DuKStVLsBE0ny3FVufAe1SWiRjcCSbjVlrZiWLt+IA8=;
        b=EYaLs38jvq4h7/EypozWtcS5icftNs2Htotmu62Rq4K7TEhyCpTVZY36BcO4U6rPR5
         ZLP/8hPs55sL+MOzCcKy5ejo/U4vC5upsBHwaoQI/pkTVfJ01HijzeTyv98BrFpWj2Me
         NcgWUo0cFcY3VBQHlsHgevtcdpnHXKiDPWBTIrYNlNRPKyXIvhBlF9RcQ0+GterYASD2
         jLLNYfxIw8Akf6gP2C262EkabLP1VLouWeim65Ox8AZn8G9YCvIo3ic/HKfp6DyGTt5W
         K33LBmOWkhcr5vWSiGoLKGv31D9OKf9ceuufFwxBJktZk24DtQcSGPQD2UerHW90mOC9
         6uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727101208; x=1727706008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DuKStVLsBE0ny3FVufAe1SWiRjcCSbjVlrZiWLt+IA8=;
        b=VO8vk/ePIi6rRL82WRoVYTPayHO6LSwWLVaKORmrBvb9dZT4+BeuoIqcrPiy/mz0qe
         +Ics50OcgsMQ/hO2Ssp6g05DQn3HxOK12ertzcHuVmsbtsx+QDQArJcp5R6qUrNLOdQm
         rsxPg/SB72OMShlN4jk5iKS7m0dmFVEwV9G9DI4Ym4QrbZBMADRLecf4VaqYVW3gUmo5
         D/w50S1Uba+IlUY62dfZwA2zUIeDX6ZvVh6ZSvfp2XqLBgYOk4yl1aMW2QAnR5LfwJyQ
         6lAgmNg5wemxIDte71DNHnac/FkNrUE3bDWsx+m87q72FupNsKKLRkhgy9LrU/zzYH7z
         1VSA==
X-Forwarded-Encrypted: i=1; AJvYcCU5fQjvzwFdWwqKVXt9R4Kb+kliFkuRCEtdXsumWV7dhPwAvWuMSUPyel+g91zR9TtP8fFwgntEUEM2tCEyjumE@vger.kernel.org, AJvYcCUENPxgn4y+vBJNS1iWfyMlFd39UrtEYUpAS4W/ADVQ1aAsRc0Vsl2vAe8Ai8j8jsDmiJ/hqlVtrhIsT4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZcDDDAGa6h24M22KKhI63pIy/vdHvOg56sJoKSAAjZ497GJf2
	wgqBai/u3axhwqM9rAoi4mlWONZCx0aQTc9xAze2oV74Dz8x7Ad7RG8gvqUJ
X-Google-Smtp-Source: AGHT+IFOQylqp35ZraFiJBq+od7qrkn87cS5UenkAZqmyTTFY+gPzUcrt2qNAvexHiDdVpwS+JPofw==
X-Received: by 2002:a05:6902:2208:b0:e20:2ab4:9d5e with SMTP id 3f1490d57ef6-e2252fbb7d5mr8824914276.41.1727101207890;
        Mon, 23 Sep 2024 07:20:07 -0700 (PDT)
Received: from localhost (fwdproxy-frc-005.fbsv.net. [2a03:2880:21ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1dc1108b49sm3634220276.1.2024.09.23.07.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 07:20:07 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: tj@kernel.org
Cc: cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lizefan.x@bytedance.com,
	mkoutny@suse.com,
	shuah@kernel.org
Subject: [PATCH v3 0/2] Exposing nice CPU usage to userspace 
Date: Mon, 23 Sep 2024 07:20:04 -0700
Message-ID: <20240923142006.3592304-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hahn <joshua.hahn6@gmail.com>

v2 -> v3: Signed-off-by & renamed subject for clarity.
v1 -> v2: Edited commit messages for clarity.

Niced CPU usage is a metric reported in host-level /prot/stat, but is
not reported in cgroup-level statistics in cpu.stat. However, when a
host contains multiple tasks across different workloads, it becomes
difficult to gauge how much of the task is being spent on niced
processes based on /proc/stat alone, since host-level metrics do not
provide this cgroup-level granularity.

Exposing this metric will allow users to accurately probe the niced CPU
metric for each workload, and make more informed decisions when
directing higher priority tasks.

Joshua Hahn (2):
  Tracking cgroup-level niced CPU time
  Selftests for niced CPU statistics

 include/linux/cgroup-defs.h               |  1 +
 kernel/cgroup/rstat.c                     | 16 ++++-
 tools/testing/selftests/cgroup/test_cpu.c | 72 +++++++++++++++++++++++
 3 files changed, 86 insertions(+), 3 deletions(-)

-- 
2.43.5


