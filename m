Return-Path: <linux-kselftest+bounces-137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05E07EC75D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 16:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC6E281238
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 15:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74527381DD;
	Wed, 15 Nov 2023 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="iU09SIHB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CE93EA65
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 15:33:50 +0000 (UTC)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C81101;
	Wed, 15 Nov 2023 07:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1700062428;
	bh=0NwkqGMmlxRkONEuO4KbmE3UnNfjeoUyBXz8wtpcI6I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iU09SIHBmcpVTgbcYJxzjAW/StJk21020JMEkRL7HtMXPbIQrZRdc6PDKNjk79RmF
	 84AQ4X1+tnR5rLk0bzgNGLV6BHCCKqpFULgwcv/i3Oi2fgX/X9vU8b1I26Y1tISWuI
	 WWsS/WG3PrtXOvhiAua79ZxfMQpmHNLcAxYSOSnWcrNeiB6ytB6YCgykv1ldzxJ1Rh
	 2IYLNTeUNTDsOAeZwHEY/i2jxEPpgR8YIKk7NWdJyMRiz5MnGnASJIdssBpYPXbNtL
	 5BrGbUiQ/ZMdsAkf1l9MscLC4IZN39gBEewmbo5HPgNEaUbaLsSTmQEfKkyiR1Cy81
	 sXybTB4xdCvTQ==
Received: from [172.25.85.137] (unknown [12.186.190.1])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4SVnJD4Zz9z1cB6;
	Wed, 15 Nov 2023 10:33:48 -0500 (EST)
Message-ID: <8431b227-d053-4a9a-a278-2a43753fdaf7@efficios.com>
Date: Wed, 15 Nov 2023 10:34:16 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/media_tests: fix a resource leak
Content-Language: en-US
To: zhujun2 <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc: ivan.orlov0322@gmail.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231114093812.7169-1-zhujun2@cmss.chinamobile.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231114093812.7169-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-11-14 04:38, zhujun2 wrote:
> The opened file should be closed in main(), otherwise resource
> leak will occur that this problem was discovered by code reading

Fixing resource leaks for one-off test cases (processes execute and
then immediately exit) seems to be something that would fit in the
definition of "trivial", so I would advise to perhaps send those
patches to kernel-janitors@vger.kernel.org ?

[...]

> +
> +	close(fd);

These added calls to close(2) miss handling of possible close errors
(check return value and use errno to print an error).

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


