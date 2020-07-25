Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220AD22D886
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jul 2020 17:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgGYPs1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jul 2020 11:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgGYPsX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jul 2020 11:48:23 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205C0C08C5DC
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Jul 2020 08:48:23 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id l2so513676pff.0
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Jul 2020 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/1vt+B3DVDrdrfR+H/x+bcPYzBM3lx1EeYwS9nHXkv0=;
        b=LLuknkdOV2ZtuQPqqojqyvetQWZyKdeY9d3pGLpBMsgkaZgVvKIy/AOCpwPfbYes5B
         H/o0kCTLgkAjS3VbyKJPiw8PQtoBi3SFOF2kTEMS3QjeeRaS8iowUPs0nb2cE46QURNP
         7+NdSyvlQQugboxyBYham2MUGFHTQgh4+wzjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/1vt+B3DVDrdrfR+H/x+bcPYzBM3lx1EeYwS9nHXkv0=;
        b=ieB+euM32vxxIzDJ9jkEBu+xDvFgyU6PeKBzLUB97577z+90uNe8GEpzuvMBtSk9Hd
         SBjKdd0xr/BCvW2UsLlGTShi9Y8rpiSBJdl8tIxjLKScj83QDyt4KTruT3tU+ImigYLW
         umzFA27xfqkcJRO4oZw33lzs92YtM64mcFy2QLLGJzij6Waoaeq8QxDkP5hPGawVl4Jp
         j9x1A19Fo4Z1t801udNz55yD5Lxv7lrfkoT/0WVLMZauJEsvc+4bq41jacjzdom0ywGl
         /nUdcsR5JaF6o6GvNREoMKUtdgf6nvnhZIv2Qj8x338UHA9g4BbXITKZw9SdzComgK18
         E6FQ==
X-Gm-Message-State: AOAM533unSPcnKeTkEcMK7h2Auc7FRUApZ9TmHCLLtUFtr8SOGYxaldw
        7rACkwMPbti0OJKunx64sEc1pg==
X-Google-Smtp-Source: ABdhPJyxdaNUWfD+EhFI99UZ6LC/JVNqOP8wI3FHvEU/crZf7bnX4W1waM+OsXoJToUlv6T15nEktw==
X-Received: by 2002:a63:7d16:: with SMTP id y22mr12268714pgc.136.1595692102486;
        Sat, 25 Jul 2020 08:48:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j10sm9458042pgh.28.2020.07.25.08.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 08:48:21 -0700 (PDT)
Date:   Sat, 25 Jul 2020 08:48:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/19] Introduce partial kernel_read_file() support
Message-ID: <202007250843.534DE3DB48@keescook>
References: <20200724213640.389191-1-keescook@chromium.org>
 <20200725100555.GA1073708@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725100555.GA1073708@kroah.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jul 25, 2020 at 12:05:55PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 24, 2020 at 02:36:21PM -0700, Kees Cook wrote:
> > v3:
> > - add reviews/acks
> > - add "IMA: Add support for file reads without contents" patch
> > - trim CC list, in case that's why vger ignored v2
> > v2: [missing from lkml archives! (CC list too long?) repeating changes here]
> > - fix issues in firmware test suite
> > - add firmware partial read patches
> > - various bug fixes/cleanups
> > v1: https://lore.kernel.org/lkml/20200717174309.1164575-1-keescook@chromium.org/
> > 
> > Hi,
> > 
> > Here's my tree for adding partial read support in kernel_read_file(),
> > which fixes a number of issues along the way. It's got Scott's firmware
> > and IMA patches ported and everything tests cleanly for me (even with
> > CONFIG_IMA_APPRAISE=y).
> > 
> > I think the intention is for this to go via Greg's tree since Scott's
> > driver code will depend on it?
> 
> I've applied the first 3 now, as I think I need some acks/reviewed-by
> from the subsystem owners of the other patches before I can take them.

Sounds good; thanks!

(I would argue 4 and 5 are also bug fixes, 6 is already Acked by hch and
you, and 7 is a logical follow-up to 6, but I get your point.)

James, Luis, Mimi, and Jessica, the bulk of these patches are LSM,
firmware, IMA, and modules. How does this all look to you? And KP,
you'd mentioned privately that you were interested in being able to
use the new kernel_post_load_data LSM hook for better visibility into
non-file-backed blob loading.

Thanks!

-Kees

-- 
Kees Cook
