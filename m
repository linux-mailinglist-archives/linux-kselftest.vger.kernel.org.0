Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B24F7CC92C
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 18:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbjJQQy5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 12:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQQy5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 12:54:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B0092
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 09:54:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53db1fbee70so10026329a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 09:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697561693; x=1698166493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K1bTNFT87lr+HVy46GvlRl8WsLt2mWlRGa4YdiUNjuo=;
        b=PFM3RQvqEe7u45KgiION4fPKs+KtXOGSvg0QTKUlrHz7SWoJEBVTrjq658S9W55ebn
         d5Z/RURWGQhF9DXWCVda+CFLc1tKSMUDUpeqX49o5op9URYMUrjokEbRLabqKG967oxM
         cyeyE7xOpyC3OqcuJCwTT6AU4Eoynlp8pLuJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697561693; x=1698166493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1bTNFT87lr+HVy46GvlRl8WsLt2mWlRGa4YdiUNjuo=;
        b=Q6y/6RPyhjMbj1Jq9Y0Zb6Lqx7p5G6ENZXDE1VX9Q+0Fa+N0uC+HVi6yHJnKKuawhc
         iMP/l3+oj2pEfCydtrTiVlQD9fK7P7O8o1cS+qdiizrKCcQLOzurRB0GrvCrz0rjimHr
         yJ3vF6gWf44G+wU5n714W9w4jbvCt0i5aH7H44zunAOnaua6oUNwK7tbMDI9KJTfRjqr
         h8afsdmcLEdvCHTIsx4IuwfnDPxoXXRZXgSdzFT4KRAAvE3bBi4DwdHuXBsvvg3uQ/RK
         1hp/qhmDXz0b0fr2KlRQh0ximSGydvwRURICbJo34xRB3vIPrHgakBLM1as5f0CTOrxp
         uY5w==
X-Gm-Message-State: AOJu0YywiiZTLmrmJf0SI6aEs2+OU9nDGqokYS5rxP4wBS1Fs/zG7Lm6
        ENDM5MxSasPThMEZr+ruWKX5fABWCEVfC07KyqKq0gqM
X-Google-Smtp-Source: AGHT+IGOOMN33e77HHO5/prtydsuNUsUQXDEV6/qw97vzNmjanzVHUUdxxQl99YAyWFTc2j036Oa8w==
X-Received: by 2002:a05:6402:2691:b0:53d:b5bc:48af with SMTP id w17-20020a056402269100b0053db5bc48afmr2501818edd.11.1697561693609;
        Tue, 17 Oct 2023 09:54:53 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id f15-20020a05640214cf00b0053e88c4d004sm1472632edx.66.2023.10.17.09.54.52
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 09:54:52 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so950964166b.3
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 09:54:52 -0700 (PDT)
X-Received: by 2002:a17:907:3cd:b0:9c4:b8c9:1bf2 with SMTP id
 su13-20020a17090703cd00b009c4b8c91bf2mr1497085ejb.60.1697561692367; Tue, 17
 Oct 2023 09:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231017090815.1067790-1-jeffxu@chromium.org> <20231017090815.1067790-6-jeffxu@chromium.org>
In-Reply-To: <20231017090815.1067790-6-jeffxu@chromium.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Oct 2023 09:54:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgwdHzOY_mT3y9gDHSMXZ8Xb5OYrK40-u9uRXLv25fNPA@mail.gmail.com>
Message-ID: <CAHk-=wgwdHzOY_mT3y9gDHSMXZ8Xb5OYrK40-u9uRXLv25fNPA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/8] mseal: Check seal flag for munmap(2)
To:     jeffxu@chromium.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, willy@infradead.org,
        gregkh@linuxfoundation.org, jeffxu@google.com,
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

On Tue, 17 Oct 2023 at 02:08, <jeffxu@chromium.org> wrote:
>
> Of all the call paths that call into do_vmi_munmap(),
> this is the only place where checkSeals = MM_SEAL_MUNMAP.
> The rest has checkSeals = 0.

Why?

None of this makes sense.

So you say "we can't munmap in this *one* place, but all others ignore
the sealing".

Crazy.

             Linus
