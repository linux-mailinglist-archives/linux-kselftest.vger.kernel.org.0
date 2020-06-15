Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FCB1F9F98
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jun 2020 20:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbgFOSoJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jun 2020 14:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgFOSoI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jun 2020 14:44:08 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F87C061A0E
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jun 2020 11:44:08 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z63so7266977pfb.1
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jun 2020 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/L9vpEy4YW+wvyzUDXXcVOqQeUfP4Lan/mDToAVsZn8=;
        b=Qq3fN4y2CCfEPhibQkPDaZ75Ak5kNzodLN5Z3DKP2Bq96Tm1pExOLtH5IRqg3V67wN
         7KpKNhSUNdpTUyhFuzRc5jhgaJ8fabzwM7yYceZFF/SrROtrUgG07+eLCcFy32D6+U/3
         NmQEkdKxfiGBRWeC0hEo70hvO4o/6uQ/AETGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/L9vpEy4YW+wvyzUDXXcVOqQeUfP4Lan/mDToAVsZn8=;
        b=X1akeUivQP/hukJ7Il0DyEWRV2++3M2d00oi7FE5hpBj3mIP58fzlg3/EHGYBwVrlQ
         SJXgWWygWX4eO6MOPtoLaVk0Yjkw8C/AOfzhsUeal2lFE8ibDHZRkNPcI+4ovAstgoCq
         nW41UJnP0PPEK55YG0xloZpnnhN8ideRTk6QK7QmfupVJ5qRdMNGIpCJoDmnHMVmskzv
         0JZ9C3JDGbAMUaDZ9adcxidJyE06Ml489sYSFM5nG6eRdWUJeryRvUJUjsGLiA2WDkWM
         YXoasvf+efdSqRQZweXGVy4y0szq9fM/aJR/n4ibsK657tiWcRzqVlelcag9msVJ+yMx
         ggLg==
X-Gm-Message-State: AOAM531y6dA3lusIS8VvJ2O+jZ48Ce2elsseSRbsPmPoqbN+Ek0oJb4S
        Zz07qIQBfS04Pz9zqvBumzFe4A==
X-Google-Smtp-Source: ABdhPJz0GnEMgd+NOJZ4YyIuSQqz2DIY7a1WO/6cybe4V5xreJTkji7NSBD9m9gfN0gcNG2/5EgGBg==
X-Received: by 2002:a63:2a8a:: with SMTP id q132mr21651876pgq.279.1592246647773;
        Mon, 15 Jun 2020 11:44:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l4sm12552670pgo.92.2020.06.15.11.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 11:44:06 -0700 (PDT)
Date:   Mon, 15 Jun 2020 11:44:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     David Gow <davidgow@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
Message-ID: <202006151142.8B78AAE7D2@keescook>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006141050.5512F17@keescook>
 <CY4PR13MB11752A5C1586F3D597C52679FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR13MB11752A5C1586F3D597C52679FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 15, 2020 at 05:45:28PM +0000, Bird, Tim wrote:
> Personally, as a human I find the space prefix a bit easier to read.
> However, I think that in "normal" kernel log output it is unusual for
> a line to be prefixed with a hash (#), so this might be easier to
> both visually distinguish and for automated parsing.
> So I'm torn.  I don't have a strong opinion on space vs. hash prefix
> for indicating sub-test.  I think the KUnit convention of matching
> whatever was the prefix of the "TAP version 14" line is clever, but
> it would be nice to just pick a prefix and be done with it.

Are there plans in kernelci for doing any parsing of subtests? (As in,
what do we break if we move from "# " to "  "?)

I'm really thinking "  " makes sense now. :)

-- 
Kees Cook
