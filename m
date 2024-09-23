Return-Path: <linux-kselftest+bounces-18231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A04D97EE65
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 17:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496CC1C21414
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 15:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38D519CC0D;
	Mon, 23 Sep 2024 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="APlDxWqm";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Az776og0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF019E960
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106155; cv=none; b=jr/X7uusUAgwwfU8LvAMNzdCNIseDcVQb825Pbq0+HaMWA+q/LExZTn5Nhhjlyfj9X/7LssGKBCQc8C7h9NRWjxpJu3uuxMYbdCZwJRSCLbpm5rxLdyha3bnQ/Uf7zGpPFG2dBRY2B+MtZarD6UsSgH+A8aP68s9lR/ePwz7Fus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106155; c=relaxed/simple;
	bh=jiaxN8v6Qalp5o4bqqg3abzazuoU9/7sYLZwTbmnuaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFA4CgjTIlL4SUHq25ABrxz7dTa4dH8rjzA2emlPHc55mrhTkTL0Q134SIVgUzQyIplOddnrYQlv79d+65NjGPNg30fLjU7lcDo1cgCbufqRs9tPNe10EiZUMZb/KVIJPoCLrMbITEMFIP9dlA50nHz95eT8qTS6fM9xu0fdYxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=APlDxWqm; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Az776og0; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=APlDxWqmTBXAFe7838HFRj9wZn/EWIxAzqoUbY+dtTNtL3NrEjwwpb2IytDBm2MipAoeI4721ewChjGJvkv8WjGylOmIee53b4nhX5tx8UQ9K6cn9wjS6GPMLKbTRXzQjO0toZlPrf/3O2NzaRKA/gK0k4Zm4tGR98tQ9DYO523wUm0kKXOP4gPJLl7OBze7+WI4s3h5tLgaEj13ptNEyjgRx1B4reyGFqMUR9mkKM+bbfwlSo4eXFawqOgqiCm5n4eCewVJzQXmJXF9kd4KWuRlIrHG1CpKaVEqlW0MydwDSd1SwPMEPk4/TDa5MBii+Ypgtw1usXjclr26pGWH0A==; s=purelymail3; d=lkcamp.dev; v=1; bh=jiaxN8v6Qalp5o4bqqg3abzazuoU9/7sYLZwTbmnuaY=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=Az776og0L+ls8jqQjYsVmQ9ClT/HCXcaXmtyN6Qjm5EOYbkcJ9XnxOHW3KxOIsyDP7eimWjHRwAzFU9pNtNI6NI16TmExBu7WIAHh2AAj41hIzInk2asE6CKSH+zvPMFuJ6w8ZqSZhxhSdVnDS9cbC3+T409mzTalb2rccfTScoQ5XkpqJL2Re+snnvhpGFxpByzCfLO+bgGgSE/Xnqih3UMyez2rdcdRc/2f1JUtlkZaKwq9aI35IBC4C79woiNz1nlIN4hLk/TInDzgAJ+Mzf6CE5mVsQXL6C0+u0MLn4xuqeWRn4jC39GYOi1SIk7SLlEy7QPLi1bWsvY9b7IAQ==; s=purelymail3; d=purelymail.com; v=1; bh=jiaxN8v6Qalp5o4bqqg3abzazuoU9/7sYLZwTbmnuaY=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 48571:7130:null:purelymail
X-Pm-Original-To: linux-kselftest@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1210100400;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 23 Sep 2024 15:42:18 +0000 (UTC)
Message-ID: <53395c4b-8e7e-4871-aeed-cf56215a3c26@lkcamp.dev>
Date: Mon, 23 Sep 2024 12:42:14 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] unicode: kunit: refactor selftest to kunit tests
To: Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
 Gabriel Krisman Bertazi <krisman@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht,
 dpereira@lkcamp.dev
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 Pedro Orlando <porlando@lkcamp.dev>
References: <20240922201631.179925-1-gbittencourt@lkcamp.dev>
Content-Language: en-US
From: Pedro Orlando <porlando@lkcamp.dev>
In-Reply-To: <20240922201631.179925-1-gbittencourt@lkcamp.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+CC linux-kselftest

-------

On 22/09/2024 17:16, Gabriela Bittencourt wrote:
> Hey all,
> 
> We are making these changes as part of a KUnit Hackathon at LKCamp [1].
> 
> This patch sets out to refactor fs/unicode/utf8-selftest.c to KUnit tests.
> 
> The first commit is the refactoring itself from self test into KUnit, while
> the second one applies the naming style conventions.
> 
> We appreciate any feedback and suggestions. :)
> 
> [1] https://lkcamp.dev/about/
> 
> Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
> Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
> Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
> Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
> Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
> 
> Gabriela Bittencourt (2):
>    unicode: kunit: refactor selftest to kunit tests
>    unicode: kunit: change tests filename and path
> 
>   fs/unicode/Kconfig                            |   5 +-
>   fs/unicode/Makefile                           |   2 +-
>   fs/unicode/tests/.kunitconfig                 |   3 +
>   .../{utf8-selftest.c => tests/utf8_kunit.c}   | 152 ++++++++----------
>   4 files changed, 76 insertions(+), 86 deletions(-)
>   create mode 100644 fs/unicode/tests/.kunitconfig
>   rename fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} (63%)
> 

