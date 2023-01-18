Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E60B672882
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 20:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjARTg0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Jan 2023 14:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjARTgZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Jan 2023 14:36:25 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D688955B2
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jan 2023 11:36:20 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id c6so93856pls.4
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jan 2023 11:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5+aE/jbgLyJnkv72aV3jrOEHHlJGmJ+PjhB5xV4UCzk=;
        b=GCN2jAMYuwQTVADAv1EFYmNduvQA1jj291fAMgmDX/T0SU+RyyQPKVu9Bx5BpmMaSb
         vC28ufHwqnWNPN2aJ9uaBEUQ4GI/uVx7LT9u+ZeYuz/j+w3j/Fxzsyiug/rdAe6mV2T7
         8OIF91zT0wuh1C7H5G2bxgsM7mbRti+y02kSY7uEWV/XGBIjkyWDJrCBJemnzT7mjzlb
         M7M6Xgu4ku9gSyZ2TNo9me37M8IKwZbRnLel4ba03NouRVtR+IDgZdI5hmz1NZOvRqvO
         S5UuAArwp1tcn4qIV7eN3zlYtEG5nnbwEv5h3pDuJOqjmiw7Dp6jNgtG2zEVbXV5plaf
         W9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+aE/jbgLyJnkv72aV3jrOEHHlJGmJ+PjhB5xV4UCzk=;
        b=wqxLBPfwX41U44FXOVxEtxUELKBkFEX+h/YYga3xO3HcWcRSsOx3i0xt8214ZuuWSJ
         sE+Hvwe86hvobkI0ol1XdY1H7ksti4533blNNVrYZAMZZnLqvGgqFt2xUo35Aj7efTNX
         pKYSwC6Da2HoMqVRJXaszRlx2oiLL1ydU7+B5KZ/Eqz3F9MxjM2+bMljWqkkA4E5ztZp
         9Q2LxYsfJNOYlbCrwUhHYg00fTQ08TmrQanL7Fe3veiuQWe4Q5Gdd5Fus1cRgVCeF735
         yAC/vPRYsJJY4hJxY+IXjeR3iNIAXyeJrCvnpO5Ll8ZvV7xNuJ+pXwJtobyk+vIfNSHu
         bvMw==
X-Gm-Message-State: AFqh2krtNaWcj5krlj4CYQEWekLYoRCaz0cg67U7cSRXH3EBP++rKykx
        UbOdLOjTslA4ax6WEkwtXha5TQ==
X-Google-Smtp-Source: AMrXdXt9XrdT3bis8k08FAStKbp3FXpnUnp/TMuGadBbdYvSXflH210FtXvZ62HPhXf7EwE/i3i+OQ==
X-Received: by 2002:a05:6a20:a883:b0:a4:efde:2ed8 with SMTP id ca3-20020a056a20a88300b000a4efde2ed8mr2880586pzb.0.1674070580211;
        Wed, 18 Jan 2023 11:36:20 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id v15-20020aa799cf000000b0056bc5ad4862sm14139474pfi.28.2023.01.18.11.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 11:36:19 -0800 (PST)
Date:   Wed, 18 Jan 2023 19:36:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Ackerley Tng <ackerleytng@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Wei Wang <wei.w.wang@intel.com>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: selftests: Reuse kvm_setup_gdt in
 vcpu_init_descriptor_tables
Message-ID: <Y8hKMCOaZ7T3ok3E@google.com>
References: <20230114161557.499685-1-ackerleytng@google.com>
 <20230114161557.499685-3-ackerleytng@google.com>
 <Y8hCBOndYMD9zsDL@google.com>
 <CALzav=cBxddw=CsC4T-43+mT7W7jgROj2m_YodWp7bDpdQx-qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=cBxddw=CsC4T-43+mT7W7jgROj2m_YodWp7bDpdQx-qA@mail.gmail.com>
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

On Wed, Jan 18, 2023, David Matlack wrote:
> One thing to be aware of: vmx_pmu_caps_test and platform_info_test
> both relied on *not* having an IDT installed (as of Sep 2022).
> Specifically they relied on exception generating KVM_EXIT_SHUTDOWN.
> Installing an IDT causes these tests instead to hit the unhandled
> exception TEST_ASSERT().

LOL, I'm just _shocked_ that we would have such code.

> Just a heads up when you do this clean up :)

Thanks, definitely saved me some time!
