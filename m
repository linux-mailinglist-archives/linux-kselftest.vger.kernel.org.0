Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E353602C8C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Oct 2022 15:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiJRNMP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Oct 2022 09:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiJRNMJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Oct 2022 09:12:09 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343C9C7848
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Oct 2022 06:12:06 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cl1so13855127pjb.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Oct 2022 06:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GfgN++TPk0fTsXy49wFUN76bG9RP2vq/hMwME62fwuc=;
        b=CGXkSB9uywrxsgCdNFPuLJClpIMUtjLodXrbG2P6EA5GDH5qtFAFuSefrX06MNdx7K
         y09Se10ajet7taVCaFyZi5lU6ag1p1po3SpuOj8qa3ikH+Rhy59iG7l+QvmqL3EkjN1g
         02iO9A1tXmi11e1B8e5QzJHbGC3Ty5fk85n0M0JIFt1xLmuspHls3QZxaKuje3aZt5ag
         jKBZzNMOFbine3wnRei1n1ogxTbx+zgim9cZLm19B9KInwPb4DFozHlLtBgniMPhONqF
         kf3LWS87AjBafRqd8MEgPuVjgs1JSn14EQmTft/SLeBBC4E94/3AjdGqwXR3t43SATD6
         +8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfgN++TPk0fTsXy49wFUN76bG9RP2vq/hMwME62fwuc=;
        b=2Uboi2PpzCfGaII+BChDw845XsPMS2DOU7OD9zBD5LY1UtsSyZ3MklI5y/3lg7HLUU
         rYm63lFnQB8UJYn0hAbFdrl6u5xN2nqAbjz0L1Ar5pcETSeUpJVao36cOn9nCVo+37Wo
         AGp0lkPiRvShISd48DJcahduOGNfZ/WTzT8fU1YlRZ5Jx94RC/W+XnNtbYpaQJ+ex9VV
         bNtPX/DAgAUJXEMD4B8naPNAuehiet9BQRCmgqllntFdQxuRVSDdl11XYdpl88Y6FjCm
         yZ+X+T6nkYIhf8LWswTnj8Uri+cqDjvZi4mVK/IjRuCG9Fo6HLRtsh7gKcRCjil+K3Nf
         1KMQ==
X-Gm-Message-State: ACrzQf1E39YIfJ/rAoNEeKY4QjfFvwg5fah3TCcWF/Ux+qGPZBuEmfWB
        BbF7J+B1+sK5GofUF7+UiRALfmDMYMCvlRIxmYSnTw==
X-Google-Smtp-Source: AMsMyM6WIAnvbu3GJwLi+rnRvx9SP9n/YV8ENAQvAYkNqJyKnq+TLw0aAHXTKYafdDi0g5pfux+aSCbMtCBn6X8DJwg=
X-Received: by 2002:a17:90b:38c3:b0:20d:406e:26d9 with SMTP id
 nn3-20020a17090b38c300b0020d406e26d9mr3569457pjb.121.1666098725139; Tue, 18
 Oct 2022 06:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220819174659.2427983-1-vannapurve@google.com>
 <20220819174659.2427983-4-vannapurve@google.com> <Yz80XAg74KGdSqco@google.com>
 <CAGtprH_XSCXZDroGUnL3H1CwcsbH_A_NDn8B4P2xfpSYGqKmqw@mail.gmail.com>
 <Y0mu1FKugNQG5T8K@google.com> <CAGtprH9tm2ZPY6skZuqeYq9LzpPeoSzYEnqMja3heVf06qoFgQ@mail.gmail.com>
 <Y02aLxlCKWwN62I5@google.com>
In-Reply-To: <Y02aLxlCKWwN62I5@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Tue, 18 Oct 2022 18:41:53 +0530
Message-ID: <CAGtprH-i6MDiYFQGf=cjOPcaTZyezObW7HpegBiFq6BPKa2jWQ@mail.gmail.com>
Subject: Re: [RFC V3 PATCH 3/6] selftests: kvm: ucall: Allow querying ucall
 pool gpa
To:     Sean Christopherson <seanjc@google.com>
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
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Oct 17, 2022 at 11:38 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Oct 17, 2022, Vishal Annapurve wrote:
> > This is much sleeker and will avoid hacking KVM for testing. Only
> > caveat here is that these tests will not be able to exercise implicit
> > conversion path if we go this route.
>
> Yeah, I think that's a perfectly fine tradeoff.  Implicit conversion isn't strictly
> a UPM feature, e.g. if TDX and SNP "architecturally" disallowed implicit conversions,
> then KVM wouldn't need to support implicit conversions at all, i.e. that testing can
> be punted to SNP and/or TDX selftests.

Ack. Will address this feedback in the next series.
