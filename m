Return-Path: <linux-kselftest+bounces-36962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 029B6B002DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0559418992F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 13:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F8625D21A;
	Thu, 10 Jul 2025 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="l+ugFq5o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D68F1DC9A3;
	Thu, 10 Jul 2025 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752152755; cv=none; b=qRIhfl39LLir2ErruS3V7dBV37rHh0T5DgBXonuh1w/1rMQOVeu58XzsN5KH3MOPEVhQRa7bzIxRCgHHOlThNL+kmw4dn/klwzVLQk7toM57a700lLOYtJA2gJEVolMRyw2oT9LfJT/kjHk3iOSet8h1TMsK+xqBtJVXAf8eURM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752152755; c=relaxed/simple;
	bh=GQueY1iBB2lYZXp4i4PqpXAZskd6Jwy696NwcKzG8rA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fR3GEO/ZIGETW1u8zmXNILy5iQa8FqE/vRjDDsCYhip3uCi8Sm+cEAgYrcM9QjJfshvBaA2uj6iSIGbptyYABoQCjtTLAByQDGFmQZejmEE5kKHifNv7KPt2rsKmZr4y9/88F5S6p7bbaGtnE0a7r2vNbYfx1TVW6wa6yutbaa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=l+ugFq5o; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1752152707;
	bh=sMysxZ2PDwu8C55CtOCn+w5tvI/L1SSPhfVKimncbOA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=l+ugFq5oESjDffIrhFOao4mGFxKLKKFFS1TpSosklqO7An5ASnB2ybb5N27ej36FX
	 3BbxRZyf/goKQIKgrBcDMadBzTOnU6O+O6S1BJdSsYAG6Dx2c4luTx/LS2GDzEVIbe
	 VSRxbfM6gR1Cqay6Bv6RaMRDrWlASjHRCatxpMVc=
X-QQ-mid: zesmtpip2t1752152671t2e6cb732
X-QQ-Originating-IP: r1IOeWfhp6jcJ9zR2VkDNl+uwXjZnZo6LTTzluZaDHs=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Jul 2025 21:04:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10183139680791964204
EX-QQ-RecipientCnt: 9
From: WangYuli <wangyuli@uniontech.com>
To: shuah@kernel.org,
	wangyuli@uniontech.com,
	chelsyratnawat2001@gmail.com,
	akpm@linux-foundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@unintech.cm,
	guanwentao@uniontech.com
Subject: [PATCH] selftests/thermal: Remove duplicate sprintf() call in workload_hint_test
Date: Thu, 10 Jul 2025 21:04:12 +0800
Message-ID: <6338CD0E839B770B+20250710130412.284531-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NImvdRhE6fHp1TYj7/vl3op8jUW8RaVx1kOeKZm2FdtjyWNZJelIBGec
	oLm7zuXVfWyQ9cd9VldCOcGhxgxYs9QXTOZgONMVnDqx+tOke5lI45zFVRvsuNUZZ81VB8p
	8mrr/fC+HawNhi+HjcgShboT11xjjUOufUtNkZUp3dVE2pe5Xt9l3wJ2z3hhhEU5nvvtF2q
	ZtXmTiybqjRvTG0IXBtziZnp1cktm1U5LGwjk0Bt70suVajNbdzS3f5Er9tzK/U7yZUainW
	0nftSB8KDh3QiDX5rtw+QEho7QycO8scYD0lmmgDwSl2/q7p5vtGmfu22Y7yE1t27HSVb36
	4xy+PQ9JryvBGQURjo3a7hiOl2Td7Eo6mURDMiqf1Et4YD2UzXuUOTTZjRm/lyVAIs1L8ke
	IP7nfm6Mjm4xKc45r0poCCBZAU9Gdphz7uv2miJ7GkTOsr8uIBBc5+z2IYZfNfOKxoIPBvj
	mP2ShUBHv/4Id/K0Sn8tcje/quOaftSHZ4UuWzbvd1Pv0L1TrNWLkUS3hDLRXMoS3WMBgYk
	2Sygf1J/uYdWDQJu9/D1jIEJAIyz/IfT/+wE5Musp2Zz9IOkX6QiIBQ4r2VAx7oYc3mTrVr
	SyhNPAANS79dSLZdn/ceQmteU9xyhLNyfRUgLMHFRkDXfxQHaKi1/CPw2I9WGHNRkvHP05g
	UMPLFv9Q9xyU5SjEbEX85l/K3fDZMSmiMuvHP9h7cZ8SmzoQGgaRusblrPDq+G+xLZCAtQq
	Hfagzmp+EwZ8w+raBbq1Lihm1PSEH6nHKpUO6xGjzbKRUQnL9nLRl7AUrUws4LWdwqTieWm
	qUbJVNQGryX7BAmll59M/LKOyjTkXiCkFkYQ3FpnxB0aDpEslEo8VwpypBzW1wKbvjB7LQC
	ggciG3nLFTJ2GCa5CG8FYlEGxPsyGWzt8CBrMmLKoPQZV6A1pojTjyulHg164ur3JQDqsPn
	jtm+b90b+V6QE6tH0zuRlnho5KRRHabfj292/XhywuFSUhBW1X1sX212TLh8OPLCfakR/nW
	xG1Phn3KVjS4DW9R5fgz3UnunsGBpqWyxQWfm61g==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Remove redundant sprintf() call that was duplicating the same operation
of formatting delay_str with argv[1].

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 .../selftests/thermal/intel/workload_hint/workload_hint_test.c  | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
index a40097232967..bda006af8b1b 100644
--- a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
+++ b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
@@ -67,8 +67,6 @@ int main(int argc, char **argv)
 		if (delay < 0)
 			exit(1);
 
-		sprintf(delay_str, "%s\n", argv[1]);
-
 		sprintf(delay_str, "%s\n", argv[1]);
 		fd = open(WORKLOAD_NOTIFICATION_DELAY_ATTRIBUTE, O_RDWR);
 		if (fd < 0) {
-- 
2.50.0


