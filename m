Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C4E46EBF1
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Dec 2021 16:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhLIPnh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Dec 2021 10:43:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57145 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232694AbhLIPnh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Dec 2021 10:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639064403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QT9+Eto76AQyhw6YgaOC53MIX23XQDyrz/FUT+QNKSA=;
        b=IYxRplC0bArMAOMadTUm5zF+8/tdQueCnyrn2PuYt/SP/vDu8DaQ4is6LRvryLfhy9A9qc
        OkHV6zvcIp+f7ri151eoiVYcpm4gUuUaV4n0FWvMO/R9yAxAgcQAh7OXWqDXELF9JV0pPh
        Ki031gXXs6hf8MvECegAyBdBsDANY4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-aqBLroqWND6umz035CDTRg-1; Thu, 09 Dec 2021 10:40:00 -0500
X-MC-Unique: aqBLroqWND6umz035CDTRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AE9A100CCCB;
        Thu,  9 Dec 2021 15:39:58 +0000 (UTC)
Received: from [10.22.10.109] (unknown [10.22.10.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE0E04ABB5;
        Thu,  9 Dec 2021 15:39:55 +0000 (UTC)
Message-ID: <f74efd4a-eee8-3927-f975-92b4c457cb9c@redhat.com>
Date:   Thu, 9 Dec 2021 10:39:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v9 0/7] cgroup/cpuset: Add new cpuset partition type &
 empty effecitve cpus
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20211205183220.818872-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211205183220.818872-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/5/21 13:32, Waiman Long wrote:
> v9:
>   - Add a new patch 1 to remove the child cpuset restriction on parent's
>     "cpuset.cpus".
>   - Relax initial root partition entry limitation to allow cpuset.cpus to
>     overlap that of parent's.
>   - An "isolated invalid" displayed type is added to
>     cpuset.cpus.partition.
>   - Resetting partition root to "member" will leave child partition root
>     as invalid.
>   - Update documentation and test accordingly.
>
> v8:
>   - Reorganize the patch series and rationalize the features and
>     constraints of a partition.
>   - Update patch descriptions and documentation accordingly.
>
> v7:
>   - Simplify the documentation patch (patch 5) as suggested by Tejun.
>   - Fix a typo in patch 2 and improper commit log in patch 3.
>
> This patchset includes one bug fix and four enhancements to the cpuset v2 code.
>
>   Patch 1: Allow parent to set "cpuset.cpus" that may not be a superset
>   of children's "cpuset.cpus" for default hierarchy.
>
>   Patch 2: Enable partition with no task to have empty cpuset.cpus.effective.
>
>   Patch 3: Refining the features and constraints of a cpuset partition
>   clarifying what changes are allowed.
>
>   Patch 4: Add a new partition state "isolated" to create a partition
>   root without load balancing. This is for handling intermitten workloads
>   that have a strict low latency requirement.
>
>   Patch 5: Enable the "cpuset.cpus.partition" file to show the reason
>   that causes invalid partition like "root invalid (No cpu available
>   due to hotplug)".
>
> Patch 6 updates the cgroup-v2.rst file accordingly. Patch 7 adds a new
> cpuset test to test the new cpuset partition code.
>
> Waiman Long (7):
>    cgroup/cpuset: Don't let child cpusets restrict parent in default
>      hierarchy
>    cgroup/cpuset: Allow no-task partition to have empty
>      cpuset.cpus.effective
>    cgroup/cpuset: Refining features and constraints of a partition
>    cgroup/cpuset: Add a new isolated cpus.partition type
>    cgroup/cpuset: Show invalid partition reason string
>    cgroup/cpuset: Update description of cpuset.cpus.partition in
>      cgroup-v2.rst
>    kselftest/cgroup: Add cpuset v2 partition root state test
>
>   Documentation/admin-guide/cgroup-v2.rst       | 168 +++--
>   kernel/cgroup/cpuset.c                        | 440 +++++++-----
>   tools/testing/selftests/cgroup/Makefile       |   5 +-
>   .../selftests/cgroup/test_cpuset_prs.sh       | 667 ++++++++++++++++++
>   tools/testing/selftests/cgroup/wait_inotify.c |  87 +++
>   5 files changed, 1142 insertions(+), 225 deletions(-)
>   create mode 100755 tools/testing/selftests/cgroup/test_cpuset_prs.sh
>   create mode 100644 tools/testing/selftests/cgroup/wait_inotify.c
>
Hi,

Is this patch series good enough or is there other changes you would 
still like to make in this series?

Cheers,
Longman

