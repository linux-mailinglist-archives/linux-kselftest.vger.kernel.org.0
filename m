Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD0634B7DF
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Mar 2021 16:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhC0PR2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Mar 2021 11:17:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230170AbhC0PRZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Mar 2021 11:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616858243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sWbU2NHEP/nHwdL8rp425gC++yCS11BbCfWAnc1DbmU=;
        b=GbYVkBAyNfvlkGfqiD4hHkWJTyrmuXLj/ZLmrsvfN9ZGcvT4wDtJH246WC/BVXs0N+eo7Q
        2drtgw37KZQ0BYVSYCgIS8yGmfEL2cVpLfe1hTxTXhbLYGkpnoYPeGBr9M0++zuCoAwpjj
        9so5yu+Gh73uRgPrzaRflvViBdoMvwA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-k2snb_vYO76agLlTqApzJQ-1; Sat, 27 Mar 2021 11:17:21 -0400
X-MC-Unique: k2snb_vYO76agLlTqApzJQ-1
Received: by mail-ed1-f71.google.com with SMTP id i12so2728102edu.23
        for <linux-kselftest@vger.kernel.org>; Sat, 27 Mar 2021 08:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=sWbU2NHEP/nHwdL8rp425gC++yCS11BbCfWAnc1DbmU=;
        b=CYjMy+mgiGSgRYoIs0oO0I0d/if2GkfP8uUyH4FswirycHQ0fEfsgkh5THbEev3a79
         b14AADLAtDQIGg3zh/F3A35ETEe4guKCYoHIyoY6A7czRLlMe6jM9Y7V7RFJiB4yFzog
         +WqcvkDtJ6hr2ls3SCII2YpPNm1SRi21Z1YShxzKTo54SpdC29ex7kUyvHpXrQapDQ0s
         GRHuKRkXWQeHjoGi7Dnf12WeMnbyttku5FD6bhDXCr0lRP0l00EP1m+zTe1YqoCCMb9r
         GCRF/0GY8UoEYc5js7V5k6UTTOuqpEkfPLNuX9EgYThT0an9Z8XpNeqB9Zn+tUgQkLLm
         zanQ==
X-Gm-Message-State: AOAM533qupMj5Jb7JNVcGkzLvKBrrzySA345baiYIMl9jCvzxmYsNVHD
        ADdieQyvluVY/SYMxYRlHvDVbqO9GM4/Toekxnen1SQGvZEAWPQZL0YFlyB4zz1q04idMRTZV2h
        TDlDWxtmdfVEGrSIY2ZdTKnRglTsQ
X-Received: by 2002:a17:907:c08:: with SMTP id ga8mr8638250ejc.376.1616858239744;
        Sat, 27 Mar 2021 08:17:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjelz8rGQfFMkVntcNGTpZVUyjEss2KFI7rT4x0i91pJuKEm7MOTj/nTjCEznGZHmjScXEpA==
X-Received: by 2002:a17:907:c08:: with SMTP id ga8mr8638215ejc.376.1616858239358;
        Sat, 27 Mar 2021 08:17:19 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id m14sm5978144edr.13.2021.03.27.08.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 08:17:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7FDD31801A3; Sat, 27 Mar 2021 16:17:16 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, brouer@redhat.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 5/5] libbpf: add selftests for TC-BPF API
In-Reply-To: <20210327021534.pjfjctcdczj7facs@ast-mbp>
References: <20210325120020.236504-1-memxor@gmail.com>
 <20210325120020.236504-6-memxor@gmail.com>
 <20210327021534.pjfjctcdczj7facs@ast-mbp>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 27 Mar 2021 16:17:16 +0100
Message-ID: <87h7kwaao3.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Thu, Mar 25, 2021 at 05:30:03PM +0530, Kumar Kartikeya Dwivedi wrote:
>> This adds some basic tests for the low level bpf_tc_* API and its
>> bpf_program__attach_tc_* wrapper on top.
>
> *_block() apis from patch 3 and 4 are not covered by this selftest.
> Why were they added ? And how were they tested?
>
> Pls trim your cc. bpf@vger and netdev@vger would have been enough.
>
> My main concern with this set is that it adds netlink apis to libbpf while
> we already agreed to split xdp manipulation pieces out of libbpf.
> It would be odd to add tc apis now only to split them later.

We're not removing the ability to attach an XDP program via netlink from
libxdp, though. This is the equivalent for TC: the minimum support to
attach a program, and if you want to do more, you pull in another
library or roll your own.

I'm fine with cutting out more stuff and making this even more minimal
(e.g., remove the block stuff and only support attach/detach on ifaces),
but we figured we'd err on the side of including too much and getting
some feedback from others on which bits are the essential ones to keep,
and which can be dropped.

> I think it's better to start with new library for tc/xdp and have
> libbpf as a dependency on that new lib.
> For example we can add it as subdir in tools/lib/bpf/.

I agree for the higher-level stuff (though I'm not sure what that would
be for TC), but right now TC programs are the only ones that cannot be
attached by libbpf, which is annoying; that's what we're trying to fix.

-Toke

