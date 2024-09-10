Return-Path: <linux-kselftest+bounces-17648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EAA974307
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 21:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E880C1C25A6C
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 19:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AA71AAE1C;
	Tue, 10 Sep 2024 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0TJkimY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078BD1AAE13;
	Tue, 10 Sep 2024 19:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995224; cv=none; b=W4v0lwwRob1y7XR9Z1ptHsjmoP8Fcl5PIxRzdy/WKt2Jz4ej7JpY1+Yu4c6okmDGOpH5Xrz0bFuWrvQ6qzbf9kiCsvNE/n45XN6eFcbARxKBj3YvQJ6xyVIrDpLYkeA7I06DW7hk2C101KRl6I4rS+RaDSMfRkf6pQJkS/faySU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995224; c=relaxed/simple;
	bh=QgKZMPlAiI7k1oZ5ezpnNYoN7ULwe/z2ApzxqxNf/0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eEbeOuiv9hlLD8e8vkEheLN+kXdxfgqu5h6Fxew9TVJ/ma9KI+E2uTvNJP4UPw381f4e6UulbznxoczctoqTQfquDv8EqOp02M3Ldw6c6rK10bzQU7HSlEF4LfnR97JV1CACRCIkTKFLimNNgkp7gQZ2Z71WMIb/N07P9E5C3nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0TJkimY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086ECC4CECE;
	Tue, 10 Sep 2024 19:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725995223;
	bh=QgKZMPlAiI7k1oZ5ezpnNYoN7ULwe/z2ApzxqxNf/0k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h0TJkimYyhkgI5uiNOOHMNJTpCPU+bFSyY/4StX3MGFxwIbYN/AGKeV/ZzfOYywHs
	 mXHc2HqWE+dTkfcYWPsS5Dtg+shcmJo9gHglx+AZzeWTHccK+1E0J4omUntiwChAX3
	 dUsysIHD54Ut2OlIrzcrnqUIPBzG5bAECtb8e6In7/dtDQzLhMUIdhBf1wR/PUosA1
	 uUb0xQIqJr6cnasoEVBDHRnu7yXaqK103zWV1DxNnW8vt7ZApXso7YSAON02xHL+H/
	 z4EmJu8pvfoHECMGx9EZtIJuSguMS5cuD2P8PdxyqdTydEF+pvXF/pcnuTHsxkTxe/
	 gsQ/1jIyo5mnw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 10 Sep 2024 21:06:36 +0200
Subject: [PATCH net 1/3] selftests: mptcp: join: restrict fullmesh endp on
 1st sf
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-net-selftests-mptcp-fix-install-v1-1-8f124aa9156d@kernel.org>
References: <20240910-net-selftests-mptcp-fix-install-v1-0-8f124aa9156d@kernel.org>
In-Reply-To: <20240910-net-selftests-mptcp-fix-install-v1-0-8f124aa9156d@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1738; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QgKZMPlAiI7k1oZ5ezpnNYoN7ULwe/z2ApzxqxNf/0k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm4JjRuPiBmqQot2XLTpRTMWhZfHmFpzO1y02Wl
 aCc7IshYiyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZuCY0QAKCRD2t4JPQmmg
 c2XQD/0aHs+MCJEqg8v/bc77WNcibzjhtfoMGZ8abK9s/afUxzbz96vhN7cXXEVb/lpIFqr440R
 b7A9IfNNkqHpfb0lMfVu5dppXr1AGa23sqywOXLNdxsoDzkSe+4DJUODPxcy5774eEYRCHitikX
 sK36dwZ0/CfJ8I6KBd8Vyv9euSE9hnthfjK6cx97rFdMHMNo6VD5nuTOhs+qYAby3h/YOuADfEt
 RFrVCJ/Ol8wL9XOk2jPKj/kIQCTKKhsL7J3fR+t3hflJKQR79VZx3NOzVlELSBF2wyHxOyBJB4G
 zCMsGQfhh38Gy2QzKJCftPAlhnNhkGcK1xzxVN50Y3i12w+u1itCDLMEN9actcL9EQLRgEPjFKr
 kjh5rEzKlOs6XH+cb0KbA3I/H2rUUqkBs3V36tFnJRjBmmme0FWQ7LO9qmodQyS8An0GpK6c9Gv
 SDnZs8QrEIhUw27y0K46IGkpidDThJ9aaJ/hoviNLH8RDrb0sOEU410I8F/970BjozcM9P6uaax
 tPB060csTgsORANAy4VMEHpG+HC5ufvcOWvKrTv1CdPQbPXDhjhU2BDWhTVp4CqT666bQ7GIhky
 M1ro2FfEsinHSGAz/om5A4uGuu8QxYJZAjGDgLgIpvauzHwr8F3m2SpCNyvstEvioMCf0KTCcKH
 s9YoPlXmyv4bv2Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A new endpoint using the IP of the initial subflow has been recently
added to increase the code coverage. But it breaks the test when using
old kernels not having commit 86e39e04482b ("mptcp: keep track of local
endpoint still available for each msk"), e.g. on v5.15.

Similar to commit d4c81bbb8600 ("selftests: mptcp: join: support local
endpoint being tracked or not"), it is possible to add the new endpoint
conditionally, by checking if "mptcp_pm_subflow_check_next" is present
in kallsyms: this is not directly linked to the commit introducing this
symbol but for the parent one which is linked anyway. So we can know in
advance what will be the expected behaviour, and add the new endpoint
only when it makes sense to do so.

Fixes: 4878f9f8421f ("selftests: mptcp: join: validate fullmesh endp on 1st sf")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a4762c49a878..cde041c93906 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3064,7 +3064,9 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,fullmesh
+		if mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
+			pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,fullmesh
+		fi
 		fullmesh=1 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3

-- 
2.45.2


