Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF92C5ADD6A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 04:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbiIFCei (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Sep 2022 22:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbiIFCee (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Sep 2022 22:34:34 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2936DD113;
        Mon,  5 Sep 2022 19:34:32 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id c4so7917299iof.3;
        Mon, 05 Sep 2022 19:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=T04FLeoKwCq029S0jtgDi8vVCFJoYrWdVmaL01N5FEk=;
        b=dNBWo78nwRURwL3MzY7vA4oN6OkT5NhNtbqZV4HTc61Spu0aquPK8jCTuKVN21WVkI
         s1kGMyB44r7/ICNEwfMEHMiJYza1jt4PFsxIF7FmDU1exCGlzhsmTbt7EaToBxPcjJ6S
         mbRmOPmmqnhW+W2KAuiG9hecG/5jtxWNYU3rVrPYgDtWaL4Q4E/Tv+lKSDhH6pdGuC+t
         95WQcmL5dHp2YfTUvmmmILOfcaiucyj+Sc1ffFE+3SQES0K3MEhdXnUzyFB4xuUrcJAX
         4+P4lJWm3U+Sv/PEEk4cDIFJtJJYDTLvdIt2SOp1rI75lHcQjQ3DcyDD2BMcZIgmfwXu
         dF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=T04FLeoKwCq029S0jtgDi8vVCFJoYrWdVmaL01N5FEk=;
        b=JAzmPodwc1nPI2mF5s+0+gwX5I4a12RBMkNso7GdYrU3KXYz/lF0Ogl6Z2H7nK6Thj
         vsNzlD6wGb15B6NJV6OoaFf0l4GkPsU1M9DfkbuPtYilb7yUWa3zoAvQFpjH7TP6+lcB
         /ME0rpqOVcaoT3IUWLcmdhXUYAHXhyrYfsUNMVVfZo2SZaQ2DodivhuCM8TC15Y39lD/
         JZsZt2Bn8tZL2tz770fipV69VUyFoFdr+QnTUfaLk+scDKN2zHI/gzVWg6E1tRjQIpvP
         eXpoIVPNVATrLWUxQXtUSMuM8NwSmm+ZFDvEB5ELp5y1NC8Nvz+e+jNS4smq37T94DAX
         tdPA==
X-Gm-Message-State: ACgBeo3U+BAsUIbtQDarteexecwtFLHLQdZeP+LvsTTxqdqahV7lq8Rs
        3JaaYMP0N8jdg6ZiXHynNU1Gyjofk+vQnCoREbw=
X-Google-Smtp-Source: AA6agR6RTfxKUXosH1bVhVZssQ9NwUnwPvI5J6zNH8sBmH7CJCg5r0HTNIAVjWrYUmNjYp7LRwIYuUsyBUCOOQ5PNDQ=
X-Received: by 2002:a05:6638:2388:b0:34a:e033:396b with SMTP id
 q8-20020a056638238800b0034ae033396bmr15481197jat.93.1662431671394; Mon, 05
 Sep 2022 19:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com> <20220905143318.1592015-5-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220905143318.1592015-5-roberto.sassu@huaweicloud.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 6 Sep 2022 04:33:55 +0200
Message-ID: <CAP01T76Jyr6xibmKW7XftGCXMTcn8hox=yOGyBPM+AVVH_3z3g@mail.gmail.com>
Subject: Re: [PATCH v16 04/12] bpf: Export bpf_dynptr_get_size()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        dhowells@redhat.com, jarkko@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, bpf@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>,
        Joanne Koong <joannelkoong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 5 Sept 2022 at 16:35, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Export bpf_dynptr_get_size(), so that kernel code dealing with eBPF dynamic
> pointers can obtain the real size of data carried by this data structure.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> Acked-by: KP Singh <kpsingh@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  include/linux/bpf.h  | 1 +
>  kernel/bpf/helpers.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 9c1674973e03..9dbd7c3f8929 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2585,6 +2585,7 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
>                      enum bpf_dynptr_type type, u32 offset, u32 size);
>  void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
>  int bpf_dynptr_check_size(u32 size);
> +u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr);
>
>  #ifdef CONFIG_BPF_LSM
>  void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index fc08035f14ed..824864ac82d1 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1408,7 +1408,7 @@ static void bpf_dynptr_set_type(struct bpf_dynptr_kern *ptr, enum bpf_dynptr_typ
>         ptr->size |= type << DYNPTR_TYPE_SHIFT;
>  }
>
> -static u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
> +u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
>  {
>         return ptr->size & DYNPTR_SIZE_MASK;
>  }
> --
> 2.25.1
>
