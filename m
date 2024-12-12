Return-Path: <linux-kselftest+bounces-23242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8969EE024
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 08:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6132821B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 07:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C25209F52;
	Thu, 12 Dec 2024 07:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hdALD5FM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bwwh2XFZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BBD1662E7;
	Thu, 12 Dec 2024 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987961; cv=none; b=Gl65j/F7cSf5yT2vNff5yX7cEFH4DXAcRO+U06DGGnV1YadTpg533vnmVgrR+6lslJL8Np/wC8xHcxxvK82DbOxcabzUds9rBRcBtiqiQU6VfWD2B1S1wDz3KsehVEf97VzCZfoWrCfbqoGoFS5aNWX6cY/NcUXOYpVpla++AF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987961; c=relaxed/simple;
	bh=zzxdqFZXUIErIeYCetkNsQbDEpK+q8+9ZMOXDbqAD6M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=s60qVeD9Z30FTzJODrXzZITAkRiytKBPHyQOhJXEiYyFTokM6cvWENSroxPyzaWh81JBceShR0/F+7YFeGV3fp11X7cB4h1Pkd1GhWu7jkSTpKSaOy+4U3Z3Z8as/KsmNQSCTNYy2Zf7b145Tc3z3QoUZaMwoO7yx94UF/zfUww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hdALD5FM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bwwh2XFZ; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id 15DF22007AD;
	Thu, 12 Dec 2024 02:19:18 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 12 Dec 2024 02:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733987958;
	 x=1733995158; bh=580mfzyUQsCTc5a85zB6dfYbdmbbQ2+HZxzSZ4pchqY=; b=
	hdALD5FMM8IuOjz1EOfJc29TdsqLC8ZKj/opabdDMYCcZT5KQtgW+/K7JjfS/OJw
	smKsoR7H0DyyUURopGSXEOd+wG3pgu8xB4WQny/uIEg1hhl3twk5dZX5Lj8pmJxp
	p7tYXarenTfFkhPoAhF8PsrbGhSYelJAnN0E1/rLMB87za8C8/HdqHnDr5myc+wN
	w9b9G4gH3VeFsnNxnK+eh48VUS1Si71Vdq2Ik3SewH/20AuO2O5f4SBKGrQysrRH
	l68WGngchjTYH0bLSrRgxjKpgwJEsxjkdiiY8XhJtqWAsB3yqPBGPHQ8U4hQzz0g
	3A8xK/SlmdSnUhXauR0iaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733987958; x=
	1733995158; bh=580mfzyUQsCTc5a85zB6dfYbdmbbQ2+HZxzSZ4pchqY=; b=B
	wwh2XFZYYInlW3z4d300clygu1iBnBttkr59Q8lY4PyZqcW+738Om2V68//bjNhA
	u0GpL4spYVPUud71bX06A5WpdyI3bnsKky+F+O+S7/Yhyzg6a8rz53+lsV0G0feO
	rq7cRdc2HXAM8wsJrY8iVIVMNZWb99EZxnV9j6+CRPwRZrnqpMUzj9l5AeRnYZJP
	8kL7T69G2h4Gii8eeh6R8umM80bSfUbnS+XFp8XLyzhCNUdQV6ILPdY7a/REjWeG
	tMQx3qCT396hMh+0vOkElXmRZeEvgXaB//pXahdCfwQLKf3ASV1zKOUDl+m02BJs
	q81Qsoga6p906/4egCn1g==
