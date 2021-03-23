Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11C0346424
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Mar 2021 16:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhCWP65 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Mar 2021 11:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbhCWP6f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Mar 2021 11:58:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A189C061763
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Mar 2021 08:58:34 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so10318353pjb.2
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Mar 2021 08:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SfxnQOiV9YtUhVcKaF5V6wU86bSU5bXDZAmmBqiZiO8=;
        b=D2p4/PesPSG1mrdD2nErlUzlOKRxAMLs38va47MURkQJ3SOMFZbuEkzyFsjKDX2iM7
         yde2KQI8/GySy+QNOtg7Iz1d6WHS7tI2OioCyUjGWqSQSwVt/Ma6lrDSYf6l1Oa6yRzU
         /slcrq3CdMoGOQ4CLBvJetxj1Y74nYhrujy55EkCjhJb4yZvd89I0146G9rnusoWWoIH
         hnN7EHoTxyldjH13iWmmpgFRNfWDvdrCZAiEDhIMLHWlP389Yuy1tPUTFLTHkoAFbeB8
         wdJ/FafA/R7UE8H7dhUhdXNbRooxP66soJoScEQkMX5vvdmnqIPFjONVRH0rGuKwOsAq
         JxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SfxnQOiV9YtUhVcKaF5V6wU86bSU5bXDZAmmBqiZiO8=;
        b=YrIAY2ucjzNSs4vJMQMwS87ACCR7ied5sDj0XGZG/fqlzTcTjCHVDPeuNTKYnsjVug
         H1YDbdPqVlQE7iXuw0wd3BRsHdw7cKamqAee85HnuUFJccgDkhBr0b35Ov1pLwJTJ0M4
         Nh/B5P0bP5z0M9Yb3rpwBWM4NdRYJoKUf5SBFfq5IV0IdGiv21kwgJ9Wp0bBFWbaq1A4
         pAiKiYenShO9Brk1LHCfBsWa18Z1BaqwBnBq+tfGf2ylpWxh+B4D2wGrR4y4v7K0hN8+
         PB4I22seiagg3eMHs0uEIVlGp11erMttIrwUVN1jHFNnbw9tl/a7Uxre/qOtIqLbY3Kr
         jzsA==
X-Gm-Message-State: AOAM532DeLV/XUKx36Cxkay4pzrwNvsHccX1zJk6XnE0g5LJheJ+DBqI
        y53wjEebSEzNXLUl2WkvI3q2Dw==
X-Google-Smtp-Source: ABdhPJx9v0kCbb15YUoBdgkPPfFrpgXF7gY9i57WrbCLPcQvRfVEROeZggyWBWyXluSfOwN0ZG+dwg==
X-Received: by 2002:a17:90a:1502:: with SMTP id l2mr5004874pja.149.1616515113748;
        Tue, 23 Mar 2021 08:58:33 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id s28sm17894559pfd.155.2021.03.23.08.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 08:58:33 -0700 (PDT)
Date:   Tue, 23 Mar 2021 15:58:29 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yanan Wang <wangyanan55@huawei.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Jones <drjones@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        wanghaibin.wang@huawei.com, yuzenghui@huawei.com
Subject: Re: [RFC PATCH v5 00/10] KVM: selftests: some improvement and a new
 test for kvm page table
Message-ID: <YFoQJQ5OYEx3BD3Y@google.com>
References: <20210323135231.24948-1-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323135231.24948-1-wangyanan55@huawei.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 23, 2021, Yanan Wang wrote:
> Hi,
> This v5 series can mainly include two parts.
> Based on kvm queue branch: https://git.kernel.org/pub/scm/virt/kvm/kvm.git/log/?h=queue

Given the number of Reviewed-by tags, I'm pretty sure you can drop the "RFC" :-)
