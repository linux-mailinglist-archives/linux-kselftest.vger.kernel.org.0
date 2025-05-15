Return-Path: <linux-kselftest+bounces-33120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51633AB8FB5
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 21:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186DC1B685D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B52928B407;
	Thu, 15 May 2025 19:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AwkTDPMU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y2dCJdzj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AwkTDPMU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y2dCJdzj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62159259CB9
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 19:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747336317; cv=none; b=PlmQpBaHDTm+JpIhqc2oOipFAjxmWv96Y53Fj6qFq8ld0xXN+i4PT5GQUbj7EcpVW2s32mL4lSsftPTxKyfn6gbkOk6AbvNw0Xh/ITttHBpgKye2niP3TPB+tfMy7DVOMW7ULDgf//rIhT/RhZASjx0U3/Qi67abbV7BVjUl53E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747336317; c=relaxed/simple;
	bh=53ZvbN5s6ZxUVFeOGsXq8cNH4ViwBY1V4bIBueJe1P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hR5k5JsDonc8xOySD1e8YccDV4RKqf0eP/DZMNXoo8I9AHDButWX428pG0xT1dztESirAjW7OWOEWRUjM68fC5x0rhsAtxRD/6jY49jwmNRfsyrNwEoTaWs2pew+uzAMZVhltlRHJDnRLHQvszUmpSBtfoReDYlU1VeS6A23Umo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AwkTDPMU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y2dCJdzj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AwkTDPMU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y2dCJdzj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8EFD721910;
	Thu, 15 May 2025 19:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747336306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XUxKUN5h2uz7dO6RAzieEeqQmjPl0PzvEKqLC9+1mGw=;
	b=AwkTDPMUhsbJCWwrJbDN9bpb1/MHOqxIo4cUTx5nZHXWXoerk4BszEEEYdyAGl5xMHxD5n
	5puYzMGW2ycVQb535ThW4rSyHCoVUnQXpgbHoYT+CC76rrRyHE+s7dWib7qho3qFCx2Pe8
	ViPb+i/0DXL/osLh8TiuDJvCsVfzils=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747336306;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XUxKUN5h2uz7dO6RAzieEeqQmjPl0PzvEKqLC9+1mGw=;
	b=y2dCJdzjQCl7NYTk84xO0dUvCticNGOXvmv8e9pLynIvbNoNio0ySFGvSfZeAL+0gqWU5M
	m6ZVQ+hV+WhcLIDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747336306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XUxKUN5h2uz7dO6RAzieEeqQmjPl0PzvEKqLC9+1mGw=;
	b=AwkTDPMUhsbJCWwrJbDN9bpb1/MHOqxIo4cUTx5nZHXWXoerk4BszEEEYdyAGl5xMHxD5n
	5puYzMGW2ycVQb535ThW4rSyHCoVUnQXpgbHoYT+CC76rrRyHE+s7dWib7qho3qFCx2Pe8
	ViPb+i/0DXL/osLh8TiuDJvCsVfzils=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747336306;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XUxKUN5h2uz7dO6RAzieEeqQmjPl0PzvEKqLC9+1mGw=;
	b=y2dCJdzjQCl7NYTk84xO0dUvCticNGOXvmv8e9pLynIvbNoNio0ySFGvSfZeAL+0gqWU5M
	m6ZVQ+hV+WhcLIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 141CD139D0;
	Thu, 15 May 2025 19:11:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Mdu+AXI8JmiPBAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 15 May 2025 19:11:46 +0000
Date: Thu, 15 May 2025 20:11:44 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Zi Yan <ziy@nvidia.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Adam Sindelar <adam@wowsignal.io>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/mm: skip uffd tests in madv_guard if uffd
 is not present.
Message-ID: <v3pxrwc55kdvzm7rkkb77lel7ge7rsbs4mtwfvgds64ico3q2u@r4k2i42k6bur>
References: <20250515182333.346587-1-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515182333.346587-1-ziy@nvidia.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -3.80

On Thu, May 15, 2025 at 02:23:32PM -0400, Zi Yan wrote:
> When userfaultfd is not compiled into kernel, userfaultfd() returns -1,
> causing uffd tests in madv_guard fail. Skip the tests instead.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Thanks!

-- 
Pedro

