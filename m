Return-Path: <linux-kselftest+bounces-37379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD03CB06667
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 21:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC68C1734E5
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 19:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8FC1EDA3C;
	Tue, 15 Jul 2025 19:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="YlqART+8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747371F19A;
	Tue, 15 Jul 2025 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606069; cv=none; b=SwoBYjo2Uwp9gybbGLreqWkyINXmb9fGmUz3KRPnj6IzSrKKkPxEjWC1d4u7CpSiGR7cSopEhlpfST8I3VvOLQVjJP0R2lmWmargkcFHqo/bV3M1FvOObE0YZywDJU104n0AJspNLTvmOFdyCScFRV6UNwJhE429NnAX8zuubs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606069; c=relaxed/simple;
	bh=DzC7FSQt83sXsaK/PxNQFpXQ0m8C+erLEI5dnUrtrxY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=djw4d25y0n1h5vvRTkSy3cgC7MWd+SSJDhicLvbbjdDJ28lTsmSPUQ18Xu+b1SkjUolQ0S7Dc1GMn487Mk5X1QWpqnaRDgRfjMqBbo7RT4gxiH2Qh6lRqd7TjQmnKRTpPkoGaRhoBF7GR8NdpGNQWFLbdOLC1LMqnjflrOgPydM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=YlqART+8; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752606046; x=1753210846; i=markus.elfring@web.de;
	bh=07Pa+856qEFo2V8QLHWyjRVReH2nqIS67HTT5nxhfOk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YlqART+8hV4BjX8nIa1p1U1XIq6cMK4oq/sNYbg+BRCAgkbFyU3hy8SF6VJYB6Bd
	 j1zljrTLkiJP4BeqcT4Fxu4J+tcjCd1VzV6GevRjADnnfYJkkusgl6h8hxuQZwD/9
	 g8KGrSHju4LPMI40i/se8wkgTluvtmSKUm+Gio+6bXt5pu6WR7YdrFZAueSWehD13
	 nji8FJe9Cn4QCp5mGTF6nfW9UmUSBK2ygpELGBG5hinTScx2L4JZvB0FkrZTcozuY
	 etYcKaW3ykkUB5LAurgQL3gE4BeE7vNB9pPE2ibwgxSeTtftG6rNM0jk81EOjoj94
	 RnDYwDzn/nPjeX0t3A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.1]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmymz-1v0bWr1u3L-00dCx2; Tue, 15
 Jul 2025 21:00:46 +0200
Message-ID: <01498bc3-4885-4b6e-a437-af3dca58f187@web.de>
Date: Tue, 15 Jul 2025 21:00:43 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Gabriel Goller <g.goller@proxmox.com>, netdev@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>
References: <20250711124243.526735-1-g.goller@proxmox.com>
Subject: Re: [PATCH net-next v6] ipv6: add `force_forwarding` sysctl to enable
 per-interface forwarding
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250711124243.526735-1-g.goller@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7kGtyvJj1FDTVdwnxIFDmsgAERx5RXZBaqIFcRPYJYMOMJdR7JC
 0gOhI0j81bFvBKKRANw8p/bqAJv+UhuNLhig9jvowCOr2T0tB3tYYTpQ3pnCakyim5XpjRy
 9iEqMkoFME6TaZ6DH6GzhMuYVFKWsWgcxEZbfZuJHPz0KJvgo9oPNwIMIaBlFWqM5DhR6/x
 QRjrO4CZCd6QmvTEXiJww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VEMtaAZMOok=;kH4kcySVQdCULVBcGPtpLlS1G41
 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
 5JzMNgP8gGUPlSzbQPlPeZJkIc20C0SiANI

=E2=80=A6
> a netfilter rule. This is especially cumbersome if you have lots of
> interface and only want to enable forwarding on a few. According to the

  interfaces?


=E2=80=A6
> To preserver backwards-compatibility reset the flag (on all interfaces)
=E2=80=A6

  preserve?


=E2=80=A6
> ---
> v6:=20
>     * rebase
>     * remove brackts around single line
=E2=80=A6

               brackets?


Regards,
Markus

