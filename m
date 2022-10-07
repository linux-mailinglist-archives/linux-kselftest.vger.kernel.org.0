Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED645F7282
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Oct 2022 03:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiJGBXr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Oct 2022 21:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiJGBXp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Oct 2022 21:23:45 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC98C4C13
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Oct 2022 18:23:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so3354528pjf.5
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Oct 2022 18:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=stxK5eytfi7UYuaTvPr6AF15rib5TqQ7VohLY8AETTo=;
        b=BAMPgHgcFnz0m5pv8ALZ2vuDAV8Wc9woff48oOK4K3VMoOPH9YWc5vnpQ7Heyj2BBG
         nErfRvGZFFrVBxkfN8+u3Skf3cCa62PrOw7iLZw5DPICoO1zvKaRXjGHEa+qKJZHKG3t
         v6jrPuKfQbzGgsIL98V9SzitClNrxXtr5Gl7Sd71SrKOP7n2Rd9wK0KZVm6KQaVHa+jL
         W4RdSyoaZbbXNRucpHlJ8Z9EtmwXiSNUZOncYy2CsQdKY2C1QH8456f9SnWskshsgZNT
         uFOOkktZooPW0OQIjY9chxvRV0u/OC8K1zp8E3PO+lokUwafNUUGnxxbUIrlANr3bloM
         GSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stxK5eytfi7UYuaTvPr6AF15rib5TqQ7VohLY8AETTo=;
        b=j0b3OSrBdMMu8i9i144jWPnQn7HZzIhA1gE5qzF/Ix7+fAEgTro5Zy5tB9obxfTRbj
         yM5E9p/hC96b/cjsAY4EiiX3Itu1VyNo/ZO1pUaZXAvbrJwH3P4aCXPspRBGZDIOrEqe
         bRnyJMDfJySg2x9Kn89btiphlF0w36yweH9fApv9SV4k3RLht7277mZ18C/d4lR9otUm
         6rjEv86m/l5fxEaB+nlqwhm00COVA8ExabQzfudvIa+MB5eLOGfJcA5ERzRRYXf3iW1w
         IxfO4vZal/FTVI/VAEVZgnO9yYdKEcH0L4FVW4L93tBSxBAf5Hlgt+BsinIa1ryZycji
         wutA==
X-Gm-Message-State: ACrzQf28SU6QlgVV2OHVSiJQk1ICmNuECzGY2y64yZ7eIAKojj3t9hG8
        mjZ7LFl5uvuOxrrzISQteINz/OZmU0UhKA==
X-Google-Smtp-Source: AMsMyM4PWFE5pVw18NO2lbdt/TsjQ6FJS7+cij5WQtyZmovc7uLcrH3PCdFglUP7Tg7u6mRpJ23L7A==
X-Received: by 2002:a17:90b:3d89:b0:20b:201e:9d with SMTP id pq9-20020a17090b3d8900b0020b201e009dmr3592539pjb.11.1665105823006;
        Thu, 06 Oct 2022 18:23:43 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id k3-20020a632403000000b00439920bfcbdsm395764pgk.46.2022.10.06.18.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 18:23:11 -0700 (PDT)
Date:   Fri, 7 Oct 2022 01:22:26 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andrew Jones <andrew.jones@linux.dev>
Cc:     Thomas Huth <thuth@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] KVM: selftests: Use TAP interface in the
 kvm_binary_stats_test
Message-ID: <Yz9/UsWtYimt2T1D@google.com>
References: <20221004093131.40392-1-thuth@redhat.com>
 <20221004093131.40392-2-thuth@redhat.com>
 <20221005083312.dnblbpe6wabspkzk@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005083312.dnblbpe6wabspkzk@kamzik>
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

On Wed, Oct 05, 2022, Andrew Jones wrote:
> On Tue, Oct 04, 2022 at 11:31:29AM +0200, Thomas Huth wrote:
> > The kvm_binary_stats_test test currently does not have any output (unless
> > one of the TEST_ASSERT statement fails), so it's hard to say for a user
> > how far it did proceed already. Thus let's make this a little bit more
> > user-friendly and include some TAP output via the kselftest.h interface.
> 
> I like the idea of switching the entire kvm selftests framework and all
> tests to the ksft TAP interface. But, if we want to do that, then the
> question is whether we should start by partially using it for some tests,
> and then eventually switch over the framework, or whether we should try to
> switch everything at once.
> 
> I think I prefer the latter, because without changing the framework we
> can't provide full TAP anyway as TEST_ASSERT exits with 254 instead of 1
> for a fail-exit and it doesn't output a final TAP test summary either.

I would much prefer the latter, e.g. with common entry/exit points[*], much of the
boilerplate can be done once in common code.  I bet we could even figure out a way
to have tests default to setting a plan of '1' so that simple tests don't need to
care about TAP at all.

[*] https://lore.kernel.org/all/20220915000448.1674802-2-vannapurve@google.com
