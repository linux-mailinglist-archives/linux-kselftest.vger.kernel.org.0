Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53596F9D2E
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 May 2023 03:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjEHBEm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 May 2023 21:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjEHBEj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 May 2023 21:04:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B9B100F0
        for <linux-kselftest@vger.kernel.org>; Sun,  7 May 2023 18:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683507831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yNJL2kG/0UIHUcIFT9+ra+rm25yTkCXYyXj8ZQWBWis=;
        b=QDPd4/XStczy37zbrvIPimJBUEw39esMN1b9YNnfNlk2UAUmR1TE7edoMbfRKB/xWTQcg0
        a6YLl/ciLHxjgz/39bXVVkhv6XPZv+7KPv45B+NPZxs3qAaJUWzJka/n6NNFPxIfl/ZomR
        Y6HH9VpPPy0/KWeZIHqcTLbJrH3XxBM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-YY8RQShXNZi9T1VyKmEdXg-1; Sun, 07 May 2023 21:03:46 -0400
X-MC-Unique: YY8RQShXNZi9T1VyKmEdXg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3062885622;
        Mon,  8 May 2023 01:03:45 +0000 (UTC)
Received: from [10.22.16.113] (unknown [10.22.16.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 050ECC15BA0;
        Mon,  8 May 2023 01:03:44 +0000 (UTC)
Message-ID: <405b2805-538c-790b-5bf8-e90d3660f116@redhat.com>
Date:   Sun, 7 May 2023 21:03:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 0/5] cgroup/cpuset: A new "isolcpus" paritition
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mrunal Patel <mpatel@redhat.com>,
        Ryan Phillips <rphillips@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>, Phil Auld <pauld@redhat.com>
References: <226cb2da-e800-6531-4e57-cbf991022477@redhat.com>
 <ZDmFLfII8EUX_ocY@slm.duckdns.org>
 <c61ca9d0-c514-fb07-c2f2-3629e8898984@redhat.com>
 <ZDmOjeBVsIcgSLIV@slm.duckdns.org>
 <60ec12dc-943c-b8f0-8b6f-97c5d332144c@redhat.com>
 <46d26abf-a725-b924-47fa-4419b20bbc02@redhat.com>
 <jqkf7jkuyxqiupmxmdbmpnbpojub2pjsz3oogwncmwqdghlsgk@phsqzirmmlyl>
 <f2bd7b1e-190e-1d08-f085-b4cae36fb5be@redhat.com>
 <ZFGOTHQj3k5rzmyR@blackbook>
 <deb7b684-3d7c-b3ae-7b36-5b7ba2dd8001@redhat.com>
 <ZFUo5IYAIwTEKR4_@slm.duckdns.org>
 <759603dd-7538-54ad-e63d-bb827b618ae3@redhat.com>
In-Reply-To: <759603dd-7538-54ad-e63d-bb827b618ae3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

The following is the proposed text for "cpuset.cpus.reserve" and 
"cpuset.cpus.partition" of the new cpuset partition in 
Documentation/admin-guide/cgroup-v2.rst.

   cpuset.cpus.reserve
     A read-write multiple values file which exists only on root
     cgroup.

     It lists all the CPUs that are reserved for adjacent and remote
     partitions created in the system.  See the next section for
     more information on what an adjacent or remote partitions is.

     Creation of adjacent partition does not require touching this
     control file as CPU reservation will be done automatically.
     In order to create a remote partition, the CPUs needed by the
     remote partition has to be written to this file first.

     A "+" prefix can be used to indicate a list of additional
     CPUs that are to be added without disturbing the CPUs that are
     originally there.  For example, if its current value is "3-4",
     echoing ""+5" to it will change it to "3-5".

     Once a remote partition is destroyed, its CPUs have to be
     removed from this file or no other process can use them.  A "-"
     prefix can be used to remove a list of CPUs from it.  However,
     removing CPUs that are currently used in existing partitions
     may cause those partitions to become invalid.  A single "-"
     character without any number can be used to indicate removal
     of all the free CPUs not allocated to any partitions to avoid
     accidental partition invalidation.

   cpuset.cpus.partition
     A read-write single value file which exists on non-root
     cpuset-enabled cgroups.  This flag is owned by the parent cgroup
     and is not delegatable.

     It accepts only the following input values when written to.

       ==========    =====================================
       "member"    Non-root member of a partition
       "root"    Partition root
       "isolated"    Partition root without load balancing
       ==========    =====================================

     A cpuset partition is a collection of cgroups with a partition
     root at the top of the hierarchy and its descendants except
     those that are separate partition roots themselves and their
     descendants.  A partition has exclusive access to the set of
     CPUs allocated to it.  Other cgroups outside of that partition
     cannot use any CPUs in that set.

     There are two types of partitions - adjacent and remote.  The
     parent of an adjacent partition must be a valid partition root.
     Partition roots of adjacent partitions are all clustered around
     the root cgroup.  Creation of adjacent partition is done by
     writing the desired partition type into "cpuset.cpus.partition".

     A remote partition does not require a partition root parent.
     So a remote partition can be formed far from the root cgroup.
     However, its creation is a 2-step process.  The CPUs needed
     by a remote partition ("cpuset.cpus" of the partition root)
     has to be written into "cpuset.cpus.reserve" of the root
     cgroup first.  After that, "isolated" can be written into
     "cpuset.cpus.partition" of the partition root to form a remote
     isolated partition which is the only supported remote partition
     type for now.

     All remote partitions are terminal as adjacent partition cannot
     be created underneath it.

     The root cgroup is always a partition root and its state cannot
     be changed.  All other non-root cgroups start out as "member".

     When set to "root", the current cgroup is the root of a new
     partition or scheduling domain.

     When set to "isolated", the CPUs in that partition will
     be in an isolated state without any load balancing from the
     scheduler.  Tasks placed in such a partition with multiple
     CPUs should be carefully distributed and bound to each of the
     individual CPUs for optimal performance.

     The value shown in "cpuset.cpus.effective" of a partition root is
     the CPUs that are dedicated to that partition and not available
     to cgroups outside of that partittion.

     A partition root ("root" or "isolated") can be in one of the
     two possible states - valid or invalid.  An invalid partition
     root is in a degraded state where some state information may
     be retained, but behaves more like a "member".

     All possible state transitions among "member", "root" and
     "isolated" are allowed.

     On read, the "cpuset.cpus.partition" file can show the following
     values.

       ============================= =====================================
       "member"            Non-root member of a partition
       "root"            Partition root
       "isolated"            Partition root without load balancing
       "root invalid (<reason>)"    Invalid partition root
       "isolated invalid (<reason>)"    Invalid isolated partition root
       ============================= =====================================

     In the case of an invalid partition root, a descriptive string on
     why the partition is invalid is included within parentheses.

     For an adjacent partition root to be valid, the following
     conditions must be met.

     1) The "cpuset.cpus" is exclusive with its siblings , i.e. they
        are not shared by any of its siblings (exclusivity rule).
     2) The parent cgroup is a valid partition root.
     3) The "cpuset.cpus" is not empty and must contain at least
        one of the CPUs from parent's "cpuset.cpus", i.e. they overlap.
     4) The "cpuset.cpus.effective" cannot be empty unless there is
        no task associated with this partition.

     For a remote partition root to be valid, the following conditions
     must be met.

     1) The same exclusivity rule as adjacent partition root.
     2) The "cpuset.cpus" is not empty and all the CPUs must be
        present in "cpuset.cpus.reserve" of the root cgroup and none
        of them are allocated to another partition.
     3) The "cpuset.cpus" value must be present in all its ancestors
        to ensure proper hierarchical cpu distribution.

     External events like hotplug or changes to "cpuset.cpus" can
     cause a valid partition root to become invalid and vice versa.
     Note that a task cannot be moved to a cgroup with empty
     "cpuset.cpus.effective".

     For a valid partition root with the sibling cpu exclusivity
     rule enabled, changes made to "cpuset.cpus" that violate the
     exclusivity rule will invalidate the partition as well as its
     sibling partitions with conflicting cpuset.cpus values. So
     care must be taking in changing "cpuset.cpus".

     A valid non-root parent partition may distribute out all its CPUs
     to its child partitions when there is no task associated with it.

     Care must be taken to change a valid partition root to
     "member" as all its child partitions, if present, will become
     invalid causing disruption to tasks running in those child
     partitions. These inactivated partitions could be recovered if
     their parent is switched back to a partition root with a proper
     set of "cpuset.cpus".

     Poll and inotify events are triggered whenever the state of
     "cpuset.cpus.partition" changes.  That includes changes caused
     by write to "cpuset.cpus.partition", cpu hotplug or other
     changes that modify the validity status of the partition.
     This will allow user space agents to monitor unexpected changes
     to "cpuset.cpus.partition" without the need to do continuous
     polling.

Cheers,
Longman

