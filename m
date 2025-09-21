Return-Path: <linux-kselftest+bounces-42019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C63B8DBB2
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 15:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B015189BD8F
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 13:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E102D6E7F;
	Sun, 21 Sep 2025 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwam33GQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6858C1863E;
	Sun, 21 Sep 2025 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461113; cv=none; b=lKL93g1I05k0Hpsv2ki3FrUqb09AmLJOAfgMqBV8JkXqzJVIJ4ZbzEGIIR8/FgDxEJIAgEEEjLd70F1FLX2iiVtrzhsD+uhjYz/HIuDcoMuwyE+0jTponmI6lyN+tlW+Zc6RbQ9cNCKzirhIR1yDMjcvl746d9fL0rMZRipOFLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461113; c=relaxed/simple;
	bh=uiS7ak48qsq0YS43npk87Kkwxiw17oFaWGEvKa8C49I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=m22MZ4+40aQ/GSgjKEPrWRvky07wT7GmGwyMQfVNT+/nvestFyP/9uJjESmoTaZ7pQdAf11Ex87qnt8r/reN2ymFsZ6tfigmpEGtr4QXT95CpiC332/fsO7uJidRUq5dDBT6k/waYItDETEizkrGa6JcPeJQGj2XDHA+Erbb9KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwam33GQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D233C4CEF0;
	Sun, 21 Sep 2025 13:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758461113;
	bh=uiS7ak48qsq0YS43npk87Kkwxiw17oFaWGEvKa8C49I=;
	h=From:Subject:Date:To:Cc:From;
	b=pwam33GQelPGruexNN/xDzLWVbEYs5mu1JG9g+3eBO4bScGL2aR+f0a8TQwY369Od
	 Gj3b7mbtFzYxoZpJ6B3W/o3+GqyRmv1zsAB7qhO8I5omFxQcQX+gxtb+UGfqhTPY5i
	 O55IIHLeyM2s2sutRxNWXI86iGYQzwMVNFkBWukV0hbbOd09yqHVE/v+Ve+xEYNBNk
	 sVCJia1FAnkf6ENQdb59eQv25xmwdwdRDmiOC0GSEZiJZAyddhT2DYrriYooneCHDJ
	 iQcQvY9UKG2kUYdYyilYCPiiFrbzW6pH06XlLiGmYpaIHgXvTdLTI4GqsVa2VgttFi
	 AyMfepIiCNLtQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH RFC 0/3] arm64/gcs: Allow reuse of user managed shadow
 stacks
Date: Sun, 21 Sep 2025 14:21:34 +0100
Message-Id: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN77z2gC/z2Nyw6CMBREf4XctTfpg6KwNfED3BoWtb1AgxZtq
 5IQ/t1GjcuZyZyzQKTgKEJTLBDo6aKbfA58U4AZtO8Jnc0ZBBOK1bxGHa5Vib2JSLNLmKaRPO6
 EkUaoLdPaQr7eAnVu/mBPcDzsof2Wge6PrEi/5W9oisyXnGW+uUyeJMZB2+mFMWkzIle2ZFacO
 yUraNf1DWCwg7K2AAAA
X-Change-ID: 20250919-arm64-gcs-exit-token-82c3c2570aad
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Christian Brauner <brauner@kernel.org>, 
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 Carlos O'Donell <codonell@redhat.com>, Florian Weimer <fweimer@redhat.com>, 
 Szabolcs Nagy <nsz@port70.net>, Rich Felker <dalias@libc.org>, 
 libc-alpha@sourceware.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=2599; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uiS7ak48qsq0YS43npk87Kkwxiw17oFaWGEvKa8C49I=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoz/yy1rTEq5YgzFfX39saUQCKKDRNid2kj+KDp
 u5hvo8ID0iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaM/8sgAKCRAk1otyXVSH
 0JU3B/kBKCC6dI85Qt5+fS/3i94Pr0WXw6hMdCcDct7u7TTH9zfvEmjeg/+j45Y0FVnx2jHo5vr
 q7iFyxpSdhcOY22Fm+sWge596m2zb7hLwNecPb6YqiZ3jmZSZ7hfsps8G0EP4B122P0+MhgiGQt
 PJ1u7/HfkfQAdFLpgoDARjI2aHi4Eb63MZ9d30wog3Wx6bR8Uw0Nrz40lCM84d2dFuGLe+ua/Hp
 5eZTHaWJpVyyZ9FmhNT7ZRt8yYvbjXL1P/ilXAZjINqYjD6DusYDxcUux11PlXuCQ2eQK9+uw4j
 my3MALA8PPCjkXiTswmuxxxtPhpWeHIShQdStuxaxAz4KAwE
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

During the discussion of the clone3() support for shadow stacks concerns
were raised from the glibc side that since it is not possible to reuse
the allocated shadow stack[1]. This means that the benefit of being able
to manage allocations is greatly reduced, for example it is not possible
to integrate the shadow stacks into the glibc thread stack cache. The
stack can be inspected but otherwise it would have to be unmapped and
remapped before it could be used again, it's not clear that this is
better than managing things in the kernel.

In that discussion I suggested that we could enable reuse by writing a
token to the shadow stack of exiting threads, mirroring how the
userspace stack pivot instructions write a token to the outgoing stack.
As mentioned by Florian[2] glibc already unwinds the stack and exits the
thread from the start routine which would integrate nicely with this,
the shadow stack pointer will be at the same place as it was when the
thread started.

This would not write a token if the thread doesn't exit cleanly, that
seems viable to me - users should probably handle this by double
checking that a token is present after waiting for the thread.

This is tagged as a RFC since I put it together fairly quickly to
demonstrate the proposal and the suggestion hasn't had much response
either way from the glibc developers.  At the very least we don't
currently handle scheduling during exit(), or distinguish why the thread
is exiting.  I've also not done anything about x86.

[1] https://marc.info/?l=glibc-alpha&m=175821637429537&w=2
[2] https://marc.info/?l=glibc-alpha&m=175733266913483&w=2

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (3):
      arm64/gcs: Support reuse of GCS for exited threads
      kselftest/arm64: Validate PR_SHADOW_STACK_EXIT_TOKEN in basic-gcs
      kselftest/arm64: Add PR_SHADOW_STACK_EXIT_TOKEN to gcs-locking

 arch/arm64/include/asm/gcs.h                    |   3 +-
 arch/arm64/mm/gcs.c                             |  25 ++++-
 include/uapi/linux/prctl.h                      |   1 +
 tools/testing/selftests/arm64/gcs/basic-gcs.c   | 121 ++++++++++++++++++++++++
 tools/testing/selftests/arm64/gcs/gcs-locking.c |  23 +++++
 tools/testing/selftests/arm64/gcs/gcs-util.h    |   3 +-
 6 files changed, 173 insertions(+), 3 deletions(-)
---
base-commit: 0b67d4b724b4afed2690c21bef418b8a803c5be2
change-id: 20250919-arm64-gcs-exit-token-82c3c2570aad
prerequisite-change-id: 20231019-clone3-shadow-stack-15d40d2bf536

Best regards,
--  
Mark Brown <broonie@kernel.org>


