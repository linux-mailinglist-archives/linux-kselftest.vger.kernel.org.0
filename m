Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E8551AE94
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 21:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356211AbiEDUCn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 16:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377838AbiEDUCa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 16:02:30 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CD74EDFC
        for <linux-kselftest@vger.kernel.org>; Wed,  4 May 2022 12:58:47 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id y11so1559529ilp.4
        for <linux-kselftest@vger.kernel.org>; Wed, 04 May 2022 12:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GsfXoNKONKDKWhJHjg7OT8XgANJP2e9G7Mc1nVY0AYE=;
        b=Aq1U8sdb7NiZVJWC4vUlChWXOfRbCGaFNjbSpc0WleExMf0SKkQUNrsAlYXljTlC8V
         kIwakMFlClmc4+G6Yl7CQ/45/9xgObIBveZ7BjUWWP3+FAaW4C1aJyJALPCVD9lXJc+x
         YJ++0U3IX23F9PeoHw9+6HPC3HlHHljxhgJrbOn5aAgZau7Q6TShdWIkw27qEr4r1db0
         ySclaROjZ8pxDb8YfChQRlCjxbFar+IhUVYKk3BD08+hVk5gdraFe163Ypca8nO0QyxZ
         DsoFqtJh0sAijvTR6s7QSXKCKou0s4gdKPXNW/z/rGUII4CS32K7EojcLfa8YVJI1oAs
         x6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GsfXoNKONKDKWhJHjg7OT8XgANJP2e9G7Mc1nVY0AYE=;
        b=QS9a2/JiPFZiBWcLxx4RpLI4I1DAVl7O/UPkrz8IOcnps2pq3GJv+WbCSmYT6tPDGy
         KwileYaCl/2R6lxZnuFvqEceHjw9/e/hnTAsgdN4wKM2whONvIYLZjz6Y0evE44OBhZi
         S9Od/XACzyN5lSaTNFnvp+FfcdodWD4Xq/BdfI6jBaudmlvH4j18Ux26JrPGzVzG+BD2
         pk00Z3l4WSPBjz+5zGh/iGftsOPfbRGdQgXVK7rQK9IHt+SaaS/tjRTL3YaEmmjeWjgw
         Oj4H3kYTEJdMjFphNpQ6puLmp46pVf6t5YCS7UbXuyj12b1Gl/rP8nQVkGqpmeHoH31K
         6NVg==
X-Gm-Message-State: AOAM531+1bU95g0176BZc1Oo97P0LK/71afXb6bDYOo9DhHVsCCMpfOP
        x9o7KR03Xi6VQ1mv5scQvmEIiQ==
X-Google-Smtp-Source: ABdhPJy5Bzj+uvdC2D+9IucvrmZ0XZi+3AvPJbXcQc72eVCSrPti9fdcCscTtD01OvFKOzl/PHzgiQ==
X-Received: by 2002:a05:6e02:164f:b0:2cf:3244:665d with SMTP id v15-20020a056e02164f00b002cf3244665dmr4183126ilu.170.1651694326903;
        Wed, 04 May 2022 12:58:46 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id t13-20020a02ccad000000b0032b3a7817afsm4928792jap.115.2022.05.04.12.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 12:58:46 -0700 (PDT)
Date:   Wed, 4 May 2022 19:58:42 +0000
From:   Oliver Upton <oupton@google.com>
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: KVM: aarch64: Let hypercalls use UAPI
 *_BIT_COUNT
Message-ID: <YnLa8uH55/epyjlS@google.com>
References: <20220504184415.1905224-1-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504184415.1905224-1-rananta@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Raghavendra,

On Wed, May 04, 2022 at 06:44:15PM +0000, Raghavendra Rao Ananta wrote:
> The hypercalls test currently defines its own *_BMAP_BIT_MAX macros to
> define the last valid feature bit for each bitmap firmware register.
> However, since these definitions are already present in the uapi header,
> kvm.h, as *_BMAP_BIT_COUNT, and would help to keep the test updated as
> features grow, use these instead.

LOL, looks like I lost that one in the end! Still, the fact that you're
patching the selftest highlights the fact that there is a nonzero chance
of userspace using this value incorrectly expecting it to hold true
across all kernels.

Since this is the route going forward can we please consider documenting
the fact that _BIT_COUNT *will* change and is not stable between kernel
versions. Bad UAPI expectations could throw a wrench into this entire
plan we've hatched for preserving hypercall ABI.

Just a warning at the end of the register documentation would suffice.

> No functional change intended.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>

Besides considering the above hazard:

Reviewed-by: Oliver Upton <oupton@google.com>
