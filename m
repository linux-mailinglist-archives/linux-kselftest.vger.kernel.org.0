Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03817D01E9
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Oct 2023 20:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345214AbjJSSjU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Oct 2023 14:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344662AbjJSSjT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Oct 2023 14:39:19 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A310FCA;
        Thu, 19 Oct 2023 11:39:17 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-577fff1cae6so23005a12.1;
        Thu, 19 Oct 2023 11:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697740757; x=1698345557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vvpiQJ6k/a5eGoEtij7HD0ulJSwtg8u7MSw+T7gzmSU=;
        b=mwPHfm+cMNOwd2lEL1PXmjFvb5jUhWSyhwcgCoor3V6HX8jCTosQ0ynfmUzFPH0GDo
         Am0l/qKB3MbntO81ZvFVFxrPvB0PQCwRhmhfNw4dYhSQReiNfhzQuWrelXsMEHV0Pojr
         mZu3/FnCenYCY33GduxKsX6KWfj7Pxc5FpmSW9fzzskadlNGxz5hqKfa7AZZOZCIf7vL
         Z20oGzVDJcqn0rWxCI16Bvu7bZ4N8cI44AWaznYBESM8LkXu1xvP7ziiNAXwoFDcP7wv
         LcSSn8tYxLZFoe2YHWd7a2BMaYaqitTq3V6yadGshxXFoA4MXBeTUpw/ZpKW7zszaCUf
         qTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697740757; x=1698345557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvpiQJ6k/a5eGoEtij7HD0ulJSwtg8u7MSw+T7gzmSU=;
        b=aZYU7YrEDZ1gLzW0ZMZQhJr5PdjsGf6R3MXsUgIWcTKeMYIPtxvnqJo49JoR7qMZaz
         GoJMMfsXvo/IW7RJE3qALczTchmUwXjdp9yGTBk+xD+0v3iUyjXwW5gItKboEVobfH+C
         Z4FEK6Wdt/4YJVwZWNQwJwz78UIEkv/TzhIpMBONkaQ6qyX7KVaDr9kypF2hgMfXyGdo
         ieu2uej3mcBAkqOl5kI9t9oEn47pm/cVcyWLyTIAhcUF4ni28Efgr7awqPjXXGrBvO3q
         Kv5Kl4bkJUC2WAUW5JKkFimq2H7sGH3sgUgb6XNTXwrw60p2yw92yfGitpgXNkNYeM4c
         JfRg==
X-Gm-Message-State: AOJu0YzU4bTYtgyXKGpoJr2c2cZLfoZ4mMNZNtMVnrd6BKTdG5q6KkPm
        fuY2MOnEej7fQ06+Ohw0M5V8TO51ngdUGABZ
X-Google-Smtp-Source: AGHT+IGbvNaUkXhmHNOJH60DIlmREOyBTMp0AT7sUzSL3oI7VuUV2u2yhSbTsgI9O7bI1wNMFch8Sw==
X-Received: by 2002:a17:90b:48c4:b0:274:8951:b5ed with SMTP id li4-20020a17090b48c400b002748951b5edmr3943674pjb.20.1697740756903;
        Thu, 19 Oct 2023 11:39:16 -0700 (PDT)
Received: from swarup-virtual-machine ([171.76.85.44])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090a7a8f00b00256b67208b1sm1830933pjf.56.2023.10.19.11.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 11:39:16 -0700 (PDT)
Date:   Fri, 20 Oct 2023 00:09:11 +0530
From:   swarup <swarupkotikalapudi@gmail.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests: capabilities: namespace create varies for
 root and normal user
Message-ID: <ZTF3z9gKJCn3bQ7w@swarup-virtual-machine>
References: <20230929125348.13302-1-swarupkotikalapudi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929125348.13302-1-swarupkotikalapudi@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

