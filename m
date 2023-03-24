Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961456C86F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 21:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjCXUlr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 16:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjCXUlp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 16:41:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E491E292
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 13:41:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 204-20020a250fd5000000b00b6d6655dc35so2873768ybp.6
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 13:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679690500;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7c0elEDxGGtgZ98ipBv9YG9bKIImebaxGJ+PlUUC8zU=;
        b=mQ7hRAyFPVoiNHCCnDfThBXLCS64L7JF/OLnQv7tZjk2JaTturO9bNHKXpmrWQS9St
         0YKGbhmvzmtTNahzMngL7TJc7N1UFkvRccJ9YRCU21E+CMwgKiqZErYDzaxtZOoM/ISv
         5Dk3MRwB4SCrpgONU56QI0o8689QBjnxDlnBp/6dBMQMXaFBnuf7fvpLAcN5pek98WOp
         sQDwFL4K2d6G07ASWTtAILpG+Lp2PZR/B9SdmJ8UbWIUK9A5+O2Hjz5bLjYBFPBT5O5w
         5DtjxUicpxVAGsWos/+CU5RfKjBCuuq2IPM2XfagLBU5KnFhp4lrWRT9rxSZD1KtEvpI
         TCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679690500;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7c0elEDxGGtgZ98ipBv9YG9bKIImebaxGJ+PlUUC8zU=;
        b=GzLlmemPP4Q8hEzrPgUtObl+zNZ98CzxVwIrewcR1BWkBSPwBgsQgUYlAugN0ck9tY
         +GjakTAztncM3koqg6P31QUeSN2br7YU5OTijvpZdfkOcF59cb1AVneMiPT6KsePGZ+F
         C2+UWBrpjge5PgVYLhKL9TQFbBvbh1x7ykU5xnnuXJCl6aULnHTiKRIMHGWc8a4fekC7
         1sm6PrNch4CyYGqVDaOhdjw2aFJuDOaVXvoeX3OU8bZnUUN8WhpJCzlZ4RV1+naaddGD
         Y5yo2yu0SyFUbDxjDLlv06wPZxbc+itkgK0u0KBl2vnJ9Yl6eMYcg5ObvJxcJl49uNjI
         O5/Q==
X-Gm-Message-State: AAQBX9cziHG1mvdbb8LPA+JBKQ8XGyuhCAO9I3cCYqCmP4NoGZbbVrLh
        DrT8IRi+rRQBlzNCNwrwMA/TfpA3UVo=
X-Google-Smtp-Source: AKy350btV5WNqzErKtxiHAqBrc74aEG4o3U784IbaSpYUXuHaUKrnkflNxJZVCzDKHG61J0a7gJ//m/aT38=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:cf81:0:b0:b76:ceb2:661d with SMTP id
 f123-20020a25cf81000000b00b76ceb2661dmr1699796ybg.7.1679690500564; Fri, 24
 Mar 2023 13:41:40 -0700 (PDT)
Date:   Fri, 24 Mar 2023 13:41:39 -0700
In-Reply-To: <20230221163655.920289-8-mizhang@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com> <20230221163655.920289-8-mizhang@google.com>
Message-ID: <ZB4LAzgNsbKdTESk@google.com>
Subject: Re: [PATCH v3 07/13] KVM: selftests: x86: Fix the checks to XFD_ERR
 using and operation
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>, g@google.com
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
> Fix the checks to XFD_ERR using logical AND operation because XFD_ERR might
> contain more information in the future. According Intel SDM Vol 1. 13.14:

If that happens, then the future change is responsible for updating the check.
The test very clearly does a straight write of MSR_IA32_XFD.  If there are extra
bits set then something is broken.

	wrmsr(MSR_IA32_XFD, XFEATURE_MASK_XTILEDATA);
