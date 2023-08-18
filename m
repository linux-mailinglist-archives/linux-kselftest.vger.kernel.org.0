Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A278781248
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 19:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379183AbjHRRqV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 13:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243157AbjHRRpv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 13:45:51 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5475326BB
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Aug 2023 10:45:50 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ffa462d98fso1450123e87.2
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Aug 2023 10:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692380748; x=1692985548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvDbxW21Lb8gvKG4oLLMFbstJTpYE7KJLO80KXRmdc0=;
        b=Y4wNcysBif/2NP0qQqmaUIh//ojkZ2rrZ04AK66d5L92pDdhdjaiDnjA8CC5ML1b20
         W8bwV88aWpihTYWwAuivakvjlDxwUwhgVzLaxNH75gPEDlOWg7k1n3W0PibSjI3npiLq
         aCOfd8rLmBqzRRbYCox34imUoovtm4eJtL3POcaYgKETTUs+pQPIY3BBfzT6xFPLARwN
         h1d1jRDcCTSQyklY9FqHhPWhIw2eEVG5foqsse8IayV8Jc7MQDej93XsCDtHURcgT+gv
         cSEyy0pi9T914lStMYIiNJvHcjypmPCcvNr1swFi/CBpopy2o3B+PDsFpqhJax+qUxQw
         YqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692380748; x=1692985548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvDbxW21Lb8gvKG4oLLMFbstJTpYE7KJLO80KXRmdc0=;
        b=c3tGks1Oqv4rMjUt4/sqqCUmNL8WUyRdOdMlKs5lK0Ly23/RGGgMJ9N3wBMo7TrbyR
         Z2ljGuCQiDzU4iSu+fDCxsdakwFFUNE1W+RzQAfpMgJi7eJSMf/g8vwicA1PdX+orvuS
         /UTOXS3hXE2HqAF0SJqK8+9ffeTy0S5ToKTtQc3Es1b5H0746W0DkcGniqvlYnWl8W3W
         2lYvoFxPtpx6sOHYk44rKgOKIUEtURRNuK6kAxxQgkWU8gAfqkoL/o2Yz4dVHUdQrx08
         V67KGiSOHHY/mW6E01c+jaSjnc3FxlyPjUiEdsMdrcSA5bQ4ewcTG6gc3EjN0hWOGdst
         gIdw==
X-Gm-Message-State: AOJu0YycNQaRrx1x3C03Gw4FhmYeOnNQnikVzTB8CPB93qyStfjxokZH
        NMNtqmxOFLV7pl/++i25hBssOp6tLZgmVr4Sviax7A==
X-Google-Smtp-Source: AGHT+IFdiQorBU/xnNlx/5q0HWUoSAApFAo46w+qgFLzEhYRX0jS0Jcj9Pvwm8D4xvWIYrzskxeOMAmeqc2NPajVh7k=
X-Received: by 2002:a05:6512:10d1:b0:4f9:556b:93c5 with SMTP id
 k17-20020a05651210d100b004f9556b93c5mr2524758lfg.40.1692380748401; Fri, 18
 Aug 2023 10:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230818170454.19493-1-tuananhlfc@gmail.com>
In-Reply-To: <20230818170454.19493-1-tuananhlfc@gmail.com>
From:   Sagi Shahar <sagis@google.com>
Date:   Fri, 18 Aug 2023 10:45:36 -0700
Message-ID: <CAAhR5DG-QXw9p5avOVEhyfz6e4VGQSP_GBaZa9mb034D_fb9GA@mail.gmail.com>
Subject: Re: [PATCH v1] selftests/tdx: Add .gitignore
To:     Anh Tuan Phan <tuananhlfc@gmail.com>
Cc:     shuah@kernel.org, kirill.shutemov@linux.intel.com,
        mika.westerberg@linux.intel.com, wander@redhat.com,
        kai.huang@intel.com, mathieu.desnoyers@efficios.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 18, 2023 at 10:05=E2=80=AFAM Anh Tuan Phan <tuananhlfc@gmail.co=
m> wrote:
>
> Add .gitignore to ignore tools/testing/selftests/tdx/tdx_guest_test
>
> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> ---
>  tools/testing/selftests/tdx/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 tools/testing/selftests/tdx/.gitignore
>
> diff --git a/tools/testing/selftests/tdx/.gitignore b/tools/testing/selft=
ests/tdx/.gitignore
> new file mode 100644
> index 000000000000..56dd26b77c07
> --- /dev/null
> +++ b/tools/testing/selftests/tdx/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +tdx_guest_test
> --
> 2.34.1
>

tools/testing/selftests/kvm/.gitignore recently switched to a positive
filter which might be easier to maintain in the future if you add more
tests. You might want to consider just using the same .gitignore here.
