Return-Path: <linux-kselftest+bounces-2744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2F9827E5C
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 06:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42E61B234C6
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 05:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79813EB8;
	Tue,  9 Jan 2024 05:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="ZuW1i1aY";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="ch2pMQcH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCD16124;
	Tue,  9 Jan 2024 05:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id BF02E6017C;
	Tue,  9 Jan 2024 06:36:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704778608; bh=PGZFsCN5bX9Fgj1fexQnuKUnpX+2oo8Uw7rRMuV5zzQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZuW1i1aYfe4FaNyzjl+XKMaiyGvlbH+rWnDopThJpI6pB8UcC+qzkvm0ZwjvxuQBj
	 e0Oj3xeJbX2aO3mnzmgrqc0ikxTuSXi/bCeL5SUAY8cFa5djFs42p3STlQGzKSrFCN
	 Ov5hIv2S4yGxH5eha6AETCYJhg68g8MF7ZoL5/iGUSZEi+jbZ/wMQ6SFoXaXRUUPqM
	 Gn7itpudlxOTinKdzWBrtDmKjgGUfnVpHXS7AenD7f/lJRADZqDVe7WhqG7noNRpiv
	 ZXL8bKga2BsGGTAlv9S4vTgrBa02wPxMu5iMmAH4isycg3EunH6JCI/3UTjO2pcvAF
	 UBD0mu550FCzQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9vQO2rzvINSB; Tue,  9 Jan 2024 06:36:46 +0100 (CET)
Received: from [192.168.239.51] (unknown [95.168.121.53])
	by domac.alu.hr (Postfix) with ESMTPSA id 484A460171;
	Tue,  9 Jan 2024 06:36:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704778606; bh=PGZFsCN5bX9Fgj1fexQnuKUnpX+2oo8Uw7rRMuV5zzQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ch2pMQcHVRVaEOaBaYiRVBzgm3MbFuFaFf67vhIqf63015IuOrOzTFkibQ83wonK9
	 7T8fctL70zMRN7OmUzruqlBf2uw33rtCvIQvvbBmp7YiRALe+Z2r3LU3lj/frfZGOP
	 DyO8miHWKn+WUCcn4dCclWuyyJFh55rGz3/zdAOS3VuSI0nikzTpz9pkDgWtw3dQei
	 60BUPdA6qlhSqaLbrbzQf8U28d6hTtz7NF/uMhb4Y7LmvjJnoFENr2Wcv4Qej3Ek4W
	 FxCEhCpBmyL+oSwSHRhxqKG7zUGNKttEaKRLzKwIrCgMtlaQjGATniKbE/QXmU0itY
	 GyuvaovdvnXmw==
Message-ID: <e8f903e9-cca2-40ad-8b10-9f2f9cfdc750@alu.unizg.hr>
Date: Tue, 9 Jan 2024 06:36:45 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] kselftest/alsa - conf: Stringify the printed errno
 in sysfs_get()
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Shuah Khan <shuah@kernel.org>
References: <20240107173704.937824-1-mirsad.todorovac@alu.unizg.hr>
 <20240107173704.937824-5-mirsad.todorovac@alu.unizg.hr>
 <0654c2d9-3980-4f5c-9c0f-eaafc44fee52@sirena.org.uk>
From: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Autocrypt: addr=mirsad.todorovac@alu.unizg.hr; keydata=
 xjMEYp0QmBYJKwYBBAHaRw8BAQdAI14D1/OE3jLBYycg8HaOJOYrvEaox0abFZtJf3vagyLN
 Nk1pcnNhZCBHb3JhbiBUb2Rvcm92YWMgPG1pcnNhZC50b2Rvcm92YWNAYWx1LnVuaXpnLmhy
 PsKPBBMWCAA3FiEEdCs8n09L2Xwp/ytk6p9/SWOJhIAFAmKdEJgFCQ0oaIACGwMECwkIBwUV
 CAkKCwUWAgMBAAAKCRDqn39JY4mEgIf/AP9hx09nve6VH6D/F3m5jRT5m1lzt5YzSMpxLGGU
 vGlI4QEAvOvGI6gPCQMhuQQrOfRr1CnnTXeaXHhlp9GaZEW45QzOOARinRCZEgorBgEEAZdV
 AQUBAQdAqJ1CxZGdTsiS0cqW3AvoufnWUIC/h3W2rpJ+HUxm61QDAQgHwn4EGBYIACYWIQR0
 KzyfT0vZfCn/K2Tqn39JY4mEgAUCYp0QmQUJDShogAIbDAAKCRDqn39JY4mEgIMnAQDPKMJJ
 fs8+QnWS2xx299NkVTRsZwfg54z9NIvH5L3HiAD9FT3zfHfvQxIViWEzcj0q+FLWoRkOh02P
 Ny0lWTyFlgc=
Organization: Academy of Fine Arts, University of Zagreb
In-Reply-To: <0654c2d9-3980-4f5c-9c0f-eaafc44fee52@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/8/2024 6:37 PM, Mark Brown wrote:
> On Sun, Jan 07, 2024 at 06:37:08PM +0100, Mirsad Todorovac wrote:
>> GCC 13.2.0 reported the warning of the print format specifier:
> 
> Acked-by: Mark Brown <broonie@kernel.org>

Thank you very much for the review.

I guess now patchwork will do the rest required.

Thanks,
Mirsad

-- 
Mirsad Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
tel. +385 (0)1 3711 451
mob. +385 91 57 88 355

