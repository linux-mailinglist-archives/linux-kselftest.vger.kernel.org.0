Return-Path: <linux-kselftest+bounces-13857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5299934642
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 04:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45A7EB21852
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 02:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E29A1BDDB;
	Thu, 18 Jul 2024 02:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Chm9TWFn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE4F1FB5
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jul 2024 02:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721269345; cv=none; b=j17Ie0MsgAOxsQ3/4QhlV2aO5kkA5+DQTURp6/0FFkWW7bUWARJq48bOB5WG5Caaq7sRSQZ1ubOKURrZzIOi5MfbwAU6tBTalpSTgRqSw+NF6oyFv6CYJ1c+i8xM/XTVghx+xLCs2L9Bkjbg7fJaVTgGRJYQfcz7+GKeXlv2IUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721269345; c=relaxed/simple;
	bh=dREXj+0w+CFnbqC/KdsZ8rUAi8ch+xarvadXOl5uRj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGOjaWuwOgxKk3rVie6eMpxmSvz9ZpFufC9MidfZ9043DmpZxNsCWcGdYDhZ9TzoWNFEqDvIAt2XnsssyHIr9+MU+Ml5n7gqCoENtx1FMGDUYr6PRBTshC6eGp7Kf0tl9VvN9usnUvdHE/xf4UMBgbUVfChgrmLQXe1vv7Mb0IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Chm9TWFn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721269342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=op/3tKtTGqIBuOoiHm9+X+k3cZHvHECwan0paq2e89w=;
	b=Chm9TWFnSeh87nTyiEwgYyK7Rcy/Hlm43RBRNw3xOuYMy7ExDUu4fd2N3S/2u9QJzCnJDN
	QGWkbh4QzMQ226xx574PBRuX8YH6LPsZq85cjrPTOOu6hVvfnmqZoIuop1cYqvRo29Wkth
	Mv7/RoWfBnguqYLiaaTfhuxi/QLBHxg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-8WNXbSF4NHyNwiJs-RVBGw-1; Wed,
 17 Jul 2024 22:22:16 -0400
X-MC-Unique: 8WNXbSF4NHyNwiJs-RVBGw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C5BA1955D56;
	Thu, 18 Jul 2024 02:22:13 +0000 (UTC)
Received: from [10.22.16.209] (unknown [10.22.16.209])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E4E319560B2;
	Thu, 18 Jul 2024 02:22:09 +0000 (UTC)
Message-ID: <0addf17f-1dc8-40f1-970a-9a3d44b14d71@redhat.com>
Date: Wed, 17 Jul 2024 22:22:08 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Tejun Heo <tj@kernel.org>
Cc: David Finkel <davidf@vimeo.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
 Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shuah Khan <shuah@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>
References: <20240715203625.1462309-1-davidf@vimeo.com>
 <20240715203625.1462309-2-davidf@vimeo.com> <ZpZ6IZL482XZT1fU@tiehlicka>
 <ZpajW9BKCFcCCTr-@slm.duckdns.org> <20240717170408.GC1321673@cmpxchg.org>
 <CAFUnj5OA0KaC54M9vd8W+NZJwz5Jw25u-BStO=Bi2An=98Ruwg@mail.gmail.com>
 <20240717204453.GD1321673@cmpxchg.org>
 <CAFUnj5OGJtR0wqOZVUh8QQ3gaw4gmatsEN1LcBdcwN_wx-LUug@mail.gmail.com>
 <85a67b00-9ae7-42a1-87e0-19b5563b9a0f@redhat.com>
 <Zphu4SDGCJ-IExnf@slm.duckdns.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <Zphu4SDGCJ-IExnf@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


On 7/17/24 21:24, Tejun Heo wrote:
> On Wed, Jul 17, 2024 at 07:48:40PM -0400, Waiman Long wrote:
> ...
>> How about letting .peak shows two numbers? The first one is the peak since
>> the creation of the cgroup and cannot be reset. The second one is a local
>> maximum that can be reset to 0. We just to keep track of one more counter
>> that should be simple enough to implement.
> What Johannes suggested seems to hit all the marks - it's efficient and
> relatively simple, the overhead is only on the users of the facility, and
> flexible in a straightforward manner. I have a hard time buying the argument
> that it's more difficult to use - the benefit to cost ratio seems pretty
> clear. Given that, I'm not sure why we'd want to add something fishy that
> can lead to longterm problems.

On second thought, it is a change in the user interface that may break 
existing apps that use the peak file. So it is probably better to go 
with Johannes' suggestion.

Thanks,
Longman


