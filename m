Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCD47D1284
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 17:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377690AbjJTPW1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 11:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377693AbjJTPWZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 11:22:25 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AEAD72
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 08:22:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7ed6903a6so12640747b3.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 08:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697815342; x=1698420142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KeBN29hJ4LjkmlULAdi6wXvguRmPwY9ij6dOK18Our8=;
        b=kzHIdtfH2CVtn1JZPsuG8SO46dkMev2ofrsHDocgM3362Cyr0TK06sGE042I0JdZnE
         fnyhlEKOMsBLtuis21yUl5CM/TFSPolFMAvP3Ucdkn3i3Lev+lkatqkpaPA9bJxrVEJA
         IKuzqFe2je15oQdrwd9FTMGfgZP5NVXr4T1qs94UIAfivvaHdJI/srgHCOvZsMaHakPR
         w00cRWFNhHvezUG6weBOGCTUM+/IccucfidT4nLiS6tI9ooFW4EPV+JsfZmrqTDqpda8
         K7FgNCA5X50/wh4S4bRqUp+XiYNXFX0vH28oCf2JqVB/6Elk53FsOmMdhwtCS+BPqXx4
         IR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697815342; x=1698420142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KeBN29hJ4LjkmlULAdi6wXvguRmPwY9ij6dOK18Our8=;
        b=VJsWw6gID23J8zUd24+kioSI0ofl1I+pgwV9bJlOzbKHH+4v6mpFLl927AFmLTUfcg
         Sge0jv29CyDl0K1N2AITAybk72TEL35T8t4l5JOMJKwswJYV2qqU9Xlo/YDAU9tXMzRm
         N01eFj4HqBj3auMAzSqODLd1w4/UrdVhF662cRcjCHVpX2pzUgk0ARuLIRjDDsgkdROE
         SKML10bE+jqPZvgY7jtJ1naFhHtaPH7eLrBflgb9/Dy8YYHSXt8alifJPlbaKNomxt6L
         wIJTzPQtNosfeWA5eXd5a+KT52epMR7ZMZCAw0kQI1au9OUOt7lwbGMd0VvQM2Vxta40
         mJTA==
X-Gm-Message-State: AOJu0YwB1JwkqYToT5HxuykKGCC0AdMxRVzFEVYhTp1q6l03/NDmQnbt
        8md90VZSkQx0ecNtpX53KZRQD0GvgLY=
X-Google-Smtp-Source: AGHT+IGJ8nVnX9/UbO2Yh1OQ/NK9Kx6ZKcxAld+bIeetVr1RVijF0J+1mwesfi/RqnFrlFaxlWSuOWUi13k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d50f:0:b0:592:7a39:e4b4 with SMTP id
 x15-20020a0dd50f000000b005927a39e4b4mr51324ywd.6.1697815342159; Fri, 20 Oct
 2023 08:22:22 -0700 (PDT)
Date:   Fri, 20 Oct 2023 08:22:20 -0700
In-Reply-To: <bbddbf1f-33c1-cdae-9e0a-a05403bf44bd@oracle.com>
Mime-Version: 1.0
References: <20231006175715.105517-1-dongli.zhang@oracle.com>
 <ZTA3W-f4sOX3LHfi@google.com> <20231019-f96a45af9c235d89be644e67@orel> <bbddbf1f-33c1-cdae-9e0a-a05403bf44bd@oracle.com>
Message-ID: <ZTKbLKK0icwUZvlB@google.com>
Subject: Re: [PATCH 1/1] selftests: KVM: add test to print boottime wallclock
From:   Sean Christopherson <seanjc@google.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, shuah@kernel.org, dwmw2@infradead.org,
        joe.jin@oracle.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 20, 2023, Dongli Zhang wrote:
> Hi Sean and Andrew,
> 
> On 10/18/23 23:51, Andrew Jones wrote:
> > On Wed, Oct 18, 2023 at 12:51:55PM -0700, Sean Christopherson wrote:
> >> On Fri, Oct 06, 2023, Dongli Zhang wrote:
> >>> As inspired by the discussion in [1], the boottime wallclock may drift due
> >>> to the fact that the masterclock (or host monotonic clock) and kvmclock are
> >>> calculated based on the algorithms in different domains.
> >>>
> >>> This is to introduce a testcase to print the boottime wallclock
> >>> periodically to help diagnose the wallclock drift issue in the future.
> >>>
> >>> The idea is to wrmsr the MSR_KVM_WALL_CLOCK_NEW, and read the boottime
> >>> wallclock nanoseconds immediately.
> >>
> >> This doesn't actually test anything of interest though.  IIUC, it requires a human
> >> looking at the output for it to provide any value.  And it requires a manual
> >> cancelation, which makes it even less suitable for selftests.
> >>
> >> I like the idea, e.g. I bet there are more utilities that could be written that
> >> utilize the selftests infrastructure, just not sure what to do with this (assuming
> >> it can't be massaged into an actual test).
> 
> Thank you very much for the suggestion.
> 
> Would that work if I turn it into a test:
> 
> 1. Capture boottime_wallclock_01.
> 2. Wait for 10-second by default (configurable, e.g., max 60-second)
> 3. Capture boottime_wallclock_02.
> 4. Report error if drift.

Rather than pick an arbitrary time of 10 seconds, deliberately introduce a
plausible bug in KVM (or re-introduce a previous bug) and see how low you can
push the wait time while still reliably detecting the unwanted drift.  Then add
a reasonable buffer to give the test some margin for error.  Given the drift that
David reported with the xen_shinfo test, I assume/hope that a 10 second runtime
would be overkill.

I would also differentiate between total runtime and the periodic check time,
e.g. to allow checking for drift every N (milli)seconds while having a total
runtime of M seconds.  Then there's no need to set an upper bound, e.g. the user
could set the test to run in the background for multiple hours without having to
worry about the test being useless if it's canceled early.
