Return-Path: <linux-kselftest+bounces-4886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC20B858A4C
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 00:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99533B2313A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 23:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300B8148FF3;
	Fri, 16 Feb 2024 23:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="0eZbR2l9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3361A1487F5;
	Fri, 16 Feb 2024 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708127414; cv=none; b=WQF9AAwwag4lrTuGipWjR7y7X5t9P2BSY0IHKMC1Hj9Q7FwlGsdOV857hEZn7cpCOzkATVI6z8EtizigtXFgAGAlPlNMpcDu8XVlf2Vs90Zkg/LOMfcQp6VbWHwTlBdeQaMvjcbVGBRJqRFJAarOqEhNX/jOWQXKaBmhKTAiJw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708127414; c=relaxed/simple;
	bh=ewZyQaeiMirI+9fW2Ek8NXDSlbSYf5H+Yv+QmoDrGVA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lUo0tdePO4fj0AFBSawIT18eIYYagCo6/FO02qTNQvjF5e5QBxC6/r2aTrLldDUgVcYcbcCAPDEGwk3GOEeMPtn0yHrtUKNBJo/vcMdSf9w7j2sCt5JeUOFg9huJsvtKCG5ijsLrNM4C5nIbxJZ+PrzbPg0K88yx/AUO4OQv308=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=0eZbR2l9; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 43599200C998;
	Sat, 17 Feb 2024 00:44:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 43599200C998
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708127066;
	bh=eMLDY0oEAFPsqXefhCsGRO69q/q7s/Eh/mdW8pbZR8I=;
	h=From:To:Cc:Subject:Date:From;
	b=0eZbR2l9PWwUhOewGVUR/GNLWrN2fHH4+t91iqHSaBXrtdQPDh48EnaG5Edw6oGdg
	 ucQUNgVJscZpz9G2cLUzV+IEAkIYc2UUekVw+xAZtXO9iZpbjvGsT70sdLF6NVFMHG
	 wWkAf4Nme/5phCp8Acsl+wi/o+ps+4ycqtZ8u46A2w4KaE+tCiOU2kQIg99I0OUR6a
	 q24/8FFYJRj7NEvQLYmK9s2UXXJhRUwOSBo7sPVHxSq7sut2UftqWL2+rsJTZDEf93
	 EKpwiBNVudy42bv+8srIV/yJepZTNbbq2IPg1lfsFrDV6HqmwoIwA9n1OfMsUAbUhH
	 t6O6fhjhadtng==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net 0/2] ioam6: fix write to cloned skb's
Date: Sat, 17 Feb 2024 00:43:54 +0100
Message-Id: <20240216234356.32243-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure the IOAM data insertion is not applied on cloned skb's. As a
consequence, ioam selftests needed a refactoring.

Justin Iurman (2):
  ioam6: fix write to cloned skb in ipv6_hop_ioam()
  selftests: ioam6: refactoring to align with the fix

 net/ipv6/exthdrs.c                         |   8 ++
 tools/testing/selftests/net/ioam6.sh       |  38 ++++----
 tools/testing/selftests/net/ioam6_parser.c | 101 +++++++++++----------
 3 files changed, 81 insertions(+), 66 deletions(-)


base-commit: 166c2c8a6a4dc2e4ceba9e10cfe81c3e469e3210
-- 
2.34.1


