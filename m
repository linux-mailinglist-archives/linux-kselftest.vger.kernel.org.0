Return-Path: <linux-kselftest+bounces-12844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49730919F91
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 08:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0387628364D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 06:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC413BB2E;
	Thu, 27 Jun 2024 06:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="D3dBNaFK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28CB20323;
	Thu, 27 Jun 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719471066; cv=none; b=SkDbbQBBwGtnLB5iA1yuCtzRFDcYkSNQ+pefRIUt9S0/SMY5Z1G6fhF/xOSbT5gzClpAgE8TpS9US8wrAMpuy/bV3DhyVTQKDbXqrHKTz/Mkhc3LFxnvLCZQLZg5K2zw45gFie+CQFVKeXKWJcSpSOusf1LiGOmGptNNdVOCwMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719471066; c=relaxed/simple;
	bh=bQYa/DespjSHuQZ1oFVwziBEd4jeC5kUZa9xTrmlBx4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=mwXJWKn/vFyE2BOC6QPDvH036cM9/WcA8fj5owtBhB2NUzKjoz/ffVeQXqshSq6AMhyIppZ6l35oXUdjGlcCWNb/Ge4OAEjC4by6bKOUEKIpgWcOqVkGOO7+xqHWdgQEf0A/rILpPSrIflIItFis8HCjcCGrtCZEXZV2AC+RVTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=D3dBNaFK; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719471042; x=1720075842; i=markus.elfring@web.de;
	bh=2atwNxPRI5mO89YD5+6WEYABHJpwprYUB+48+DjiF+c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=D3dBNaFKfAiEebkKfYwjbBugU8AKqxHn7cZxkn1tqi/7vV3Xv6qlYUvSgrqR8bLx
	 f/Ad8DM+AHZz0JUXtCKH6YCYF85QbJsNv6pxIo8FY+Rd1fsUMDT7w98+yuWfGCauL
	 aTS1bPxiqgQON1whv3uE1TiF1/ZznHTPhHMlQVtAUvbu4ZubhI6IwKuCFVXb7WyEP
	 PerOyysjxiZK8vD/Z9/dTB1gVzOPrfzA8m1/St4mMAuME5yXTlurmu8LqqxEFR9CI
	 sffxrn3imh0z1qeKno2F3LuX4pdObFhi6Ayx6J5gWyKqLGmBOgPw9osqVoDhlKp5M
	 K3AdeBGB00UAPAWIlg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgAJ8-1sov7M3GUo-00nzun; Thu, 27
 Jun 2024 08:50:42 +0200
Message-ID: <97116eca-6166-49e4-8e21-376b1a711472@web.de>
Date: Thu, 27 Jun 2024 08:50:40 +0200
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
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240627015732.2974078-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v2] selftests/capabilities: Fix possible file leak in
 copy_fromat_to
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240627015732.2974078-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9RqA6a/5mc8PH/+0+xqBe9P6nPxuRgIDQ+NQ7ULRr0odF29H2Uv
 681BUR0GjNbtvSQUAIkP9E5DkaXMygXjrZ1X5XGAVLRu2upcOMF/3a5+xlsOCrMY+Evh1SG
 1p8uRB+hrkGhq/nLy+EdQpz+ARDJ987ghADEwtQrZ2p5oESbxzxJxAyPJnsgIj2mm3oqgn4
 IM+Qwh3jeQ7DIWa4LHqQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YYUSFw9XI64=;pZIvEEh3wcOhYwlK/FvVcGORUMz
 4vsCNhxgYE/LgQOqwIMOMEtFrj0IZs+f7SuBnftMe61SdN5x3tYMUrP6aKumwexPrl+bA0GvJ
 xFNxYi2dzl2sbGlXxevWqry0HbNCDoOCoEMQSrStpXKJIQPngc//HEQrj0GGVtStQaEw9S7CP
 m8abA1Lldulf/tQc/5PKd1iBXW3zotuSYCRZlcy/GX1X9yYdC/BhI+2VHQrflroA61AvQwa/V
 vaZdDc+H4fse0WE6zQhldWa600k4YD+ce1c6osTkdogcLiVogxnKWiHza6IjB3LyXAgvtlBo9
 lvL6LemG07NZdzInAhfbJ280WrU8zWGxbph8IoOf2OOyVHZMB9hUM5BSLEHLqgcxJDNztSjYS
 YKIaJhL4lBq1eCcErLcJNJJxh0gzrfAOPVYQHlqQNe+Q/VJVJzXLZIgxhvZ5txIX1Rh27Zceo
 QEDgcO2AUJvc0U324Cn+kE6uZXYSbaXEd2OHcvfnd38Yo5LTO4QSM6QRpBN+gHbtT1nRpsEam
 nc+Se8ZeHIa7QMwet24++C6bRGCaFquSsP/j+9Qj2QX91zyrOcwFEGCdcyT2k6V//UQwogqXR
 YArIp/jZoxrOy3L40YZtuFHLPSnWUbk4mfoTvcSjevhCdDQtqTqsh+nOwfLTmnZ4iVVwHVQ9q
 cSAw38zItUq1MDPSAkTRdXfQKkmZgmX5zi42/VHecdxEGaZuttxeqb4J1zVbA7qjceYUAO+1m
 ayznEXrBZ0l6njanB7RPTMOyNy4UkTPwsm87f5y9tY9iqd7tBZPQcfddzlOpaWyo5IFwoGAqA
 B329gHNO1m2EP1GEKgWzHfg+UnKbZTaALe5hzC2DmRakQ=

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
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc5#n168


How do you think about to use a summary phrase like =E2=80=9CComplete erro=
r handling
in copy_fromat_to()=E2=80=9D?


=E2=80=A6
> ---
> Changes in v2:
> - modified the patch according to suggestions;
> - found by customized static analysis tool.
> ---

* Would you like to replace a duplicate marker line by a blank line?

* I would appreciate further information about the applied tool.


Regards,
Markus

