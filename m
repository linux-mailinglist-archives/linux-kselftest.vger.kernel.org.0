Return-Path: <linux-kselftest+bounces-10865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C991D8D400A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 23:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC091F23B43
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 21:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8801C8FB1;
	Wed, 29 May 2024 21:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iM4+YZ85";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iM4+YZ85"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3473915CD77;
	Wed, 29 May 2024 21:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717016954; cv=none; b=cjkilXET9Wbdp1gEYQubU2A4k8lFrcLPJPwX/MVxv7LkPVX6ApWypgWM0IVF7zYVfJE96fPZd8e0iWdSVmzrs+/joNF4G7bdjz2ldlpu1GkVP9x6QwBndLqKODR6+UcUW/VkOHkC6/iOdGif/d39XAOCzDjMgxGa5pXhUY6eDQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717016954; c=relaxed/simple;
	bh=+20DTMcdjAcWuNGJY9GpSPGyYn8L4ONP6y95rYxjPtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejpxciL1x5NV8RMUlXAkxmkYxMxCaEt3KCd+cvHxYNFUXkMljlftvm77d4PVWUAcQ1XDIy9s2K8apTP2E+/olgrrlZEPd/ayH7h8rjDCeAHGeJuUrMukFTAtjoeqBp/D+0OzWy1y4aQXXOdb7NvtGq8Pc5m6v0CiPzR+B/NHYm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iM4+YZ85; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iM4+YZ85; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B88433735;
	Wed, 29 May 2024 21:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717016950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R5/QR578I3Tf5bhnm76lZUT5pHXHPS64O9hi/hfRSLo=;
	b=iM4+YZ85Znr3uOy4224MIcfNdHWPQmT/mXg089d51sxR5ZEGZx+BQgullwq8egAAcI3T0E
	2lrXRgx4K12jNGYfEQxD5jZZ7BiUbtFcY36bbXB9iNcIJpQieTjnlAfznXiTT3XyjBWuFD
	UKfWONXbMrmnlBHYZafbvu4kgG9aisA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717016950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R5/QR578I3Tf5bhnm76lZUT5pHXHPS64O9hi/hfRSLo=;
	b=iM4+YZ85Znr3uOy4224MIcfNdHWPQmT/mXg089d51sxR5ZEGZx+BQgullwq8egAAcI3T0E
	2lrXRgx4K12jNGYfEQxD5jZZ7BiUbtFcY36bbXB9iNcIJpQieTjnlAfznXiTT3XyjBWuFD
	UKfWONXbMrmnlBHYZafbvu4kgG9aisA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D593813A6B;
	Wed, 29 May 2024 21:09:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id riLgKHWZV2aqVQAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Wed, 29 May 2024 21:09:09 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Ryan Sullivan <rysulliv@redhat.com>
Cc: mpdesouza@suse.com,
	live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	shuah@kernel.org
Subject: Re: [PATCH] tools/testing/selftests/livepatch: define max test-syscall processes
Date: Wed, 29 May 2024 18:09:04 -0300
Message-ID: <20240529210906.1177-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240529201941.13968-1-rysulliv@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-0.59 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	BAYES_HAM(-0.79)[84.68%];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -0.59
X-Spam-Flag: NO

From: mpdesouza@suse.com

On Wed, 29 May 2024 16:19:41 -0400 Ryan Sullivan <rysulliv@redhat.com> wrote:

> Define a maximum allowable number of pids that can be livepatched in
> test-syscall.sh as with extremely large machines the output from a
> large number of processes overflows the dev/kmsg "expect" buffer in
> the "check_result" function and causes a false error.

I believe that 128 threads hammering getpid is good enough :)

Tested-by: Marcos Paulo de Souza <mpdesouza@suse.com>
Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>

> 
> Reported-by: CKI Project <cki-project@redhat.com>
> Signed-off-by: Ryan Sullivan <rysulliv@redhat.com>
> ---
>  tools/testing/selftests/livepatch/test-syscall.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/livepatch/test-syscall.sh b/tools/testing/selftests/livepatch/test-syscall.sh
> index b76a881d4013..289eb7d4c4b3 100755
> --- a/tools/testing/selftests/livepatch/test-syscall.sh
> +++ b/tools/testing/selftests/livepatch/test-syscall.sh
> @@ -15,7 +15,10 @@ setup_config
>  
>  start_test "patch getpid syscall while being heavily hammered"
>  
> -for i in $(seq 1 $(getconf _NPROCESSORS_ONLN)); do
> +NPROC=$(getconf _NPROCESSORS_ONLN)
> +MAXPROC=128
> +
> +for i in $(seq 1 $(($NPROC < $MAXPROC ? $NPROC : $MAXPROC))); do
>  	./test_klp-call_getpid &
>  	pids[$i]="$!"
>  done
> -- 
> 2.44.0

