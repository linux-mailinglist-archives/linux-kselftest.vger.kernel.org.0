Return-Path: <linux-kselftest+bounces-336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912837F1BA3
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 18:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2B5FB210F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 17:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5BB225DD;
	Mon, 20 Nov 2023 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cr09XTOr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61752A7
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Nov 2023 09:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700502777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EaP8zHgiN92957jp7fZCzqskbnxzXQoKIlUtUyIIKl0=;
	b=cr09XTOrfBW7FXmOhsLI4KNadMGblW1JIfLiz3AEpFLAL3larsAguJ87nh9X+3mFtfPQsS
	0HbwBbU+8MZTX9xvWJrqOSbCf0YH4yJy4pgWL5O8rM2zwCKM3yvIfCkbM+wHLPKw5BpYKA
	Tie+FYF0Vl4KFBmoQPcnGXTuh+M2cno=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-5MHgQduvOpGFOS2IHDsWsg-1; Mon,
 20 Nov 2023 12:52:52 -0500
X-MC-Unique: 5MHgQduvOpGFOS2IHDsWsg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 980C13C0F429;
	Mon, 20 Nov 2023 17:52:51 +0000 (UTC)
Received: from [10.22.33.229] (unknown [10.22.33.229])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D96E410F45;
	Mon, 20 Nov 2023 17:52:50 +0000 (UTC)
Message-ID: <eb92acba-6aab-487d-b06f-1da1c4796b4b@redhat.com>
Date: Mon, 20 Nov 2023 12:52:50 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] cgroup/cpuset: Improve CPU isolation in isolated
 partitions
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Peter Hunt <pehunt@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20231116033405.185166-1-longman@redhat.com>
 <ZVoojBi4ZoVR2mOt@slm.duckdns.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZVoojBi4ZoVR2mOt@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5


On 11/19/23 10:23, Tejun Heo wrote:
> On Wed, Nov 15, 2023 at 10:34:00PM -0500, Waiman Long wrote:
>> v4:
>>   - Update patch 1 to move apply_wqattrs_lock() and apply_wqattrs_unlock()
>>     down into CONFIG_SYSFS block to avoid compilation warnings.
> I already applied v3 to cgroup/for-6.8. Can you please send the fix up patch
> against that branch?
>
Sure. I will post another fixup patch.

Thanks,
Longman


