Return-Path: <linux-kselftest+bounces-26474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE543A32A4B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 16:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320FC3A6D4E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31EA212D71;
	Wed, 12 Feb 2025 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cTvlOpnk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BPNNI9J0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cTvlOpnk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BPNNI9J0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75A8211719;
	Wed, 12 Feb 2025 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374840; cv=none; b=sUdyf+ZZF5FbRlQDzNMfZqbuSfHfJzU/K+QSMpYUAAk/ckq+Sw61B3io7sOzu/tgTPGFOe8BVLptKDnDjqZQO8BzbJ1Z6WBGBMzkTGRZiv8BHoDFIJpgEZt8NGanPedB0sWt2xJrUv0omfe14UHibP/zuMVO+NlEiv4tpygEjKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374840; c=relaxed/simple;
	bh=8xxpimJPx2BWd7+7ZelhGur63diWjAPtO0Xxizv9mAo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FCXfDAnxRNlCwL7kPmWe7HcMcPVOAF7oiBaDWfH8kkzXabuq3Uai4DKf2bYW2rvXkam3vrJ3QkzagMEuqn0+D6IymSOHk5XNnxVUGdeEmU+t5yJcVVcYckb2rkE7qGSwyvOkOA0Il2gnGJVseCPmW5H2ihoBH5w52F1YCq9F1DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cTvlOpnk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BPNNI9J0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cTvlOpnk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BPNNI9J0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1F831FB68;
	Wed, 12 Feb 2025 15:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739374836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Stfxrx3s1IcnHzynaf4EIL6SBz02V4LY+WllomxPWz8=;
	b=cTvlOpnkxoaIoTU1A6Db5N1wWHUpkkDGVlwZueMNVhCLOEsZV6q51AQz3IkezdaNMzjp7P
	l3TMPLiZ3j2BqAfJqTdLYqaRZDTrdsYlC4Hqn9HYaOFrqKmxiNKNZlQ4ItHYWoO/YPG/Vm
	ckdJZVkKpXiQowYX/ufAxML+vy5JCLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739374836;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Stfxrx3s1IcnHzynaf4EIL6SBz02V4LY+WllomxPWz8=;
	b=BPNNI9J05NWgctZ+NMrdZi4VYqDUo1IpbCMAHG28t/QVPDJ/V10sGYRGS8WCT+Cqsu2vSd
	TRxe9gR6uD2TtRAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739374836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Stfxrx3s1IcnHzynaf4EIL6SBz02V4LY+WllomxPWz8=;
	b=cTvlOpnkxoaIoTU1A6Db5N1wWHUpkkDGVlwZueMNVhCLOEsZV6q51AQz3IkezdaNMzjp7P
	l3TMPLiZ3j2BqAfJqTdLYqaRZDTrdsYlC4Hqn9HYaOFrqKmxiNKNZlQ4ItHYWoO/YPG/Vm
	ckdJZVkKpXiQowYX/ufAxML+vy5JCLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739374836;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Stfxrx3s1IcnHzynaf4EIL6SBz02V4LY+WllomxPWz8=;
	b=BPNNI9J05NWgctZ+NMrdZi4VYqDUo1IpbCMAHG28t/QVPDJ/V10sGYRGS8WCT+Cqsu2vSd
	TRxe9gR6uD2TtRAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70FBE13AEF;
	Wed, 12 Feb 2025 15:40:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n82eD/TArGcuTAAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 12 Feb 2025 15:40:36 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Kees Cook <kees@kernel.org>
