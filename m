Return-Path: <linux-kselftest+bounces-3675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2756B83F7B4
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jan 2024 17:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7971C22B78
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jan 2024 16:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E995A12C53D;
	Sun, 28 Jan 2024 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mc8WS3yJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE7D12C536;
	Sun, 28 Jan 2024 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458535; cv=none; b=uxE+t8cFtpeZXhxNIidlJlsaUF3NGit9VvG6iMQTEEoWhXvaecM6iK5RMdvGkKozbyL4k0tvPXZS38ATkHEm2bWlSkZnGmMwEvFovNP7a5DjuUtLBJ1fzE0lXhQuymG9pj68AhkfVV5Ny5eLiiQiBxnVSBkMubqjpfFJa73zAOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458535; c=relaxed/simple;
	bh=VBn9Yltm5cfWYKt+VTGYGKZwWroFJx7UMerJX8Wpfqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQEvJKAQcUq6kU7eejecw9u7T6nINsV7tSuLNmLTDNLZfPgOw7OPYT/htduoOuA3TcpGViXNYB74Gww/XKzYDPhDdRmp/xvueghQu4uKWYQub+G+fUyMHtekYs5+UQdGQYgHD9xlt6O9r8BBOMjrkHZtS4/eGNrtXvWExBkrMG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mc8WS3yJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD13C43394;
	Sun, 28 Jan 2024 16:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458535;
	bh=VBn9Yltm5cfWYKt+VTGYGKZwWroFJx7UMerJX8Wpfqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mc8WS3yJ8lFrfDCahmNfXvWfwZo1EnSv/MGItiTsVtV3eDNC6vhQ0CTJncpWa+QZj
	 T4zRJaqyI0zizsW86OEdmg+X8I62ImJkElVMVEYG2sdLSYQlMPa8ryK3Meb7rfxROW
	 3zqVxSefGlU7n6NP39+PC6JasVK/0vuQVQcvTwMYJoqxzZ+VLlRP8UCDkXGxP9KhUA
	 5t5ekvrvaFVk7k/FsQwAvbEybizRIdrCGFQKmX9Km/4EddAS/YYWA6+eA6SdqQaz0O
	 ZZt5uYWRr4fSx8JHfLwiK+FtIAMgMh0wSVqpUoX0oJKJNjoJKkkQqoA1EY74qn0clf
	 2X5jBdxfLmINw==
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
Subject: [PATCH AUTOSEL 5.15 06/19] selftests/sgx: Fix linker script asserts
Date: Sun, 28 Jan 2024 11:15:03 -0500
Message-ID: <20240128161524.204182-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161524.204182-1-sashal@kernel.org>
References: <20240128161524.204182-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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


