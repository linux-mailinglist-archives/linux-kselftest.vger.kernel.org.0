Return-Path: <linux-kselftest+bounces-8071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C23B28A60D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 04:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805B42818D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 02:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ADA11181;
	Tue, 16 Apr 2024 02:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TgfuDBEV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B69101D4;
	Tue, 16 Apr 2024 02:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233632; cv=none; b=QnoZkKQydXOj1iYe9LSopRsESYUfLc/ebfsFB9dOQguaWVHc9IQMEgCwcSHwHY+ii4cxD2ywaR9mnyy0PDcsHUHTDTDhxFH92bTIASiqq/9A1+j3vssxBOIH0/ge/VSQN3Wc8O3eP+8vHzmkHPlyBDgEu1DIrh81hCabKOLsPg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233632; c=relaxed/simple;
	bh=tnJFAO7QrPjusS1qw/TiYMLSqEXIPPHBurqgo9xcJT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DGOFlB62QsKypTZ+1XFZtAgSOfuSM8ro9XBfcFQMi7CQiYP2GcrJ+mXMlpPuD0wKjqSIpy56AkgCfKQDFPEAfmJow/FIIULOlfcltCSNhoK5K3Gh1TDlDriXh6kX7oTinFy7FbEOxeXYbSMY+iBr/EzdWT4T7GQwi/xrEGOW9Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TgfuDBEV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=8l2g+qShkQJg5de25+Sa2UhpWJe5smK8XXARY/imiTY=; b=TgfuDBEVB07nmNa6k5ZJ/Rc9Hu
	/O7kuvTbr5xLNRop+Aine7Qm93Dp68jnmmjgoNuOxkdbCvysP7nKuNudDYHZxo50K2Pu7jhn6dhqe
	nL6bV8lnZwkHytQjCI3w7d0rT6T5YHmkAtSmohpV+KA/DNip3Ah3CpW4cxmxVS/3DDGvDhKIWPBIR
	00bDf6Ud+4LHbCT0jggYKcucmLFkLn8jkqRUsN+aR7LsUCC9akn3A2hDgUNx+Ng6MTZC3OATAcGxB
	xRnVFlMW7GIREm4FgutVCBCl++MWAe1cnHZRPS/SFUokSniopdYHRLuEqWAvkij+XdQCHkAdiVWv8
	pQpyP4UA==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwYKL-0000000AWFh-2nba;
	Tue, 16 Apr 2024 02:13:42 +0000
Message-ID: <3b0af7ef-5525-4a8e-beb0-71f55fb0e4bc@infradead.org>
Date: Mon, 15 Apr 2024 19:13:40 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/27] docs: ntsync: Add documentation for the ntsync
 uAPI.
To: Elizabeth Figura <zfigura@codeweavers.com>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Wolfram Sang <wsa@kernel.org>,
 Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>
References: <20240416010837.333694-1-zfigura@codeweavers.com>
 <20240416010837.333694-28-zfigura@codeweavers.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240416010837.333694-28-zfigura@codeweavers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/15/24 6:08 PM, Elizabeth Figura wrote:
> Add an overall explanation of the driver architecture, and complete and precise
> specification for its intended behaviour.
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/userspace-api/index.rst  |   1 +
>  Documentation/userspace-api/ntsync.rst | 399 +++++++++++++++++++++++++
>  2 files changed, 400 insertions(+)
>  create mode 100644 Documentation/userspace-api/ntsync.rst

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

