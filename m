Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DD16489D8
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Dec 2022 22:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiLIVDz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Dec 2022 16:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiLIVDu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Dec 2022 16:03:50 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4DAB079E
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Dec 2022 13:03:49 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id m4so6155643pls.4
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Dec 2022 13:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HqhkVKX+RdgYCWZiIceLsOHMpWv/ROuczp7qb/H7X1w=;
        b=geRGPSQKUlIYqCU/v/MAful0c2VKh6VA6SBeijyPLtHNmaNPvdTAZRBm+8BK0vMyF7
         oJs/xaNz1FVL8jiMpUauu2wtzHgyNFuSzbsou1/FkQDUTY5R2F/BqoUtLcz7XXJd3ZAO
         Dmk3W82U//fL1/HxmzzBDyZ7VklM1UH74NpwkG3WyTvUXcSDELZRwL14XyE4yxNMMTiP
         7vxNfdzUPeKjtlkEpdgj2U13i8nATEgPias3k43ZtZwrU5RjHtwlN5SiT1tERKN6A3Rk
         WNJjSbXl0byXigqUqjfuCWVXto0wnqtwZ9BO4n+XScjq16D9RNXVrELTuGdILxKMMIaA
         6JaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqhkVKX+RdgYCWZiIceLsOHMpWv/ROuczp7qb/H7X1w=;
        b=7YOLWb3UxYt68N5oKeey7y4Usgje+iEzZ8CwW6uV2klqRvlXusChYKPsEfsSgBMHLx
         qpQ7U5vQtYMMfKvCgCA39GxGhJ80Fxq9VzSE1zP7NVFf++vlkPrx4LNP9mnkBArfObTg
         MbCes3KLQP2dn23TIdl1WhXaNtiKoJHjPR5vvFh5c5Tar9aMUfm1mXbQWSrIpcVr8thV
         6cWOUmjD7tw5vtbh4qok9XdcPpjJxclyyO1bts6Q1xOHcO1rbkA/DTlxerP7Fs5OuV5l
         G/cEDb1YzfTAAGjrWx/ft+tK+b91gJhQfxSJh+CA5O/gnHauuogW4hHZr63mQpTsPuXk
         041g==
X-Gm-Message-State: ANoB5pnjl/nCsL20VklwjMZMvtC26n/lF+NgC7RUrlNeCCFTE2BHal1e
        zQF4Mjrg/05vpbjXJybpb+zLYA==
X-Google-Smtp-Source: AA0mqf76S2APEPIqvhNO2xeCJ5k7zOJZF0cOVyP09wKMa17nX0r0d7TDym1CMnQt7VgOPeLCqe8Uuw==
X-Received: by 2002:a05:6a20:7f5c:b0:9d:b8e6:d8e5 with SMTP id e28-20020a056a207f5c00b0009db8e6d8e5mr24495pzk.2.1670619828811;
        Fri, 09 Dec 2022 13:03:48 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id c11-20020a170903234b00b001885041d7b8sm1722515plh.293.2022.12.09.13.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 13:03:48 -0800 (PST)
Date:   Fri, 9 Dec 2022 21:03:45 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <andrew.jones@linux.dev>,
        Peter Gonda <pgonda@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        Ricardo Koller <ricarkol@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] KVM: selftests: Avoid infinite loop if
 ucall_alloc() fails
Message-ID: <Y5OisdH5ohtr6r3j@google.com>
References: <20221209015307.1781352-1-oliver.upton@linux.dev>
 <20221209015307.1781352-8-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209015307.1781352-8-oliver.upton@linux.dev>
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

