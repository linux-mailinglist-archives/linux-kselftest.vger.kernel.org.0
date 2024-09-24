Return-Path: <linux-kselftest+bounces-18326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59609984CE9
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 23:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A866284BBF
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 21:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED77912F5B3;
	Tue, 24 Sep 2024 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="Y1jY88Na"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB2A17557;
	Tue, 24 Sep 2024 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727213606; cv=none; b=NFzOcA7MCCR7qHrBFGTFxmicGf/zfu8EuqvUAl2ERwnQpPXWfQIzmZjZogYmiEDbzk6UT5cdtG7UDmfTGnOZRSLwWPe9P1F4gBOes5yyNcXVGEEGl0pYgbsRUNsdLmedhgULnFnx4SMSRu+dwCMxSHaqHVrWMMxnVo0JHI46EcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727213606; c=relaxed/simple;
	bh=OjF0ucnfYYvF6CDeHwrxxqODXeaTRoOBgmqktmPAVy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=MxLGpUBsOcWek6TrU5Nvt1TmACsaEHOFy9yJcHuSHGhJqr7ICKzUS/KLcsoBffirXGBdOIw50d9miIg4F2EQ/Hp4As5zMBk8jhrMP0I6TamovNjbHUqrYRG3rcunnB108VSNDAIzqxzfWp2aja5oVuCHPhoEEBkauLXsxSz7LEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=Y1jY88Na; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4XCtQD5WL7zDqQ3;
	Tue, 24 Sep 2024 21:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1727213604; bh=OjF0ucnfYYvF6CDeHwrxxqODXeaTRoOBgmqktmPAVy4=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=Y1jY88NayE7/5gs3HMNYueAX+fXyo3eHnkI6L5Ka6PkYkJQnQNLRZSpqaaIbyABgJ
	 qHTYjSY14ESWUNOW30tkBOuQ04ApPG7xIJQ2vdQ0psZOcsY8nYxfbUkSrS4hyzEHDv
	 /9jEhmXkqIyyRAuVU2xk7g8bP8m8RiaciqOZpgtU=
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4XCtQ61P7Mz9w0h;
	Tue, 24 Sep 2024 21:33:18 +0000 (UTC)
X-Riseup-User-ID: 22C5D9AB7542B38831EC3FCDFD435E6CD26FEACDE9C2BA0FE9A1A50B109603EE
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4XCtQ31nsjzJrrG;
	Tue, 24 Sep 2024 21:33:15 +0000 (UTC)
Message-ID: <8291c6eb-750a-4ab2-8904-65d723d034dd@riseup.net>
Date: Tue, 24 Sep 2024 23:33:13 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/1] Add KUnit tests for lib/crc16.c
To: Vinicius Peixoto <vpeixoto@lkcamp.dev>
References: <20240922232643.535329-1-vpeixoto@lkcamp.dev>
Content-Language: en-US
Cc: Brendan Higgins <brendan.higgins@linux.dev>, ~lkcamp/patches@lists.sr.ht,
 Rae Moar <rmoar@google.com>, David Gow <davidgow@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@riseup.net>
In-Reply-To: <20240922232643.535329-1-vpeixoto@lkcamp.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey!

On 9/23/24 01:26, Vinicius Peixoto wrote:
> Hi all,
>
> This patch was developed during a hackathon organized by LKCAMP [1],
> with the objective of writing KUnit tests, both to introduce people to
> the kernel development process and to learn about different subsystems
> (with the positive side effect of improving the kernel test coverage, of
> course).
>
> We noticed there were tests for CRC32 in lib/crc32test.c and thought it
> would be nice to have something similar for CRC16, since it seems to be
> widely used in network drivers (as well as in some ext4 code).
>
> Although this patch turned out quite big, most of the LOCs come from
> tables containing randomly-generated test data that we use to validate
> the kernel's implementation of CRC-16.
Can you share how you created the tables? Given that is impossible to 
review the table itself, at least people will be able to see how they 
got created at least.
> We would really appreciate any feedback/suggestions on how to improve
> this. Thanks! :-)
>
> Vinicius Peixoto (1):
>    lib/crc16_kunit.c: add KUnit tests for crc16
>
>   lib/Kconfig.debug |   8 +
>   lib/Makefile      |   1 +
>   lib/crc16_kunit.c | 715 ++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 724 insertions(+)
>   create mode 100644 lib/crc16_kunit.c
>

