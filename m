Return-Path: <linux-kselftest+bounces-42979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5670BD02A8
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Oct 2025 15:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDE03B871A
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Oct 2025 13:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA731274FF1;
	Sun, 12 Oct 2025 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uVgynvdx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963432594BD;
	Sun, 12 Oct 2025 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760275647; cv=none; b=FV2t32PihXRTWPO6mDvO1kxPR3dTI9pi6F+elzQEwzBlJpdnisglzJaPJiIVAaZMGv7cBsok1yLfX8wMrCsAfWY3KaOIorTiwarRUzvdg8vFZ4M5US2zcffYlO8lnruItFiCQMhZOtcvLj8sep77w1XnbAZNckjha+GeatLvPqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760275647; c=relaxed/simple;
	bh=pjqlBmK1+WbqnxRQqFRg6aWJ1GRKnD6tJB2spJsJOTo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=CtolHzhKcZgdKBSkJlRuvX3RSexK/DooxC0G7t1ElJHh8fXi+IGh6d6rPsH0MO7jA4gSwwfgn66wCrAoI4RdFasX7T0m4kKNOOKsWoeumiKZ7ywED2ppyU+X5rwms9E6gruElrI1F2TACmtILEZcRk3PdceRFi05d4xy2CdVbWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uVgynvdx; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760275594; x=1760880394; i=markus.elfring@web.de;
	bh=yVG8ADOPDzqUmkywmgv9dc2B90UlYkCVvSg1ciAYIFg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uVgynvdxLKobuK46q24Dep5yA0kbVnCiMyB0iFSBftMOhXlZZbPa+Q7Q8SL+1DXL
	 KoNvsuYS+4wpVBAeO6GNn9kKyCFOeoM39REJ/7QtDFCB1UaxddjMyyxxmMlW13e80
	 cyBigF+AvQNY3ht+KYW+4el19RVKdgKk8jcw5LWcqvcfvceHW5DTmrgbmSJPybqV+
	 sXuDHcSFqbtVkOPv4l7n7as1s97dV5KbvVRh3ntC6DZJHRLK3v15fzw8X5uQf2eN7
	 1DUfLs5SDBO9p1V6DwEZ0ZC2Y/ALuWVJWBrKuIqB+4lwCh0sBgmK3tgVQ0fv8/Qr2
	 +S2+XDv5pabcZinjxg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNfU1-1urnDm441j-00VjQA; Sun, 12
 Oct 2025 15:26:34 +0200
Message-ID: <0aea408f-f6d7-4e2d-8cee-1801ad7f3139@web.de>
Date: Sun, 12 Oct 2025 15:26:20 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li RongQing <lirongqing@baidu.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 wireguard@lists.zx2c4.com, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, David Hildenbrand <david@redhat.com>,
 Feng Tang <feng.tang@linux.alibaba.com>, Florian Westphal <fw@strlen.de>,
 Jakub Kicinski <kuba@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Joel Granados <joel.granados@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Petr Mladek <pmladek@suse.com>, Phil Auld <pauld@redhat.com>,
 Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20251012115035.2169-1-lirongqing@baidu.com>
Subject: Re: [PATCH v3] hung_task: Panic after fixed number of hung tasks
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251012115035.2169-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WAgp8h3DyF6g11AayvlQAbFiTVzjoFCtdKXHQo068coehoUT01P
 bW6tgArZAVON6B1QS/KDDP2llblnKalEayJyP8SUrAkR49Edq95sn6phJexJn8o27fA/S0y
 1cIqFOnqVLrsmWwTO+jLfK/uCP4ll9phmEtknMatXpyd6vM5267T2cBLBfCQ7rQmSBpkzAc
 Y/rAKFr/N7Lq0QmKzb1Xw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4M4KDQe0V1M=;DELwcmNw3ZKCxN2ao5uzkogf/bG
 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
 RXGoA==

=E2=80=A6
> This patch extends the =E2=80=A6

Will another imperative wording approach become more helpful for an improv=
ed
change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17#n94


=E2=80=A6
> +++ b/kernel/hung_task.c
=E2=80=A6
@@ -229,9 +232,11 @@ static void check_hung_task(struct task_struct *t, un=
signed long timeout)
=E2=80=A6
>  	trace_sched_process_hang(t);
> =20
> -	if (sysctl_hung_task_panic) {
> +	if (sysctl_hung_task_panic &&
> +			(total_hung_task >=3D sysctl_hung_task_panic)) {
=E2=80=A6

I suggest to use the following source code variant instead.

	if (sysctl_hung_task_panic && total_hung_task >=3D sysctl_hung_task_panic=
) {


Regards,
Markus

