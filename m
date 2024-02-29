Return-Path: <linux-kselftest+bounces-5574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F9686BDCB
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 02:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C792815A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 01:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041253DB89;
	Thu, 29 Feb 2024 00:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9OMXeV6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0B03D0BE;
	Thu, 29 Feb 2024 00:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168372; cv=none; b=DjEKXjUUVJH9Mg9keoK2khM62cSzMHtWccgB0cYzwRJgD3HATVDQBE6fRHXlgbd1WYyubUbP96yFKBJGMcavm4Gehx7tdvNPRtC4KGUDZZAIjG104W4OskCHoSUjbu1KFom3YoZBW6aSyDMGy9u3rHqDh8FCR/mQ9U+UMWKOoPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168372; c=relaxed/simple;
	bh=NmuieFZoScnkuFnA/13Z3/d13a37ja5rWHwFFbZTMHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfThPJc/IUjBzlXO7jPnmffaibe6OwiwF+39XmgHbJXypx9Bx6Bpa8AJwUrx/kh+f6LmKveDgxoXR2S2ot9jPL2IHLE7beH9AKuWXL9/jUcT5qWgriglKORDjBVceywmV84lidsOHeaMpQ1EjYcMi+HkvdzEEO2q79njnX/i5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9OMXeV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BC9C433F1;
	Thu, 29 Feb 2024 00:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709168372;
	bh=NmuieFZoScnkuFnA/13Z3/d13a37ja5rWHwFFbZTMHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d9OMXeV6MiN8yIbDvSozoyam2NDP9HF5K2VSaFn/BPrCP+qdNXaEBRSK2qW+KdJPB
	 7IJJ9JSDaR40NpRlE+iyq9tk8HT6CIW/Q6fXj0vDNk1w8DuuxG+AdDDse+gZe6I7DA
	 OzDbeuWb0DGjvLX87VORVTfSGPvAuqa4I7SU0AjfPIl2Jxz57BvfIbqmI1FwCDEHSa
	 2nf4AJwPv7GgdDDqdRxdc7m3wTFsKjkgekZuMKkxfkbKba7DfT8wv/2WRTQ55D0SUa
	 Hp5Nsbcn0G/iwAn31DCmezwf0UpVAH2Oc/vdgkyr3eU3YSamUzcjuSTBrM3SnBXvQu
	 ZZqVJqwIT/IUw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	mic@digikod.net,
	linux-security-module@vger.kernel.org,
	keescook@chromium.org,
	jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v4 09/12] selftests: kselftest_harness: separate diagnostic message with # in ksft_test_result_code()
Date: Wed, 28 Feb 2024 16:59:16 -0800
Message-ID: <20240229005920.2407409-10-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240229005920.2407409-1-kuba@kernel.org>
References: <20240229005920.2407409-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the spec we should always print a # if we add
a diagnostic message. Having the caller pass in the new line
as part of diagnostic message makes handling this a bit
counter-intuitive, so append the new line in the helper.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/kselftest.h         | 5 +++++
 tools/testing/selftests/kselftest_harness.h | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 25e29626566e..541bf192e30e 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -287,10 +287,15 @@ void ksft_test_result_code(int exit_code, const char *test_name,
 		break;
 	}
 
+	/* Docs seem to call for double space if directive is absent */
+	if (!directive[0] && msg[0])
+		directive = " #  ";
+
 	va_start(args, msg);
 	printf("%s %u %s%s", tap_code, ksft_test_num(), test_name, directive);
 	errno = saved_errno;
 	vprintf(msg, args);
+	printf("\n");
 	va_end(args);
 }
 
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 82377051aa54..5b0592e4b7a4 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1148,7 +1148,7 @@ void __run_test(struct __fixture_metadata *f,
 
 	if (t->exit_code == KSFT_SKIP)
 		ksft_test_result_code(t->exit_code, test_name,
-				      "%s\n", diagnostic);
+				      "%s", diagnostic);
 	else
 		ksft_test_result(__test_passed(t), "%s\n", test_name);
 }
-- 
2.43.2


