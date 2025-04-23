Return-Path: <linux-kselftest+bounces-31386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A67A98405
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 10:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ABA917D1EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 08:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869401DFD8F;
	Wed, 23 Apr 2025 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="m31CpV73"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21CB1D515A;
	Wed, 23 Apr 2025 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745397985; cv=none; b=ai6grKOsWPrCeBRjPTDk0YXttea9aEgrzo8E4ASXUX9wbrzODO3n5cNkXy56lwjHcm7cV5OWMrjOfIUsHyNn8Uw9CpDi8NXib9qWjaUDIfKwjMIWUUS6KfrE78G5URCcl3u0UA+AWsT/k10ihwKFhp6c4LT4cHy+3SWiSTO2DWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745397985; c=relaxed/simple;
	bh=ro/RxJwGTo0wu9Wl6SHHN0DVxtsSkTUrvzIFd8ea9W8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Cu4aQ3OBKlJ19WhK4PRprj6wm+7s1Ol+UeCwlRn8c2WgEaDbjFOuzEg0OscwZw3Qi8YBvbgXuxNYYyU469Bz/2ByioVx9Q9Cq9TbEoSZpxy1x+5aT2V8bLTa97zQNb7C+ITVuifKQ/ApQ0Q/sUeITO/Wx1zxfLLO1+d9q2q3Dws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=m31CpV73; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1745397954; x=1746002754; i=markus.elfring@web.de;
	bh=ro/RxJwGTo0wu9Wl6SHHN0DVxtsSkTUrvzIFd8ea9W8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=m31CpV73bHR4520I4Puv9rtSlv5sugGkqpqvqMNvcOdsuzG03tk0B83Qfd4JU/oc
	 8jSDiaibeLZicz5QTcqrafYIxNCeUjeRbOCLFZw3k/p40yAZqoYxw7HntyLU61S+7
	 mMexKi29fG0/vwnD3IvdOLkKAYnt90Z01j1K6ik+FOgj6svzd/7qCBlj6L00F7nRd
	 MZ3ox6MU7Mfbhw8W25jkr4j3UeBIC/zlsMXX0CYrEy1kPJfRA0fJMr/pUDVxdBw0O
	 fhDeE1RRveI6HLY/u+dQY8/h6Pql2B2VAPtD0x/2cqHNEiihPvxinodME3g8v+HCy
	 W1AvkHO+mjgKjbMoNg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.6]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNOVK-1uRwHA2SfC-00Z635; Wed, 23
 Apr 2025 10:45:54 +0200
Message-ID: <cde757c8-fd15-4538-9bb6-1341cddb38dc@web.de>
Date: Wed, 23 Apr 2025 10:45:50 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Jiayuan Chen <mrpre@163.com>,
 syzbot+e6e8f6618a2d4b35e4e0@syzkaller.appspotmail.com,
 yonghong.song@linux.dev, LKML <linux-kernel@vger.kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>
References: <20250417044041.252874-2-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf-next 1/2] bpf: Create cgroup storage if needed when
 updating link
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250417044041.252874-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a2RveycS6Z8tGnyvKpnVd/v0KGJzShQ6CNmwUoLzvk/92Hu16Ed
 9N4/xd/Yp/DHt4HQkGivemBOhkPCkGgybccwQCiCXbBURE+qwnf5UUvqYMYmlL66jsQQT7W
 K6qeueKbcaZ2b2OAPJJksujM6vNDt0Ggbv7Ts0zgzdglkubs8N1Nk9E8ITiIzZtBH2IhlVz
 BWJgzvtxnRIiejHnXCsyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jqoPEhpswPc=;FpxypifhLUr8GkAl0Q5xtCMCGJA
 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
 qE4Zb0FQfPGaKSG6dFhqvk=

=E2=80=A6
> This cause a painc when accessing stroage in bpf_get_local_storage.

Please avoid typos in such a change description.


How do you think about to append parentheses to function names?

See also:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.15-rc3#n94

Regards,
Markus

