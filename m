Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8186F2236
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Apr 2023 03:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjD2B6H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 21:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347136AbjD2B6C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 21:58:02 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAE83C1B
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Apr 2023 18:57:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1aad5245632so510095ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Apr 2023 18:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682733479; x=1685325479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwYEXU7Lp9XroufPN43xvmiTz9v2gxPHNeujBe94GAs=;
        b=RXfyW4VFENC5ciM0BkQroL4aTdKXdDxKRQP+lXVasRmQpe5AI9ZHyvuHYeeGYk3Qb3
         5eGB9m1chP/gFDsK+Kq3oCrQGusaWdv4ohH1vJ1AauBiusk9QlXKDJxIcIXL/ysUJiuo
         TJ8ryIERQ67DdKzkaBWura/eB3J3OP4gWII1O8nQCqHtILnjZkE20TC7iYsmfyoi2YcD
         NVYLjMQk/hAcc+H6PB0dtfjya3cxCRCqtERmwcSfhVVfyFnWklGRnJI6OQH/9Y6bZpbv
         0B8iJM+g4s5BoqriWl9kxk+QO331R/fFPpG6dylVLVil6y68Q6dXek410s1b5hZSql8w
         pDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682733479; x=1685325479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwYEXU7Lp9XroufPN43xvmiTz9v2gxPHNeujBe94GAs=;
        b=HYq/tqzmsxItlXGi9N0cBX+dBNl1acAYeSH7xRNNP/p1LVbntxYdIMiLnCvBZBB4d8
         ibJrMMS+FveEKo99MbKU/GN01kJWOm4kBA9A0cWiTKt6IiKWd0ZPEbdcGGs1iTt+6JV6
         1wY1wBGKTQkky/R6ndxV31fqZqcUck7H1XQYafZbLCLL8nCe9uni4p30MC0I8bnNxPrf
         5rvOEky+1zNji2iZJciDG9/NPmBljcw4ScUu5pi2mNz5lR1UehR81MK7HnC8SJDhKAN8
         dkPvNOSA12XJvMYqRyfj4+LusQy5+iqgzjuRuBLsk4UyEPSMIn24YmoLyN6E2l8ehx3n
         5d+A==
X-Gm-Message-State: AC+VfDx7nsmV7ynhWH2xeKD9qARlYo3H4Wr7ddFDTrulPv1W6/KLwBLi
        rSk3SU/B3UEihQw6nN6Flt2ix8WD4l61Nl6nqb0v7Q==
X-Google-Smtp-Source: ACHHUZ6hnf26OkmiqUDWsr7DSiuPNV/BdRgyZpdsz5lR+uhorY4Vu4itliEAmdMKDWjt/ddvAknB/Tx9C46kEc/0Fy8=
X-Received: by 2002:a17:902:f78a:b0:1a9:b62f:9338 with SMTP id
 q10-20020a170902f78a00b001a9b62f9338mr6290325pln.45.1682733479236; Fri, 28
 Apr 2023 18:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com> <20230406004018.1439952-3-drosen@google.com>
 <CAEf4BzakRfffU9+wLBNfhBi1dKxs03ibopJsMyEF6JAM-QJWjw@mail.gmail.com>
In-Reply-To: <CAEf4BzakRfffU9+wLBNfhBi1dKxs03ibopJsMyEF6JAM-QJWjw@mail.gmail.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Fri, 28 Apr 2023 18:57:48 -0700
Message-ID: <CA+PiJmQJ8m_W_SF3GPe9pqnwJX0gbkWuuOz-WXHWcA7JExgMyg@mail.gmail.com>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 6, 2023 at 2:09=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> would this work correctly if someone passes a non-null buffer with too
> small size? Can you please add a test for this use case.
>
Working on a test case for this, but the test case I wrote fails
without my patches.
I'm just declaring a buffer of size 9 on the stack, and then passing
in bpf_dynptr_slice that buffer, and size 10. That's passing the
verifier just fine. In fact, it loads successfully up to size 16. I'm
guessing that's adjusting for alignment? Still feels very strange. Is
that expected behavior?
