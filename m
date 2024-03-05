Return-Path: <linux-kselftest+bounces-5908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD37871C19
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 11:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8823CB20A6B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 10:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155485CDEA;
	Tue,  5 Mar 2024 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5MpYPos"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76405CDE2;
	Tue,  5 Mar 2024 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635374; cv=none; b=OMJSFxHLlUdqOzqAZyPjfg87jLR+yGxTnyKhM0DX8Bnaf4OitZK8KX1Lx2adsao9qQukDcJT2q+DSwbOEmBHYgnEwGgOBqHW6/ZF06jpUqx4uxTyPxz7ogjWmc+VnRYvaJunJSJeNhQ3KE/hs9DzbyEScoRePYtSqTdZrwRAo/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635374; c=relaxed/simple;
	bh=JN2dNESh/y3tfb0TsFQ2avl51emLgu5m25nFtJpTifo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pB26cyLLorLgx62ihAGa3xB7lTeUooD8V0U/9kLRTD2327s45vBKYGPnMQ7xEQv/Vtt3lG4dLkd2OL8E3Rs9e3t7U3JwZjQ6bMAHPU8J+BlDzOcD0c4ew9IlgDMNM6qG1fTAxUzwAdm07cmMA94n27QNbo00PYZ/YibK7jaepYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5MpYPos; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6016C433C7;
	Tue,  5 Mar 2024 10:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709635373;
	bh=JN2dNESh/y3tfb0TsFQ2avl51emLgu5m25nFtJpTifo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L5MpYPosyRXNolZOet8a+ciMnpda+ZzNAs9DfQSQ/qlwcWSm5kqw+QIlk7EiAIiLZ
	 kw3v27npw2QhlXWcZeQjA0uIqDlT5L5Td9JZrJpIiajkVHs88KA4DfINqG/Vey3nif
	 hRthsTXXSYlYyauk8Yme94l5Sb0guziUfgzPAxF01IqA91r8+EVnXHmd/qykgYIZuZ
	 agmABV/uFoGztuv97AwtpwH+XXWfTMyCxNI1FwGn0Vmd5djQk17Z59ED18Xe1ueKhL
	 VB0w9HOO0a3CbFkflifWVKtFRsNUUQXQirPTTwdk1o30FuiA6ukVztEFm47vCN/twd
	 vfioCAuroaKcQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 Mar 2024 11:42:33 +0100
Subject: [PATCH net-next 03/13] selftests: mptcp: add
 mptcp_lib_check_output helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-3-66618ea5504e@kernel.org>
References: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
In-Reply-To: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1473; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=nZs0x809wzr+eJddUt9MlJGJF47PT8cW7Q1w0vMKvSs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5vccRBX23YStuLEegcwd5kODJJ0cB6NBjHla5
 hSM+45062yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeb3HAAKCRD2t4JPQmmg
 cwkSEAC7l+udkR6ZJEU8Uc0QWmX9JHZO+S59qOkADmlikuTekT+1y1xstVxwn3eEp+HU85aA9ti
 YB9UEIeLGl7pPR7bG/CJxwSCvsLBFcbfQIc1e0g8hxgxW03qA7H35FqRChb9Q5rLMW+IlTp7Mcw
 Bo9euarfevIHqhScSJliohAxv/kXhxACF5P5uZupd3kHbKDiw6bmmYEVIKv64goTfpLXyKXKlt2
 NM8kqnaZbwAYAB0OT8ADAleCIncBvHFP/3MUj55r4OWXVFE6Ht0wWw8g+bd9KYtpxUJT+2FY/iH
 m8KYnwL684jNoufB4kHked6PyOQziJge64xBhmHBUWoSb+vL3ffXjmVnT4ekU5NebbGTFC4vXjY
 ss9K75epheEiZj6P/vtisHagfuY3QBkQRj4sOWoC5J30Z9fWZ2mYwpEOLLcIAWoiN3qJjU9ah57
 /mAtlAVnCTLJvyzQXWu39wo4Xpz3/17GVoSkIZ26xWPk5VitVYNcEbTH06IEip4UktiXMUgG1r2
 Urd4X7JdcOUdXbksJAe5IginpdN9STEQN7X+n34a41BXlROGFnC72au2nUpIKqYV825p8sv7zUR
 Ss4bqNtA/SVvc+NFm7Brdr/dtrB65dj9ucyRTJHl4TPpVbL1bW8vYSi73cCbaLUR9tXw8ePZiJE
 cLXluGV2PUyY+xw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Extract the main part of check() in pm_netlink.sh into a new helper
named mptcp_lib_check_output in mptcp_lib.sh.

This helper will be used for userspace dump addresses tests.

Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index b1fe354cfe96..ed86bb0bab49 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -373,3 +373,26 @@ mptcp_lib_check_tools() {
 		esac
 	done
 }
+
+mptcp_lib_check_output() {
+	local err="${1}"
+	local cmd="${2}"
+	local expected="${3}"
+	local cmd_ret=0
+	local out
+
+	if ! out=$(${cmd} 2>"${err}"); then
+		cmd_ret=${?}
+	fi
+
+	if [ ${cmd_ret} -ne 0 ]; then
+		mptcp_lib_print_err "[FAIL] command execution '${cmd}' stderr"
+		cat "${err}"
+		return 2
+	elif [ "${out}" = "${expected}" ]; then
+		return 0
+	else
+		mptcp_lib_print_err "[FAIL] expected '${expected}' got '${out}'"
+		return 1
+	fi
+}

-- 
2.43.0


