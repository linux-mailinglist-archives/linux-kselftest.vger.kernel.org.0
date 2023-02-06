Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCA368C57F
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 19:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjBFSPX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 13:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBFSPW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 13:15:22 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1611DBB8
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Feb 2023 10:15:21 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id ge21-20020a17090b0e1500b002308aac5b5eso6213251pjb.4
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Feb 2023 10:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j2naqO27jEomHdidROPfa1/bwU+cqej9MnTe7cdSV7w=;
        b=GI6MWavZ0XdjoEwPBPU6eZlXhzpwC047vgjkT7j9veomSLlENdHKNzp9M0n/7Be7zX
         Dx8oPwkDLrGI9tSYaEXoPTYcXQHHgUvASA//IlusPnyTGmlq+uMvDmiEYPC/m1f5y3WE
         nreKUtDv3cDlmk4baxebRwr/h7K4HmszysWJwMggw7x320bJiMwrrfIiJgYXIeX+eJrk
         QydhCbxdbvfIbaH3GZmzby0eGjtqRZEBRbY8vtiDo5bJKJj51aanrIXGIU2rq7kxhKMr
         VvHNIJemyUn5ENkncBSxr62MfD3Xzw01shRBkodDnHr0gBcpPoSTs3ppLkRDWH8bs9J8
         PlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2naqO27jEomHdidROPfa1/bwU+cqej9MnTe7cdSV7w=;
        b=yemncMGts/DL3MO0dwyohUMSY7x+LteAJOtj1it/+KoD5feT+beRl7aTEAqVzlu0xN
         RQRlr5bV1XIQHqRr0QdCRD2jDcOh3qysemNpzFqj1jnGvcMa0hZWeMaS2/hMVwHZ1+r0
         VpS1/RK6isUJ1U8e89GnUK1pa24bxwJyzu338WoxoT+AZgagqMFqyYuLPdVzLjq6kpYf
         z7tXLgUMhOqlaD2qDvgVvwGx7F1qcBX3Fzi2FFqQTVc9rNNemFSqNg9xSCAIp4LAKrD8
         3XGREO+naygwJjvqMWwtnJ/hrp0Nc5ahwWroc28hTmyd9dOI/CcYZKvJZR1NbcSZR3hM
         a/Kw==
X-Gm-Message-State: AO0yUKVdAMKmz3hWY/UYJhXG71sg8OLh0x30ARK7+6CPm8yyUsS13Nel
        5qYAFp13O0gD++mZDZ13aylHHQ==
X-Google-Smtp-Source: AK7set9Q9tCTBGDnPHWRJieacFziStzsPkn8q4WBBMDFYh9eCRF2em3CeKkKIEyjvLJVN3Ym/6DTtA==
X-Received: by 2002:a17:902:daca:b0:198:af4f:de0c with SMTP id q10-20020a170902daca00b00198af4fde0cmr528182plx.12.1675707320731;
        Mon, 06 Feb 2023 10:15:20 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090a8e8300b0022c08b63564sm6641081pjo.52.2023.02.06.10.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 10:15:20 -0800 (PST)
Date:   Mon, 6 Feb 2023 18:15:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Mark Brown <broonie@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org
Subject: Re: [PATCH] KVM: selftests: Enable USERFAULTFD
Message-ID: <Y+FDtDWnG2k0wqlv@google.com>
References: <20230202-kvm-selftest-userfaultfd-v1-1-8186ac5a33a5@kernel.org>
 <Y+E0MuGJ+hE3zslT@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+E0MuGJ+hE3zslT@google.com>
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

On Mon, Feb 06, 2023, Oliver Upton wrote:
> +cc x86, riscv as they're also affected.
> 
> On Thu, Feb 02, 2023 at 09:01:36PM +0000, Mark Brown wrote:
> > The page_fault_test KVM selftest requires userfaultfd but the config
> > fragment for the KVM selftests does not enable it, meaning that those tests
> > are skipped in CI systems that rely on appropriate settings in the config
> > fragments except on S/390 which happens to have it in defconfig. Enable
> > the option in the config fragment so that the tests get run.

What do CI systems do for HugeTLB and THP?  Those are the other config options I
can think of where there are very interesting interactions from a KVM perspective,
but where KVM doesn't have a strict dependency on the feature.

E.g. x86_64_defconfig selects CONFIG_HUGETLBFS=y, but I don't see anything for THP,
and AFAICT TRANSPARENT_HUGEPAGE is default=n.

> Thanks for catching this.
> 
> I believe we also need UFFD for demand_paging_test, which is used by all
> the KVM selftests arches. I plan on picking this up, but if anyone has
> objections please shout :)

All yours.

Reviewed-by: Sean Christopherson <seanjc@google.com>
