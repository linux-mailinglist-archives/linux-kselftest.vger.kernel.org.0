Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3743519DEC
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 13:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348730AbiEDL3c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 07:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348719AbiEDL3b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 07:29:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3502A71C;
        Wed,  4 May 2022 04:25:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BE45B210E0;
        Wed,  4 May 2022 11:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651663553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IHotc1tLxNFQnMsMhQ4/PAmmsXVX/ZrmEY2hoLkhoeY=;
        b=prmLabugZEs93348NyPI+Rk+PvbnW03y6T9MnWqgkElCaLaxD76fSofTgRaeDBgj+VsO+6
        JJrL0pJY5taH3pcpCX3mOYmFXRH4wLu2FwI9+uFoFQy61iIBDOsN98iOmHbJLnWAaSemYH
        wBbOqgwKNBoCX7DWQOQHFbvaRdjwiaA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E694132C4;
        Wed,  4 May 2022 11:25:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GYZmFcFicmKxPgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 04 May 2022 11:25:53 +0000
Date:   Wed, 4 May 2022 13:25:52 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v10 7/8] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <20220504112552.GA15266@blackbody.suse.cz>
References: <20220503162149.1764245-1-longman@redhat.com>
 <20220503162149.1764245-8-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503162149.1764245-8-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello.

On Tue, May 03, 2022 at 12:21:48PM -0400, Waiman Long <longman@redhat.com> wrote:
>  Documentation/admin-guide/cgroup-v2.rst | 145 +++++++++++++-----------
>  1 file changed, 79 insertions(+), 66 deletions(-)

A note across various lines -- it seems your new text accidentally mixes
both spaces and tabs for indentation.

> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 69d7a6983f78..94e1e3771830 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> [...]
> +	The value shown in "cpuset.cpus.effective" of a partition root is
> +	the CPUs that the parent partition root can dedicate to the new
> +	partition root.  They are subtracted from "cpuset.cpus.effective"
> +	of the parent and may be different from "cpuset.cpus"

I find this paragraph a bit hard to comprehend (I read it as it talks
about three levels of cgroups (parent, child, grandparent). It is
correct but I'd suggect following formulation (where I additionally
simplifed it by talking about "available" cpus):

> The value shown in "cpuset.cpus.effective" of a partition root is
> the CPUs that the partition root can dedicate to a potential new child
> partition root. The new child subtracts available CPUs from its parent
> "cpuset.cpus.effective".


> +	For a partition root to become valid, the following conditions
> +	must be met.
> +
> +	1) The "cpuset.cpus" is exclusive, i.e. they are not shared by
> +	   any of its siblings (exclusivity rule).
> +	2) The parent cgroup is a valid partition root.
> +	3) The "cpuset.cpus" is not empty and must contain at least
> +	   one of the CPUs from parent's "cpuset.cpus", i.e. they overlap.
> +        4) The "cpuset.cpus.effective" must be a subset of "cpuset.cpus"
> +           and cannot be empty unless there is no task associated with
> +           this partition.

This sounds good to me.

> +        Care must be taken to change a valid partition root to "member"
> +        as all its child partitions, if present, will become invalid.

This does not talk about recovering. Is it intentional? (I.e. to left
implementation defined)

Except the remarks above, I find the concepts described here good. I'll
reply to implementation separately & later.

Regards,
Michal
