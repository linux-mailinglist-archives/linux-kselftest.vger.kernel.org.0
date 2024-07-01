Return-Path: <linux-kselftest+bounces-12987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB70391D98B
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 10:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4351C21600
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 08:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7580242047;
	Mon,  1 Jul 2024 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="NPa412Fr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF251EB39;
	Mon,  1 Jul 2024 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719820915; cv=none; b=OK6kWvZvgUKadd7F5PmxleY5NgJYRh5nzYk9liprDaCov70LPU9RDlHrxpXElgxzIJZi3oaHMAtaTMrgqH2KDdBCg25+IgSqIJesqfzGCOzIlOv7OC7h5zFy0wXSFNXlEYwAkRwfts4dhRsQIm09R65w18HV5qwVQ40Nr4MGhNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719820915; c=relaxed/simple;
	bh=vHZsiYbVuLK8PNijbZkO2ITL1Z6pcGf5q74vYq9jzEg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=hCLiEDj95tJZKQnGRa63VbtuGzSVmcYoDMqIrXmQMlE7xmSiFiPzq0lJbPV6c7WtU7E7kVZmLI+OiSXFkP8IVvsvEgDdVqlVLcBggiRa8iksnaMddyJ9Bx/opR0KnKKXTrP2H1LIVTD8r7CmiCNBOP+o6GYmKt1VE3z/4W146fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=NPa412Fr; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719820885; x=1720425685; i=markus.elfring@web.de;
	bh=XMjo85fqdujP80T25ZWnN55NRa54zLobA87TTomVDrA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NPa412FrmCBZuIGal3jrn9O06XHbIqxQWQevki1VbsLVJ5rDdS6/Q0xok3Bjorzf
	 DIsJJC8QA2gO6r4GDPoa2GVAvuDmcyTdjIsSAAfwUG8Mmpmzlk7UPQolAwfWsuBZ4
	 aomV3oiNogFm6VXjc3jQG2QoSVUkA4RR+HuvGvm8LkMHnP16cjeRX7Nc8achUdpiG
	 HqFENMiIq8zB8IvaCRzYuam/VUOMzgmcw8b5zb4BgJbK76kPGfqfpqWOrwfOMP/yP
	 2IIwfhbmiMn9BXmjt8QaMrxfCx4rU/31Zwol+5wXTeALBCnwHWAU3isDvuzDLfZen
	 KO9MHMcAu21h7WpPjg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsaS7-1s8aw22d59-00zkZa; Mon, 01
 Jul 2024 10:01:25 +0200
Message-ID: <a194b5d3-d3f8-48a4-a010-d98381107b80@web.de>
Date: Mon, 1 Jul 2024 10:01:13 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Ke <make24@iscas.ac.cn>, linux-kselftest@vger.kernel.org,
 Amer Al Shanawany <amer.shanawany@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski
 <luto@kernel.org>, Kees Cook <kees@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>,
 Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Julia Lawall <julia.lawall@inria.fr>
References: <20240630130038.3671507-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v3] selftests/capabilities: Fix possible file leak in
 copy_fromat_to
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240630130038.3671507-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ITtbtaJRixQcC4ydQvWAh70vkNkfeTcFFOSJ+GWUnF3ZF7ZPydo
 iv9KGBeu0yaw+ZcByKAnvwFn1SaSqT3D+ij7Wdqfz5ToAAYq4q2lBfPHH1OW4wjEBPuFoqb
 Zjl96yT1l3VpqNWijbS5KiGTMPWlDnbniWZkJsiJ5+S4imLHpSiU0SzzIpTgq7wNBmdaj0F
 LI4AEC1n+35wXxG9SIHQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y2osiQM7q8c=;1aLLusO+miy302MIfA0gbIrnF0A
 BRAcS6kQibZuLPI9SQ0XEz/rYmslI66qtnLOpXUsiAy7IbSMEFdYV9HXNcxCp7JA9FEldlm1M
 0WsRd1pCBE7x9vhZ8iNqqbatNkGl7Tv0oxaV82ERi8WALuJq3xwBvHFyTEI0Iz8kHsu5g6LCC
 FiMQfO6YPgsnNgH1t7fvYTvOVDvetlxQX7ep7U4lIjvTopnZN11u3fnskr8i5ci/JnTDG/bVw
 a67A2Zhk68LHUmq4qqSbf4gYM03eKhjpKxQLyMHFRzA3av6ZvX1vGlwX5G4nHuAoxULXmBi2g
 trlpVc6L5i1qn5vNpIgHgfxIEGDTpf2yyJAhSIHGLYD6NlmSf6CuzwGIwH7Tl91cxrpYKe5Md
 yCOIt+G7zSL/w/l3cU17iBSzBxLVIqClb332iWI/K3nJRl5kX/ervhyzOpIH7xWVJlpMQh0oX
 ClLYQmjboR9CXPMaN6jvGUnwrGlBeQbSLu0onZYWxm77JSUHTl1RcFRixBU4mdYihFFK0V0XR
 E8ux8/AO8yhjNLVKvJmXZP924bnxTJAP8rpU/oLMnIYQhf6APShgNcia7UT61/61nNKhcTG0e
 C6XRYeT7g245SMYwmK18EmMsLOmqiXorWhZ9/ZAAxeaTnnQiHYSGoo9C+rE4PGBtyh1n8MZsv
 bAhr/cB/Q/LV3sKgWgaca0KsqGyfjo/yOx9rc1ZeT99fAwQzlmISheez54jY3hWfTi7yL3Bv9
 cDzzTxK8dGTFxrE7K+/tY6XborgX6KN2CDEt4cRuvIgKli+ww3DD417AmzNzoODKt3nCe5kY6
 CJ5zeKTCTrRHKbP9ZFASljiv1+fJzQ5XXgzzkzDfcHdQ8=

>                                        =E2=80=A6 openat() and open() ini=
tialize
> 'from' and 'to', and only 'from' validated with 'if' statement.

Why do you find such information helpful?


>                                                                 If the
> initialization of variable 'to' fails,

The variable assignment will usually succeed.
A stored return value would eventually indicate a failed function call.


>                                        we should better check the value
> of 'to' and close 'from' to avoid possible file leak. Improve the checki=
ng
> of 'from' additionally.

Please split desired changes into separate update steps.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc6#n168


How do you think about to use a summary phrase like =E2=80=9CComplete erro=
r handling
in copy_fromat_to()=E2=80=9D?


Under which circumstances would you become interested to take remaining
patch review concerns better into account?


=E2=80=A6
> ---
> Changes in v3:
> - Thank you for your interest in our vulnerability detection method. We
> extract vulnerability characteristics from a known vulnerability and mat=
ch
> the same characteristics in the project code. As our work is still in
> progress, we are not able to disclose it at this time. =E2=80=A6

* In which time range do you plan to publish an official announcement?

* Will similar software research approaches be discussed further?


> - found by customized static analysis tool.
> ---

Would you like to replace a duplicate marker line by a blank line?


Regards,
Markus

