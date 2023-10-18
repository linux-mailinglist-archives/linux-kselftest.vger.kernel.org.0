Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B2E7CE665
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 20:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjJRS1d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 14:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjJRS1b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 14:27:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3EB120
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 11:27:28 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso1155506066b.2
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 11:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697653646; x=1698258446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4LSW7ZRKgP1lLxQuTMsxLUqNOunePLnj/+UPZS75Rc0=;
        b=hcZXq2UhksD+Hh6t/eVWNVE2q+i+SJbnCiZv1j87hLr7Q8rBBnKAcFBcimRX+KK/d+
         Qgc33tayiY/lhVxSjqpMDVcb6awdrbLqeuRi3xJJyC9VjLh7baGPXAQhM2RixXb0O1lP
         m3LmCV7STOwysb6+YrGH22/ZuOoExylCYkI70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653646; x=1698258446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LSW7ZRKgP1lLxQuTMsxLUqNOunePLnj/+UPZS75Rc0=;
        b=CrYasUOarcnRwp++Kc0FopogJsG5ObTHhvd7Xp1sfd/D6sGL5wbUFCK+95GxwVCwO8
         z3jyQVaqYC/N9CeJOUb7sAGyDEJH5VBDkp7i1Y1wU5VmeAv3UGbsUcgh/zNfvkmHX77F
         QuMLEvCzjSdcsjuzsD0uNL2tdcyZ/PD2uE260F6r6wJhByHFJ1kd1W3KmUf3BS0PgMQJ
         aVZF9mMz4F+R3Cn7Eylv6NrZ/ONBuvffbJBfXSSwb9/YASnJ7JT7o3I0yMD+9rroTBiz
         p1PbFTtSd+mn76KbgMaV8zgxbPiS6vINPmK8Jtz3j5+rNxmBOnBDcLqyZTYFP3MZTJ8n
         39ww==
X-Gm-Message-State: AOJu0YyE7/FF4p0SCPj994vSynXsHwHG0TSZkwHhSn+LLkiSNAbsqhm/
        I3RK2npwnw3dt5lyYpGXeHeME2+3ZJWIzagcj8CS4RhW
X-Google-Smtp-Source: AGHT+IErbeCVMpLiAczfWoMgIz4V7qPF1XmCNemMu8+RaZjtGdiRh2a2kSde6xaIsgFBeavfbhDxsQ==
X-Received: by 2002:a17:907:9284:b0:9be:9d5f:6967 with SMTP id bw4-20020a170907928400b009be9d5f6967mr34293ejc.69.1697653646276;
        Wed, 18 Oct 2023 11:27:26 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906024900b009b2b9af0784sm2132685ejl.110.2023.10.18.11.27.25
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 11:27:25 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso1156252266b.1
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 11:27:25 -0700 (PDT)
X-Received: by 2002:a17:907:8687:b0:9c5:2806:72e9 with SMTP id
 qa7-20020a170907868700b009c5280672e9mr50945ejc.34.1697653645201; Wed, 18 Oct
 2023 11:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231017090815.1067790-1-jeffxu@chromium.org> <20231017090815.1067790-6-jeffxu@chromium.org>
 <CAHk-=wgwdHzOY_mT3y9gDHSMXZ8Xb5OYrK40-u9uRXLv25fNPA@mail.gmail.com>
 <CALmYWFux2m=9189Gs0o8-xhPNW4dnFvtqj7ptcT5QvzxVgfvYQ@mail.gmail.com> <CALmYWFvgM7DOihdUpUC5SREhUMn9t53HYCX+YioeHHhLSD1KHw@mail.gmail.com>
In-Reply-To: <CALmYWFvgM7DOihdUpUC5SREhUMn9t53HYCX+YioeHHhLSD1KHw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Oct 2023 11:27:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixGw88-OzcFbCLEuAzSe53oUUozdM-E_RJwvejgY6ySA@mail.gmail.com>
Message-ID: <CAHk-=wixGw88-OzcFbCLEuAzSe53oUUozdM-E_RJwvejgY6ySA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/8] mseal: Check seal flag for munmap(2)
To:     Jeff Xu <jeffxu@google.com>
Cc:     jeffxu@chromium.org, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, sroettger@google.com,
        willy@infradead.org, gregkh@linuxfoundation.org,
        jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 18 Oct 2023 at 10:14, Jeff Xu <jeffxu@google.com> wrote:
>
> There is also alternative approach:
>
> For all the places that call do_vmi_munmap(), find out which
> case should ignore the sealing flag legitimately,

NO.

Christ.

THERE ARE NO LEGITIMATE CASES OF IGNORING SEALING FLAGS.

If you ignore a sealing flag, it's not a sealing flag. It's random
crap, and claiming that it has *anything* to do with security is just
a cruel joke.

Really.

Stop this. I do not want to hear your excuses for garbage any more.
We're done. If I hear any more arguments for this sh*t, I will
literally put you in my ignore file, and will auto-NAK any future
patches.

This is simply not up for discussion. Any flag for "ignore sealing" is wrong.

We do have one special "unmap" case, namely "unmap_vmas()' called at
last mmput() -> __mmput() -> exit_mmap().

And yes, that is called at munmap() time too, but that's after the
point of no return after we've already removed the vma's from the VM
lists. So it's long after any error cases have been checked.

             Linus
