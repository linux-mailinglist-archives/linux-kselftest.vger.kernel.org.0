Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E2D6DA471
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 23:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238887AbjDFVJb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 17:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238304AbjDFVJ3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 17:09:29 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C67F7ECB;
        Thu,  6 Apr 2023 14:09:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id g18so4399719ejj.5;
        Thu, 06 Apr 2023 14:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680815366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IMYxeiTkHkUnkag6hCenfbg4myfMEKIz109nk2UMqI=;
        b=WXYYDnt7D3I2S52tUDwZehAKPr9B1cxcK+D1iGSFpHuF43/C3/wWQuzObNf+NNnZym
         0CIjLsCLjgxyMqs12yamE3w9S1qYCX9l60Vo3+brHHJcXXYPHlWyuyNT5Mdtq6PSUqJz
         vRTUD5oCtzhqXv1Cg72mqJBp6EBqc4aIGf64c/GY3jvRJBI4sXC0ayi8dpQDaj57KkJF
         xc4ucUs4FtawC4fiSCuela/WdQmOHvOTZ0lXeItf+TXfoJbcv7E3Gu5dx2Bwv/9jHOrg
         C/tQZqsYPoO368x2pI0VVU2x5dgXPCcI+bzaK1SzUBIjoC1QAql57Tzube1WpXtmGxow
         cbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IMYxeiTkHkUnkag6hCenfbg4myfMEKIz109nk2UMqI=;
        b=KuwFO5nP67z+5z2oPpALKoa2oeUDXzRSTgaFq7eeeWZt5M2bnqs4XGYTMI8oROr3e2
         aiEGqieK1PwH3fxz/2YxswI2ulDgqDW/4CA8u5n/Lxz7KGoVYnViQ8JlmOWFlpFyOAAk
         mXdiGwYshi7mKmOWhLPt/wNMn23PQ0b22D+afnz9wwF5dxbiKysxMW88G6PJS4U1T/mS
         /OoRLkhBGd1ZvbUnrb4MKbcZzBRSw1zpO35JPB2T4OI30rb1d+1thrMURmGQvRYz3/63
         XGGZKYfBy1pNL8gKC98Ok0+47Ev7mJz10MFBZ3h4khpqBFKmAH+E7gChLdhwXexvd+eI
         bP1g==
X-Gm-Message-State: AAQBX9d1c60/5DIJKss1b5Mfuimu8P0rRx3WpE2lNGRVufctsFlwNiP7
        O3mXA1sZIcZlXUFJtMG4w3ivLch+YKTIkiKMlfk=
X-Google-Smtp-Source: AKy350bTvCR3TUWc6oqucssQTixUjIphJrw/gv6Lfi7PWl7ORkEXxu9N3J33NB8doGgi6ir7CRr45VkZpLP0ZfqyQ+I=
X-Received: by 2002:a17:907:1c83:b0:947:9d85:30c9 with SMTP id
 nb3-20020a1709071c8300b009479d8530c9mr5488338ejc.5.1680815365676; Thu, 06 Apr
 2023 14:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com> <20230406004018.1439952-3-drosen@google.com>
In-Reply-To: <20230406004018.1439952-3-drosen@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Apr 2023 14:09:13 -0700
Message-ID: <CAEf4BzakRfffU9+wLBNfhBi1dKxs03ibopJsMyEF6JAM-QJWjw@mail.gmail.com>
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

On Wed, Apr 5, 2023 at 5:40=E2=80=AFPM Daniel Rosenberg <drosen@google.com>=
 wrote:
>
> bpf_dynptr_slice(_rw) uses a user provided buffer if it can not provide
> a pointer to a block of contiguous memory. This buffer is unused in the
> case of local dynptrs, and may be unused in other cases as well. There
> is no need to require the buffer, as the kfunc can just return NULL if
> it was needed and not provided.
>
> This adds another kfunc annotation, __opt, which combines with __sz and
> __szk to allow the buffer associated with the size to be NULL. If the
> buffer is NULL, the verifier does not check that the buffer is of
> sufficient size.
>
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  Documentation/bpf/kfuncs.rst | 23 ++++++++++++++++++++++-
>  kernel/bpf/helpers.c         | 32 ++++++++++++++++++++------------
>  kernel/bpf/verifier.c        | 17 +++++++++++++++++
>  3 files changed, 59 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index d8a16c4bef7f..69573b511233 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -100,7 +100,7 @@ Hence, whenever a constant scalar argument is accepte=
d by a kfunc which is not a
>  size parameter, and the value of the constant matters for program safety=
, __k
>  suffix should be used.
>
> -2.2.2 __uninit Annotation
> +2.2.3 __uninit Annotation
>  -------------------------
>
>  This annotation is used to indicate that the argument will be treated as
> @@ -117,6 +117,27 @@ Here, the dynptr will be treated as an uninitialized=
 dynptr. Without this
