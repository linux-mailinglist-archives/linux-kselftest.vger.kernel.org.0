Return-Path: <linux-kselftest+bounces-48718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 447E1D1156A
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 09:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F97330249C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 08:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B79E3451C8;
	Mon, 12 Jan 2026 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="KmzRg/RA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster4-host2-snip4-5.eps.apple.com [57.103.78.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EB334575A
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768207959; cv=none; b=JgeEihzSSORYDGPOmKD8/nHWAWM55yu75D5fZUdCqEnY9Pb3c+sxOr3gOqF96NAnqU8bUNMFqUuvVp3pExx8Mbin9kDLydD0quHAf7qc59hHQSY1D+Pi2x1Z7Nu+bWe9RyeVJr6cXkv2LpWL0GZ6Htfa94qbKbLZNA51/Vda+yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768207959; c=relaxed/simple;
	bh=/yRazxsbNMX774Mh8GZGUYzGMpZwHziAMhcBRbGAQQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R/evWhEPOVC9/gMQV8hM+oZ6BJ4z8efztFLYAT3k5r5m9LS2rxEt0fDKSkl7HB3GW1AsLwLbOnN7/qp7o6OzHwNpCtbQ3bIFfy+DOwIYH+PL7EZkI6c5+XC/jfHFv0BEQkIRWChlVRzJnY+g+9fJI+gxh1T4levSOvbX0R+Fl+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=KmzRg/RA reason="key not found in DNS"; arc=none smtp.client-ip=57.103.78.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id 254CC1800176;
	Mon, 12 Jan 2026 08:52:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=4Itv0Ooc4L8CDM5G3pwk44bU8zUPWzoZLezCw3n7i6w=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=KmzRg/RAPg5QAK/cngZHWlIw2gN20ktGGy6gT7n/QgXKGoIE3zPp+mnDLHZRlZBEmylYT1zo9A6BoGtv+1hR8VDFg8RpmutIJkIAMOiqsPM54gWI4WdysTiMI3+JSJoyAuuufI7llzFfMcL2R0kwAZrbJC+m4JnBiAGmM/H19KZs7N8htxLym0EC6A05ymCsKocHWw4MdvYW7/D6kNdZ1QPUvTniqIkEATTT/1/RXdNlRXNbm7QZB164UX7mWUM3abJcJjjv6q0Py23E0ByrDysAv3nfiXFRVCS18yJUdK/pkxkvqDkkjYAFDyC/DvIeB0XVarPmy6ymMfnUs6LGew==
mail-alias-created-date: 1719758601013
Received: from desktop.tail809fd.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id 894D718000B9;
	Mon, 12 Jan 2026 08:52:31 +0000 (UTC)
From: Yohei Kojima <yk@y-koj.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yohei Kojima <yk@y-koj.net>
Subject: [PATCH net-next 0/2] selftests: net: improve error handling in passive TFO test
Date: Mon, 12 Jan 2026 17:51:42 +0900
Message-ID: <cover.1768207347.git.yk@y-koj.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA2OSBTYWx0ZWRfX3V6EZ9fWe7+H
 tWIcAI7qBnylYzR6Newu1QuvxC7MSEhV3mt8nCslFDh+LzQ5IIIjDDG76B5I4MWWIUr55nn4GiN
 whW9JPVTVvs150wI77zX1x1EEOo8xBEFgbaNg81CEnILfq+jxWwn7I+kka658T7vYy5YbiHQ4DW
 Sc303QNvkPgYNfj+AyC4/lwTPX/ofot2QNWIdmHso8LbIVGTbq5q4lelkPO8DAfWqqYYrzEdi/+
 cnB+eq49TXoPV25nYt+87RMhjViZDpwe0hidyuNuj1039ooSp4Y0+Doodn0xdD9/i5L3qslUUeR
 tw4x7x+dyJoJ7mEEyvp
X-Authority-Info: v=2.4 cv=UaRciaSN c=1 sm=1 tr=0 ts=6964b652
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=jnl5ZKOAAAAA:8 a=BzLB1Msb6QmX_b4eOlEA:9
 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-GUID: 5b7hPN9b5qdm09jQkz2Jm-13iPD3rbVU
X-Proofpoint-ORIG-GUID: 5b7hPN9b5qdm09jQkz2Jm-13iPD3rbVU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1030 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=827 suspectscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601120069
X-JNJ: AAAAAAABph2r8x2NWv2ySL5voK8tTMyoIvedlYtIjOdpZ6pxmaKaXO73V5YMgUivD5lZA9GAgD2tBCOjBapsr34ibjKvJT73aHfjdQeed2xPK1EheW9DEmUWK3EfzlKmqLMwK0s8ZCFjjkUSLYID3Yv+wKEI75Cg0ilkAOWc6fOhxX9G//1Mzj9h8wczJJXVkvSiuZJPqsxxwe57jwQsiZ6FzzP367qtWofYZ6+6neP7ilYM+wQe878U6kk23cg25YNGKewunvYhOiUzAaksPJcRhqi1xCg3xvr0HIpbIdQeQk7hWZK+PFdT3/YTRiaHkxOr6TsLDXdta9w5FO5v4ny5jim0Bt9uBONPyiHrRITvX5R6GY5mOvE7m9j5Im079zKUWCSpnPs/x836OPChptu862VieLRxFHyLViLXRPZO/3PquswhpLxc6kk4k+vpPeAbs98Ncv79QsvjPUOpX6KMffWX+sCSL/trKSRmB+Ed/s2sKlqrpJBntha2jxV0RcXDlthfm8YtECDMl5vGQIrUpn1sG2IWcdI97NsoscxgtMQPeR97ccyw08wPYnm3m3vdrFGSUmYoRE/7ntzorwtYoBSO1i+v7a1iIYH9/3gsexRCxIZWu3nTXjb6koAA43ZPWu1MfNvYld12Q7ASMnYhzSNlgAquyMHelrt1oMYSsSEbDWt9QfPyAFMr+5snqafhP37FrIBB7T1QMbXnlg==

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

Yohei Kojima (2):
  selftests: net: fix passive TFO test to fail if child processes failed
  selftests: net: improve error handling in passive TFO test

 tools/testing/selftests/net/tfo.c          | 10 +++++++---
 tools/testing/selftests/net/tfo_passive.sh | 13 ++++++++++++-
 2 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.52.0