Cc: David Gow <davidgow@google.com>,  Gabriela Bittencourt
 <gbittencourt@lkcamp.dev>,  Pedro Orlando <porlando@lkcamp.dev>,  Danilo
 Pereira <dpereira@lkcamp.dev>,  Shuah Khan <skhan@linuxfoundation.org>,
  Rae Moar <rmoar@google.com>,  Luis Felipe Hernandez
 <luis.hernandez093@gmail.com>,  Nicolas Pitre <npitre@baylibre.com>,
  Diego Vieira <diego.daniel.professional@gmail.com>,  "Steven Rostedt
 (Google)" <rostedt@goodmis.org>,  Jakub Kicinski <kuba@kernel.org>,
  "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,  Vlastimil Babka
 <vbabka@suse.cz>,  Bruno Sobreira =?utf-8?Q?Fran=C3=A7a?=
 <brunofrancadevsec@gmail.com>,
  linux-kernel@vger.kernel.org,  linux-hardening@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  kunit-dev@googlegroups.com, Thorsten
 Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v2 6/6] unicode: kunit: change tests filename and path
In-Reply-To: <20250211003136.2860503-6-kees@kernel.org> (Kees Cook's message
	of "Mon, 10 Feb 2025 16:31:34 -0800")
References: <20250211002600.it.339-kees@kernel.org>
	<20250211003136.2860503-6-kees@kernel.org>
Date: Wed, 12 Feb 2025 10:40:34 -0500
Message-ID: <87pljnw4r1.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,lkcamp.dev,linuxfoundation.org,gmail.com,baylibre.com,goodmis.org,kernel.org,suse.cz,vger.kernel.org,googlegroups.com,leemhuis.info];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Kees Cook <kees@kernel.org> writes:

> From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
>
> Change utf8 kunit test filename and path to follow the style
> convention on Documentation/dev-tools/kunit/style.rst
>
> Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
> Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
> Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
> Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
> Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
> Reviewed-by: David Gow <davidgow@google.com>
> Acked-by: Gabriel Krisman Bertazi <krisman@suse.de>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Rae Moar <rmoar@google.com>
> Link: https://lore.kernel.org/r/20241202075545.3648096-7-davidgow@google.com
> Signed-off-by: Kees Cook <kees@kernel.org>

Hi Kees,

Last time this was submitted, I have reported this patch breaks the
build when the kunit is built as a module, and it wasn't fixed before
resubmission.  Thorsten Leemhuis just reported the same issue is now on
linux-next and I confirmed it is still there.

https://lore.kernel.org/lkml/2c26c5e4-9cf3-4020-b0be-637dc826b4e9@leemhuis.info/T/#m2e2ddb3b2600274e5eae50b93ea821914dc85f20

The build error is:

fs/unicode/tests/utf8_kunit.c:11:10: fatal error: utf8n.h: No such file or directory
   11 | #include "utf8n.h"
      |          ^~~~~~~~~

The problem is that the patch moves utf8_kunit.c into tests/ but doesn't
fix the include line above.  Can you fix it in your tree since it is
already merged?

Thanks,

> ---
>  fs/unicode/Makefile                                | 2 +-
>  fs/unicode/{ => tests}/.kunitconfig                | 0
>  fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} | 0
>  3 files changed, 1 insertion(+), 1 deletion(-)
>  rename fs/unicode/{ => tests}/.kunitconfig (100%)
>  rename fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} (100%)
>
> diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
> index 37bbcbc628a1..d95be7fb9f6b 100644
> --- a/fs/unicode/Makefile
> +++ b/fs/unicode/Makefile
> @@ -4,7 +4,7 @@ ifneq ($(CONFIG_UNICODE),)
>  obj-y			+= unicode.o
>  endif
>  obj-$(CONFIG_UNICODE)	+= utf8data.o
> -obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += utf8-selftest.o
> +obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += tests/utf8_kunit.o
>  
>  unicode-y := utf8-norm.o utf8-core.o
>  
> diff --git a/fs/unicode/.kunitconfig b/fs/unicode/tests/.kunitconfig
> similarity index 100%
> rename from fs/unicode/.kunitconfig
> rename to fs/unicode/tests/.kunitconfig
> diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/tests/utf8_kunit.c
> similarity index 100%
> rename from fs/unicode/utf8-selftest.c
> rename to fs/unicode/tests/utf8_kunit.c

-- 
Gabriel Krisman Bertazi

