Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46F458E1D9
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Aug 2022 23:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiHIVip (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 17:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiHIVif (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 17:38:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11FD65665
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Aug 2022 14:38:34 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b4so12920203pji.4
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Aug 2022 14:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=o8zzCiEtSfxFlAxZzKI7HqSYHHhfKIfxoT6ysA2mwRQ=;
        b=mz0Fjqu9dzg7nU0PCSUBlYeJVZ9gb/NvoAjp4klMVPqMWGBhoN7T4Z0A+Z5dI9GQUf
         nxY8R3gRW2W8Mae+vrr6Ov/btiZ6+vE6BrY4Kb0G+XnUcpHcplU/LqFC9QnvoIdHE0Bu
         /g+230V6KN4RaDF9l6q2AfbJ23OtFDrDFA/ZMoH1TKvz1vpKNLrWVhnVtBHLzuUnvgWh
         pTqM3Ksr4fhJ+B6dQYaaJwgY5DL1KZxkL90D8RAM62drfSjOX14jlDF7PTkcKwENBXt2
         MtUmXKj5VBSQVKk2fMfgtzxlsBv5KLSPjbe0t1StTlu3+6htVnbMD0KVSeQgELY8ybIb
         afPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=o8zzCiEtSfxFlAxZzKI7HqSYHHhfKIfxoT6ysA2mwRQ=;
        b=fkRQ3kzP85yHsIP3vIXVrv+ynVPGrr0Jj56HQzyDa4GHbYvBk+dQfc82sX23qQwKal
         GJLVysfkXJTs3yhv1BmZimn2DS7TmKVctxkwRdgjJsdiEjjjHQAAHv8ARexW9FGyav3t
         OvTRaFjyNCJTjMrxblcD51FeLNdD1544YG+fFEDyCKsw7VigS/r6sH/6KnAdNYsC5ZW2
         M8E+u4nF7znT4XskzAFfwcZ0WMUSfchclvFzwYjDT4U24rO3N5pB+J6VDRPTySeT9w7i
         FrZH2HC/yZppAKiIoZFxG4XTM5ldHt8DeczaRS0PmzH5us6weVHwcFNn+XIbDOCiJpOd
         rhcw==
X-Gm-Message-State: ACgBeo3rRNEQoAlcnF5WEcmBJXSg1Sp/eoA3Oxehxbw8AA867f+pO+Gx
        +spjlL9L1I6OueNViyN1hWSqLQ==
X-Google-Smtp-Source: AA6agR4J/HhURqfPvPpi43Q7Bija6xPtnqX55byjC51oilG8jZwpXiNOXRPE6CWpwE3OWAgXLExSyw==
X-Received: by 2002:a17:902:8b87:b0:16f:1bb7:984a with SMTP id ay7-20020a1709028b8700b0016f1bb7984amr24756042plb.113.1660081114308;
        Tue, 09 Aug 2022 14:38:34 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b0016f1204cde8sm11219119plk.301.2022.08.09.14.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 14:38:33 -0700 (PDT)
Date:   Tue, 9 Aug 2022 21:38:29 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Gavin Shan <gshan@redhat.com>, shuah <shuah@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        kvmarm@lists.cs.columbia.edu, KVM list <kvm@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, maz <maz@kernel.org>,
        oliver upton <oliver.upton@linux.dev>,
        andrew jones <andrew.jones@linux.dev>, yihyu@redhat.com,
        shan gavin <shan.gavin@gmail.com>
Subject: Re: [PATCH 1/2] KVM: selftests: Make rseq compatible with glibc-2.35
Message-ID: <YvLT1fd8ddybF5Uw@google.com>
References: <20220809060627.115847-1-gshan@redhat.com>
 <20220809060627.115847-2-gshan@redhat.com>
 <8735e6ncxw.fsf@oldenburg.str.redhat.com>
 <7844e3fa-e49e-de75-e424-e82d3a023dd6@redhat.com>
 <87o7wtnay6.fsf@oldenburg.str.redhat.com>
 <616d4de6-81f6-9d14-4e57-4a79fec45690@redhat.com>
 <797306043.114963.1660047714774.JavaMail.zimbra@efficios.com>
 <1014177394.115022.1660052656961.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1014177394.115022.1660052656961.JavaMail.zimbra@efficios.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 09, 2022, Mathieu Desnoyers wrote:
> ----- On Aug 9, 2022, at 8:21 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
> 
> > ----- Gavin Shan <gshan@redhat.com> wrote:
> >> Hi Florian,
> >> 
> >> On 8/9/22 5:16 PM, Florian Weimer wrote:
> >> >>> __builtin_thread_pointer doesn't work on all architectures/GCC
> >> >>> versions.
> >> >>> Is this a problem for selftests?
> >> >>>
> >> >>
> >> >> It's a problem as the test case is running on all architectures. I think I
> >> >> need introduce our own __builtin_thread_pointer() for where it's not
> >> >> supported: (1) PowerPC  (2) x86 without GCC 11
> >> >>
> >> >> Please let me know if I still have missed cases where
> >> >> __buitin_thread_pointer() isn't supported?
> >> > 
> >> > As far as I know, these are the two outliers that also have rseq
> >> > support.  The list is a bit longer if we also consider non-rseq
> >> > architectures (csky, hppa, ia64, m68k, microblaze, sparc, don't know
> >> > about the Linux architectures without glibc support).
> >> > 
> >> 
> >> For kvm/selftests, there are 3 architectures involved actually. So we
> >> just need consider 4 cases: aarch64, x86, s390 and other. For other
> >> case, we just use __builtin_thread_pointer() to maintain code's
> >> integrity, but it's not called at all.
> >> 
> >> I think kvm/selftest is always relying on glibc if I'm correct.
> > 
> > All those are handled in the rseq selftests and in librseq. Why duplicate all
> > that logic again?
> 
> More to the point, considering that we have all the relevant rseq registration
> code in tools/testing/selftests/rseq/rseq.c already, and the relevant thread
> pointer getter code in tools/testing/selftests/rseq/rseq-*thread-pointer.h,
> is there an easy way to get test applications in tools/testing/selftests/kvm
> and in tools/testing/selftests/rseq to share that common code ?
> 
> Keeping duplicated compatibility code is bad for long-term maintainability.

Any reason not to simply add tools/lib/rseq.c and then expose a helper to get the
registered rseq struct?
