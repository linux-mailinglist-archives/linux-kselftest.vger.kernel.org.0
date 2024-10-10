Return-Path: <linux-kselftest+bounces-19414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EE2997A0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 03:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4901C1F23918
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 01:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569452AEEE;
	Thu, 10 Oct 2024 01:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fzv4DN2R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9E1179A3;
	Thu, 10 Oct 2024 01:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728522728; cv=none; b=XV+DAFMvka6Q6orrD47/e5KplL+X4OPHKFYYi/5014MoO/GwsKiClCdLNucPR9ckMisAHc40o+Bp7Bc6uJ1BZ0uCAv1Db7jl0kJagKp93QZ/2EvyUTSLtZ3kMwTAwkCGBZw6jxtNMKWy9Mnatt8idivS/8J7YShN/Kxirr93eRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728522728; c=relaxed/simple;
	bh=sfTmi9bO+JsKHo8KbDH+whliHBSUn1Xnkn5TlzDEB9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M+arBE2O5rTHW/+7ZjBB4/QqFCd+U6YcR6jU/okkmV2cZOPxA8r1O1FbSEY+wP7fzBEaT0cmeNU43pztSxjUihy7GYtkdEwqQ0FtE3YxEc5LGaFoTUVay2YV4L9qcHpyV3x9QzBXnJbHbnRwvLI8RJmIOYWWKdMrOxqlNaWXtY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fzv4DN2R; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/vbsgdq8h70s6oV3b82YFlDBTjmMluLLdybnxWtRiWg=; b=fzv4DN2R5dh46hDCZHSxlm7eYc
	di5Ks1VQOhz9Ar0y59Inp7LCIvkjcyBeSrcsyyoxrOLg9JNW2EAb7QkNkJt9fixSiGRl4hD0PoYY2
	9z8pLPfnOolMSKc3s4mNRPstkSw0RkI/xzUpPS/dtnlmBceqCdKp5WAJS5uLSrSTtrgieKU79dLXr
	8gZbzTFfOAy033SeAS0owzzzDq3qey2xuy+XGxrJEoNvyy3rp5afZJJyVauhKjNjdeO8j/Ll4J0pO
	gVn0Et7Dv1jujN74Yn6vrSpR6iavyy0oYmz5CfF0lMTNmDtQI4adlxuZ0UYhVgDoScqzuw+oens/7
	3iOcbuqA==;
Received: from [187.57.199.212] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1syhiY-0079Wq-Es; Thu, 10 Oct 2024 03:11:50 +0200
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
Subject: [PATCH v3 0/2] selftests/futex: Create test for robust list
Date: Wed,  9 Oct 2024 22:11:40 -0300
Message-ID: <20241010011142.905297-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
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

Changes from v2:
- Create ASSERT_ macros for futex selftests
- Dropped kselftest_harness include, using just futex test API
- This is the expected output:
    
TAP version 13
1..6
ok 1 test_robustness
ok 2 test_set_robust_list_invalid_size
ok 3 test_get_robust_list_self
ok 4 test_get_robust_list_child
ok 5 test_set_list_op_pending
ok 6 test_robust_list_multiple_elements
# Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
https://lore.kernel.org/lkml/20240903134033.816500-1-andrealmeid@igalia.com

André Almeida (2):
  selftests/futex: Add ASSERT_ macros
  selftests/futex: Create test for robust list

 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   3 +-
 .../selftests/futex/functional/robust_list.c  | 512 ++++++++++++++++++
 .../testing/selftests/futex/include/logging.h |  28 +
 4 files changed, 543 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/futex/functional/robust_list.c

-- 
2.46.0


