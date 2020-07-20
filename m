Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7E6226FB6
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jul 2020 22:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgGTU2O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jul 2020 16:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgGTU2O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jul 2020 16:28:14 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34272C061794
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jul 2020 13:28:14 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id s21so14464964ilk.5
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jul 2020 13:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnROxpLTebfdg0VQxLM+qOeJIWXx+3VtqAPYTCwBg5A=;
        b=e+YdMIZbfHuIN71zlAV9pte6XTKkIrMTuKqwzmQZxOkC954LaZlH12s9VMPeezYI/f
         Jzv9Vzo+NY9vuVMW7D959S2Cdvs9ichUR+pxGCUw8tgcn9EqQtUg+gaQcJ0/MHWorqZG
         /UDNGpn0SIDSdKMAMJQOHR7Re670rfu9J3bP/upy5wVU8JbcSWFw7jSVkEhpbdUvmmwy
         2XkrGG80hp9CMfvxOaOhxtD9ErS7CIYgMtAd9PUGPwpxpdRbgachvMNiitkCzU4SDh6e
         WfI7egJn+xCqdGw1WJUiGfrYepxPaHbyfX45EeOp+TCrHvYYLqEQ82fwEjcD0Fx5Lj35
         diTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnROxpLTebfdg0VQxLM+qOeJIWXx+3VtqAPYTCwBg5A=;
        b=hJD8wUmJ4WxGPxUvoWT3wWY6NpXF4yU/7gI+PY8VvoQOZWysJvN+su0+GlYa8rkdtP
         b0isxocKOS8+R5ibD+qQaVKWnmHU5DI7k6Al7Latt9VuPD9d2uGj+Z+IkN8qFSIi/sWW
         y2OPn3n862YaflcX9YiGF9zy0dWmklurudFECH/xkhDkQVkk1WF6Z45CLNhPl+B3LGXp
         1N7zFVXtv/Y5GN+N049JLKLUN0wIvKulY1eldodVZIJ9EyRonXgpd91DwDU6EOEXmHXc
         QskolB/3hGHoBj4LuN0ofDv6Xyp5PATJ+wmvwptpBGAevx4FBZl3X42CKmHXr/8Y+3lv
         m7aA==
X-Gm-Message-State: AOAM530ytAr0/ZsZ2XPykF8a7Br96Fbb+C9hWcNU+C5ZLzD1JkIc2PsT
        vF+2ENwam7w/AIUrkmql+rFQaJytd7/Qerqhu2d4+w==
X-Google-Smtp-Source: ABdhPJziZBrq7Pg+3/2EhDfmIw4gaLRIAxqYeGhCSSFHEMO8VPg5I18oqjIhNgbraAGINUvLf5g9njXh6av9exRpt4U=
X-Received: by 2002:a92:bb57:: with SMTP id w84mr25017823ili.104.1595276893343;
 Mon, 20 Jul 2020 13:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200715214312.2266839-1-haoluo@google.com> <20200715214312.2266839-3-haoluo@google.com>
 <CAEf4BzYxWk9OmN0QhDrvE943YsYd2Opdkbt7NQTO9-YM6c4aGw@mail.gmail.com>
In-Reply-To: <CAEf4BzYxWk9OmN0QhDrvE943YsYd2Opdkbt7NQTO9-YM6c4aGw@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 20 Jul 2020 13:28:02 -0700
Message-ID: <CA+khW7i9wq0+2P_M46pEv-onGXL_=sW7xE=10CYeP_yjPh-Rpw@mail.gmail.com>
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

>
> This should ideally look like a real global variable extern:
>
> extern const struct rq runqueues __ksym;
>
>
> But that's the case for non-per-cpu variables. You didn't seem to
> address per-CPU variables in this patch set. How did you intend to
> handle that? We should look at a possible BPF helper to access such
> variables as well and how the verifier will prevent direct memory
> accesses for such variables.
>
> We should have some BPF helper that accepts per-CPU PTR_TO_BTF_ID, and
> returns PTR_TO_BTF_ID, but adjusted to desired CPU. And verifier
> ideally would allow direct memory access on that resulting
> PTR_TO_BTF_ID, but not on per-CPU one. Not sure yet how this should
> look like, but the verifier probably needs to know that variable
> itself is per-cpu, no?
>

Yes, that's what I was unclear about, so I don't have that part in
this patchset. But your explanation helped me organize my thoughts. :)

Actually, the verifier can tell whether a var is percpu from the
DATASEC, since we have encoded "percpu" DATASEC in btf. I think the
following should work:

We may introduce a new PTR_TO_BTF_VAR_ID. In ld_imm, libbpf replaces
ksyms with btf_id. The btf id points to a KIND_VAR. If the pointed VAR
is found in the "percpu" DATASEC, dst_reg is set to PTR_TO_BTF_VAR_ID;
otherwise, it will be a PTR_TO_BTF_ID. For PTR_TO_BTF_VAR_ID,
reg->btf_id is the id of the VAR. For PTR_TO_BTF_ID, reg->btf_id is
the id of the actual kernel type. The verifier would reject direct
memory access on PTR_TO_BTF_VAR_ID, but the new BPF helper can convert
a PTR_TO_BTF_VAR_ID to PTR_TO_BTF_ID.

Hao
