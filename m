Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE03020BBE8
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jun 2020 23:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgFZVwk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Jun 2020 17:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgFZVwk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Jun 2020 17:52:40 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEA7C03E97B
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 14:52:40 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u5so5193728pfn.7
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 14:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q757IDXyRukGvX5SZOHlJdoHJ/1n6S14vTGyo4zvXBQ=;
        b=VIGOIHNEEU9j/QBCfkBjGdBcqAkDVMSPH2V6E9pYYKa7w0oI1NtGdugkcB6s2J7djs
         DSZ85QWa+gMBeGdBreMiRKvPJcdHicHe0ZZZe3JPNlhdZodj/p1tvl8Xip3Cc2IPrr+s
         lsiie+VLCThaSSaloZS5eYhO67RiKTuNXrYns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q757IDXyRukGvX5SZOHlJdoHJ/1n6S14vTGyo4zvXBQ=;
        b=BSq2cKvJJN9PBki9fopL3sQU+MZv2M4j3UMoGZg0bOld3bxxtN0E510IJIWMfymmtU
         9U5UqGzEGkUrt4K4f5yc4qfbBSZ8SijA/smcERMmlRi2fnVSGFH4BAuNoIHUNoKjYE/3
         49DYJTHSaAKfw7+JNTRp9bG4IHTqYSP2WMw1H+zf4Wn5w6tLB7ikVzs4M1rW2Wi7/Hzz
         SSLdtP/w6h6mC4KxRTJSeK2JdFWIWXf5pXTvcw0ysA37JlH05OJG/N6net5ZL06UPwXU
         6V6EsMmUIHESqH14GOxk0rJ68CtJRo7AnEfYT6BobBY3jsKe9AJrQHmYRdh44RQbmZgG
         QC8g==
X-Gm-Message-State: AOAM532O9PJ8DCKb8hQt9AOrOpoijpieBj9JA84dF3t+ELLCLKjwmOoX
        xkssg9n+DwJAcs892eruc0+vcg==
X-Google-Smtp-Source: ABdhPJxjew6vuVd8xK7z4Or0D8mu7tCMflIKF0q/SKBZ2je3Uo1yszhe7quUG/VVVAWRTDES/M5wNg==
X-Received: by 2002:a62:ea0b:: with SMTP id t11mr4824646pfh.276.1593208359728;
        Fri, 26 Jun 2020 14:52:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o16sm23597011pgg.57.2020.06.26.14.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:52:38 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:52:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, skhan@linuxfoundation.org, alan.maguire@oracle.com,
        yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org,
        rppt@linux.ibm.com, frowand.list@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, monstr@monstr.eu,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        chris@zankel.net, jcmvbkbc@gmail.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v5 00/12] kunit: create a centralized executor to
 dispatch all KUnit tests
Message-ID: <202006261442.5C245709@keescook>
References: <20200626210917.358969-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626210917.358969-1-brendanhiggins@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 26, 2020 at 02:09:05PM -0700, Brendan Higgins wrote:
> This patchset adds a centralized executor to dispatch tests rather than
> relying on late_initcall to schedule each test suite separately along
> with a couple of new features that depend on it.

So, the new section looks fine to me (modulo the INIT_DATA change). The
plumbing to start the tests, though, I think is redundant. Why not just
add a sysctl that starts all known tests?

That way you don't need the plumbing into init/main.c, and you can have
a mode where builtin tests can be started on a fully booted system too.

i.e. boot with "sysctl.kernel.kunit=start" or when fully booted with
"echo start > /proc/sys/kernel/kunit"

And instead of the kunit-specific halt/reboot stuff, how about moving
/proc/sysrq-trigger into /proc/sys instead? Then you (or anything) could
do:

sysctl.kernel.kunit=start sysctl.kernel.sysrq-trigger=b

-- 
Kees Cook
