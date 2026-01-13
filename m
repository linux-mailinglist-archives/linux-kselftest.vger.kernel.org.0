Return-Path: <linux-kselftest+bounces-48859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD48AD195C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 15:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41AFA30223E5
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 14:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D23392B72;
	Tue, 13 Jan 2026 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="v5V/WSVn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster6-host10-snip4-8.eps.apple.com [57.103.76.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE378392829
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313565; cv=none; b=t9t5dyOEvmomCP4fWpaivbxC4+CaQlcyMf0aGnJO1vG38dPW6Gh6b2nq6qKSK6KKBqsf1yBPiDpQZaa7CEULd9OAy7S7i2vgbhH8fqiARi58M6CYBhBMCCV1wlAxk2KmJgimxpbywSva9S9vdEhI6snabvt+I9IeU749Ih49F0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313565; c=relaxed/simple;
	bh=iyta8NE5NDlfmw6L04V4o5AAcmnE1uFMrJ6X4Vhs6ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B701osPX3WPuk4FwbxOONR5SR2aGjxd5JA0Qt5CPgyRW1kYpQxUU98C4oZu8+R0vFCg6ywmFemX5rcJee1H+kBBjrUZp2mbFB2BhbQjuYJVrhKwinEmfqCIOfs7VdESv4VyWyxHyacihsuLVp59kwr7H1xZjdKw4zSVK6xArCuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=v5V/WSVn reason="key not found in DNS"; arc=none smtp.client-ip=57.103.76.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id 0B7DA1825592;
	Tue, 13 Jan 2026 14:12:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=WZtDG6mvRdZYrbjETM4DpUeWhiTJW9EtZ1QWUihic5o=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=v5V/WSVnitvNLMCfLH/PYKHSNrunAjNhpht0yqaStCK57438kZEyK76GpIEPqJ92U8wTMv5vf9ZrHJgEiiqPtzY1kSrapogp2j0Ty5uTSLoFSyBStSnr0JGL7mVpdLTrhvaM6VaCQsmVFOMZduxkUSHsyTKfTKzpfgNmRPuTi8NKCuA97Y/Eu81USBvz7zPD2BRvo66stbSJc77KdhvuMdRLFgHXwGGw1zkO618MZoO1njCguKRXez5PTE6CtYKm/4OV26tNKPLbvYULd5hQSLQECRC9ZwTlQflJLtsY2Fu7navhD1XYbvpSy3CmwHCNOICEVqH0IAMXypWhdGsSUQ==
mail-alias-created-date: 1719758601013
Received: from desktop.tail809fd.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id 777E6180185E;
	Tue, 13 Jan 2026 14:12:35 +0000 (UTC)
From: Yohei Kojima <yk@y-koj.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Yohei Kojima <yk@y-koj.net>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH net-next v2 0/2] selftests: net: improve error handling in passive TFO test
Date: Tue, 13 Jan 2026 23:11:53 +0900
Message-ID: <cover.1768312014.git.yk@y-koj.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: idCf3MxPphw8xzIQQv5SB-jlAkRN5G8-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDExOSBTYWx0ZWRfXxxB2Sip32ap8
 Ks+LjXKlVhuv641tDkrndCr0nJRfodrFyypUWFp5YM9vXXR26cU0/OX7JkqIGnVSdBiWCB6rkxj
 fky8UdQAKRYze69AZlnR8X3Y0oz0dgN5GokgRiEzyLIHDY+tWC1pCkDvrjWIHVVxGNacMid3maA
 EoB94gFJbcgbohSoydQ7N7XdmJneOiICVgP0Xt7RrGxGvlzv/GJvKRg7wFkovjZQprfiw9ohSNO
 JEjl6Tj8w7b6dGwH1O4a9U48x8Wlz3mn17vdb4Cp21QWKPXAruM05aSLeysmTL3pwJmg+63uC1y
 6MpJJ73KHOwAuv6P92u
X-Proofpoint-ORIG-GUID: idCf3MxPphw8xzIQQv5SB-jlAkRN5G8-
X-Authority-Info: v=2.4 cv=QolTHFyd c=1 sm=1 tr=0 ts=696652d9
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=jnl5ZKOAAAAA:8 a=pgjvsvh3yOMjbX-kRL8A:9
 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 clxscore=1030 phishscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601130119
X-JNJ: AAAAAAAB0L3yRii6cal3MdZCcKZxqLy2LrXtDOxIw0XkQEFHSVMySvWRScksoYzqXRsMfSUd24nFH4sB9kK+USBm2OfOlJVcKWDT/9qVnNIamsGB4AB1zvGn02ejjPzpUCFf4MvZmarmE3RSCWBwLd4T71LVOvTWOFVAtbx4jKiaDRysKYggOpZ0VckzsDNuBdNMuiTiJX/vNEIooSBx53d7SJQanraBbjpCTDKRYLcGYtuU98ELY3e8JI+dTkRhjB6eK8jVZ1uvGDMe9fq6JyS8Y/FayUT0uJc65bFxmBDA3CQV6J24lQKyat+6lRHb2MwdewJyAINSdf9B5znAecR5tdNYFveewUt/EpF/FiKGI8XvaaDpMEGvk4rGTK5IKce+Nmh8cODXFWu5i1GxSPSsE5Xsc9SwltUgAIOGlAM8ROz/1p+YQ9jBOw2UBe13KL5rq50U6WOWc3cWE3Ovjn1w96AtOjOmY+JoGsEK05iCKueY8/jexUPgT73jI/qjkIrwq291nHtMsNPk4DUP5lAJ7C0ynEtXj4visG78DnlKnb4UvoRUnymldnWvOo9N/szauTWRKvSAJrMorTw3+IidEuFxFSZ3P2JCscDHDBsZfdxd1mmGadYmvvMJRA/xEimvYclHDkNini7EK4vqVOVEjAdjKMiP4GS7vDHPVKZoAbanL3GU+yvckVQ6x+Fy6dOLufzII9Bnq6U6orAp+FBhyYLfRHot+wnrRVVE9pb5wI9hF10=

This series improves error handling in the passive TFO test by (1)
fixing a broken behavior when the child processes failed (or timed out),
and (2) adding more error handlng code in the test program.

The first patch fixes the behavior that the test didn't report failure
even if the server or the client process exited with non-zero status.
The second patch adds error handling code in the test program to improve
reliability of the test.

This series was split out from the following series to address the
feedback from Andrew Lunn:
https://lore.kernel.org/netdev/cover.1767032397.git.yk@y-koj.net/

 ChangeLog
 ========= 
v2 (this version):
 - Fix a typo in the patch description
 - Rephrase the patch description in imperative mood
 - Add error handling for fprintf() reflecting Markus Elfring's feedback
v1: https://lore.kernel.org/netdev/cover.1768207347.git.yk@y-koj.net/

Yohei Kojima (2):
  selftests: net: fix passive TFO test to fail if child processes failed
  selftests: net: improve error handling in passive TFO test

 tools/testing/selftests/net/tfo.c          | 13 +++++++++----
 tools/testing/selftests/net/tfo_passive.sh | 13 ++++++++++++-
 2 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.52.0


