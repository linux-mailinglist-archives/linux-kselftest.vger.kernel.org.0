Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE051207D8D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jun 2020 22:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391468AbgFXUgL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jun 2020 16:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389041AbgFXUgK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jun 2020 16:36:10 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C1DC0613ED
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jun 2020 13:36:09 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k6so1570426pll.9
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jun 2020 13:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pgO1m61KHUuX3PlQgWsNmv+WwHbeWP7bfAQiG1GvUW4=;
        b=Y1j+29kxJwpJ0aEr6u3wsVIF8qsGWpyiGBvwKiy5HrXYgpRLcw4DAwK7vLtdyYiB3M
         qKxtyyX2XoWDyIEouUtcKSby8ACCDJYMT1BqlNQEz9sC9V9QMOm19BQgZKPw2sJgX8eo
         lR2lzjXyG0E/LHiNV332oFq+AvlgY8bV9i8g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pgO1m61KHUuX3PlQgWsNmv+WwHbeWP7bfAQiG1GvUW4=;
        b=J6PwVGTsQ6JTM1uJnfPzs90ULouZ2z1MYmy0JcgvUueM1VCtITz/q2GL9VafzrSS9b
         0lLpCh6ThKfi7pon5T10lzMexP3p/qEu4MhPRuVZUKEOljdSxW/m1EA3gODyOoS5fEZk
         e91R1bb37BsenkDwmmJYnxnnugaxGDXwP/RnuZ/YVi1Me2NdcXU5bFmoE1ehHaIOy6lG
         kHdCYTeejfCtAiunhrtB7oYHQ2+tZAfpdVFTiSEa2HXlANqKRFM+uuGwdpqqyEbPAa1h
         07KCbS0I3vsPSdgQV6aeT48zw4StB5jDjVGc1daVq3AmSbAIZzmYOdJd25Fmzg0k9eVh
         beUA==
X-Gm-Message-State: AOAM532j7XGloknt0zyeTeYMJbmuN4Xy3n9b0tlnqFzUPo4OLW5kHdzS
        kbmWCP72+28PbsY2ZcMH4enPhg==
X-Google-Smtp-Source: ABdhPJxQnUOr0rPh83NgE/X2mffcJAt0WerGIXvgcy2ZVvS/CVDjKXX+PoSM4O3Z+h3Uoytd2NTvrg==
X-Received: by 2002:a17:90a:55c7:: with SMTP id o7mr27620634pjm.205.1593030968933;
        Wed, 24 Jun 2020 13:36:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j19sm20510490pfn.109.2020.06.24.13.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 13:36:08 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:36:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: [PATCH drivers/misc 0/4] lkdtm: Various clean ups
Message-ID: <202006241335.2C0FB5DF90@keescook>
References: <20200529200347.2464284-1-keescook@chromium.org>
 <202006231610.4993DC5@keescook>
 <2356a78c-750b-538f-3d64-b9c78aff89cb@infradead.org>
 <903628180.54697.1592983405305.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <903628180.54697.1592983405305.JavaMail.zimbra@nod.at>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 24, 2020 at 09:23:25AM +0200, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> >>> Regardless, it seems arch/x86/um/asm/desc.h is not needed any more?
> > 
> >> True that, we can rip the file.
> > 
> > Has anyone fixed the uml build errors?
> 
> I didn't realize that this is a super urgent issue. ;-)
> 
> Kees, if you want you can carry a patch in your series, I'll ack it.
> Otherwise I can also do a patch and bring it via the uml tree upstream
> as soon more fixes queued up.

I think the lkdtm change will tweak this bug, so I'm happy to carry the
patch (I just haven't had time to create and test one). Is it really
just as simple as removing arch/x86/um/asm/desc.h?

-- 
Kees Cook
