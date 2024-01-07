Return-Path: <linux-kselftest+bounces-2707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D40608265BE
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 20:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C00D1F20CCB
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 19:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F44210A3C;
	Sun,  7 Jan 2024 19:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="khWyaJHr";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="HEpJZLuQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F4F10A13;
	Sun,  7 Jan 2024 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id A62026017E;
	Sun,  7 Jan 2024 20:15:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704654941; bh=d3LbiJNQ7y0NCWm2gRzh66E1f66jjXrRh4BTfGJ7PdQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=khWyaJHrgQPSJxKd+OYGTw7ohoRPc0qI7EF/7OmTPfrMymRYPbU45x2+5DrXqlraM
	 zURsjsV0QSZWPfZWMjF458LU8vIkewU5s4C+IkAfxZP40Z8jftLPowY6lm7LU5mv6W
	 RO2MI5yJlmXsLGBsqXw08owJ7oN3lFb+AOGgKmbjzTCjyIqVidpdbx42k8E0BANwHE
	 x8oOB0t06YLK/JsF2dfxsZnpPzCQ6kYR+pIQS2YJTwEGCH+k3dC5ouCKBrNVlxumE7
	 JR5vjamx+enEnthRcIVIzbUFoQ66ogMme3zgQo2BAHG/jvTsmujBBXg4W260YNruai
	 f6UdYmWXtlTjw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2XVoPw5UeT1x; Sun,  7 Jan 2024 20:15:39 +0100 (CET)
Received: from [192.168.6.51] (unknown [95.168.121.73])
	by domac.alu.hr (Postfix) with ESMTPSA id EA42760171;
	Sun,  7 Jan 2024 20:15:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704654939; bh=d3LbiJNQ7y0NCWm2gRzh66E1f66jjXrRh4BTfGJ7PdQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HEpJZLuQ0pVPcJ8fs2UcGDNWlPQCfaud5Xlqivdnd8jjqXD5QGLvxpEaoddO/JLew
	 IsUDi5B50DylKXVGHFR6KF/i4hqE3pbcinGmiHiaVnIk46710/3MLQpHT//5UUpro9
	 xnhiAF5HvboJ+vdWqllkbbbbfcmO7C9OU/CgI8TdY+Hk5QUS/hBC1G64jQPMudwT7F
	 g4DhmCdR0rVA7+lavQmNXDgpRhDps0C8pxP3min4g4kX5f+s5L/mcyd5gp8ZygOaac
	 zmDe4uX2NaJUnu0AQ29RTRLQpoza4wvZyy7t2Vw7LsjuwDxIx7YapUqvtJqTgKlVT6
	 fK3d2GET5mHug==
Message-ID: <69683d58-3cde-4bff-bc11-4d2953e22bf2@alu.unizg.hr>
Date: Sun, 7 Jan 2024 20:15:37 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] ksellftest: alsa: Fix the printf format specifier
 to unsigned int
Content-Language: en-US, hr
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Shuah Khan <shuah@kernel.org>
References: <20240107151218.933806-1-mirsad.todorovac@alu.unizg.hr>
 <20240107151218.933806-4-mirsad.todorovac@alu.unizg.hr>
 <87r0itm1ft.fsf@igel.home>
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <87r0itm1ft.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07. 01. 2024. 19:40, Andreas Schwab wrote:
> s/ksellftest/kselftest/

Thx.

Fixed in v2.

Thanks,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

"I see something approaching fast ... Will it be friends with me?"


