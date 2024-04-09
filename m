Return-Path: <linux-kselftest+bounces-7442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C6689CF3C
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 02:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F1DEB228F4
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 00:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E116638B;
	Tue,  9 Apr 2024 00:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBgUIW4k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFDA370
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Apr 2024 00:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712621573; cv=none; b=hfejzVLTxiMWOpWqfKPAG9PIZPT31EA2KILyY4qLCDd7KYw/qVSs9JW8OLDiS+BS9rokl7l8kciKVbPaCMK6LJxVCPEubMSgoePELkyqd72Qv0/DaJKI5bniASrxiwMwB++elXp9e2LhiNi86Z80wkaqyZv/WJfUOxn+enQ/ivw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712621573; c=relaxed/simple;
	bh=rA42DVPIz8tTwXvz9KosnbYvthn+MzPB6Blbd4aKlmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9lMZNfhWCUKpJJZ8xZHL2GRgLxWGOqkj6yAtjSfLZE1ZaEH7tfBvTB3UDk9IG8mIlU2opUUQjKzmoPJV1BtnKx/EleoIkBq728wfhsClwGLhBNWiML52swtxqNZFUbEdA2hB4FmYZ1jaj/HYOcOwAc7WW+JZpnliQ/upMSyKa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CBgUIW4k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712621571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EZMDqLk/ajYnQzQR/K3NrKQIpgpLukxRoVqcEZWTdt4=;
	b=CBgUIW4kd54nQZWRDPtcMqRyjk3VK3VbHDeMJGRoM8CMOUgY6RmI46qBtYeoxHGxOwGzKB
	pldW0Gg+PaEwBlkcMnF3+oyCSDoQxS3V/5t/BDeQqNFefLvt/eFFuACeg6ACbtta/TYj/Q
	AFRY6TmQPBSEy1Hf7xuuH73TqlEIpdM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-YqHu-p8-MzCfFmqjip8zgg-1; Mon, 08 Apr 2024 20:12:45 -0400
X-MC-Unique: YqHu-p8-MzCfFmqjip8zgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D880802A6F;
	Tue,  9 Apr 2024 00:12:44 +0000 (UTC)
Received: from [10.22.34.20] (unknown [10.22.34.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 77F11C09A05;
	Tue,  9 Apr 2024 00:12:43 +0000 (UTC)
Message-ID: <ec74bc9f-8e63-44b9-b3a6-ca7d6d366c69@redhat.com>
Date: Mon, 8 Apr 2024 20:12:43 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 6/9] selftests: cgroup: Add basic tests for pids
 controller
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>
References: <20240405170548.15234-1-mkoutny@suse.com>
 <20240405170548.15234-7-mkoutny@suse.com>
 <a45c2ece-acb4-4cff-9d53-f5c007c9b905@collabora.com>
 <qweowkm4wlfzovp3qhtkzbybeampodtwmpbp2kbtiqcrhmjtdt@syk4itfkpmfr>
 <41dd9c5a-0e07-4b98-9dfb-fb57eaa74fa2@collabora.com>
 <oosadt3f5i3qsvisrxe6hrs46ryfqbyxyk3a6jimd7cqczjtcw@dvlsm7eh3b6r>
 <4bae7682-801e-498f-88c9-9c9d45364bfc@collabora.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <4bae7682-801e-498f-88c9-9c9d45364bfc@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8


On 4/8/24 08:04, Muhammad Usama Anjum wrote:
> On 4/8/24 5:01 PM, Michal Koutný wrote:
>> On Mon, Apr 08, 2024 at 04:53:11PM +0500, Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
>>> ksft_test_result_report(tests[i].fn(root), tests[i].name)
>> $ git grep ksft_test_result_report v6.9-rc3 --
>> (empty result)
>>
>> I can't find that helper. Is that in some devel repositories?
> Sorry, I always do development on next. So it has been added recently. Try
> searching it on next:
>
> git grep ksft_test_result_report next-20240404 --

I don't believe it is a good idea to make this patch having a dependency 
on another set of patches in -next because the test won't run in a 
non-next environment. We can always have additional patches later on to 
modify the tests to use the newly available APIs.

Cheers,
Longman

>
>> Michal


