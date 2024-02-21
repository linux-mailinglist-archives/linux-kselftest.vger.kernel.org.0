Return-Path: <linux-kselftest+bounces-5251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F7485ED1A
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 00:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB771F23609
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 23:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F5981752;
	Wed, 21 Feb 2024 23:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UisHyCZh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8845B12AAE2;
	Wed, 21 Feb 2024 23:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558725; cv=none; b=BqI+hXBFqXFa2wtn3ZvDZY3lXbA+3ccDepO7qu+nGrRRjd4P4Vdjo5XmsLaQeCC/7CRZuRDa7FKaSixVc9Y85rFZXK8LnGmqZ6csgqM+b2w2doncRh05sulnQlISzWbgMm1DHMrb+9waJ1Q/G1TBta38IeKVafxA67r+98HtXRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558725; c=relaxed/simple;
	bh=mqzDBgvnARQZuU+Pb8bmtT89hBXtM0GOCDpsxtpoHm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XO50AnSLx1ei8qvUGnitkx/X7n+91KL06QzvgTd0MpbVwHTO46WWVuolDxIiDspF8L4TchUEs4P3UhQcUlxkmD1z5H1e3vfQF3gmupSw/bwnyCyWA0JRZC+QIjQzvI0Vo/Eo2x8mM20u2pUIiVS70P+o5qgW1XqoGXkLspXHoUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UisHyCZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19FF4C43394;
	Wed, 21 Feb 2024 23:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1708558725; bh=mqzDBgvnARQZuU+Pb8bmtT89hBXtM0GOCDpsxtpoHm8=;
	h=From:Date:Subject:To:Cc:From;
	b=UisHyCZh/EXw2iELZKEcraUL7Tm+nULt5XUFc2XICjcsZo8FzvAbfHY0cK4mAbs8T
	 YVDOJpWa4quk4gMspTX7CZIda7f1a8XY2c5QFlC8utBRU8Py5ZvbRssnd3KfU7z085
	 fUCMwKidEhzK62niy59XAKjmcbsfI3A891QD5Ac4=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077E1C48BF6;
	Wed, 21 Feb 2024 23:38:45 +0000 (UTC)
From: Itaru Kitayama <itaru.kitayama@linux.dev>
Date: Thu, 22 Feb 2024 08:38:37 +0900
Subject: [PATCH] Build guest_memfd_test also on arm64.
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-memfd-v1-1-7d39680286f1@linux.dev>
X-B4-Tracking: v=1; b=H4sIAHyJ1mUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyMj3dzU3LQUXXMjC9M0S1Mzk2TDVCWg2oKi1LTMCrA50bG1tQD+NlG
 VVwAAAA==
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708558724; l=1061;
 i=itaru.kitayama@linux.dev; s=20231030; h=from:subject:message-id;
 bh=lA7PzCZQ2lseoAA2i+RxO+8QEPr2soICHGzThVxFsV4=;
 b=5n1duozIxzxnBCXUW296kFTXX6lgv5V+XSAWRZRDLr6XvGcTjdyoHjOFdcVTWctswvlhZ8LNu
 L084E6chHO/Dr2DVGeC4UFBmQ/xSZcvmsNde3tZ3UnwmBdJOh/g0p/q
X-Developer-Key: i=itaru.kitayama@linux.dev; a=ed25519;
 pk=4yYhz2CbKL7F2qR5IzP7QvqM9B6c+dfWJRHWez+rMDw=
X-Endpoint-Received:
 by B4 Relay for itaru.kitayama@linux.dev/20231030 with auth_id=92



---
on arm64 KVM_CAP_GUEST_MEMDF capability is not enabled, but
guest_memfd_test can build on arm64, let's build it on arm64 as well.

Signed-off-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
---
 tools/testing/selftests/kvm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 492e937fab00..8a4f8afb81ca 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -158,6 +158,7 @@ TEST_GEN_PROGS_aarch64 += access_tracking_perf_test
 TEST_GEN_PROGS_aarch64 += demand_paging_test
 TEST_GEN_PROGS_aarch64 += dirty_log_test
 TEST_GEN_PROGS_aarch64 += dirty_log_perf_test
+TEST_GEN_PROGS_aarch64 += guest_memfd_test
 TEST_GEN_PROGS_aarch64 += guest_print_test
 TEST_GEN_PROGS_aarch64 += get-reg-list
 TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus

---
base-commit: 39133352cbed6626956d38ed72012f49b0421e7b
change-id: 20240222-memfd-7285f9564c1e

Best regards,
-- 
Itaru Kitayama <itaru.kitayama@linux.dev>


