Return-Path: <linux-kselftest+bounces-39654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C792B30EBE
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 08:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A7364E080A
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 06:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3192E3B16;
	Fri, 22 Aug 2025 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="veqYoiyQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1qfcXQSw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QIRj/Hid";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NQGCrAMZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D8B2E3712
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755843673; cv=none; b=LjTkyjJ/3DwbwzPWtZ48YxhB4je/DQHBEzm9DmS8xnhGZafSY2SWpDCXhjhAl5jFUmLPWueDiboBiSZfI6AUcfjenxOFTkZp7XAuXxVCiJWcY1e8An7yMHk2dLapdnLq5JwRnaPrIJRW9ZgXBqWn/llcE6tnpYkJzoCin8bCG2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755843673; c=relaxed/simple;
	bh=oRDP0YB3OQl6oeFNLyUe94ReJ4n6giFLUwfWL61Z5Sw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=la5+Qld9clck4Hr8CY4MOv8QYaQohU6l+g805CKepa9+1e2dBOEBAOPFvzcHBuG6jL9PAkKpYS4PcYMM3eDRHFEcukaDYKHTU4baV/wHY3rjhYNUKNbWTPeSAyYDO3NsZ15l98CyIZtoHt/lXh/LWUUNdHGq4yDn9Ojv63bUfFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=veqYoiyQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1qfcXQSw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QIRj/Hid; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NQGCrAMZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AC1AB1F460;
	Fri, 22 Aug 2025 06:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755843669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41INJ0v8EWhcsBrvx4Frea3INbUx7hn68vuS+MWYl68=;
	b=veqYoiyQ78qZbymoYIqE8heurRWbhI7HnLQIL9+VUYLRXr3GZ6k2JKr/HQzFM2XyRGs1zW
	6jKfJnA76Ezvz7ZIK4IynNVwUNbvOungAVfZfMT2b+34MY/vsrRuvL0KUXdId2tXxfChr2
	Wr88oP/sLHQxV/vhaW2krL59HhV2/lY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755843669;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41INJ0v8EWhcsBrvx4Frea3INbUx7hn68vuS+MWYl68=;
	b=1qfcXQSwb+Nl4Q5EpX4UKop2NqEHgwzp1dXOB375D2MeoJdyM9XP3MgOB1yRUbxyFqVe7N
	6AmYyDcDdH6ombBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755843667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41INJ0v8EWhcsBrvx4Frea3INbUx7hn68vuS+MWYl68=;
	b=QIRj/HidRGFboht6lxuyENjtGIIRT9lbqrvTi/2iru/0WbFZZmzUAOTvXEShiDpI2kmC0w
	w+VDCh++Nv5NeqKv6NDymcgCrQx9UgLViJm7+KffGjHxOZ8Oij6TDgW1FIClWm/2igvyvQ
	nl9tYKJB4+VbIGgGGyMthD5TiwCYLew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755843667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41INJ0v8EWhcsBrvx4Frea3INbUx7hn68vuS+MWYl68=;
	b=NQGCrAMZiQdEvWJWZ1SYAEOvoL4dWJPlmDzUo5kG/v9U5MZc6kQ4dQEXlZtxNcAXM62aMW
	4rmbjujyJ2NdR6Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BCAD13931;
	Fri, 22 Aug 2025 06:21:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id twUhGVMMqGgkdAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 22 Aug 2025 06:21:07 +0000
Date: Fri, 22 Aug 2025 08:21:07 +0200
Message-ID: <87349j6fn0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	shuah@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests/alsa: remove 0/NULL global variable assignment
In-Reply-To: <20250821200132.1218850-1-zlatistiv@gmail.com>
References: <20250821200132.1218850-1-zlatistiv@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Thu, 21 Aug 2025 22:01:32 +0200,
Nikola Z. Ivanov wrote:
> 
> Remove 0/NULL global variable assignment in mixer-test.c and pcm-test.c
> 
> Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>

Applied now.  Thanks.


Takashi

