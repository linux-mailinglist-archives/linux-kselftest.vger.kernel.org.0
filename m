Return-Path: <linux-kselftest+bounces-34702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF084AD5593
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927551BC29C1
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C271C8479;
	Wed, 11 Jun 2025 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O5Z5mKW2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+SozX5OM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O5Z5mKW2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+SozX5OM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3EB2E6123
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645034; cv=none; b=NO08wzmZ+dukPehcPvhtREzgoz5sXt3sfTQY65m16lW5eHz67rEPjXLEP4gqZ/GXpeJFY7MEAzYH8N26hTT3YPel6YjT+K9oF9qIJGjH6YzdGsZ6Bk/WzZIH2DVC6P05SxdV0PEwzIUzxO99tgCJi0dKR6akBDALaXxRDAnmtVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645034; c=relaxed/simple;
	bh=2MKJ2OnQVaW96pic+XvcJYKDEZhEbwIwlfczQ3tYyVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBKdVfoBnGGwPq8rO/E31UX6oiFkuEHu1lv134++azBELi1B21gIifTqAdB6RHBt9WoxJ0cJtWHG9omtvdTSo7iFT0u/Nmxy1LHYY7f+V+0T3WXircTq3GvKvCAqQSEyvg2NT2frf1+0DkNA6QjlLYxpWUTnE5kdODLalQI1Iec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O5Z5mKW2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+SozX5OM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O5Z5mKW2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+SozX5OM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A5C5A219B6;
	Wed, 11 Jun 2025 12:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749645024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zJjtNUj8t5/LTf3/dSyN9ynAVzPgYRBeasaKpc+ksbg=;
	b=O5Z5mKW28+ufblj+XBJj324gOzmrsr5lB7IyN3Tn5wPkyZ09Vwdx9RuRkVjFNgiNr7wlNE
	Lpa+fvmjPfAdh5a0Xrw9j7yj59UVoMGDW7AtLFyzzbNC6VZ10O8gsbpAjdDrqqEUGA13Er
	90bJ0GlEmxeAAHAwqz8Tf5INjtW0dx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749645024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zJjtNUj8t5/LTf3/dSyN9ynAVzPgYRBeasaKpc+ksbg=;
	b=+SozX5OM+n/T/aHj5kWoBwgO7IzyJhEyPOSzuBr3lZNpM0PmKRg12444lqyGqatKCWPdXc
	tcj6FK24iKJKW9Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749645024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zJjtNUj8t5/LTf3/dSyN9ynAVzPgYRBeasaKpc+ksbg=;
	b=O5Z5mKW28+ufblj+XBJj324gOzmrsr5lB7IyN3Tn5wPkyZ09Vwdx9RuRkVjFNgiNr7wlNE
	Lpa+fvmjPfAdh5a0Xrw9j7yj59UVoMGDW7AtLFyzzbNC6VZ10O8gsbpAjdDrqqEUGA13Er
	90bJ0GlEmxeAAHAwqz8Tf5INjtW0dx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749645024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zJjtNUj8t5/LTf3/dSyN9ynAVzPgYRBeasaKpc+ksbg=;
	b=+SozX5OM+n/T/aHj5kWoBwgO7IzyJhEyPOSzuBr3lZNpM0PmKRg12444lqyGqatKCWPdXc
	tcj6FK24iKJKW9Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2FD2137FE;
	Wed, 11 Jun 2025 12:30:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y81lMN92SWgYOwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 11 Jun 2025 12:30:23 +0000
Date: Wed, 11 Jun 2025 13:30:22 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, shuah@kernel.org, vbabka@suse.cz, jannh@google.com, 
	pulehui@huawei.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	aishwarya.tcv@arm.com, broonie@kernel.org, ryan.roberts@arm.com
Subject: Re: [PATCH] selftests/mm: Add CONFIG_FTRACE to config
Message-ID: <b46324o3b6rwmda7fu5mc3edv5hy2vow32jeksnjjzotgcbmft@ccxqapirzo7t>
References: <20250611121011.23888-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611121011.23888-1-dev.jain@arm.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed, Jun 11, 2025 at 05:40:11PM +0530, Dev Jain wrote:
> If CONFIG_UPROBES is not set, a merge subtest fails:
> 
> Failure log:
> 
>   7151 12:46:54.627936  # # #  RUN           merge.handle_uprobe_upon_merged_vma ...
>   7152 12:46:54.639014  # # f /sys/bus/event_source/devices/uprobe/type
>   7153 12:46:54.639306  # # fopen: No such file or directory
>   7154 12:46:54.650451  # # # merge.c:473:handle_uprobe_upon_merged_vma:Expected read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type) (1) == 0 (0)
>   7155 12:46:54.650730  # # # handle_uprobe_upon_merged_vma: Test terminated by assertion
>   7156 12:46:54.661750  # # #          FAIL  merge.handle_uprobe_upon_merged_vma
>   7157 12:46:54.662030  # # not ok 8 merge.handle_uprobe_upon_merged_vma
> 
> CONFIG_UPROBES is enabled by CONFIG_UPROBE_EVENTS, which gets enabled by
> CONFIG_FTRACE. Therefore add this config to selftests/mm/config so that
> CI systems can include this config in the kernel build.

While I did consider this before sending my patch, not every architecture
supports uprobes :/ So this isn't a complete fix.

Also, does every architecture support ftrace? If not (and it does not seem so,
e.g there's an ARM variant that does not), I would guess this config fragment
blows up.

-- 
Pedro

