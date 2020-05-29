Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D840A1E75B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 May 2020 07:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgE2F5x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 May 2020 01:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgE2F5x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 May 2020 01:57:53 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB52C08C5C6
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 22:57:53 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j21so870365pgb.7
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 22:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SF3sCg5EU3YnkaxWsqKF6EgCQwUSf3m7IaDAB8UTyRM=;
        b=bx5HI5nrUX+igPb9py6fThZgzGqrey0SgnNIr5N9VtsU1W62Y64dvJcfOzhGhr1bf5
         QZOrrQ0mmtdn1xRj+90t4vHLsxpd/DxbFPNyJ4SIOpECiNcZFN1h8iJ+RgNPDxwlY5OV
         /MFhhwfUTdby9jh5AXrDGCqvZzbIo6UPu4/tY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SF3sCg5EU3YnkaxWsqKF6EgCQwUSf3m7IaDAB8UTyRM=;
        b=uYJtpqEQ9XMcdmaCjY6pXTiw8WQuU+QNTQT7ShsnpvIbPglxTp5BGBo46rkaYT3dZr
         evzoje4qtxqokqpfrZNXiJgSYWZiZGbTYwL4YNjVyqrkkolVU0Jk7wN144XwH4hoMtIo
         UjfEba5ToJ10y5PrA+rTicAyVsrXqCROGgHn9U5bo+kRzo8NuzAey+E87gzZZ4dhTb80
         2UkqfWPRn98tnkElPR82ARAmNoynncCWF57LogSRhK0faMy6ZdL/tXnKtdCf5CxTdull
         FiyARDtstRDsLEuBZO0QE2bBuryvveEDZKPCpIX3Wr0l+XpvydZgQNX2o+G7cNxd51sf
         p/Lw==
X-Gm-Message-State: AOAM533Xw+9vJ4SJ/7F7NwoghF3VLaDUMCaOVTDK0euP+NxFo/uOsyik
        OQ6xiqM25y7Yrqlmmy0ladJ5jA==
X-Google-Smtp-Source: ABdhPJx9YGgcLgJ0ntOaQ/pT2UeTQNFQc+PjjokH7xnOdMSwCNdtLY4V8ITuJRa/df4vrMYc1Pri0Q==
X-Received: by 2002:a63:480f:: with SMTP id v15mr4187332pga.148.1590731872760;
        Thu, 28 May 2020 22:57:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lj12sm7108885pjb.21.2020.05.28.22.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 22:57:51 -0700 (PDT)
Date:   Thu, 28 May 2020 22:57:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH 4/4] selftests/sysctl: Make sysctl test driver as a module
Message-ID: <202005282257.B9747A0D2@keescook>
References: <159067751438.229397.6746886115540895104.stgit@devnote2>
 <159067755690.229397.12060049846042042480.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159067755690.229397.12060049846042042480.stgit@devnote2>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 28, 2020 at 11:52:37PM +0900, Masami Hiramatsu wrote:
> Fix config file to require CONFIG_TEST_SYSCTL=m instead of y
> because this driver introduces a test sysctl interfaces which
> are normally not used, and only used for the selftest.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
