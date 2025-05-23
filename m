Return-Path: <linux-kselftest+bounces-33654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DBEAC266E
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 17:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AAE27B4038
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 15:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE2621FF3F;
	Fri, 23 May 2025 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVduL2Vu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F5F128819;
	Fri, 23 May 2025 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748014089; cv=none; b=QXnqvb4pfHHvhpxNyJQ6gf2w9Rx0UiBow9BdmeZgNYMDj/iZANCDT7gKCKYmrsxOMeGyXhBV7hl+LPYB/hRHsDpqcn65liF5IoCLYrzYMy3scoFAXojCgbWksv+GztU461XyyD3R5hM53VZoYlyE4Mr41zxGMfB5VPba6WhAAVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748014089; c=relaxed/simple;
	bh=CZB04wmED1JGXTOX7r3pF+DNYjq86hwdBgfs+9h9GIk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rWctnG9Nysa4ptfJWdOCUHpZf21t6s3B3CtVy62uCW6nWgkxxoktkSBp3ZI8gpsgqyxWr/mqEoy1HaEigqFfqzx5kv5rbaWML8mDfFA8Y6VyxriePiRUpJoI4GCuipum7vpM4ILkSKrGblzzziQjyxd8O4hT0pijXUbKEGqBjmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVduL2Vu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D27C4CEED;
	Fri, 23 May 2025 15:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748014089;
	bh=CZB04wmED1JGXTOX7r3pF+DNYjq86hwdBgfs+9h9GIk=;
	h=From:Subject:Date:To:Cc:From;
	b=gVduL2VuCeuf4pQxFJx0fwLrhbZUblHaB1wr5H5RoC7vPcuXx1EzDJ8TT6SnqyJKH
	 x2KDobQoJSnlbnVLcxkQCYiiMxa1NAHKRLpWk4Q5p/PAdLUYk37EEB/+KUWaTuIRvX
	 UaFSfvsU680FSqAptdMwPgVjqTjyKhRa7k/MkB5/MOqlpVyabPGpEbM+HkuOrIDk2H
	 iCw1JMREjuwBI6oPKEM0uhHpCdKsqVZm4xLQ7IPVilr/v7g/pJ641eKZzkkpU/GM7H
	 3R9MzQWylu0Js2/AwBz1BWUNWs6em9iruA8Qn6FwuLwPh6knSwq583J+24zvEm2WUK
	 /GglluzfLRVIg==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/3] kselftest/arm64: Update sve-ptrace for ABI changes
Date: Fri, 23 May 2025 16:27:11 +0100
Message-Id: <20250523-kselftest-arm64-ssve-fixups-v1-0-65069a263b21@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM+TMGgC/x3MWwqDMBBG4a3IPHfApBqKW5E+RP2jg/VCxoog7
 t3g48eBc5IiCpSq7KSIXVSWOcG8MmoHP/dg6ZLJ5rbMS/vmUfELG3RjHydXsOoODnL8V+XGfTy
 caQ2aQOmwRqTy3Ovvdd32wsvmbQAAAA==
X-Change-ID: 20250523-kselftest-arm64-ssve-fixups-b68ae61c1ebf
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=924; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CZB04wmED1JGXTOX7r3pF+DNYjq86hwdBgfs+9h9GIk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoMJQDvgIanx1caBCCr87FUvZ8dKH1eaZQMuQne
 1kZk1zR6MGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaDCUAwAKCRAk1otyXVSH
 0EibB/sEq4AqGXPx+vRbuDmgWUbOvJP+ZmmajU04uYmsaIWeVuBVVfiGUKA9Ea+S3pMTtLtC3pE
 5bTB5B85GhVFLkWQvC8rH6AySwwtp+E939MDZiSosNI2ZW+NlmHfDWdaimlUXi9t8Kr9t0dn8Re
 U7ptTiLahvAE20OIYtOVADcjoXbfuuJRZ1KGUrSTzCHB2nBXlqZAjUsV9mY3uQS4ApVKxp+Zu+I
 DDtlR8FztVlXmGnjUTYbdkDY9lhmsUq/hvH/f2nxaax6hWQA3AS6VoEo/Sm14obk4kQcrrJ5dbO
 p7llEXafVoq6n2IjamPhg6vp861w2hPfqN2BGC+vm8xvsGtS
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Mark Rutland's recent SME fixes updated the SME ABI to reject any
attempt to write FPSIMD register data via the streaming mode SVE
register set but did not update the sve-ptrace test to take account of
this, resulting in spurious failures.  Update the test for this, and
also fix another preexisting issue I noticed while looking at this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (3):
      kselftest/arm64: Fix check for setting new VLs in sve-ptrace
      kselftest/arm64: Fix test for streaming FPSIMD write in sve-ptrace
      kselftest/arm64: Specify SVE data when testing VL set in sve-ptrace

 tools/testing/selftests/arm64/fp/sve-ptrace.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)
---
base-commit: 1c1abfd151c824698830ee900cc8d9f62e9a5fbb
change-id: 20250523-kselftest-arm64-ssve-fixups-b68ae61c1ebf

Best regards,
-- 
Mark Brown <broonie@kernel.org>


