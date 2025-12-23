Return-Path: <linux-kselftest+bounces-47897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9253ECD7B63
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 02:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 745823022B4B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D82A3446DA;
	Tue, 23 Dec 2025 01:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+qxLBd1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3DB3446C5;
	Tue, 23 Dec 2025 01:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766453012; cv=none; b=ojwXY3urdtc9DlQ0AfhyYucvZU01kPEA6wmZk5WixyxI2JfB0QkuXCco5+0oCbjiqy66N7nNp6SQMuBoE+XEtlXoW4RbH8cAm6ynlHUnin/pc8R3yyVmmX0LFfd56z+TaF7WQp+MIEgryhP1CgUvQs07xKu49jsXaORter136Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766453012; c=relaxed/simple;
	bh=Z5j3l5hq06OVglsz6W9Xs4iwgZIZ/lq9hxI6ABS0IYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c2aaX01ACAS15bsgQHVOEtU2jT34AiqreQi1ISZtoG/bxSYogxl3xgMjdQi6cfnok6bUinAdwfY69MOP1F7zs179R7hUCPG2fLJCMilxd4vyZAcv4oIJtbZ77c/j9+Soj5iksgeDcVfKW1x8cieTUUzVUA85XzuBZyw/BgrQabE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+qxLBd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13B3C19423;
	Tue, 23 Dec 2025 01:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766453011;
	bh=Z5j3l5hq06OVglsz6W9Xs4iwgZIZ/lq9hxI6ABS0IYM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q+qxLBd1+fBvecWLmFic4UBW2LgCAzlPUr9zb0EF80h8QkPP4HPOhbO1rYiVYjGw/
	 Jw/yDNNQ9ERhcqDPInp5hXfwMU9jFrWbRvCjExBqhyYrmwgs7bQe1ph9AGup0JCjap
	 osv3tq9df9wVDVMyI0Fd8zzQxG2Bk0SKNgPTsznaTCF0131x2EfWFuCfSNMx6iLjkz
	 Df/sZea2lE3kMBvsMpupIkq0UGmU8kZ0jKCUkfHTTdbMLq0mFI3sJ8IH8HJ2ss9h/H
	 oSKwuE8qVSTBLzmXbeIB2XWAQNHzi7jsoBZSkw3QToRd8h+fUJL0lQOAXzNLRroh2X
	 OEUuStJ92mzHA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 23 Dec 2025 01:21:21 +0000
Subject: [PATCH v9 27/30] KVM: arm64: selftests: Remove spurious check for
 single bit safe values
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-kvm-arm64-sme-v9-27-8be3867cb883@kernel.org>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Z5j3l5hq06OVglsz6W9Xs4iwgZIZ/lq9hxI6ABS0IYM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpSe6XuZqDZHAD1EbYrK8wn0phiB+1DdVn6PblO
 QAM9RR2+ICJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUnulwAKCRAk1otyXVSH
 0JJCB/4y34p+VTk0tkbCqrPh1qJK7fJsyrMK/+p5SaTDCsoRuuE4RyMJ5RqomOK0FgfnkdBHk2P
 va9Xud+cf24Dezk4eYeg6HQaJtZRQnK1AnSqKOMOfxx5fqmK8wljWyR/QII8LA4UrQWX7vGTpYp
 t9Wmb+EZUJoVc14h9Mfmqcum/aUjTjiEm4RnN1HO+PdnxU5p3HRXlQfB0g1RRPSvkzwr3w+Bish
 0erE71BlCyTFzonFUO3SH+5UhD1w/bCILJybHOzBsnDEcw/jBIyIVUI7eKq9CJ7lEMfhxExTe2M
 bTitMkcm7AoeoGDCM1CjdBli5WAddd0qICzdghkryQSjmMmN
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

get_safe_value() currently asserts that bitfields it is generating a safe
value for must be more than one bit wide but in actual fact it should
always be possible to generate a safe value to write to a bitfield even if
it is just the current value and the function correctly handles that.
Remove the assert.

Fixes: bf09ee918053e ("KVM: arm64: selftests: Remove ARM64_FEATURE_FIELD_BITS and its last user")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/set_id_regs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index c4815d365816..322cd13b9352 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -270,8 +270,6 @@ uint64_t get_safe_value(const struct reg_ftr_bits *ftr_bits, uint64_t ftr)
 {
 	uint64_t ftr_max = ftr_bits->mask >> ftr_bits->shift;
 
-	TEST_ASSERT(ftr_max > 1, "This test doesn't support single bit features");
-
 	if (ftr_bits->sign == FTR_UNSIGNED) {
 		switch (ftr_bits->type) {
 		case FTR_EXACT:

-- 
2.47.3


