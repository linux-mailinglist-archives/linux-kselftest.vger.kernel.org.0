Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10E27D053F
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 01:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346677AbjJSXGh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Oct 2023 19:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbjJSXGg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Oct 2023 19:06:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F8E106
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Oct 2023 16:06:34 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507a98517f3so246757e87.0
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Oct 2023 16:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697756792; x=1698361592; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vyephYMGi9WkrF+MMy/aTcTtLZAvJsqtW+X3GM9oKyI=;
        b=XLScS6SxFxKUAqTUem7TJ54dAnmfCURESHowXgmWQ1vxH0MjIQLMv4NiccWfdNQ81o
         5ZcLccrDnSzYHjqc64UjvxOpSvRJNgjkHzArwGJMtQn3Yqxrc6SAQlHDxcgmA7MXLcPa
         jhxI7YiRmCnbCgVqS0vpsurLG8UspeVIvZumA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697756792; x=1698361592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vyephYMGi9WkrF+MMy/aTcTtLZAvJsqtW+X3GM9oKyI=;
        b=fKQMT8ElG3JWTGS90V3DpyhQv7eFn7fwJ9CxLdTt1riCowlEy6X4nzNh9HUPX8KwTw
         w5lpoCsnv1FLFe66bhQcJ39EwNDpL2Wg1ktRXe5FxnuKX1BsvLyfShNaiUk+g5QZU7EA
         7EkT+ra4KGpGcpzkJOKFyLlwHjD+aCuIAn5Q0hRQhUSwUuxqF5wb/xZDcM0it+6+ooRC
         oCf6CFk8lq0yvTzx3qNFfINDB+u7OIsEd50Qvkvm7ghB+QcZwDNLSUYGY9soZ1mDj7yt
         8sxAsYppN7jApXu3L0FozqTuV4mtbNDUGTpa/HKg9MGTvSMdAhxdo3gR3AXX8bIDaksv
         4IkQ==
X-Gm-Message-State: AOJu0YzcqhB/1EoWY4uJNWRFk/g7fnQM29QOvRkyBK6FD21QT3eXIQWa
        kix+JMW2422EjSP2VHon7bCWcz3kw8KrCHujpJZD8wcI
X-Google-Smtp-Source: AGHT+IGjN9Aq5gF8anADfrNQq9nWMBqUlmGInyCjt8fXZOHasbHREwrBmy72dI+BiE4sMIhYF7iQog==
X-Received: by 2002:ac2:4c0c:0:b0:507:96cd:9288 with SMTP id t12-20020ac24c0c000000b0050796cd9288mr73451lfq.45.1697756792764;
        Thu, 19 Oct 2023 16:06:32 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id h2-20020ac25962000000b005079ec79bfesm79789lfp.93.2023.10.19.16.06.31
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 16:06:32 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-507c50b7c36so220597e87.3
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Oct 2023 16:06:31 -0700 (PDT)
X-Received: by 2002:ac2:533c:0:b0:503:3453:ea7a with SMTP id
 f28-20020ac2533c000000b005033453ea7amr52431lfh.66.1697756791018; Thu, 19 Oct
 2023 16:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org> <ZS1URCBgwGGj9JtM@casper.infradead.org>
 <CAKbZUD2A+=bp_sd+Q0Yif7NJqMu8p__eb4yguq0agEcmLH8SDQ@mail.gmail.com>
 <CALmYWFtOgMAQDGNoM6k2Ev4kMHD396wwH+rVDODaSjsyVMDogg@mail.gmail.com>
 <CAKbZUD2j1jbomCAVxUX_JmG1rfa8udc=5SqVOpDgc-3GnSTbAQ@mail.gmail.com>
 <CALmYWFv7jzOj5HPcYct=UzYKPrwwvtN1EQeHioQHDPwGFvL5Ug@mail.gmail.com>
 <CALmYWFt71Vi6ySiZhW+tmE-LZL7Tnu-dQ1uMO10DUkASUTxzKA@mail.gmail.com> <CAKbZUD12pEaDCLysOpT3yL3064=P28Pm3c=UBqhOZYeBP026WA@mail.gmail.com>
In-Reply-To: <CAKbZUD12pEaDCLysOpT3yL3064=P28Pm3c=UBqhOZYeBP026WA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Oct 2023 16:06:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgDv5vPx2xoxNQh+kbvLsskWubGGGK69cqF_i4FkM-GCw@mail.gmail.com>
Message-ID: <CAHk-=wgDv5vPx2xoxNQh+kbvLsskWubGGGK69cqF_i4FkM-GCw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     Jeff Xu <jeffxu@google.com>, Matthew Wilcox <willy@infradead.org>,
        jeffxu@chromium.org, akpm@linux-foundation.org,
        keescook@chromium.org, sroettger@google.com, jorgelo@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, surenb@google.com, alex.sierra@amd.com,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 19 Oct 2023 at 15:47, Pedro Falcato <pedro.falcato@gmail.com> wrote:
> >
> > For mprotect()/mmap(), is Linux implementation limited by POSIX ?
>
> No. POSIX works merely as a baseline that UNIX systems aim towards.
> You can (and very frequently do) extend POSIX interfaces (in fact,
> it's how most of POSIX was written, through sheer
> "design-by-committee" on a bunch of UNIX systems' extensions).

We can in extreme circumstances actually go further than that, and not
only extend on POSIX requirements, but actively even violate them.

It does need a very good reason, though, but it has happened when
POSIX requirements were simply actively wrong.

For example, at one point POSIX required

     int accept(int s, struct sockaddr *addr, size_t *addrlen);

which was simply completely wrong. It's utter shite, and didn't
actually match any reality.

The 'addrlen' parameter is 'int *', and POSIX suddenly trying to make
it "size_t" was completely unacceptable.

So we ignored it, told POSIX people that they were full of sh*t, and
they eventually fixed it in the next version (by introducing a
"socklen_t" that had better be the same as "int").

So POSIX can simply be wrong.

Also, if it turns out that we had some ABI that wasn't
POSIX-compatible, the whole "don't break user space" will take
precedence over any POSIX concerns, and we will not "fix" our system
call if people already use our old semantics.

So in that case, we generally end up with a new system call (or new
flags) instead.

Or sometimes it just is such a small detail that nobody cares - POSIX
also has a notion of documenting areas of non-conformance, and people
who really care end up having notions like "conformance vs _strict_
conformance".

                 Linus
