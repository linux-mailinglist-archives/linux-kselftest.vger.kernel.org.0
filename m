Return-Path: <linux-kselftest+bounces-47469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C693CCB7BF0
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 04:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31D1A30463A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 03:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193C52C3768;
	Fri, 12 Dec 2025 03:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="IfNTW9fa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DC92C21E5;
	Fri, 12 Dec 2025 03:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509731; cv=none; b=PhyT60vb8S4lJiX4F117ix6BrdRekGxyFNhxrb2sZ7A6DRjaqTdfUhBLmAvJyGaWOyeYgWeU2QSHLxP2i3gP0VPrbm4MvlGo5xbeYtkyTzJNUAG6u5sY6i3Q3XJ5PtG2RWbAdjze+L2Q/wD/si9zppjGw4Gb4I7akY27tSqT5iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509731; c=relaxed/simple;
	bh=bKjybBAXhUv/QDpNkd0XmMP5Clj1iN4b+ENaUp2XUsM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Oh/R+FIfF4na2WlrkPR3nkE9amGC3zbkYK8CiN2lbvDWK0gNC2jDCl0eW+O+U2uWktpoYAujXXUGdriPU3WlP7OSi9yxqs+JdY0rm3WejUAIiNYhWpzU3tBjoFi1lch3zwi/yJa10E1bGYmt55+cLPWKeW/55xveCzO5OeXYhBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=IfNTW9fa; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1765509708;
	bh=hVN0VEpngBbBvYk5u4NWA0726Jm8BFMS/FLpCH/DGDY=;
	h=From:To:Cc:Subject:Date;
	b=IfNTW9faameQtv9vGhb/AJnlB+Ya88MN6tSkpORF4aa2/Ct6+7J0YbILzQG8EL0tr
	 LtyyNhtOiealkxdXXwWxypHcADrcmNE+IXG/XpEO10pWNvlwC2J7sk/GFAYgmJvbsT
	 XhOTQPND+nS2Q3sdzbnyRTy0MJQ5PvMt2nDaN7gw=
Received: from meizu-Precision-3660.meizu.com ([112.91.84.72])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 56DB9EAB; Fri, 12 Dec 2025 11:21:45 +0800
X-QQ-mid: xmsmtpt1765509705tvyjk2aeh
Message-ID: <tencent_E8629E1FE67D7F457479179170238F07B90A@qq.com>
X-QQ-XMAILINFO: MZtEYADUG4Ag7myerlRVic0Q/0tF8YJFQRzjJ0B9qY/ETSTAjbl43yWIYgTd36
	 uW5id0ucud9wU7nIxGAq1Qg5hoUUjSn7yy+HKk2uMSmkNaNmNenARGjXFGL0pzR5rf0BLbV6WUWr
	 8MaZpHRddGBGDejYYKsJD+pi65VKVlGu0zZHMeO2f8G0tdpvmq4ZLLv3dI9Th40cyPj8kg732rev
	 DSKa7mz9YuKSR8H21v2vc/vUh9OBVRYuVA+iSd+kUjpAZKY7LE1d6JBwnW/z2AsuyJNj+glvyvSy
	 P8NWZZ8+6Pv6PCbjr6y5Wv9vuL4wzuLU5Vq3mc404KZe3PM7wdVmsByi4jEpjjVm1XHsWTe1HRDz
	 +pyH2eU7iSfkvEmx0qgcpa9UZqHJGp70OnV/DoXJJP5KvrHolEIvjDxG4NZn7V+XvEUkB/q8Re9T
	 ii9iXYzbXiAi3ehXoHwULH83XieLICO0jqXuHi64GT82fCMYtXgE7cwkVxFQMZHJwqF/lo+Ri5lN
	 REbmmX+jvrlLY7jH+Fu4gyG7WxL8appFdstZeYmz/BoRFeQttYFQ7qICYx1SN6T3yqZSQfR7O+s6
	 knFpPuTfHS5ylrAeWkLV12DPVNUZu+Ru5lx4gT55qpJlyG7XlqfBKQSKQA6RRrCmiXYEmC6J/wPj
	 VQ02iaCYelOIe9h2WqWkGKDw13djEPxp35SFcbI3OtwkFNavpCWAAnHb2xoGDZPZEoryQTfa2V00
	 H/3GW85Q+y+YWE13UOBIb5i9MHvPkHeG964zUrklbkt9geS70lEy/m8rLCu977woJvj2s8C+NV2w
	 mW7BrPmO/AcHVqhQliS847By1R39roONQ5gSAbnPmdqevqTlyG5jzEjyAJu8ZdAS7pYTg3cOhrXB
	 /2f0HDXZZzTvjxHEQN/NGrWyLtilKX6hJ4Am8h0cGr/PT1VAMmzq3gR1T+SGxhvoXZ4eRd8KQESW
	 cKNDkt/sQpmuqofnnqfAjgnDbz+Fa6lP9dMc+/126ceHAqFAeoj5cA8OySobiQxGIoFu5dj8bXWH
	 4wWBIPy2mpwI2qwQWp27C2sEFSytHzVZ7csd1X947+xPCcZo4+qks/SVujq/INmirCC9mr1PjFGS
	 hKoZVW/gQWOzniLVi0plSKGQBd+QjIGMEdsDFf
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com
Cc: peterz@infradead.org,
	dvhart@infradead.org,
	dave@stgolabs.net,
	andrealmeid@igalia.com,
	justinstitt@google.com,
	kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	luto@mit.edu,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	shuah@kernel.org,
	bigeasy@linutronix.de,
	usama.anjum@collabora.com,
	colin.i.king@gmail.com
Subject: [PATCH v2 0/5] selftests/futex: fix the issue of abnormal test results caused by thread timing
Date: Fri, 12 Dec 2025 11:21:45 +0800
X-OQ-MSGID: <20251212032145.1842158-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the Android arm32 platform, when performing the futex_requeue test, it will
most likely return a failure. The specific reason is detailed in a commit[1]
previously submitted by Edward Liaw. However, this commit cannot perfectly
solve the problem. This is because using a barrier does not guarantee that
the child thread will wait on futex_wait.

This series of patches attempts to solve this problem by checking whether
the child thread is in a sleeping state. This is because when the child thread
goes to sleep, it indicates that it is waiting for the futex lock.

v1->v2:
    - Solve the compilation problems found by the kernel test robot
    - Cleanup the atomic library code for futex test

Link: https://lore.kernel.org/all/20240918231102.234253-1-edliaw@google.com/


