Return-Path: <linux-kselftest+bounces-18678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5522298ABBC
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 20:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E347EB20F0F
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 18:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06536199248;
	Mon, 30 Sep 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Of9/INfG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF7E1991BE
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719967; cv=none; b=DfvE7IUjSb5s99n1EuQtkegI+d8YUUEhjFghrmKIohfjnE4oKq9K5hAKWTZTh/oG2lZ7p+Ydea5H60vZKMC+0cGmCaArFFNgHGZqyF8vlRk6OIGyXTJtuhW0AHDuKlEKeA5PUyEOU/eOwKoLosbFtz3Lpz3D2vhRuvy0+rpvJpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719967; c=relaxed/simple;
	bh=dlu1mH5bGSJsyE1ixR3p8HBxAyolLICTGGEcWVYRtCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJfttopbWWhFSVlK8VTrsaDbv0DuJ7YgP6QHKbCssqbvMiaQWfJlEevxZnag6bDTvviMMJaRx72THxFFT+P6pUMTkBEnoBR1p/J/MHV6CUOY1WrAv9XhmSyNeLTlLNfvl/YwbqCCVxX3Ewh8fqeYoWpoiNdIa98rIbCzPuGm8Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Of9/INfG; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <83297afc-f2fa-4fb6-be0f-f73905f726ef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727719963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqnjojoj1Y1D57oeAHxWP7P0UrCbjXLwC4A9xtDaDwo=;
	b=Of9/INfGwyXJypaxCYDs4BIXLb927cUzmwpWOpAWSxcm9QV+BBQI54d5ztfT6PEbme+DI8
	fm4x7dNF5yEO0avZdsLuR8pyRURlmz8c/XfKY9A/Ap1b3V8KUCTwyOIN1rxA7r9JHWIBCS
	WnVDtDMJNo6QIDQKqrzHSZgXslcZo6c=
Date: Mon, 30 Sep 2024 14:12:37 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] selftests: net: csum: Clean up
 recv_verify_packet_ipv6
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240930162935.980712-1-sean.anderson@linux.dev>
 <66fadcd4b8f08_18740029417@willemb.c.googlers.com.notmuch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <66fadcd4b8f08_18740029417@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/30/24 13:16, Willem de Bruijn wrote:
> Sean Anderson wrote:
>> Rename ip_len to payload_len since the length in this case refers only
>> to the payload, and not the entire IP packet like for IPv4. While we're
>> at it, just use the variable directly when calling
>> recv_verify_packet_udp/tcp.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> 
> Not sure such refactoring patches are worth the effort.

Well, FWIW you commented on this in your review, so I figured I'd send it.

https://lore.kernel.org/all/66dbb4fcbf560_2af86229423@willemb.c.googlers.com.notmuch/

--Sean

