Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907D37CC9CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 19:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbjJQRWj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 13:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbjJQRWh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 13:22:37 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB966109
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 10:22:35 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so9865947a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 10:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697563354; x=1698168154; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pYYZG7yAyFfJYvTA6jWgYrv4Zal/uQTaztc6Ctmxivo=;
        b=F7xZeRERpGfApZ2gfk21fOMRw83t9mU+0nldG8ThqAIM7a3fVsEQEoMmqwnGsI1VEV
         PBBPv59KxmxWFzMvQJ4GU8oXpLbMfPfxhNroTFs+EcwqR5ekEtG0oNt/vZcRMmKIHmoo
         vUoQUuilmOO+c80xbYJF7tWKhuZWAFgWhg67w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697563354; x=1698168154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYYZG7yAyFfJYvTA6jWgYrv4Zal/uQTaztc6Ctmxivo=;
        b=hyWQM2s3veo97rhejECgKOGNtjmk99uoQeBskdgiJH6GV9/hpCmECXG0EIDbjMFqdw
         0iNdHhddSpx2OGrDzDDwdiizJslM0aIJfQsexDXM3D8YfFkdac1DorFtYDstsK13lACG
         MUjuvNOC/x3vjNGmWBDoJtu+N5KBcPAvV9Y61zu01JrNT8pUFRSbKXxQHD5nxtphuUj9
         0hWJ6cBnjhvzgeAxPYcFueWst4cAATx0FqLI+sDtvXLzxTst7L2+XksHy/nkDjJaQoBe
         hPol7yc514BtwocQF8YrIAQBgCI26Yj+OPiLVAl8Pont3qpbd15zKvTYJVswaqJCWnjN
         IwZg==
X-Gm-Message-State: AOJu0Yy8Otv7wNjkG9ZOBuXySLRtgSizSzDpaJ5l9MEuGgcnI//FSUG1
        rGZIfHIgrIEboDyB6KaA1s9K7q0YCMjzg5DVjyk6mKqA
X-Google-Smtp-Source: AGHT+IGyEfONsGZnqOfRoHT4wja8/QS6Ul7E4Ux5ZJED/jrko7/CBOUlkVWhYKNAeLUHrCjTx3TJfQ==
X-Received: by 2002:a17:907:a42:b0:9bd:f902:9a61 with SMTP id be2-20020a1709070a4200b009bdf9029a61mr2117590ejc.18.1697563354006;
        Tue, 17 Oct 2023 10:22:34 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id d1-20020a1709063ec100b009bf94de8971sm162019ejj.70.2023.10.17.10.22.33
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 10:22:33 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9c5b313b3ffso201303066b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 10:22:33 -0700 (PDT)
X-Received: by 2002:a17:907:c08:b0:9bd:e017:370e with SMTP id
 ga8-20020a1709070c0800b009bde017370emr2539597ejc.54.1697563353335; Tue, 17
 Oct 2023 10:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org> <CAHk-=whFZoap+DBTYvJx6ohqPwn11Puzh7q4huFWDX9vBwXHgg@mail.gmail.com>
 <CALmYWFtTDAb_kpZdAe_xspqwNgK1NWJmjTxaTC=jDEMzfe297Q@mail.gmail.com>
In-Reply-To: <CALmYWFtTDAb_kpZdAe_xspqwNgK1NWJmjTxaTC=jDEMzfe297Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Oct 2023 10:22:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj87GMTH=5901ob=SjQqegAm2JYBE7E4J7skJzE64U-wQ@mail.gmail.com>
Message-ID: <CAHk-=wj87GMTH=5901ob=SjQqegAm2JYBE7E4J7skJzE64U-wQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To:     Jeff Xu <jeffxu@google.com>
Cc:     jeffxu@chromium.org, akpm@linux-foundation.org,
        keescook@chromium.org, sroettger@google.com, jorgelo@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, willy@infradead.org,
        mawupeng1@huawei.com, linmiaohe@huawei.com, namit@vmware.com,
        peterx@redhat.com, peterz@infradead.org, ryan.roberts@arm.com,
        shr@devkernel.io, vbabka@suse.cz, xiujianfeng@huawei.com,
        yu.ma@intel.com, zhangpeng362@huawei.com, dave.hansen@intel.com,
        luto@kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 17 Oct 2023 at 02:08, Jeff Xu <jeffxu@google.com> wrote:
>
> It is probably worth noting that I choose to check one and only
> one sealing type per syscall. i.e. munmap(2) checks
> MM_SEAL_MUNMAP only.

Yeah, this is wrong.

It's wrong exactly because other system calls will unmap things too.

Using mmap() to over-map something will unmap the old one.

Same goes for mremap() to move over an existing mapping.

So the whole "do things by the name of the system call" is not workable.

All that matters is what the system calls *do*, not what their name is.

And mmap() will fundamentally munmap() as part of the action.

This is why I absolutely hated the old "ON_BEHALF_OF_xyz" flag, and
why I still absolutely hate the "randomly pass different sealing flags
fto do_munmap()".

You should *not* be passing any flags at all to do_munmap(). Because
*regardless* of who calls it, and regardless of which system call
started the action, do_munmap() unmaps a virtual memory area.

See what I'm saying?

                 Linus
