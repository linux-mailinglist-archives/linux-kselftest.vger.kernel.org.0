Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E596C86FA
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 21:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjCXUnr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 16:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjCXUnq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 16:43:46 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EC85B88
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 13:43:45 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id l14-20020a170902f68e00b001a1a9a1d326so1788356plg.9
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 13:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679690625;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g9FsH5f+Xb8IXPDsf4Vq2M9YTg13c83UJ3Vl9FncU8A=;
        b=R1CJAKUEiFUCOywhblEqKTuQ5/frQjfKCPjzY4EmGXnG/FZ8Mvl74UQXykJLT4izLW
         AC8Ga8LOADJ9jErvWBObdzLpjfKSPgoezDRFEkJI+4xJ5sSwPLpjJcb7SsFf/JZedd4g
         M44BNIsx8ZTxhshB1B0CI0siKLtgDNfkPvGG7N2Ltv9n6WO9Z8elgJ+MiA3TfoJh/lXb
         JHYrBxc46scu7edRhrqSNAK8P2K7QTVZz49wi6pdGRicPOuhFPDwlgc/Y5+QUUx66s4L
         q6FLJj9urtUdO4i5coFLMS/Q3yDAjLJmSNap9VFNAx4RPAoZXofFgNlMgFXkC48AVw93
         jQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679690625;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9FsH5f+Xb8IXPDsf4Vq2M9YTg13c83UJ3Vl9FncU8A=;
        b=Tdk4Tda+Ho5Zyj9NNqBUFf0k3FUJ+NYr3S+bqnRsq/X5EUz6X+LfJ50kcfZ2YZ0Mwh
         /TFP8Vdn3z3KbiQ9ZZRiHILWgYdcGuH1zQO7Hta5F/KXg5pf1KP0F54k6zn9kUBPp/fm
         gzZH2OeC3UrDXyOM4vkBRtRc7cwvJT5anqX5vem78clFGSigoCqhn5BfiYiPodtU8uEX
         0xWFCEOc2FFtoEXtlfFwoLUxyqasn2VAzNkmukLAnfMzGZfMgmgg4HPn2GdkoGifc5N7
         dYginabFmhJr5bTw8kHhQLlIh7fFtMndTs7zySpTzO7vrTcD+UhH+E2Urb/rU9k/4HhU
         Ys1w==
X-Gm-Message-State: AAQBX9eudlPXX7qqBfBEkqKf6qJykeqGLEc/tZfCUFv4HDCYQXbhvv3O
        stNzpB5Weg1EmafFwAcvZsSqxrJntIY=
X-Google-Smtp-Source: AKy350Ymjfg+3M3Dv4LBikspPO3ElnhrQ/Ms1LmMDrfGv3OrehR2cc7M3jW6S4kdjDad2P2FdlyI1gKgqVo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:5141:b0:23d:50d0:4ba4 with SMTP id
 k1-20020a17090a514100b0023d50d04ba4mr1256858pjm.3.1679690624943; Fri, 24 Mar
 2023 13:43:44 -0700 (PDT)
Date:   Fri, 24 Mar 2023 13:43:43 -0700
In-Reply-To: <20230221163655.920289-12-mizhang@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com> <20230221163655.920289-12-mizhang@google.com>
Message-ID: <ZB4LfyVjDuncOsM7@google.com>
Subject: Re: [PATCH v3 11/13] KVM: selftests: x86: Remove redundant check that
 XSAVE is supported
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
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

On Tue, Feb 21, 2023, Mingwei Zhang wrote:
> From: Aaron Lewis <aaronlewis@google.com>
> 
> In amx_test, userspace requires that XSAVE is supported before running
> the test, then the guest checks that it is supported after enabling
> AMX.  Remove the redundant check in the guest that XSAVE is supported.

It's a bit paranoid, but I actually don't mind the extra check.  It's not redundant
per se, just useless in its current location.  If the check is moved _before_
CR4 is set, then it actually provides value, e.g. if something does go sideways,
will fire an assert instead of getting a #GP on set_cr4().
