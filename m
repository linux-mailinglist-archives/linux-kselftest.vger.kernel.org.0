Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DAC27E54E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Sep 2020 11:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgI3JiG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Sep 2020 05:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728399AbgI3JiG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Sep 2020 05:38:06 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EF1C0613D0
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 02:38:06 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id m12so1203978otr.0
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 02:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TfzEw5x0NiRRju3CPhetGru5/pRnoeNXGN+8SqIx2Xg=;
        b=xSNlabK0wj27CX+1Qcx2VTudu5ZW9FuibpTZ0nWLnP7KiZc1Y26yZKB8Eh31WGDcm6
         8swxBpO09W7KLsdWCfcJLGpNOa9gUdbATUzXP1GsumP4vcMrlnAxEcLj8eox2M6rO4QT
         LYOYeyB9ved5GDo1QpgQlQh7SernXIJ3tBNMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TfzEw5x0NiRRju3CPhetGru5/pRnoeNXGN+8SqIx2Xg=;
        b=uigNKfK7Ygvs31jcu4fotrFh8JyPpmYbI0XXl3+ZyKxg542m5AlNadiRPMk9QagLf4
         ZFnx9WM4GORwnlv/7apLP3oBgsFMH8yQ217G1wzVw/xHW2iUCwqLmgKhXSDwSigT1f1L
         FAOQzKVCslce+IkjCV0lqzh4+5UIrPbiv9E0PA+58se967mZB0I06ThqSMzQfAbDKyln
         clu4vURiJL+xVOF1W93t5m4Ak+wxDnr6yqg0WfJB0rBLDQUgkfis6Q2lwB3tmZt4UHPB
         zbtg3W+9eJgYOEnw6k94BHGl6vjpUKcACrX7fh7VjD2YzBh4aQS2zYV+T08G8kBuiOQy
         HarQ==
X-Gm-Message-State: AOAM532ZhO/O40obOD5AzNgTi+KwlQMFPnNq+utDnsnrWvxU2fziKJlE
        zAyMXMustleJrH3XRtxLiBkmGUZHcnHtQJ/KR4zseg==
X-Google-Smtp-Source: ABdhPJyEFIY605VtSWbEn3ZkRUtaTSsucUs4nlzLVLBbPX+b1HdTLS14fXU+7V2yAvC7hyiex42j1bUzvOLQo1flGe0=
X-Received: by 2002:a9d:6e90:: with SMTP id a16mr962799otr.132.1601458684868;
 Wed, 30 Sep 2020 02:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200928090805.23343-1-lmb@cloudflare.com> <20200928090805.23343-5-lmb@cloudflare.com>
 <20200929060619.psnobg3cz3zbfx6u@kafai-mbp> <CACAyw9-hSfaxfHHMaVMVqBU7MHLoqgPyo55UwQ3w7NKREHcCxw@mail.gmail.com>
 <20200929172340.hogj6zficvhkpibx@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200929172340.hogj6zficvhkpibx@kafai-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 30 Sep 2020 10:37:53 +0100
Message-ID: <CACAyw9_wfD39OCKR5zMN4g=GjcYH31Dg7skoyhPVHVTspgvarA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] selftest: bpf: Test copying a sockmap and sockhash
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@cloudflare.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 29 Sep 2020 at 18:23, Martin KaFai Lau <kafai@fb.com> wrote:

...

> > Yeah, I think so. We'd need to do something similar to your
> > sock_common work for PTR_TO_RDONLY_BUF_OR_NULL. The fact that the
> > pointer is read only makes it a bit more difficult I think. After
> I thought the key arg should be used as read-only in the map's helper.
> or there is map type's helper that modifies the key?

I don't know, that's what I meant by more difficult. If map keys are
always read-only like you say this would be straight forward to do
(famous last words).

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
