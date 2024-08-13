Return-Path: <linux-kselftest+bounces-15259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D00950C28
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 20:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95861F222FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 18:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0CA1A38DD;
	Tue, 13 Aug 2024 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQCilvWt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03EA1A2574
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573479; cv=none; b=JexlX2a5efI1G462FI8c1cVQPlCNNg3uod7enqxRAFW/lRx40k6AIB3ha5vG1qM4NfVJAgqnczB5+LHDTAZx+kcKH9TyWNAjaub7H2W4SuDy0cU+/v4AOadTuYo5oBK6gxCWlkR2dHYT+Ow6STL2SGW+vZYn8+KbQj0i9kDykyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573479; c=relaxed/simple;
	bh=Wf89HB0JuBuXM/v6zgDf4chaaOhtvYYLu8c84Gc4k5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aCgRzhmD9gA61nImvcqZZZ+NaQbJ/Xn3UaXvBDoqtOO5DmTRXOTgBRUWQvdRa2tKK6jvyeidhfcjUPojq1aq7m2iuxZzdHkhiSVUcJXrxK0ETEvM1Fin16wcE7souewkJ5KR0+CHd9GEOmCgm0nuymgKPTLzjf5pw5FSqBbZxJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQCilvWt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723573476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjeRpoHvIJg5MafdM5/VBNm6LQMFYWDnbQpg1j0Ad4c=;
	b=eQCilvWtSd7JwD0JmfYpOLMp6ABD0ooeFg8RIWm7g7IC221DYgayp2pn/jpa4pTYGBgAlQ
	rozmXEnrkulQ2ZYHBAucznQ4yE1EzmZ6F3OHZXJTL9EElSu6EgdqGXhjdy9Q6grjzpst+X
	qHq/Ajtxevo3RhJj1McrU40gP6y6suQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-Gu2X6rZNPP6Xwvztoi3viw-1; Tue,
 13 Aug 2024 14:24:16 -0400
X-MC-Unique: Gu2X6rZNPP6Xwvztoi3viw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25BCC1925388;
	Tue, 13 Aug 2024 18:24:10 +0000 (UTC)
Received: from [10.2.16.208] (unknown [10.2.16.208])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C4FA619560A3;
	Tue, 13 Aug 2024 18:24:00 +0000 (UTC)
Message-ID: <6ca76824-331f-407f-afa6-bf75cdca6d96@redhat.com>
Date: Tue, 13 Aug 2024 14:23:57 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] Docs/admin-guide/mm/workingset_report: document
 sysfs and memcg interfaces
To: Yuanchu Xie <yuanchu@google.com>, David Hildenbrand <david@redhat.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>,
 Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Gregory Price <gregory.price@memverge.com>, Huang Ying
 <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
 Lance Yang <ioworker0@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kalesh Singh <kaleshsingh@google.com>, Wei Xu <weixugc@google.com>,
 David Rientjes <rientjes@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Shuah Khan <shuah@kernel.org>,
 Yosry Ahmed <yosryahmed@google.com>, Matthew Wilcox <willy@infradead.org>,
 Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
 Kairui Song <kasong@tencent.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Abel Wu <wuyun.abel@bytedance.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240813165619.748102-1-yuanchu@google.com>
 <20240813165619.748102-8-yuanchu@google.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240813165619.748102-8-yuanchu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


On 8/13/24 12:56, Yuanchu Xie wrote:
> Add workingset reporting documentation for better discoverability of
> its sysfs and memcg interfaces. Also document the required kernel
> config to enable workingset reporting.
>
> Change-Id: Ib9dfc9004473baa6ef26ca7277d220b6199517de
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>
> ---
>   Documentation/admin-guide/mm/index.rst        |   1 +
>   .../admin-guide/mm/workingset_report.rst      | 105 ++++++++++++++++++

The new memory cgroup control files need to be documented in 
Documentation/admin-guide/cgroup-v2.rst as well.

Cheers,
Longman

