Return-Path: <linux-kselftest+bounces-24495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A87DEA10F34
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 19:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E232D188B720
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 18:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F181D20D507;
	Tue, 14 Jan 2025 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XymEbIfq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEBA20CCC2;
	Tue, 14 Jan 2025 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877804; cv=none; b=BfnrP4vTKCJ7Ax/+u0q07XASRQqM6gCROqdR4tGEfQ6lMPAlPO5gDYiSVZDRGWjVuLz79gp6QD7vylpWJm5Z1zudYGcSLUcCxAWBqUcMJLZB9aE/MW9N/KEUwzXN4WUT67srPlGBMRZ7yLW+mXCilLCdrTMSJzhfkYb87mbdhVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877804; c=relaxed/simple;
	bh=1Vx6MDob7DYZ0cYhjz+3te+cEC2Fukkfaa1zFfoLMDE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CFvu2u4Tp6Sx2v8lweo3hac0mICcCsbGlwoF+0A/gVxL22vJjFHZ8dk+3DvTZSuiYzafR/4ydYJWeytJJuT5rShPQhXypXWlNo6HYq2Q/ZwMjc2U9wU6wFyGAkn+SHuGeokW6vwB/sdYs/FbJ3Fam+Gw9ZXQvkVEJV59DtCrglw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XymEbIfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A058C4CEDD;
	Tue, 14 Jan 2025 18:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736877804;
	bh=1Vx6MDob7DYZ0cYhjz+3te+cEC2Fukkfaa1zFfoLMDE=;
	h=From:Subject:Date:To:Cc:From;
	b=XymEbIfqgixbf8aS9k+1ttVB6CvnrQF4azha8iCptATWYrbeaG90Dv6eA1mKLADmt
	 JbsPRwyJErUhdgEHybfW8y6godYPENZgCunjMjyObEc5xw7xxabN7v+DJ239vuKLKx
	 J038TBaRzeaf3aVCOzMxMwuOnPxy5NTNq7SG2bjE96m7245gMAsjEQ9kbSSkdrFQWH
	 2koT1XlKzL5bPtUoyXKMnCGLk/cTWMWlBmVHIOWGQeIuX8ElgMsFIPvFT4WZNSCPJ/
	 ZLF9MenIYhF1ySoAJMAYkimyN5X9oe6niVh0Y6nhEdYfl4NzoWRxPp40PcwArcZ8CT
	 e2qM8CLHaU3hQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/6] mptcp: selftests: more debug in case of
 errors
Date: Tue, 14 Jan 2025 19:03:10 +0100
Message-Id: <20250114-net-next-mptcp-st-more-debug-err-v1-0-2ffb16a6cf35@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN6mhmcC/zWNsQrDMAxEfyVorsBKmqW/Ujq4yTnVUMfIbgmE/
 HtEocPBveHd7VRhikq3bifDV6uu2UEuHU2vmBewzs7Uh34MIlfOaJ6t8bu0qXD1shp4xvOzMMx
 4SEOSGGWMEshniiHp9ru409+mx3GcAApNQ3wAAAA=
X-Change-ID: 20250114-net-next-mptcp-st-more-debug-err-3f3f1aa15a10
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1521; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1Vx6MDob7DYZ0cYhjz+3te+cEC2Fukkfaa1zFfoLMDE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnhqboEWD42bX/epxILilDBKHu3xMoh5VocUrOy
 Cg+67+WQa6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4am6AAKCRD2t4JPQmmg
 c944D/9xP4y9lK1kwrhR1FmweCzgSRXl1LKSCx9xXpP/FDtLLzdo205/rFizMLFW7lv2/Pp1Upi
 q0jdOGUUgcltJHvoRil14tXHKiw4yGuewFIduCvqZBPr5RwqvXYMy196XwKzMKQat6hu59T61n8
 FfiWpCE5jeSUCghO93SqLnKKeHf1lhQ0cgeo1wni1Al5X+AE7QLfyFWOK0YcjdoVVwwWVbG045I
 35/18ZLbrXFFB6zOxODh3MGgef1kGPs7y1NI/7q/X9rAkbIOEIFKHTOvotkWPg40pLtAyPSQAdT
 lIYgAKieN01AijVPsYVbaaH23bkXjKJ57wwIrG6Oq9yrVoOOFv0rP9IMAO9fKkLpzZljsrluR6j
 cKr+aYhf/tIh895wF7wB4iTTnQLD0Xv+gxs5W+KYmkmqgVLF0XA6J3u8GEePkKmi0zCy5WM8IL8
 qnax36Kr7+e+tVaRJilwKH2oyJzNljX85vm8/3GjwFFB3rF1uak2v7q+QB7YHTgG45+LgWBlZqy
 x5L2dUU3kygojQBlYDabRdJNxWtn4lai0c8A0TSxpnxdbDsIP4U3lHTaczzhxd8xcFxoHA6eIdB
 85cQSemozPEkqEG9WkRopSO5GFAZMpt1U+xHxAwrudhjbSqC1Sn+N0F//oF4/zwtFX3jH49Km2s
 6/YGoJrKS1OPsMA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are just a bunch of small improvements for the MPTCP selftests:

Patch 1: Unify errors messages in simult_flows: print MIB and 'ss -Me'.

Patch 2: Unify errors messages in sockopt: print MIB.

Patch 3: Move common code to print debug info to mptcp_lib.sh.

Patch 4: Use 'ss' with '-m' in case of errors.

Patch 5: Remove an unused variable.

Patch 6: Print only the size instead of size + filename again.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (1):
      selftests: mptcp: sockopt: save nstat infos

Matthieu Baerts (NGI0) (5):
      selftests: mptcp: simult_flows: unify errors msgs
      selftests: mptcp: move stats info in case of errors to lib.sh
      selftests: mptcp: add -m with ss in case of errors
      selftests: mptcp: connect: remove unused variable
      selftests: mptcp: connect: better display the files size

 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 13 ++++---------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  9 ++-------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 21 +++++++++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 17 ++++++++++++-----
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 21 ++++++++++++++-------
 5 files changed, 53 insertions(+), 28 deletions(-)
---
base-commit: 9c7ad35632297edc08d0f2c7b599137e9fb5f9ff
change-id: 20250114-net-next-mptcp-st-more-debug-err-3f3f1aa15a10

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