X-ME-Sender: <xms:dY5aZ0ruKPiw_rq_ZPTClPIcVdIlYo9D7xIT_pwScA2M-d2_9EqwZA>
    <xme:dY5aZ6oNso_QKFwl5NzH2HQfxY48sPPYq3TJWd-mOen3FjuQztuH-7mgfuoAj_Uob
    j6JqFqR_HKGgCp7gs0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeggddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpeeggfejudejvdeijeeglefgtdfhudffieetfedugefh
    ffekjeefhedtjeefjeetfeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhn
    uggsrdguvgdpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegrhhhilhgvrhestghouggvfigvrghvvghrshdrtghomhdprhgtphhtthhopeii
    fhhighhurhgrsegtohguvgifvggrvhgvrhhsrdgtohhmpdhrtghpthhtohepsghoqhhunh
    drfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvggrlhhmvghiuges
    ihhgrghlihgrrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurd
    horhhgpdhrtghpthhtoheprhguuhhnlhgrphesihhnfhhrrgguvggrugdrohhrghdprhgt
    phhtthhopehlkhhpsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhuthhosehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dY5aZ5PlLiOOKQY_MJx7_pASTm30i0mlaZNB0PVOenQzeUXnz5k2Gg>
    <xmx:dY5aZ749oX995tsM5Htk9jed6A5SeXp6yd6lrVBZromytQjnQgrRQg>
    <xmx:dY5aZz7CiyDFcw9vamWV8GM_QpSHQKjKwCXdYJF44q5yjeq280EzCQ>
    <xmx:dY5aZ7gEFMKl-V99fUr8kbmjrmEjiFMCDsHxnZSZihL6JLN4hVTeMA>
    <xmx:do5aZ8OE8NZO_w5SKeWNm1ZPPUHrGNcBHD5VRYvUk9gEmpD1Iy4D4ZcW>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 48B8A2220072; Thu, 12 Dec 2024 02:19:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Dec 2024 08:18:50 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "kernel test robot" <lkp@intel.com>,
 "Elizabeth Figura" <zfigura@codeweavers.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, wine-devel@winehq.org,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Wolfram Sang" <wsa-dev@sang-engineering.com>,
 "Arkadiusz Hiler" <ahiler@codeweavers.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Andy Lutomirski" <luto@kernel.org>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "Randy Dunlap" <rdunlap@infradead.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Will Deacon" <will@kernel.org>, "Waiman Long" <longman@redhat.com>,
 "Boqun Feng" <boqun.feng@gmail.com>
Message-Id: <21811752-06d3-44cd-b3e6-f8124676df87@app.fastmail.com>
In-Reply-To: <202412121219.EQhUbN0S-lkp@intel.com>
References: <20241209185904.507350-29-zfigura@codeweavers.com>
 <202412121219.EQhUbN0S-lkp@intel.com>
Subject: Re: [PATCH v6 28/28] ntsync: No longer depend on BROKEN.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Dec 12, 2024, at 05:52, kernel test robot wrote:
> Hi Elizabeth,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on cdd30ebb1b9f36159d66f088b61aee264e649d7a]
>
> url:    
> https://github.com/intel-lab-lkp/linux/commits/Elizabeth-Figura/ntsync-Introduce-NTSYNC_IOC_WAIT_ANY/20241210-031155
> base:   cdd30ebb1b9f36159d66f088b61aee264e649d7a

> All errors (new ones prefixed by >>):
>
>    In file included from include/linux/spinlock.h:60,
>                     from include/linux/wait.h:9,
>                     from include/linux/wait_bit.h:8,
>                     from include/linux/fs.h:6,
>                     from drivers/misc/ntsync.c:11:
>    In function 'check_copy_size',
>        inlined from 'copy_from_user' at include/linux/uaccess.h:207:7,
>        inlined from 'setup_wait' at drivers/misc/ntsync.c:903:6:
>>> include/linux/thread_info.h:259:25: error: call to '__bad_copy_to' declared with attribute error: copy destination size is too small
>      259 |                         __bad_copy_to();
>          |                         ^~~~~~~~~~~~~~~

I looked up the function from the github URL above and found

	int fds[NTSYNC_MAX_WAIT_COUNT + 1];
	const __u32 count = args->count;
	struct ntsync_q *q;
	__u32 total_count;
	__u32 i, j;

	if (args->pad || (args->flags & ~NTSYNC_WAIT_REALTIME))
		return -EINVAL;

	if (args->count > NTSYNC_MAX_WAIT_COUNT)
		return -EINVAL;

	total_count = count;
	if (args->alert)
		total_count++;

	if (copy_from_user(fds, u64_to_user_ptr(args->objs),
			   array_size(count, sizeof(*fds))))
		return -EFAULT;

which looks correct to me, as it has appropriate
range checking on args->count, but I can see how
the warning may be a result of checking 'args->count'
instead of 'count'.

      Arnd

