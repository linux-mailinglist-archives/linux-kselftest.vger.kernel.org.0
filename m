Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001A01E75B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 May 2020 07:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgE2F5n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 May 2020 01:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgE2F5m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 May 2020 01:57:42 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF373C08C5C6
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 22:57:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x11so636778plv.9
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 22:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S1pJP0zIjVkIj/rRde/f3WN6OKHKfEgWbqfA/JHK4Lc=;
        b=RvN4IGZXDr8jjz0wBCffohZ2KJcST7bTayzHhjp8XCKlkoKA9dHkMB/rOOjz0YYI/H
         DPGEHGsDHOk5daxT4S6nDzBfcXvGA+GQemOYfuxbkfoZtua/LAl2IjE5tx2uLr0Cs2NP
         ev+FkGmwuHACWW533A9NtFU5nbo++e402JvX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S1pJP0zIjVkIj/rRde/f3WN6OKHKfEgWbqfA/JHK4Lc=;
        b=B8PYpLE6xI7T07g1WXdCDLBzzvotvINCyG9C1cFFJFLPNe6CFVE8LQTxoGWV1RVLP8
         kJzPUPSlmlOYiyrSob/PUid0sx1yQNMl1jvS4jvXAIQ+xMF2cCYWCDVA+CmnnyUfhpVV
         r1ICRGr1aES38+EU7l7PSrqUrRbevDRy2ll1f3CrrvSAb7rhO4yuJ4pAqeh2JGCbbkxf
         a5NDAm5rrzM9rSFi1uQVNA7RQdLAauYdfL6P18kmYuMzwicxQ+NNA5DO1njeFId3xOcu
         zy2E9ca4lZIDBpVxyjZDss4J2Et8L8KenCkiUUCLqG7mIF7/Ky/5LDjMXTj5N1QwLLBT
         msKw==
X-Gm-Message-State: AOAM530O9V7h7okdOS3yhIxz4JXAOuDmqHAAeLDgV3R34x3hb3ZIDLOY
        WuHt6+BJPPNtZYk9Gyj3kfdgww==
X-Google-Smtp-Source: ABdhPJwdJXa3Glc0NQSI7NM6PGvoNtECNhFF5hzvOMEielqzGB14RK10hNdRpzwae3b3tTwq7sqHvw==
X-Received: by 2002:a17:90a:c004:: with SMTP id p4mr8133936pjt.170.1590731862388;
        Thu, 28 May 2020 22:57:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w21sm6801908pfu.47.2020.05.28.22.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 22:57:41 -0700 (PDT)
Date:   Thu, 28 May 2020 22:57:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH 3/4] selftests/sysctl: Fix to load test_sysctl module
Message-ID: <202005282257.0EB7813@keescook>
References: <159067751438.229397.6746886115540895104.stgit@devnote2>
 <159067754657.229397.15961438722058766667.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159067754657.229397.15961438722058766667.stgit@devnote2>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 28, 2020 at 11:52:26PM +0900, Masami Hiramatsu wrote:
> Fix to load test_sysctl.ko module correctly.
> 
> sysctl.sh checks whether the test module is embedded (or loaded
> already) or not at first, and if not, it returns skip error
> instead of trying modprobe. Thus, there is no chance to load the
> test_sysctl test module.
> 
> Instead, this removes that module embedded check and returns
> skip error only if it ensures that there is no embedded test
> module *and* no loadable test module.
> 
> This also avoid referring config file since that is not
> installed.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
