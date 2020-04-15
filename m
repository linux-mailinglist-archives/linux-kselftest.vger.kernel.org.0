Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A281AADAA
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 18:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415504AbgDOQRZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Apr 2020 12:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2410349AbgDOQRV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Apr 2020 12:17:21 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A78CC061A0C
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Apr 2020 09:17:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id np9so46618pjb.4
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Apr 2020 09:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8qF0LUXdpindc5vOiwqFLokJsFdLR0vgnOBjxtQzWbs=;
        b=Mve6xxIT004adgNzucM9jYaZUdUKPTbB4pwhTsIrjJyXfWIjwyitHsnToKZ2/j7tXo
         VmFkPLz3yqdaiwSASSLGOvK7JOu8Kl0d2dIICLPS6AGnBQif9AGJeXnHs9V8by/mtclL
         qAsawvXA5/aCflai5s1gmEy5wct8dOm+XAOZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8qF0LUXdpindc5vOiwqFLokJsFdLR0vgnOBjxtQzWbs=;
        b=XYO0xZsf5JPxj00NcRAJ8Ji5Wi6Oz/+i8ennam/Wk79ckbPoR7qYcZYiQtLyhOwVaF
         gnDyFZJ77ska8aNh0eO599iBw2X/3Yva2SiNm3vrejFAk5JLTFBiEA0KOn0hXD4bc4ic
         tJPms1fNEwxXEU7lAzWUjQkpM6fuC+g+Ilgt33kug5p5i+xF/AIHFa7+qPaG9/q+az6v
         62ie0//XDMtQ1JWwvfrVM7iBnuqbS0McDVM2lRp48fVMKpC9Vn7x1kb87rgo1oW0SkFK
         3x5gBarnVhnMcFYtHgbyh5j15lxn7Ny+RvpSCPRSJxYwPOixvt7huhL0uIpGjXZbnFOQ
         gOOg==
X-Gm-Message-State: AGi0PuaHmT8GIjdziLrecGGcmg95mG9CIRe/apVb0Aeow5pBLFljZJsO
        PnEZj7Ix3RHUEE70kjYmiUwC6Q==
X-Google-Smtp-Source: APiQypLZs4xoFWXwCC6ACEShStmRbLORywovCATnaoYdHfDs8I1rBSwFVXIOkj5TOo8wqWByixut/Q==
X-Received: by 2002:a17:902:a40b:: with SMTP id p11mr5828336plq.304.1586967440145;
        Wed, 15 Apr 2020 09:17:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u15sm13106471pgj.34.2020.04.15.09.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 09:17:19 -0700 (PDT)
Date:   Wed, 15 Apr 2020 09:17:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     shuah@kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        luto@amacapital.net, wad@chromium.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Tim.Bird@sony.com
Subject: Re: [PATCH v5 0/5] kselftest: add fixture parameters
Message-ID: <202004150916.3A452C9@keescook>
References: <20200318010153.40797-1-kuba@kernel.org>
 <20200410172326.3ad05290@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410172326.3ad05290@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 10, 2020 at 05:23:26PM -0700, Jakub Kicinski wrote:
> On Tue, 17 Mar 2020 18:01:48 -0700 Jakub Kicinski wrote:
> > Hi!
> > 
> > Shuah please consider applying to the kselftest tree.
> > 
> > This set is an attempt to make running tests for different
> > sets of data easier. The direct motivation is the tls
> > test which we'd like to run for TLS 1.2 and TLS 1.3,
> > but currently there is no easy way to invoke the same
> > tests with different parameters.
> > 
> > Tested all users of kselftest_harness.h.
> 
> Hi Shuah!
> 
> Were these applied anywhere? I'm happy to take them via 
> the networking tree if that's easier.

Shuah, with -rc1 out the door, would now be a good time to take this
series?

Thanks!

-Kees

-- 
Kees Cook
