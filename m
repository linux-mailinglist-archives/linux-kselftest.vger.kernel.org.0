Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D95F5FEBE0
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Oct 2022 11:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJNJlh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Oct 2022 05:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiJNJlf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Oct 2022 05:41:35 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9507B1C8D6C
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Oct 2022 02:41:31 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i6so4217109pli.12
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Oct 2022 02:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KdrfFMceV7elb/rA2YCTui/ZhC4l1ygRRIMRPNusZhU=;
        b=tILJoqotiPdze1TCCwL+mF59nGOxYtncfKrouddVFax7Gcsz+crVbOVRREI0Tubts5
         vV3yE8640V3CYRlQELJMmFfQQTczEty9SrunN7E3D3rGtjh2DtqxOyXcFHLCaUj06bmI
         n2K5LQbByQ+bIzM6sx24DqM+gWvxy+s7nteoahhh7v3RsKCxB7wfK3JM651TalbDEgCt
         iq+ySPOEI9A34HStVa3+jhYVticSF1HMoHESfANw0eGaYRCfMc6JZDSu2ulbuQq9aPiZ
         CEjBxmmj7CjShgC3jfj1T37OUIOlhGbi6AzfZNYGfNVtK/Ji6CXdTMJ7lej9vyZzHKB2
         fE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KdrfFMceV7elb/rA2YCTui/ZhC4l1ygRRIMRPNusZhU=;
        b=6FbPKHK079DcU4jVpz/OcdD+mqFoQSJGoU1CankypEDkl3gzisWF2+vP5Cmjd8s2LE
         SBWp6ur1ZeMEyy8Agk9YcyAGDMHte75oVh55CPqHq5+BTYAVJCJkxIzqrgrg9p5mp5YY
         P0SFzfKm1eKuW5aNg3AUujleRNM4dBkzcgrekLBVKBMyv1FFeew3aAi6Hc5stngcYxYv
         no9nWHd8dKmlJhnLZrbq44pieV0fOh9QnnHGfOcP1nfa5fslWBTqWUFi9eRPW6fC4PZz
         e5zRcHx62DzlwiSQFjzkP1WMVH+x3ljUX7yKS2iYEocFh1XCKfXCqFyUbv9k5zscSHK3
         mAkA==
X-Gm-Message-State: ACrzQf0VnVdnakYykwTY/OHfPS+PK1dggt/4FsyZQnwVcwNp5sTCeYCO
        WxZEAhcqQMIUvEX6sBwQXkLTJVHufPYGxBQEePVPOA==
X-Google-Smtp-Source: AMsMyM4UqG/vIk3S7koHuixUnBbVmb4fDf+woVq1uoMPm6jtVGqdAhA4fxEgS9gbQtKnvvq2Dv3MB4MMySXFLzb02qg=
X-Received: by 2002:a17:90b:38c3:b0:20d:406e:26d9 with SMTP id
 nn3-20020a17090b38c300b0020d406e26d9mr4843007pjb.121.1665740490315; Fri, 14
 Oct 2022 02:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220819174659.2427983-1-vannapurve@google.com>
 <20220819174659.2427983-7-vannapurve@google.com> <Yz85WEQWsXAbLWnu@google.com>
In-Reply-To: <Yz85WEQWsXAbLWnu@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Fri, 14 Oct 2022 15:11:19 +0530
Message-ID: <CAGtprH-eA+k3BwczSyds+Hrr5QZn96hNK81Op_iBH20-wKfKeg@mail.gmail.com>
Subject: Re: [RFC V3 PATCH 6/6] sefltests: kvm: x86: Add selftest for private memory
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

On Fri, Oct 7, 2022 at 1:54 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Fri, Aug 19, 2022, Vishal Annapurve wrote:
> > +static bool verify_mem_contents(void *mem, uint32_t size, uint8_t pat)
>
> As per feedback in v1[*], spell out "pattern".
>
> [*] https://lore.kernel.org/all/YtiJx11AZHslcGnN@google.com
>
> > +{
> > +     uint8_t *buf = (uint8_t *)mem;
> > +
> > +     for (uint32_t i = 0; i < size; i++) {
> > +             if (buf[i] != pat)
> > +                     return false;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +/*
> > + * Add custom implementation for memset to avoid using standard/builtin memset
> > + * which may use features like SSE/GOT that don't work with guest vm execution
> > + * within selftests.
> > + */
> > +void *memset(void *mem, int byte, size_t size)
> > +{
> > +     uint8_t *buf = (uint8_t *)mem;
> > +
> > +     for (uint32_t i = 0; i < size; i++)
> > +             buf[i] = byte;
> > +
> > +     return buf;
> > +}
>
> memset(), memcpy(), and memcmp() are safe to use as of commit 6b6f71484bf4 ("KVM:
> selftests: Implement memcmp(), memcpy(), and memset() for guest use").
>

This is much better. It made less sense to add a custom memset for a
single selftest.

> Note the "fun" with gcc "optimizing" into infinite recursion... :-)
>
> > +
> > +static void populate_test_area(void *test_area_base, uint64_t pat)
> > +{
> > +     memset(test_area_base, pat, TEST_AREA_SIZE);
> > +}
> > +
> > +static void populate_guest_test_mem(void *guest_test_mem, uint64_t pat)
> > +{
> > +     memset(guest_test_mem, pat, GUEST_TEST_MEM_SIZE);
> > +}
> > +
> > +static bool verify_test_area(void *test_area_base, uint64_t area_pat,
> > +     uint64_t guest_pat)
>
> Again, avoid "pat".
>
> > +{
> > +     void *test_area1_base = test_area_base;
> > +     uint64_t test_area1_size = GUEST_TEST_MEM_OFFSET;
> > +     void *guest_test_mem = test_area_base + test_area1_size;
> > +     uint64_t guest_test_size = GUEST_TEST_MEM_SIZE;
> > +     void *test_area2_base = guest_test_mem + guest_test_size;
> > +     uint64_t test_area2_size = (TEST_AREA_SIZE - (GUEST_TEST_MEM_OFFSET +
> > +                     GUEST_TEST_MEM_SIZE));
>
> This is all amazingly hard to read.  AFAICT, the local variables are largely useless.
> Actually, why even take in @test_area_base, isn't it hardcoded to TEST_AREA_GPA?
> Then everything except the pattern can be hardcoded.
>
> > +     return (verify_mem_contents(test_area1_base, test_area1_size, area_pat) &&
> > +             verify_mem_contents(guest_test_mem, guest_test_size, guest_pat) &&
> > +             verify_mem_contents(test_area2_base, test_area2_size, area_pat));
> > +}

Ack. Will address these comments in the next series.
