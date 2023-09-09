Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7196879930D
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Sep 2023 02:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344664AbjIIAPs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 20:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343704AbjIIAPs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 20:15:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E52CE46
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Sep 2023 17:15:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7b9eb73dcdso2366252276.0
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Sep 2023 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694218542; x=1694823342; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=duTiommV4wRLXU9fXYKi68EXY965Pe9kyNHOVuE7lAE=;
        b=IsBEP4bomsq2q0ScihmwzzZ/w5M0rIoVM6GYSqLbVVKr2s9O8ccKFdm8mPwqQmgAWt
         zY2crjfKBS8EkbtWBPTH6yEpDOj9SvGBKLmwK5TWgYfgDUxMN3JMMos+RaIvlzyE2AtR
         WAZdAlLZS81BqtlBYAax+zZi2jllP9TL8mxRLatYbCUVvJCljpEJC4/5qcJ7jIVYaiGz
         gQpPTmXHF3j6ZfeH08Xr1K9fecQK3AWeiVdyhA1tgzad/osVZvvTIkPlJDxPDjxd/thb
         /KFtzhluJV3F8W0/LVvDIQfDPH7ykZT4AUWBjBT1fhu7vYv8xkyXB0LaRl0mpEXTJofk
         0nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694218542; x=1694823342;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=duTiommV4wRLXU9fXYKi68EXY965Pe9kyNHOVuE7lAE=;
        b=APfe4FQyEr1kWQL5ODM+iNDx3swcQtMB5YUODRm3Qx9GupKOVLntq6GsXogScnteZx
         7C5sL5k9sTgyo/M8cDuOcxjRMnrYsCyoZjH5iOQj3ibFLSNEWweYUmY7hTiDRH7tlnbW
         PDOM39BopPC2XSxONS56LyvbWnyytrOxjo5BhQ51HB6Vn8qwV6yzAOdrP//1PdINGRHL
         S93FP0WLsUpau+clBa75ZOwzIn5M18v7MPrNiBzgOStIu62y/IBwzmdP7qBe3BjfmecL
         XbETjhPyQR56JA/LiiUX/dgeF8k8SJT6HuBw+O3yQ/HvF5rro8fyfMCaA5X8YzTG6tLh
         AMqQ==
X-Gm-Message-State: AOJu0YznrwC4J/UUAohU00mKRbKCM/mNNML4ks94RL0UHARwvNp4vw8U
        zKnmTQ1+oOOv0ZFXB+fE2GvSqYsIZwk=
X-Google-Smtp-Source: AGHT+IFG9zFrL0+cWVhbTJWR1ZSxntCJRoVGsdC1oHU8sVjjKFd4JL2NtbwkPyCFC8lKPTHXLt7ietThG3s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ac02:0:b0:d7f:f3e:74ab with SMTP id
 w2-20020a25ac02000000b00d7f0f3e74abmr90874ybi.1.1694218542725; Fri, 08 Sep
 2023 17:15:42 -0700 (PDT)
Date:   Fri,  8 Sep 2023 17:15:31 -0700
In-Reply-To: <20230825001729.1952858-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230825001729.1952858-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <169421600030.98653.16406301904284107961.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: selftests: Add tests - invalid inputs for KVM_CREATE_GUEST_MEMFD
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com,
        tglx@linutronix.de, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Ackerley Tng <ackerleytng@google.com>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, andrew.jones@linux.dev,
        ricarkol@google.com, chao.p.peng@linux.intel.com, tabba@google.com,
        jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        vannapurve@google.com, erdemaktas@google.com,
        mail@maciej.szmigiero.name, vbabka@suse.cz, david@redhat.com,
        qperret@google.com, michael.roth@amd.com, wei.w.wang@intel.com,
        liam.merwick@oracle.com, isaku.yamahata@gmail.com,
        kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 25 Aug 2023 00:17:29 +0000, Ackerley Tng wrote:
> Test that invalid inputs for KVM_CREATE_GUEST_MEMFD, such as
> non-page-aligned page size and invalid flags, are rejected by the
> KVM_CREATE_GUEST_MEMFD with EINVAL
> 
> 

Applied to kvm-x86 guest_memfd, thanks!

[1/1] KVM: selftests: Add tests - invalid inputs for KVM_CREATE_GUEST_MEMFD
      https://github.com/kvm-x86/linux/commit/a5accd8596fa

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
