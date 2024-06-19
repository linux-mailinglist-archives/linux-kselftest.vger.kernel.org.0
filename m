Return-Path: <linux-kselftest+bounces-12208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 958C290E29A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 07:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8971F23FA8
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 05:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D0046433;
	Wed, 19 Jun 2024 05:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BOOXfrTn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hTvEkJj6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BOOXfrTn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hTvEkJj6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2230C28EC;
	Wed, 19 Jun 2024 05:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718774407; cv=none; b=cCuXH86WcSg4fC60LwmaC0CqnV3KcnLsLRAUF3PkOJSaJLjx0mxcpQOnnhpNgG0Qvdyyg/5vuhu912siPgLrnT72fhjZuzw3EjnIyr+X6jSqmaejwB0NKBaX+uTWSZnrPNs0iODNZtzQ8Bnh7rS4KFgn5AivU1kBYb6xSBIc2kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718774407; c=relaxed/simple;
	bh=q8IfBXXC9BjfYt0DGWSS6ipKbwFi2BRy1fln0r9oMhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHeepNiq591N4ytgNwGwyUdchwlxxAguUaRU9XxNXFQVRl096H+nTX0qe5BPsn4b7F9WXZ95GAUq+29AHzUimwQYk8exQ7jYSO3ZNZJ4dk0pTB9rFBeecJlDpFypUkPVxWFGiu/Yox8RDiGcgJP5MXJ3FU0rySrFbZr8zd0XRjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BOOXfrTn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hTvEkJj6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BOOXfrTn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hTvEkJj6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 347B21F7D6;
	Wed, 19 Jun 2024 05:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718774404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1imiKCuO1clBjPc+1z5RNFFpUob2vVaLpGk8atqc+9E=;
	b=BOOXfrTnyBU+rEetZOpOelCZ0l0Bot/3gj58MbOMsJuHzI1jnMI9qEq8RK+64FRgmtdLf9
	CmtJt+K+I1dN0+PwF31Xo0kvAaFDePHvGJoxyuwcpXz49Tx52gpenoL6DjZRTJwS5dXG6r
	0CxZ9xpRpZcgvFM6CP7xgDEsLV3YMdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718774404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1imiKCuO1clBjPc+1z5RNFFpUob2vVaLpGk8atqc+9E=;
	b=hTvEkJj6ENSwAzlvgYdBQtjMR7vfIUkpuBdCZ3M3ZIt6NWD09eXWX10o+o1diRzAfiST+f
	lafpRbe9xO8pGvBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BOOXfrTn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hTvEkJj6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718774404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1imiKCuO1clBjPc+1z5RNFFpUob2vVaLpGk8atqc+9E=;
	b=BOOXfrTnyBU+rEetZOpOelCZ0l0Bot/3gj58MbOMsJuHzI1jnMI9qEq8RK+64FRgmtdLf9
	CmtJt+K+I1dN0+PwF31Xo0kvAaFDePHvGJoxyuwcpXz49Tx52gpenoL6DjZRTJwS5dXG6r
	0CxZ9xpRpZcgvFM6CP7xgDEsLV3YMdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718774404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1imiKCuO1clBjPc+1z5RNFFpUob2vVaLpGk8atqc+9E=;
	b=hTvEkJj6ENSwAzlvgYdBQtjMR7vfIUkpuBdCZ3M3ZIt6NWD09eXWX10o+o1diRzAfiST+f
	lafpRbe9xO8pGvBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6173413AAF;
	Wed, 19 Jun 2024 05:20:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2uCIFINqcmaKZQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 19 Jun 2024 05:20:03 +0000
Date: Wed, 19 Jun 2024 07:19:53 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com,
	ioworker0@gmail.com, muchun.song@linux.dev,
	akpm@linux-foundation.org, shuah@kernel.org, corbet@lwn.net,
	rientjes@google.com, duenwen@google.com, fvdl@google.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 3/3] docs: mm: add enable_soft_offline sysctl
Message-ID: <ZnJqeQtkMqNaXaMl@localhost.localdomain>
References: <20240617170545.3820912-1-jiaqiyan@google.com>
 <20240617170545.3820912-4-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617170545.3820912-4-jiaqiyan@google.com>
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,huawei.com,oracle.com,linux.dev,linux-foundation.org,kernel.org,lwn.net,google.com,kvack.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 347B21F7D6
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

On Mon, Jun 17, 2024 at 05:05:45PM +0000, Jiaqi Yan wrote:
> Add the documentation for soft offline behaviors / costs, and what
> the new enable_soft_offline sysctl is for.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>  Documentation/admin-guide/sysctl/vm.rst | 33 +++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index e86c968a7a0e..fc62fc272fc5 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -36,6 +36,7 @@ Currently, these files are in /proc/sys/vm:
>  - dirtytime_expire_seconds
>  - dirty_writeback_centisecs
>  - drop_caches
> +- enable_soft_offline
>  - extfrag_threshold
>  - highmem_is_dirtyable
>  - hugetlb_shm_group
> @@ -267,6 +268,38 @@ used::
>  These are informational only.  They do not mean that anything is wrong
>  with your system.  To disable them, echo 4 (bit 2) into drop_caches.
>  
> +enable_soft_offline
> +===================
> +Correctable memory errors are very common on servers. Soft-offline is kernel's
> +solution for memory pages having (excessive) corrected memory errors.
> +
> +For different types of page, soft-offline has different behaviors / costs.
> +- For a raw error page, soft-offline migrates the in-use page's content to
> +  a new raw page.
> +- For a page that is part of a transparent hugepage,  soft-offline splits the
> +  transparent hugepage into raw pages, then migrates only the raw error page.
> +  As a result, user is transparently backed by 1 less hugepage, impacting
> +  memory access performance.
> +- For a page that is part of a HugeTLB hugepage, soft-offline first migrates
> +  the entire HugeTLB hugepage, during which a free hugepage will be consumed
> +  as migration target.  Then the original hugepage is dissolved into raw
> +  pages without compensation, reducing the capacity of the HugeTLB pool by 1.
> +
> +It is user's call to choose between reliability (staying away from fragile
> +physical memory) vs performance / capacity implications in transparent and
> +HugeTLB cases.
> +
> +For all architectures, enable_soft_offline controls whether to soft offline
> +memory pages.  When setting to 1, kernel attempts to soft offline the pages
> +whenever it thinks needed.  When setting to 0, kernel returns EOPNOTSUPP to
> +the request to soft offline the pages.  Its default value is 1.
> +
> +It is worth mentioning that after setting enable_soft_offline to 0:
> +- If RAS Correctable Errors Collector is running, its request to soft offline
> +  pages will fail.
> +- On ARM, the request to soft offline pages from GHES driver will fail.
> +- On PARISC, the request to soft offline pages from Page Deallocation Table
> +  will fail.

I do not know about others but the 'fail' word feels wrong here.
I would reword that as "... the request to soft offline pages from
xxxx will not be performed".

 
Other than that:

Acked-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE Labs

