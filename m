Return-Path: <linux-kselftest+bounces-19846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 099E49A0B10
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 15:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD24E28174B
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 13:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEB1208D99;
	Wed, 16 Oct 2024 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KWZnJlc4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GlEzHQCF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KWZnJlc4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GlEzHQCF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A589912E75;
	Wed, 16 Oct 2024 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084304; cv=none; b=RbwXuEK6U3ihtW8wse9T6bxKbj7YGRJXvHE+fvZBOEtl6MlsM4ySKdxMm3/tZW4vG2a/eKAjJLkfta2JVDJW6cH0HovXpGM9Z4uZkGjfTHpCxWHJgXLeu9cxUaSebicbbTBWJ6DwuqaMjGHUx+YkBhKZADiFF8zWt3o2LkmFQ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084304; c=relaxed/simple;
	bh=JwgwUuW9UqgmJsnCCUolNRBTWYiD175LKq9EREDLbQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKM3J+sH6o/Dy7P+tp5+a00hDgtQFp4dQ3kuOcKahSyejGJXdkFjvUIV6ghIXi1pqmlyOHPHAqI7mmZRKH8sBS1mmQ1t0jYS/TQmHfxc+1lIyMaucSXv7BW3Emg9s1Cl6zrTLRLO+A8sTwgrFMXZ0KHZCbF8vbYCPishrFdFQrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KWZnJlc4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GlEzHQCF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KWZnJlc4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GlEzHQCF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C3AD71FC30;
	Wed, 16 Oct 2024 13:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729084300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n32mPKBUY3kuUCODYzOed7T+MxJXcOwK00CoK5L3D7A=;
	b=KWZnJlc4QiuubChmjsI5ww787rFppvfdrspXkd41c6i9EwUbCmRx1iB0TbGnOmeoj9TDnz
	/eQ5lnINl/O2AllHrKCGHVdNVpo7zRPcwCvohztqb8xnc33b7rNRS+QlJRk5aBSZRbJvIX
	MiEdYbXyHdREWvQfiUsLLTw9SFkgQS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729084300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n32mPKBUY3kuUCODYzOed7T+MxJXcOwK00CoK5L3D7A=;
	b=GlEzHQCFRaop9SluV4HwZsp1cb5d9jo9yAFpEIgVNiXBqrLSuAUVV6PS5oxj2Nn+z7wqje
	RvHjefghKKYG7vAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KWZnJlc4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GlEzHQCF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729084300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n32mPKBUY3kuUCODYzOed7T+MxJXcOwK00CoK5L3D7A=;
	b=KWZnJlc4QiuubChmjsI5ww787rFppvfdrspXkd41c6i9EwUbCmRx1iB0TbGnOmeoj9TDnz
	/eQ5lnINl/O2AllHrKCGHVdNVpo7zRPcwCvohztqb8xnc33b7rNRS+QlJRk5aBSZRbJvIX
	MiEdYbXyHdREWvQfiUsLLTw9SFkgQS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729084300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n32mPKBUY3kuUCODYzOed7T+MxJXcOwK00CoK5L3D7A=;
	b=GlEzHQCFRaop9SluV4HwZsp1cb5d9jo9yAFpEIgVNiXBqrLSuAUVV6PS5oxj2Nn+z7wqje
	RvHjefghKKYG7vAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF0271376C;
	Wed, 16 Oct 2024 13:11:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2PWCKYy7D2eCBAAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Wed, 16 Oct 2024 13:11:40 +0000
Date: Wed, 16 Oct 2024 15:10:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tim Bird <tim.bird@sony.com>
Cc: Don Zickus <dzickus@redhat.com>,
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>,
	"automated-testing@lists.yoctoproject.org" <automated-testing@lists.yoctoproject.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	kernelci <kernelci@lists.linux.dev>,
	Nikolai Kondrashov <nkondras@redhat.com>,
	Gustavo Padovan <gustavo.padovan@collabora.com>,
	kernelci-members <kernelci-members@groups.io>,
	"laura.nao@collabora.com" <laura.nao@collabora.com>
Subject: Re: [Automated-testing] [RFC] Test catalog template
Message-ID: <Zw-7Tydnaaj3XAQo@yuki.lan>
References: <CAK18DXYitS7hL1mA3QsPLmW9-R0q6Kin0C5Uv9fj=uS90WSnxA@mail.gmail.com>
 <MW5PR13MB5632C443F9D7E658168BC77DFD452@MW5PR13MB5632.namprd13.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR13MB5632C443F9D7E658168BC77DFD452@MW5PR13MB5632.namprd13.prod.outlook.com>
X-Rspamd-Queue-Id: C3AD71FC30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Hi!
> Just saying "LTP" is not granular enough.  LTP has hundreds of individual
> test programs, and it would be useful to specify the individual tests
> from LTP that should be run per sub-system.

A few thousand tests to be more precise, and also the content tend to
change between releases, be it test additions or removal and I do not
think this level of changes is somehing that makes sense to be tracked
in such database.

It may be better to have more generic description of LTP subsets, there
are a few obvious e.g. "SysV IPC" or "Timers", and have the LTP
testrunner map that to actual testcases. The hard task here is to figure
out which groups would be useful and keep the set reasonably small.

I can move this forward in LTP reasonably quickly we get small list of
useful groups from kernel develpers.

-- 
Cyril Hrubis
chrubis@suse.cz

