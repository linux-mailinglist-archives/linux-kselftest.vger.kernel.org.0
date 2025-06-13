Return-Path: <linux-kselftest+bounces-34902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6F6AD8B52
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 13:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E386188B8B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 11:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376FF2E2F02;
	Fri, 13 Jun 2025 11:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1SISVv9d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CKlPFkLt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FKmWNUBy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3oLHDDy5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACC52DFA24
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 11:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749815263; cv=none; b=goNJVbK/i/TYnzZ30RHbrIMFcAkldoWF7f8+xVTacl3uKAhBBlQM4EACI/zw/WiVf4prrIq8luxvVg3GiVNyC3kwbOxYgDiIkeFKgmyAdnlpMhLg628QSLuHuiv2WFj4eyqgB6p6Ti+TUW51bFej56FdXga/LLZWDOdEovJiwsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749815263; c=relaxed/simple;
	bh=MbH/V0zkr2sli1gLu9DPU1YWefSRpayxt4a9hARNQiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KURyvPgy6mZSpFpdrZGvLm1Js+TxP9Dnx3nrNncsdeXYLqjJxPnyvpv4f3lofWeGbQpcWNANrnUzL1BcfQYNTyGCiFGLRryCgbiEN/SxHvjk7/WUCb9D/uTGYu7usPmpRN8j+at28sqY1PSTrz1vRnVLadXr0IhplBCdMRp/Eu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1SISVv9d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CKlPFkLt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FKmWNUBy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3oLHDDy5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E52C71F394;
	Fri, 13 Jun 2025 11:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749815254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8jUmzKR2PgiTUl+fyEUA1uAgwr5Zet9xJNASyseI9vw=;
	b=1SISVv9dteZgzGJiifRQDarurWF9yFvIwDOXgbPPeC449hAzI1B89FB7mGzobuhjYDwmA/
	mXMTJbjTpki15xcJgrAGcTDi2e6tRKbw7H3btzU0fNu/nOCA6aHCpxH/imLJzD9tqoziD+
	i0BVpJOyNAPjZvrD9bNOkRzZ/2ZbLT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749815254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8jUmzKR2PgiTUl+fyEUA1uAgwr5Zet9xJNASyseI9vw=;
	b=CKlPFkLtYgsttllf614dMjYJ2coMEyqfbpyo3ASLtt2aPdFdDvUA7mNExkuPacWmTdyQLj
	TwqcjnjPze+QGLAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749815253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8jUmzKR2PgiTUl+fyEUA1uAgwr5Zet9xJNASyseI9vw=;
	b=FKmWNUByq4uF6vnRjwYaGltD0yi2P8z+HRb8OYu8Pd14//OEoGNUnvzLImvh+nQUE/JeNy
	27tuXwf4gcrd0esW/Drv3hiYcXRDm7BSOBarRgY8q88WwaPkWcEPAXp/Nqz67Mm3aycIK0
	XGU+BJsFSlwmXlosO678ber0Nndw4Bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749815253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8jUmzKR2PgiTUl+fyEUA1uAgwr5Zet9xJNASyseI9vw=;
	b=3oLHDDy585ymk01U+s9dkoFFG6VHOBrv/RNfVPidXBjofC/pkqn0JFWL68DwRpNSD3EUNO
	SarwdZcKSK0ck2BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1340E137FE;
	Fri, 13 Jun 2025 11:47:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +cGaAdUPTGhXZAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 13 Jun 2025 11:47:33 +0000
Date: Fri, 13 Jun 2025 12:47:23 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, shuah@kernel.org, vbabka@suse.cz, jannh@google.com, 
	pulehui@huawei.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	aishwarya.tcv@arm.com, broonie@kernel.org, ryan.roberts@arm.com, donettom@linux.ibm.com
Subject: Re: [PATCH v2] selftests/mm: Add configs to fix testcase failure
Message-ID: <y5nwqrtlph2fzuyhiivsnnjjcnoe3gmzkrfcyyz2q7ezeduga7@7fzae7nfrxr4>
References: <20250613034912.53791-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613034912.53791-1-dev.jain@arm.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Fri, Jun 13, 2025 at 09:19:12AM +0530, Dev Jain wrote:
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
> CONFIG_FTRACE. Therefore add these configs to selftests/mm/config so that
> CI systems can include this config in the kernel build. To be completely
> safe, add CONFIG_PROFILING too, to enable the dependency chain
> PROFILING -> PERF_EVENTS -> UPROBE_EVENTS -> UPROBES.
> 
> Fixes: efe99fabeb11b ("selftests/mm: add test about uprobe pte be orphan during vma merge")
> Reported-by: Aishwarya <aishwarya.tcv@arm.com>
> Closes: https://lore.kernel.org/all/20250610103729.72440-1-aishwarya.tcv@arm.com/
> Tested-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Tested-by : Donet Tom <donettom@linux.ibm.com> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

