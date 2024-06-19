Return-Path: <linux-kselftest+bounces-12209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B563B90E29F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 07:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5DB1F23176
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 05:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23665466B;
	Wed, 19 Jun 2024 05:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CC+aG7Od";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="klF9jX88";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CC+aG7Od";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="klF9jX88"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F317628EC;
	Wed, 19 Jun 2024 05:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718774632; cv=none; b=da3QA7ZxJELw1rKPXWE4YyWEyPEsIsr+lo3PiyLtj3Qrj2ofopAC0U8j4HY2HNvnSc0Ac3atRLdrQWT5BOsEeA1NAKToE8Izy4bUqNT3AOA2FDTWgZeEwfmo1RDpF/tGA3/c2XqKF+WsXALAlPG5PCaDOfmy/SbSzE1NrON584s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718774632; c=relaxed/simple;
	bh=KaS68tC7mDah+eDYNqO+Yrrvd9o3NFQnpxOCYinQTyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2OSY2C2qnes2be8+pjjLZEzTaMvlqp1SciHwvSUf6sQ1yC+jclrrPQSU3wk470hk/SgVITv7scLpZkNcR+XUAJRti7LdzC7HO0/MqoYKx7KYjTfFhbVsd0iXpNf8aPaR8BPiLkj6qRP723vtesTxOtaqYED4EuowrbzE9KsaX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CC+aG7Od; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=klF9jX88; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CC+aG7Od; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=klF9jX88; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1EF571F7D8;
	Wed, 19 Jun 2024 05:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718774629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXTlgSHDZjc1Is0RTeFzg2tLZPe/dlFJM8+192GwUh8=;
	b=CC+aG7OdhiVVbIE0d9/C++DTJ1b/s6k8fLezYp2sJTx/3u6PCSNuENCV/27MYvbjrE05xu
	lgJo6YgFVq6gGiWI+Ai6UvQdW9//ACbwSCN6t+7Q8mn5JxeIBzLu8HN9Y44k3sk7rB5r0x
	i6uVZUPm/Ad4BKzdrExj3J7e4+I+BTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718774629;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXTlgSHDZjc1Is0RTeFzg2tLZPe/dlFJM8+192GwUh8=;
	b=klF9jX880MfqKE+halkart24l9VtRseQ+0BkvDmz8kSs0eNgiaMDpFN/HPxWHMvDa50DCy
	gHFRciyh6CkUo5Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CC+aG7Od;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=klF9jX88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718774629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXTlgSHDZjc1Is0RTeFzg2tLZPe/dlFJM8+192GwUh8=;
	b=CC+aG7OdhiVVbIE0d9/C++DTJ1b/s6k8fLezYp2sJTx/3u6PCSNuENCV/27MYvbjrE05xu
	lgJo6YgFVq6gGiWI+Ai6UvQdW9//ACbwSCN6t+7Q8mn5JxeIBzLu8HN9Y44k3sk7rB5r0x
	i6uVZUPm/Ad4BKzdrExj3J7e4+I+BTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718774629;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXTlgSHDZjc1Is0RTeFzg2tLZPe/dlFJM8+192GwUh8=;
	b=klF9jX880MfqKE+halkart24l9VtRseQ+0BkvDmz8kSs0eNgiaMDpFN/HPxWHMvDa50DCy
	gHFRciyh6CkUo5Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53A6913AAF;
	Wed, 19 Jun 2024 05:23:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 17PTEWRrcmZ1ZgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 19 Jun 2024 05:23:48 +0000
Date: Wed, 19 Jun 2024 07:23:46 +0200
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
Message-ID: <ZnJrYuFroToIm2v0@localhost.localdomain>
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
X-Rspamd-Queue-Id: 1EF571F7D8
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[15];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,huawei.com,oracle.com,linux.dev,linux-foundation.org,kernel.org,lwn.net,google.com,kvack.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed, Jun 19, 2024 at 07:03:46AM +0200, Oscar Salvador wrote:
> We should not be doing anything if soft_offline is disabled, so this check should
> be placed upfront, at the very beginning of the function.
> Then you can remove the 'put_ref_page' call.

Sorry, I managed to confuse myself, this has to stay as is.

-- 
Oscar Salvador
SUSE Labs

