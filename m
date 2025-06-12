Return-Path: <linux-kselftest+bounces-34803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B62FFAD6D07
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 12:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC2B16498E
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 10:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE4E22FF59;
	Thu, 12 Jun 2025 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e2TvbBmT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="APnNyG+/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e2TvbBmT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="APnNyG+/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD8D20F07C
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749722672; cv=none; b=WHjsQtEj4ullxq8ukAw9DS7WTYDkrY9IqX4PvRN7s7lt47YZdwEWs9Ov93OUre1EMBfd81hcS6L90/NUnNUnmp+bp2Vpnlc1tqlx9N/SRCvAR8kkDTEpCAH8lxQ0WNTjbvyG1eKMLnKEE8eLB8373ElL+Y4vAw6qroDo+gmCq5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749722672; c=relaxed/simple;
	bh=RPRO3clRitgHhKcTpL9w+jEcTYCkh5ssqhuszA4m2uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8mpZSlaIllTecnftky2cB/ojhO+O5X2P3ilI89jnG0UylbvgVThZFz+Hr58dLAcSyWvlUdHypwlERW44w8+gUP8WHbzLtLYlOT5/Y5/DkMrJCONz5rk0a4IVdumIGEkNW8XsA7fuQXJ0FjQzVH+mBwBSfPwMkb+K6a0uzNvFBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e2TvbBmT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=APnNyG+/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e2TvbBmT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=APnNyG+/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 943781F78E;
	Thu, 12 Jun 2025 10:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749722668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/1XDCp8OYvA+z/UwMP73ZXJFEOA8NUW8dP0h9kaHSg=;
	b=e2TvbBmT7qvjnSUmPy0aoqTJ4Xkn288Soe26WsexCH6VJT4Cr5ByDKa6XENAHlB5Wy0mYv
	MiBlgH75zqWei+0qQ0ojiMstCKkYfjigBr/tMGffbkwNGMnJJ8Hqyz+Sa/mflVtXwnqQnT
	mUDE5hNdUrxkAJmdRvZPgIXb+FBY0Xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749722668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/1XDCp8OYvA+z/UwMP73ZXJFEOA8NUW8dP0h9kaHSg=;
	b=APnNyG+/RJKg54lRj7u9CqnuK6TC3LwbAOrN3GFBMcXpF04O33ZwNX9KunKNrQxXOJFi+y
	K5MioudQorDcqtBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749722668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/1XDCp8OYvA+z/UwMP73ZXJFEOA8NUW8dP0h9kaHSg=;
	b=e2TvbBmT7qvjnSUmPy0aoqTJ4Xkn288Soe26WsexCH6VJT4Cr5ByDKa6XENAHlB5Wy0mYv
	MiBlgH75zqWei+0qQ0ojiMstCKkYfjigBr/tMGffbkwNGMnJJ8Hqyz+Sa/mflVtXwnqQnT
	mUDE5hNdUrxkAJmdRvZPgIXb+FBY0Xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749722668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/1XDCp8OYvA+z/UwMP73ZXJFEOA8NUW8dP0h9kaHSg=;
	b=APnNyG+/RJKg54lRj7u9CqnuK6TC3LwbAOrN3GFBMcXpF04O33ZwNX9KunKNrQxXOJFi+y
	K5MioudQorDcqtBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0C54132D8;
	Thu, 12 Jun 2025 10:04:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CdvkKyumSmi7SwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 12 Jun 2025 10:04:27 +0000
Date: Thu, 12 Jun 2025 11:04:18 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, shuah@kernel.org, vbabka@suse.cz, jannh@google.com, 
	pulehui@huawei.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	aishwarya.tcv@arm.com, broonie@kernel.org, ryan.roberts@arm.com
Subject: Re: [PATCH] selftests/mm: Add CONFIG_FTRACE to config
Message-ID: <o6w6ejmzjp6ej6zsiax63jiugfwy5wfzamb7dwjwykpzzc7rby@ihydklfrp4ys>
References: <20250611121011.23888-1-dev.jain@arm.com>
 <b46324o3b6rwmda7fu5mc3edv5hy2vow32jeksnjjzotgcbmft@ccxqapirzo7t>
 <7ffffef8-d2ff-42ee-8a1a-da208109ac2b@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ffffef8-d2ff-42ee-8a1a-da208109ac2b@arm.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu, Jun 12, 2025 at 11:58:21AM +0530, Dev Jain wrote:
> 
> On 11/06/25 6:00 pm, Pedro Falcato wrote:
> > On Wed, Jun 11, 2025 at 05:40:11PM +0530, Dev Jain wrote:
> > > If CONFIG_UPROBES is not set, a merge subtest fails:
> > > 
> > > Failure log:
> > > 
> > >    7151 12:46:54.627936  # # #  RUN           merge.handle_uprobe_upon_merged_vma ...
> > >    7152 12:46:54.639014  # # f /sys/bus/event_source/devices/uprobe/type
> > >    7153 12:46:54.639306  # # fopen: No such file or directory
> > >    7154 12:46:54.650451  # # # merge.c:473:handle_uprobe_upon_merged_vma:Expected read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type) (1) == 0 (0)
> > >    7155 12:46:54.650730  # # # handle_uprobe_upon_merged_vma: Test terminated by assertion
> > >    7156 12:46:54.661750  # # #          FAIL  merge.handle_uprobe_upon_merged_vma
> > >    7157 12:46:54.662030  # # not ok 8 merge.handle_uprobe_upon_merged_vma
> > > 
> > > CONFIG_UPROBES is enabled by CONFIG_UPROBE_EVENTS, which gets enabled by
> > > CONFIG_FTRACE. Therefore add this config to selftests/mm/config so that
> > > CI systems can include this config in the kernel build.
> > While I did consider this before sending my patch, not every architecture
> > supports uprobes :/ So this isn't a complete fix.
> > 
> > Also, does every architecture support ftrace? If not (and it does not seem so,
> > e.g there's an ARM variant that does not), I would guess this config fragment
> > blows up.
> 
> Sorry forgot to reply.
> 
> What do you mean by "config fragment blows up"? I think scripts will just pull
> these configs and build the kernel, and if the config is not supported, it will
> be thrown out of .config, and after applying your patch, the test will be skipped,
> so everyone is happy I guess?

Right, I spoke with Mark Brown off-list and apparently it should be safe to add
unsupported config options there (and I wasn't sure about that, maybe it could
fail, or maybe kbuild would fail, or<...>). So yeah, I'm fully supportive of
a patch adding CONFIG_UPROBES.

- 
Pedro

