Return-Path: <linux-kselftest+bounces-7902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538508A3A33
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 03:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B34FDB2114A
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 01:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3314A10A19;
	Sat, 13 Apr 2024 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxwhhqGk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E049450;
	Sat, 13 Apr 2024 01:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712972585; cv=none; b=dhyxO3qJgnVQVFnMV1B/5LxP5ZJEgEVR2F6kYAkxVXCH4IZL3CWqdWyHx37+1l9SCxtHZPzHiQD8nQKvdjXFhJIqKjeZwnvTjalMNb+g96uwC6Yb2aiPHRcMYytTHBAx6ATvw+7bUvty/UXszHK+K9yrCYhDfQa98974guZErcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712972585; c=relaxed/simple;
	bh=0YWscSSm7l0v4qjTRd8h1MMOmKsL+vK8TQNftfhtfH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GUyvnEGhrlJUz0hsafcdFVrOYjjqXQ32BsP2FjxqFjcw/AOwCtFgaVBDuYLDHGn4eVTQKIAEcb8JVq+iNDqQdO5kcPhi2km8IcM1BrLzGUpIjP0oH/1/RClmDpnKw56it1YHIVVgkJg0k9pp8ntNeOPPh64dsW7G5IY8q1UHGM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxwhhqGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74573C4AF07;
	Sat, 13 Apr 2024 01:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712972584;
	bh=0YWscSSm7l0v4qjTRd8h1MMOmKsL+vK8TQNftfhtfH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sxwhhqGkB0GNDbvsQ90NrqhMJydecf3E700VIoqU8dT+JQyB2+Rai4TqNZEHTmSWT
	 D3MKXxHrzKhseVEywetQTtHXcEj5Q7zkWiidA0qLTLdjmrzCv5wbE0YjqOwC9pLqXj
	 bpNdKLO+yg5vV1RGxyZPUioGR8vM9dz1e1BOwC13o9wdHRRt0Pjgr7xzWxeP4h+6Mh
	 ohjShaMivVL9L0l28IxFhnjJM+oc9N7SGQCu++KJC9Hb8w0cv/Ye3rRrnBC5Sd4gmU
	 91UD9cjILn9TFWVmG118cg8tWHOvLFO7gWfDHPoMWn7oSZl7/8YtVEhGzU2/vHppUp
	 20RxRYqhkSnsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CB0C04FF8;
	Sat, 13 Apr 2024 01:43:04 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Sat, 13 Apr 2024 02:42:54 +0100
Subject: [PATCH net 3/4] selftests/tcp_ao: Fix fscanf() call for
 format-security
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240413-tcp-ao-selftests-fixes-v1-3-f9c41c96949d@gmail.com>
References: <20240413-tcp-ao-selftests-fixes-v1-0-f9c41c96949d@gmail.com>
In-Reply-To: <20240413-tcp-ao-selftests-fixes-v1-0-f9c41c96949d@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712972582; l=1369;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=8QLIHbMoN2Kwyajab0w/1qWe3pRkg64mhy39Rmm7dW4=;
 b=E+Tm/hDau67ueNTODWxl1Xainp4x+/2jO0SZqndJTzxr2VvGLnENcbzY/loJ0nCmerjr1CVsT0A+
 bgy+z5hHAMtNEGPNhInjRYw45a9tupTNZ83cWzf41CbwVWFNmK7m
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

On my new laptop with packages from nixos-unstable, gcc 12.3.0 produces:
> lib/proc.c: In function ‘netstat_read_type’:
> lib/proc.c:89:9: error: format not a string literal and no format arguments [-Werror=format-security]
>    89 |         if (fscanf(fnetstat, type->header_name) == EOF)
>       |         ^~
> cc1: some warnings being treated as errors

Here the selftests lib parses header name, while expectes non-space word
ending with a column.

Fixes: cfbab37b3da0 ("selftests/net: Add TCP-AO library")
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/lib/proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tcp_ao/lib/proc.c b/tools/testing/selftests/net/tcp_ao/lib/proc.c
index 2fb6dd8adba6..8b984fa04286 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/proc.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/proc.c
@@ -86,7 +86,7 @@ static void netstat_read_type(FILE *fnetstat, struct netstat **dest, char *line)
 
 	pos = strchr(line, ' ') + 1;
 
-	if (fscanf(fnetstat, type->header_name) == EOF)
+	if (fscanf(fnetstat, "%[^ :]", type->header_name) == EOF)
 		test_error("fscanf(%s)", type->header_name);
 	if (fread(&tmp, 1, 1, fnetstat) != 1 || tmp != ':')
 		test_error("Unexpected netstat format (%c)", tmp);

-- 
2.42.0



