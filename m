Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90336DA659
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Apr 2023 01:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjDFXyp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 19:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237261AbjDFXyh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 19:54:37 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4667ED3;
        Thu,  6 Apr 2023 16:54:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id g18so5062492ejx.7;
        Thu, 06 Apr 2023 16:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680825275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CikBPbUxVUuJ7IrbUQ9wU1KffUTIqbzP3eb0rXcRUkg=;
        b=HzkmRvtxMm4P83iWhZXWYnREh/Aw63gNTIRiYPPczkXDk+XvTAZffm2WgzmunJabVv
         I+fCneguVvtcsSVm6MNOSxeX25kPF26kuP4fapvf9l6yFUQgMKeGp5yjVgMo/WnDwNWd
         zxE2Q5sGiF5H8cBmAowJH/PZoUs79TBYs2HPLoT8Arthat0AFIvIE9YDXrw3y2j84HnX
         DulZMUwCs09JwEtM23hpbXjQ/5LIAXKkgx6ij/6CLvGpLEjNCAboFL2IHqpngEnrX1OW
         z0ApFH7PqH5lqeY80VFtow6u1DCKjaIjAuTIcfCRmwVRWx+ZJxTmxOHZEmeArCUL5T34
         mqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680825275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CikBPbUxVUuJ7IrbUQ9wU1KffUTIqbzP3eb0rXcRUkg=;
        b=HayTHKlNKIOQCdtpQTy594ER9rU3EueV4Q2wMSpdbfSqF8gNtzWj5+y5TB6jPAGB3g
         4BhSh35nOgKIeL0kOeossWMZhk/vqT6wui3m+5gGiPWsuaJp/V8Ww4ymP2qctKHviBZz
         1VmjfRX1niaU3/h5HC/9m4EFSnxO6H1QxISYXrigjRSRthplI30Qmas7eoa38BXGH2zU
         LdxeR2H4kDABM10iOsbCl+ioEBBJfTX79OEHgkps8CNuKff9n6tLxa/X7GqRaA+KNY9j
         b7t96i5SWEJLvnUURewMmz6lLs2q9HStsTR9xbc5g2NkijLLcTDnwDQg2yQepr+xVKZL
         1gxw==
X-Gm-Message-State: AAQBX9faTDD6I2LL4id+3fRDs5cRdgQBUp89GYSRNEhJ5dPTm9GaKn/S
        SSfrWBto0A1m1m1/buuxqQ66k8kjfsVBGmgwLKU=
X-Google-Smtp-Source: AKy350aP3LAuRE4kHXafIyRhhTeGu1zIiVG/9F6cl2mx5fdZ4PtKm+tbFi0lQ64c0i0cHxRXAMG3vZrkyM+RDT4IpYE=
X-Received: by 2002:a17:906:82cd:b0:932:38d5:ff86 with SMTP id
 a13-20020a17090682cd00b0093238d5ff86mr299666ejy.5.1680825275137; Thu, 06 Apr
 2023 16:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com> <20230406004018.1439952-3-drosen@google.com>
 <CAEf4BzakRfffU9+wLBNfhBi1dKxs03ibopJsMyEF6JAM-QJWjw@mail.gmail.com> <CA+PiJmRZHKn4GyDu7NbWc612=ovgM7jODKSD76CSW0gbjzDfzg@mail.gmail.com>
In-Reply-To: <CA+PiJmRZHKn4GyDu7NbWc612=ovgM7jODKSD76CSW0gbjzDfzg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Apr 2023 16:54:22 -0700
Message-ID: <CAEf4BzbnYM+=W3N9mun24v0QbCDTbm5rnpGAwxD4xat297+XZg@mail.gmail.com>
Subject: Re: [PATCH 2/3] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
To:     Daniel Rosenberg <drosen@google.com>
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
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 6, 2023 at 3:25=E2=80=AFPM Daniel Rosenberg <drosen@google.com>=
 wrote:
>
> On Thu, Apr 6, 2023 at 2:09=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > should we always reject NULL even for SKB/XDP or only when the buffer
> > *would be* required? If the latter, we could use bpf_dynptr_slice()
> > with NULL buf to say "only return pointer if no byte copying is
> > required". As opposed to bpf_dynptr_data(), where I think we always
> > fail for SKB/XDP, because we are not sure whether users are aware of
> > this need to copy bytes. Here, users are aware, but chose to prevent
> > copying.
> >
> > WDYT?
> >
>
> I think Passing NULL here should signal that you're quite okay with it
> failing instead of copying. We could limit this to just local/ringbuf
> types, but that seems like an unneeded restriction, particularly if
> you're operating on some section of an skb/xdp buffer that you know
> will always be contiguous.
> I adjusted xdp for that. The adjustment would be similar for skb, I
> just didn't do that since it was another layer of indirection deep and
> hadn't looked through all of those use cases. Though it should be fine
> to just reject when the buffer would have been needed, since all users
> currently provide one.
> I agree that allowing that same behavior for dnyptr_data would be more
> likely to cause confusion. Blocking the copy on dynprt_slice is much
> more explicit.
>
> >
> > would this work correctly if someone passes a non-null buffer with too
> > small size? Can you please add a test for this use case.
> >
>
> Yes, that's one of the tests that's missing there. Once I get my build
> situation sorted I'll add more tests. The behavior for a non-null
> buffer should be unchanged by this patch.

cool, sounds good

>
> > Also, I feel like for cases where we allow a NULL buffer, we need to
> > explicitly check that the register is a *known* NULL (SCALAR=3D0
> > basically). And also in that case the size of the buffer probably
> > should be enforced to zero, not just be allowed to be any value.
> >
>
> We absolutely should check that the pointer in question is NULL before
> ignoring the size check. I think I'm accomplishing that by ignoring
> __opt when reg->umax_value > 0 in is_kfunc_arg_optional. Is that the
> wrong check? Perhaps I should check var_off =3D=3D tnum_const(0) instead.

yeah, umax_value is probably wrong check, use register_is_null()

but this approach, even if correct, is a bit too subtle. I'd code it explic=
itly:

  - if __opt, then we know it *can be NULL*
  - if so, we need to consider two situations
    - it is NULL, then don't enforce buffer size
    - it is not NULL (or may be not NULL), then enforce buffer size

Basically, conflating check whether argument is marked as opt with
enforcement of all the implied conditions seems very error-prone.

>
> We can't enforce the size being zero in this case because the size is
> doing double duty. It's both the length of the requested area of
> access into the dnyptr, and the size of the buffer that it might copy

yep, completely missed this double use of that constant, ignore my
point about enforcing sz=3D=3D0 then

> that data into. If we don't provide a buffer, then it doesn't make
> sense to check that buffer's size. The size does still apply to the
> returned pointer though. Within the kfunc, it just needs to check for

yep

> null before copying dynptr data, as well as the regular enforcement of
> length against the dynprt/offset.
>
> > it's scary to just ignore some error, tbh, the number of error
> > conditions can grow overtime and we'll be masking them with this
> > is_kfunc_arg_optional() override. Let's be strict and explicit here.
> >
> It would probably make more sense to check is_kfunc_arg_optional and
> skip the size check altogether. Either way we're just relying on
> runtime checks against the dynptr at that point. If the buffer is
> known null and optional, we don't care what the relationship between
> the buffer and the size is, just that size and the dynptr. __szk
> already takes care of it being a constant. This doesn't affect the
> return buffer size.

yep, I agree about the logic, I'm concerned with the conflated
implementation, as I tried to explain above
