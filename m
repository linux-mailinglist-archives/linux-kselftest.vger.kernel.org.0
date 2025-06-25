Return-Path: <linux-kselftest+bounces-35726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB638AE74E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 04:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0794189D511
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 02:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D171C1AB4;
	Wed, 25 Jun 2025 02:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="bWFSp2Y8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11EB1A23A4;
	Wed, 25 Jun 2025 02:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750819286; cv=pass; b=AGQ6mlNFm/Z4lOVDZekf+JOjNfCpk8quGrVa3cudiYleFAfCm9fBy9aQv1Pb2Fp+tWts6R97x6FhZHmG804g5l/yYOeEV+bdL3jTrF5olCV1qQPI8qieJwapOhO8EU66V4iwmmmfQs2LDMvsKLWyNpi4EFY5nJm17/OruWdLEDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750819286; c=relaxed/simple;
	bh=g05fp5tznJTq2ihZAsz/TZXx28vocabXtBccaPhv0L4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PzP8HmEhHYwU+olugnAboU1gjUupNSxds84AiAv/3sQgNITgi0k0E3Qwn71nJKJmCtbt7Jb+zggT70vPRYZ+zwhKP/sTPBOWuAxXbvATWB/hbBE7DzVNG81xeeL4g7esnPrUINf3mY9d1ZgB8jYu0mgckZ8+leAKCzA4fLO087E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=bWFSp2Y8; arc=pass smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 296441A4D84;
	Wed, 25 Jun 2025 02:41:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a314.dreamhost.com (100-108-113-168.trex-nlb.outbound.svc.cluster.local [100.108.113.168])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B633C1A3F0F;
	Wed, 25 Jun 2025 02:41:16 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1750819276; a=rsa-sha256;
	cv=none;
	b=ltFt7IzZNxrJGxiYV+k1oGZWgrwHuGih4VwkNcqlliN6gShnrrTxBblpqnQivlZpp18Pkd
	vccqqA0wpyetNsTgh1o3WGGe0U4jhsXn31J83pb3Ie8yg8+YDNggCMRXa0XVi55GkmeZnV
	vh8245EacFFZprcViyTZhfXQsjtc2qwvJnNRNX5xpfbJUS6RmPj6yvxOxc8H0k5ar/qh1Z
	iCo02sqgxqJqwfGnWvIPAdwTF539ZuIsif4+bO1Q37nHA0SSggrXMcQbA7Uki0y11yS0gj
	7gKk+8LyWaPnZu2gkjR3GbTgju5u0YqrIBIbIorzaCLYLxfQ459sxg0YNsvexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1750819276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=LgABf1mB39qVwXO9ATW+JWNCBe+eqNN387tXL3KETMg=;
	b=WQBczNvNGfB4w8FJqs+9GW6tc1lORYHGd9yxPwBTt1VEe+HP9zI0IgPRVe6oUy3Z6HFj4N
	neda4JnEocB/nwR/wVVnFZG3pvvn6YxB8XtKL81qOY1vl/PB+bEGHYR4OtkHQ2kjkaxOvC
	f5HmplyNEUKTKaGcvABy0h+duXIyxoUOYBPP/4O23Mh8U8e6oTVGUfhoXJQcCX5bPHzEOh
	TGMIJZgxYKsl50Q1UR2mLGZEmuqvPOI0T7ctogwqXYG2SwNwKGX7NuIpJ9JwtuE/NDAvAf
	EXhWhNQ+Yy0zQkGFIhg4g6l3yVcb3NPJ6osGUOcsDSxijPgOIBHWWWEWVL9wVw==
ARC-Authentication-Results: i=1;
	rspamd-6597f9cdc7-8mcrn;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Tangy-Name: 101dd87568f9001e_1750819277034_1257048522
X-MC-Loop-Signature: 1750819277034:1050076598
X-MC-Ingress-Time: 1750819277033
Received: from pdx1-sub0-mail-a314.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.108.113.168 (trex/7.1.3);
	Wed, 25 Jun 2025 02:41:17 +0000
Received: from [172.22.7.54] (unknown [198.232.126.195])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a314.dreamhost.com (Postfix) with ESMTPSA id 4bRmKR5XZ9zC4;
	Tue, 24 Jun 2025 19:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1750819276;
	bh=LgABf1mB39qVwXO9ATW+JWNCBe+eqNN387tXL3KETMg=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=bWFSp2Y8DtFviBNOxweyNaW8TuWC7PDhtig+Xm+aD/JvpQccqIwt0ekglzI/JDWz7
	 IKGNqf6WPpINfkah5mAf/MGcezl990xL3cb68XhUfp6twDSSDKTUc2M2qms+Eu6Yxf
	 qm5z2MEOEswM2Q6y5oN43UMqSrIEZ810GxVfmzqr4QfwGQd9N8xEbna4gaDQNcMaBT
	 OAE8VZp2pN6m4bDh/zgYNl/ExBhFEq1ncwbLRW6oMWvDTDskLBdtxGWFDWyl3c+k/R
	 dOzsF/XR22mzJ6v4P4juS0TuCtwOKqYOBqfnBnJ6CwWPTzkrBDEA5Ymfzx0aA1iqnB
	 o1YSEOH9HwR3w==
Message-ID: <16f63653-c5c9-4b32-8e0c-0a4910a9fdb9@landley.net>
Date: Tue, 24 Jun 2025 21:41:14 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] tools/nolibc: add support for SuperH
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250609-nolibc-sh-v1-0-9dcdb1b66bb5@weissschuh.net>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <20250609-nolibc-sh-v1-0-9dcdb1b66bb5@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/9/25 04:28, Thomas Weißschuh wrote:
> Add support for SuperH/"sh" to nolibc.
> Only sh4 is tested for now.
> 
> This is only tested on QEMU so far.
> Additional testing would be very welcome.

I ran this by Jeff Dionne (the j-core architect) who said:

 > Looks correct to me.  There are no endian assumptions that I can see.

So you can put

Acked-by: Rob Landley <rob@landley.net>
Acked-by: D. Jeff Dionne <jeff@coresemi.io>

But neither of us really have a build environment set up to do much with 
it. Is there a howto for this, or is just to run the kernel tests?

Rob

