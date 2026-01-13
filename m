Return-Path: <linux-kselftest+bounces-48843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B39D17C53
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 10:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F466304D4A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A6B387345;
	Tue, 13 Jan 2026 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DvAK00ee"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C133E2F1FC9;
	Tue, 13 Jan 2026 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768297589; cv=none; b=cYQQ2sS1M2UoW/iyalj8yg557Jbr6hLCW5ApAxOvv0m0BmEPVowqydvEV/LAy9KVXkMans9ADzSCahUKh7WLlqMTMV2TSaCZ31iTRath55VfKemW3R1ciyk3NwN96F3U4g1Apc7WVOtXwXE/e1qxK5SCXqIboWVteMR6RoGgVLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768297589; c=relaxed/simple;
	bh=WBXEgVHWC84VgTSSlpHKNpV0StmDXPiNGP06GtDnKiA=;
	h=Message-ID:Date:MIME-Version:Cc:References:Subject:From:To:
	 In-Reply-To:Content-Type; b=usYsDLU3USP2cN0zf9hVMdMiT5Ezc4YJaG4enzVaZpvn12inav1DyAkJg7expSayYhNUGr/kL0Zf5JRjToZNMGP7bPGulEQwMbC8OywA1Uy+Iqad7/JzGnFds7I9KTkbXYHtPMizh4yn6cL5SEv+rn9vlIYH+ysY78dY0148Y3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DvAK00ee; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768297580; x=1768902380; i=markus.elfring@web.de;
	bh=Jj84gbOx4Ct7lfUmxsO/SAuHmlAz+3I/LsTKcGdmQ84=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Cc:References:
	 Subject:From:To:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DvAK00eeh2R5ZlEmp/5vk9qWbRMK9Jui3b17cVsLXKQzvSmlAYCaBDIMQU+hhxZW
	 V+9ipGzqCmxtue/P6Np+DvOzUkOoiMbCoojqZ7wkQln1VZj5w3+giiBWwhTMHNTT4
	 s6rzR2g5ed3kTG8l+mb793/kM7BmWTQZO1xUwr2wyqWq812vSJUMoIXn/P+aReIKy
	 tcF51zapN8s0Xjn8FH8RhR8yTu11Ao5aE2P4KZJWrrZkwY5eQYNS/IwgQuCBqI1ir
	 VDNJKW99Dv1FmOcu1F/LT/tXOxiLy2M1XueRKSEHN+I4E4rckKNOKL6hcDYT4MMmW
	 el1dWC5RMh19b97h5Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.174]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGxMN-1vawPI3nxz-002ebR; Tue, 13
 Jan 2026 10:46:19 +0100
