Return-Path: <linux-kselftest+bounces-16331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EBF95F9D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 21:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2A31F22CFA
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 19:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41F91991D5;
	Mon, 26 Aug 2024 19:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDJdjVLp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3CD80034
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724701294; cv=none; b=qk/6hFU07OKbSNhjFdQOZmEb7O5mziy6RdfAbKcG+tirdg40BfYtP01TzPZwkHDUIwx/1ItH+bZ48UC5w66ITpoFBuJQ8zwgsyvbWfQBVIrkI6xWCy7m4hMNBAsyKbk8coaBNo0yrJMKwzpMtLEHi3J8Gf7AMuSIc80J6BDChzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724701294; c=relaxed/simple;
	bh=YBbRZtirXd6o7CwjpvmKYRPMTiOmSsS+A1fhHpSoiiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZW+UWn9Cwx1W0+lAH6LkaOQ13CaFZMnhRGUVLd/wXAZQyNzxc1ngr3M/YqenHXMAnvkWRclSCIRKfKTm+uvnCx4+7PuYA3gOvAgypVhTYAL2RS7c7YjLI1VpX17Ig/QmOjIGXWpDaUrnid6e85/d8RFnb0K2353NTCyMNLM6tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jDJdjVLp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724701292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tc+FMU3SHLP9qdwgTJG7YvFdlWIWsDbgpSsFFf4KmPg=;
	b=jDJdjVLpbQMaJ+fhWhqBHgoZOAYZKyK8k7EUxB55InRd6ILKVX7RQixi9qt++YKWMqUo4J
	BXrLdcE2GD/fYAFdvbcd+maRi+v1NnwSdKaeAg1TSjkvLN6yHTuMbhkcMdSdFbzFoadlGE
	sXAzosBz/HwK6Pme3HweUKAD7C8ie8k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-u7nz4JulMR2-YyLoAQGHrA-1; Mon,
 26 Aug 2024 15:41:28 -0400
X-MC-Unique: u7nz4JulMR2-YyLoAQGHrA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10EAE1956064;
	Mon, 26 Aug 2024 19:41:27 +0000 (UTC)
Received: from [10.2.16.157] (unknown [10.2.16.157])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D468C19560A3;
	Mon, 26 Aug 2024 19:41:24 +0000 (UTC)
Message-ID: <102a1760-6440-4535-aaf4-d7c1aa6e97b3@redhat.com>
Date: Mon, 26 Aug 2024 15:41:23 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup 0/2] cgroup/cpuset: Account for boot time isolated
 CPUs
To: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240820195536.202066-1-longman@redhat.com>
 <ce01caf5-e576-4614-b6b8-0206da1a7c49@redhat.com>
 <ZszSDG7GlvKQTydh@slm.duckdns.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZszSDG7GlvKQTydh@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


On 8/26/24 15:05, Tejun Heo wrote:
> Hello, Waiman.
>
> On Mon, Aug 26, 2024 at 03:01:21PM -0400, Waiman Long wrote:
>> Ping! Any comment on these patches?
> cgroup side looks fine to me. Ping isol people?

This patchset is specific to cpuset code and doesn't touch any isolation 
code at all. My other isolation related patch series [1] does have a 
dependency on this one to work correctly.

[1] https://lore.kernel.org/lkml/20240821142312.236970-1-longman@redhat.com/

Cheers,
Longman


