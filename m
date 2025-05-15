Return-Path: <linux-kselftest+bounces-33121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1354AB8FC0
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 21:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E289BA036CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4061E7C12;
	Thu, 15 May 2025 19:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vz6Ms9X9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QIacIgLX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vz6Ms9X9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QIacIgLX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343C01548C
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 19:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747336515; cv=none; b=MuuhYhopVAJDz9UqIlmzA+kMAag1gGm+tS7fJf5toVl8zI8z3De2iHUF/o8DvEDXaYsgPZvTYtQFvOW2DyR/5Ia+QkB5I2jVGv57MxtQ8Eyk2CwwyauXUmYpGztw9VRbo36K5lUVtdkwzztwDwd8QV7XgtjL2pD9fki43DrHGu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747336515; c=relaxed/simple;
	bh=VsFN6KjT2CD8IWVUmSwGKm4x/n6aml3mKGqLfNn2+PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8XosGzP4kId4SWJsEiqY8PuN1xCJOPLcMz2ianW7HJn4o53hIcTNThelXJz+lj7hNz5bjCjrOZNQMXVDHrmgzmgLwko6dqvnEOPaJ+pFpaVWQQAZdbpotatn/C93lNhi41SPx+dZUyOx8w6uPjf46/sE3Y5g1cQTp9aRImgSTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vz6Ms9X9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QIacIgLX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vz6Ms9X9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QIacIgLX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BD8521286;
	Thu, 15 May 2025 19:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747336512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=USAwlxUrycqtlNrtbES6qx9HlJFBmLCkrwuwugca7Uw=;
	b=vz6Ms9X9pIedd0kA6jgbZJ9BqenivFiKJ1LhkVZolGzDavlwnKkf0Yllv+Rb5OqbmJOZYk
	8TJ4QG9F/ddbkhq5SIbREZk/pttN8c0armiGyJez4bP0geQDf35n6Iz+6BE6+UJ6vZLK0R
	q5uAbJPnA4gudY7d8sd+67PH7PAKJHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747336512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=USAwlxUrycqtlNrtbES6qx9HlJFBmLCkrwuwugca7Uw=;
	b=QIacIgLXZUjg2T9J+HVOPJr+5b+UX7JlPpygzXMrmGhSFOcrbtZT3JS0XUsvY7rdpS7VHG
	UZgJeGT2QTnIY+DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vz6Ms9X9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QIacIgLX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747336512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=USAwlxUrycqtlNrtbES6qx9HlJFBmLCkrwuwugca7Uw=;
	b=vz6Ms9X9pIedd0kA6jgbZJ9BqenivFiKJ1LhkVZolGzDavlwnKkf0Yllv+Rb5OqbmJOZYk
	8TJ4QG9F/ddbkhq5SIbREZk/pttN8c0armiGyJez4bP0geQDf35n6Iz+6BE6+UJ6vZLK0R
	q5uAbJPnA4gudY7d8sd+67PH7PAKJHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747336512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=USAwlxUrycqtlNrtbES6qx9HlJFBmLCkrwuwugca7Uw=;
	b=QIacIgLXZUjg2T9J+HVOPJr+5b+UX7JlPpygzXMrmGhSFOcrbtZT3JS0XUsvY7rdpS7VHG
	UZgJeGT2QTnIY+DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1653139D0;
	Thu, 15 May 2025 19:15:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id puzKKz89JmhjBQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 15 May 2025 19:15:11 +0000
Date: Thu, 15 May 2025 20:15:10 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>, Adam Sindelar <adam@wowsignal.io>, 
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/mm: skip hugevm test if kernel config file
 is not present.
Message-ID: <adcz3xx524ragyywd3uitstcsojpcxe5sqio7ln4rjsgiv2zo2@dcycsbnorcoo>
References: <20250515182333.346587-1-ziy@nvidia.com>
 <20250515182333.346587-2-ziy@nvidia.com>
 <a81d06c8-11b5-4599-a749-5c288f2a9772@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a81d06c8-11b5-4599-a749-5c288f2a9772@lucifer.local>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 4BD8521286
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,nvidia.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -4.01

On Thu, May 15, 2025 at 07:43:40PM +0100, Lorenzo Stoakes wrote:
> On Thu, May 15, 2025 at 02:23:33PM -0400, Zi Yan wrote:
> > When running hugevm tests in a machine without kernel config present, e.g.,
> > a VM running a kernel without CONFIG_IKCONFIG_PROC nor /boot/config-*,
> > skip hugevm tests, which reads kernel config to get page table level
> > information.
> >
> > Signed-off-by: Zi Yan <ziy@nvidia.com>
> 
> Looks generally reasonable to me, but I'm not so familiar with this so,
> 
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Pedro Falcato <pfalcato@suse.de>

Same here. Although, despite this being worth patching, I do think we should
document somewhere what the expectations are for mm selftests (in terms of
kernel config, environment, libc, possibly even utilities present).

-- 
Pedro

