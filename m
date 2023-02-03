Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F4E68A222
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 19:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjBCSlh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 13:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjBCSld (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 13:41:33 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40597A9D4D
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Feb 2023 10:41:32 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b5so6152864plz.5
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Feb 2023 10:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cn1ilt9CXu68kWVudz6MPv9G5X8jU8YjMqpSgc7Tn+g=;
        b=XVRfE7KZ96kUXnbwCAulTyZIfAPDcnownBSqk5Y3zjOlf0JvaGsecZQGPfFDEgYxzn
         /Vu/Ya3+pG8qgiG9wXNTWTNynt0NglLqATwLeLvan97Q6holYvnf3ZPq8UQiLpsaPv2V
         KeMLowFsRoKXEhCKwj09qOPIdbTjcL7+c+TMxbdSTKNR3RQFCNk6/g6nKXygjDkgFSjz
         PAN9X9glsEwV2LfuR5xGUIti8PaJDvsvznqtWyBIbODEaJkLgo6limUqFgvZ9Y+TVFJh
         gjg7SrN+FgksbwX2zYaP3j630WE0s5pStFCC1d8OsxgxVSofeRXg1Ir14LGkeUzhAWZH
         2X9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cn1ilt9CXu68kWVudz6MPv9G5X8jU8YjMqpSgc7Tn+g=;
        b=2B+X5dftA3Y6d7jw+dSPdbCg3LPZRvQOtzFqqTQK0zDG87jfKhO/UMrIm0xRfrmpSR
         dlrYJu69G9MGnJDgXwgTQIwZ2iOclBHyMhFPBhur16wnlDjt1qdp1ADjD60p6QZtaw3p
         utfEz0cXrGwzHoLgdROw1XP/YKFYMXhBXTtfLOUch9ZfpHUixse2SDIKuHrZ3ZWagyVs
         gGqv1V2+SR2b2KP3+Ye0rx6dLVJ5G3q6xTvv7wxXEPou86LroYTypPXu+RCkWlWseD3K
         HFFx1Lqf2iaWCU9FMnQdtbOhkTrsnPpcv24Rj6f4Q9qhjvkNdfamzVZPvAHai0XNWJtI
         fSFw==
X-Gm-Message-State: AO0yUKVXOiqaF3gzgwkBWM9sYZOVHyDeY2eBU4l88nMPc4f3rF4SziQB
        B6W6jw9KsunCRMbFTJjeon3SYA==
X-Google-Smtp-Source: AK7set81ndZ6iqL6SCLrZ4yXsjNr0LajPm5EI4Bs27dAno1HwoKfEuLTFYxjXvbxcfsUY/E3yzW2Zw==
X-Received: by 2002:a17:903:210d:b0:198:af4f:de0a with SMTP id o13-20020a170903210d00b00198af4fde0amr10312ple.10.1675449691546;
        Fri, 03 Feb 2023 10:41:31 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id e15-20020a63ae4f000000b004f06ccd76bcsm1793496pgp.70.2023.02.03.10.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 10:41:31 -0800 (PST)
Date:   Fri, 3 Feb 2023 18:41:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     shahuang@redhat.com
Cc:     kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        David Matlack <dmatlack@google.com>,
        "moderated list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.linux.dev>,
        "moderated list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: selftests: Remove redundant setbuf()
Message-ID: <Y91VV+WWrakREsN6@google.com>
References: <20230203061038.277655-1-shahuang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203061038.277655-1-shahuang@redhat.com>
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

On Fri, Feb 03, 2023, shahuang@redhat.com wrote:
> From: Shaoqin Huang <shahuang@redhat.com>
> 
> Since setbuf(stdout, NULL) has been called in kvm_util.c with
> __attribute((constructor)). Selftests no need to setup it in their own
> code.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>

Oliver/Marc, want to grab this one?  I doubt there will be conflicts, but IIRC
there are a handful of in-flight changes for aarch64/page_fault_test.c.
