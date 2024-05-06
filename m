Return-Path: <linux-kselftest+bounces-9519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1F98BCF56
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 15:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05A41F22335
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 13:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981B178C67;
	Mon,  6 May 2024 13:42:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B42C7603A
	for <linux-kselftest@vger.kernel.org>; Mon,  6 May 2024 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002962; cv=none; b=Hu68401V32BMONYGGW9FXREk4TY4JDP1yrO6iLbpC2ytI2Z32a/NQCu1wYiGnugQ9AjHwX+AmGJCX8YT39BzlH29435KWTBFl84TjQbjcBb5VPNx5XUqeqx9BbP+wQ7ck63C5HEzbCuwbM+knJ1JzheO363uv5IJBbbsoOvJAgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002962; c=relaxed/simple;
	bh=G0bIv+NYyvixpUK/34pM9QfM6349d+1xEpfXdS7ojN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Zt/t2c55cJZIBPMsaIgNqCTqfPo6NZ04lDXlHsiW4PFAloNiARZfZyXVd3Z3R1vWM5tL/7e98DZUHhiRR0dnrc2GSy1BbKWdcGeJWUs8dwsK9Vb6y0zGx9mV+afuxbebAqf705/QmmgiH7M2PwnBFlW9CPD5UedstqHYgAOOO24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-j3iHDVvWN7W5mmZF3dJa5w-1; Mon,
 06 May 2024 09:36:19 -0400
X-MC-Unique: j3iHDVvWN7W5mmZF3dJa5w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0429738000AF;
	Mon,  6 May 2024 13:36:19 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 04D0140C5C0;
	Mon,  6 May 2024 13:36:16 +0000 (UTC)
Date: Mon, 6 May 2024 15:36:15 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony.antony@secunet.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Shuah Khan <shuah@kernel.org>, devel@linux-ipsec.org
Subject: Re: [PATCH net-next v3 0/2] fix icmp error source address over xfrm
 tunnel
Message-ID: <ZjjczzsSz6wwUHd5@hog>
References: <cover.1714982035.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1714982035.git.antony.antony@secunet.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-06, 09:58:26 +0200, Antony Antony wrote:
> Hi,
> This fix, originally intended for XFRM/IPsec, has been recommended by
> Steffen Klassert to submit to the net tree.
>=20
> The patch addresses a minor issue related to the IPv4 source address of
> ICMP error messages, which originated from an old 2011 commit:
>=20
> 415b3334a21a ("icmp: Fix regression in nexthop resolution during replies.=
")
>=20
> The omission of a "Fixes" tag  in the following commit is deliberate
> to prevent potential test failures and subsequent regression issues
> that may arise from backporting this patch all stable kerenels.

What kind of regression do you expect? If there's a risk of
regression, I'm not sure net-next is that much "better" than net or
stable. If a user complains about the new behavior breaking their
setup, my understanding is that you would likely have to revert the
patch anyway, or at least add some way to toggle the behavior.

--=20
Sabrina


