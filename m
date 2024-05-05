Return-Path: <linux-kselftest+bounces-9481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC098BC2EB
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 19:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74DE61F21349
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 17:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED3A5915A;
	Sun,  5 May 2024 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="yeqq5oeM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067C579D2;
	Sun,  5 May 2024 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714931908; cv=none; b=JxFcEKc5Gbe9JiU0/YM4i/K8E6UkFo5HdNEVSLhhytsE7Nf0QjZzJ4rWfrKWolU735/vOft2DntSAHv7RPIgc74LMqpbsBkMyow8OW7PQgZ6Do7N+AFh39L4pKz66jrQv1dETd6MCzf5d4mWsUdZq8PLIGqzNE/L0jZg+KfHdys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714931908; c=relaxed/simple;
	bh=BSv0pSIQIHxV8Gc0ioOPnCjjR3zV27u8s4eTfKiPicg=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hJSkzrfzM3fs0sL+KlmrrB0rVEpqqiO7MvOS4qNcqAh+Xhi9wbE22bhSM9eMratOc1jaUmNMlbU6HnmCcRGZniWAB8JfJLZBxj41YhVxw0eA3qi5D2cjk53f93xTqptTTFQi6M96i3pkDATdM5IQtBxPcFQagoOMwa0kbhLpfZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=yeqq5oeM; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 35655205E5;
	Sun,  5 May 2024 19:58:17 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mjWdlp7yj9p8; Sun,  5 May 2024 19:58:16 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 70C5720561;
	Sun,  5 May 2024 19:58:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 70C5720561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714931896;
	bh=U0lEMf0V0eRAxjIoud9jxZDeFY8xykVrvW+479IJ8js=;
	h=Date:From:To:CC:Subject:Reply-To:From;
	b=yeqq5oeMzvO5oy7+5TnyHPBjzADmOlsMXm8CZkTq/meN9ZR6fm1cEje7rsiJ/JRNz
	 rjUdn5Zzq8dy0BIwQeB5IhKM0yQv28mJGJuvNJ28e/jDwEPLd5EvzZLDksUhzpQd6u
	 gtDliYVKp4oU5S1/f23ye3cQlTc5Kb+97YW5ho7F/QyFtlzE78CQ2XttgdmxTLKmol
	 eunc1FZmHTSX3r+Cfx0qEfzgK/oXkvfseltidkBJF5KZeh/ygb2cdhVUUh7G56Cr8T
	 ni68hMAX8iYJOIxiR6cpVBD2DnPf5Qyk1+H1fQmKqmgPLGYcmpdl9gP7YEfxDvMDQH
	 3/VwDbPk1rRFw==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 5F6CB80004A;
	Sun,  5 May 2024 19:58:16 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 5 May 2024 19:58:16 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 5 May
 2024 19:58:15 +0200
Date: Sun, 5 May 2024 19:58:09 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Herbert
 Xu" <herbert@gondor.apana.org.au>, Antony Antony <antony.antony@secunet.com>,
	<devel@linux-ipsec.org>
Subject: [PATCH net-next v2 0/2] Fix icmp error source address over xfrm
 tunnel
Message-ID: <cover.1714931276.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hi,
This fix, originally intended for XFRM/IPsec, has been recommended by
Steffen Klassert to submit to the net tree.

The patch addresses a minor issue related to the IPv4 source address of
ICMP error messages, which originated from an old 2011 commit:

415b3334a21a ("icmp: Fix regression in nexthop resolution during replies.")

The omission of a "Fixes" tag  in the following commit is deliberate
to prevent potential test failures and subsequent regression issues
that may arise from backporting this patch all stable kerenels.
This is a minor fix, anot not security fix.
With a seleftest I am submitting this to net-next tree.

v1->v2 : add kernel selftest script

Antony Antony (2):
  xfrm: fix source address in icmp error generation from IPsec gateway
  selftests: add ICMP unreachable over IPsec tunnel

 net/ipv4/icmp.c                           |   1 -
 tools/testing/selftests/net/Makefile      |   1 +
 tools/testing/selftests/net/xfrm_state.sh | 624 ++++++++++++++++++++++
 3 files changed, 625 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/xfrm_state.sh

--
2.30.2

