Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182BD20C2DA
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jun 2020 17:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgF0Pwy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Jun 2020 11:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgF0Pwx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Jun 2020 11:52:53 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90608C03E979
        for <linux-kselftest@vger.kernel.org>; Sat, 27 Jun 2020 08:52:53 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ci15so38269pjb.5
        for <linux-kselftest@vger.kernel.org>; Sat, 27 Jun 2020 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=41PjtVw2FCnymQIWQmtqJCNWG/zIBsJ1p+vOmqPkCKE=;
        b=BWOD2zVOkpWNo2bPFp4ryz2GzTvlrG4eRcB7J1dRZGF2dC02SxWF6s4ngC2sUr5+Bb
         eDY2hiyrwzKyw5MPZkEq3pceBPMsMcWggsPLBtAFkb3BeqEQctFko234Pn4GYrqlFPY2
         CUyBk7DmCZTz9+V2L2y1dJEjvvVQ3YRUIPMkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=41PjtVw2FCnymQIWQmtqJCNWG/zIBsJ1p+vOmqPkCKE=;
        b=XLgcakoicnL3pPZasoUqXeYpB98hInnPtiB9IFPqvG6DboFJdSpRbpINzyfPHH0s9t
         xdg8BZc16yi5j0CFSMP4kv+4vEbnaw0zbbfQ2UiDzfmaUh6o2PXha2e48VGDteWp68ai
         PL9jY6QiwdEoKL66olB5sUKnfa1aSMovM5gkEbkRLZtbxJToIC39qdPMn0KadmWZKO+w
         K9/QJr3EqpC0rYd+gNugF4cJJsS3H80AiLQwV/SPBUvgUNvY8AstbqsnOdfNVn4PrMsR
         jKPfmQIRGXFlQmrCvj8Y8bz8OAaFXgCVZC+gO1lQIrz1GVGzROu5BkgdpRTW0LrbDxIy
         L5zQ==
X-Gm-Message-State: AOAM532JEAeSdTHofdr+LJmJZncemmvy1MtWLDxACM9NOip37FmIWAjQ
        eZ7PSuaeBed+rxdS9Uyd1eKx0w==
X-Google-Smtp-Source: ABdhPJwq0luAdpdlmLTPEl4oe8Od9vPb+TjMSBktwbCClEDhgr3jX3UYqoZ/0w+XuhMn1QXco7RLsA==
X-Received: by 2002:a17:90a:8545:: with SMTP id a5mr9009522pjw.35.1593273173171;
        Sat, 27 Jun 2020 08:52:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b13sm7419617pjl.7.2020.06.27.08.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 08:52:52 -0700 (PDT)
Date:   Sat, 27 Jun 2020 08:52:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Shuah Khan <shuah@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/lkdtm: Use "comm" instead of "diff" for dmesg
Message-ID: <202006270849.7190A26@keescook>
References: <202006261358.3E8AA623A9@keescook>
 <87k0zsbubg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0zsbubg.fsf@mpe.ellerman.id.au>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 27, 2020 at 09:51:31PM +1000, Michael Ellerman wrote:
> Kees Cook <keescook@chromium.org> writes:
> > Instead of full GNU diff (which smaller boot environments may not have),
> > use "comm" which is more available.
> 
> Although using "comm" requires CONFIG_PRINTK_TIME=y doesn't it?

No, it doesn't seem to. "comm" doesn't carry about the line prefixes.
AIUI, the only reason for a mention of "sort" is because of how "comm"
does its line pairing. i.e. as soon as it goes out of sync, it starts
accounting for the disjunction between files. But that's exactly what we
want it doing, and the prefix doesn't matter.

-- 
Kees Cook
