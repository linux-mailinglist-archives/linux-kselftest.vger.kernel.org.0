Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1CB41CB52
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 19:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345028AbhI2R4C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 13:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345007AbhI2Rz6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 13:55:58 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59D9C061765
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 10:54:13 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id om12-20020a17090b3a8c00b0019eff43daf5so2632480pjb.4
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 10:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NsM0QYbB2vUeU6XpTENYRxMtFbeMZ3QJUEScRtQsMSU=;
        b=A43brtOAGWdbiGMmjU/KjDyojLXi0Q4ZBFDfw88tTfcdHmvg2RxbOQQfAhy6nBMZ3/
         AhrmNzsGT32VeaAd44VjOcfneFf+TbuLjoOlqmfVY0mxoSHPdHupGgJPD8y+X+odsHkd
         XykxJvUdi1cJ9QcUXOmc6ro4N00DG+F8FRWnE8L8lKw6e+b9LJdQVJyBhv0iLzonOqar
         a6XQ3fD6knY4a3+BWHNsODfQjEiz8NtkZxfzGqHSmNl/ZWQ9iVzn5vsRfszDepTihK4Y
         cKE+73mayyq1slTd7cwzV6+OWQ6xSrnjOaSWf8Y3dEkJbzs46a+hxXZix7CLNapxfr+/
         qk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NsM0QYbB2vUeU6XpTENYRxMtFbeMZ3QJUEScRtQsMSU=;
        b=ZOvklaHJaAbfYL0mDPnJoI2gJ9D9QJCURFeveFSFsxoplLXJc0WlBFMDRCdc4KSbS2
         xobc+i5vvi83ePYD5S5zt5WsBMXcSTQYYAgg5jl381CwGqYOzF1C+gRaJlAdpPGVEKyG
         pSeSXh0YzsFqi5sncn9mSTbdFqWNY2r6l43gNE010ojOca99YYoHPHQK03Hm692336b2
         Lv5buuwxIxRuKM2c9Dzs6FHKYVc/s1jI9SLn4VTQyOEbcEFA0qi0rrCG7v29uJEqOeYz
         z6i24c+M9S9y/+fubBee+uD26eajz9vEA7xpye4X3VfS0UGs5+sjQk2nL4Gv/wTwp7Ll
         kHUA==
X-Gm-Message-State: AOAM531KlBVUOprmoG1s8lRPczzt4KJEze2fFmVVya94xfrZG5+0wnxn
        xJrOyFdBqmoqjKvr4VUNTRQXNDaJkrlJ4g==
X-Google-Smtp-Source: ABdhPJzp40tu/G9HqnvotUw/jMzwx9XNCWus/4f0EXr5sSTYTeNKg2Zwh/1URL4JStL4NZqRMJ5Zrg==
X-Received: by 2002:a17:90a:307:: with SMTP id 7mr1316264pje.176.1632938053093;
        Wed, 29 Sep 2021 10:54:13 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id a27sm409833pfk.192.2021.09.29.10.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 10:54:12 -0700 (PDT)
Date:   Wed, 29 Sep 2021 17:54:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        pbonzini@redhat.com, shuah@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] selftests: KVM: set affinity of VM to right CPUs
Message-ID: <YVSoQD+yuQzlKLoM@google.com>
References: <20210924233037.4329-1-dongli.zhang@oracle.com>
 <YVIZ/67cfjk18mbe@google.com>
 <5b0a16a9-e98e-368f-4ecd-359c58ae34c4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b0a16a9-e98e-368f-4ecd-359c58ae34c4@oracle.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 28, 2021, Dongli Zhang wrote:
> 
> On 9/27/21 12:22 PM, Sean Christopherson wrote:
> Perhaps a linked list is more suitable to here (when there are 1024 cpus and the
> task is bound to both 1 and 1022) ... to pre-save the possible cpus in a list
> and to only move to next cpu in the list for each iteration.
> 
> However, I think min_cpu/max_cpu is good enough for selttests case.

Yeah, it's annoying that there's no CPU_SET_FOR_EACH so that x86 could optimize
it to use BSF :-/

> Would you please let me know if you would like to send above with my
> Reported-by, or if you would like me to send with your Suggested-by.

If you don't mind, I'll send a patch, I want to fiddle with the migration loop to
see if I can make it less magical/ugly.
