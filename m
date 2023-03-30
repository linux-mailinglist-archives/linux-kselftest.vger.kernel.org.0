Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42276CF83C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 02:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjC3A21 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 20:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjC3A20 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 20:28:26 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B865248;
        Wed, 29 Mar 2023 17:28:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ek18so70128818edb.6;
        Wed, 29 Mar 2023 17:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680136103; x=1682728103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mb3G5o726v3k/1euwToR/optCOdA0q3663pn9rDHtho=;
        b=YSLKHppFbhVoR3sgfg0f5+sMafkjsbSIZGGaxDnRO5n/fwPAMuEU5BOe6XIxhGfZ56
         x04wUW7NXyhlKPWuPYheYrIC5+5EZzsiXr171F2FU3reKYtUDyZhj1lWXtDjJ9sIOCbZ
         pDA7f16Req1kxvcfq7WY0vaBssVDA1uEza20CTCgMzpTt2rCAM6Oq2SuwIT72IoigICs
         MP+s9ofzx6sL7EvRncMV4iv12QWiIyltfsF1Fd6hQ9BG1IHzNhmhILMlrsRTiTpG+NkG
         BngXhp8RWqnYbS5WX4myOORFiXouEkBNF+tEHKBKOIwnakP/qxzEj18CoUYlk3iFfoVJ
         TOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680136103; x=1682728103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mb3G5o726v3k/1euwToR/optCOdA0q3663pn9rDHtho=;
        b=6ZROqJ+XOv6jS6lADeg/2Sx6n1o2BeoP3Clg7zJ3FDU+2mBC326xJHrynOr4XBxF2y
         sXdzsNREU3brNK1l0szfc93PDEFso2vVmJcQ4U17VMLctUJcKoOclQ11w77mjeGhIkdu
         be8fXDcQFpvkSfprHuDpbuQirZ4VNTpvHU8GmKBJI/9LkSV+peuxAnYcvk2riY4oLva1
         PnxOutYogNBH0JGuMD/rRNhUpOIInFGazdjdPeKpa9cANliVuUzjydXmGMEyWQrzQzDF
         gR42s/JzkWkZ+2iTlMOqm0Wh7QMl6CVqZ3XN+Ui8WaYjlK/VOuq3LwYYi+ZlTlta369M
         cwig==
X-Gm-Message-State: AAQBX9ciWJ9ll9iiZphfzge/d6NbwifFi/cJraliq8p/WvDJFPZqi5QO
        EzDvo7F9iB8by91st5yuUpUYDrdBNIrXCe/jxXu4pyEWDhATxtPG
X-Google-Smtp-Source: AKy350ZBwikhJKgtwcrvf/1cjta9c2pwkp233iSnXxozxjq0oHtwX/0lKu3EsGa5CeFuYcT/rB0rsX2/UrtoLnsCQw4=
X-Received: by 2002:a17:907:2d91:b0:931:3a19:d835 with SMTP id
 gt17-20020a1709072d9100b009313a19d835mr11355961ejc.3.1680136103495; Wed, 29
 Mar 2023 17:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230329011048.1721937-1-xukuohai@huaweicloud.com>
In-Reply-To: <20230329011048.1721937-1-xukuohai@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 29 Mar 2023 17:28:12 -0700
Message-ID: <CAADnVQKEm59_bZciY7hDOMGUogFZecw92nXCFbYAV-U2FB9Zkw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Rewrite two infinite loops in
 bound check cases
To:     Xu Kuohai <xukuohai@huaweicloud.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Tue, Mar 28, 2023 at 5:11=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> The two infinite loops in bound check cases added by commit
> 1a3148fc171f ("selftests/bpf: Check when bounds are not in the 32-bit ran=
ge")
> increased the execution time of test_verifier from about 6 seconds to
> about 9 seconds. Rewrite these two infinite loops to finite loops to get
> rid of this extra time cost.
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
> v2:
>  - rewrite the infinite loops to finite loops instead of removing the
>    test cases
>
> v1: https://lore.kernel.org/bpf/20230327153538.850440-1-xukuohai@huaweicl=
oud.com/

Thanks.
On my VM with debug kernel it went
from:
real   0m37.508s
user   0m0.382s
sys    0m36.555s

to:
real   0m14.547s
user   0m0.378s
sys    0m13.661s

Applied.
