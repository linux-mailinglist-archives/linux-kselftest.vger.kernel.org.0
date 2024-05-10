Return-Path: <linux-kselftest+bounces-10025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C54B8C2A10
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 20:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32DD81F2219F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 18:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D8E481A5;
	Fri, 10 May 2024 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b="NVpkUZ1D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752A743ADF;
	Fri, 10 May 2024 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715366622; cv=none; b=FV7NC1t+OuKsvBmkw9m1ejm/vdVWNTyMJXGWyYFK2YCpF+DjBLrwMKO6rndmCvIvdecz6imXcC7rwLPEUTg3HbleMuX6ABvd5w2G7OetA/BLUW/I+lOB+FJphGpR1zu1FHHYfekP1IZeFGkLF+yqolFPA8lXZIQNcdYo8OIlRyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715366622; c=relaxed/simple;
	bh=i8Y+CF0/msLe+CrT7MBQOBx8WllRoivm74sS5P5A44o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=X5RJ7At/2Hw9VMKeCU5zR6xdaJeO56tw80tVl+FrskhzGfhZPs024vhMAaco/G5+fGSK1q9CWALpTw3Jv+scgolrPbgqSnW4kIz5ldOg3aWzNys/2NLDxOqGQULqAH23xZrIcc7FSQ2ZQAsAjHwBnrunBGJn9WuT53+JLENpS74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io; spf=pass smtp.mailfrom=gtucker.io; dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b=NVpkUZ1D; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gtucker.io
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 81A60C2612;
	Fri, 10 May 2024 18:43:33 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5FBE9C0003;
	Fri, 10 May 2024 18:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gtucker.io; s=gm1;
	t=1715366606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zTCULRYllt+dMGIqGygx1xMSb3Ax/XJV4B6sfUxpVsg=;
	b=NVpkUZ1DWirf0zfndgu1mtPACxiCq1wmzE/fGaaIWIbTMlfVZauqP7pV5ywIzcAhYd7mKe
	i6z7OCiQioyVZ9lyO05j/9qwKFT+DgntbHYmFIJqHQdJdTFxqFoASXBJHB5wG6YnFEHOg8
	niCTEmmO1eAsWn+dNOUDe5b9P+mmCCq28SbAnM/B6ncsoIAb87JWz/pQXObnsiAj8e7PMx
	dIUMGS+SnY2ZgfivD7nokta74tT/0XcXDt6vDjRq0owLYu0nBX6EXtsrlmblN/sNfjQL/K
	Sx71HupuYly4sS0bxFU8h5vJYCcF41w4crA9c4BXWroC2G3/nXW0AygtWAZPOg==
Message-ID: <aba2b2c0-ebb9-45e3-b14a-2321b7770e03@gtucker.io>
Date: Fri, 10 May 2024 20:43:24 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: automated-testing@lists.yoctoproject.org, kernelci@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kunit-dev@googlegroups.com
Cc: Shuah Khan <skhan@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
From: Guillaume Tucker <gtucker@gtucker.io>
Subject: Kernel Testing & Dependability Micro-Conference at LPC 2024
Organization: gtucker.io
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: gtucker@gtucker.io

Hello,

We're pleased to announce the return of the Kernel Testing &
Dependability Micro-Conference at Linux Plumbers 2024:

  https://lpc.events/event/18/contributions/1665/

You can already submit proposals by selecting the micro-conf in
the Track drop-down list:

  https://lpc.events/login/?next=/event/18/abstracts/%23submit-abstract

Please note that the deadline for submissions is *Sunday 16th June*

The event description contains a list of suggested topics
inherited from past editions.  Is there anything in particular
you would like to see discussed this year?

Knowing people's interests helps with triaging proposals and
making the micro-conf as relevant as possible.  See you there!

Thanks,
Guillaume & Shuah & Sasha

