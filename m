Return-Path: <linux-kselftest+bounces-8764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0888B07A2
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 12:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA79D1C22831
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 10:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E41E159594;
	Wed, 24 Apr 2024 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HZWPnBpY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5DB3EA66;
	Wed, 24 Apr 2024 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955764; cv=none; b=KSjt6QNduziLR2PweJEhSu/JVxU1+drhLpXj5UKWW2ic8PZ30exCORpEuNM9Wc6Mo+lJRxRkx7fxBrMN6ysmZoMyVkyko8DejixAeeVGccjXmlmRBqnxeYfUua0drdiTSl4GiTzATKOQgx0kagzF0qsDZNj5W9EJvQfldCSnKaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955764; c=relaxed/simple;
	bh=Yee0/Osb8LuV3ZB2AQuxep76YOpKew5FVBEd5LX1IP0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=g6AsjhaG48kDI5i1DRtoMKNyJ9Z5WoYYwtxpNFBZGBMF9DqFB5tUPD7wZ3b7LqUINkYPWLvzqosuNvubTSslW0E33Pmi2MjMkzf6ef8QL5XIpULm/LdqzEvx5Y6SNZBIb0OfzGZ3sdIIVz4xTATZBvRiZvVYlBQ4ourWFwnh9v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HZWPnBpY; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713955735; x=1714560535; i=markus.elfring@web.de;
	bh=Qk2Z9Ur/axCDf3ITMI3JPxcQXOHmAKvjUk3aT8fYJig=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HZWPnBpYG78wi6FtGgGW3nJxdpOlFMEO+jprXyl+stSY2M6NWD90qe16+McfvgpC
	 o6lXPzI2TjHFnCyQ5FySjnsIelOoHiir71RG6MBagMPIJJ1NLL8CfBrsMvCetMswa
	 qNqA13j1gXp9ovCSuuXpqYz6T6ixxCnSHolZm5dTEVid+pzZ2wrd5LtHT2ioEOA7T
	 aNt+2zWlxkUApJtNNuYPiEgSbLdqQnI8u88a96IgK6tWF5gxhfRp9Mn315ELA4njF
	 6DBuWWTweleB4i5mLhc85HeDIoEPiFrNihua+Hbe4RSVuWUuOShiwz5r3d35qU4jB
	 FoAKx/wrycVpbbfqfA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N62yY-1sjZ4I3ftQ-016hUt; Wed, 24
 Apr 2024 12:48:54 +0200
Message-ID: <bf6e727e-a28c-4605-8a47-ac33550ebb10@web.de>
Date: Wed, 24 Apr 2024 12:48:53 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kunwu Chan <chentao@kylinos.cn>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Yonghong Song <yonghong.song@linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <kunwu.chan@hotmail.com>
References: <20240424020444.2375773-5-chentao@kylinos.cn>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Add a null pointer check for
 the serial_test_tp_attach_query
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240424020444.2375773-5-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c7wSIBl9mvxe/oo1tdl2vCRED6SYaYM8u6v4WauSkzejejYjAAt
 np5HfYpoZymH9VE+IZbNGK7UqHxxYOoeUNdeHlUWsqagJoj7pULCM6DnYHOSFT7WVDt91ul
 agYKJlHPB1bpxlkv27osy0n4hLtJv25QQFmLZR/q4HZ3wmS+4Iuj4o0oBrxiFbHlhoBgknI
 ktcCV5r86GvRaGWcBc6NA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H46wqUsSReI=;BwoCsKVvVwzyZjotKK3Nz6BIaFO
 X/dcVBjZ2kBDBNMpqeYhSD5fE4tCWcZ5jrxWULfBXJAr2EutOXOpgl1G0qu2H3JLazNGIZVPS
 PM3RpIj+qFRp+vdy3Ekyl05Ku4BzhxAToEeppc2Sv2tTdwxTHyMf/mCeXrQMdsidwROXDXLvp
 Cu6rZ90AVRNrMFDZLaPWZlpOT2cXZmxhC2waj+amMoPIGSxaT+FaIZKmSRdkT7SUXoRSOTdTo
 TEMcOXkYh4hwLboXRK06KVbg8ZT2D7xqBiwJKuFNFYeJqwSPLwdgaKvNwMT+Pz4d6BM1bcLh0
 HbXWTr41j4LCOCkZ8lhAipr05tDtXE1tZp57zSVaJItwuy8zEGYUB5cggXlscrTIOBU6wN800
 AMloERz30e2+6F7R4AaD2gDpqUZVAK2EwW9C5wjxvQ+Yvp2tadPg6SG3b6BI/HM0wUTCUNsvz
 Ni1pVUsjoAjvqWRsJiBAMVv81/lU1vNujxtgJxIeukmuxGBspmv3pxl+FH/MPalJL680Ekb+w
 Ka+hYTjJk9qkGtisXZx9m8hNtlnZjvr/jKNG5ZS64tSKMvuRJN4sm3n5nXn3e3neO2LHewWus
 Vj84ewHD4KZiRzHWtEyU7FVismC0UQ7sQm4nWC7uGj+0854UawZM24d+FvjDho0Nijsx/DJHw
 GB2ZLGjCyZwR1q7Ok1SbWRlaZGegWyTnvNHv7OpKBLv2Og5WTpnK27cvgmEMhUTEnXpIBHz7m
 Ad+oF+tdWJDq0DGgfDmy5cXeSPD8fuIVmylzy1pfQGotMlo8T5P8/VlFztNfRdmyc5P7i3fks
 ltS7ZFjcRL36hJQsO/0M8GegraZ6hIMpp0ZHvYwIvjQug=

=E2=80=A6
> Add the malloc failure checking to avoid possible null
> dereference.
=E2=80=A6

How do you think about to use the following wording variant?

   Add a return value check so that a null pointer dereference will be avo=
ided
   after a memory allocation failure.


Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?

Regards,
Markus

