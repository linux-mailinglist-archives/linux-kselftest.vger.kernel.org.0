Return-Path: <linux-kselftest+bounces-6745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D7688F228
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 23:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27EFC1C282DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 22:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C069153BE2;
	Wed, 27 Mar 2024 22:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgsOZ+JQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C152D2EB04;
	Wed, 27 Mar 2024 22:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711580090; cv=none; b=BloZVl3iC5pDrj16S+g43NmUasnD8RLtNovTo3YVt/GODSI9b8Cvh6tPRu+L1stN3NBnbtJeHOcH/J/fFyTIszLzqwGXbRTdyQr83q/P6TVj0iemiBodXyRnaPDatSezDRZDR8ZVAEtrIuzw9Dyu6E5230n7k5Rx9YYWqeKPN8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711580090; c=relaxed/simple;
	bh=B4kQ7Md5GvHsR2L+XgbgKogJenUHgF+GDFDTZ3omF3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ORPFDO2pm2QK8dSlaCnZhWu/IZGMUCqdQECTh/G9Yx5kXQGivFvrr4/7ITYk2UmenMD1ZuGlCI1Lcn2qwt0LLAuAE/p1fI6Eb3A3rFcfW+9shCZfRMWNTgg94d2IIVx6jbKQxSwYxMsogk8InNIYZH8AU7NCN54AT8oiuBDHn9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgsOZ+JQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34100f4f9a2so162724f8f.2;
        Wed, 27 Mar 2024 15:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711580087; x=1712184887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G15/cZOUwJ4wAwK3pv4/rQlxMz/GUR4FC5RGf/w3iUA=;
        b=BgsOZ+JQH2nJUYy46m09uxxwJ2bqyPAio0LRk7LBu6Y6JCEIXzj1yw4g0ao+ZpoRPG
         BQMW9INaHpPeC6VKysMxpxksQim8xwTRGJZJASfxbCWOmoxUo1K/vuSPcVfXD955G5kF
         qy9S2Jn9NWdtFZ+urA2jRG1SXvm6MwOhmUR44DJpfgJwxPOsMrZQeTxga5+Z7SXIcetz
         XcZ8H3Dh4TefXYBbEOcvszOQ4G9PVG9FxrI2T2+CHfEv52ozE8IqumsXrjxHHHyQIpWj
         JouBMzvg7owUNN5vwlcPlbA8wQMzzkrdwKOtgfIgJzenw5rjLE6Q7kH83Rr4vgOD1yar
         PQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711580087; x=1712184887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G15/cZOUwJ4wAwK3pv4/rQlxMz/GUR4FC5RGf/w3iUA=;
        b=ioMugbPVZ7NEMzGG0Z+I5fcxi1XH4RRGZZ5eDANgQhi6DhYlVbU0x2bFQ43XyQzIgY
         5jT2z72LJnt0ICok9GLe6IHaRrjNLmC3OzVM4rWNZHvxxDLNTiA6bwtjjOExSMt9KPM1
         tVUhWaaey+7P02IhvPm74gUNLG+SkVPhR6L4OQzL0ikbTBWcWvbL5Evabl+t18I87YP/
         GzsF9Flmu1tvKPy7S0qkLASCMdvP8CFsSq+MZX9krtAG3afTqsZzN0SGwqnq68IyAev0
         HOHk6ueUDBMJIyXjLGLGWm1sfg+ql681YbInpnYun/X154vRedvIyUFTAKBUKA+YhAsL
         MLdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr3UFDKITQ+sQVpwylQiD46pls6J28lERwOsDcdTDM0243xS09EWm4rPtkyBlbPAZJZ8yxIxmkz0Uz5XhA0YwrkbHICclURfZXLKc+kMX0+tGiMKx9llLKfMPAvzkR6er5iYw3NXxmB4YGPYI1iuMX+7cphHzbghUBjZbL/pX0HKp2+yjLCci0rPbtGavp0Cxrp+8A62ugPKoplg==
X-Gm-Message-State: AOJu0YzbQ5U8ISo92LYsMTpyFjpebbKCCL6zYHhlZcoCMqtypwvpPoNH
	QcBFRAJ+GmtlK1ZAvLb4w404cANlfFaEmQVbm9Y4u7Y966V4WzM6
X-Google-Smtp-Source: AGHT+IFiZCk0HkqbCAQsllCUbaI0r3bBk8XB4pcoHzbYn3a/kHovV8RAYQ6NsVr5EfUqdqm/zagQUA==
X-Received: by 2002:a5d:400e:0:b0:33e:69a8:fe85 with SMTP id n14-20020a5d400e000000b0033e69a8fe85mr858630wrp.37.1711580086806;
        Wed, 27 Mar 2024 15:54:46 -0700 (PDT)
Received: from rorona-tty.. ([154.121.114.3])
        by smtp.googlemail.com with ESMTPSA id cc7-20020a5d5c07000000b0033e75e5f280sm152348wrb.113.2024.03.27.15.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 15:54:46 -0700 (PDT)
From: Djalal Harouni <tixxdz@gmail.com>
To: tixxdz@gmail.com
Cc: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH bpf-next 0/3] bpf: freeze a task cgroup from bpf
Date: Wed, 27 Mar 2024 23:53:22 +0100
Message-Id: <20240327225334.58474-1-tixxdz@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327-ccb56fc7a6e80136db80876c@djalal>
References: <20240327-ccb56fc7a6e80136db80876c@djalal>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support to freeze the task cgroup hierarchy
that is on a default cgroup v2 without going through kernfs interface.

For some cases we want to freeze the cgroup of a task based on some
signals, doing so from bpf is better than user space which could be
too late.

Planned users of this feature are: tetragon and systemd when freezing
a cgroup hierarchy that could be a K8s pod, container, system service
or a user session.

Patch 1: cgroup: add cgroup_freeze_no_kn() to freeze a cgroup from bpf
Patch 2: bpf: add bpf_task_freeze_cgroup() to freeze the cgroup of a task
Patch 3: selftests/bpf: add selftest for bpf_task_freeze_cgroup

 include/linux/cgroup.h                                      |   2 ++
 kernel/bpf/helpers.c                                        |  31 ++++
 kernel/cgroup/cgroup.c                                      |  67 ++++++++
 tools/testing/selftests/bpf/prog_tests/task_freeze_cgroup.c | 165 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_task_freeze_cgroup.c | 110 ++++++++++++++
 5 files changed, 375 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_freeze_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_freeze_cgroup.c

-- 
2.34.1


