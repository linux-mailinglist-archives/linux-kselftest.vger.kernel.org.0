Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AFC2F57AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jan 2021 04:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbhANCEk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jan 2021 21:04:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729351AbhAMWbU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jan 2021 17:31:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7910B23436
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jan 2021 22:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610576967;
        bh=mHvKCEj3/7nBBxrW4tVVo0k16Rhddoa7YQd2OFic81Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FVFcyxYuFODJwc1NmCq6dGYUEoqC8dzhGHg0FuoCqh5X/YZZkUMGkePdU8HMTwX/t
         jfKtp1SjnptuInY/ZByd0inH/ALCBa4jES85UEPmrbobY0vm1aRGAjO1FX2Hjxu0yS
         gLVKbjdZ8mBUhuVzF9QyrZVXqPKwznB+/+Qrgc6Zy0l6P1LiCMOyS3DX5e7yvD9Cgf
         x8n3IsFITJilMRqyu8twyH4Ke/Wufmh+GciuVls7JYHwIcTqszFYFWxmznlp+cqVZC
         Qow/5H0y6+He63QtAcrQ1Cb8GkDm5mUvGfJBTBt6UJVGX7xH0DJqn4bAlEud9gFEhx
         a8xdjguWtOnYQ==
Received: by mail-lj1-f174.google.com with SMTP id f11so4341780ljm.8
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jan 2021 14:29:27 -0800 (PST)
X-Gm-Message-State: AOAM533u4AmueeulQquYi1ZyO593jlSsYakn773nnH9vXZHARdbIbK0D
        W6T/l4mWexmI/IxejbNPjuLogI5RYvPZjfj+WiGQ/Q==
X-Google-Smtp-Source: ABdhPJwSFcQoW+n63mgov3Msp2haXfpDPP8xwUvqAEp/d3ESBqh434XmbQzSCR2/v+Bz6JmsJNnCb6xYp2oVwbjPD3g=
X-Received: by 2002:a2e:b5dc:: with SMTP id g28mr1848338ljn.112.1610576965768;
 Wed, 13 Jan 2021 14:29:25 -0800 (PST)
MIME-Version: 1.0
References: <20210113053810.13518-1-gilad.reti@gmail.com>
In-Reply-To: <20210113053810.13518-1-gilad.reti@gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 13 Jan 2021 23:29:16 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5o7QBR1stFTqxGJv2gbS0qsVKZW6BJ3iBUagy5_S+N0w@mail.gmail.com>
Message-ID: <CACYkzJ5o7QBR1stFTqxGJv2gbS0qsVKZW6BJ3iBUagy5_S+N0w@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: support PTR_TO_MEM{,_OR_NULL} register spilling
To:     Gilad Reti <gilad.reti@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 13, 2021 at 6:38 AM Gilad Reti <gilad.reti@gmail.com> wrote:
>
> Add support for pointer to mem register spilling, to allow the verifier
> to track pointers to valid memory addresses. Such pointers are returned
> for example by a successful call of the bpf_ringbuf_reserve helper.
>
> The patch was partially contributed by CyberArk Software, Inc.
>
> Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
> Suggested-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Gilad Reti <gilad.reti@gmail.com>

Acked-by: KP Singh <kpsingh@kernel.org>
