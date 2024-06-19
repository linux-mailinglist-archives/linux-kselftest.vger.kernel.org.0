Return-Path: <linux-kselftest+bounces-12207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D73290E294
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 07:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90AA28488B
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 05:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4165C524C4;
	Wed, 19 Jun 2024 05:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vVGeMBFr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dapU7svZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vVGeMBFr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dapU7svZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFAF45977;
	Wed, 19 Jun 2024 05:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718774005; cv=none; b=dCak5+TQV2KfHmkfqEclj2j1Cnm1g2tJ2Fzi+uUz2hxWl7FDesQNUxb71SmKwikHjCmNNorcWc2rnOlkgSm+cDTP2EDudnOp554Gi6Oovb8W+xv5ibei/ssOW2wR6I6DACKcp9ZliEulZK6o5+90vULJxdRy6hXtv3w17OAAyNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718774005; c=relaxed/simple;
	bh=7Vm+bZ5o3HzcsHhKybOdoFGP0BZmSnalDYOhB45+lVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJ3SeLK7KEqlr4HHE1EwYKwjqipZvHO9rIKOjkQ/Ek6xhfWrfaQhJItQ7VH75m+lF2FqKzyE9n+QqeWZHCEk6p3GVEOGKUZN0m1fLxjITIWxOGTfUJSbqDdvwsxtE+fc0rz+eAyPnX31bCAjxur9l1sc6yFAOp/7RJ0B4N3yrZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vVGeMBFr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dapU7svZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vVGeMBFr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dapU7svZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C959321A17;
	Wed, 19 Jun 2024 05:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718774001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pAG5AI+tavN0s8ygl8OS0QBr+oMD6ODJzxCJLwUfzhc=;
	b=vVGeMBFrYKf540KL8Le+kmrqUf2d3YuKyLA+CmM8jxQ3tgyn93YdD0NLfQgDjdZmtXWBIg
	vEwlEA2WtrCtlnaDpo4NPbIPb6JO7lh2o/JGoBOuSwCQEgNPSYQoaBq41YtKOPhannSJ5l
	HEW0e1jTlOkbtWpkuX+jaM0FoWqDBdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718774001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pAG5AI+tavN0s8ygl8OS0QBr+oMD6ODJzxCJLwUfzhc=;
	b=dapU7svZmG0V/wdtL9i4a/DpwPHTnute5Bd4Fpe8GWEjrIi28Xg5L/mzZPlGQnkFoFG2jI
	nUTgSVti8ypNv7Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vVGeMBFr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dapU7svZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718774001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pAG5AI+tavN0s8ygl8OS0QBr+oMD6ODJzxCJLwUfzhc=;
	b=vVGeMBFrYKf540KL8Le+kmrqUf2d3YuKyLA+CmM8jxQ3tgyn93YdD0NLfQgDjdZmtXWBIg
	vEwlEA2WtrCtlnaDpo4NPbIPb6JO7lh2o/JGoBOuSwCQEgNPSYQoaBq41YtKOPhannSJ5l
	HEW0e1jTlOkbtWpkuX+jaM0FoWqDBdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718774001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pAG5AI+tavN0s8ygl8OS0QBr+oMD6ODJzxCJLwUfzhc=;
	b=dapU7svZmG0V/wdtL9i4a/DpwPHTnute5Bd4Fpe8GWEjrIi28Xg5L/mzZPlGQnkFoFG2jI
	nUTgSVti8ypNv7Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0612A13AAF;
	Wed, 19 Jun 2024 05:13:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1lD0OfBocmbIYwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 19 Jun 2024 05:13:20 +0000
Date: Wed, 19 Jun 2024 07:13:19 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com,
	ioworker0@gmail.com, muchun.song@linux.dev,
	akpm@linux-foundation.org, shuah@kernel.org, corbet@lwn.net,
	rientjes@google.com, duenwen@google.com, fvdl@google.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mm/memory-failure: userspace controls
 soft-offlining pages
Message-ID: <ZnJo73kZk5EDxq0D@localhost.localdomain>
References: <20240617170545.3820912-1-jiaqiyan@google.com>
 <20240617170545.3820912-2-jiaqiyan@google.com>
 <ZnJmsqvJz63imq3O@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnJmsqvJz63imq3O@localhost.localdomain>
X-Rspamd-Queue-Id: C959321A17
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,huawei.com,oracle.com,linux.dev,linux-foundation.org,kernel.org,lwn.net,google.com,kvack.org,vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed, Jun 19, 2024 at 07:03:46AM +0200, Oscar Salvador wrote:
> On Mon, Jun 17, 2024 at 05:05:43PM +0000, Jiaqi Yan wrote:
> > +	if (!sysctl_enable_soft_offline) {
> > +		pr_info("%#lx: OS-wide disabled\n", pfn);
> > +		put_ref_page(pfn, flags);
> > +		return -EOPNOTSUPP;
> > +	}
> 
> We should not be doing anything if soft_offline is disabled, so this check should
> be placed upfront, at the very beginning of the function.
> Then you can remove the 'put_ref_page' call.

Also, I would go for a pr_info_once here, as otherwise we can spam the log quite
easy.

-- 
Oscar Salvador
SUSE Labs

