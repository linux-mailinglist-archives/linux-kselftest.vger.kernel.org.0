Return-Path: <linux-kselftest+bounces-5019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7160285BB47
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 13:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04193B27A8D
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 12:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717DB67C49;
	Tue, 20 Feb 2024 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cZ6XEF1a";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cZ6XEF1a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506EF67E63;
	Tue, 20 Feb 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430432; cv=none; b=dtRSdgQFYl9sdbR7HkXOE6OgBG9bE1qW5UQBOYQ7rocWUjOxpB6diJ/1WAyADVzHYPkQtXUsWJTj7XRiQehodizXrDGmT0rOYfmeV8JwPwv5OszxR5cPCL61AjLymIz/vJyWnUUCVaHt1Dqfu+ubcuK8xyebF5qExQ1B1SFSU6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430432; c=relaxed/simple;
	bh=abZNTJqU/RwPnT5tL8Obzy2HHmE8IgkqkqmA1yvAeWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4wNX1RjdyO9lJk3naXIYf6W/mH5mwFCLYcvuuWeDIymJfEtFh2KSxcsEXhCyyuuOKIeJ5/vCe3p4epdxljJle/W4PKkRaS6SVLN2LeglHxqamRzjkuBH7aV5QH/aQDRju4jdIY06HTGQPrwryT8qkbTxCey5d8HwF1l5gOBquI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cZ6XEF1a; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cZ6XEF1a; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6BBC21FD36;
	Tue, 20 Feb 2024 12:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708430428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWg7vA4kQ2xBQZqdvKR+2gxwgUjfjH7eu84AEYENqzQ=;
	b=cZ6XEF1a9N4uGzeGUvAaziS0DfNuTNXdkD4XFkrX+pZszFIhzqo28MRGBGaqhkXDBNSi7E
	QCv2FZNY15CMJRvsUU5V1f/8h+OueqDUmgxpxaHWKxrCljGhpG+YpSczVQ30VqCjkhhEst
	tytQfr6Hr1bERCanR9xKnIqY2GlrD64=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708430428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWg7vA4kQ2xBQZqdvKR+2gxwgUjfjH7eu84AEYENqzQ=;
	b=cZ6XEF1a9N4uGzeGUvAaziS0DfNuTNXdkD4XFkrX+pZszFIhzqo28MRGBGaqhkXDBNSi7E
	QCv2FZNY15CMJRvsUU5V1f/8h+OueqDUmgxpxaHWKxrCljGhpG+YpSczVQ30VqCjkhhEst
	tytQfr6Hr1bERCanR9xKnIqY2GlrD64=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DA5771358A;
	Tue, 20 Feb 2024 12:00:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gaQZKFuU1GVoDQAAn2gu4w
	(envelope-from <mpdesouza@suse.com>); Tue, 20 Feb 2024 12:00:27 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: zhangwarden@gmail.com,
	jikos@kernel.org,
	joe.lawrence@redhat.com,
	jpoimboe@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	live-patching@vger.kernel.org,
	mbenes@suse.cz,
	mpdesouza@suse.com,
	pmladek@suse.com,
	shuah@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH]     Fix implicit cast warning in test_klp_state.c
Date: Tue, 20 Feb 2024 09:00:24 -0300
Message-ID: <20240220120024.28694-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <4dc04319-8f4c-4159-a6c8-6b106a15305e@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[30.69%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[gmail.com,kernel.org,redhat.com,lists.linuxfoundation.org,vger.kernel.org,suse.cz,suse.com,linuxfoundation.org];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Tue, 20 Feb 2024 17:23:49 +0530 (GMT+05:30) Shresth Prasad <shresthprasad7@gmail.com> wrote:

> Looking at the function definition now, I do see that the function returns a struct pointer but for me the compiler still complains about an implicit conversion from int to struct pointer.
> 
> Is there any particular reason why this might be happening? I couldn't quite figure it out myself as I am very new to working with the kernel.

What compiler version and architecture? Are you compiling using flags like W=1?
I would advise you to always add more information about how the problem
manifests, and what you are executing. This can help to nail down the issue
quicker.

Thanks,
  Marcos

> 
> Regards,
> Shresth

