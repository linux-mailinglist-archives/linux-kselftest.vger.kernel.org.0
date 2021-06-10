Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACACD3A2DF4
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jun 2021 16:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhFJOWF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Jun 2021 10:22:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59365 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230084AbhFJOWE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Jun 2021 10:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623334808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vPeoXcqrS3MIzkBmzsxPXiPd+AVSGxxS032+qPVyFQc=;
        b=emwIM/5iNbNCcmHaQEBEDcWF9j0q9PbgJ2scksJl8AP2hIwiJXsr5a1fgZ/gOVpbKi3HLT
        tr0PtQKUnVim3KhT5uMHI2LcX35at2feqN8cokcSBn60UXZA+eT545fZmp/+1An/Di/Rre
        OHCBIlm1sE8hizWIFcq62TO8YddCVTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-4Iz9mnYoM26GMVnPmhD8sw-1; Thu, 10 Jun 2021 10:20:06 -0400
X-MC-Unique: 4Iz9mnYoM26GMVnPmhD8sw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB3378030A0;
        Thu, 10 Jun 2021 14:20:01 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.8.122])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 95DAB60C5E;
        Thu, 10 Jun 2021 14:19:49 +0000 (UTC)
Date:   Thu, 10 Jun 2021 10:19:47 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 0/5] cgroup/cpuset: Enable cpuset partition with no load
 balancing
Message-ID: <YMIfg0Aa2HZQPEy+@lorien.usersys.redhat.com>
References: <20210603212416.25934-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603212416.25934-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Waiman,

On Thu, Jun 03, 2021 at 05:24:11PM -0400 Waiman Long wrote:
> This patchset makes the following two major changes to the cpuset v2 code:
> 
>  Patch 2: Add a new partition state "root-nolb" to create a partition
>  root with load balancing disabled. This is for handling intermitten
>  workloads that have a strict low latency requirement.
> 
>  Patch 3: Allow partition roots that are not the top cpuset to distribute
>  all its cpus to child partitions as long as there is no task associated
>  with that partition root. This allows more flexibility for middleware
>  to manage multiple partitions.

Thanks!  This looks like it will be a usable replacement for the functionality
lost when SD_LOAD_BALANCE went away.


Cheers,
Phil

> 
> Patch 4 updates the cgroup-v2.rst file accordingly. Patch 5 adds a test
> to test the new cpuset partition code.
> 
> Waiman Long (5):
>   cgroup/cpuset: Don't call validate_change() for some flag changes
>   cgroup/cpuset: Add new cpus.partition type with no load balancing
>   cgroup/cpuset: Allow non-top parent partition root to distribute out
>     all CPUs
>   cgroup/cpuset: Update description of cpuset.cpus.partition in
>     cgroup-v2.rst
>   kselftest/cgroup: Add cpuset v2 partition root state test
> 
>  Documentation/admin-guide/cgroup-v2.rst       |  19 ++-
>  kernel/cgroup/cpuset.c                        | 124 +++++++++++----
>  tools/testing/selftests/cgroup/Makefile       |   2 +-
>  .../selftests/cgroup/test_cpuset_prs.sh       | 141 ++++++++++++++++++
>  4 files changed, 247 insertions(+), 39 deletions(-)
>  create mode 100755 tools/testing/selftests/cgroup/test_cpuset_prs.sh
> 
> -- 
> 2.18.1
> 

-- 

