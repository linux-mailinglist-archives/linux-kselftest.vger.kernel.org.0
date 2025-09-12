Return-Path: <linux-kselftest+bounces-41369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7B5B54DBA
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E273E7B3D5C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 12:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214D431A064;
	Fri, 12 Sep 2025 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roZ6qjf8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BB631A05B;
	Fri, 12 Sep 2025 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679981; cv=none; b=JFASC87k19CrmvcqAK4cnzo01NqlBUqXokGLBkKY6H/WvbVfMxJNFZ25n7i1E0vC3dq/J9U/+u+apy/jBA0bOXIykkJ6AELLQH4/hXVzlzwmIusSV0LMXX7v0ZRw1hjx/L4bDPhxCpSIt+WpnHjWe93IwfXsKEzUogSYkYeNuvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679981; c=relaxed/simple;
	bh=kVAG+e2fU44cNuZ5nqAIAIWQnToJPmMLd9Q1XAIm90s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OsdEayN4t9AeLMxWD8R2TyKQIHWUrwkgBvGcFLDEg5C3Y+/U/n6VlgTYKh80qpPoeRZ/o4F+ccChcE7JPYge3beHsQMWyqQ/k3RnnO0z/8+gUsJT97infTWZUwAX5MX9n+gikzPiinUmPuA1vweRDCL+rW5iTDjiS6EFQYTMHuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roZ6qjf8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1721AC4CEF4;
	Fri, 12 Sep 2025 12:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757679980;
	bh=kVAG+e2fU44cNuZ5nqAIAIWQnToJPmMLd9Q1XAIm90s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=roZ6qjf8of+rJ8Fnd/zTGYYuoGUhSvTAnJv3Q79P/MZp0FwGH2N26s0TNjJp3sXSt
	 RRbLVk5BOdQG/00Q2znXmr53qcuMUTgqyTl5DD+9YvAfmqahX1e1M2pPLs+Ddk2tRH
	 bQNcZY6nXC1ZBkv60e0+duEWSFi74NlHYXWOtmUsrva/bUQRw3kKEiFSNbwCInbQjR
	 b3jKzHr7EJNOlQNCxRDE1I1vId/CxvrFiH9lx/oAXvo2INY9Lusg2PdFJpOqHVwVEC
	 88MslP7Z2QK8t1QoPXLM3Xyus/P/FInBUFU5AyFujCa/WToNUo7sEb0YalbZbE6ho7
	 d/BomdU/b+1Gg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 12 Sep 2025 14:25:53 +0200
Subject: [PATCH net 4/5] selftests: mptcp: print trailing bytes with od
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-net-mptcp-fix-sft-connect-v1-4-d40e77cbbf02@kernel.org>
References: <20250912-net-mptcp-fix-sft-connect-v1-0-d40e77cbbf02@kernel.org>
In-Reply-To: <20250912-net-mptcp-fix-sft-connect-v1-0-d40e77cbbf02@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1400; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=kVAG+e2fU44cNuZ5nqAIAIWQnToJPmMLd9Q1XAIm90s=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKOCMYEJ77dyX7XeE7Y/tKD2+V87wnP/KzNn2714OCLB
 eZHFNmedJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzE+x3D/4z1U1eclL7y0K3m
 1rtdJw/MlEm/cmFH/fmfbuvv/gx50mLE8E/556VukZ1uTi7Oj/nc1y58t3KXprM/W/Lz7GWf/34
 vtGUBAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This is better than printing random bytes in the terminal.

Note that Jakub suggested 'hexdump', but Mat found out this tool is not
often installed by default. 'od' can do a similar job, and it is in the
POSIX specs and available in coreutils, so it should be on more systems.

While at it, display a few more bytes, just to fill in the two lines.
And no need to display the 3rd only line showing the next number of
bytes: 0000040.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Suggested-by: Mat Martineau <martineau@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 09cd24b2ae466205dacbdf8289eb86c08534c475..d62e653d48b0f2ef7a01e289fa0be8907825667d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -384,7 +384,7 @@ mptcp_lib_make_file() {
 mptcp_lib_print_file_err() {
 	ls -l "${1}" 1>&2
 	echo "Trailing bytes are: "
-	tail -c 27 "${1}"
+	tail -c 32 "${1}" | od -x | head -n2
 }
 
 # $1: input file ; $2: output file ; $3: what kind of file

-- 
2.51.0


