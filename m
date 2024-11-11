Return-Path: <linux-kselftest+bounces-21788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC409C427A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 17:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4331F22B6D
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 16:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590441A0737;
	Mon, 11 Nov 2024 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELhnZSmJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3101819E98D;
	Mon, 11 Nov 2024 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731341951; cv=none; b=f7EPMREsUGIIcBZiXLcjPqb4tddtXY/7y3i3kNsGt+41KjUaBhdVeGZbCaEuz+unDZEvD+l7jLYlmsr6fSnEP07eL0haOdvU+RWgfj8xlmNcnAwK5N8svkynsfcr0n9ghgrZUq5NbDn8Gn65D+CEk9vHe3J4q2kPzzNFS7a5fuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731341951; c=relaxed/simple;
	bh=m/AeiM/whS+c6xBBzNvf1hd5pMNDw3SCnJ5DVbjF9gI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I0oZUSp/Y+k+DBEJpci3UPATsb6di3tMsi61D1jE14fTXi1HeliaHuXXqIKPjZW685eboawmoCTMPvoYddJsIrBesPiL2Ks3HJ0eS3SSELbveAQKexPpX5PES+M5+5BPhULxhfETkxwSbDShzz65Jh/ya0qnf+zNbhgQJt0GNs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELhnZSmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D65BC4CECF;
	Mon, 11 Nov 2024 16:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731341950;
	bh=m/AeiM/whS+c6xBBzNvf1hd5pMNDw3SCnJ5DVbjF9gI=;
	h=From:Subject:Date:To:Cc:From;
	b=ELhnZSmJ690rhtOXcbSHTcG0If5zx1CN1amSkhucDxE1xlEV4i+ysGe1Z4w8CGjIv
	 BO2bubCoeVh3ri7SVIJ0DYhlrVn06MgffHhAgHTJdea2rWwXp2+1qYrtDqUIGDhrjq
	 9upPtyw8uBefuT2nhnDXxEneTH3IKxhDg1NG3APMLFX72Y2/s7WygediC2+iN31gQ4
	 nrZ5oNdt1Lu082AHzVhS3TqYOo0QMCYgIiEOLKcYRkTG3JH+Pu73W6Ruxpq6qm40B+
	 AFUvoWo8OUMbl92U7khnUUQOFmnA1mBZyEb0vzZYGbnIVt+e7oRq0d+u+s1BqX/snK
	 70RNDayx8bYrw==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] kselftest/arm64: Avoid detecting spurious PAC key
 collisions
Date: Mon, 11 Nov 2024 16:18:54 +0000
Message-Id: <20241111-arm64-pac-test-collisions-v1-0-171875f37e44@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG4uMmcC/x2MywqAIBAAf0X23EKaFfUr0UFsrYVeuBJB9O9Jc
 5vDzANCkUmgVw9Eulj42LPoQoFf3D4T8pQdTGmszqCLW2PxdB4TSUJ/rOsfCdaNrkI9BbJtB7k
 /IwW+//cwvu8HNxd9AWsAAAA=
X-Change-ID: 20241111-arm64-pac-test-collisions-5613f5dfe479
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074; i=broonie@kernel.org;
 h=from:subject:message-id; bh=m/AeiM/whS+c6xBBzNvf1hd5pMNDw3SCnJ5DVbjF9gI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnMi56xmL05NyNLFXLuO7+1tHJWJ3tdzbjRn94L
 NzxqKQkaFWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzIuegAKCRAk1otyXVSH
 0JdkB/kBO+9SbtwHZL3Z7Pz+Pnhb9/0457z4NwOemai2FoOr83bgZxeTDiQ0d8p1WClM+dFV679
 vJBxmp92NECT5oGNfO8Oi1cOBpGHLHEoPyZafzFjgmchdVvy4oeixUtRGanXokMLVEWMZn7CWTh
 AvYLuSqkY97Dip1B5rkmmYcdrHkm9wwuZ/q1L2wHeLvxgNt7uz1Fwz+emkbv1M+2NFBPl+g7nLr
 TQkqfPQBFBzZ9Y/ZRJPQzpRo4+/8mMBEUAN8L00IdOynNx3KPJ2KijfNxWLGzqxcgy9VrKScBu8
 4wG4PmsmwVZKNhSof5bmXuPw4kMcXYSe3JIkwp3mjmlR+D/E
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The PAC tests currently generate a very small number of false failures
since the limited size of PAC keys, especially with fewer bits allocated
for PAC due to larger VA, means collisions in generated PACs are
possible even if the PAC keys are different.  The test tries to work around
this by testing repeatedly but doesn't iterate often enough to be
reliable.

We also fix a leak of file descriptors in the exec test which doesn't
matter now but can become an issue when the number of iterations is
increased, we can bump into limits on allocated file descriptors.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      kselftest/arm64: Don't leak pipe fds in pac.exec_sign_all()
      kselftest/arm64: Try harder to generate different keys during PAC tests

 tools/testing/selftests/arm64/pauth/pac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241111-arm64-pac-test-collisions-5613f5dfe479

Best regards,
-- 
Mark Brown <broonie@kernel.org>


