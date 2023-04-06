Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9C16DA5B5
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Apr 2023 00:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbjDFWZT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 18:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjDFWZS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 18:25:18 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0A67DB1
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Apr 2023 15:25:14 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id go23so481605pjb.4
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Apr 2023 15:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680819914; x=1683411914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1AjHf2kCvIdLeYFh5xT+QDV5+o6aZpVh3ZQromHqS0=;
        b=s3vxtsDPoSXlMifI4rs+/vS/5nH+8PhwE9xs9s2dgUzHr8Wd3iRtFg3A8X9ZOMc66B
         DDWHb/HSBO6gvjMvYXddd2ncUcHdon4UINWwRxDu/DSlHq7aLz0YDSpzGjy8NubKQ2s1
         GedeUwwhCURiLXGy9Pxq6czCKovsxRc09laMA9ZvWQwov+ZavxiPAU5CL4CISipg3LEr
         fMH1kDRJSjjZmUubc2XGwOX0HMdwZylp3slecMV9+YfDhnsA3/2ABFqjoUTfrfpy8mZb
         pE8p3K/8k07JlB5CbT8c9Ofk3I0XP0L0P12C9kC4arPcCY0hJCOrLiE8Q8S2hOKn/zmD
         y8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680819914; x=1683411914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1AjHf2kCvIdLeYFh5xT+QDV5+o6aZpVh3ZQromHqS0=;
        b=SphtBc2t2lpW4mMyjN3h23zGyNWP7nEitpSaj58AgtCEgo0kIXFDrhwdJtGtMG5yBK
         SmCDmOAVes77VKcP/5u32SKYGgQ14IM2+fCOHXft1B2mD42bnJy8UkMcQ/CLQ84Gq+8+
         CD/c1mOKvrhEYX/FmCWxA5E79zoVKr6x1vWSVyuGqk9UBOGjFj0AJtoLtUn7xH8AgPX1
         +io4C6vpLmUnyiKUwqrtqEQVnFShDUL5WltiDKP/btCOKbappvPtQuxsp1UNaEX+NuBP
         bNOuqaZR7ukIiHxi8cOF1Z2eURlZC1OIa4ircnjpCF+a0e9sV7h6gf3X+Z1huOYAjXxW
         310Q==
X-Gm-Message-State: AAQBX9cT/MKrLSVKiH/4DKPExTEMLt8igLHfKTEI54oIsUG7iuhWihsZ
        PjRhTESEAlbaVFyCotoiUENIovyTBBIMnkz3T+cVGw==
X-Google-Smtp-Source: AKy350b4MSYhRrQppF3SFeUUd2Wqh3mvfTH0sbdW7A7SJ35ELwO/9HCnaPp1HV1GdJEDIqfIeIepgzvIq/pDoig2y14=
X-Received: by 2002:a17:90a:a004:b0:23d:3b06:ee13 with SMTP id
 q4-20020a17090aa00400b0023d3b06ee13mr64109pjp.1.1680819914155; Thu, 06 Apr
 2023 15:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com> <20230406004018.1439952-3-drosen@google.com>
 <CAEf4BzakRfffU9+wLBNfhBi1dKxs03ibopJsMyEF6JAM-QJWjw@mail.gmail.com>
In-Reply-To: <CAEf4BzakRfffU9+wLBNfhBi1dKxs03ibopJsMyEF6JAM-QJWjw@mail.gmail.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Thu, 6 Apr 2023 15:25:02 -0700
Message-ID: <CA+PiJmRZHKn4GyDu7NbWc612=ovgM7jODKSD76CSW0gbjzDfzg@mail.gmail.com>
Subject: Re: [PATCH 2/3] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 6, 2023 at 2:09=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> should we always reject NULL even for SKB/XDP or only when the buffer
> *would be* required? If the latter, we could use bpf_dynptr_slice()
> with NULL buf to say "only return pointer if no byte copying is
> required". As opposed to bpf_dynptr_data(), where I think we always
> fail for SKB/XDP, because we are not sure whether users are aware of
> this need to copy bytes. Here, users are aware, but chose to prevent
> copying.
>
> WDYT?
>

I think Passing NULL here should signal that you're quite okay with it
failing instead of copying. We could limit this to just local/ringbuf
types, but that seems like an unneeded restriction, particularly if
you're operating on some section of an skb/xdp buffer that you know
will always be contiguous.
I adjusted xdp for that. The adjustment would be similar for skb, I
just didn't do that since it was another layer of indirection deep and
hadn't looked through all of those use cases. Though it should be fine
to just reject when the buffer would have been needed, since all users
currently provide one.
I agree that allowing that same behavior for dnyptr_data would be more
likely to cause confusion. Blocking the copy on dynprt_slice is much
more explicit.

>
> would this work correctly if someone passes a non-null buffer with too
> small size? Can you please add a test for this use case.
>

Yes, that's one of the tests that's missing there. Once I get my build
situation sorted I'll add more tests. The behavior for a non-null
buffer should be unchanged by this patch.

> Also, I feel like for cases where we allow a NULL buffer, we need to
> explicitly check that the register is a *known* NULL (SCALAR=3D0
> basically). And also in that case the size of the buffer probably
> should be enforced to zero, not just be allowed to be any value.
>

We absolutely should check that the pointer in question is NULL before
ignoring the size check. I think I'm accomplishing that by ignoring
__opt when reg->umax_value > 0 in is_kfunc_arg_optional. Is that the
wrong check? Perhaps I should check var_off =3D=3D tnum_const(0) instead.

We can't enforce the size being zero in this case because the size is
doing double duty. It's both the length of the requested area of
access into the dnyptr, and the size of the buffer that it might copy
that data into. If we don't provide a buffer, then it doesn't make
sense to check that buffer's size. The size does still apply to the
returned pointer though. Within the kfunc, it just needs to check for
null before copying dynptr data, as well as the regular enforcement of
length against the dynprt/offset.

> it's scary to just ignore some error, tbh, the number of error
> conditions can grow overtime and we'll be masking them with this
> is_kfunc_arg_optional() override. Let's be strict and explicit here.
>
It would probably make more sense to check is_kfunc_arg_optional and
skip the size check altogether. Either way we're just relying on
runtime checks against the dynptr at that point. If the buffer is
known null and optional, we don't care what the relationship between
the buffer and the size is, just that size and the dynptr. __szk
already takes care of it being a constant. This doesn't affect the
return buffer size.
