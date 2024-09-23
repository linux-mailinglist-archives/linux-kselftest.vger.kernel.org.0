Return-Path: <linux-kselftest+bounces-18212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4B997E8B8
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 11:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B881F21D18
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 09:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FE31946D0;
	Mon, 23 Sep 2024 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="Bw2qvpD9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F05CD528;
	Mon, 23 Sep 2024 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083834; cv=none; b=XnVYa3b9JdL4wcC3zlev64kd0MLCam3un+rkKENYvCiQ54vDuniCIC4S0pJBiC6T55F8UnYPeeaxW5yLJxdPLOqWCoZI7dGs5KO/v13hyQJszRqLiddhhnm2KWntvV00NokiueoMXvTrhycs3GucBPBznGxSxh5F6U6o+4DUhQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083834; c=relaxed/simple;
	bh=TIue23DwuyeWW14GUaAJhUSJdguSLXKFkIz0wfKSol4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HB5Wlbkpq1ZtIhaXwsqydOhXXiJ21itq//Nf11KtIatwxYxCpy3KwUyFMFW4aZ4CsDqyRj+mDpoz4DbusfOLRrEj6mLXzJGe3EclG//EVnIevgZGR+WrpyT/Ht18xmaIBiEWUOJGm03J16CEKVENj3u642mxOWgOlQtguygUEII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=Bw2qvpD9; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [10.7.80.49] (193-253-228-142.ftth.fr.orangecustomers.net [193.253.228.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 9E64F200BFFC;
	Mon, 23 Sep 2024 11:22:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 9E64F200BFFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1727083332;
	bh=W0nLkJMWc8XMQpZDRSLr0WBs+8zZYAUDlCaJP9ucxLc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bw2qvpD9A/NPxLSpGqK8vWaQOtBV5pER/mrAsIboCSKcWxlFfuGaJisdgNP8zwki5
	 PPPe72GZG0P8pxIZBdGtRcpLynJqtXZeTcUZhbPwLeiiEFvoT7R2w0oFN4dcF7igMs
	 npVUMbWAdW4BtKIqK4YWOamGLBjVn4eYX4n75rEvEkjWDu53Wz0PjgwB39Tf6FlSUK
	 P3w02oWTNsqjBu9oAx63kDnwWTrQKFXFSVNhKfekSxEu/7iUBG3McDcPUjJDccAwhg
	 ruQgvBxiaRa2ClUvxnBapyXm6LXoZJ17r/pvmjGhiQ1zKSk9YKeK1vmPdy5PHDg13S
	 Bol2kTXLuchRQ==
Message-ID: <e9cf1bf8-2d77-4165-bf64-b41f3b8b880d@uliege.be>
Date: Mon, 23 Sep 2024 11:22:12 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: net: ioam: add tunsrc support
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240907164245.89627-1-justin.iurman@uliege.be>
 <bbeb8c77-1772-45a2-8626-a4e064ab7c54@redhat.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <bbeb8c77-1772-45a2-8626-a4e064ab7c54@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/19/24 09:57, Paolo Abeni wrote:
> On 9/7/24 18:42, Justin Iurman wrote:
>> TL;DR This patch comes from a discussion we had with Jakub and Paolo.
>>
>> This patch updates the IOAM selftests to support the new "tunsrc"
>> feature of IOAM. As a consequence, some changes were required. For
>> example, the IPv6 header must be accessed to check some fields (i.e.,
>> the source address for the "tunsrc" feature), which is not possible
>> AFAIK with IPv6 raw sockets. The latter is currently used with
>> IPV6_RECVHOPOPTS and was introduced by commit 187bbb6968af ("selftests:
>> ioam: refactoring to align with the fix") to fix an issue. But, we
>> really need packet sockets actually... which is one of the changes in
>> this patch (see the description of the topology at the top of ioam6.sh
>> for explanations). Another change is that all IPv6 addresses used in the
>> topology are now based on the documentation prefix (2001:db8::/32).
>> Also, the tests have been improved and there are now many more of them.
>> Overall, the script is more robust.
>>
>> The diff is kind of a mess. Since it's "just" a selftests patch, I
>> didn't bother having a series of two patches (one to remove it, one to
>> add the new one back). Let me know if you think it's necessary for
>> readability.
>>
>> Note: this patch needs this [1] iproute2-next patch to be merged
>> (waiting for David to do so, should be done soon).
>>
>>    [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=884653
>>
>> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> 
> Unfortunatelly we was unable to process this patch before the merge 
> window and net-next is currently closed. You will need to repost it is ~2w.

Hi Paolo,

Sure, no worries.

> Strictly speaking about the patch contents, any chance you could 
> refactor the change in a more 'incremental' way?
> The current format is very hard to review, and even self-tests patches 
> deserve some love ;)

I think the best incremental way I can come up with right now (so that 
it also makes my life easier) is to have a series that (i) removes the 
ioam selftests (patch #1) and (ii) re-adds the new one (patch #2). Would 
you all agree with this?

Cheers,
Justin

> Thanks,
> 
> Paolo
> 

