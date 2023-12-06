Return-Path: <linux-kselftest+bounces-1290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7C380729D
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 15:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656CA28194B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 14:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48303A8E3;
	Wed,  6 Dec 2023 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1a41P6Jl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MYtymdGE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAE4D4E;
	Wed,  6 Dec 2023 06:39:20 -0800 (PST)
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64DE321E31;
	Wed,  6 Dec 2023 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701873559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SdOMADw0BR1XqWadq+PaincC9VC4XbaVwQa4xbhyWuQ=;
	b=1a41P6JlV3rycQG+nmBWl05YMvb4fqKf0htEORvmGxjO4t+DMZxLAjMktZ5o6aIO+jOd0h
	MIvifQohAdt/4HfUVSbYtlyR7dLhxtGi18Uqap17Xh64QbIuSd34IgH0kffMFtQvTATRH0
	lRLyGmFBPCaIO8yKuednDW0p8dg3IfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701873559;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SdOMADw0BR1XqWadq+PaincC9VC4XbaVwQa4xbhyWuQ=;
	b=MYtymdGEPw/m/rPTvOE5RaiuasTRE8wksAgx6TeI/mTsVK2UWwQecDzT6gcmtIubEKaYtg
	pR3erBzCHAqeceCw==
Date: Wed, 6 Dec 2023 15:39:20 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Shuah Khan <skhan@linuxfoundation.org>
cc: mpdesouza@suse.com, Marcos Paulo de Souza <mpdesouza@suse.de>, 
    Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
    Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
    Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>, 
    Joe Lawrence <joe.lawrence@redhat.com>, linux-kselftest@vger.kernel.org, 
    linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-s390@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v3 3/3] selftests: livepatch: Test livepatching a heavily
 called syscall
In-Reply-To: <76c4b967-1cb6-4f77-9402-f835b15adb10@linuxfoundation.org>
Message-ID: <alpine.LSU.2.21.2312061530470.13051@pobox.suse.cz>
References: <20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com> <20231031-send-lp-kselftests-v3-3-2b1655c2605f@suse.com> <f9d82fa6-08d7-4ab6-badc-691987b37a82@linuxfoundation.org> <unpg4z7eig6qbudgulnr6sog65fq7s2dy4u2vp2dgkdrq5csdw@dltnxuw6kw5b>
 <8b95b96c-6aeb-4bf0-8ee9-2ba62330c672@linuxfoundation.org> <12a9ec1bc84dc6d4b461e5c780ba7d3c3aa91740.camel@suse.com> <76c4b967-1cb6-4f77-9402-f835b15adb10@linuxfoundation.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -0.10
X-Spamd-Result: default: False [-0.10 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_MATCH_FROMTLD(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+]

Hi,

On Tue, 5 Dec 2023, Shuah Khan wrote:

> On 12/5/23 05:52, mpdesouza@suse.com wrote:
> > On Fri, 2023-12-01 at 16:38 +0000, Shuah Khan wrote:
> 
> > 0003-selftests-livepatch-Test-livepatching-a-heavily-call.patch has
> > style problems, please review.
> > 
> > NOTE: If any of the errors are false positives, please report
> >        them to the maintainer, see CHECKPATCH in MAINTAINERS.
> > 
> > I couldn't find any mention about "missing module name". Is your script
> > showing more warnings than these ones? Can you please share your
> > output?
> > 
> > I'll fix MAINTAINERS file but I'll wait until I understand what's
> > missing in your checkpatch script to resend the patchset.
> > 
> 
> Looks like it is coming a script - still my question stands on
> whether or not you would need a module name for this module?

I admit I am also clueless here. The module name is given in Makefile. In 
this case in test_modules/Makefile. I do not know of anything else. There 
is no MODULE_NAME macro. Could you elaborate, please?

Miroslav