>  annotation, the verifier will reject the program if the dynptr passed in=
 is
>  not initialized.
>
> +2.2.4 __opt Annotation
> +-------------------------
> +
> +This annotation is used to indicate that the buffer associated with an _=
_sz or __szk
> +argument may be null. If the function is passed a nullptr in place of th=
e buffer,
> +the verifier will not check that length is appropriate for the buffer. T=
he kfunc is
> +responsible for checking if this buffer is null before using it.
> +
> +An example is given below::
> +
> +        __bpf_kfunc void *bpf_dynptr_slice(..., void *buffer__opt, u32 b=
uffer__szk)
> +        {
> +        ...
> +        }
> +
> +Here, the buffer may be null. If buffer is not null, it at least of size=
 buffer_szk.
> +Either way, the returned buffer is either NULL, or of size buffer_szk. W=
ithout this
> +annotation, the verifier will reject the program if a null pointer is pa=
ssed in with
> +a nonzero size.
> +
> +
>  .. _BPF_kfunc_nodef:
>
>  2.3 Using an existing kernel function
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 6be16db9f188..f08556fd8b96 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2145,13 +2145,15 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid=
(s32 pid)
>   * bpf_dynptr_slice() - Obtain a read-only pointer to the dynptr data.
>   * @ptr: The dynptr whose data slice to retrieve
>   * @offset: Offset into the dynptr
> - * @buffer: User-provided buffer to copy contents into
> - * @buffer__szk: Size (in bytes) of the buffer. This is the length of th=
e
> - *              requested slice. This must be a constant.
> + * @buffer__opt: User-provided buffer to copy contents into.  May be NUL=
L
> + * @buffer__szk: Size (in bytes) of the buffer if present. This is the
> + *               length of the requested slice. This must be a constant.
>   *
>   * For non-skb and non-xdp type dynptrs, there is no difference between
>   * bpf_dynptr_slice and bpf_dynptr_data.
>   *
> + *  If buffer__opt is NULL, the call will fail if buffer_opt was needed.
> + *
>   * If the intention is to write to the data slice, please use
>   * bpf_dynptr_slice_rdwr.
>   *
> @@ -2168,7 +2170,7 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(s=
32 pid)
>   * direct pointer)
>   */
>  __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u3=
2 offset,
> -                                  void *buffer, u32 buffer__szk)
> +                                  void *buffer__opt, u32 buffer__szk)
>  {
>         enum bpf_dynptr_type type;
>         u32 len =3D buffer__szk;
> @@ -2188,15 +2190,19 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct b=
pf_dynptr_kern *ptr, u32 offset
>         case BPF_DYNPTR_TYPE_RINGBUF:
>                 return ptr->data + ptr->offset + offset;
>         case BPF_DYNPTR_TYPE_SKB:
> -               return skb_header_pointer(ptr->data, ptr->offset + offset=
, len, buffer);
> +               if (!buffer__opt)
> +                       return NULL;

should we always reject NULL even for SKB/XDP or only when the buffer
*would be* required? If the latter, we could use bpf_dynptr_slice()
with NULL buf to say "only return pointer if no byte copying is
required". As opposed to bpf_dynptr_data(), where I think we always
fail for SKB/XDP, because we are not sure whether users are aware of
this need to copy bytes. Here, users are aware, but chose to prevent
copying.

WDYT?

> +               return skb_header_pointer(ptr->data, ptr->offset + offset=
, len, buffer__opt);
>         case BPF_DYNPTR_TYPE_XDP:
>         {
>                 void *xdp_ptr =3D bpf_xdp_pointer(ptr->data, ptr->offset =
+ offset, len);
>                 if (xdp_ptr)
>                         return xdp_ptr;
>
> -               bpf_xdp_copy_buf(ptr->data, ptr->offset + offset, buffer,=
 len, false);
> -               return buffer;
> +               if (!buffer__opt)
> +                       return NULL;
> +               bpf_xdp_copy_buf(ptr->data, ptr->offset + offset, buffer_=
_opt, len, false);
> +               return buffer__opt;
>         }
>         default:
>                 WARN_ONCE(true, "unknown dynptr type %d\n", type);
> @@ -2208,13 +2214,15 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct b=
pf_dynptr_kern *ptr, u32 offset
>   * bpf_dynptr_slice_rdwr() - Obtain a writable pointer to the dynptr dat=
a.
>   * @ptr: The dynptr whose data slice to retrieve
>   * @offset: Offset into the dynptr
> - * @buffer: User-provided buffer to copy contents into
> - * @buffer__szk: Size (in bytes) of the buffer. This is the length of th=
e
> - *              requested slice. This must be a constant.
> + * @buffer__opt: User-provided buffer to copy contents into. May be NULL
> + * @buffer__szk: Size (in bytes) of the buffer if present. This is the
> + *               length of the requested slice. This must be a constant.
>   *
>   * For non-skb and non-xdp type dynptrs, there is no difference between
>   * bpf_dynptr_slice and bpf_dynptr_data.
>   *
> + * If buffer__opt is NULL, the call will fail if buffer_opt was needed.
> + *
>   * The returned pointer is writable and may point to either directly the=
 dynptr
>   * data at the requested offset or to the buffer if unable to obtain a d=
irect
>   * data pointer to (example: the requested slice is to the paged area of=
 an skb
> @@ -2245,7 +2253,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf=
_dynptr_kern *ptr, u32 offset
>   * direct pointer)
>   */
>  __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *pt=
r, u32 offset,
> -                                       void *buffer, u32 buffer__szk)
> +                                       void *buffer__opt, u32 buffer__sz=
k)
>  {
>         if (!ptr->data || bpf_dynptr_is_rdonly(ptr))
>                 return NULL;
> @@ -2272,7 +2280,7 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struc=
t bpf_dynptr_kern *ptr, u32 o
>          * will be copied out into the buffer and the user will need to c=
all
>          * bpf_dynptr_write() to commit changes.
>          */
> -       return bpf_dynptr_slice(ptr, offset, buffer, buffer__szk);
> +       return bpf_dynptr_slice(ptr, offset, buffer__opt, buffer__szk);
>  }
>
>  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 20beab52812a..b82faef389b1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9428,6 +9428,19 @@ static bool is_kfunc_arg_const_mem_size(const stru=
ct btf *btf,
>         return __kfunc_param_match_suffix(btf, arg, "__szk");
>  }
>
> +static bool is_kfunc_arg_optional(const struct btf *btf,
> +                 const struct btf_param *arg,
> +                 const struct bpf_reg_state *reg)
> +{
> +       const struct btf_type *t;
> +
> +       t =3D btf_type_skip_modifiers(btf, arg->type, NULL);
> +       if (!btf_type_is_ptr(t) || reg->type !=3D SCALAR_VALUE || reg->um=
ax_value > 0)
> +               return false;
> +
> +       return __kfunc_param_match_suffix(btf, arg, "__opt");
> +}
> +
>  static bool is_kfunc_arg_constant(const struct btf *btf, const struct bt=
f_param *arg)
>  {
>         return __kfunc_param_match_suffix(btf, arg, "__k");
> @@ -10539,10 +10552,14 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
>                         break;
>                 case KF_ARG_PTR_TO_MEM_SIZE:
>                 {
> +                       struct bpf_reg_state *buff_reg =3D &regs[regno];
> +                       const struct btf_param *buff_arg =3D &args[i];
>                         struct bpf_reg_state *size_reg =3D &regs[regno + =
1];
>                         const struct btf_param *size_arg =3D &args[i + 1]=
;
>
>                         ret =3D check_kfunc_mem_size_reg(env, size_reg, r=
egno + 1);
> +                       if (ret < 0 && is_kfunc_arg_optional(meta->btf, b=
uff_arg, buff_reg))
> +                               ret =3D 0;

would this work correctly if someone passes a non-null buffer with too
small size? Can you please add a test for this use case.

Also, I feel like for cases where we allow a NULL buffer, we need to
explicitly check that the register is a *known* NULL (SCALAR=3D0
basically). And also in that case the size of the buffer probably
should be enforced to zero, not just be allowed to be any value.

it's scary to just ignore some error, tbh, the number of error
conditions can grow overtime and we'll be masking them with this
is_kfunc_arg_optional() override. Let's be strict and explicit here.


>                         if (ret < 0) {
>                                 verbose(env, "arg#%d arg#%d memory, len p=
air leads to invalid memory access\n", i, i + 1);
>                                 return ret;
> --
> 2.40.0.577.gac1e443424-goog
>
