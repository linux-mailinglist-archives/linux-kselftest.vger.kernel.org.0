Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 505FE185218
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Mar 2020 00:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCMXKZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 19:10:25 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36767 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgCMXKW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 19:10:22 -0400
Received: by mail-pj1-f68.google.com with SMTP id nu11so1912241pjb.1
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Mar 2020 16:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1g2ofZwUxVpJJGEVn2viaG1SunlaO0igWiCpmdonF48=;
        b=I8P+cEafE9tM+UDURGv7lgvAGhBU5sHEq6xuOrYAXSBGEVuemAFUvUdbKGBQdF8PL4
         kcsGxrMbdqENvxhZ2Xjquy47Ec0HAHltl4EuYrEG1T+1s2xhXdz2Sr5PlZ26hiCFNb82
         VjBBp1i7NTS0o1BSR2XQ7uptM9zNTB5bnxL+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1g2ofZwUxVpJJGEVn2viaG1SunlaO0igWiCpmdonF48=;
        b=l4SH4j6CGvYhuOOTr3SQ3gArVbKzeXz5R+9QPTqm2nn09dVjhxxkpMDg45WO3QwrKE
         PxLaOqPtNN0V/KhyZgafvxRAxQyFUGlYAdr6JquaB7W+/qe5/X9ENzxKRrOcw7bGIkHE
         KqhDS/y+2pcJDMthmckw13V7rcnyYBxbgH99DojpF9ZHakZmVgffI3FAS87KfhNunpEV
         tDM8u4KFKW8rxlgX33xrMNeJPTxka4+N/ha3FV69mD0DR4rAGH5AGczp//ADRN6VxINy
         koXyoWV846zB/6sZ2YRcNzt9ciuIbJlwieuoJWb9bZ6vYlu3pUElvI39CLcyVtr8ZQoX
         dhzw==
X-Gm-Message-State: ANhLgQ2De+cPpIgCBOeGNrqheY30jtENUyGW4z4oUKPNzyteC6PoqZMr
        GjcKlQ2TWz54grGNZS4Hqz7SlC9w/ag=
X-Google-Smtp-Source: ADFU+vuINWsD5yvnkQHhrqqZDo60oD7PhvqyIxn+3wmqL8J7tZkakukr6JG8hV0IsFYhA8R5+zD+SQ==
X-Received: by 2002:a17:90a:9303:: with SMTP id p3mr11686936pjo.35.1584141020337;
        Fri, 13 Mar 2020 16:10:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 25sm8736773pfn.190.2020.03.13.16.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 16:10:19 -0700 (PDT)
Date:   Fri, 13 Mar 2020 16:10:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     shuah <shuah@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/harness: Handle timeouts cleanly
Message-ID: <202003131609.228C4BBEDE@keescook>
References: <20200311211733.21211-1-keescook@chromium.org>
 <5da3bc61-6e43-f6d4-9623-0f4f1cb8e76a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5da3bc61-6e43-f6d4-9623-0f4f1cb8e76a@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 13, 2020 at 11:25:58AM -0600, shuah wrote:
> Hi Kees,
> 
> On 3/11/20 3:17 PM, Kees Cook wrote:
> > When a selftest would timeout before, the program would just fall over
> > and no accounting of failures would be reported (i.e. it would result in
> > an incomplete TAP report). Instead, add an explicit SIGALRM handler to
> > cleanly catch and report the timeout.
> > 
> > Before:
> > 
> >          [==========] Running 2 tests from 2 test cases.
> >          [ RUN      ] timeout.finish
> >          [       OK ] timeout.finish
> >          [ RUN      ] timeout.too_long
> >          Alarm clock
> > 
> > After:
> > 
> >          [==========] Running 2 tests from 2 test cases.
> >          [ RUN      ] timeout.finish
> >          [       OK ] timeout.finish
> >          [ RUN      ] timeout.too_long
> >          timeout.too_long: Test terminated by timeout
> >          [     FAIL ] timeout.too_long
> >          [==========] 1 / 2 tests passed.
> >          [  FAILED  ]
> > 
> 
> This is good info. to capturein the commit logs for the patches.

The cover letter is an exact copy of patch 2's commit log. :)

> Please add them and send v2. You can also fix the subject prefix
> at the same time :)

I'll resend a v2 with fixed prefix regardless.

-- 
Kees Cook
