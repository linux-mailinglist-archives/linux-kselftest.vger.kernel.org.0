Return-Path: <linux-kselftest+bounces-8460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1258AB339
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 18:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E371F23242
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 16:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0E8131180;
	Fri, 19 Apr 2024 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="O8L8D7FD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A92130A5B;
	Fri, 19 Apr 2024 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543521; cv=none; b=SkkR65gDiN8aoBPTNwMGNevkyciu/ON5A4bTAVabxPcMtLxP7nMnLdQSMhqc4sb5VeBNiUj588YpBLHru0CFJiULYQttzEtQLsTQ7QleRUReYJVVdb95x/Vj5DXpF+ElLZzOAltPAWTVwY9B9jeIbbY5PoFFl9quFcSrFiEE7FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543521; c=relaxed/simple;
	bh=d5n73mg0TsW5GuosMrClZ4WiLXJso87FcN0NbBIHvS4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=bg+iT/TQzxNLGwDBbxRJFueC9gPb9GD938qV+m3MLjJL4KWG2IaHPUfZSufF6EqFIfWT1S+mt5XCHoQhCUvTRo55c6L3a8l23dmLR0hZ0WShc2PwfRp64U5VZcdmKh8TKo39/HuKzwr4fXOqH9Ij23tezOocX0JJ+zieKkNtRus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=O8L8D7FD; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713543503; x=1714148303; i=markus.elfring@web.de;
	bh=cp7wx4staeqTlQLIoJHFIJDuZ7q4wbooJhXwZ3E13aI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=O8L8D7FDvRzDbQx8Uv7WkfIulajzVOibFPeUxPDc6Xs2LXI4t1algojKdWOz2YHy
	 1eTWEDvYcWXwM1UCsco8RPjsUsv+9tR2X/wu0s+7XQ1sd/ZMYmoNFh5hVNcCVqeyJ
	 s/p9VaWAyXAetjaXLMfUB0YlS44SZHk8VBcEDQLfU6S0/FRWAsFarlIL3dXfPmN/1
	 UT3CJAbBoNAio01TVgky9ssXyl2Dxv7iO8y2VFtXP0mCTHN03SDqrOsBzIIA7nJvS
	 PRVUTPW2F3tQEgsO6XjetSf1hvsy7/YvFb2HvsbV/guLM+y7Igz37mZZAK1BPCDHx
	 MBqAzwXwa6TCKaEqUg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXGOI-1sDsxt1yZS-00YjnS; Fri, 19
 Apr 2024 18:18:23 +0200
Message-ID: <4dd9babe-1e4d-46d9-b3dc-cc8978e74e5f@web.de>
Date: Fri, 19 Apr 2024 18:18:22 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wander Lairson Costa <wander@redhat.com>, kunit-dev@googlegroups.com,
 linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Rae Moar <rmoar@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240419132504.9488-1-wander@redhat.com>
Subject: Re: [PATCH v4 0/2] kunit: fix minor error path mistakes
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240419132504.9488-1-wander@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dZ1kl0cheQ9TcwOAvAzY8L/APqrmRjRzbU5lO0gAxDHka065H8N
 jaOTnJd72niJ6S/+s763D3sNhi3yfHXE2vALXIkKhaC6OW9GtLyA507HEEILJuDrQBnfPyH
 WCdA25Y5nnpALcb3Xe8hxui96dWz3pqQ1xZroX+wjBQ+LDCfueLlq+gzfeSJm9RXc+n+33o
 dFMuJ+/lPohZnkYYJq/xQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2XhgTCe4k7s=;H2Vad0xjTrY2+MTRzxpgG+Hi6Tt
 RukFgRsyr5MMsS/DW9DZkbkG+glCdye7rzl2Bj9T2/jGLrmIOvBRqd+3DZDRb9DxsXDutwjG6
 4leCNG4FwnsPGKTnkcOK9fTkYZSl/cY18Kk6GAP/cHDoSYRU7NLz9+rrPshf3hE+ZlukL0A99
 xRZRwH1Y2KrkI2U0BkPw7yox3ae7JBiKcpbFpefuTAt0ejo67SW7Gc5FZeurCpxa+7IY7ZuSA
 4xxcjs5n3hspeD4a1Dv04J8rMlriYpG778RcAknu661W5gHUAYFYhosi/vvp0kP5iiKjHJ7L/
 P0MyGUcCb+ChAB759btrRTigx3vM9QWictiymqrDKAMQ3yXMpIsntjBE/7WcZki+45NWx0hZT
 K6GeTi/uqPBPPAQTos9yf7VZrjP5biuhlL/4Ho59KzMNIU0iXhU8tV+q0mwPstZNA1+Xl2K0N
 JpKRxPTaE3v1VOU+beg6Xb74fAd5ms20ehEMIO13AY5CLsyAJn5o9kd7OEaSXZaZU96Hfo/aZ
 maOStfC0x7ljsgSI88HgbKSlRS9Ephv8CANBpTsqSTocXEELgNW8c8ptAmoFwWZnTWU6mH6RP
 zJJurdqJX52FrdKRYh5MvhaKINIuvD2A4B7aX37P4k/H0DfXfpAvWmbYdO+N8caQbzTWz53ky
 7ysAfGFZ9jsyOTE6lhQxx7iL9aIe/Ya4JJ8BWvnfliMh6BdiC7cb9Q/RPOPyQvFgkJm7Ms93r
 O4c0IA5HLELgzXCnFmxR4n7onhe6/wTmDVC/3x1l3o1p5ksPYanvsIYA1eb3oRduHBaognZa1
 u/bB0lyz03QMtDvI98B2cPNx9BD2Sdo9kHOIldYI8O4Sc=

=E2=80=A6
> * Remove some changes requested by Marcus Elfring,

I became curious how affected software components can evolve further.


>   as I was alerted he is a known troll.

I would appreciate if this interpretation will be reconsidered somehow.

Regards,
Markus

