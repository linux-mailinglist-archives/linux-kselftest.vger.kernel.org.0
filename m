Return-Path: <linux-kselftest+bounces-1251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A77806A04
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 09:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D33A2813AD
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 08:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D696618C18;
	Wed,  6 Dec 2023 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="F3nkpE2P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5823D4B;
	Wed,  6 Dec 2023 00:46:00 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 714EA1FD03;
	Wed,  6 Dec 2023 08:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701852359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwIA41qwVke6sh1/FSzZs9q9NAcH6wFzAZcpVOEwDtg=;
	b=F3nkpE2PwX4hk0Xxxgt+mJSvMVMZfgQN6BAAK4xuanoRacEXwVPgGTMCMARe2ltM1/eDQY
	CbOHJYIJvPIId67Ct911v689d00ph0QCWReF90MKFe7PRToKfTMKqu3mmOGqRQNIWMe5ry
	YjXK5TmQZ8ggVwgve7qQ+D+zgYiF/D8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53950136CD;
	Wed,  6 Dec 2023 08:45:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7iNfEcc0cGWnMgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 06 Dec 2023 08:45:59 +0000
Date: Wed, 6 Dec 2023 09:45:58 +0100
From: Michal Hocko <mhocko@suse.com>
To: David Finkel <davidf@vimeo.com>
Cc: Muchun Song <muchun.song@linux.dev>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <ZXA0xuFHLRRUaU8a@tiehlicka>
References: <20231204194156.2411672-1-davidf@vimeo.com>
 <ZW7oXalrpQWdWZNJ@tiehlicka>
 <CAFUnj5PqZ5zybYJ4uCiv-8cfdyg3d9NmzMjy=cYB+DkRNEiJug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFUnj5PqZ5zybYJ4uCiv-8cfdyg3d9NmzMjy=cYB+DkRNEiJug@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.22
X-Spamd-Result: default: False [0.22 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.18)[-0.907];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]

On Tue 05-12-23 11:00:47, David Finkel wrote:
> On Tue, Dec 5, 2023 at 4:07 AM Michal Hocko <mhocko@suse.com> wrote:
> 
> > > This behavior is particularly useful for work scheduling systems that
> > > need to track memory usage of worker processes/cgroups per-work-item.
> > > Since memory can't be squeezed like CPU can (the OOM-killer has
> > > opinions), these systems need to track the peak memory usage to compute
> > > system/container fullness when binpacking workitems.
> >
> > I do not understand the OOM-killer reference here but I do understand
> > that your worker reuses a cgroup and you want a peak memory consumption
> > of a single run to better profile/configure the memcg configuration for
> > the specific worker type. Correct?
> 
> To a certain extent, yes.
> At the moment, we're only using the inner memcg cgroups for
> accounting/profiling, and using a
> larger (k8s container) cgroup for enforcement.
> 
> The OOM-killer is involved because we're not configuring any memory limits on
> these individual "worker" cgroups, so we need to provision for
> multiple workloads using
> their peak memory at the same time to minimize OOM-killing.

OK, that makes more sense now. Just be aware that you might under
utilize your limit that way because peak memory can still be reclaimed.
If you set the hard limit (memory.max) to the peak memory consumption
you would get a very conservative configuration wihtout any memory
reclaim.
 
> In case you're curious, this is the job/queue-work scheduling system
> we wrote in-house
> called Quickset that's mentioned in this blog post about our new
> transcoder system:
> https://medium.com/vimeo-engineering-blog/riding-the-dragon-e328a3dfd39d

Thanks!

-- 
Michal Hocko
SUSE Labs