esOn Fri, Sep 29, 2023 at 06:23:48PM +0530, Swarup Laxman Kotiaklapudi wrote:
> Change namespace creation for root and non-root
> user differently in create_and_enter_ns() function
> 
> Test result with root user:
> $sudo make  TARGETS="capabilities" kselftest
>  ...
>  TAP version 13
>  1..1
>  timeout set to 45
>  selftests: capabilities: test_execve
>  TAP version 13
>  1..12
>  [RUN]       +++ Tests with uid == 0 +++
>  [NOTE]      Using global UIDs for tests
>  [RUN]       Root => ep
>  ...
>  ok 12 Passed
>  Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0
>  ==================================================
>  TAP version 13
>  1..9
>  [RUN]       +++ Tests with uid != 0 +++
>  [NOTE]      Using global UIDs for tests
>  [RUN]       Non-root => no caps
>  ...
>  ok 9 Passed
>  Totals: pass:9 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Test result without root or normal user:
> $make  TARGETS="capabilities" kselftest
>  ...
>  timeout set to 45
>  selftests: capabilities: test_execve
>  TAP version 13
>  1..12
>  [RUN]       +++ Tests with uid == 0 +++
>  [NOTE]      Using a user namespace for tests
>  [RUN]       Root => ep
>  validate_cap:: Capabilities after execve were correct
>  ok 1 Passed
>  Check cap_ambient manipulation rules
>  ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
>  ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
>  ok 4 PR_CAP_AMBIENT_RAISE worked
>  ok 5 Basic manipulation appears to work
>  [RUN]       Root +i => eip
>  validate_cap:: Capabilities after execve were correct
>  ok 6 Passed
>  [RUN]       UID 0 +ia => eipa
>  validate_cap:: Capabilities after execve were correct
>  ok 7 Passed
>  ok 8 # SKIP SUID/SGID tests (needs privilege)
>  Planned tests != run tests (12 != 8)
>  Totals: pass:7 fail:0 xfail:0 xpass:0 skip:1 error:0
>  ==================================================
>  TAP version 13
>  1..9
>  [RUN]       +++ Tests with uid != 0 +++
>  [NOTE]      Using a user namespace for tests
>  [RUN]       Non-root => no caps
>  validate_cap:: Capabilities after execve were correct
>  ok 1 Passed
>  Check cap_ambient manipulation rules
>  ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
>  ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
>  ok 4 PR_CAP_AMBIENT_RAISE worked
>  ok 5 Basic manipulation appears to work
>  [RUN]       Non-root +i => i
>  validate_cap:: Capabilities after execve were correct
>  ok 6 Passed
>  [RUN]       UID 1 +ia => eipa
>  validate_cap:: Capabilities after execve were correct
>  ok 7 Passed
>  ok 8 # SKIP SUID/SGID tests (needs privilege)
>  Planned tests != run tests (9 != 8)
>  Totals: pass:7 fail:0 xfail:0 xpass:0 skip:1 error:0
> 
> Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
> ---
>  tools/testing/selftests/capabilities/test_execve.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
> index df0ef02b4036..8236150d377e 100644
> --- a/tools/testing/selftests/capabilities/test_execve.c
> +++ b/tools/testing/selftests/capabilities/test_execve.c
> @@ -96,11 +96,7 @@ static bool create_and_enter_ns(uid_t inner_uid)
>  	outer_uid = getuid();
>  	outer_gid = getgid();
>  
> -	/*
> -	 * TODO: If we're already root, we could skip creating the userns.
> -	 */
> -
> -	if (unshare(CLONE_NEWNS) == 0) {
> +	if (outer_uid == 0 && unshare(CLONE_NEWNS) == 0) {
>  		ksft_print_msg("[NOTE]\tUsing global UIDs for tests\n");
>  		if (prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0) != 0)
>  			ksft_exit_fail_msg("PR_SET_KEEPCAPS - %s\n",
> -- 
> 2.34.1
> 
Hi Shuah,
Please review this patchset.
Thanks,
Swarup
