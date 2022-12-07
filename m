Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641B964654F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Dec 2022 00:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiLGXo7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 18:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiLGXo6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 18:44:58 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986368B185
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Dec 2022 15:44:54 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d3so18545797plr.10
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Dec 2022 15:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6iCaSQa1HFCfJ8+bX1upEoM6MTaIn0UmKgjdPtgAjjc=;
        b=KkMIutKijaPJLWWpORIH3M7DoEIXJXVArWkiJXMSz8T5xYL8iAo5sVXEy6sqiKL4Q6
         GzONfdpncDOio5lHMt6K32MFchEpLDDS74m0k84wySF8/xUSWPDlRO2qHTFx5CJMTPXs
         Pz6umlCMMEx5buAmxJt9/iKpq4sAYZrlfHRHXCB8Qi05gvNYWM87iJwBVi1GJFkHaJdf
         ee9nlI6HgLtZD0zr9k1FZwi8siSZ1tDbxVjExGf5o7x44QyiPbec1tbcxkvIpEzPWM9t
         c8szkfNSqQIk+eipVkW44sLAkuj6/o8y3vDsWwtHW9Cp/VMEqkIeC4CwH84SP4Y+4+N9
         mnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iCaSQa1HFCfJ8+bX1upEoM6MTaIn0UmKgjdPtgAjjc=;
        b=KclmHklTZExpXA1n1PteJmnXjw0uwrDn5Y+uJHPucH9ERNCVHtQ4pGr87ch/6jr63U
         GUONa0NhJ2lMoAFHL/Jeu/P6CYhVcKAZ8rny1frx7b59wH1yC6vUxXfocbeRKwfLdtlI
         GDwxjxWflKhLB7gKuy+j/CiOAJ/YzO25mChzkJ5tjrPWzEVVfoQYnwRACfV09oMnqikk
         Isx5m/+QXDztVSY8QoX3mP+B2+hK0TJKNXAoWAmhgws1tK7R/jsXnmksQblKX4fYuzMR
         zWgDFtksl5SdQXBLshs2DHidVfaZXcDYueIedm/me1/1rkAlFTBCQOca5XXjCcHvvqlV
         ZIRQ==
X-Gm-Message-State: ANoB5pmyxAMod/pWZtVQ6WBw4eFjiMCNt29eHJ4OI6/gpWbKsPmkz9JM
        6tf8cZ6doOchMrQgY1F7jC/qZg==
X-Google-Smtp-Source: AA0mqf5f+HSDTe/eFvdYT1KQV50ny+OsSgkb0jaUxxexfrGcapWSrpNJd+KINOsgbiEg2Rw5vCDanA==
X-Received: by 2002:a17:90a:55c2:b0:219:f970:5119 with SMTP id o2-20020a17090a55c200b00219f9705119mr590148pjm.1.1670456693817;
        Wed, 07 Dec 2022 15:44:53 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id w10-20020a170902e88a00b001868ed86a95sm15155465plg.174.2022.12.07.15.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 15:44:53 -0800 (PST)
Date:   Wed, 7 Dec 2022 23:44:50 +0000
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
Subject: Re: [PATCH 4/4] KVM: selftests: Allocate ucall pool from
 MEM_REGION_DATA
Message-ID: <Y5ElcibE2CubONgm@google.com>
References: <20221207214809.489070-1-oliver.upton@linux.dev>
 <20221207214809.489070-5-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207214809.489070-5-oliver.upton@linux.dev>
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

On Wed, Dec 07, 2022, Oliver Upton wrote:
> MEM_REGION_TEST_DATA is meant to hold data explicitly used by a
> selftest, not implicit allocations due to the selftests infrastructure.
> Allocate the ucall pool from MEM_REGION_DATA much like the rest of the
> selftests library allocations.
> 
> Fixes: 426729b2cf2e ("KVM: selftests: Add ucall pool based implementation")

Not that it really matters because no one will backport this verbatim, but this
is the wrong commit to blame.  As of commit 426729b2cf2e, MEM_REGION_DATA does not
exist.  And similarly, the common ucall code didn't exist when Ricardo's series
introduced MEM_REGION_DATA.

  $ git show 426729b2cf2e:tools/testing/selftests/kvm/include/kvm_util_base.h | grep MEM_REGION_DATA
  $ git show 290c5b54012b7:tools/testing/selftests/kvm/lib/ucall_common.c
  fatal: path 'tools/testing/selftests/kvm/lib/ucall_common.c' exists on disk, but not in '290c5b54012b7'

The commit where the two collided is:

Fixes: cc7544101eec ("Merge tag 'kvmarm-6.2' of https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD")

> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---

Fixes nit aside,

Reviewed-by: Sean Christopherson <seanjc@google.com>