>   2 files changed, 106 insertions(+)
>   create mode 100644 Documentation/admin-guide/mm/workingset_report.rst
>
> diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
> index 8b35795b664b..61a2a347fc91 100644
> --- a/Documentation/admin-guide/mm/index.rst
> +++ b/Documentation/admin-guide/mm/index.rst
> @@ -41,4 +41,5 @@ the Linux memory management.
>      swap_numa
>      transhuge
>      userfaultfd
> +   workingset_report
>      zswap
> diff --git a/Documentation/admin-guide/mm/workingset_report.rst b/Documentation/admin-guide/mm/workingset_report.rst
> new file mode 100644
> index 000000000000..ddcc0c33a8df
> --- /dev/null
> +++ b/Documentation/admin-guide/mm/workingset_report.rst
> @@ -0,0 +1,105 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +Workingset Report
> +=================
> +Workingset report provides a view of memory coldness in user-defined
> +time intervals, i.e. X bytes are Y milliseconds cold. It breaks down
> +the user pages in the system per-NUMA node, per-memcg, for both
> +anonymous and file pages into histograms that look like:
> +::
> +
> +    1000 anon=137368 file=24530
> +    20000 anon=34342 file=0
> +    30000 anon=353232 file=333608
> +    40000 anon=407198 file=206052
> +    9223372036854775807 anon=4925624 file=892892
> +
> +The workingset reports can be used to drive proactive reclaim, by
> +identifying the number of cold bytes in a memcg, then writing to
> +``memory.reclaim``.
> +
> +Quick start
> +===========
> +Build the kernel with the following configurations. The report relies
> +on Multi-gen LRU for page coldness.
> +
> +* ``CONFIG_LRU_GEN=y``
> +* ``CONFIG_LRU_GEN_ENABLED=y``
> +* ``CONFIG_WORKINGSET_REPORT=y``
> +
> +Optionally, the aging kernel daemon can be enabled with the following
> +configuration.
> +* ``CONFIG_WORKINGSET_REPORT_AGING=y``
> +
> +Sysfs interfaces
> +================
> +``/sys/devices/system/node/nodeX/workingset_report/page_age`` provides
> +a per-node page age histogram, showing an aggregate of the node's lruvecs.
> +Reading this file causes a hierarchical aging of all lruvecs, scanning
> +pages and creates a new Multi-gen LRU generation in each lruvec.
> +For example:
> +::
> +
> +    1000 anon=0 file=0
> +    2000 anon=0 file=0
> +    100000 anon=5533696 file=5566464
> +    18446744073709551615 anon=0 file=0
> +
> +``/sys/devices/system/node/nodeX/workingset_report/page_age_intervals``
> +is a comma separated list of time in milliseconds that configures what
> +the page age histogram uses for aggregation. For the above histogram,
> +the intervals are:
> +::
> +    1000,2000,100000
> +
> +``/sys/devices/system/node/nodeX/workingset_report/refresh_interval``
> +defines the amount of time the report is valid for in milliseconds.
> +When a report is still valid, reading the ``page_age`` file shows
> +the existing valid report, instead of generating a new one.
> +
> +``/sys/devices/system/node/nodeX/workingset_report/report_threshold``
> +specifies how often the userspace agent can be notified for node
> +memory pressure, in milliseconds. When a node reaches its low
> +watermarks and wakes up kswapd, programs waiting on ``page_age`` are
> +woken up so they can read the histogram and make policy decisions.
> +
> +Memcg interface
> +===============
> +While ``page_age_interval`` is defined per-node in sysfs, ``page_age``,
> +``refresh_interval`` and ``report_threshold`` are available per-memcg.
> +
> +``/sys/fs/cgroup/.../memory.workingset.page_age``
> +The memcg equivalent of the sysfs workingset page age histogram
> +breaks down the workingset of this memcg and its children into
> +page age intervals. Each node is prefixed with a node header and
> +a newline. Non-proactive direct reclaim on this memcg can also
> +wake up userspace agents that are waiting on this file.
> +e.g.
> +::
> +
> +    N0
> +    1000 anon=0 file=0
> +    2000 anon=0 file=0
> +    3000 anon=0 file=0
> +    4000 anon=0 file=0
> +    5000 anon=0 file=0
> +    18446744073709551615 anon=0 file=0
> +
> +``/sys/fs/cgroup/.../memory.workingset.refresh_interval``
> +The memcg equivalent of the sysfs refresh interval. A per-node
> +number of how much time a page age histogram is valid for, in
> +milliseconds.
> +e.g.
> +::
> +
> +    echo N0=2000 > memory.workingset.refresh_interval
> +
> +``/sys/fs/cgroup/.../memory.workingset.report_threshold``
> +The memcg equivalent of the sysfs report threshold. A per-node
> +number of how often userspace agent waiting on the page age
> +histogram can be woken up, in milliseconds.
> +e.g.
> +::
> +
> +    echo N0=1000 > memory.workingset.report_threshold


