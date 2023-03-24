Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E14C6C8732
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 22:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjCXVBf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 17:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjCXVBc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 17:01:32 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B70565BA
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 14:01:31 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o89-20020a17090a0a6200b0023b3d3acdd6so2774169pjo.3
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 14:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679691690;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+zOOneOFLIEndB0CaMZppbvCkI9DMigdeXvFf960HGc=;
        b=DBrG46jF5N5QUcNdULafJQFP5GGayusEYUPFk9Vgnz0YFPDF95lhoyPFW8salbhzdS
         +R6h4IrXJwd5ofKZtEAdsXEK1krwoWNFMCBsqT5kDLj248ffs++pioyVKakumzNh83zv
         yY1TCGufB4j1WlgvwrdG5SIg1fimMazNsirhjNiw6pMpiBxaQ7J8+WRBcUAs2qPbW65u
         I2g8p/bmoU+5ev06McxbEYcYAbSQvWyuiZPPz+oBXZBG6UafA/sLfRXmSTJMvy/S/QoN
         TEmvZkxunK+jOV7vlQybEcBb77VxQ1GOBoN7PlDHVpzYA8xxcukwJg4abdvzC8uiMG+u
         PWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679691690;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zOOneOFLIEndB0CaMZppbvCkI9DMigdeXvFf960HGc=;
        b=yDJuo9wpFDJXvT9/06fZLYKAV/6Gn5vRhCB4CPhN7OBfqMJG2dGsJFGNySmX3Hurss
         BGMX+4PxfHSguMHU4B7CKJxagdMPRL+F8wnshTEQjo4aPRPTQPf0MpxpCERomRBTFUtC
         tYBcmJPCwLqn2PQuZIogQTJxTqoqoKvUP3+pKE0XPb4sVP4fOELVtcLBnf391rKVRweT
         ZBEDWjSKepqdF0SRKLHgFXRK6mIYBcvRnEWTsGSY0wqqEvJk7xycts/pK75MOVuv6MOR
         09JqzQoy5Ec1fQCT9q/z2LZ6dBeAf5Jp06bsDZMghsW7EiZWlclKmnwwJA56s7yMAQqa
         AFgg==
X-Gm-Message-State: AAQBX9ekFvBKH3o3/XuC5U2nuwqPhDo0qYJIkyURjoA9PBgMBgd7RhPh
        ZJYSfkUpP25xp4Or1JekGaXQ0XJkeH0=
X-Google-Smtp-Source: AK7set9Rm6CmQtks4lEbZl89dC5jxvPJ26vVglAmeH9PelTnMaqe8gOX2ZnX/wXOUSwRTc6AmMPwBZ9VXjo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1a0b:b0:625:4ff8:3505 with SMTP id
 g11-20020a056a001a0b00b006254ff83505mr2371606pfv.1.1679691690661; Fri, 24 Mar
 2023 14:01:30 -0700 (PDT)
Date:   Fri, 24 Mar 2023 21:01:29 +0000
In-Reply-To: <167969137429.2756469.2347841728687804486.b4-ty@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com> <167969137429.2756469.2347841728687804486.b4-ty@google.com>
Message-ID: <ZB4PqcsZlE8cOo0C@google.com>
Subject: Re: [PATCH v3 00/13] Overhauling amx_test
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mingwei Zhang <mizhang@google.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 24, 2023, Sean Christopherson wrote:
> On Tue, 21 Feb 2023 16:36:42 +0000, Mingwei Zhang wrote:
> > In this version, I have integrated Aaron's changes to the amx_test. In
> > addition, we also integrated one fix patch for a kernel warning due to
> > xsave address issue.
> > 
> > Patch 1:
> > Fix a host FPU kernel warning due to missing XTILEDATA in xinit.
> > 
> > [...]
> 
> Applied everything except patch 7 to kvm-x86 selftests.  Please holler if I
> missed something subtle about patch 7 (using & vs. ==).  This is at the head
> of kvm-x86/selftests, i.e. I can fix it up if necessary.
> 
> [01/13] x86/fpu/xstate: Avoid getting xstate address of init_fpstate if fpstate contains the component
>         (no commit info)

*sigh*  And by "everything" I meant "all of the selftests patches".
