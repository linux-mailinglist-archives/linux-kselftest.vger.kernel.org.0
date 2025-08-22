Return-Path: <linux-kselftest+bounces-39617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E00B30ADA
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 03:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D9E68599C
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 01:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274581A2C0B;
	Fri, 22 Aug 2025 01:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cdRzYUma"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6583F1494C3
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 01:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755826727; cv=none; b=Z+JIMC7QMZ+rsyCT6dLu4DBfAzSbQkEnObANkqPLCg3ns7dU/WGQrKOOjeYGqUeP/t+2ZMScSYV828bNavx8hDoUWxyw7GKYbCDUYS2++aYdc04k2O/+Ug2/wS5N6TGn+ZM/HJljW9AW83ak8b8Xr+WofDfx/FGwMNMjLJeWWr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755826727; c=relaxed/simple;
	bh=A49EhjtovdcOMZSxAFwCEK81dRUbjpo5bkUejNjPW/A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OjAVhBZ6UaWtaDxZ6QaC8xpJZL357f+KdNaaqDGtFKpJvgReacnoeXGZvuPAtfWAlImvoquyB6kpIGv6lm0bBQQdy0wbAEwhE5R2hadYCMp7r0GvRmrgB3r1e7xacU4tyi6p1zUbd99bpmzN9DLNmuWVLh4ivUv+3Y0KAPcAsfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cdRzYUma; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2460e91cf43so9594675ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 18:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755826724; x=1756431524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W15LouMyj4vdHymi7TVZHUFLWipG+7CdV/EGR2TsyJU=;
        b=cdRzYUmaqBGJw4rZ4dbLqHY3W7asmM9a/Z7URuN7nkui01Yjw3uk5CwC3aXcguCuWl
         Gj6WTXL9PgSq9bk9N7IJsVtrUlhxUl7wLOW1ruPR4rHeUPUKckJwWcvE04Agy7S0dGPL
         pdgzo5iQ0UbsZT7FHCDKcxFek1vRp5mZcn8/TOsED8z31oa73DMp31Raii+dI++mVZ+6
         X4GyICSeRsJu9+lWfMY4uprFNJib8LjZJ+Sisr3Wo0RMfL5Hmgaau7/l1xNs5q60fjJh
         CK2g3cgpT6ebR+Px9pPOAQARC7U77oel/g4wRHD1d8Ong/d8Vv2QbUOxb3ITs8Go1LPB
         ILUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755826724; x=1756431524;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W15LouMyj4vdHymi7TVZHUFLWipG+7CdV/EGR2TsyJU=;
        b=LWSuUKt714t17biYgIF8sV1UTNP45VzrCF7cGkJjRSKp8wr+2DXuASeGqK1CdYBtli
         RcoCMPRhuZpxREVu6hKB2jr7w2Esw9i7bsYVtZhg1OVmv/t0Uzo6Zh8KRE9W+D+zpGxv
         n2JpG7I8MNeL7eFigl++7SLtnS1uGq73vLsgHg2rSBfSmlOPe/5CqQxbcLJrjH8qoJtf
         P5+HzYk6IrekfESnM8/zCfkv18k/tvY58Xob/1x+GISuOAV5QTa1URG7sOy6/LE+EIAJ
         hwK6Xcl0FmXtNw1pBiRtvT+0Q2rIeuDOYqbPGuTIRjS/cgZW+PDbDbWdWG8mYtjJZwyO
         lAXg==
X-Forwarded-Encrypted: i=1; AJvYcCVse5ftuQ0SGfEcsMZRNegG1WK7L2ReFk0Rvbz8oqAjogXIdhKEp7W2Y6AYWTfmLDSOdAj+TbAj6zaPDc9mqpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4L1kpme/BGmJ2pj7qs9MIIDz1f4WGRv9sNQpfsOfjdqA3yYA9
	bt+O0uNLXBD1YQZFScdB6w8//EnGGAGNkEhRchVCx2/eeS/54m+sfkpOAsL+S68XPy8RI2R8mSQ
	TvoUBzabSjw==
X-Google-Smtp-Source: AGHT+IHopvgy+NT1vyxHR0lL/IQJOLtwOt5TkxAJYqqhMkX+S6CNkIYHIk02Ok4PnPzh/BGnt+DyE+ktjcJP
X-Received: from plbme14.prod.google.com ([2002:a17:902:fc4e:b0:240:1953:fa3])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:46c6:b0:246:1c6a:7025
 with SMTP id d9443c01a7336-2462edec143mr21257215ad.12.1755826724580; Thu, 21
 Aug 2025 18:38:44 -0700 (PDT)
Date: Thu, 21 Aug 2025 18:37:51 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822013749.3268080-6-ynaffit@google.com>
Subject: [PATCH v4 0/2] cgroup: Track time in cgroup v2 freezer
From: Tiffany Yang <ynaffit@google.com>
To: linux-kernel@vger.kernel.org
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, 
	kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

The cgroup v2 freezer controller is useful for freezing background
applications so they don't contend with foreground tasks. However, this
may disrupt any internal monitoring that the application is performing,
as it may not be aware that it was frozen.

To illustrate, an application might implement a watchdog thread to
monitor a high-priority task by periodically checking its state to
ensure progress. The challenge is that the task only advances when the
application is running, but watchdog timers are set relative to system
time, not app time. If the app is frozen and misses the expected
deadline, the watchdog, unaware of this pause, may kill a healthy
process.

This series tracks the time that each cgroup spends "freezing" and
exposes it via cgroup.stat.local. Include several basic selftests to
demonstrate the expected behavior of this interface, including that:
  1. Freeze time will increase while a cgroup is freezing, regardless of
     whether it is frozen or not.
  2. Each cgroup's freeze time is independent from the other cgroups in
     its hierarchy.

Thanks,
Tiffany

Signed-off-by: Tiffany Yang <ynaffit@google.com>
---
v3: https://lore.kernel.org/all/20250805032940.3587891-4-ynaffit@google.com=
/
v2: https://lore.kernel.org/lkml/20250714050008.2167786-2-ynaffit@google.co=
m/
v1: https://lore.kernel.org/lkml/20250603224304.3198729-3-ynaffit@google.co=
m/

Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Koutn=C3=BD <mkoutny@suse.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Chen Ridong <chenridong@huawei.com>
Signed-off-by: Tiffany Yang <ynaffit@google.com>

Tiffany Yang (2):
  cgroup: cgroup.stat.local time accounting
  cgroup: selftests: Add tests for freezer time

 Documentation/admin-guide/cgroup-v2.rst       |  18 +
 include/linux/cgroup-defs.h                   |  17 +
 kernel/cgroup/cgroup.c                        |  28 +
 kernel/cgroup/freezer.c                       |  16 +-
 tools/testing/selftests/cgroup/test_freezer.c | 663 ++++++++++++++++++
 5 files changed, 738 insertions(+), 4 deletions(-)

--=20
2.51.0.rc2.233.g662b1ed5c5-goog


