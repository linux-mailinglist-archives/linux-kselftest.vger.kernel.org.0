Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3676F721F58
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 09:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjFEHQ0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 03:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjFEHQX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 03:16:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01987E9;
        Mon,  5 Jun 2023 00:16:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ADBEC21B1F;
        Mon,  5 Jun 2023 07:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1685949364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VvobikAyYLd5tNbqhgR0HiS99+mLLI7sqkpLdjdt9Xg=;
        b=hbrZ7RHtTFh3lFSwfJewIoVWFCNd9Px6YYoyfhk7e/uh9RWcNA/giRTxp9+hQPPd75w85v
        1DPwh8BysAYVNAay9JCa0zpKgcM443KdZ6Ok/xg8jqV4a1Pn8+srPcKITlOGnMatARggA1
        9anQs9brs8F5xPY83o5oIRM3YboqzXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1685949364;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VvobikAyYLd5tNbqhgR0HiS99+mLLI7sqkpLdjdt9Xg=;
        b=Pw4S27pJNwrpqHa1bM5XY4yVGTEztYBGKUXEq/wFpQjP9Sjzr+7hb0QVLaTIe330wmNr0Y
        zUSYVvThQZsLx6CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CABD139C7;
        Mon,  5 Jun 2023 07:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GzdUHbSLfWRcZgAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 05 Jun 2023 07:16:04 +0000
Date:   Mon, 05 Jun 2023 09:16:04 +0200
Message-ID: <871qiqjs5n.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1 1/1] selftests: alsa: pcm-test: Fix compiler warnings about the format
In-Reply-To: <20230524191528.13203-1-mirsad.todorovac@alu.unizg.hr>
References: <20230524191528.13203-1-mirsad.todorovac@alu.unizg.hr>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 24 May 2023 21:15:29 +0200,
Mirsad Goran Todorovac wrote:
> 
> GCC 11.3.0 issues warnings in this module about wrong sizes of format
> specifiers:
> 
> pcm-test.c: In function �test_pcm_time�:
> pcm-test.c:384:68: warning: format �%ld� expects argument of type �long int�, but argument 5 \
> 				has type �unsigned int� [-Wformat=]
>   384 |                 snprintf(msg, sizeof(msg), "rate mismatch %ld != %ld", rate, rrate);
> pcm-test.c:455:53: warning: format �%d� expects argument of type �int�, but argument 4 has \
> 				type �long int� [-Wformat=]
>   455 |                                          "expected %d, wrote %li", rate, frames);
> pcm-test.c:462:53: warning: format �%d� expects argument of type �int�, but argument 4 has \
> 				type �long int� [-Wformat=]
>   462 |                                          "expected %d, wrote %li", rate, frames);
> pcm-test.c:467:53: warning: format �%d� expects argument of type �int�, but argument 4 has \
> 				type �long int� [-Wformat=]
>   467 |                                          "expected %d, wrote %li", rate, frames);
> 
> Simple fix according to compiler's suggestion removed the warnings.
> 
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

Applied now.  Thanks.


Takashi
