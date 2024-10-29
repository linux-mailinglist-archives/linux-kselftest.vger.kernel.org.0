Return-Path: <linux-kselftest+bounces-20876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4A39B3EE5
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 01:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5C6283A57
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 00:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D701023BB;
	Tue, 29 Oct 2024 00:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2FSbRKR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE081372;
	Tue, 29 Oct 2024 00:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730160650; cv=none; b=Ju+RDhpLwdHjf1aBTHnPtk0by1d3ziB4+oaK3w7JZWWBHH3bDf1tzJqVIcsvQvalvSilEIBiRO/OnoBR8DmLvPaNOtjeW7EtCu3GzRB/o3+q93sKLmoQUMp1zdlYkzN8sOkl9nhwfgx4LdQhDKVSTENWTSr4aSr3pB4h+lX+nS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730160650; c=relaxed/simple;
	bh=2Tz4DfrMjjNJi9ttTpQychaPANF6G/ayWTanbXJH8V0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=duyacmweFDHaZPMyc+kcX9roVtqCv5giamemVpgwIzSKauDyHegC9Idnwdf47obR91a2WOTBEfUblPIjkWIO+kpKXlRT5O6KpO8gYTKFjvETuQQAWElBpJM9OuupTGBRYxqiCWDFKHCT57afEA/76LN5jQxuMrsR8mUBO7SOiOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2FSbRKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9839FC4CEC3;
	Tue, 29 Oct 2024 00:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730160650;
	bh=2Tz4DfrMjjNJi9ttTpQychaPANF6G/ayWTanbXJH8V0=;
	h=From:Subject:Date:To:Cc:From;
	b=R2FSbRKRp8EEO7I9/aX9GBpri1kJmV//sMJs9AW8gcFjm+E4rzVcY7PY11MGXOBd0
	 f/I5/CzoKSo7MrWGs+o4IGYZoQ+iWHnmpU9dcjxSM4JNf/lI74FEP48mKQ5S14CfTf
	 wtBhe0WDnq/Qxu6f2iPjlAqbM0Py3mf69BDX7xJOc4jfz4HqbycR9bWTrFhUa9Y/gf
	 lECL4+GyQ95vwIJCHZgm866AIMp5+q7Cd9BSO6uDh5T/865017dKeANjeZUT/5C0HZ
	 Ouq5Qbz4L7FUX8BAru1JxA6DYB6VbfeUT4y+3GpMV6/7bC51WIO2vLPt95DXJxDDH2
	 odF8mvg4zJZvg==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] kselftest/arm64: fp-stress signal delivery interval
 improvements
Date: Tue, 29 Oct 2024 00:10:38 +0000
Message-Id: <20241029-arm64-fp-stress-interval-v1-0-db540abf6dd5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP4nIGcC/x3MQQqDMBBG4avIrB1IBhukVxEXwf5pB9ooMyIF8
 e4NXX6L905ymMLp3p1kONR1rQ2x72h55foE66OZJMgQg4yc7ZMGLhv7bnBnrTvsyG8eyw1JlpA
 QhVq+GYp+/+tpvq4fRw0y6moAAAA=
X-Change-ID: 20241028-arm64-fp-stress-interval-8f5e62c06e12
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2Tz4DfrMjjNJi9ttTpQychaPANF6G/ayWTanbXJH8V0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnICgGU0fswmFnpjH9LN4ZrQr49oduaAh8GdsoBfN2
 yFkDhzyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyAoBgAKCRAk1otyXVSH0BcPB/
 9jMkqhx7JVBd/zQGP6kyYVjfL5uKJ1XlSlIdrxMaKySUbSFk3vJ+pv1YkmH1dwWPPsy30Z/+6UIfWN
 c23J8QUGbSi0MyneyWn4HfzUylNhUGki6b7dv5Bqd+b7Dv6Wm+o+W5GW8ny5DAUJs1qO5XgEMoxgzo
 w3eWNDnh4IT/pve5jGwEMo+5asj+uXEh1GUUDTM4huRkO8m49Pcg4pnxm+ZqAut3PYnpwdTQH5BkwN
 x6S1cSyAeqoqFxTPB+SetrgNnThH95Z5B+TGKwcXEuEbdFcrG4bN01dh/K0eAZVd7Yrez2mBE+c975
 JPK1923GgMvR2PWnx7479c8ZMEpnLW
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

One of the things that fp-stress does to stress the floating point
context switching is send signals to the test threads it spawns.
Currently we do this once per second but as suggested by Mark Rutland if
we increase this we can improve the chances of triggering any issues
with context switching the signal handling code.  Do a quick change to 
increase the rate of signal delivery, trying to avoid excessive impact
on emulated platforms, and a further change to mitigate the impact that
this creates during startup.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      kselftest/arm64: Increase frequency of signal delivery in fp-stress
      kselftest/arm64: Lower poll interval while waiting for fp-stress children

 tools/testing/selftests/arm64/fp/fp-stress.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)
---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241028-arm64-fp-stress-interval-8f5e62c06e12

Best regards,
-- 
Mark Brown <broonie@kernel.org>


