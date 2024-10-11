Return-Path: <linux-kselftest+bounces-19530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB056999FE3
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 11:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD11A1C2107C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 09:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96FF20C495;
	Fri, 11 Oct 2024 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MbnvOXZU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5S3YYNuA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YhXi4WSx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WFU9SVm7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12A820C46C;
	Fri, 11 Oct 2024 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638101; cv=none; b=fu51cCwrn1HwJ0eXjIMxG2sqcvAN8aQTVQnukGV4s+eV3kGUi185RvTrh6gnb4zhDPKCRE1946k0LqgEvSQp0DyDWzNSbIyfnpIyzLO8sIP/Mvv+Q9RcxGVyoPkpAV7gXAsDw+GdrzhKvw4J2UjSRBisNQQe7BIgFm09FZ9+nfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638101; c=relaxed/simple;
	bh=nEMm5LqG4HAtAJOD8nzaXUqC7qSrkcmnjCEnbWGzWGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0gTiOsfMkjtk0f5kJI1B1HtrJq/fOy3+gw6zFkVbJLfQ9MWfJNqVXTWOy7h2ZV2lYWZ21UevQArklQWyMVlCiFnLDF8ocCDa2yG+mGLx6/fha/nrtUECItpwfU6johXp4bVv3Cn09jtNgdJG5FzDs7c4US79sWLMTkQ/dwUVs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MbnvOXZU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5S3YYNuA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YhXi4WSx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WFU9SVm7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF7E41FC07;
	Fri, 11 Oct 2024 09:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728638098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SvjsvdtAXrD538ofyAfSVlI9tkgdX7SxPFr8XZvvjw=;
	b=MbnvOXZUOwGv8spnrwbr2/+f/QvJJaqVqyYCFsIf3KEQH629O1own7vxYWjVfvSyXmSEar
	SUQWd6e6fH7EIGjXVxcZRpDWRnNVDwGEKn6FdFr1uvyhnrJYF2gsZXWpWliflO2dg8PB1f
	76emHhNSTPulNyZiQDZm2OXpsF+V8/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728638098;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SvjsvdtAXrD538ofyAfSVlI9tkgdX7SxPFr8XZvvjw=;
	b=5S3YYNuAIvPJE5Ug8RmUdnwwbP0riH5BbscvbTOeIzwgF+qbsMq+6xtVNxBHXSs0OZkMxX
	qUT4SPgyISAyhAAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YhXi4WSx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WFU9SVm7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728638097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SvjsvdtAXrD538ofyAfSVlI9tkgdX7SxPFr8XZvvjw=;
	b=YhXi4WSxLIufIISDJ1C6J5MMrzWj3ob4sQJE6EX1GBM6bfZByW09CoB9V7noF8dM5UJ1On
	dAlVL6bOLnXzDFTtUxKj76F2qgGNbwfKJev7t+r35oizQVkgAPo8cvPi5U86S8Pk0c84ng
	fygXmzu4ML8LY0h1asNEbFECpQV+wPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728638097;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SvjsvdtAXrD538ofyAfSVlI9tkgdX7SxPFr8XZvvjw=;
	b=WFU9SVm744llweVIQLEQZn/MnZsxL+n+JmSdTweHGaOl2qpzwUyk3haIVm+PLbLZs9a+Hh
	1u5s4JHiKnUCf7Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87E6A136E0;
	Fri, 11 Oct 2024 09:14:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uEpZIJHsCGdfKgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 11 Oct 2024 09:14:57 +0000
Message-ID: <08682e72-a7e2-409d-85a5-fa4c2fbfdcc1@suse.cz>
Date: Fri, 11 Oct 2024 11:17:42 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] lib: Move KUnit tests into tests/ subdirectory
To: David Gow <davidgow@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>,
 Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, Andy Shevchenko <andy@kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 "David S . Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-hardening@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Charlie Jenkins <charlie@rivosinc.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Daniel Latypov <dlatypov@google.com>, Guenter Roeck <linux@roeck-us.net>,
 David Howells <dhowells@redhat.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, Marco Elver <elver@google.com>,
 Mark Rutland <mark.rutland@arm.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Nathan Chancellor <nathan@kernel.org>, Fangrui Song <maskray@google.com>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>
References: <20241011072509.3068328-2-davidgow@google.com>
 <20241011072509.3068328-5-davidgow@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20241011072509.3068328-5-davidgow@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DF7E41FC07
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlegroups.com,canb.auug.org.au,gmail.com,rasmusvillemoes.dk,zx2c4.com,kernel.org,linux.ibm.com,intel.com,davemloft.net,rivosinc.com,csgroup.eu,arndb.de,google.com,roeck-us.net,redhat.com,digikod.net,arm.com,linux-m68k.org,goodmis.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RL63kxeufebbfchdakdyrqufr3)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 10/11/24 9:25 AM, David Gow wrote:
> From: Kees Cook <kees@kernel.org>
> 
> Following from the recent KUnit file naming discussion[1], move all
> KUnit tests in lib/ into lib/tests/.
> 
> Link: https://lore.kernel.org/lkml/20240720165441.it.320-kees@kernel.org/ [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> Acked-by: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> Acked-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz> #slab

> Reviewed-by: David Gow <davidgow@google.com>
> [Rebased onto mm-nonmm-unstable, moved usercopy_kunit]
> Signed-off-by: David Gow <davidgow@google.com>

