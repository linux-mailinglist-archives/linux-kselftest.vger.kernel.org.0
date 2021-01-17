Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540862F9673
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Jan 2021 00:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbhAQXzZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 17 Jan 2021 18:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbhAQXzY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 17 Jan 2021 18:55:24 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B3AC061573;
        Sun, 17 Jan 2021 15:54:44 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id s15so7661214plr.9;
        Sun, 17 Jan 2021 15:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LmlVmr5QZIAuFyhAzTMtvc0ZpiTTs7C1V/Whdgh2hgY=;
        b=NSDhOJH1IF0DMEv9C6jyJuFO25nj0Tc3RYbK7HP/Vfwt6QN8Nh92s1aJIc8byDsixl
         1DoO23LH7OtXeCle5o6ochEmi8aWZOuHibBD7rNCeXqP26Pr0wxv2eWcth9/+KXpN1u4
         w53+hlkr5jjSu+mRPOekDg74fpFiVE+0EBfBdyHWml58afKSjnQWaTr2TjrkULMSmp69
         ORD6Nl3ryWGzFNLaoAIRbTY5vjoKZ9Txh1h155ocdBgbfJuqbHaFKVReGG4M3SQgEllN
         9Iy1eHLNt9IO7Ajxwl/4fpl0MEmzo1YaSXrqXStLdbXwAqqkvaSzQk9OJr7Z+6eEzOLO
         fogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LmlVmr5QZIAuFyhAzTMtvc0ZpiTTs7C1V/Whdgh2hgY=;
        b=U9UsbZpY11PoOTdPE3kebznHCLiTnciRFUp4KpNYCBfHgm4lki3qYa1SfCHVTvE4ri
         MHZkl212BDa//qMBRU+prq/ZIUvTJvOwxuWjQyghzYRsbefcGhhrz83UFOGt0VqGjqdd
         4tTdOn0QbnlklEA2Np7z/5/S12w494/vHZO3mc4YlnVe+7dKj5z1ZCcqMsXO4ujgFqmq
         Pr78jwkk+fcRa9R18fR3GV8Is1+OTf+m50Cvmgs2WJr40CmxXAktIYP1YDyEOCGKvvXr
         KEvsU1jNPjvDEneI67h+fzzqdc6H6+sEmh5eSlp7fx3spGJT58/0M6KJF20GtdhjTP81
         E+8Q==
X-Gm-Message-State: AOAM530cgLgy7I+ESVK99Jp5ROJ/y6o+WW2+5GJftS0huVy++qHvIMKh
        IBQR6EgAQTCsy+SddFGKsXnQmsClc+A=
X-Google-Smtp-Source: ABdhPJxOwST6O0eP6JbE8aOvb/Gk7fiF9noRUF63dyqYx3BwAhYIx8PTQveV0TD5wbMfO62e4OWw2g==
X-Received: by 2002:a17:90a:8e84:: with SMTP id f4mr23427129pjo.129.1610927683402;
        Sun, 17 Jan 2021 15:54:43 -0800 (PST)
Received: from sol (106-69-181-154.dyn.iinet.net.au. [106.69.181.154])
        by smtp.gmail.com with ESMTPSA id t6sm14245537pjg.49.2021.01.17.15.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 15:54:42 -0800 (PST)
Date:   Mon, 18 Jan 2021 07:54:37 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com
Subject: Re: [PATCH v2 1/7] selftests: gpio: rework and simplify test
 implementation
Message-ID: <20210117235437.GA6841@sol>
References: <20210107025731.226017-1-warthog618@gmail.com>
 <20210107025731.226017-2-warthog618@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107025731.226017-2-warthog618@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 07, 2021 at 10:57:25AM +0800, Kent Gibson wrote:
> The GPIO mockup selftests are overly complicated with separate
> implementations of the tests for sysfs and cdev uAPI, and with the cdev
> implementation being dependent on tools/gpio and libmount.
> 
> Rework the test implementation to provide a common test suite with a
> simplified pluggable uAPI interface.  The cdev implementation utilises
> the GPIO uAPI directly to remove the dependence on tools/gpio.
> The simplified uAPI interface removes the need for any file system mount
> checks in C, and so removes the dependence on libmount.
> 
> The rework also fixes the sysfs test implementation which has been broken
> since the device created in the multiple gpiochip case was split into
> separate devices.
> 
> Fixes: commit 8a39f597bcfd ("gpio: mockup: rework device probing")
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Just a note that the 'commit' should be removed from the Fixes tag.

That will be fixed in v3.

The patches have been reviewed from the gpio side - any feedback from the
selftest side?

Cheers,
Kent.
