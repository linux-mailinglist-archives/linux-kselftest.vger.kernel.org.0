Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E908C62C677
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 18:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiKPRgX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 12:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbiKPRgV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 12:36:21 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0941B5D6B2
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 09:36:21 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id k15so18156272pfg.2
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 09:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uMpyhPRo49yCYtDdWLnPUG6w8J9G3yX4v+y+FzJTCjI=;
        b=P4lcupnFe3arFwzI/RBiDY1CkjkCFPn44C2NQbdzi7VF192uxSML8weiuFgHVgrb9C
         /rRhMFOM3hQLU6MCnkftFr+Cl1mO/Zoto/73UgmSLvx1vW0Yrxwy38E6s4nOOmIM1hZ8
         jF2n/oObkKjqXF653GuRNOxAj1wLas0nRL45IVHF42OHau/qkP/OHGjWO0wzpc7Ci+Hv
         02P5tCLZzyDFHH9cIkXq23NKv/23jzy9jVe5/sAvzqNlHOnX7vnYN+q4TAIlZOm2TAg6
         8/jFcvbTeqiFWrHS9TksJmnirKuckgKR+dXmZcbmOFuKE6KKEQ1Fvf8PJiWyJGqje0eZ
         Ocdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMpyhPRo49yCYtDdWLnPUG6w8J9G3yX4v+y+FzJTCjI=;
        b=SxZNStEIMK0QYIh6T+FvBBuV9QLT13gws1df5OZMuPtAp0UpR1asg0Rte0EIdR6CxZ
         6i0PZEbGbECohOdBWhsqt9uJAJiLchbG2jdwxJxoRVRPCjfe2s+ulIbdr+pSViKlGmMW
         lmnCrVVTrIuhMJ+AA4ZFU25R2mFCnWVaGcRO5aavnCyF+W6bPcSuW4209RNwpJlKuDMk
         WWnDs4c32G8ffslaxrMOB8nTysPjuj+ngbcMDuhAw7F7waEslZXfYj0GYZTiTMUt8o5O
         m9JIIZB/LahXQzgX4VzGs48f/tbZ89A6iMFUAgGQt/ern1ruiucpFKuWQOVtIJtE9vtp
         a8XQ==
X-Gm-Message-State: ANoB5pmAw+sSlSE/WEPCpcKeM5AGQySceOif/dUf9al3PadypHdJfW3q
        P3RRn2/zVRDgxIBswvkmP5jnVA==
X-Google-Smtp-Source: AA0mqf47RLQKtt8wsQd5KbME8R0MEGBnP3uaGwhfFvDROmU7GuT9E67J84o92BN7xsr0rD07zgUhrA==
X-Received: by 2002:a62:506:0:b0:56d:4b31:c4d9 with SMTP id 6-20020a620506000000b0056d4b31c4d9mr24532107pff.44.1668620180412;
        Wed, 16 Nov 2022 09:36:20 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902ec9100b00176e6f553efsm12555425plg.84.2022.11.16.09.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 09:36:19 -0800 (PST)
Date:   Wed, 16 Nov 2022 17:36:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, oupton@google.com,
        peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com,
        pgonda@google.com, andrew.jones@linux.dev
Subject: Re: [V4 PATCH 1/3] KVM: selftests: move common startup logic to
 kvm_util.c
Message-ID: <Y3UfkIQLUKDM8OLb@google.com>
References: <20221115213845.3348210-1-vannapurve@google.com>
 <20221115213845.3348210-2-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115213845.3348210-2-vannapurve@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 15, 2022, Vishal Annapurve wrote:
> Consolidate common startup logic in one place by implementing a single
> setup function with __attribute((constructor)) for all selftests within
> kvm_util.c.
> 
> This allows moving logic like:
>         /* Tell stdout not to buffer its content */
>         setbuf(stdout, NULL);
> to a single file for all selftests.
> 
> This will also allow any required setup at entry in future to be done in
> common main function.
> 
> More context is discussed at:
> https://lore.kernel.org/lkml/Ywa9T+jKUpaHLu%2Fl@google.com/

Nit,

  Link: https://lore.kernel.org/lkml/Ywa9T+jKUpaHLu%2Fl@google.com

is the the "standard" way to convey this information.
