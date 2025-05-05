Return-Path: <linux-kselftest+bounces-32454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E35D1AAAC1A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 04:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540491889D89
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 02:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14632FB451;
	Mon,  5 May 2025 23:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qD8T+Bs9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B766F2EEBEC;
	Mon,  5 May 2025 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486608; cv=none; b=klDJo9YlKdSq2OseXB+tOYVkIsVdxKgLu3NakW0Lqe2nWV9Dl6eE5jdBoHwbGV3rZ3ev9PXF1xGj73n0YHn+sBgpZKpmYZdiI3OWTaCrjQu3B2QCGXKvYCz/UPX02NwZPDLKKeUzLYbxJmbYm5pDZMvz5Yt1a2HuToKAamBm3Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486608; c=relaxed/simple;
	bh=6nilLHw0VgDiTs0EsmbNUNsBYV4knhCYP34x5LqIndU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ul4xQBL3toBfTam3irTrAeVJm3HhENcpBSeEJi3kspNG4YL1hI67Dscn9ZRAWJSFnP1TRzssP4E41qWV0FxCl7K4qB8XP24dldN5/VdHwNQcpax3Guxfgq58Tphde7r/euKw8JPfsS/CpkbW9qeb15wDovRVtPiDTwr5xbaAhlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qD8T+Bs9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED5DC4CEEE;
	Mon,  5 May 2025 23:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486607;
	bh=6nilLHw0VgDiTs0EsmbNUNsBYV4knhCYP34x5LqIndU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qD8T+Bs9MrzhlMi/Zp7AtwJjAbYo1HDSOvV6xO/Ibvad2DkeGdOgFYU4RvhvLHiUb
	 02KsdtMi4Ilp0bXGUIoAXuM+ZE+mZZaFYlj6WyeWYzbUN3QZxwGfHnOuwEcaPE5qkv
	 QNDDbxSEPxXBylVE1Ruft3kNTcO+EFzbtHBq8CKoqNq4QV3LJOdbUQtRE1oKftuKUJ
	 3UrI4dOFHFmU26OKCMORrRskvSn6LrKCkNP1krM8xEZ+QRy/+VzlV3LmKVjf3uA+0Y
	 /6w+drLPkoyPHx5feeiWqiICksIbTGYaQ83CFq4OZuTWd0T0cTgZBVC34T/CzplXRh
	 ckS1yHH5chpow==
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
Subject: [PATCH AUTOSEL 6.1 115/212] selftests/net: have `gro.sh -t` return a correct exit code
Date: Mon,  5 May 2025 19:04:47 -0400
Message-Id: <20250505230624.2692522-115-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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


