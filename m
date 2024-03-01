Return-Path: <linux-kselftest+bounces-5744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8263086E6F8
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1D63B2B498
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 17:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D580B5394;
	Fri,  1 Mar 2024 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NL7Nd/7T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B8A5224;
	Fri,  1 Mar 2024 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313099; cv=none; b=MASXwDS+lP4HpdkkpKXE//fi+sbJhImUtcXrk8eBouzKvuhRCaazVOX8F5GqxUs8YcDvBgt+ocsvl+XuPx5sXD9nNgksdBQEkT0j/2RlcqyGwe96BSMqSzUEOJt4lY+rYUfjcbwjgOnCknLVqfkj2gC50vBX6fq5NtfpolEkm+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313099; c=relaxed/simple;
	bh=cuyEmViMwK7nH39XXKESpTLTtBzMLu91c/Io+gjy+i4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ri36PUbbh3BMYAFwZJJ9WjMNLzV83ivpRPwU0PPu1l+79zGPrzCWxuqXJhUtE70soBmDKEh09Pi7wlXr2JpAB0fpoPGNwTTF1g/BQdOe8GNbdssEXoeq7tbTK3hcgAECy/9hMJYBharnbtvTzVCfyFQH1QVi7BYzqK+6ni3VlC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NL7Nd/7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F4EC433F1;
	Fri,  1 Mar 2024 17:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709313099;
	bh=cuyEmViMwK7nH39XXKESpTLTtBzMLu91c/Io+gjy+i4=;
	h=From:Subject:Date:To:Cc:From;
	b=NL7Nd/7T+B4PmyKKH9q+DisBPomr4EMh8gMZgnXe4ISgeMwzDJDModWFc3LJX/vPv
	 ysM8KWBaaAXOTAuzLTT44ww9Fc0+KHFv3Qjht1jHJgdIq0XwTwxGeAz9MrkyM80odE
	 kbEyGS/4y+E4ZmqJCZMPdto6GrSSbYRgZ2v5stTHK5T0REpp3j6nNV9PdfbQyclFEf
	 oxtmG+QKuRiel5WMYtARqJo5r8oEteeUZ3REUoiqgpknLX9FV2vbBqrk09Vwxu7eay
	 Zxm/gRpe30/CdzMUKHhfU3gC2OnVMmcU96mhX6KGnkKZZYUuO8xsIteep+KC9hOeHU
	 mnIt2jC3QR6fA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/2] selftests: mptcp: fixes for diag.sh
Date: Fri, 01 Mar 2024 18:11:21 +0100
Message-Id: <20240301-upstream-net-20240301-selftests-mptcp-diag-exit-timeout-v1-0-07cb2fa15c06@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADkM4mUC/z2NQQrCMBBFr1Jm7UAaLUGvIi5iMq0DJg2ZqRRK7
 2500eV7fN7fQKgyCdy6DSp9WHjODfpTB+Hl80TIsTFYYy/mbHpcimglnzCT4mGF3qOSqGAqGgp
 G9hPSyorKieblN3XRXe3wdMFAq5dKI6//5zu0Fjz2/QuOf5NnjgAAAA==
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cuyEmViMwK7nH39XXKESpTLTtBzMLu91c/Io+gjy+i4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4gxHsxscfNAbpgFzjliiQ2h6mRqUpVmBT9iZl
 DQ0TLEvFBaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIMRwAKCRD2t4JPQmmg
 c5e6D/9CjlN7HMRdynQb2VzD+KTkqZe1Zwyek8DqgfLlw6aM6+xKgDReqn9QZZDvLWCypRd+IeP
 n9mBhFz7hK3GAu4OlVkuELoS7HkhQ3Bdc23mKRNHsT25/i8INgJ+PO8yXgwGFQeMOUFcj4/V05y
 uokocSiiEGV1leifSIHwlRRUmAT9L+k7E9n6L0c+cLz0Tojc8yk288EPE36IulRXYvLNBIflW6O
 1Uv/Ok7MzYHgNM5oPTQwytSaSFA9dGmLFo5TP3s1iTDvOR0v2N/2Fvz+3DHWtV3KMXPxoDSR8N7
 royVPCxYez/TYTu198dvqkJTlPOjirSqRgK2EFO3Xj9BrtAmy8H8ENzX0lTEYlKa+nmac7TEv7D
 KJXQxvzhbcWeh3dqKZeWJgDz3yxF8HVUDVuCI/0xTTAvpWnmsFW07+4OIb85MCBZm0/f4VXtlrL
 nMghBzHZS/oxkSJaeOjl46tQuUBvQKl5egWz0Hby1lPGI3lUP9g3tx1l5emRzIVLbXtmIW/2N+Y
 Z+WRcNJ0cuuZn4s9/CSDtzD/7e6+EptEMr/vOh/xlZTI0zbf077Q4mVNf29ODlVW3wxwDo4jktk
 dUNdkQ2NOyIWMvAPbYlQekhdCUsrj9cLajPUgFiNJ25zJs/9FB/y975X1nPU3NdTLEZKHEhflGz
 8gjWAcxZSwXK+EA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are two patches fixing issues in MPTCP diag.sh kselftest:

- Patch 1 makes sure the exit code is '1' in case of error, and not the
  test ID, not to return an exit code that would be wrongly interpreted
  by the ksefltests framework, e.g. '4' means 'skip'.

- Patch 2 avoids waiting for unnecessary conditions, which can cause
  timeouts in some very slow environments.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (1):
      selftests: mptcp: diag: return KSFT_FAIL not test_cnt

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: diag: avoid extra waiting

 tools/testing/selftests/net/mptcp/diag.sh | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)
---
base-commit: 1c61728be22c1cb49c1be88693e72d8c06b1c81e
change-id: 20240301-upstream-net-20240301-selftests-mptcp-diag-exit-timeout-207d7925b7c0

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


