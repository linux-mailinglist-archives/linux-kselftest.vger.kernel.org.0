Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F1233FCA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Mar 2021 02:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCRBWu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Mar 2021 21:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCRBWe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Mar 2021 21:22:34 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57222C061762
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Mar 2021 18:22:34 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id q5so2347377pfh.10
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Mar 2021 18:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EalAswFOAcFp0mMFCKv9AaiQ3ouyPCG+tDog26PGvcI=;
        b=TSffuJwrnV2vab8/yGoahUmuVCMDXKwUtsys3/bDoxiRWc2F+tAbiwWP2aKGYHhGV8
         gzbjPnRuubA6uxOalwf/Z67un8+OC/fwBeJ8Upsa2Pv1pu1E+PVITOIEVPFFO+PQW43A
         yV0DB8OU4s1DHxtjiTSy0K6Yf3Xh0c37cc+7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EalAswFOAcFp0mMFCKv9AaiQ3ouyPCG+tDog26PGvcI=;
        b=sVpq7T88jU9Zu9pYax+kaR9klIsw6lkE0dToumfOjo+PO7QcYGaBO/uxNM6M/75qJD
         40e7M27IhL0yN+r5dbsDdN+V7/cD2QerDg+nCyZ3DA3GB0lAaN0S3eHFctPOhKvr1yB1
         b2dX2JzMkpHRZ+gP6g14YeHROIHZj+f+RnbxGfFL94Gj+e9PxnSkf9M4TvebS2LI09Af
         xBCU93RLWY+4RS1yx5+HBSBaiDt1JOQlbTPqlBa5KrN+wAOGhOoDx6Rnt/b2V7YAVlOI
         Z97veuTdpED001wpoxA0Q4PmhlUTndrMuKtIEqPy8CnFO/x0cPSy4f5bG6n7bxHhoCaX
         3wUQ==
X-Gm-Message-State: AOAM531rlX0iZQ4wXmUE3v6EOqsqaA6ePwWHr2QVLnJXkNAfidYq6VFO
        vVxw+tqSZ+2VD1D77ZuBWvNKZg==
X-Google-Smtp-Source: ABdhPJyrmCLmGW63fx9n1OC+yYNO5rjvfb0Ce9xQhK2RMb98xMDnfa90K4TsbnB5zAo7scdsUzAUcw==
X-Received: by 2002:aa7:81cb:0:b029:1ee:5346:8f1d with SMTP id c11-20020aa781cb0000b02901ee53468f1dmr1683154pfn.4.1616030553695;
        Wed, 17 Mar 2021 18:22:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c1sm272445pfn.131.2021.03.17.18.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 18:22:33 -0700 (PDT)
Date:   Wed, 17 Mar 2021 18:22:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Wood <john.wood@gmx.com>
Cc:     Jann Horn <jannh@google.com>, Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        Shuah Khan <shuah@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v6 1/8] security: Add LSM hook at the point where a task
 gets a fatal signal
Message-ID: <202103171821.C851A2D189@keescook>
References: <20210307113031.11671-1-john.wood@gmx.com>
 <20210307113031.11671-2-john.wood@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307113031.11671-2-john.wood@gmx.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 07, 2021 at 12:30:24PM +0100, John Wood wrote:
> Add a security hook that allows a LSM to be notified when a task gets a
> fatal signal. This patch is a previous step on the way to compute the
> task crash period by the "brute" LSM (linux security module to detect
> and mitigate fork brute force attack against vulnerable userspace
> processes).
> 
> Signed-off-by: John Wood <john.wood@gmx.com>

I continue to really like that this entire thing can be done from an LSM
with just this one extra hook. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
