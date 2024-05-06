Return-Path: <linux-kselftest+bounces-9506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CC38BC8E5
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 10:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7381F225C9
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 08:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478EE14388D;
	Mon,  6 May 2024 07:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ap58yHs0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC451143866;
	Mon,  6 May 2024 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982355; cv=none; b=eL/lL3Ng0NNCFgqSiXThEIb+xe8Tu67O+TI3lFf3WDeUxwrLaFO2LUt8230aZqjMOkZaRGnyLf+Y+Pu5XLhNyu8gXL9OpywbpZNDZhbfU9QwOH8h36fgKvPlAILfIfREb1t5XzZhL/Hx7E1PoUnbTz7KoAB1uwvjGPFW8BoAN3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982355; c=relaxed/simple;
	bh=A11ir9HMZk5lFng003qQQyACRtudDztOHYJ7m/5Rwrg=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tJIZjcKSpUPw1bQKHKaIOISdS+Vfih3tKZnx/1L0itD/hF9y0+Uw6wCZsyGOD2w3a45EQww1f5jQdjdrorntxewoV0ox+CxbJaMP3j6cVEumM0vRqyv7726Pr98/WXhGC7zNDe0bBNQuLXlarzYAATLIKi9UtC3Ty0CQTsrd190=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ap58yHs0; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id C44A320748;
	Mon,  6 May 2024 09:59:09 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oXQuNdqcWq6Q; Mon,  6 May 2024 09:59:09 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 3ECA3201A0;
	Mon,  6 May 2024 09:59:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 3ECA3201A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714982349;
	bh=BAFIIitOUDVm50DjLdvw1dgQjq9vvNrMzD+TCwy8ybk=;
	h=Date:From:To:CC:Subject:Reply-To:From;
	b=ap58yHs0NaqM5j2uT3JX7GLjZ52+Sypd23Nk1WnEFAJjv70DP17XHuDHEqFjdFvnp
	 uRw0LUR1S7MlMLOVn9oocFytqqIssI38oW+3ocYAhymAHZ+vSH/abeuqCMwdM0790c
	 0eZNSHZSMBiY2efm6p28iTsumCXBloL5T+QZnEfF5rgfxeOCUyIHhiXnYvd/71Gusy
	 2vBNqjV0lQH2fCboJc8vm+gYDxnsKXBtBYJc4SW3uxFjfcMDuuwp6QLcXALlv++SFG
	 7zssf8PJ86X3Dw/9h3j03CDSq0LgFhJd0MkpBgsklP8V+jG8VpigfoQ84jw31MbPvg
	 diQC4UiCyB3FQ==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 3187680004A;
	Mon,  6 May 2024 09:59:09 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 6 May 2024 09:59:08 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 May
 2024 09:59:08 +0200
Date: Mon, 6 May 2024 09:58:26 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Herbert
 Xu" <herbert@gondor.apana.org.au>, Antony Antony <antony.antony@secunet.com>,
	Shuah Khan <shuah@kernel.org>, <devel@linux-ipsec.org>
Subject: [PATCH net-next v3 0/2] fix icmp error source address over xfrm
 tunnel
Message-ID: <cover.1714982035.git.antony.antony@secunet.com>
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

v2->v3 : fix testscript. The IFS, space, got mangled.
v1->v2 : add kernel selftest script

Antony Antony (2):
  xfrm: fix source address in icmp error generation from IPsec gateway
  selftests/net: add ICMP unreachable over IPsec tunnel

 net/ipv4/icmp.c                           |   1 -
 tools/testing/selftests/net/Makefile      |   1 +
 tools/testing/selftests/net/xfrm_state.sh | 624 ++++++++++++++++++++++
 3 files changed, 625 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/xfrm_state.sh

--
2.30.2


