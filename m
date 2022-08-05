Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1E458B09D
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Aug 2022 21:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241364AbiHET7h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Aug 2022 15:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240859AbiHET7g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Aug 2022 15:59:36 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD661E3C6
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Aug 2022 12:59:35 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso9193563pjq.4
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Aug 2022 12:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=QWBm7lqUfCm1gEiD6q+yqH0sezQKK+ZMj4BJuVRBJdk=;
        b=qEpk93t1+HB2zZDgqU94m7lSWi878nc3XrE45Y2MX6mcUpmfVDhwFRuFILBIUKh5s2
         dX3sXkw++IGfGudzBxIcvBuJI0DPBYyquChZ4VF5IAPPYbBuxxU5roFf/GAoHojQSjzT
         oWZJh240TBtujRK0DNWC4bPtTXjI5sfR1H/kJDf2tas+Y3rr/9r54yuOBTeuYk4Gk0te
         evcVLDQTwDSYcg7w9dTPeBrl24LDh+/I1l2NLkeeemwBJNdMhy8XgcS6cfrfIeqSYtUt
         RD4R60OSGQ73+hWCw9Nl1B2km6C+3GjYvNJEk3YuZ7AscGFoyjzjzPhVPrtV6djgw9lI
         l8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=QWBm7lqUfCm1gEiD6q+yqH0sezQKK+ZMj4BJuVRBJdk=;
        b=BfUtLT+e+pSwBQa066/ux/TnMYpQHv9AhviAZ2JLpMWp6ZiFP7k3PE83W0LnrRnfR5
         cKaLanLAMHHYXIxh3KCbRlNJapgoOr0Ff1NDZHflvEjkH/qLkADww7PoDs9k6aqy3nMq
         bFH5FKPWIP52dOH+u1KNYbrdX5/iLQBgFYyqenpOossAeLCMfaNGthypsXV5HoPEPnhL
         nIJSLtN8RPHGRBusPROjI9hQLcynQk9RrRk37UjfKEsyX6FKQt2Jw4BXu4C4+BBQJYV3
         pUR0QQ2kj6Szc53YLE/gHUAHe2OXOpMwKXinjJXCjW45zpN4J/P92lVskTbXMMUZmLCx
         Pk8Q==
X-Gm-Message-State: ACgBeo3Y4WxQlJwtFD3JM+5USe5Y3qNgbvZlIhW/CSTh7c9uuvD6i6DT
        vNVqWBl8M4IbUiHJpPTjiFX2jA==
X-Google-Smtp-Source: AA6agR6hPDsYpzfLfbDVz6nqPYj5F+irxuz9Zv5G2qnYofzc5OQEFOB2B/m/fQm3dWRDga+ztSAonw==
X-Received: by 2002:a17:902:aa48:b0:16f:1364:788b with SMTP id c8-20020a170902aa4800b0016f1364788bmr8387357plr.109.1659729574798;
        Fri, 05 Aug 2022 12:59:34 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id x134-20020a62868c000000b0052e67e9402dsm3436825pfd.106.2022.08.05.12.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 12:59:34 -0700 (PDT)
Date:   Fri, 5 Aug 2022 19:59:31 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Michal Luczaj <mhal@rbox.co>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm <kvm@vger.kernel.org>,
        shuah <shuah@kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>
Subject: Re: [kvm-unit-tests PATCH 2/4] x86: emulator.c cleanup: Use ASM_TRY
 for the UD_VECTOR cases
Message-ID: <Yu12o0mKMUdnQ8Ol@google.com>
References: <ae0a0049-8db0-501b-79e4-cd32758156fb@redhat.com>
 <E1oK2U0-0000qn-CI@rmmprod05.runbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1oK2U0-0000qn-CI@rmmprod05.runbox>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 05, 2022, Michal Luczaj wrote:
> On Fri, 5 Aug 2022 13:42:40 +0200, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > On 8/3/22 20:21, Sean Christopherson wrote:
> > >> I've noticed test_illegal_movbe() does not execute with KVM_FEP.
> > >> Just making sure: is it intentional?
> > > It's intentional.  FEP isn't needed because KVM emulates MOVBE on #UD when it's
> > > not supported by the host, e.g. to allow migrating to an older host.
> > > 
> > > 	GP(EmulateOnUD | ModRM, &three_byte_0f_38_f0),
> > > 	GP(EmulateOnUD | ModRM, &three_byte_0f_38_f1),
> > > 
> > 
> > *puts historian hat on*
> > 
> > The original reason was to test Linux using MOVBE even on non-Atom 
> > machines, when MOVBE was only on Atoms. :)
> 
> So the emulator's logic for MOVBE is meant to be tested only when the
> guest supports MOVBE while the host does not?

Ah, I see what you're asking.  No, it's perfectly legal to test MOVBE emulation
on hosts that support MOVBE, i.e. using FEP is allowed.  But because KVM emulates
MOVBE on #UD and the KUT testcase is guaranteed to generate a #UD (barring a
hardware bug), there's no need to use FEP.  And not using FEP is advantageous
because it avoids depending on an opt-in non-production module param.
