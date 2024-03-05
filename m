Return-Path: <linux-kselftest+bounces-5909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A95871C1B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 11:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5DB1F2528E
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 10:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4AF5D47E;
	Tue,  5 Mar 2024 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CA4lRqOl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDAB5D47B;
	Tue,  5 Mar 2024 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635377; cv=none; b=qCZh9QYtwF++7nT3iLKgu56zEfJ9H49YGnRTvVWSmyKjOCbrQxmp0yJSgEwQC3bMrDupVgcFW6IwFtakJZyha7+5eRPM7luFrj9CE/8CBofa+GjqgewNtP6nnU3B6ZhksRaeSFFYijfXp9DD3cJc8LbK9ExacJjpNvS1oFRD+UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635377; c=relaxed/simple;
	bh=NwaGraVY2orMRXPc4dj4/mlBtx6flfWWyqqm+KZIYZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T9WO/4/IJJRNam1EwlzN/9+6jC703QSBGoh88K5aTdiG3bdC4H4ZaUpadmKxEXTUvqPocqCXoDKTVyXYFS+hlCOwN040ZOQ1zy9633+T3xQYh7ryowfn8vJwHuj2whCvB4b1d79w9oJN2NTRyVAW/1U/LWvK2wpoP9DB8ZpKe9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CA4lRqOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8357C43390;
	Tue,  5 Mar 2024 10:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709635377;
	bh=NwaGraVY2orMRXPc4dj4/mlBtx6flfWWyqqm+KZIYZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CA4lRqOlXOr3a6i2U6GCtUnowoCK+rEo0Q/5rEfsXIt9PG+SetBisgIkZQ+cr4DEX
	 DVxE1k6Q2tmGpJnufqbqCabE1Y1A0kapwWxF4+N/bAoH8WI8BJMr/CaNM+DrfnjSgD
	 0lUBP48pW9imqsW6h0xDWTc0ktNl773Fjy05AXjjg356zGkeGzfR6Ce44il32wA5Cx
	 4Oito7jmuL5cbJNdgWHgMvPhT3g0hzDzBd4Wwv0dUP1kZqKnrfa2qzLtxsyIqwkuIi
	 lpaXmZqklPBBxsTCKD3u2/pQ7DrQj9iIb3si859VYIELgUbO6EKSk5C33rp7CdawRZ
	 gYfyIQVN8F7og==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 Mar 2024 11:42:34 +0100
Subject: [PATCH net-next 04/13] selftests: mptcp: add local variables rndh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-4-66618ea5504e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=rR83I8+9RuJUsNHRpTCHk6/7gRGCW52wxZZeqhezDd0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5vcctx8rBdjKkea/BSXnmiIO9Q/gwbNNqgI36
 bMV7Q4C/pyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeb3HAAKCRD2t4JPQmmg
 cwDyEACqvyfCv1JuWAQFsM8rHRSuGs4sxxbWjsiSDRZZvHeohxK5iiAIftryNbvAnGizVQT5/D/
 W2IrRd6YnpLWTRBt940afAihg1+Gz3ruFi6os4ngK8wQMRC1QmfwNZl7Diyw82RlMJAOHYwjZbr
 QoYYOfysJ45E5otqSyyBseDJYu5lj8IYWgoZ5E0blcSpOuSeWvfLMEq+YI1jJ1LG64Xe4PJpytE
 hEoCrXfIB0VvRAVGTuxBKKJFOtBpKaTV0mbfV9UN3b8jkaGYzK7g2T0Xgm8XoCOwijASIKR6xNi
 Hg9Oc2Wb1b+onpT8C/1qHmXSkI+q9ROw2+ziZHWblUXSiqc+IbPVed6Nqkss4Wc1uGKH6LGjMms
 tlxisz0e3Y/AJiSzGMtjxxYspi1Iot1A/MYykoV1/0/41jhgkqB3q61gZIdyw2cCm4zoBN7nzzF
 SVywLBBk09ZGAOPUt2NCv4EJuh7AGsC1oAUCqnGHad/HtHxWBmJnxwNbTOj5oba4HtRZEBo9k9W
 +hBFtUubw/Yfd1Ke7U8Y/NsosF/gH7opbGgDQGmW9vzJMo5y7h5pLLyhbJ72O8UbYTqzB+DULVQ
 VCMetI2kZKPBnkRi4ku/dDFPgkQjGCk1zD91tQLV9BJT66bcXsDVEArzCXC75HzNyy+u6hHIuuw
 Vj2meyzOySeiT9g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds local variables rndh in do_transfer() functions both in
mptcp_connect.sh and simult_flows.sh, setting it with ${ns1:4}, not the
global variable rndh. The global one is hidden in the next commit.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 1 +
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index ea52110c3fbc..b609649311f6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -348,6 +348,7 @@ do_transfer()
 
 	if $capture; then
 		local capuser
+		local rndh="${connector_ns:4}"
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
 		else
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index dbbb13d1d74e..3d08116500a4 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -139,6 +139,7 @@ do_transfer()
 
 	if $capture; then
 		local capuser
+		local rndh="${ns1:4}"
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
 		else

-- 
2.43.0


