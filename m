Return-Path: <linux-kselftest+bounces-4447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C1C84F7A5
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216472816CA
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CCE76030;
	Fri,  9 Feb 2024 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2rxUTox"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7C674E36;
	Fri,  9 Feb 2024 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489147; cv=none; b=oVe24WCB1EF3koGYqrSYwaYmVvnpuENXiPfq7QL1KEJqM5CYrGZ0SEf4kNuEG5jBYMIh6hRGKtsBnvyc85tv9Fo7HrGHpNV+8XfcdeNWEBquDmOm5Jn+bWrrxUtB/6SuU8MDK2cU1jLXjYl01u8m2lL25O16iN/ij+cL1c9axQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489147; c=relaxed/simple;
	bh=z/myf+v/1y1qIOHpJpehIboeoya05bejTBt1ojDoHsQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l1TmiI0V45ttiVAObsjUD0D2eQyFoDs3khJq7KZdziobvqNaGdUsKasA7mHaJeMffd8gSFyv3PCqgDPK8+4IK2oDd8TKAndQh4FiGgnweLmULsbqy8jjSQf0/XNHo9CEMwDIIaQkghOBgHrU+7A2/nA/ZPaNcXibFSjwG4jmCsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2rxUTox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105BDC433F1;
	Fri,  9 Feb 2024 14:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707489146;
	bh=z/myf+v/1y1qIOHpJpehIboeoya05bejTBt1ojDoHsQ=;
	h=From:Subject:Date:To:Cc:From;
	b=H2rxUToxeSBGn+kEPoVOE5feiJRSrE4z9O8q5FRA0ANxmuzpghdukTdfFW7XI5SK8
	 jNzeSBg5TmQt7t6RwgCJfLfBoUMMblT1mhYFd5QWKY8Ep3ncmezD8bdLroMJearjx9
	 ZVuPdeSv8v2R0Avumy9+WKQGJ2EweG78Kk5/7HdLQyQsosMErykRaHhN8CEVGcNNXS
	 77AHQulyRHlJ3BKoDHJEzOI4Uz4nU/AQn2pjWxXNekbr7wg1VLOgMw7foI6U4+hUv/
	 EsRNn46L1yzDpi4pUu0fljn+fDZ8Gzjk8QpPkF11fRrLvXkAagO0oPUMdLfxHxWffk
	 Nsi4NaVxf9yRw==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] selftests/mm: Output cleanups for the compaction test
Date: Fri, 09 Feb 2024 14:30:02 +0000
Message-Id: <20240209-kselftest-mm-cleanup-v1-0-a3c0386496b5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOo2xmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwML3ezi1Jy0ktTiEt3cXN3knNTEvNICXWOD1JQUo1RTM/PkJCWg1oK
 i1LTMCrCx0bG1tQBA4O+fZgAAAA==
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 Ryan Roberts <Ryan.Roberts@arm.com>, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=628; i=broonie@kernel.org;
 h=from:subject:message-id; bh=z/myf+v/1y1qIOHpJpehIboeoya05bejTBt1ojDoHsQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlxjd1Y/cl/Jjs1IsHJQZKUCPu62BRt5V6rqVoq
 YhGItbRB3qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZcY3dQAKCRAk1otyXVSH
 0PlOB/wK/gIKAIzkBaIYeu4hGCconShTBMFnfJFUMsqm42YyhqMiv3DalLV4xx5uVqOSZeFHwVy
 S7hY6c/oZm3Iwrm6KUTsl++Moeo/PXaXKvXt+M0B/td7IFPWkkiGGVpqxRuSNY3zGRH8IEEe2H3
 MyKTUtODpKSXqg2d1BPOFPJ0aSuyPNntp0xfZLhErKHCxwI0FA62peidhxsKbW1t1Z//kI91N4v
 bNP82/5h+aV+Aau3kGh9jvsMXALRAq7eqW7j0RbVXuKH1LLshyfy0ikTGZ5cCxHb7MT6zYnkQKM
 Z+/el8bBOewMP69eAH/rXwtX9bWlUiNBqHRo671c+U7fweFO
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

A couple of small updates for the check_compaction selftest which make
it play more nicely with test automation systems.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      selftests/mm: Log skipped compaction test as a skip
      selftests/mm: Log a consistent test name for check_compaction

 tools/testing/selftests/mm/compaction_test.c | 37 +++++++++++++++-------------
 1 file changed, 20 insertions(+), 17 deletions(-)
---
base-commit: b1d3a0e70c3881d2f8cf6692ccf7c2a4fb2d030d
change-id: 20240208-kselftest-mm-cleanup-30edd2e567cb

Best regards,
-- 
Mark Brown <broonie@kernel.org>


