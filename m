Return-Path: <linux-kselftest+bounces-34482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82137AD225F
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 17:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5FB3A554C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 15:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED97A1A2C0B;
	Mon,  9 Jun 2025 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5FjUSfb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35BD14B959;
	Mon,  9 Jun 2025 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749482746; cv=none; b=ZJKoL2S0npGBY/W4IwWEbKX+nUayS+GBtocZmG32pRspPcFM4GHaGUpT8ZUS7V7nxfqPoANIrzYVYuUmZlZQwdeCrSyqJUJ2aMx6LlQW3RF3l/rxKpD1l3klYKAffb8Ob1qm9Hsk+N9ipV9hvz1VlLEZbxyBUm0Gz1W58f32oDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749482746; c=relaxed/simple;
	bh=xz9CPiZmvA8I8vw1xhCyJX7ftts3Lo/ky6cOBWw1JG8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Bjcz/ykgYKB2o7kZpSUOClks8iVauhYIEJuXc33+Won1LxUKf4NETSBcXm+0TbLB9g9RVT4coX1XOGPwa5NPmgNwgj5GLfUOECTPYI0qYAK5SdQrcAL4aT2YHPoGIzdfKqQD6M+FWrLGWkHvMuQbpdpPXxXlQ6URS/Swnh8hfms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5FjUSfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3CCC4CEEB;
	Mon,  9 Jun 2025 15:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749482746;
	bh=xz9CPiZmvA8I8vw1xhCyJX7ftts3Lo/ky6cOBWw1JG8=;
	h=From:Subject:Date:To:Cc:From;
	b=K5FjUSfb1thiOodOF9NycyduKWR47tjHemh3DAw9CskE769QGS/Or9pzcS6x4v7IA
	 xUG73ZP4CzgHAGjNceibEDgw2c8QKfj1cEmP1Pdd7mKsy3X80VCPNB4oBKjLtyCw9g
	 zA1Ru7jotPIi6pV/k31uRMkrM8Muq+AvoHPq3mAk8io7PpLR+juSbAUhB9F/M4Tlp9
	 MTXpkCNups0HN6nZJ9Wvxk/csQ7CSrKQSL6y2NkLnXl98baFG93QqWy6yoiagwZe46
	 z/groHOotpgHqDtS9/IFv1ihqu8FtIi8mr69/kML7DIvEtJhfNQg31j5Uae1sQeQK3
	 t5Zdy5167fNHQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/3] kselftest/arm64: Update sve-ptrace for ABI changes
Date: Mon, 09 Jun 2025 16:25:30 +0100
Message-Id: <20250609-kselftest-arm64-ssve-fixups-v2-0-998fcfa6f240@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOr8RmgC/42NQQ6CMBBFr0Jm7Zi2SKOuvIdh0eIADQhkBhsN6
 d2tnMDlez95fwMhDiRwLTZgikHCPGUwhwKa3k0dYXhkBqNMpSpT4iA0tivJio6f9oQikbAN79c
 i6O3ZkdWNJt9CLixMednr9zpzH2Sd+bOfRf2z/3WjRoW2UvbijC290beBeKLxOHMHdUrpC14Bj
 NLHAAAA
X-Change-ID: 20250523-kselftest-arm64-ssve-fixups-b68ae61c1ebf
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Dev Jain <dev.jain@arm.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113; i=broonie@kernel.org;
 h=from:subject:message-id; bh=xz9CPiZmvA8I8vw1xhCyJX7ftts3Lo/ky6cOBWw1JG8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoRvz1PNjLG9/4JVU/f4+EONfW3WtjK/XEE/YmQxXp
 VfdK3xiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaEb89QAKCRAk1otyXVSH0BqBB/
 9y3CtGDVizHftAeftbEKjeJcVJZ4SSroJ159RfgjeiDtUIRyWMe3dqj/7QACsQp4lfp9YxzALOkNGC
 cwQ9GDpxsp3gLTQPChH2joHaCMjo6OCQz09hppb7zsLRncsSLgS8tsCp3Xj1qOOJ24vOJsR8FnkpOA
 i2sMsNZFpv5RahaV9iUMov5lx51IDr5Bwn2aZ+ZaxJGcX2ENwaPzAgQjI2ep5EgYfGlfCcFh0OEqgf
 SCIXSTzq5Hg8hja5wd/T27XUtDoXjF3XR+sJD7QyYl9FLkF07zwjwD1KwJJMoj4m/svlQoIpy8m60Q
 rgCS0OzdTMLSptOnBY//sRYpzwlsIM
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Mark Rutland's recent SME fixes updated the SME ABI to reject any
attempt to write FPSIMD register data via the streaming mode SVE
register set but did not update the sve-ptrace test to take account of
this, resulting in spurious failures.  Update the test for this, and
also fix another preexisting issue I noticed while looking at this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Rebase onto v6.16-rc1.
- Update fixes tag for patch 1.
- Link to v1: https://lore.kernel.org/r/20250523-kselftest-arm64-ssve-fixups-v1-0-65069a263b21@kernel.org

---
Mark Brown (3):
      kselftest/arm64: Fix check for setting new VLs in sve-ptrace
      kselftest/arm64: Fix test for streaming FPSIMD write in sve-ptrace
      kselftest/arm64: Specify SVE data when testing VL set in sve-ptrace

 tools/testing/selftests/arm64/fp/sve-ptrace.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250523-kselftest-arm64-ssve-fixups-b68ae61c1ebf

Best regards,
-- 
Mark Brown <broonie@kernel.org>


