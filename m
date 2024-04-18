Return-Path: <linux-kselftest+bounces-8357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF158AA1C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 20:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9657FB234ED
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 18:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3DB17A92F;
	Thu, 18 Apr 2024 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="bEsc/JMu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06C816191A;
	Thu, 18 Apr 2024 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713463714; cv=none; b=OnsyW30yGlKtna7ID+p+dePHmn5xvhImnYVJbiTHPnYw8hDFmbEQEFR+bpYCuRubbjQtRbnqxnQaJ1XqBaS0anopu6nOz5rguDgaxpgwMHyazk3q65qOIfPt5EZEEFLNzTDcSM6+64XELofWkvNz8gkIotx5rSKHjkl2m+YBDzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713463714; c=relaxed/simple;
	bh=TmjZljf0EWxiHwGWUm5LZmE5fNg+MFxFKT4Nc41DZ94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mg8t7cwhEzmIMMuH3TXSVuhQHOCMbVD6SObcaWsIqNNXR0LB2nCzjjURMC9SHd5UefeomlauTrBIpDjNpqd2PjbNmy1wEaiFZIOgzZtAlwqh2wsXUOlJTZ33MrZtksUc2RLcNbcGsDSceU1ui91xxwobJR8pXjzAAY9J9Q5ez0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=bEsc/JMu; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713463702; x=1714068502; i=markus.elfring@web.de;
	bh=TmjZljf0EWxiHwGWUm5LZmE5fNg+MFxFKT4Nc41DZ94=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bEsc/JMupATmoAxm8B2A8XriLdLySYnEDhNpv8wE/st8wORDbhodltsGTmTP6wLu
	 fClEkK6ORgs/4GNFB54RIzTf48ZXd73AkiDP9sa/LYAnmxeRi+j3e9Rt2lsduzTAo
	 sbtgODnPgslXvBEhPjOkZzPVNijIZdeTc/z9U4jOafss4T+OL30O3eazSYrUtJhEV
	 38nVKv5NI0wiuPK87hBgAu/VJfURA97+48Q6O+YE4nLlSUsilz7+xpruDquw5gg73
	 JRhyavlyyuBVZY3jiVtpaDz/DhY7TRb2BrUc0++aW5pIfJMVGcswiQeG3teDvREVv
	 zeACTy2hl4RwOhfTKg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgibY-1seaAE1hCG-00h5rV; Thu, 18
 Apr 2024 20:08:22 +0200
Message-ID: <24b3851a-b5c4-4c53-950f-bb5da1a32e11@web.de>
Date: Thu, 18 Apr 2024 20:08:21 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ 2/2] kunit: avoid memory leak on device register error
To: Wander Lairson Costa <wander@redhat.com>, kunit-dev@googlegroups.com,
 linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240418131754.58217-3-wander@redhat.com>
 <9ff84256-c7d2-48e5-b06b-09a993db2c39@web.de>
 <CAAq0SUk7nJ80rrMG+zeVi-XReVJ7sdWTAT9fmi4E+LpYAYa=OA@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAAq0SUk7nJ80rrMG+zeVi-XReVJ7sdWTAT9fmi4E+LpYAYa=OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:twexNX9VepwTcqA7qEc4TIfag0nJfenHdpr/TiWekFjawHJGSxN
 UUr+HHBRkY/Apa9ofmHZpr3Csc3bovvbecxtntMe788k+N3IWuLQGzQRRW0rKaGnJlYeHIj
 ppNLvuzE6WpcQSiDXXU3JdvzbtVzZ2jfXz5+1ytMQTWp6qyXSsIr+ijR3ch9G5juztiKJd7
 Hvd756os03ZgRZFgyWI3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wtzbIy0zubc=;CAfGe7b8AUBGtrOaQUk906NOSiM
 /egr2aEV5fEIAxAB6/DcT23IVyOssxCYTWGPpnEhIGzvqMoHWDky2wFlQ7fjc1bsc/BnsHAVN
 f9RE6NlszPRTCj02791XHyZS5rXo8+FW5nmQWPSWb+gmUB3h5qwPgn6B2tUVEeg4SS7RRDQNz
 2nkCrRKunerBhuCDMQKkmfSBeQEM1bw/rOok1aAKklrDHV1MvL6fya0pg7fM7Vz8jEG7aHyu3
 rGW9dDjqg6BKjIRAsfOlVy7hcxjY0uziI8bFGRkwEgjWLCTVuJVl38Wl3fV0XiHG6E+bZWkHJ
 tTxSCI/QXypZNDUuqqvVqWLhzQ5W7NWQVMfgSZFJgwN5+8mmcgBqnM+kfaLo9+Kwi+amficaD
 pOB8RlHjBqItq2c+xpfsEMCKi/ZB6b1aD5tDi5IMoCOQ5XUdQdjX4K24VgnWy887TEeCNpfWn
 uvQXwAE+CP385JfSAQ2Cg1NNgLIGLWUtOrju0RKLEF12KGXjkZeQkYJZLRv9uT3+Tp9hqIlBs
 AEBQMrr6oX72PooTPfK1EHK8CRSP96ftqRixYgas0AHWXP11G/A/HAsETGCnXtM9X6q7kPNF6
 oSM7iDE/+B4tmC2963/qH3G4w3ghvQ/Nsqb9fdJID5M82/PBqIRFW8Qkj8ZDigXj64KDg+HZB
 2rysc18b/cnLjC/1WVAfgoGnA2GKwv3unrK8HSzn4VCQJTltymEXVyExLDimKUhg9iSXGUYJO
 ddPQHDSxLA8mNrX1tv3OLd9S/vAkI0ZRuuEZCYakv9dPKcAQ4mDgkBqVBAdZu/8Jby9tOotZY
 H4WAjOsXwib0JqA77BoVq4PEx+9uA0ED1Ks9eWJ3HoswM=

>> Common error handling code can be used instead
>> if an additional label would be applied for a corresponding jump target=
.
>>
>> How do you think about to increase the application of scope-based resou=
rce management here?
>
> I thought about that. But I think the code is simple enough (for now)
> to not require an exit label.

Please follow a known advice (besides other recommended improvements).
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es

Regards,
Markus

