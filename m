Return-Path: <linux-kselftest+bounces-34425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B332CAD07B3
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 19:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8186916BFD5
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 17:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8938D27F163;
	Fri,  6 Jun 2025 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qE84Qrwb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213EB323D;
	Fri,  6 Jun 2025 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749231966; cv=none; b=d+Qk2dBXjOTHfRQ96LstVjlFWw+iHuCggdAfo8+rzHX8FQ7jxEj+osz0A+xFFFUV5dMRICZvTwuyyOA50nOxPrBas1kkntlagOfcKmDiesIC5Mb/MwCwu5UM55IlvhrROG6ft8dMkIs6dVlBRqm29d1cE0ke3K/BHG4Iv7E5iFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749231966; c=relaxed/simple;
	bh=kzZo/pPwS2a7woTNhFPCC1pFFoifVZqTySTlI5BhV1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IqpyUOdeT4LypJNawqOEtFTrdGAzzOdOlpPjV59QLYFV+IAVT8ulsKIHCNIamnR8gHAG7hAHUvdZMS05VpxmqS9j+YV0vuwiHtBKk17SkDhIIbWB0O7RMK8XQOeFuvFufmYxHmypknyfb15agqqKdMyInEjh0lzf99mcOw7o1qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=qE84Qrwb; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 556HjTFp1004770
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 6 Jun 2025 10:45:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 556HjTFp1004770
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025052101; t=1749231933;
	bh=0fzXvFcjV1jijNBzKFIeWvGOahvlidSk1fy1tPhoqJM=;
	h=From:To:Cc:Subject:Date:From;
	b=qE84Qrwb2bZ7OsLlWMVzd+0jAE9+EgkORYDkjdGmNVQuv06TdJhu4Ad10qP55w7v4
	 RKCUa8S8KPzVSZCF0eAd8ABUSxJcxF71R7UmGKIDjVnoVXim2nESJT07hK31y1FrFc
	 R5VK7d/lUkcYv6hGgUR6wUPzRtm0fXUKPDoOSLFafLRq/EtVIBBNaI5tdU1tcHD2Z2
	 YW0P7utoZ77ANrcW4yt79DSGwfttGKlViazlAQjFyUnp2WxhP3WmjyftARBWAzj7eD
	 zfu++TTXw12ROzR+M/9nxHhKML6oKpger0piyj6q/QOvZS0acIMKojroDCkhN0cNSW
	 U11hoNOr8ltZg==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        shuah@kernel.org, andrew.cooper3@citrix.com, sohil.mehta@intel.com,
        stable@vger.kernel.org
Subject: [PATCH v5 0/2] x86/fred: Prevent immediate repeat of single step trap on return from SIGTRAP handler
Date: Fri,  6 Jun 2025 10:45:26 -0700
Message-ID: <20250606174528.1004756-1-xin@zytor.com>
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


Link to v4 of this patch set:
https://lore.kernel.org/lkml/20250605181020.590459-1-xin@zytor.com/

Changes in v5:
*) Accurately rephrase the shortlog (hpa).
*) Do "sub $-128, %rsp" rather than "add $128, %rsp", which is more
   efficient in code size (hpa).
*) Add TB from Sohil.
*) Add Cc: stable@vger.kernel.org to all patches.


Xin Li (Intel) (2):
  x86/fred/signal: Prevent immediate repeat of single step trap on
    return from SIGTRAP handler
  selftests/x86: Add a test to detect infinite sigtrap handler loop

 arch/x86/include/asm/sighandling.h         | 22 +++++
 arch/x86/kernel/signal_32.c                |  4 +
 arch/x86/kernel/signal_64.c                |  4 +
 tools/testing/selftests/x86/Makefile       |  2 +-
 tools/testing/selftests/x86/sigtrap_loop.c | 98 ++++++++++++++++++++++
 5 files changed, 129 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/sigtrap_loop.c


base-commit: dd2922dcfaa3296846265e113309e5f7f138839f
-- 
2.49.0


