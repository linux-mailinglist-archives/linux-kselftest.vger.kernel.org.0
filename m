Return-Path: <linux-kselftest+bounces-14861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9291394933A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 16:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50EE0283314
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 14:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC5E1BE875;
	Tue,  6 Aug 2024 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwlfmkOj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D5317AE11;
	Tue,  6 Aug 2024 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955073; cv=none; b=cpedOMkYqNLsgkNb7+I4quYjHK3nXEoBwX5yKqgC3YML4MH6gMiVr9q2/MPQPhUakUPM04feqo8ZYvVlkGNa7aYdyYH9RaGqZ1PBi1OIxPhxqUyjDiH83CWd2OU4DHNo8ox4+vNXNawlHg6iYpbvVE7faL4HuRBHNlqQuXK+MhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955073; c=relaxed/simple;
	bh=5F/a2UAFCbcuKds0UHemgLchXdDzpsNufq+WS34s7TY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sZ0O4AWnOAxUILNzRBe4q7Cwba22kUgfuI+B33LzcaCY45S0qvvX3q+TIcyuUefrAEE4VPEtLfw3jKEWJd7twP0q/03eK3mFqN/GHVWdTMgKP5F1U8KrkgVg2+CCry1/5tQOR+3i+QwKr6+sjOLgjHBbdXtzexwI1TVAnU8IKvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwlfmkOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13293C32786;
	Tue,  6 Aug 2024 14:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722955072;
	bh=5F/a2UAFCbcuKds0UHemgLchXdDzpsNufq+WS34s7TY=;
	h=From:Subject:Date:To:Cc:From;
	b=TwlfmkOjkmKrGB2oxo/vKQyhrP9hBRgAyg8S8ztRz9C4xhiKelolwhFqpAxIb+HqI
	 AbyxrryL05k1KJZNr6VHt0ng4yEwCUvqe5RVLYJqh5IJta8E+Fv9PiRYT6Os2hDo9b
	 B2RJFHxZJy3FN2/pPjjeuvWxW2zcxRVVLJNySjFrTuiGwHKUqx5gyDlPk7kBQbyZaV
	 claIX7GGUjZkC+ZFGrvAaoQ9fGapGwfI7CQwsT9On86rc0PzCmmqkqeyu43mJvCMU4
	 MDlhzMRQymnQxOcgwX+DZE4jpySMKlbV9c9V7O1X7IIenm+WWM17Z6Zao0/Gp0jZeu
	 5rVHYAf5jljWQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/3] KVM: selftests: arm64: Make use of sysreg
 defintions in get-reg-list
Date: Tue, 06 Aug 2024 15:24:21 +0100
Message-Id: <20240806-kvm-arm64-get-reg-list-v2-0-1d3fbc7b6844@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABYysmYC/4WNTQ6CMBCFr0Jm7ZhSoDSuvIdhUexQGv7MlDQa0
 rtbuYDL7+W97x0QiD0FuBUHMEUf/LZmkJcCnqNZHaG3mUEKWQstJE5xQcOLqtHRjkwOZx92NFq
 Zqq2V6K2FPH4xDf59ih9d5jGXNv6cP7H8pX+VsUSBlWn6QQ9atKq5T8QrzdeNHXQppS9TTIovv
 QAAAA==
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2025; i=broonie@kernel.org;
 h=from:subject:message-id; bh=5F/a2UAFCbcuKds0UHemgLchXdDzpsNufq+WS34s7TY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmsjU68/WV5P2u7RmlE2JOAjzGyS20eONW8lrOc5SL
 rnTPUz2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZrI1OgAKCRAk1otyXVSH0IGdB/
 9jvWpYk/BIfnApqIH7uNCraWHJCs89PvHEWALj2z01/WeNGVvmx9dQiHgISElWrn0lUVqiTc+wfeAP
 4VHvRg0EihU7gYrYxcFlILQ2GAz/3tAsA942qSozFFxfQZWsj1d0lQ4uft/nsafuqHLbM+DVTsIQMv
 3S/Q6TesPXFIsF4MXinyqMOkM9zrq1nNk0LC1z8eETynMsxz/hGtXmzmrKUs40zw6Xkr4siVUc3dbX
 4I7ljEEdyWYIJIXLflGRWBd6a5t+qUki0WV3apourOzQ8ofjpPJJpFbcqtTUHMAY5KS6amn3U1EX2n
 ul7VutQpDY2B4KmgZ0aMxtHOraehVc
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The system register definitions in the arm64 get-reg-list are all done
with directly specified magic numbers rather than using the definitions
we import from the main kernel.  This is error prone, and requires us to
audit the additions to get-reg-list separately to what we do when
specifying the registers for the main kernel.  Since Marc has indicated
that this isn't a deliberate or desired choice let's start using the
constants we have defined.

We first manually update the data used to filter registers based on ID
register fields to use a simplified macro that specifies the register
and ID field in a muc more compact fashion.  This is done first since
there is an error in the ID register field for the S1PIE registers.  We
then replace all the remaining named system register specifications with
use of the existing KVM_ARM64_SYS_REG() macro.

This is just a first step, there's a bunch more work we could be doing
here, the main thing being making use of the encodings in
arch/arm64/tools/sysreg to convert more of the registers (including
updating as more registers are converted to use the generator).

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Add use of designated initalisers when converting filtering macros.
- Manual handling of CNTV_CTL_EL0 and CNTV_CVAL_EL0.
- Commit message tweaks.
- Link to v1: https://lore.kernel.org/r/20240802-kvm-arm64-get-reg-list-v1-0-3a5bf8f80765@kernel.org

---
Mark Brown (3):
      KVM: selftests: arm64: Simplify specification of filtered registers
      KVM: selftests: arm64: Use symbolic definitions for incorrect encodings
      KVM: selftests: arm64: Use generated defines for named system registers

 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 244 ++++++++++-----------
 1 file changed, 122 insertions(+), 122 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240802-kvm-arm64-get-reg-list-a86a37460bdd

Best regards,
-- 
Mark Brown <broonie@kernel.org>


