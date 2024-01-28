Return-Path: <linux-kselftest+bounces-3674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD8883F76E
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jan 2024 17:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC711C226A2
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jan 2024 16:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689856BB30;
	Sun, 28 Jan 2024 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnwGoMhL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3A66BB47;
	Sun, 28 Jan 2024 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458479; cv=none; b=DkeIa7He4VyKLbT7ac7bzQLYZjCEA5Bs3eIza8vXvcCMjQOf6jMqJj0yFmOcvfVUgV+UFbXvJjmFtliHrV8Wl3xAOnzm1sVS87JBNoQxXKLDqawbGB5f4bMtZUUHSUamLh1S0nH98uNpdAj9r2IF3pGQmRXlwFS8idACQlCH+Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458479; c=relaxed/simple;
	bh=VBn9Yltm5cfWYKt+VTGYGKZwWroFJx7UMerJX8Wpfqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UD+K05HzHFoxO/ZcpFfXu7XqjfPle+CSjeZH2O2n7EPP2A1f4xdGS/5FIfDsfavHoQwmgfKeOTr45Hd2+oc31YozJMWXdkPgcaLwQhwVn/I9X/SGx1JcODhmLdVEyeOhV5BAH+H+uGiCu1vs2eL6du97z02YiklOEFirfnvatyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnwGoMhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B72C43399;
	Sun, 28 Jan 2024 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458479;
	bh=VBn9Yltm5cfWYKt+VTGYGKZwWroFJx7UMerJX8Wpfqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WnwGoMhLoFXgUuDZh8JZt/h45uFEy26cmt4qw6NbrWfAoemi3LnqzwCbfWVSXMelr
	 vgF+QGa+4ENMSts1Btz47IFqJSo/IKO800ENkQMcgOcvwAUJAkyOMoVoLOpQqv8TmG
	 IhSOUJgj/VXD1/5vPtXMtV5thcy78b1RTZW4SrG1kL2oqDLieKeuNGMP7BkOozZn1Q
	 jK+2Ps7evVMrZ8FW0TB5WZQ8BUgbPX2AYWh8H/unt9jKX6ODdVEEu+dhJst5ncVpuv
	 BUiA12eYP6EALeXyQcLx9L///uBfqD0EWFXHsPBIu/h5T+gUQA7GvlI+gaOISO/adQ
	 yifqN0MwuL2Rw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	linux-sgx@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 07/27] selftests/sgx: Fix linker script asserts
Date: Sun, 28 Jan 2024 11:13:52 -0500
Message-ID: <20240128161424.203600-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161424.203600-1-sashal@kernel.org>
References: <20240128161424.203600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.75
Content-Transfer-Encoding: 8bit

From: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>

[ Upstream commit 9fd552ee32c6c1e27c125016b87d295bea6faea7 ]

DEFINED only considers symbols, not section names. Hence, replace the
check for .got.plt with the _GLOBAL_OFFSET_TABLE_ symbol and remove other
(non-essential) asserts.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/all/20231005153854.25566-10-jo.vanbulck%40cs.kuleuven.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/sgx/test_encl.lds | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/selftests/sgx/test_encl.lds
index a1ec64f7d91f..108bc11d1d8c 100644
--- a/tools/testing/selftests/sgx/test_encl.lds
+++ b/tools/testing/selftests/sgx/test_encl.lds
@@ -34,8 +34,4 @@ SECTIONS
 	}
 }
 
-ASSERT(!DEFINED(.altinstructions), "ALTERNATIVES are not supported in enclaves")
-ASSERT(!DEFINED(.altinstr_replacement), "ALTERNATIVES are not supported in enclaves")
-ASSERT(!DEFINED(.discard.retpoline_safe), "RETPOLINE ALTERNATIVES are not supported in enclaves")
-ASSERT(!DEFINED(.discard.nospec), "RETPOLINE ALTERNATIVES are not supported in enclaves")
-ASSERT(!DEFINED(.got.plt), "Libcalls are not supported in enclaves")
+ASSERT(!DEFINED(_GLOBAL_OFFSET_TABLE_), "Libcalls through GOT are not supported in enclaves")
-- 
2.43.0


