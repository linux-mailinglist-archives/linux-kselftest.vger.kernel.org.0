Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA251561E2C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jun 2022 16:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbiF3OhO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Jun 2022 10:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbiF3Ogz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Jun 2022 10:36:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286CA201A6;
        Thu, 30 Jun 2022 07:32:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CB1B921EFB;
        Thu, 30 Jun 2022 14:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656599532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r+2jSverPOfqGEKU6YL54SGkmzqRewq0zi4aTwuQWVg=;
        b=NQJFxWMbAHm7LziJAaX0qwJ3jblN0hLNNfEOc+ukjrHuS04pTcAJtGu2PvLSHHm2baWcLi
        6d6yoEW/ti0PFPza/gAw0Pv8kuPVwzG0Cqo/igYQU3BYxnCm+v4Hr+jEtN7Hz8DTdG0u0/
        9iFRnVdTN7We1cfra567KIbMx3damAM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FB7913A5C;
        Thu, 30 Jun 2022 14:32:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +DZiHuyzvWJHbAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 30 Jun 2022 14:32:12 +0000
Date:   Thu, 30 Jun 2022 16:32:11 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
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
Subject: Re: [PATCH v11 7/8] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <20220630143211.GA22105@blackbody.suse.cz>
References: <20220510153413.400020-8-longman@redhat.com>
 <YqYnQ4U4t6j/3UaL@slm.duckdns.org>
 <404171dc-0da3-21f2-5003-9718f875e967@redhat.com>
 <YqarMyNo9oHxhZFh@slm.duckdns.org>
 <20220613142452.GB6910@blackbody.suse.cz>
 <YqdzuSQuAeiPXQvy@slm.duckdns.org>
 <20220613175548.GB21665@blackbody.suse.cz>
 <Yqd7WMFj6AEyV3Cy@slm.duckdns.org>
 <20220614115345.GA6771@blackbody.suse.cz>
 <YroApRMPV/6zO5I8@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YroApRMPV/6zO5I8@mtj.duckdns.org>
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

On Tue, Jun 28, 2022 at 04:10:29AM +0900, Tejun Heo <tj@kernel.org> wrote:
> What I'm trying to say is that cpuset.cpus of child_1 and child_2 are
> owned by the parent,

Cf

On Mon, Jun 13, 2022 at 08:00:56AM -1000, Tejun Heo <tj@kernel.org> wrote:
> On Mon, Jun 13, 2022 at 07:55:49PM +0200, Michal Koutn=FD wrote:
> > I don't think child_*/cpuset.cpus must be owned by root.
>=20
> I meant the parent.

I'm slightly confused.

> so a feature which blocks siblings from intersecting each other
> doesn't make whole lot of sense because all those files are under the
> control of the parent who would have the power to enable or disable
> the restrition anyway.

file				owner
parent/				user (mkdir)
`- cpuset.cpus			root
`- cpuset.cpus.partition	root	(P)
`- child_1/			user
  ` cpuset.cpus			user	(*)
`- child_2/			user
  ` cpuset.cpus			user	(*)

The writes to child cpuset.cpus may/may not invalidate parent's (P)
partition validity (whether a cpu is left to it to host possible tasks).
child_1 vs child_2 overlap affects only whether the children cgroups are
a valid partition.

I think you mean: writes to children cpuset.cpus should be allowed,
possible exclusivity violation should be reported in
parent/cpuset.cpus.partition.

What I thought was OK: prevent (fail) writes to children cpuset.cpus
that'd violate the exclusivity (or would take the last cpu from parent
if it's necessary to host a task).
IMO, it's similar to failed writes to parent/cgroup.subtree_control in a
delegated subtree if the parent still has some tasks (that'd violate
internal node constraint).

What I think might still be OK: allow writes to children cpuset.cpus
that violate exclusivity and report that in children's
cpuset.cpus.partition. Writes that'd take last cpu from parent should
still fail (similar to the failing subtree_control writes above).

Hope that clarifies,
Michal
