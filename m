Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18A22F482B
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jan 2021 11:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbhAMKBB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jan 2021 05:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbhAMKBA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jan 2021 05:01:00 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C60C061794
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jan 2021 02:00:20 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id i24so1218861edj.8
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jan 2021 02:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mDq1RY5y4eEZgqb0bS7g6f+LXxKSwiLQTHiMJzxqexg=;
        b=rTJbY8DRu648BZH/+lJK+72SkYHBVa+hiWmYAbvlx8UriOOwPx/nhb6g/F2+E38Jtb
         ty02axbJTrYGm8k+f+x2YMHtejX4KSQuvKby8QXONWcTXzLJ1y+OY3UlyvIZIToONh01
         zQlGXZfEwUDAqK0PZYG1ixLy2t1dhUdhWK30eNhZrjCuOGjd5Box/jA8ehqZ6lIGUNLE
         LNGBhBUGbg7P/2rHpSHW8VZtzxkpSMUeaOSgfxo41WA9V08W1gTdRgxiP0v/NmJDva7J
         SLYg3pPEqrm2v9OEoOxkTCX1xHJRu8rdZ25ZEUarVvoW2e9uhFvT+o+jRIxyJsX3kOhn
         /L9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mDq1RY5y4eEZgqb0bS7g6f+LXxKSwiLQTHiMJzxqexg=;
        b=dQfsqR90pbd7A8e06Enb122u31h2Cyd348IszDMBgHewukwSF7sQh1RKT2y7dzS2fu
         pplLEk34iSzvs31lWqjeipUM5/HAy8nu9cho4IsJq3t0V2mQb5m2sdeucfkxJH4GfQJi
         FmohbZ0vszY0VQXM3IKDz/E5O5+RRKldRGOSw7p+XY5EBIcf1dFXSevvVzfLR8joqEft
         VXo63RG7PKgFJjfZCUvxvLxq3WZgbq+exRSxSYkqrwimnYp/k/pJWaP8PoBsizXnBYFj
         Jk3S6yGsg4q6iPPFhSyeKWtX2hWJxwXP5EoYWi+mzSYK0IWWJXReozz/vtOjNSpYPDIs
         aQfw==
X-Gm-Message-State: AOAM532nGUxfYcYR+iwVd9Ph9lWwS0jOxZPRVpNXaX/uM6Io0kNe5MbQ
        baXtt6saK40HHspkYesWShRIJQ==
X-Google-Smtp-Source: ABdhPJxbCmKpaqxk0UgxgOAZXFennlSWV3/iUh9AppwiVn/Lh9NJIpYxeZHloQLMlOliNy4Fw4lmKg==
X-Received: by 2002:aa7:cb16:: with SMTP id s22mr1158594edt.53.1610532018913;
        Wed, 13 Jan 2021 02:00:18 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id oq7sm516281ejb.63.2021.01.13.02.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 02:00:17 -0800 (PST)
Date:   Wed, 13 Jan 2021 10:59:59 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: Install btf_dump test cases
Message-ID: <X/7En4i4NHTmLrQQ@myrica>
References: <20210112135959.649075-1-jean-philippe@linaro.org>
 <20210112135959.649075-6-jean-philippe@linaro.org>
 <CAEf4BzZhDut7QAG-M7cxtVxehebM=bge6uckeU_aJ6yp+pSu9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZhDut7QAG-M7cxtVxehebM=bge6uckeU_aJ6yp+pSu9w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 12, 2021 at 12:55:02PM -0800, Andrii Nakryiko wrote:
> > -TEST_FILES = xsk_prereqs.sh
> > +TEST_FILES = xsk_prereqs.sh \
> > +       progs/btf_dump_test_case_syntax.c \
> > +       progs/btf_dump_test_case_ordering.c \
> > +       progs/btf_dump_test_case_padding.c \
> > +       progs/btf_dump_test_case_packing.c \
> > +       progs/btf_dump_test_case_bitfields.c \
> > +       progs/btf_dump_test_case_multidim.c \
> > +       progs/btf_dump_test_case_namespacing.c
> 
> 
> maybe wildcard(progs/btf_dump_test_case_*) instead? one less thing to
> remember to update, if we ever add another test case

Sure, I'll send a v2

Thanks,
Jean
