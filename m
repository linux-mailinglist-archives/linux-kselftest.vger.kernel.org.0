Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D460A286699
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Oct 2020 20:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgJGSME (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Oct 2020 14:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgJGSME (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Oct 2020 14:12:04 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BE6C061755
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Oct 2020 11:12:04 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id p11so1404347pld.5
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Oct 2020 11:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U51R3R0x1HlDU/rwfEcnqrw14Df1DxhtYwUuphhicTo=;
        b=HD/l7WlDsgTbjiMNQseskrrD3WamWgf+2tA58r3lFd72ZBZ4ncrD3IWyow15G+CJhg
         Y7naLw1dtmz4H13LtnKtTtXr5tFXOJ/OAJUnM1drGRS7MrOr22aFhGLSgDaESWo8ZNr6
         cyLCWLelwiKdaT4+U4LRUez+2R3Li2Fz5/BUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U51R3R0x1HlDU/rwfEcnqrw14Df1DxhtYwUuphhicTo=;
        b=aQj7s9phdvLvnbSsEz/pO4CRIL1CWruMn3raVWFsFzwQEjJmzwueKIbG/Z9LpK6kTn
         giFbsGttnr0V3ORSky3BIvLGbjx6h5wE8yWvle8lBILu3M2WzgmjnWlqnjR3yS6vs3rC
         Zc9J7G8X8En781rRq6ro0A+r+Kh3UcSdF7HBPTGBIsAT51zszX0a0TaqfLqJyl3p+A5O
         78ZqF0gxjJUh7ZJvItuURJuFkorjqsSNKOH515vQWu31Sf8UoR3eCVLI/xwm9yCLrvTe
         Sz6iyeFtP0yaE2kAtafgIAUZM/XM5atq2P0OQf8JwBAV9TadQ4Hlkb4R0cclO1COsBWU
         LexA==
X-Gm-Message-State: AOAM531zcNKXO7gJlTIKbfMbyEIYF9coJ5B0yZ+TIhN+EY1+eBRpjAtT
        FZBF5YEQtRV2FdasofExiqlJ9A==
X-Google-Smtp-Source: ABdhPJybWHoqusi93W9Aq6yodO08L83RzLwuH6q440Ymxn5QdLI/Kyd7aRpJaYbzEXCVsMdsAl0y+w==
X-Received: by 2002:a17:902:c3c5:b029:d3:df24:1ffb with SMTP id j5-20020a170902c3c5b02900d3df241ffbmr3979932plj.35.1602094323642;
        Wed, 07 Oct 2020 11:12:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q2sm3810459pfu.193.2020.10.07.11.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 11:12:02 -0700 (PDT)
Date:   Wed, 7 Oct 2020 11:12:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 02/11] selftests:lib:test_counters: add new test for
 counters
Message-ID: <202010071111.F3968C04@keescook>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
 <dd751c3ecedef23f3bd12c043863a6233fceb0d9.1602011710.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd751c3ecedef23f3bd12c043863a6233fceb0d9.1602011710.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 06, 2020 at 02:44:33PM -0600, Shuah Khan wrote:
> Add a new selftest for testing counter_atomic* Counters API. This test
> load test_counters test modules and unloads.
> 
> The test module runs tests and prints results in dmesg.
> 
> There are a number of atomic_t usages in the kernel where atomic_t api
> is used strictly for counting and not for managing object lifetime. In
> some cases, atomic_t might not even be needed.
> 
> The purpose of these counters is to clearly differentiate atomic_t
> counters from atomic_t usages that guard object lifetimes, hence prone
> to overflow and underflow errors. It allows tools that scan for underflow
> and overflow on atomic_t usages to detect overflow and underflows to scan
> just the cases that are prone to errors.
> 
> Simple atomic counters api provides interfaces for simple atomic counters
> that just count, and don't guard resource lifetimes. Counter will wrap
> around to 0 when it overflows and should not be used to guard resource
> lifetimes, device usage and open counts that control state changes, and
> pm states.
> 
> Using counter_atomic* to guard lifetimes could lead to use-after free
> when it overflows and undefined behavior when used to manage state
> changes and device usage/open states.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
