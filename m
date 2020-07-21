Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B772622865C
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jul 2020 18:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbgGUQpl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jul 2020 12:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730401AbgGUQpj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jul 2020 12:45:39 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E71C0619DB
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jul 2020 09:45:38 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id h28so15781290edz.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jul 2020 09:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gDLw9Dcw3YPv5eg4D1cNA4KJREZ+5phRSHLKAVCSqo4=;
        b=sWaGYNFNvLHfLnFqhWw6qD05fZJ3xzg9qHpo5WavC+HOa4H9WOO8R58q/QpUclGLry
         9IL4j0cs6T2tzt1njgxmRIdcHQe5/HHEbENPKtlUivjjo0774Sk4dPYbx6pNd9sj+Hba
         BGIPr7vGf3Wz1I0ZlD9HrORuybaANBJwq3p9No8LKz53+Z00y2Qe5yTAZzt4xK0KTD14
         opOIvzeXklxODdltPMXE0N5/iPdGcCtOPo35S5qmc4oYuzfqMy8yKOjCCu2miu7Qw5xg
         SL+vKrFM9D2pcb4rxS2e3UFTvCX3US6gxaITccHPkYUeoMaMFGays+1SH64jb+4HGZ6x
         uO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gDLw9Dcw3YPv5eg4D1cNA4KJREZ+5phRSHLKAVCSqo4=;
        b=cVbggqDhEhA7nObPNj7y+dl+qh/UOTgJBu8ToATIvlay0B9o2e3eYD9Zz+qKZX7fyk
         e7n6B7qmpHOEH9JdgwK9SYienSoEQnEBGze8By8DDSKWHiDVJt0+3rcSeDgYFB3l+X6t
         ebo2hY9T1bCO2mauY2w4fcUQHz7f7YICnFBKpWqSLZ6a73onGp8JXTpqgrrw+x81a/rv
         9U7reorue+uZUKCI80VOQkaVaTRmGhgP1/zqhcsJM33cYj0hPNQzF/xBkk5UhTfKsBFu
         R5c0c2j02hD/BkCuZMM2CErkCKDJPBL6ubantXdQn1Yyz1rC0f5KnhN4C1XoR49Ts2IK
         /AiA==
X-Gm-Message-State: AOAM533EdQ/jfghm5SKn+hbLxFoJSroFidIY0NyKdgPk3YxcEYtZ9XzT
        Nyw1XD1kpv/Y0PdLuZfnQxJFQYv86eBeUz6iVgdU1Q==
X-Google-Smtp-Source: ABdhPJwFbdgTKwMQXCY5MUgVfRS3h4/ECO4sk0mNo2dLY8J6zu/iV27GdbWz0YHGFmXds1uVOpAILDeHMdcYDWpz4wY=
X-Received: by 2002:aa7:d5cd:: with SMTP id d13mr27413638eds.370.1595349937400;
 Tue, 21 Jul 2020 09:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200715214312.2266839-1-haoluo@google.com> <20200715214312.2266839-3-haoluo@google.com>
 <CAEf4BzYxWk9OmN0QhDrvE943YsYd2Opdkbt7NQTO9-YM6c4aGw@mail.gmail.com>
 <CA+khW7i9wq0+2P_M46pEv-onGXL_=sW7xE=10CYeP_yjPh-Rpw@mail.gmail.com> <CAEf4BzY=6PH4YS8sX1SRFOj+6oQnfAk-f0P8+0XWMGMS+RJ0pw@mail.gmail.com>
In-Reply-To: <CAEf4BzY=6PH4YS8sX1SRFOj+6oQnfAk-f0P8+0XWMGMS+RJ0pw@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 21 Jul 2020 09:45:26 -0700
Message-ID: <CA+khW7j93gtB-e8x1-Fd9sTrOaHHD7suzVaBh9gPjnOJux+-AA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/2] selftests/bpf: Test __ksym externs with BTF
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Ack. Will have that in v2.

Hao

On Mon, Jul 20, 2020 at 7:37 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jul 20, 2020 at 1:28 PM Hao Luo <haoluo@google.com> wrote:
> >
> > >
> > > This should ideally look like a real global variable extern:
> > >
> > > extern const struct rq runqueues __ksym;
> > >
> > >
> > > But that's the case for non-per-cpu variables. You didn't seem to
> > > address per-CPU variables in this patch set. How did you intend to
> > > handle that? We should look at a possible BPF helper to access such
> > > variables as well and how the verifier will prevent direct memory
> > > accesses for such variables.
> > >
> > > We should have some BPF helper that accepts per-CPU PTR_TO_BTF_ID, and
> > > returns PTR_TO_BTF_ID, but adjusted to desired CPU. And verifier
> > > ideally would allow direct memory access on that resulting
> > > PTR_TO_BTF_ID, but not on per-CPU one. Not sure yet how this should
> > > look like, but the verifier probably needs to know that variable
> > > itself is per-cpu, no?
> > >
> >
> > Yes, that's what I was unclear about, so I don't have that part in
> > this patchset. But your explanation helped me organize my thoughts. :)
> >
> > Actually, the verifier can tell whether a var is percpu from the
> > DATASEC, since we have encoded "percpu" DATASEC in btf. I think the
> > following should work:
> >
> > We may introduce a new PTR_TO_BTF_VAR_ID. In ld_imm, libbpf replaces
> > ksyms with btf_id. The btf id points to a KIND_VAR. If the pointed VAR
> > is found in the "percpu" DATASEC, dst_reg is set to PTR_TO_BTF_VAR_ID;
> > otherwise, it will be a PTR_TO_BTF_ID. For PTR_TO_BTF_VAR_ID,
> > reg->btf_id is the id of the VAR. For PTR_TO_BTF_ID, reg->btf_id is
> > the id of the actual kernel type. The verifier would reject direct
> > memory access on PTR_TO_BTF_VAR_ID, but the new BPF helper can convert
> > a PTR_TO_BTF_VAR_ID to PTR_TO_BTF_ID.
>
> Sounds good to me as a plan, except that PTR_TO_BTF_VAR_ID is a
> misleading name. It's always a variable. The per-CPU part is crucial,
> though, so maybe something like PTR_TO_PERCPU_BTF_ID?
>
> >
> > Hao
