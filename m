Return-Path: <linux-kselftest+bounces-15283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D0C9510BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 01:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99240284971
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 23:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80B81AB50A;
	Tue, 13 Aug 2024 23:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2ZTeVl1n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B46383BF;
	Tue, 13 Aug 2024 23:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723592767; cv=none; b=peIppLUwa+SBw2VgzcX+UFn99Pm3lsAn+BFHWSbVbVF7yiY4DxVSpyvjgqxe+CyCcFpOq+IKKCOaJBILnKFMJnotIgsciaUlnE2+B3f+nzqIIaieRVwNYl+eDx2jqp/cu4sZJ1YO4I7OrtbNkk1qKkPVAYXjeNIpxMWhMHk/1dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723592767; c=relaxed/simple;
	bh=SHgY4ZvnWkFc93CY6rQuMpZOg5xNuwIcczixIIZwUis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fm+W3Zp3rf4zpSzHKIfhMgzJVRWacDVw80CpGl6UU7GIqDoLN/86h4iX8UelNXxoUP+zSyAdf1VzLJo1TBDJdy6xVnN3ihBSpEXTh+rOywB0gU2Yu2jjH7nV67QaekH5FLTA5jn8rw2jDeWr/ZFhf5XX5AKlI3bvK48wt3PaEi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2ZTeVl1n; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=btvoCIHjpMVaBKfPYLfJYOWHcXgBOeBZSXsRuU6oyxo=; b=2ZTeVl1nNyBkwimbRyXw0IBhgm
	wG48wQMzJjVYoWaclTlRSp8ooSuX1D+uuSx81NOkFpLcPG7S6uMxIxRNDfAvMQ1aGwYVNb8r4HXUo
	pjYocvWZEVvsL20WKpLG1rwmCDpNO5+A9Ex0tmOiCKZBfTUWoep88gurhldDm+kgWq4AkExJ+nUZU
	Q2V1HgsM4pf5r3HG2RjH3dVMlZPkB9QsymsFQkDHbJhHz0EgHxUwe7wRWQKGi4m65Ovkzq0MbpRKY
	X9bhe2L0n+dljceBTRMSzdbl0NSpfhKhV+B1fImnZDz7JEbDDNmiR+xfzjJH3/k3WAMyIAfYtqNhG
	DZ0XLwQw==;
Received: from [50.53.9.16] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se1Cy-00000005DRu-0WM0;
	Tue, 13 Aug 2024 23:45:46 +0000
Message-ID: <227f9190-e065-462e-9a25-0ebd5e3dc955@infradead.org>
Date: Tue, 13 Aug 2024 16:45:42 -0700
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
 Lance Yang <ioworker0@gmail.com>,
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
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240813165619.748102-8-yuanchu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/13/24 9:56 AM, Yuanchu Xie wrote:
> Add workingset reporting documentation for better discoverability of
> its sysfs and memcg interfaces. Also document the required kernel
> config to enable workingset reporting.
> 
> Change-Id: Ib9dfc9004473baa6ef26ca7277d220b6199517de
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>
> ---
>  Documentation/admin-guide/mm/index.rst        |   1 +
>  .../admin-guide/mm/workingset_report.rst      | 105 ++++++++++++++++++
>  2 files changed, 106 insertions(+)
>  create mode 100644 Documentation/admin-guide/mm/workingset_report.rst
> 

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

                   e.g., X bytes are Y milliseconds cold.

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

        comma-separated

> +the page age histogram uses for aggregation. For the above histogram,
> +the intervals are:
> +::

I guess just change the "are:" to "are::" and change the line that only
contains "::" to a blank line.  Otherwise there is a warning:

Documentation/admin-guide/mm/workingset_report.rst:54: ERROR: Unexpected indentation.


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

   E.g.

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

   E.g.

> +::
> +
> +    echo N0=2000 > memory.workingset.refresh_interval
> +
> +``/sys/fs/cgroup/.../memory.workingset.report_threshold``
> +The memcg equivalent of the sysfs report threshold. A per-node
> +number of how often userspace agent waiting on the page age
> +histogram can be woken up, in milliseconds.
> +e.g.

   E.g.

> +::
> +
> +    echo N0=1000 > memory.workingset.report_threshold

-- 
~Randy

