Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B23C68F447
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 18:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjBHRVI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 12:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjBHRVH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 12:21:07 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1FD5580
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Feb 2023 09:21:05 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u9so15792042plf.3
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Feb 2023 09:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SevCBdyXjXvSH4omRiXD/fDq6ifdvqidYsrVMN1iQlw=;
        b=DC8QtD2YeXVbofL1K3rriL4INGSEPrOdo5/LyTggPWJecHfKLNO2cbXvqTZcYICYrw
         Yp2J3Sn9GgPgr6pNSnRFbQxSctJ3Ef45hs0Pt3t7byi6cW//9dv8G9ZfDza2POogaen4
         GabQQGBKfFP/oKhORM4XJCAmHYuI7GNu2svUiCa618/OMPP7GM4jkwd/QyMA4DF1vwxJ
         +BqnfMSMOiG4d+5MOsvTdDH2AXICwcNCXKplinbkmHGLZr5U4xavxdBheUCoQV94kl1V
         kGoK6btiuaS8T3dzFH2BLyHgqwttiODVoeOLegb74SUJkEuOM303rPiV1EW8b9MRuS/i
         Ialw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SevCBdyXjXvSH4omRiXD/fDq6ifdvqidYsrVMN1iQlw=;
        b=mvga/DxRkqCxbM6YDxPaqe17CEIHOP/XvCa8tqBsduDBf+vjTO6SmYZAP26Ud02E7E
         8s/0Jhr0h/lDDE/cD+mZO8TGkIGiBtg1piknQj9vp2myxZxjc3F5OhtwONTA91RPbEwO
         Q72jgTO0q9fLKQxxNWKfsNQbLATCSAS6rd+AgBF5IMuNzX7/EEUFMlJ9X8uKM+/zyoHe
         qYMvcKLPgh+EwCqab6a6cdv/JSH+LGcJ/ys90xz4moAckQ6jrtv5UjXxXMaOGUivkwUK
         H/7DPXMwD8UEl7O8ZWTUrf9RpnlWAAkis9WRIONANZgYyHxZ9JbarC381n10OpMNhUsP
         dFXQ==
X-Gm-Message-State: AO0yUKUBUKHcB633DP3Ve1VpxoYWkgkuwVKRqACCOcE+hD80IQR1x0pR
        g0TnTexIjDCtG18EJ43b9ONy+A==
X-Google-Smtp-Source: AK7set96+zJFQcJ6GKkd7AtudNHL9Hq/NXwLqLQqeOJ2xGUtA3yeXDV/yCXAW7bbSZe4ZAoACokjmA==
X-Received: by 2002:a17:903:330f:b0:198:af4f:de12 with SMTP id jk15-20020a170903330f00b00198af4fde12mr283390plb.18.1675876865274;
        Wed, 08 Feb 2023 09:21:05 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id h38-20020a631226000000b004fb10399da2sm3447480pgl.56.2023.02.08.09.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 09:21:04 -0800 (PST)
Date:   Wed, 8 Feb 2023 17:21:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kevin Cheng <chengkev@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] KVM: selftests: Added eBPF program and selftest to
 collect vmx exit stat
Message-ID: <Y+PZ/a9O7KgXdRf1@google.com>
References: <20230126004346.4101944-1-chengkev@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126004346.4101944-1-chengkev@google.com>
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

On Thu, Jan 26, 2023, Kevin Cheng wrote:
> diff --git a/tools/testing/selftests/kvm/kvm_vmx_exit_ebpf_kern.c b/tools/testing/selftests/kvm/kvm_vmx_exit_ebpf_kern.c
> new file mode 100644
> index 000000000000..b9c076f93171
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/kvm_vmx_exit_ebpf_kern.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/bpf.h>
> +#include <stdint.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>
> +
> +struct kvm_vcpu {
> +	int vcpu_id;
> +};
> +
> +struct vmx_args {
> +	__u64 pad;
> +	unsigned int exit_reason;
> +	__u32 isa;
> +	struct kvm_vcpu *vcpu;
> +};
> +
> +struct stats_map_key {
> +	__u32 pid;
> +	__u32 vcpu_id;
> +	__u32 exit_reason;
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, 1024);
> +	__type(key, struct stats_map_key);
> +	__type(value, int);
> +} vmx_exit_map SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, 1);
> +	__type(key, __u32);
> +	__type(value, __u32);
> +} pid_map SEC(".maps");

Can you add comments to explain why maps are used?  From our internal discussions,
I think I know the answer, but it would be super helpful for others (and me) to
explain exactly what this code is doing, and more importantly, why.
