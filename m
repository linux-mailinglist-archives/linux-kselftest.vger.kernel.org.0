Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCD1452D07
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Nov 2021 09:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhKPInj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Nov 2021 03:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbhKPInN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Nov 2021 03:43:13 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A488C0613B9
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Nov 2021 00:40:16 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso1281235wms.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Nov 2021 00:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qnawSinR00jGkiR604ulJPH5DCzCHnjmTzCrYFylOfk=;
        b=RJDilG4W6T8AU7Z2CWvrvKmxeWytdAQA0H2u+awCkD7RmB2qCyBejhhTRqCUHc5E/U
         i6lDbCzg4nC191QNTjIuiFmg7YzSpIYcbyCyuzK70Jx7y/RJugPKtLgWdGEzpaFUN0Rp
         LQWyFPAZmiDPFeZRmuJqrdsXmOcfYj+OmPgfXyKEk8tdzyFOnPOFbOGuuHkMlBoBISc5
         dnDa9CYYW2/yh/eqqoPdPkB2lg64ybmilyikmd5adQzHY1Q4j5Sc1XCZhWw8EUhMkQrX
         BtUOITv1Jv4duL4n0lRAZ5Evg5tkpKAtDa3D8PUqiDIdHbWENR4W7BDJMjDYnFgARrAj
         1xcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qnawSinR00jGkiR604ulJPH5DCzCHnjmTzCrYFylOfk=;
        b=XYGYG1CCAgpXPQg5+2Zvq0nWZgaO2t0D6miIJnObk+IyBcOnqZG+/RRWxgpOnRUuZK
         MxFKjFS4EGiOxqCSflBtDLoa8wX/yfDNXjIMEzk00lvDv+FPSnDQDwSVDnzx5ATP1H5e
         U7XM6RP/MsmlWy6czd6shqyZ2e4JgLUWUu2WwbCkDOPcr4dFWHkT0iIADvPEgrb/EB2U
         0mlTDuy+zmvFaNkbXtFNHYshdLpJZOLa/AOUmSgqzZlFCp6IMp7VI9tdRKJQ/LwkPN2g
         9fFyGdXIEEZby4YmKaukUpOSUDcEXfk389ZCmW3g7LE0v1OvhSYEoL4vrLFrD3ztxGV6
         Ij2g==
X-Gm-Message-State: AOAM531EwG2Bu7NMMU0k7NiSSN8jE26Toa9w6Mb6PmRVBmzo9Vtjn+0p
        Emn4e/5o7+TTzQmghHMdF9P1qA==
X-Google-Smtp-Source: ABdhPJzuCCRalt2h/9o78YccA6LRgEiYgCL0sRVjpfqpxsdJSSJ1hWKDOZO42qQ1ImktqzI/dAB9UA==
X-Received: by 2002:a7b:c389:: with SMTP id s9mr5850358wmj.133.1637052014862;
        Tue, 16 Nov 2021 00:40:14 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id j40sm1910211wms.19.2021.11.16.00.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 00:40:14 -0800 (PST)
Date:   Tue, 16 Nov 2021 08:39:53 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf] tools/runqslower: Fix cross-build
Message-ID: <YZNuWUEBG9Jbzerx@myrica>
References: <20211112155128.565680-1-jean-philippe@linaro.org>
 <d3a19501-01ee-a160-2275-c83fb0fb04b7@isovalent.com>
 <YY6WLDizLBxnhgnP@myrica>
 <CAEf4BzbS-4sWORntzqh7qhEo=5cpzca0WA5ars70LxwzZwxgKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbS-4sWORntzqh7qhEo=5cpzca0WA5ars70LxwzZwxgKA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 15, 2021 at 10:10:03PM -0800, Andrii Nakryiko wrote:
> On Fri, Nov 12, 2021 at 8:28 AM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > On Fri, Nov 12, 2021 at 04:17:21PM +0000, Quentin Monnet wrote:
> > > 2021-11-12 15:51 UTC+0000 ~ Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > Commit be79505caf3f ("tools/runqslower: Install libbpf headers when
> > > > building") uses the target libbpf to build the host bpftool, which
> > > > doesn't work when cross-building:
> > > >
> > > >   make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C tools/bpf/runqslower O=/tmp/runqslower
> > > >   ...
> > > >     LINK    /tmp/runqslower/bpftool/bpftool
> > > >   /usr/bin/ld: /tmp/runqslower/libbpf/libbpf.a(libbpf-in.o): Relocations in generic ELF (EM: 183)
> > > >   /usr/bin/ld: /tmp/runqslower/libbpf/libbpf.a: error adding symbols: file in wrong format
> > > >   collect2: error: ld returned 1 exit status
> > > >
> > > > When cross-building, the target architecture differs from the host. The
> > > > bpftool used for building runqslower is executed on the host, and thus
> > > > must use a different libbpf than that used for runqslower itself.
> > > > Remove the LIBBPF_OUTPUT and LIBBPF_DESTDIR parameters, so the bpftool
> > > > build makes its own library if necessary.
> > > >
> > > > In the selftests, pass the host bpftool, already a prerequisite for the
> > > > runqslower recipe, as BPFTOOL_OUTPUT. The runqslower Makefile will use
> > > > the bpftool that's already built for selftests instead of making a new
> > > > one.
> > > >
> > > > Fixes: be79505caf3f ("tools/runqslower: Install libbpf headers when building")
> > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> > >
> > > I realised too late I should have cc-ed you on those patches, apologies
> > > for not doing so. Thank you for the fix!
> >
> > No worries, I usually try to catch build issues in bpf-next but missed it
> > this time. I'm still slowly working towards getting automated testing on
> > Arm targets, which will catch regressions quicker.
> 
> Are you planning to contribute it to BPF CI? Or you meant you have
> your own separate system?

At the moment I'm looking at adding it to LKFT, which does regression
testing on various Arm boards (https://lkft.linaro.org/about/). The only
bit missing for that is support for cross-building tools with clang, which
I'll send shortly.

Thanks,
Jean