On Fri, Dec 09, 2022, Oliver Upton wrote:
> Guest assertions depend on successfully allocating a ucall structure. As
> such, the use of guest assertions when ucall_alloc() fails simply leads
> to an infinite loop in guest code.
> 
> Use GUEST_UCALL_NONE() to indicate failure instead. Though not
> technically necessary, use a goto to have a single callsite and an
> associated comment about why assertions don't work here. It isn't
> perfect, at least the poor developer gets some signal out of the
> guest...
> 
> Fixes: 426729b2cf2e ("KVM: selftests: Add ucall pool based implementation")
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---
>  tools/testing/selftests/kvm/lib/ucall_common.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
> index 0cc0971ce60e..e8370da3de24 100644
> --- a/tools/testing/selftests/kvm/lib/ucall_common.c
> +++ b/tools/testing/selftests/kvm/lib/ucall_common.c
> @@ -41,7 +41,8 @@ static struct ucall *ucall_alloc(void)
>  	struct ucall *uc;
>  	int i;
>  
> -	GUEST_ASSERT(ucall_pool);
> +	if (!ucall_pool)
> +		goto out;
>  
>  	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
>  		if (!test_and_set_bit(i, ucall_pool->in_use)) {
> @@ -51,7 +52,14 @@ static struct ucall *ucall_alloc(void)
>  		}
>  	}
>  
> -	GUEST_ASSERT(0);
> +out:
> +	/*
> +	 * If the guest cannot grab a ucall structure from the pool then the
> +	 * only option to get out to userspace is a bare ucall. This is probably
> +	 * a good time to mention that guest assertions depend on ucalls with
> +	 * arguments too.
> +	 */
> +	GUEST_UCALL_NONE();

UCALL_NONE isn't much better than infinite stack recursion, e.g. a test might end
up passing by dumb luck, or go in the wrong direction because it sometimes handles
UCALL_NONE.

How about this?

From: Sean Christopherson <seanjc@google.com>
Date: Fri, 9 Dec 2022 12:55:44 -0800
Subject: [PATCH] KVM: selftests: Use magic value to signal ucall_alloc()
 failure

Use a magic value to signal a ucall_alloc() failure instead of simply
doing GUEST_ASSERT().  GUEST_ASSERT() relies on ucall_alloc() and so a
failure puts the guest into an infinite loop.

Use -1 as the magic value, as a real ucall struct should never wrap.

Reported-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/ucall_common.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
index 0cc0971ce60e..2f0e2ea941cc 100644
--- a/tools/testing/selftests/kvm/lib/ucall_common.c
+++ b/tools/testing/selftests/kvm/lib/ucall_common.c
@@ -4,6 +4,8 @@
 #include "linux/bitmap.h"
 #include "linux/atomic.h"
 
+#define GUEST_UCALL_FAILED -1
+
 struct ucall_header {
 	DECLARE_BITMAP(in_use, KVM_MAX_VCPUS);
 	struct ucall ucalls[KVM_MAX_VCPUS];
@@ -41,7 +43,8 @@ static struct ucall *ucall_alloc(void)
 	struct ucall *uc;
 	int i;
 
-	GUEST_ASSERT(ucall_pool);
+	if (!ucall_pool)
+		goto ucall_failed;
 
 	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
 		if (!test_and_set_bit(i, ucall_pool->in_use)) {
@@ -51,7 +54,13 @@ static struct ucall *ucall_alloc(void)
 		}
 	}
 
-	GUEST_ASSERT(0);
+ucall_failed:
+	/*
+	 * If the vCPU cannot grab a ucall structure, make a bare ucall with a
+	 * magic value to signal to get_ucall() that things went sideways.
+	 * GUEST_ASSERT() depends on ucall_alloc() and so cannot be used here.
+	 */
+	ucall_arch_do_ucall(GUEST_UCALL_FAILED);
 	return NULL;
 }
 
@@ -93,6 +102,9 @@ uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
 
 	addr = ucall_arch_get_ucall(vcpu);
 	if (addr) {
+		TEST_ASSERT(addr != (void *)GUEST_UCALL_FAILED,
+			    "Guest failed to allocate ucall struct");
+
 		memcpy(uc, addr, sizeof(*uc));
 		vcpu_run_complete_io(vcpu);
 	} else {

base-commit: dc2efbe4813e0dc4368779bc36c5f0e636cb8eb2
-- 

