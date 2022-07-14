Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4829A5751E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jul 2022 17:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240307AbiGNPfZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jul 2022 11:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239998AbiGNPfU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jul 2022 11:35:20 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1F648C8A
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 08:35:20 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso3528747pjo.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 08:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jw1a9NtjnOcexhTaceVUjWOdMbEAyVZWH2rm/Z273eI=;
        b=YHnEONUUADoF25ewKQsfvyaT/jYYsD0ZZqw3dUFMQPFDIqP6QxU1Gpb0D0zhBERlk4
         VKYPTedjmR1o9+0RrFfJrMtLJAhnh2jkFQK7FHEckQH6vNf18NIQmbFu1N+i+GcmKMEt
         awvouvFnp4VVllw+8MZfUeMwz05GBkwWr7fX6y5KGYwKHq/XaaOPCiJOwB4MzUKgrij5
         2gvb97v1hB5c9mpWrDOHarQOn0UTpIKtgNpN/EwC9h2gVpIJW1UcgrH1N/lH7uZgaaNP
         kwJpnIKnP6HcP+iRMzRfB/NmzYruha9ZqRvaW3/u19SVpoTlenWU6qcMRSmyNA8OobMB
         8zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jw1a9NtjnOcexhTaceVUjWOdMbEAyVZWH2rm/Z273eI=;
        b=NdjwPgmmSBVKHQD1/UwQl3eYcxnAgsy9X7uZgzdkKch5NNyAxLxvJJZfVeJij8NYJn
         n2UkspWjmXXIpDOh7Zd/ubhf4ygvuQlpaBrAphyLo24/BXoQe5tTRcGlv/f/OQ2yxT+k
         zaHNUPedrqY9Ziwx/1sfuZvtKtvdoMO2KfHTjYsgPwfpC4wJCfEYRAikhVLik26bCNQU
         ri8lO5M+SRJZyvUQQ/ncwZ2Q7sMq8QjJ5HCggf63tttIlgsLN30v+I9yFIWh26u5fD3c
         p8oLVW61xkG+0Xyf91j9pwMzxS4vWOkVewvph5/Rnqg/jc9oQVupd6OwwD8FdqY2h6vT
         qPRQ==
X-Gm-Message-State: AJIora+GNTE88n8Ik8Yw9/sPz3C8v8DRwvYKmccodsQQSnScZOgJnZZP
        qvL51IfEQJIQE7gF4gg5rt1OJwIIjvW2AA==
X-Google-Smtp-Source: AGRyM1vgNMOGyztZqnYxoIF9PKBibGcaOhduSNpBg1CPhgLHMpeyBynnCEbmfS68T5oS+8JWZemjrA==
X-Received: by 2002:a17:902:a388:b0:16b:d52b:a038 with SMTP id x8-20020a170902a38800b0016bd52ba038mr8872152pla.56.1657812919607;
        Thu, 14 Jul 2022 08:35:19 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id mm18-20020a17090b359200b001efa35356besm3836222pjb.28.2022.07.14.08.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 08:35:19 -0700 (PDT)
Date:   Thu, 14 Jul 2022 15:35:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        shuah@kernel.org, maz@kernel.org, oliver.upton@linux.dev,
        shan.gavin@gmail.com
Subject: Re: [PATCH] KVM: selftests: Double check on the current CPU in
 rseq_test
Message-ID: <YtA3s0VRj3x7vO7B@google.com>
References: <20220714080642.3376618-1-gshan@redhat.com>
 <cd5d029c-b396-45ef-917b-92e054659623@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd5d029c-b396-45ef-917b-92e054659623@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 14, 2022, Paolo Bonzini wrote:
> On 7/14/22 10:06, Gavin Shan wrote:
> > In rseq_test, there are two threads created. Those two threads are
> > 'main' and 'migration_thread' separately. We also have the assumption
> > that non-migration status on 'migration-worker' thread guarantees the
> > same non-migration status on 'main' thread. Unfortunately, the assumption
> > isn't true. The 'main' thread can be migrated from one CPU to another
> > one between the calls to sched_getcpu() and READ_ONCE(__rseq.cpu_id).
> > The following assert is raised eventually because of the mismatched
> > CPU numbers.
> > 
> > The issue can be reproduced on arm64 system occasionally.
> 
> Hmm, this does not seem a correct patch - the threads are already
> synchronizing using seq_cnt, like this:
> 
> 	migration			main
> 	----------------------		--------------------------------
> 	seq_cnt = 1
> 	smp_wmb()
> 					snapshot = 0
> 					smp_rmb()
> 					cpu = sched_getcpu() reads 23
> 	sched_setaffinity()
> 					rseq_cpu = __rseq.cpuid reads 35
> 					smp_rmb()
> 					snapshot != seq_cnt -> retry
> 	smp_wmb()
> 	seq_cnt = 2
> 
> sched_setaffinity() is guaranteed to block until the task is enqueued on an
> allowed CPU.

Yes, and retrying could suppress detection of kernel bugs that this test is intended
to catch.

> Can you check that smp_rmb() and smp_wmb() generate correct instructions on
> arm64?

That seems like the most likely scenario (or a kernel bug), I distinctly remember
the barriers provided by tools/ being rather bizarre.
