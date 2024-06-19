Return-Path: <linux-kselftest+bounces-12206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388F890E288
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 07:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C783B2109F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 05:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894514B5A6;
	Wed, 19 Jun 2024 05:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dbwi9B83";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2PzFtr15";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dbwi9B83";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2PzFtr15"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C18C2594;
	Wed, 19 Jun 2024 05:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718773432; cv=none; b=aQdPVkEDBhOLOGwlgBz3+oTLIBOMzUAurE3dtfVsCdBZOoOA6FWfQ03FRvcXJeuRL2HXacooVRJumHCPthSFpp++UfQ+bUD0rxYb5yStaG6fFrZfUJBpiHJjLN6heqMffkkT7N3G2PUkQJpmmFri4/VXR8EXmRkXAbalhnoTOvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718773432; c=relaxed/simple;
	bh=3Bzur2hClK4e7WFVRaL3cl+GMxCS9B93/1MBxx+s4po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfkuQXURBAOTNlGqKNBZG9oGsL7wqoKtwpsXE+Ms3Uara9O+AWRaQwLaeLVfx5wmuDZXZMJ5ctny8IijtHRLsb7h1VsTDFBCzwK5FwnG3jSM32gxQvC1i8QoSCl1izjcuHK80WJO5++7JTX4MEKcOS7fEUientD2CrwRggcRx/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dbwi9B83; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2PzFtr15; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dbwi9B83; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2PzFtr15; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DA8081F7CC;
	Wed, 19 Jun 2024 05:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718773428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XdNAJea0S6CPZeM4xRERRTfOhFTKjQqO+lH0ABKDivM=;
	b=dbwi9B83Ru9C8eTWGFvA0DybmcDpwG24WK/4NmvD9bP0ODDbFpvGusi3DecdoISJND7sdp
	xhgnwbLJ8M7X10mfYO4jgZEP5T/uj4aJpTHGxCNHYHtTFuUdY58YY8ZLOikDqJHXgyLfmW
	/W4xHUpgZ6TZ6k0IylMrkHuJOfXbEgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718773428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XdNAJea0S6CPZeM4xRERRTfOhFTKjQqO+lH0ABKDivM=;
	b=2PzFtr15ZIkAPObLlVVbQ7Ny3pni/8Nx45a2yhcqaQ4w25hWk67ysDnxl2kWnArHoUY8l2
	f2WROdLl+yTPjGDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718773428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XdNAJea0S6CPZeM4xRERRTfOhFTKjQqO+lH0ABKDivM=;
	b=dbwi9B83Ru9C8eTWGFvA0DybmcDpwG24WK/4NmvD9bP0ODDbFpvGusi3DecdoISJND7sdp
	xhgnwbLJ8M7X10mfYO4jgZEP5T/uj4aJpTHGxCNHYHtTFuUdY58YY8ZLOikDqJHXgyLfmW
	/W4xHUpgZ6TZ6k0IylMrkHuJOfXbEgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718773428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XdNAJea0S6CPZeM4xRERRTfOhFTKjQqO+lH0ABKDivM=;
	b=2PzFtr15ZIkAPObLlVVbQ7Ny3pni/8Nx45a2yhcqaQ4w25hWk67ysDnxl2kWnArHoUY8l2
	f2WROdLl+yTPjGDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17F5113AAA;
	Wed, 19 Jun 2024 05:03:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PZa/ArRmcmZwYQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 19 Jun 2024 05:03:48 +0000
Date: Wed, 19 Jun 2024 07:03:46 +0200
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
Message-ID: <ZnJmsqvJz63imq3O@localhost.localdomain>
References: <20240617170545.3820912-1-jiaqiyan@google.com>
 <20240617170545.3820912-2-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617170545.3820912-2-jiaqiyan@google.com>
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,huawei.com,oracle.com,linux.dev,linux-foundation.org,kernel.org,lwn.net,google.com,kvack.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Mon, Jun 17, 2024 at 05:05:43PM +0000, Jiaqi Yan wrote:
> - * Returns 0 on success
> - *         -EOPNOTSUPP for hwpoison_filter() filtered the error event
> + * Returns 0 on success,
> + *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
> + *         -EOPNOTSUPP if disabled by /proc/sys/vm/enable_soft_offline,
>   *         < 0 otherwise negated errno.
>   *
>   * Soft offline a page, by migration or invalidation,
> @@ -2783,6 +2795,12 @@ int soft_offline_page(unsigned long pfn, int flags)
>  		return -EIO;
>  	}
>  
> +	if (!sysctl_enable_soft_offline) {
> +		pr_info("%#lx: OS-wide disabled\n", pfn);
> +		put_ref_page(pfn, flags);
> +		return -EOPNOTSUPP;
> +	}

We should not be doing anything if soft_offline is disabled, so this check should
be placed upfront, at the very beginning of the function.
Then you can remove the 'put_ref_page' call.
 

-- 
Oscar Salvador
SUSE Labs

