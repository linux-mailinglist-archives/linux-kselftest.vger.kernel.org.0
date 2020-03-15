Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEA8185FDD
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Mar 2020 21:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgCOUzv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Mar 2020 16:55:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34629 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbgCOUzu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Mar 2020 16:55:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id 23so8730615pfj.1
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Mar 2020 13:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tbQkUnVAWk4DdNT2eI9KPJ4CRtZVJETNZZv1PgzqPdM=;
        b=TUqHtxacJZiW83OVGKgFfuF6Fc/KC14JPIfKhWr/ZLp8b86LYAZcIh4ZLGLvv8HUqh
         qDzP4e7q1vFJZKCl55haTEh/XB2LBczr02MYiehd3c1KVo8oo4NkaGTGAtwHlXKE2t/M
         7pcrHYhRordlMkfMW29YuYSIcpzYZyDZ1wDpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tbQkUnVAWk4DdNT2eI9KPJ4CRtZVJETNZZv1PgzqPdM=;
        b=pE05san05rquv42o1XyTs3DbuITCRna2uPW+kPuHcmFgFbLcJTbesU29Otmw/3tp2L
         s4TVbOBh0hLXLHmLi48VfuL8soJ+HrNvM21Az7e8UofM3hVJYqtMRcoxzDDNgu1kBH/6
         cg04W7d5HzdxepzkFjSccBIcL9IuzcjzFdpMbAmQL1+45mFyYghyN2Ob3ep6vSJcnveo
         1If3CehFB1dn1hN61bL8zCYix+5qCD7/dc47HYy+fZifrYTlTfX15edD7cn8zP3+n4sL
         Db0AKRNhv9uR6uh+c62jRoAAJkrU+OPZQCueFnP4paxWCncxyPrqK7CDGRqKwUJMlhb3
         ImeA==
X-Gm-Message-State: ANhLgQ24KKbE6+m81xDgYiBezNa75K0zIhgi/SOU7piJXJSkfONAOCot
        zbRuzJizkihjAtlPNM6hRG2BEQ==
X-Google-Smtp-Source: ADFU+vtxEx4oeojuJNx6exzRxdGuXoqCl51ncVvkkl2QI21JaiWr2FV9967v4dRa9pBNfHP5Tulp2w==
X-Received: by 2002:a63:a06e:: with SMTP id u46mr23528688pgn.140.1584305749808;
        Sun, 15 Mar 2020 13:55:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h23sm13566341pfo.220.2020.03.15.13.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 13:55:48 -0700 (PDT)
Date:   Sun, 15 Mar 2020 13:55:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Miller <davem@davemloft.net>
Cc:     kuba@kernel.org, shuah@kernel.org, luto@amacapital.net,
        wad@chromium.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 0/4] kselftest: add fixture parameters
Message-ID: <202003151355.C9118025F@keescook>
References: <20200314005501.2446494-1-kuba@kernel.org>
 <20200315.000517.641109897419327751.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315.000517.641109897419327751.davem@davemloft.net>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 15, 2020 at 12:05:17AM -0700, David Miller wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Fri, 13 Mar 2020 17:54:57 -0700
> 
> > This set is an attempt to make running tests for different
> > sets of data easier. The direct motivation is the tls
> > test which we'd like to run for TLS 1.2 and TLS 1.3,
> > but currently there is no easy way to invoke the same
> > tests with different parameters.
> > 
> > Tested all users of kselftest_harness.h.
> > 
> > v2:
> >  - don't run tests by fixture
> >  - don't pass params as an explicit argument
> > 
> > Note that we loose a little bit of type safety
> > without passing parameters as an explicit argument.
> > If user puts the name of the wrong fixture as argument
> > to CURRENT_FIXTURE() it will happily cast the type.
> 
> Hmmm, what tree should integrate this patch series?

I expect the final version (likely v3) to go via Shuah's selftest tree.

-Kees

-- 
Kees Cook
