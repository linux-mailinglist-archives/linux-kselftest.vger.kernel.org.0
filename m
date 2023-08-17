Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE2177FF54
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 22:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355023AbjHQUyF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 16:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355066AbjHQUxj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 16:53:39 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2C235B1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 13:53:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58e4d2b7d16so3119727b3.0
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 13:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692305613; x=1692910413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ljybATuWSbqmcibWUndDogW5Y0plwtBc+lCyiblyYw4=;
        b=k8tkFeoESpIBm6Q+udwluVr3e5YqNzb/Lkr1Qw/uBsgo4VVePmhXbPYXE5MSh7m1eL
         Vrb1Cw1E6SlIsn16tG2KVPeFQe0CqZaEoWgphHnZctIvR2QqgQKM/vriZGPYHjtsKTym
         4jWvMHJurRfGauhrPSPtereJREILf9FysF9IpFaI64a1bfCzswV8k40D7igblL0BcvLJ
         eh4raNykfp9fzfCUKJF+5IBn69brzTsGJp8557u9IxfrLOaKFHINHoxtlPsQhtFRfeCP
         ha4o+H40uDv2raAxT7BxgClTuDxeScTCsP8xd20Yk60P/cDkYDASUats8lop3IEedyD4
         nubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692305613; x=1692910413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljybATuWSbqmcibWUndDogW5Y0plwtBc+lCyiblyYw4=;
        b=A8mRlUsAv4HED1fArluvr0Ykx3e0VmgTmAdb8qfQrQj288SeKDZIM1drJWy8Hve9Hy
         TJOKsFHoTJhon6tkXGQSElJlF6qJHQFwLwSCGOWBUgX9+lCRz8+7lpf+envaRGtd3llB
         l1Li5KckfaeLipL54pBpBUx2sBKVSDxkEhQ6+Uj1C7yU3jcG3/yzR9lTHsyyc12XWh25
         rMlWcDF17z7//2soOsIas/EQSx7onH14W/8ZCk/q+9faCq1sKJMf2h/5naKmythmY5nu
         iMoDW+cm7cgo79QUbZybX9ca+xZD6x5OPOrzrNTOFCf9Sq80MJu/jZBF6YEYCjBdYWp1
         80qQ==
X-Gm-Message-State: AOJu0Yy7laJN2vZKT0D3QTMA2B56jOfAdVX49mO+USG44+wwF6sr8qzb
        Vchsnf6yi29wf+SEI/W/iVX7e3UzJT4=
X-Google-Smtp-Source: AGHT+IFo7906WTHrxxZj9RUs2ONt+vA5DOr/hlq8cAehDvSfNTD1SHFH/KLFzVD1jYuA/jz8SvfypUDZXg4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ab54:0:b0:c6a:caf1:e601 with SMTP id
 u78-20020a25ab54000000b00c6acaf1e601mr9138ybi.13.1692305613170; Thu, 17 Aug
 2023 13:53:33 -0700 (PDT)
Date:   Thu, 17 Aug 2023 13:53:31 -0700
In-Reply-To: <20230810090945.16053-4-cloudliang@tencent.com>
Mime-Version: 1.0
References: <20230810090945.16053-1-cloudliang@tencent.com> <20230810090945.16053-4-cloudliang@tencent.com>
Message-ID: <ZN6Iy1h6wuiSDZZx@google.com>
Subject: Re: [PATCH v6 3/6] KVM: selftests: Introduce __kvm_pmu_event_filter
 to improved event filter settings
From:   Sean Christopherson <seanjc@google.com>
To:     Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 10, 2023, Jinrong Liang wrote:
> -static int run_filter_test(struct kvm_vcpu *vcpu, const uint64_t *events,
> -			   int nevents, uint32_t flags)
> +static int do_vcpu_set_pmu_event_filter(struct kvm_vcpu *vcpu,
> +					struct __kvm_pmu_event_filter *__f)

Just "set_pmu_event_filter()" please.  The "do" is pointless, and the "vcpu" part
is confusing since the filter is per-VM, the selftest just happens to pass around
the vCPU.  And to be consistent with set_pmu_single_event_filter().

No need for a new version, I'll fixup when applying.
