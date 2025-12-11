Return-Path: <linux-kselftest+bounces-47395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 911BBCB51D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 09:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 376103007958
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 08:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431802ECEB9;
	Thu, 11 Dec 2025 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="cfmjfs6o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD7D2ECD0F
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442184; cv=none; b=WXH7tKefrh9xDaLOxBcN9sBqUKLNjvSvbK+2qAoVt3sLCH5+5h/TYV6e2y8+4ZRTJDvuCHDXs1fU/Zl9txtONtJxAGLh8sk9f5WNiU30Ohtu1FL9qii3eNoath+n07yUOOt2HHuejRctrUO+L+eMCAqDXqF9aTW+wOjq+LMIBpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442184; c=relaxed/simple;
	bh=jIjz/T6XpRYaNC3hsiIb9b3/QNntAWKPTgoywF8YqQc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Gu1qEHenNtVyVLEUp6pv6ETRwCJyJTngv+c3AkFkUDm0dQ8NY1La/XFfEe2WXFNpd35+MXorZeaLGrCwpDR/PpnbxOIqD17Dnvdx9qduS3VmAsgsYhOjZn/lwizZLhSpZvyTWstkMMGVdb1OxJM+JL+rRFYzn06Msx5cIrosASk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=cfmjfs6o; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1765442177;
	bh=jIjz/T6XpRYaNC3hsiIb9b3/QNntAWKPTgoywF8YqQc=;
	h=From:To:Cc:Subject:Date;
	b=cfmjfs6o89Ecu7jJEsJSXBeV+9N5/Wh7W8oljUczqkDMx7B4+Bo2rLXRspE98GRGs
	 rPA46mlhAkB2SfMj+3JpGiw3uw+u4NdvwKHakrDqpKMSBsfBYrP5DadUv495rxE0t7
	 zQN1OuXQZi6AYtvxenjGeCDoALFr7HYfjUnishfk=
Received: from meizu-Precision-3660.meizu.com ([112.91.84.72])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 90CB5886; Thu, 11 Dec 2025 16:36:12 +0800
X-QQ-mid: xmsmtpt1765442172tkbnxe2lr
Message-ID: <tencent_3739CFB7F300BEAEBB928A0EB8D1C6875C09@qq.com>
X-QQ-XMAILINFO: M2SvzgchpLqfgv8fprE0lPiF/BquZ0eVzy2GXfXxxnnaudwql3MZ2GSIVdEAmA
	 gvn3l4V/woNF9JksyUvQKetGA5GH9HVgptowwHZIPa83/jQ35eC0iiFDHLLQ9Ay0tW901/AtsBkm
	 4jFPOak+iw7F7ViQUEUGmTqhBEMMUf76IOEPK9cf0a9ph28PeH8IZ/4me9L0Tm748SWfsj3x56Gs
	 z2HUOR7s8hCgIklPsdzJjgh4WZi4ucGz+U0FY6HIqBNXNvd0snL7IfswI+el5NBHDxwu7XWpL/4o
	 g5E5ix1VIXnmNihNTV8MKT6cnSGo8MMYkIMNx0B3rCh9BykV5BmfVXYOuGISnHgp5A3vEucDcqRu
	 9IPX+Bs6gVfq41OIB0+3fUwCnfWb4a1pUTSTlnb4mytkJPn5buDjHuCqAWzk5TTs0dYoQDF0o5hl
	 dQsJJvp/O6F/z8gnGpB/WCDgrCSidFsOfMQSOM3Qygvh24Hjkw0OYaTUA0LLejbVwVfdCHixcMqU
	 oCdhn2Ld0jPzQIHKoNYQC/sdn9/K+x+IBJpZaHFlwKyxQGZn/v7uFpMXS8ZED+2eSewL40IPd8wl
	 tmhx8sV2X9+vnSh0aZHX1WVxjDAPFPhfWOLwAl2kOH4wZErT/zA8/Y+xdRHUUMQQYFVJ+Fd7ZSW6
	 z6pDzRBWq1dko8KG+G0p6jZE+K7JbRiksZY5T/DOY1kXI5cJhYcwFW2H05y3DLnpUqYcjk7VMPo1
	 wAPxjFjS7efMtSWdEzFNz2tqs6zCvX72olADczeXesJgKjbJFjAg6H9fCSiCfLTH6Kl2BOBNp3tb
	 wbINt4B/FCvKHfbguTkIVBsn6t0ekggWeJqJjgxefYmD9lFqo2oxoASx53krY41i+gzArwYSuVCI
	 udNZw0wYpaIdA9d+bxUzjOaIBjkz0VliYJKF2jDYLFtUXlkkLaFkrzpUnzBw07VD/qXOKox1isjs
	 mFuW45SGkGHepCs+fxUGVCBxFu+vZRRaqUAzlHY7QMYj4QkjyqqzRYO2iUZVy/xf+rB783IfPPoW
	 cj9EHCzmpF4BceCFfvhO8ldSuDbxTYpRJAsfXJeB1u10JB3V6ToBRMhRBR3+Qin69mdkx/poZIKJ
	 kKIcuIvO28W3zcXzsMjzDCSf4ggw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: andrealmeid@igalia.com,
	akpm@linux-foundation.org
Cc: edliaw@google.com,
	dave@stgolabs.net,
	dbueso@suse.de,
	dvhart@infradead.org,
	hpa@linux.intel.com,
	justinstitt@google.com,
	kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	luto@mit.edu,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	shuah@kernel.org,
	tglx@linutronix.de,
	usama.anjum@collabora.com
Subject: [PATCH 0/3] selftests/futex: fix the issue of abnormal test results caused by thread timing
Date: Thu, 11 Dec 2025 16:36:12 +0800
X-OQ-MSGID: <20251211083612.1795685-1-ywen.chen@foxmail.com>
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

Link: https://lore.kernel.org/all/20240918231102.234253-1-edliaw@google.com/


