Return-Path: <linux-kselftest+bounces-2751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB028287DF
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 15:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59F7DB24A38
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 14:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABC739AF3;
	Tue,  9 Jan 2024 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zmlav5tN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D6dliPd4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zmlav5tN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D6dliPd4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAB739ADD;
	Tue,  9 Jan 2024 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 053CE21EB7;
	Tue,  9 Jan 2024 14:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704809781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ase84CEJhxi2XOYq2zDYFAUKWRmb+ZfRJUDpaFwdHpY=;
	b=Zmlav5tNGpaoMYrMAXhBPwM5iK5pvTZ/xhEtVFlZiiH+ImONkFr1GIo+HtxFZamctvHVsO
	rkDxcqW9Ur1ro1/EMzPggocKzPRPzS4iFlC1hNRP619zZNYiOFLszELjqGLF3IXXBg1dlh
	i+NXIgD4IwPzHevxLzzVjWrotf+cjI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704809781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ase84CEJhxi2XOYq2zDYFAUKWRmb+ZfRJUDpaFwdHpY=;
	b=D6dliPd4z9BzjIAsTvdGOF4sIXHSlrNgavVUXz9IYHwZE58lyd4+DUj9NOL4MGT39Y77KC
	0YXE7LaVRhu2ECCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704809781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ase84CEJhxi2XOYq2zDYFAUKWRmb+ZfRJUDpaFwdHpY=;
	b=Zmlav5tNGpaoMYrMAXhBPwM5iK5pvTZ/xhEtVFlZiiH+ImONkFr1GIo+HtxFZamctvHVsO
	rkDxcqW9Ur1ro1/EMzPggocKzPRPzS4iFlC1hNRP619zZNYiOFLszELjqGLF3IXXBg1dlh
	i+NXIgD4IwPzHevxLzzVjWrotf+cjI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704809781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ase84CEJhxi2XOYq2zDYFAUKWRmb+ZfRJUDpaFwdHpY=;
	b=D6dliPd4z9BzjIAsTvdGOF4sIXHSlrNgavVUXz9IYHwZE58lyd4+DUj9NOL4MGT39Y77KC
	0YXE7LaVRhu2ECCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3765134E8;
	Tue,  9 Jan 2024 14:16:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dyJiKjRVnWV2CAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 09 Jan 2024 14:16:20 +0000
Date: Tue, 09 Jan 2024 15:16:20 +0100
Message-ID: <87le8yr3rf.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: =?ISO-8859-1?Q?=22N=EDcolas_F=2E_R=2E_A=2E_Prado=22?=
 <nfraprado@collabora.com>,	Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org,	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,	Jaroslav Kysela <perex@perex.cz>,	Takashi
 Iwai <tiwai@suse.com>,	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2 0/4] kselftest: alsa: Fix a couple of format specifiers and function parameters
In-Reply-To: <20240107173704.937824-1-mirsad.todorovac@alu.unizg.hr>
References: <20240107173704.937824-1-mirsad.todorovac@alu.unizg.hr>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Zmlav5tN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=D6dliPd4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.99 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[11.36%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: 1.99
X-Rspamd-Queue-Id: 053CE21EB7
X-Spam-Flag: NO

On Sun, 07 Jan 2024 18:37:00 +0100,
Mirsad Todorovac wrote:
> 
> Minor fixes of compiler warnings and one bug in the number of parameters which
> would not crash the test but it is better fixed for correctness sake.
> 
> As the general climate in the Linux kernel community is to fix all compiler
> warnings, this could be on the right track, even if only in the testing suite.
> 
> Changelog:
> 
> v1 -> v2:
> - Compared to v1, commit subject lines have been adjusted to reflect the style
>   of the subsystem, as suggested by Mark.
> - 1/4 was already acked and unchanged (adjusted the subject line as suggested)
>   (code unchanged)
> - 2/4 was acked with suggestion to adjust the subject line (done).
>   (code unchanged)
> - 3/4 The format specifier was changed from %d to %u as suggested.
> - The 4/4 submitted for review (in the v1 it was delayed by an omission).
>   (code unchanged)
> 
> Mirsad Todorovac (4):
>   kselftest/alsa - mixer-test: fix the number of parameters to
>     ksft_exit_fail_msg()
>   kselftest/alsa - mixer-test: Fix the print format specifier warning
>   kselftest/alsa - mixer-test: Fix the print format specifier warning
>   kselftest/alsa - conf: Stringify the printed errno in sysfs_get()

Applied all patches now.  Thanks.


Takashi

