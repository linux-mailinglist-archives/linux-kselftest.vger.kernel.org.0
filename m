Return-Path: <linux-kselftest+bounces-8627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 547A68AD089
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 17:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9FF1F22D39
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 15:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A74152E04;
	Mon, 22 Apr 2024 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krpPezXo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC3714F10C;
	Mon, 22 Apr 2024 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799432; cv=none; b=ifPYAFI/jFu4BRJh16torvaVOTougZaOgWEHEthnSl8JPtX6zR/kDFiaJwPQ95EG2KgnbfJETodSYNXGeuRf+/GQik5RhMxk0izyUH8hN/Rbn0HertE2z7PWYQvxC29DhXo6YoQgmMnwTHtyHaB9FwhtmaRUCeBqqG4kXqnHNIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799432; c=relaxed/simple;
	bh=+S7kxweT9O/j57A4jhfdggtEzSSGgH8KJ7ly/PXxRUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhQIpKZIXFSQxvayp9kay4iq+phU9kKBbPpW4VkYdSfo9xL3tJPPDoprB/gEEyj5Ysrjb8iZvIPZw9iRlLmG1ZrQSyWwsyaYGfQn2mYloAOxrJZcFwjjAs9DHao8F6j+zabD6bacdeOHSZNGtyjXxQ6MXWk/wUiTs3UjUFTt3dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krpPezXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BF8C113CC;
	Mon, 22 Apr 2024 15:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713799431;
	bh=+S7kxweT9O/j57A4jhfdggtEzSSGgH8KJ7ly/PXxRUQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=krpPezXoNxed+E4SIQwq09cva46Iyrh3diV/2r6HPsz8+AxvhaEGx98d58PrAZKZc
	 GgpgwCtCp6xdqMo3gVtGB3SL8f+z/hOJgapgeBHmDM+oY3yI8zJUPvQbN2TZxXaEIC
	 P4acQP9/iR7pDo4VCn4CR2K2STi16ui7VpdkQ0yGx2McAgmUWn5FdpAw8E6DityQgS
	 ik5AEag6X83tzzxGR660VSOGFn4cEyOGkM7+VvXWeveAQQODBgZL9drcxUul7pVk68
	 qHF1lVIEazNqBYbtmi+C2oMmgvVFQNVlXrKeNdRrfSAVwHpb/11nLw17ZEHMfXhrHo
	 7DzNitJMhpiWw==
Message-ID: <bf799baf-d258-47d7-bf55-7b31d3b62c9d@kernel.org>
Date: Mon, 22 Apr 2024 09:23:50 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] netdev: support dumping a single netdev in
 qstats
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
 netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org, sdf@google.com,
 amritha.nambiar@intel.com, linux-kselftest@vger.kernel.org
References: <20240420023543.3300306-1-kuba@kernel.org>
 <20240420023543.3300306-2-kuba@kernel.org>
 <CANn89iK-wnNeH+9-Oe6xi9OjoY5jcZCowJ5wDL7hJz1tRhMfQQ@mail.gmail.com>
 <a1340c70-bbc9-4b23-8e9a-1bc401132721@kernel.org>
 <20240422064825.18850cc3@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240422064825.18850cc3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/24 7:48 AM, Jakub Kicinski wrote:
> On Sun, 21 Apr 2024 13:32:24 -0600 David Ahern wrote:
>> On 4/21/24 1:17 PM, Eric Dumazet wrote:
>>> I wonder if NLM_F_DUMP_FILTERED should not be reported to user space ?  
>>
>> good point. We do set that flag for other dumps when a filter has been
>> used to limit data returned.
> 
> That flag appears to be a, hm, historic workaround?
> If I was to guess what the motivation was I'd say that it's because
> "old school netlink" didn't reject unknown attributes. And you wanted
> to know whether the kernel did the filtering or you have to filter
> again in user space? Am I close? :)

close enough based on what I can recall.

> 
> The flag is mostly used in the IP stack, I'd rather try to deprecate 
> it than propagate it to new genetlink families which do full input
> validation, rendering the flag 100% unnecessary.


