Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D4344C6B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Nov 2021 19:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhKJSSx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Nov 2021 13:18:53 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38906 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhKJSSx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Nov 2021 13:18:53 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 01A821FD48;
        Wed, 10 Nov 2021 18:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636568164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WrfmgeAir/bcyFgACSGpgDgNuM+uhrNAmeRnW3A3QN0=;
        b=CvbVadvRn6in1GwXmbxlxRhD5agTW4BW2HFq6oifyXHR2R6X4K9nvUrApT3LJ7EKkEzPiP
        kEYCK/rJTOgzQxglqUQNTOwOVaUTJIVMQtXTo9PwTFj/u4ME10JU1UxVtcEYdjkbeyy4MU
        X+3kR+EBq/NX4NNVl9w/zfUkh8/cVHQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF4B013C7D;
        Wed, 10 Nov 2021 18:16:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TdXOLWMMjGF7OQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 10 Nov 2021 18:16:03 +0000
Date:   Wed, 10 Nov 2021 19:15:58 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     "Moessbauer, Felix" <felix.moessbauer@siemens.com>
Cc:     "longman@redhat.com" <longman@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "guro@fb.com" <guro@fb.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        "pauld@redhat.com" <pauld@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
        "henning.schild@siemens.com" <henning.schild@siemens.com>
Subject: Re: [PATCH v8 0/6] cgroup/cpuset: Add new cpuset partition type &
 empty effecitve cpus
Message-ID: <20211110181558.GB51149@blackbody.suse.cz>
References: <20211018143619.205065-1-longman@redhat.com>
 <20211110111357.17617-1-felix.moessbauer@siemens.com>
 <20211110135653.GD20566@blackbody.suse.cz>
 <AM9PR10MB4869C14EAE01B87C0037BF6A89939@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR10MB4869C14EAE01B87C0037BF6A89939@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 10, 2021 at 03:21:54PM +0000, "Moessbauer, Felix" <felix.moessbauer@siemens.com> wrote:
> 2. Threads can be started on non-rt CPUs and then bound to a specific rt CPU.
> This binding can be specified before thread creation via pthread_create.
> By that, you can make sure that at no point in time a thread has a
> "forbidden" CPU in its affinities.

It should boil down to some clone$version(2) and sched_setaffinity(2)
calls, so strictly speaking even with pthread_create(3) the thread is
shortly running with the parent's affinity.

> With cgroup2, you cannot guarantee the second aspect, as thread
> creation and moving to a cgroup is not an atomic operation.

As suggested by others, CLONE_INTO_CGROUP (into cpuset cgroup) can
actually "hide" the migration into the clone3() call.

> At creation time, you cannot set the final affinity mask (as you
> create it in the non-rt group and there the CPU is not in the
> cpuset.cpus).
> Once you move the thread to the rt cgroup, it has a default mask and
> by that can be executed on other rt cores.

Good point. Perhaps you could work this around by having another level
of (non-root partition) cpuset cgroups for individual CPUs? (Maybe
there's more clever approach, this is just first to come into my mind.)

Michal
