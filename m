Return-Path: <linux-kselftest+bounces-18921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C18C98E2C9
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 20:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC7B1C22057
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 18:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3531F1D0E1D;
	Wed,  2 Oct 2024 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpwWp1t9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48C812C54D;
	Wed,  2 Oct 2024 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727894841; cv=none; b=C9bNGAMszXxussgwuFtJaK/Hqnbac3NHWhwPtMT7cfRL9pjY4rA+i3I8eyZqr0k1PF4ihgkkg54b5t9Ok/uoNPouYrS4U0Z/PF43RwImukVfEbzMRDH34fKWQlnP+jBLcwQrgZfE4QjfOtwf+JpdD5TH1IuTKnjkbavwntbZxBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727894841; c=relaxed/simple;
	bh=tfIMDX0u4cYCZdQYth1eJirpG6yU87tzFoFlqpgj7qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ITfGjLjcpMFqK0YRMOnQ5HtP9ghgkJXOHtPZQvgmrdtNPUrcFG+y0Ox3m1lnQ9WuNpghhhKheRA0yhSZUrCVg7LrTfsu7wtuUf1iCVTLZ3+/LkddqpVfD/qe4NWMJNZ7TXoX77O19l7KkdL3hwGLkK5yiERP0+JBGDtxiJrOn/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpwWp1t9; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6d9f65f9e3eso1243487b3.3;
        Wed, 02 Oct 2024 11:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727894838; x=1728499638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/StA9unySiW//+ME4f4Kjao//vEGfUNtBxwsQErVdME=;
        b=mpwWp1t9chF0PIxK2MLyt5YB+sQhnsQCQD1AewAOnMwjzluFIN+zkOmuM1C6qvs5kU
         MMgR9T2yDVCSsHvNt5SVdr/tDBV6syK+mTjTqpfjVFxYI72qUwfmuKmL3VKy0u3VvFJD
         2NyfrPRrQEvZB2whSKYQzgrDec0cEy7r9P29ngDlMc2otAgNaWLq5yoqZjBc0gY48cAR
         mvuXTMUMxXd5P+ylbp+jL0B0v/Ej3jsbZQgkRKRirlFKsoV/+y9j057XMV68lkk1jOa7
         8R+43exB5DC4SbBkXW/Woo2RhU2X+wHUVTD5it3T8mj/jNy2DIfC/KL6l45N2vhlcVFz
         WOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727894838; x=1728499638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/StA9unySiW//+ME4f4Kjao//vEGfUNtBxwsQErVdME=;
        b=Q/embwmN28Om11HGX6p1L77rDhfg2paG8G+ZQhgWMNj1B+xU6BfiWhHcGq5x4HHg6p
         7/4GLlvKMFngMyKLEnyXzhygciSMPIgWcSv/iOKq3UScKdurZO4HNZrMJmPMr5FqtrOq
         NnNA3euPBaHtcRBvVjhcyArNWzwlE7uipOGgareiC6ngMf5jetCVYPhYrZkjwBi2zsnm
         0z9Z6TjmAkaoXA8SH8GEwMQT7yu2VirbqeajsRGoyS3k5FHXKqvi1EuefkYWsg+426Hs
         8PmR8Y7CCIwyGzew/dwPEPzVlHQGSRszW19ejc8ia/LmPTypQdOpabSsMmHrG00ygZWH
         qXMA==
X-Forwarded-Encrypted: i=1; AJvYcCXb3mf31LnOyoeOKmawopF0WI4DGqUWFw5u9agDLmVYcw4HwAQgmy1BmZUVLPB/OxAx4b0W51W76Y3FaGzA/Ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoMkcBw+7aIoue5iTu+/vsETfJ2b+a3FAPuR9lt7udDNqN9PYn
	hGeuZcbPjU2l30b5LozjlLowvibkRRrOF0Iuwf3Kw4RO2KFvoZwcSWD6JycR
X-Google-Smtp-Source: AGHT+IHWcvJ1my70Gg5nQIm2odAeJjo+LStFnChslLnRYgBYQZDUEtWODoJsXEe0e0IcDJUTPCYv8A==
X-Received: by 2002:a05:690c:6282:b0:699:7b60:d349 with SMTP id 00721157ae682-6e2a2caf87emr44312437b3.11.1727894838500;
        Wed, 02 Oct 2024 11:47:18 -0700 (PDT)
Received: from localhost (fwdproxy-frc-017.fbsv.net. [2a03:2880:21ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2453698f0sm25638867b3.89.2024.10.02.11.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 11:47:18 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: tj@kernel.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.org,
	linux-kselftest@vger.kernel.org,
	lizefan.x@bytedance.com,
	shuah@kernel.org
Subject: [PATCH v4 0/2] Exposing nice CPU usage to userspace
Date: Wed,  2 Oct 2024 11:47:15 -0700
Message-ID: <20241002184717.153302-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v4
	- Removed unnecessary forking from selftest.
	- Style changes in rstat.c (fallthrough & indents)
	- Fixed a selftest bug that raised false negatives, caused by
		cputime_adjust sometimes adjusting utime below ntime.
	- Reworded cover letter for clarity & motivation
Changes in v3
	- Signed-off-by & renamed subject for clarity.
Changes in v2
	- Edited commit messages for clarity.

Niced CPU usage is a metric reported in host-level /proc/stat, but is
not currently reported in cgroup-level statistics. Thus, even if one
can observe that a fracion of the host's CPU time is spent on (non-)nice
tasks, the distribution of the CPU usage across cgroups is not readily
available to the user.

This patch introduces cgroup-level niced CPU utilization to cpu.stat.
Exposing this metric will allow users to accurately probe the niced CPU
metric for each workload, and make more informed decisions when
directing higher priority tasks. For instance, service routers will be
able to probe cgroups in the host to determine CPU time spent on niced
processes in each cgroup, and direct more traffic to cgroups with lower
non-nice CPU utilization.

Signed-off-by Joshua Hahn <joshua.hahnjy@gmail.com>

Joshua Hahn (2):
  Tracking cgroup-level niced CPU time
  Selftests for niced CPU statistics

 include/linux/cgroup-defs.h               |  1 +
 kernel/cgroup/rstat.c                     | 19 ++++--
 tools/testing/selftests/cgroup/test_cpu.c | 75 +++++++++++++++++++++++
 3 files changed, 90 insertions(+), 5 deletions(-)
-- 
2.43.5


