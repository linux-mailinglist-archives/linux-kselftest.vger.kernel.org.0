Return-Path: <linux-kselftest+bounces-5390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7393861FD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 23:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1465A1C23A27
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 22:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0559D14CAB3;
	Fri, 23 Feb 2024 22:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t7PTmVJa";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t7PTmVJa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A1F1419B3;
	Fri, 23 Feb 2024 22:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727638; cv=none; b=Q8qSg4dfV7QAabL7S+l5Y5MeefrfwUQVpR5hkIi2I8OvsG1ZM3cYHlSEqx47ze6qDsrrLRox9sb/C5TPcriqmvcDJhBIsagQmQpHz1ZyxS+5KWFqNRLtTEAVQhqyRCASLEAcZ3AVIjHlWxcmy5Oe4KeGnLUi0ug2b+72TlsGOV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727638; c=relaxed/simple;
	bh=kG5gIyiT7mXCo+bLuAIFsgfZm/MS6sIwZR95nfqKS00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sG3j/tAMEhbT2hApdDuV+TNTKeEKIoy09TUHXiW6OdL6vmyJPWpfdblntzM7mwLGBhNzytcGxF41fqaMHpnUE4e5terxHJbrZqSSc52Fw0Y8Hlg48K2YOp/eMuBj9nW2Y9pEwgO/F1z7ogiSQaXJ9VgpVHsDzus/1zk2KbwwoYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t7PTmVJa; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t7PTmVJa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FE4321E9F;
	Fri, 23 Feb 2024 22:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708727635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncC4AZwMTanyhRFGNnHWUDxF2reJCIB1LsfOs3NCmHM=;
	b=t7PTmVJamWd6pk/ZPQ4B8s1MQjb6Zdr79l6k0d7rDFdJmb9VGZ4bKQe/bS6TBxjTS9BPyC
	49DO3cjjCTwLCyYBZFoFTI5PYmBnqMWvbFVoLa1br6l/VNdI+vsSXSoZQVkcUNipRpKqPG
	G9BSq/JO3RwF6FNneD2hqrMORjERMZM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708727635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncC4AZwMTanyhRFGNnHWUDxF2reJCIB1LsfOs3NCmHM=;
	b=t7PTmVJamWd6pk/ZPQ4B8s1MQjb6Zdr79l6k0d7rDFdJmb9VGZ4bKQe/bS6TBxjTS9BPyC
	49DO3cjjCTwLCyYBZFoFTI5PYmBnqMWvbFVoLa1br6l/VNdI+vsSXSoZQVkcUNipRpKqPG
	G9BSq/JO3RwF6FNneD2hqrMORjERMZM=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CF14913419;
	Fri, 23 Feb 2024 22:33:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id LMYVJVId2WVNWwAAn2gu4w
	(envelope-from <mpdesouza@suse.com>); Fri, 23 Feb 2024 22:33:54 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests: lib.mk: Simplify TEST_GEN_MODS_DIR handling
Date: Fri, 23 Feb 2024 19:33:51 -0300
Message-ID: <20240223223352.13784-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240221-lp-selftests-fixes-v2-4-a19be1e029a7@suse.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [10.00 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: **********
X-Spam-Score: 10.00
X-Spam-Flag: NO

On Wed, 21 Feb 2024 14:17:06 -0300 Marcos Paulo de Souza <mpdesouza@suse.com> wrote:

Shuah, please skip this one. The simplification is not worthy if it causes a new
warning. This reply[1] explains what's going on.

Thanks in advance,
  Marcos

[1]: https://lore.kernel.org/linux-kselftest/20240223161244.17709-1-mpdesouza@suse.com/

> We don't need new targets only to run two make modules and make clean.
> We can test if TEST_GEN_MODS_DIR is specified, and then run the
> commands.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  tools/testing/selftests/lib.mk | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 286ce0ee102b..eddcd4a849dc 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -58,8 +58,9 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
>  TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
>  TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
>  
> -all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) \
> -	$(if $(TEST_GEN_MODS_DIR),gen_mods_dir)
> +all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
> +	$(if $(TEST_GEN_MODS_DIR), \
> +		$(Q)$(MAKE) -C $(TEST_GEN_MODS_DIR))
>  
>  define RUN_TESTS
>  	BASE_DIR="$(selfdir)";			\
> @@ -85,11 +86,6 @@ else
>  	@$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS))
>  endif
>  
> -gen_mods_dir:
> -	$(Q)$(MAKE) -C $(TEST_GEN_MODS_DIR)
> -
> -clean_mods_dir:
> -	$(Q)$(MAKE) -C $(TEST_GEN_MODS_DIR) clean
>  
>  define INSTALL_SINGLE_RULE
>  	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
> @@ -133,9 +129,11 @@ endif
>  
>  define CLEAN
>  	$(RM) -r $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) $(EXTRA_CLEAN)
> +	$(if $(TEST_GEN_MODS_DIR), \
> +		$(Q)$(MAKE) -C $(TEST_GEN_MODS_DIR) clean)
>  endef
>  
> -clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
> +clean:
>  	$(CLEAN)
>  
>  # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
> @@ -166,4 +164,4 @@ $(OUTPUT)/%:%.S
>  	$(LINK.S) $^ $(LDLIBS) -o $@
>  endif
>  
> -.PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir
> +.PHONY: run_tests all clean install emit_tests
> 
> -- 
> 2.42.1

