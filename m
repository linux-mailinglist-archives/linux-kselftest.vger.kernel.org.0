Return-Path: <linux-kselftest+bounces-32471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0E5AAB51C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 07:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F4D3A4B2D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 05:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5926D488CD4;
	Tue,  6 May 2025 00:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izIiDLHG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF4E2F4F60;
	Mon,  5 May 2025 23:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486966; cv=none; b=UA5nrlkQzx8gssfTzJe7zY5OyuGcS5SHHfAvfqNydYTOFP/SPTQ6z1pXtNuYAX0kMB54ZTH6WAKsWF6L+U2p4C3TbXskOW7MQwwyiNxsi4lecjQAbl1pDxDz8tVJo/JhG0dcPKZGkrbzZ8KiXe5cg8YWBeMq5+z7QunnR7uv+QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486966; c=relaxed/simple;
	bh=6nilLHw0VgDiTs0EsmbNUNsBYV4knhCYP34x5LqIndU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A1Izu8cTaiGHdgQ0aLCcSdfFs2vM9eXlUtD4bpbp/SRA2qMw6mehzo7P3jhviHTmxIMXakAMlLG/K+kbXInmQfNURttwDZKE+iCbKIa2JisnW2mHBzsjVxu+57Rq5bEZygq6UgLK/H7LX/fAARCkm7kzg3eQlG8nF6rW1A/+cxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izIiDLHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12741C4CEED;
	Mon,  5 May 2025 23:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486965;
	bh=6nilLHw0VgDiTs0EsmbNUNsBYV4knhCYP34x5LqIndU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=izIiDLHGviDlBYRW+Ami/Cd9qglwz1YPjR1p6Y16uftkSSkh/EvgGTO/BwakmXDHl
	 s+JnxhPJ3F5LS5uRtiXqVXqXASi4+xmmWG8noVp0ikpizJpnkXvGlwDySnjrWSPSWV
	 FUZcYKfR14RSBLjrtWAzAiXcK0WO8ID3sU4yQ5Ty/Vo5FmE+blzHqxjtvdY+2NmYzm
	 qrBSRfDh+luhPDesCPNP9p0TqFA29t7fpqwBgceWwACPq5Xdc0wx21QxxY0hrWxbiJ
	 uGp1ReuoYcC0atrk1x9ZWg1JnsVwA5sljB2Laa7hWLz9uvpKhd05mpy4AdfmUuHscS
	 lL2Bn+M3XKzHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kevin Krakauer <krakauer@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 083/153] selftests/net: have `gro.sh -t` return a correct exit code
Date: Mon,  5 May 2025 19:12:10 -0400
Message-Id: <20250505231320.2695319-83-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: Kevin Krakauer <krakauer@google.com>

[ Upstream commit 784e6abd99f24024a8998b5916795f0bec9d2fd9 ]

Modify gro.sh to return a useful exit code when the -t flag is used. It
formerly returned 0 no matter what.

Tested: Ran `gro.sh -t large` and verified that test failures return 1.
Signed-off-by: Kevin Krakauer <krakauer@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20250226192725.621969-2-krakauer@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/gro.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
index 342ad27f631b1..e771f5f7faa26 100755
--- a/tools/testing/selftests/net/gro.sh
+++ b/tools/testing/selftests/net/gro.sh
@@ -95,5 +95,6 @@ trap cleanup EXIT
 if [[ "${test}" == "all" ]]; then
   run_all_tests
 else
-  run_test "${proto}" "${test}"
+  exit_code=$(run_test "${proto}" "${test}")
+  exit $exit_code
 fi;
-- 
2.39.5


