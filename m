Return-Path: <linux-kselftest+bounces-35376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D8AE0B5A
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 18:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9E33AAC98
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 16:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F0627F16B;
	Thu, 19 Jun 2025 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJEkvDDr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351B63085B2;
	Thu, 19 Jun 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750350443; cv=none; b=RIhp0MR3p2/qTLViOCRxWwAUYUL6+EuY3cMJ2yAW3WJnKk+U2xKhI36Jv8Wob9uTBGULY+NemvV/KDiDS1UBVA9zZrkIkoCma06t+SJI2nkjxs42ejDo6NspEJq4hkPAM6sFZk5UorOq3WF8S38szPKKO/hQD3YlTzhORJixoj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750350443; c=relaxed/simple;
	bh=ut7sBnFRrF7Mqh47DfQbuG68oA6w2Zz7sw0xx8b8S6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnWSQqLk18jJ7qSCMaaiB09q4D7ARe7X9lmQRNb0U6cLl5yuDoaX44NBwLeWllXDk26kdVq+UU1S6H1SBxc1zcBDwn351GnUZh3mWIJjSsMCAkxxXN12M3JdvzEVPd9FmqW5J/54pQt8PsX31rrh6bXdap15UDpzmRxol7dTBYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJEkvDDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761E3C4CEEA;
	Thu, 19 Jun 2025 16:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750350442;
	bh=ut7sBnFRrF7Mqh47DfQbuG68oA6w2Zz7sw0xx8b8S6g=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FJEkvDDruVAykG1bun51wz0patqolTYo6wGXEy+dzHZmtcmsQ03UAy0Hm012GEORL
	 MSkpczCrEztNz3k8osJYKaEU7TilWHQtsqxDtRfQwmGJEg7g2CTARWQXiozKWmcdRv
	 zEjeKFP9QQSXBIHpssKwJVBMMQeVZYKjfz6LAMv1P6YKm4quJWyRkV2RehkBNPxoyW
	 KNd0bgGglA7uKKPW3KU6iO6kypXn4fCiJpYsCJovkmacX6fAol55yKd4bflvCVh5Fy
	 eFF1WCzTwIoPaPVhHPtQz5MtMu/61p5uL/OXiAucZlelZw5ThyCNIim78dB3k2FiiK
	 Ufs/LrsP7yquw==
Message-ID: <c5e3b6fc-e9dc-4551-b632-25dd2db9ec08@kernel.org>
Date: Thu, 19 Jun 2025 18:27:18 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 1/3] module: move 'struct module_use' to internal.h
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20250612-kunit-ifdef-modules-v1-0-fdccd42dcff8@linutronix.de>
 <20250612-kunit-ifdef-modules-v1-1-fdccd42dcff8@linutronix.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250612-kunit-ifdef-modules-v1-1-fdccd42dcff8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/06/2025 16.53, Thomas WeiÃschuh wrote:
> The struct was moved to the public header file in
> commit c8e21ced08b3 ("module: fix kdb's illicit use of struct module_use.").
> Back then the structure was used outside of the module core.
> Nowadays this is not true anymore, so the structure can be made internal.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

