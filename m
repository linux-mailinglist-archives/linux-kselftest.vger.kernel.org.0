Return-Path: <linux-kselftest+bounces-814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD217FD240
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 10:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0914E1C20FBD
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 09:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1B713AFC;
	Wed, 29 Nov 2023 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ysd/KVdq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB951BC2;
	Wed, 29 Nov 2023 01:18:56 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 41A881F898;
	Wed, 29 Nov 2023 09:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701249535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gFnuBA9yIUylMwMyyAsH56skdpfLwIzJlMW0SKtsi6g=;
	b=Ysd/KVdqX42jUhsPekseKBmF8aHmcw1IWa4erQtjmW8eLxS/MvhD4vacDqBv9Hd1uLPKj4
	3Ff7DbSPNnpMvKZiqauXOW7vLPZppySJ1Su5QAOrUUD0Ii0TzM6i+CGQmleFMJxejCLFom
	3cpR0HNQwxD3VRNnLO8KhoctTZJV/MM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1533A13637;
	Wed, 29 Nov 2023 09:18:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 53ZsAv8BZ2XkcgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 29 Nov 2023 09:18:55 +0000
Date: Wed, 29 Nov 2023 10:18:54 +0100
From: Michal Hocko <mhocko@suse.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org,
	cerasuolodomenico@gmail.com, yosryahmed@google.com,
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
	roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v6 2/6] memcontrol: allows mem_cgroup_iter() to check for
 onlineness
Message-ID: <ZWcB_r8ywytCFR8B@tiehlicka>
References: <20231127193703.1980089-1-nphamcs@gmail.com>
 <20231127193703.1980089-3-nphamcs@gmail.com>
 <ZWW1IG0Mv3r0m4mp@tiehlicka>
 <CAKEwX=OGtkqWys9VM9EBScoCdAjSdfPjEkvoY7_u9udDZBFFpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=OGtkqWys9VM9EBScoCdAjSdfPjEkvoY7_u9udDZBFFpw@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [-0.80 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[34.72%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,gmail.com,google.com,redhat.com,ieee.org,konsulko.com,linux.dev,kernel.org,kvack.org,meta.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -0.80

On Tue 28-11-23 08:53:56, Nhat Pham wrote:
> On Tue, Nov 28, 2023 at 1:38 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 27-11-23 11:36:59, Nhat Pham wrote:
> > > The new zswap writeback scheme requires an online-only memcg hierarchy
> > > traversal. Add a new parameter to mem_cgroup_iter() to check for
> > > onlineness before returning.
> >
> > Why is this needed?
> 
> For context, in patch 3 of this series, Domenico and I are adding
> cgroup-aware LRU to zswap, so that we can perform workload-specific
> zswap writeback. When the reclaim happens due to the global zswap
> limit being hit, a cgroup is selected by the mem_cgroup_iter(), and
> the last one selected is saved in the zswap pool (so that the
> iteration can follow from there next time the limit is hit).
> 
> However, one problem with this scheme is we will be pinning the
> reference to that saved memcg until the next global reclaim attempt,
> which could prevent it from being killed for quite some time after it
> has been offlined. Johannes, Yosry, and I discussed a couple of
> approaches for a while, and decided to add a callback that would
> release the reference held by the zswap pool when the memcg is
> offlined, and the zswap pool will obtain the reference to the next
> online memcg in the traversal (or at least one that has not had the
> zswap-memcg-release-callback run on it yet).

This should be a part of the changelog along with an explanation why
this cannot be handled on the caller level? You have a pin on the memcg,
you can check it is online and scratch it if not, right? Why do we need
to make a rather convoluted iterator interface more complex when most
users simply do not require that?

-- 
Michal Hocko
SUSE Labs

