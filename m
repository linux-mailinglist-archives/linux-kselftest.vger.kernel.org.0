Return-Path: <linux-kselftest+bounces-23273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E189EFDDD
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 22:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB1B1884590
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 21:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FD11BEF82;
	Thu, 12 Dec 2024 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IIDBg6s8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908E9189B91;
	Thu, 12 Dec 2024 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734037508; cv=none; b=DHLiRtISIur7ZPGt3Vk/0+AGlXX6AaWuTnJN9uhp4LufSpP1wP4hd9aswNPWfWAYXCWLFdTgjSuov+fDvobx4cx51W/EKILOoJNFqX1KVz26nj1xnb3WyhizppTm7sA5Fd/NO/zp0epNQCsh41OLTXUhdtdsdkrqnG7o0a9c2BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734037508; c=relaxed/simple;
	bh=0LHuRmoljngdSD9c+1N7oQMp2u8ZMuceW5H/pbkyORg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lN91PiySiYzjYVO3MCm9NQ/Yvay/7ZPSF6Sw3eMU2RMD5HlYCb55n4/aWfVboyrj3lkk4OGCwW2I3J6M3LlDxfNi+w+/eZoiuIzD5+zCKXhnaOH/SxBQbTGFToGKxY93+3PIxZZBaeP5xDyQyUSggKQtLWgfIdHCvranudNfKuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=IIDBg6s8; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Dblla7udreygadXARpvlhJgD7EDNMt9ieS+Bqs3OkTw=; b=IIDBg6s8bKy1h8w52VcPk+Ix+E
	8YSbNT2BN56Kt22Aq60rJJFA+41BVJDOr5Y4/VXbDIBhuDgg7jU+9j9Dn4Y1tjWYP7z7+xyFZfmHo
	lp901ImPHOqm8tv69QFHN+7uV8XCXRjIaXrTvtmzwA2cmqdCAckfYEJ1zijeCW7Rir2Ov+pHnL1/7
	4PKLMS5gzKoqS7LRI3CwlJudmUatrLdJYu3YIEXI0XwUMhU9OPslAlqlAaUx6erAg2Z+0Nx3jwrC+
	GFbIS8j9MT0ftf9hjJMJnahi3k4EZrWTH1MLbsTZDSl1kjxSc4/Hsnxvyvy1V363yGmdTWXVVbByG
	Z23GOJzg==;
Received: from [179.193.1.214] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tLqMT-002Oni-EK; Thu, 12 Dec 2024 22:04:41 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v4 0/2] selftests/futex: Create test for robust list
Date: Thu, 12 Dec 2024 18:04:34 -0300
Message-ID: <20241212210436.112076-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset creates a selftest for the robust list interface, to track
regressions and assure that the interface keeps working as expected.

In this version I removed the kselftest_harness include, but I expanded the
current futex selftest API a little bit with basic ASSERT_ macros to make the
test easier to write and read. In the future, hopefully we can move all futex
selftests to the kselftest_harness API anyway.

This is the expected output:
    
TAP version 13
1..6
ok 1 test_robustness
ok 2 test_set_robust_list_invalid_size
ok 3 test_get_robust_list_self
ok 4 test_get_robust_list_child
ok 5 test_set_list_op_pending
ok 6 test_robust_list_multiple_elements
# Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0

Changelog
v4:
- Fixed clang warning "robust_list.c:121: converts between pointers to integer types
with different sign"

v3: https://lore.kernel.org/lkml/20241010011142.905297-1-andrealmeid@igalia.com/
- Create ASSERT_ macros for futex selftests
- Dropped kselftest_harness include, using just futex test API

André Almeida (2):
  selftests/futex: Add ASSERT_ macros
  selftests/futex: Create test for robust list

 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   3 +-
 .../selftests/futex/functional/robust_list.c  | 513 ++++++++++++++++++
 .../testing/selftests/futex/include/logging.h |  28 +
 4 files changed, 544 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/futex/functional/robust_list.c

-- 
2.47.1