Message-ID: <88ead962-fec5-4834-88af-c478ee2bf023@web.de>
Date: Tue, 13 Jan 2026 10:46:10 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: LKML <linux-kernel@vger.kernel.org>
References: <60dc3da1f913aa9625e864ea862c23c401e7bc6e.1768207347.git.yk@y-koj.net>
Subject: Re: [PATCH net-next 2/2] selftests: net: improve error handling in
 passive TFO test
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
To: Yohei Kojima <yk@y-koj.net>, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>
In-Reply-To: <60dc3da1f913aa9625e864ea862c23c401e7bc6e.1768207347.git.yk@y-koj.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6nvAWxGYrxSW2G13Czqo/6AaqmVOFrdAhI4tgGI4ItTCnf/DIso
 8CSFHEITfvWleQN3iP9Rmd9wKd4kLMvB5A63s45EZUYMH2RPwXjn7UFBVe+ZEFd/7lWwdO0
 b3wM/1LE+LFiz6C6Nsl2eGtEx/qpxK9agAi7UbdXfZKk95prJ3cDutKoroB/C5yvLuxUqxk
 jWfZAAGmrrD44sdC88uZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mb+dNvivDfI=;bUnAjpq/sOxVl+puNm+5ZAyEIX0
 LVYSqlZAlVRE83UbqVnczYUcl2YpYMueL5jeMFKOl3fmFduazKEHroiBkSkUw2K3mLl0u1lAC
 HZK4YPeAtMhDoLgsFRI1yWjYmJMmNJFbqp7A54B/6E1Ol+jx8cudBLb2MEyuUaOuC2k2e4mBa
 7xtSL/y21mB0oqYr3jB3LP7Ie7Uj/ugOxr1TIEeZNGkcFuVSiExRms6m35DaHgWQhzLT8zTNy
 3Q4GcMwM11rzTbDa5MCl4erWJyjC4vlwtRJg5JFxZkymZli44qwL4Cn6Ny/bWoF6glA3R6rGu
 WO9SlkqUId/d3/8tqf1Yk8+zpwGfRTvE1fEN78vBSbzfqsHffi7Ok6bo9brzWB6O6YsXkrCZB
 V7EedHPPyA4x+hm5wc1fGBizdv7RDjG8SDjQ7HS9WDTkmufZS623wJzUG+0Ve3+TDlvJhkmSH
 J2C5wlr6tyHu7z7jdq3S7qUc+1xNb79c7JcymjyPKluiGAFk9pqTKD2Dx7Ac+2UTnOYLVBsxQ
 Mfw8tCpcc7d04//g/rWbpR/zSZsXE/3/ddPAf7F0yiuo0Nnt4bG3SkRWP26lbTS3Z/1CNBtS3
 CjXqzn4yRuohSRX6sRAIt9AIBpsRh8GZDv9npIbGDxFgIJHujyGB0gm7YkhxtEDI5b+DaAKC5
 1WT0FsVaWhpBo34rL6MwY74u/5YjyudIPUPbtg1jhXwHq5gGyWTtr05RqmdaarrI8Pi3BWkxE
 Tpr2OhgLPSs8JtllA1By7Z9lOXuxILczg9NJRrpg3J53dEB85Y3uTdYsWEPoaZFvhJ28kHHMi
 TUjKM/qwzAnHsD67b6HHWU8158RVgDRLLIswKbUFJsLW43aSYycBj7yMiahaINONcimNAJo3q
 ZnaNUH5anphx3MNA0vohgwVP/d4F1EwXLP9MQN6GfL/RmKvZSAVdzItxcwkbxSKpuZ3w4O6xd
 jTmoX+Pz6NvpR+Iq1jihLzhRmwLtcYP6OKFU0y42TojJ7b4kS+65n87IHrzbarWAjwhkzicIo
 eev8eKsEMq1dU5+FBhF8bO9t8hnSXZh33OuUwlfMIdEhSujbS3kKv56OlepzkjEVVNI9ecOKR
 xpVcH0MALgPbvTx9D9tv4KUk+7Syq7bm3hbjGRds9vhzd1Vysqr2gR+9k3kHyDqXszmA+p5T+
 LjFZtVIAiyCLieYFFQ23aDQZ+AZGTHMDfa7OHv8JNn5Uzd0uyQwe8zWEjFOfvng57frXFwYtA
 GBwpUXCVA/sKxapJ9qZnWHY/xs9gz1KzzNn/JAKRjoD9RS/xlyyvck864nkFzMHubFPqNZvNV
 SZC77WKp6/Ce2N7LneJz4vy8JSFrtn9rsobjbznWhRtVEo1vOUgsK7NHZb734PklgsHa4B6Ee
 um0XFi0/+BFibTsaQTKjn2X+CRu7dlLKMa1VY7xwBVkfkCXg1fRr2FHzY+fRfXthO/aYOg3cn
 rhl+B6USn8nKImGbF9iTk+E4VT2B8YsH5Vf8ZvhCgrvBzvP5VPmcZsL7DgkkkvJ4foTIDVyLv
 ariav3AJTt/GCJjChAV1Y5loqn7u1qa/8shYJkaXAPv3yrYdGernZMP4fRQ39p115s6YuGvfh
 d4CTzgpI9nbD9DcQict9hyuY4AVKUqaKrDiw+sJeiBU4r2NBSvUoDDN0kDbgpPWiVc6a3Lsid
 rPI68esS91dVylqFKp142VxhVpTvwa/ONuzx5fG80VUaXr8udEGrt6q1lw/bJSMaJs2WDvlNF
 mH4zAIR9T4F+QRcTrqqW045I0nXiROmPzsnGHy/n80f+MHykOD2S8JMl9JgFfwm9WgXIdnEmo
 os1Ne5joRT8gNnCLo4blhmpvhVOGr/H8e0RFbjQegiP2v7yoqKUvubuCJCaAIha6wSftVp/jU
 6RjZYZhoyiylGBv41j69B5fRMXibugciQt5uNIbNHiial5DEKA5wrjhftbUqSx6JadT6iMCdJ
 qnXW5RKNa02fMuESZkfB6B/DjfekuTHt6XrPNiozgUMxoqgDH0l7JZBAuEKiAeYCHkazMI3h3
 uXJ3KBlbQJduRfw8X1+jOdbPC7RtZaQIXzO+3ATv+7AMOPXNCK0NN+xYoF/tw6trv2yaaRvzk
 rpIQ0MUWFXXl6D1ei9zP1fOQFeoyPY/kqvzAnJL6lsaoEFFgivfZEV74HDRSsEibotHsmA0d0
 Ju6nJ5CqCvtf33HEwQF08knh5OujcL59WH7dTMw2C0ZvXFXfE6k30V1PbiqDV70erPO9BLHNF
 uj/4KTf+opgKyev2VzPoWg7cbzgilOxxGTS3TYsCgVVJdQUppn7pSxwTRtvd4qppZtBjGyvzu
 rxPibMfThD1X6tx3NFhf081qhkSGex3XB4/CSEkz6JvgZEyIj1UguqXRKTDfjcOubcEDdp59g
 JWL7kDfyDXAoSTWoRnMxdafPPGdWHsLEHFOqNmAXbr1HTbVjNirt3rNb5KqGR54dBnhZEemwR
 rKV9bJiEs3GSfuvpeRbPlUsXSd8kgtjLhe7TxzODeYglnWNpeh3SQOHq198WDFNXDmhV5aKlI
 ZXNpbEYoqXSFSvOxszMeG40SyzTBGJX3mpgafFKxr1OOL/tm1iu6nrgmmk4A9A58aSAbxA9Ma
 mRA6V7xIee7ZZjvJHhz/sxu7xIrygQ2W7aoAr40un9zzpJS2ebebtxfP6IXbjmx/TPJmtU/h5
 woXR7Uwxc35S6JkQ+VYnAa40+hk4jPYLNUdcbSB02ZpFz6gbZE19La7Fc4bSdrcAoMH3gSkUM
 6+JfcIAEx6GUXc8/rJqUHedF1tAXab5T4Yl7iDzY/i5WumkISNbe/FarsxoJ9cjLlXMWLzIyt
 +C4wqwB5qT4Ja4Mr1qqDueKRrImf6L1v7I6JUC4BkxKslSqvBCY27FZJEOUUv3wdTFkHZCCgL
 QH/0rwqRVAO08FaMzxnMFt7rWtBbzPv5U27UyFXAovhAEsFeVzKV/WUF8wOXJQDUMNarungpV
 F/6JK1KFSorTW7956s66mj1dnd5wTBic3k/ucIsY+DwO/o7wvqMRI35lCuEBs4zf/V83pWsQy
 AB0S4TNfgwpcX/xkdgHU3IYEvBoatvRYx5O11xs19zH0+bibpfPkLG3R/DYfEP1nSbzFNznDv
 m32dCOcV6VN1Xpi0a8+gwOuGMOBl/YswFnOWe+IEqZcV80sUUq1vA+9XsATJZoe8sJtTq1kIf
 knrCWkWt1x/rg9GBFnihA05+N4ZhpoYaGslMAXMn0ANgLxjaxrXNY+tvdUbx90zoK4W2wRjVf
 7pT8RpP4m9/8tISTFqH6zoEV/seUuraPj5pFTyK1v4CyubHPK+ql42hqGBdtJgsYFlGun5UO3
 5lXW7xw1fqdxEfWdMQ7K9H8VRGwyPPvKJ/24BYLNW0l4fe8G8nyIKUBmt4R9xVTicYVBxG2Mv
 VFnrXvCQz/XcphHh6oyNeuZPA7sFwASU+6nsTE8DFdhjdyz3JkEyy45RlQXZH+x8iM32YuoUF
 CoY6ACnIWk5hj8nzLpLtNFMHyE3f3ebr41gyj4T87lnL22HHI+Ht27mQT0fdImU09pu5gcW1P
 ih5jbLF6WT+1f41SEiBgpjvJFZWUDsVRaFYusb294/EkuzGhdgXO7qlzfMX05/G7GsAiURZXt
 OwSv8VmnzKDB1dwRkVPbvgCKnTIKaT33R5Phs7PDxaFnMT+PlbyVoM+hzeu80jtglP1UMKDxl
 hO7cbsD4FMBcRKcTueYU+K01gFG7YYQfxdtdN7FJuDlgq/U/x3tLP5Bwv0zqfURAHZ0JzHzLg
 L0FzkLARfG8oxxuSGmFPEt24w2lOolevUw3YVVXqGZznnzmzY2GNZv5OtJJ3foRc0GGhqyOdI
 Hwfw0HVizlc2cs/pH6j9mQTvxBtw2R/UUHAt2HR4kl74Zhyzkz7ZROVrnG9bR1locxLSI6/LU
 L0ptFsD27WOaSdYWyqlYuTptq8mxiZJZXjWpGrtdMHk+6g+Oqhl/WkNt0ixoPfTLx6xH4XojK
 WxcFN+hsORbeJBiJyaP3NmXKjDDeGL40Bx9UYNs2yH0dkzWAO5qptxb67a+GdCVk+mr1Z+iL5
 zpYnue8TXpYfDkPoqLQLNjEH8P6iQKIwZb2V4+AFrWpgCUBzyHvME3as/C3KjsQn9kVmx4u8z
 Uv7P2RyufpKH32zNpFA/wYuy7iDCnm5W5QTlP7KUryCAZOBidVW++EspM6NoIrCUZHa02yhK+
 B6ymoduywaosQ0reocLUK/PiyUeSqCEB1tpJrS7Oi4zyvoCLd3hNPxgmHMZtBDSKxuwJ4Reus
 UotD9PrpN95YCCViGpDPvpEttZMzV4HMN9Y9ilIMAYw+oyTZaSaelgyY81Fm9PlnKx+3u1nW+
 AOLT1pr3zM3DOMiQQovXDx7tYya9ePuMlYvOABzU6pcZCrJJWRS1vKomd9iV3QR5fsEU1ZqhB
 zQ4MFL+KyY6EDS/e9nC1ohgW9gWLRDGmN2C2Wrz9jvkazYqNJxKfLn1A6hu050ICWqqmGAZ4f
 v5myQqcc+KEA+jIQK8qoTMIxa1znyvQ9izz9TL8n+eSqCN9SAPfeJoN7PErz9eoYAYe3p65Bg
 mdY921J5WpHkOJ8s988FPFedGPA7MAqVugw8zSLhXE7cHr046vn0fCHTUgHTmEefKLH8x7tFK
 lbCiTU5pn4dyhysAEa9HIWTj4H8i9wNAFswrB3Z5djyqAuf6CzVkRPR2GfbqU31D18eYcDBSD
 JV2ssQP4/o2spxPMnVutXKjbjHX41y4HAwQXBKzM6h7hQ0MU7+jMFqXrbvuUledpbw9jmJmnn
 q8u+dNQRORCNcTuYTY4Ph1Lw+5V1SLJWzXipf3tGuulIetBRM9DsnKpz+dvEjPsoE/f8Elb2d
 9hhiFZxGXp2pztEEbwIUvk4oQH+CXkqbC8jQ12jbo26IfQfIZrDREUXux1wE6JAH+/pm7vAN/
 Z6GQjN+D/FpmyBGbz8Ni8l7UaQ/vWJiz3EQ5406bjUGz4WCj5txhV6u5eiDjwJJOzY73S+GCv
 Zw5FRlzUnvWnIwVloJbLvqSBXFxtmhsTg/9LOvDb75Hzgj1kmBhx19R6biAOpVHQDd38AXox+
 Rmmvz7VM79tjC7sEk60lOl/5OspPJVtx+E3rzZIhaPpbOCPDEWen+cgu8y9OTki0JBx1fEWOG
 usX/z1KVgNdX6OwpEjyqXVZGKl5F0WDt1cWvhGxprDdzZQ+9GiIrCUizzAfOm6mTiddA0aFM5
 s4F1KK60=

> This commit improves the error handling in passive TFO test to check the
> return value from =E2=80=A6 and  to fail if read() failed.

Would any developers and system testers like to care more also for data ou=
tput failures?
https://elixir.bootlin.com/linux/v6.19-rc4/source/tools/testing/selftests/=
net/tfo.c#L86-L88
https://cwe.mitre.org/data/definitions/252.html

Regards,
Markus

