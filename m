Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273831E75AA
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 May 2020 07:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgE2F5C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 May 2020 01:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgE2F5C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 May 2020 01:57:02 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31A1C08C5C8
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 22:57:01 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x11so635938plv.9
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 22:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SmdvPVUjEJ1MorlU0qEr+89lJ/TqPv17jXhkR0M9z6I=;
        b=C1iYwcTi9aU+6iTf6LemO5XEeea0R+4156ui+IRXga9O5+NrAUPdc7maNHvpPiBiCl
         6YD3bmSXGXrdQJWmiR95iq1NdXs9RwvipRqzY+9vU0+jUMhm2YnlIzIBmpBe7qLCSzSD
         2KLNWE09RYUeiTCRuSoxNEoePktj0FjsFVVaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SmdvPVUjEJ1MorlU0qEr+89lJ/TqPv17jXhkR0M9z6I=;
        b=EhqDq1l18HGY4a0b2SzG+XRF353XWeSid/b/jhFKUtgA0YVojrhCqIOoiJX/Aqpvr+
         nzMoNi6K//LOtnAalXPs/OtxOPRJETJqR0mOA+lW92N9IbNAgALukNpkATj04VcCFSAD
         LW7Za40YFj34jKKfXFYuTI1JzYmYsvBqy5Y0M9wJ8YxrY0n9lATACNvog5qfE3C873MA
         a1xNgYG6Les9K3V5FH3MfqrNkU9f+rC34remM79Wn7UoTWtdnoxsOGl8HaFu+r5i4A+G
         7K9F3pC4k9fcwRVtTXK2nvr3F2DUDyPbCthS7c0gNSDtHVE4qcgnFLLMt5ng/GbsfxRO
         B1wg==
X-Gm-Message-State: AOAM533y5VUYgRLD8e9+iwegmWaoxDVyh7OOEi36E7EknJZ2UQKfr/qw
        6gKg4DIjsMn0ZG/D3GwUU1Zj0A==
X-Google-Smtp-Source: ABdhPJwvpgjvLzgpa1euBQq5Ky6r/xSxbGnAqui3q0dC/fMCbR+poNAclYZy1Vn5xrb8jJ51lLJi4A==
X-Received: by 2002:a17:902:7c81:: with SMTP id y1mr7526349pll.236.1590731821465;
        Thu, 28 May 2020 22:57:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m5sm5771238pga.3.2020.05.28.22.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 22:57:00 -0700 (PDT)
Date:   Thu, 28 May 2020 22:56:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH 1/4] lib: Make prime number generator independently
 selectable
Message-ID: <202005282255.63F6EFE55D@keescook>
References: <159067751438.229397.6746886115540895104.stgit@devnote2>
 <159067752610.229397.10253900294111245982.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159067752610.229397.10253900294111245982.stgit@devnote2>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 28, 2020 at 11:52:06PM +0900, Masami Hiramatsu wrote:
> Make prime number generator independently selectable from
> kconfig. This allows us to enable CONFIG_PRIME_NUMBERS=m
> and run the tools/testing/selftests/lib/prime_numbers.sh
> without other DRM selftest modules.

Nice catch! I see that tools/testing/selftests/lib/config already has
CONFIG_PRIME_NUMBERS=m (based on this commit log I was expecting to see
it added in the diff, but I see it's not needed).

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
