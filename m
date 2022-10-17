Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177436015FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Oct 2022 20:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiJQSI4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Oct 2022 14:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiJQSIy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Oct 2022 14:08:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AC474B92
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 11:08:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so11749154pjl.0
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L9A07l58gYnh7KAA0iXhOrnBqUc773E6KyrOSccVOeI=;
        b=VEW8NrH9pYWqGDvIZkdrS5zE1KyrBYrxMV/OFT8xI++Zos03GTAy4kuS4+FYASo15T
         vM0kH4ym0hozzgAK5k3fiBmg1i7avcGAUw2qzOK2sD4Bys1dpmBa9MV9D5SmkzFHqgxr
         Qo/AT+amKP5u7jpv49MWo8TrOSib/79/eBpB6rxAcSr9fGeYmBsTH0dJ/TYKFuIag2Tv
         73VGvVPZrNSrJgTRvomtlRITXBj/voR6b4QUthdiYg+3bejNxmdeSACLiPOFHnuYEUAB
         lchGF110Oo6fwO+VAqhIYulZdloa+ZKOw7IPEx7WHRSwI2ujMBy0UFAJHxjzwTsOg0rd
         AEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9A07l58gYnh7KAA0iXhOrnBqUc773E6KyrOSccVOeI=;
        b=YyLsc/YjJ3D5I1t9Bf7wQ6FPhEPWIv6KPj+zC1jt+kN/SjTQsmIL3doLhkrW/qY+vk
         8XXlIVfZuxUj5YZiSkCcjkI+LjLO9He/NdBKhJO9ns27souEMd8VXzlZI8XCHKngADis
         aoVk5DtHvYcSlJnVBHMBDyXvqpPL2v7fQzYACXmgOlqBNoSnkf62X/drchLjbJFaTAc/
         RHz1t64UlL/NVoXE2JmNbtiXw3im8LTfsnrOuq8ebwczQlXXGAx52SBwh9miGXJ7VcJQ
         wFqmTHsYD+6ZL9JxfdbZHauIBvMJXBwHIVUHjYFbN1qI9/ZKLSZ83Q91pBuvDIHny2Pa
         lg7g==
X-Gm-Message-State: ACrzQf1DkHbFWR3wOxtMHSlwt7L+D7xp1JONKrwCs8H19gQ4srI+ICoU
        +Hju6qVS+3ysmalGPHbDgl8jZw==
X-Google-Smtp-Source: AMsMyM5/2r1LHGQfBAhdn0WDF+kLf6ME/hYhjaFUfzyQ8DsiO0ibgWcC8AAcfRM1UTz/1uTAvXZbOQ==
X-Received: by 2002:a17:902:b286:b0:17f:9db0:2334 with SMTP id u6-20020a170902b28600b0017f9db02334mr12977811plr.131.1666030132316;
        Mon, 17 Oct 2022 11:08:52 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id n12-20020a17090a2bcc00b00208c58d5a0esm9999071pje.40.2022.10.17.11.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:08:51 -0700 (PDT)
Date:   Mon, 17 Oct 2022 18:08:47 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        shuah@kernel.org, yang.zhong@intel.com, drjones@redhat.com,
        ricarkol@google.com, aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com
Subject: Re: [RFC V3 PATCH 3/6] selftests: kvm: ucall: Allow querying ucall
 pool gpa
Message-ID: <Y02aLxlCKWwN62I5@google.com>
References: <20220819174659.2427983-1-vannapurve@google.com>
 <20220819174659.2427983-4-vannapurve@google.com>
 <Yz80XAg74KGdSqco@google.com>
 <CAGtprH_XSCXZDroGUnL3H1CwcsbH_A_NDn8B4P2xfpSYGqKmqw@mail.gmail.com>
 <Y0mu1FKugNQG5T8K@google.com>
 <CAGtprH9tm2ZPY6skZuqeYq9LzpPeoSzYEnqMja3heVf06qoFgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGtprH9tm2ZPY6skZuqeYq9LzpPeoSzYEnqMja3heVf06qoFgQ@mail.gmail.com>
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

On Mon, Oct 17, 2022, Vishal Annapurve wrote:
> This is much sleeker and will avoid hacking KVM for testing. Only
> caveat here is that these tests will not be able to exercise implicit
> conversion path if we go this route.

Yeah, I think that's a perfectly fine tradeoff.  Implicit conversion isn't strictly
a UPM feature, e.g. if TDX and SNP "architecturally" disallowed implicit conversions,
then KVM wouldn't need to support implicit conversions at all, i.e. that testing can
be punted to SNP and/or TDX selftests.
