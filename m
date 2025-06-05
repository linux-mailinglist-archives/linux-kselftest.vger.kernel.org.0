Return-Path: <linux-kselftest+bounces-34394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21693ACF63E
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 20:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8963A3A9532
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 18:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B27E278773;
	Thu,  5 Jun 2025 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="m/Ee+Wai"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A351DFF8;
	Thu,  5 Jun 2025 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749147077; cv=none; b=TwEMGU8+U0y/vLUptcZwH00j1saKCVKg+kbwcEOQ1+SR//clIfK9e9g9XoWttn9KNk4xnVLpnzu0ABUIx1lUnjsQ2RZHQxmJAdIAwz+g0G7eEv1gE5gNrhtYv/3zKUJB88N+GRNmEc180xywEUzZBTE7wS0x0D7EMVGaChyPvqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749147077; c=relaxed/simple;
	bh=qsPpSJ4ygt+4NVkpsrkmbd+H5NIZSkUSZ+G5QW9hzt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EBVXb7A8rZvAKDRfDTEAiCkBPWe2eakIxb5nGLucJ8OzUWwPPoF+rvK4oK1Osxq5C2BjgbHl4bQAwKx3T9nEGx6AENQ8s52gA1HXohmJq0w6i4p6JlMayrWKUdAArD8rXrNHC3Y5zRCSbABA5sGby4SAY304p+oJ6YDP4hDkr6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=m/Ee+Wai; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 555IAKGb590473
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 5 Jun 2025 11:10:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 555IAKGb590473
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025052101; t=1749147024;
	bh=yZ78zeeeYn7NurhVTyIVvApgCn0j/7L5rqg/Aa9n7Lo=;
	h=From:To:Cc:Subject:Date:From;
	b=m/Ee+WaiOn2ZlUAmkSkUN4HBj2S03xUz9v6FzET8lkAtWiQRwWasEKzlvwHGReCht
	 n6c1aNua31lOzrenmqnJgPSqrlJkKu/FM8T60NEtLA4Z6wh/Kaz4MrgE6isNjcoG6A
	 jY9of3eQoFfAid7KUGDtvjP3XIMdD/tpUgZdW3KkGH9VAcqNg+GwWOYi+v/3SxUc2N
	 eCb16xD5CxBAIGdmX0zzoJusW5riNHLLhNhYlqqRqi4AOCqvBRinRu0HwWwalsQsRi
	 kRZyj0I7cKg+UVLmOTFZMHMPrLv1ncdvj1wRjqsp0CvRlQ2YGi037soFJX9bLkzu0m
	 M1+12ODj5pegw==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        shuah@kernel.org, andrew.cooper3@citrix.com, sohil.mehta@intel.com
Subject: [PATCH v4 0/2] x86/fred: Prevent single-step upon ERETU completion
Date: Thu,  5 Jun 2025 11:10:18 -0700
Message-ID: <20250605181020.590459-1-xin@zytor.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

IDT event delivery has a debug hole in which it does not generate #DB
upon returning to userspace before the first userspace instruction is
executed if the Trap Flag (TF) is set.

FRED closes this hole by introducing a software event flag, i.e., bit
17 of the augmented SS: if the bit is set and ERETU would result in
RFLAGS.TF = 1, a single-step trap will be pending upon completion of
ERETU.

However I overlooked properly setting and clearing the bit in different
situations.  Thus when FRED is enabled, if the Trap Flag (TF) is set
without an external debugger attached, it can lead to an infinite loop
in the SIGTRAP handler.  To avoid this, the software event flag in the
augmented SS must be cleared, ensuring that no single-step trap remains
pending when ERETU completes.

This patch set combines the fix [1] and its corresponding selftest [2]
(requested by Dave Hansen) into one patch set.

[1] https://lore.kernel.org/lkml/20250523050153.3308237-1-xin@zytor.com/
[2] https://lore.kernel.org/lkml/20250530230707.2528916-1-xin@zytor.com/


This patch set is based on tip/x86/urgent branch as of today.


Xin Li (Intel) (2):
  x86/fred/signal: Prevent single-step upon ERETU completion
  selftests/x86: Add a test to detect infinite sigtrap handler loop

 arch/x86/include/asm/sighandling.h         | 22 +++++
 arch/x86/kernel/signal_32.c                |  4 +
 arch/x86/kernel/signal_64.c                |  4 +
 tools/testing/selftests/x86/Makefile       |  2 +-
 tools/testing/selftests/x86/sigtrap_loop.c | 97 ++++++++++++++++++++++
 5 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/sigtrap_loop.c


base-commit: dd2922dcfaa3296846265e113309e5f7f138839f
-- 
2.49.0


