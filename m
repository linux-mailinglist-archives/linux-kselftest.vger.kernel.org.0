Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7BE63FD5E
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 01:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiLBAyi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 19:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbiLBAyh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 19:54:37 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8F1CCEDE
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 16:54:36 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id r7so3464992pfl.11
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Dec 2022 16:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qHYGi4hccRkpXmnqsWHqGlJk0rUF38lHPoxZSO5Qzyc=;
        b=UI50tBxdrwYo1AkTLCVtUhVaHYduXtuPzQvN76OM8fbMoTHKPPBlui8rr+gidv1/Yl
         jEdYfF30QrKfZuxlUubWJlAZEH9B+hvbfIoe6bNjih73getounWssghoDca5FB8eEnsf
         2m8LyLwBFFfYR/v303/vtmwg7k2C1Cktsf9Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHYGi4hccRkpXmnqsWHqGlJk0rUF38lHPoxZSO5Qzyc=;
        b=E4IhOhux1NWp3v9+jZ8ys6aAynaMiGFnjJ5S3w+IB6FRKVTdB+HCKq6FIUs5Qb3kfz
         c48M7oTClpLldX6F/ocaQjGCy7NuRv2/dzNf+nJKc+8y/dhc/FjF7Yrh+LyllhjdswXc
         vL1duM10s65H9rE20oHfHOZLQw80xAIRozM0GF811vqua84SfUbxXkHkHqGZ0HTpoLQt
         3wL6mo8wxka+5hQSoJynB9I38g8mSmz3U3IIT30Ub6Rf+Mmtc2s6FeANqnL9o4alLWSx
         9RX0SwBDZsRo1h25IK+52YZaislFaErLtGXFac9/CBF3yh3bKQczwfsphLzedldsYaoI
         zhiQ==
X-Gm-Message-State: ANoB5pm24LLyiV5ymk6PA+GaKz4zvGCCk85A6vzi5cON697gYHP8c6G4
        l56aFFdW3ygI4M6obllxs2oIrg==
X-Google-Smtp-Source: AA0mqf5kJfb1ONIrys8W61vNxCK5ToeM9RpLkUWl+1oYBQO7bay6U5spcQ68Ek81GSK/b5VnkHaraA==
X-Received: by 2002:a63:4d61:0:b0:477:b1a8:531e with SMTP id n33-20020a634d61000000b00477b1a8531emr41488628pgl.158.1669942476366;
        Thu, 01 Dec 2022 16:54:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id jx24-20020a17090b46d800b00213202d77d9sm3588021pjb.43.2022.12.01.16.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:54:35 -0800 (PST)
Date:   Thu, 1 Dec 2022 16:54:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, Jonathan Corbet <corbet@lwn.net>,
        Sadiya Kazi <sadiyakazi@google.com>
Subject: Re: [PATCH v4 2/3] kunit: Use the static key when retrieving the
 current test
Message-ID: <202212011654.9BB14785@keescook>
References: <20221125084306.1063074-1-davidgow@google.com>
 <20221125084306.1063074-2-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125084306.1063074-2-davidgow@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 25, 2022 at 04:43:05PM +0800, David Gow wrote:
> In order to detect if a KUnit test is running, and to access its
> context, the 'kunit_test' member of the current task_struct is used.
> Usually, this is accessed directly or via the kunit_fail_current_task()
> function.
> 
> In order to speed up the case where no test is running, add a wrapper,
> kunit_get_current_test(), which uses the static key to fail early.
> Equally, Speed up kunit_fail_current_test() by using the static key.
> 
> This should make it convenient for code to call this
> unconditionally in fakes or error paths, without worrying that this will
> slow the code down significantly.
> 
> If CONFIG_KUNIT=n (or m), this compiles away to nothing. If
> CONFIG_KUNIT=y, it will compile down to a NOP (on most architectures) if
> no KUnit test is currently running.
> 
> Note that kunit_get_current_test() does not work if KUnit is built as a
> module. This mirrors the existing restriction on kunit_fail_current_test().
> 
> Note that the definition of kunit_fail_current_test() still wraps an
> empty, inline function if KUnit is not built-in. This is to ensure that
> the printf format string __attribute__ will still work.
> 
> Also update the documentation to suggest users use the new
> kunit_get_current_test() function, update the example, and to describe
> the behaviour when KUnit is disabled better.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Sadiya Kazi <sadiyakazi@google.com>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
