Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A45475679
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Dec 2021 11:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241701AbhLOKgd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Dec 2021 05:36:33 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39474 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbhLOKgd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Dec 2021 05:36:33 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B842C1F39F;
        Wed, 15 Dec 2021 10:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639564591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/aPaR9Uw4ulAkIgHecWl2en5QXeWEK3aOB4cy3NVwDI=;
        b=N0Oi6iG4jR1Ii/2w8VZGdDCkCls7BxgRGgpITtz5WTEMqIEVtEn64XU5QoylIR/K2x/31p
        dRUkaE8ntIn9pTwzN1kEQ9S+rdhVnK7upRk8kdKOg/KeAaBeb/daspbclQWbET4VvGyatI
        iuTmVTTFyDVEZ/YCPSS9aAkJG5W4m/0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85BE613B1C;
        Wed, 15 Dec 2021 10:36:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /RwjIC/FuWHZdAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 15 Dec 2021 10:36:31 +0000
Date:   Wed, 15 Dec 2021 11:36:29 +0100
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
Subject: Re: [PATCH v9 2/7] cgroup/cpuset: Allow no-task partition to have
 empty cpuset.cpus.effective
Message-ID: <20211215103629.GA25459@blackbody.suse.cz>
References: <20211205183220.818872-1-longman@redhat.com>
 <20211205183220.818872-3-longman@redhat.com>
 <Ybew7d2oE2gLcLNO@slm.duckdns.org>
 <810204ce-7967-e470-1267-7c3cfb521c89@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <810204ce-7967-e470-1267-7c3cfb521c89@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 14, 2021 at 10:24:22PM -0500, Waiman Long <longman@redhat.com> wrote:
> AFAICS, there are code in cpuset.c that disallows the an non-child node to
> hold tasks, but the check doesn't cover all the possible cases.
> I remembered that I was able to create such a scenario without using
> threaded domains.

On the default hierarchy (with controller(s) enabled)? That sounds like a bug.

> That is why I put in this conditional check. It has nothing to do with the
> use of threaded domains.

But threaded domains are important nevertheless.
I think that a structure like

	app-cgroup	cgroup.type=threaded domain	cpuset.partition=root
	`- rt		cgroup.type=threaded		cpuset.partition=isolated
	`- normal	cgroup.type=threaded

is a valid use case. Therefore I would not disallow partitioning inside
threaded subtrees (as suggested).


Michal
