Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE8769C1C3
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Feb 2023 18:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjBSR6r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Feb 2023 12:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjBSR6p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Feb 2023 12:58:45 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A299011168
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Feb 2023 09:58:44 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id f8-20020a17090ac28800b00233d7314c1cso1013087pjt.5
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Feb 2023 09:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b2rY0fDePvZ3ge2mp7FGjGIShiKV6CSswgiMPgCf5uY=;
        b=Q2fsYk+/ips79nToDdZaIQ5r56O5hTmDZv3zAog+oerEoHeUZzBmJzPUcIy20tmDC5
         1SEo9LyX8X/p9GYsrp+XhAIWeiqCtJtxDlkn+JIWn7Y92zjaDN1paBCzaKUrAfnATJls
         3Halcrnd18gcRkC4O+CvdstDiXB0kt8jZ3SYmlu+pMiydGNMCu3LHtkfPO4DcT/AHBzt
         M/oBDwuDxujTAFg5pjGOc6eBBsGC5WexDg/5p8fnWhZ+JCuPUWYWfYuihESbRZLhvai5
         ZJgxRRCgKbyeBlDVTen8QBA9NjPdkxXzbNUm2Mtkh03xemzQuS+gk80AD2dVZ2rOc8VF
         +WAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2rY0fDePvZ3ge2mp7FGjGIShiKV6CSswgiMPgCf5uY=;
        b=lJStTNonVtRGijJXrof6j/lt0v74LAHCjEvmgOh/hzqMxLtfPR3oLeF58Y9jQWIYtP
         bJSqc4T6Yx872OHrZu7RIuma764jquA8MTsxGxXGtKf1PmtQ/ig9qPLSqAQKayLxolVC
         VPlELd73Rojp59h7YCKQcjrOowQYEUieuJ6kTMTgLSthLGSaMijZIIDUimRXjxq6u8aY
         T62fDj9CojSBvqwcrCf7ruPbFEDYUo0JOSk1Q/1r/jXn2AsBf0ktwcnbCOeamHKa2s1L
         Tb55Rxf+nZNPm6cNLzu8+AC7sE7QA6msu+LpAFD3JLGtnmHlgUTBTr5Phe3/ixPLXkdQ
         UbRw==
X-Gm-Message-State: AO0yUKWhSfp1flgZKkJwakDdirxcO2O+EXkyoZZRjXX2TjLRMAiW4SnM
        ctSYRT96hjUuE8QDXMF9FEeulg==
X-Google-Smtp-Source: AK7set+GY3ybl/QsgojsDaqcMFssxRzRsKYU44N6hTtKw+of4RSi58cpzxDTb55Udub1Sz3I5DYV/Q==
X-Received: by 2002:a17:902:d2cb:b0:19a:ad90:4223 with SMTP id n11-20020a170902d2cb00b0019aad904223mr660008plc.48.1676829523868;
        Sun, 19 Feb 2023 09:58:43 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902744800b0019a8468cbe7sm18392plt.224.2023.02.19.09.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 09:58:43 -0800 (PST)
Date:   Sun, 19 Feb 2023 17:58:40 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v2 2/7] KVM: selftests: x86: Fix an error in comment of
 amx_test
Message-ID: <Y/JjUEiIizj98hZb@google.com>
References: <20230214184606.510551-1-mizhang@google.com>
 <20230214184606.510551-3-mizhang@google.com>
 <Y/Hh31GLftx3eZJY@gao-cwp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/Hh31GLftx3eZJY@gao-cwp>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Feb 19, 2023, Chao Gao wrote:
> On Tue, Feb 14, 2023 at 06:46:01PM +0000, Mingwei Zhang wrote:
> >After the execution of __tilerelease(), AMX component will be in INIT
> >state. Therefore, execution of XSAVEC saving the AMX state into memory will
> >cause the xstate_bv[18] cleared in xheader. However, the xcomp_bv[18] will
> >remain set. Fix the error in comment. Also, update xsavec() to XSAVEC
> >because xcomp_bv[18] is set due to the instruction, not the function.
> >Finally, use XTILEDATA instead 'bit 18' in comments.
> >
> >Cc: Jim Mattson <jmattson@google.com>
> >Cc: Venkatesh Srinivas <venkateshs@google.com>
> >Cc: Aaron Lewis <aaronlewis@google.com>
> >Signed-off-by: Mingwei Zhang <mizhang@google.com>
> >---
> > tools/testing/selftests/kvm/x86_64/amx_test.c | 5 ++++-
> > 1 file changed, 4 insertions(+), 1 deletion(-)
> >
> >diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
> >index d506821a5a26..aac727ff7cf8 100644
> >--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
> >+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
> >@@ -190,7 +190,10 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
> > 	GUEST_SYNC(4);
> > 	__tilerelease();
> > 	GUEST_SYNC(5);
> >-	/* bit 18 not in the XCOMP_BV after xsavec() */
> >+	/*
> >+	 * After XSAVEC, XTILEDATA is cleared in the xstate_bv but is set in
> >+	 * the xcomp_bv.
> >+	 */
> > 	xstate->header.xstate_bv = XFEATURE_MASK_XTILEDATA;
> > 	__xsavec(xstate, XFEATURE_MASK_XTILEDATA);
> > 	GUEST_ASSERT(!(xstate->header.xstate_bv & XFEATURE_MASK_XTILEDATA));
> 
> maybe it would be better to add another GUEST_ASSERT() to enforce that
> XTILEDATA is set in the xcomp_bv.

yeah. The check has been added in the 6th patch of the series, but I
think it is hard to see. I will reorder the change next to this one in
the next version.
> 
> >-- 
> >2.39.1.581.gbfd45094c4-goog
> >
