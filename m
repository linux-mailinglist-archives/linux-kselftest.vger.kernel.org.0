Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D647A70B3CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 May 2023 05:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjEVDeG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 May 2023 23:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEVDeG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 May 2023 23:34:06 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4C7BA;
        Sun, 21 May 2023 20:34:04 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id 4fb4d7f45d1cf-510db954476so7481693a12.0;
        Sun, 21 May 2023 20:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684726443; x=1687318443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLQltY4BWYnDf5Slt54wU1dHTqVUE/fDKiqtVuJkX0U=;
        b=IW5Q8xFDyOcEMX85AjNd1AxfqAo+mf6/3jnQHdtK37dz/6LVTbS/FkRwbn6IIocu3O
         F9QiE4d8pyB89xIYEMpQXawpgVS04gUVWyNO4VVeai378r4XRNq6czblu1aYSiTluRQy
         UvIIa2eRRBDhn6i5OGIfHxlodxdWJiOZs0XTgxeJ1PhOvI/WAxHMya1Z93EG0R4xJhEa
         Dnxoq32eMgNoGGeDXBvUl2UuleSLzdYzgr7Cq1p1DRwpTITlFBOOdklzJrpoJm0q+KUb
         4tJbmwOvONeR3WwObg4PhhaBqAho2DnJbzd5hqSnwtUSdg4nGVs3Pl7TmxNV/isgGEoM
         e8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684726443; x=1687318443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLQltY4BWYnDf5Slt54wU1dHTqVUE/fDKiqtVuJkX0U=;
        b=VuMvYUh/k0CUSGAVzWPtmmPLbn98WqJVpUKnyGE1QhaXF+B5o32jRgSfTYBovQTGL0
         YY80Hx/whc4zzex/WPuDeXef4HZ39k6bR309SiB+lMZC53yPnRKbsHsShUb82BZByCZ0
         tbByFbpjLCckkBC5MxXKrTRNvjDbSHegh4VZk26qZUDw0C48pYZR/LzKyYKicBx3miTB
         LAkBNtnMN/58C0Dxbl7mrW2jYz3ZM7P+ITGeFJAKwy2BURQm30s+74QxdoKs5v2oG2bX
         q/X2i59rA2BmgL/7EqyFDERIQox9d20YpyWZU6jzS+09yInk+AJPsk0W7dN5sAxbPHuM
         Txfw==
X-Gm-Message-State: AC+VfDxWwAGfFIIWpNCY1aKPvisTXufsAnD7FfaJVTxC9xr7x60gZQH6
        pYNO3Db4pYzrbhDSyI5wRa7P7NSFLiJlYXqWNf8=
X-Google-Smtp-Source: ACHHUZ5HtlGCCQVcPFb1g7HouFAf8sCSlMSKbyJ8+ZtJ345DO8Iv3V8Qgu6/DGZY0hF72wAFLcBr7BJ2YkdpenAR2iQ=
X-Received: by 2002:aa7:ca42:0:b0:50b:d26d:c57e with SMTP id
 j2-20020aa7ca42000000b0050bd26dc57emr7312670edt.12.1684726442775; Sun, 21 May
 2023 20:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230420104622.12504-1-ljrcore@126.com>
In-Reply-To: <20230420104622.12504-1-ljrcore@126.com>
From:   Jinrong Liang <ljr.kernel@gmail.com>
Date:   Mon, 22 May 2023 11:33:51 +0800
Message-ID: <CAFg_LQVfECWsmcSXJWnnyJK5mZAbjdCTX-RXP3aoDAECTspqkA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] KVM: selftests: Add tests for pmu event filter
To:     Sean Christopherson <seanjc@google.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Jinrong Liang <ljr.kernel@gmail.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=8820=E6=
=97=A5=E5=91=A8=E5=9B=9B 18:46=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Jinrong Liang <cloudliang@tencent.com>
>
> From: Jinrong Liang <cloudliang@tencent.com>
>
> Hi,
>
> This patch set adds some tests to ensure consistent PMU performance event
> filter behavior. Specifically, the patches aim to improve KVM's PMU event
> filter by strengthening the test coverage, adding documentation, and maki=
ng
> other small changes.
>
> The first patch replaces int with uint32_t for nevents to ensure consiste=
ncy
> and readability in the code. The second patch adds fixed_counter_bitmap t=
o
> create_pmu_event_filter() to support the use of the same creator to contr=
ol
> the use of guest fixed counters. The third patch adds test cases for
> unsupported input values in PMU filter, including unsupported "action"
> values, unsupported "flags" values, and unsupported "nevents" values. Als=
o,
> it tests setting non-existent fixed counters in the fixed bitmap doesn't
> fail.
>
> The fourth patch updates the documentation for KVM_SET_PMU_EVENT_FILTER i=
octl
> to include a detailed description of how fixed performance events are han=
dled
> in the pmu filter. The fifth patch adds tests to cover that pmu_event_fil=
ter
> works as expected when applied to fixed performance counters, even if the=
re
> is no fixed counter exists. The sixth patch adds a test to ensure that se=
tting
> both generic and fixed performance event filters does not affect the cons=
istency
> of the fixed performance filter behavior in KVM. The seventh patch adds a=
 test
> to verify the behavior of the pmu event filter when an incomplete
> kvm_pmu_event_filter structure is used.
>
> These changes help to ensure that KVM's PMU event filter functions as exp=
ected
> in all supported use cases. These patches have been tested and verified t=
o
> function properly.
>
> Thanks for your review and feedback.
>
> Sincerely,
> Jinrong Liang
>
> Previous:
> https://lore.kernel.org/kvm/20230414110056.19665-1-cloudliang@tencent.com
>
> v2:
> - Wrap the code from the documentation in a block of code; (Bagas Sanjaya=
)
>
> Jinrong Liang (7):
>   KVM: selftests: Replace int with uint32_t for nevents
>   KVM: selftests: Apply create_pmu_event_filter() to fixed ctrs
>   KVM: selftests: Test unavailable event filters are rejected
>   KVM: x86/pmu: Add documentation for fixed ctr on PMU filter
>   KVM: selftests: Check if pmu_event_filter meets expectations on fixed
>     ctrs
>   KVM: selftests: Check gp event filters without affecting fixed event
>     filters
>   KVM: selftests: Test pmu event filter with incompatible
>     kvm_pmu_event_filter
>
>  Documentation/virt/kvm/api.rst                |  21 ++
>  .../kvm/x86_64/pmu_event_filter_test.c        | 239 ++++++++++++++++--
>  2 files changed, 243 insertions(+), 17 deletions(-)
>
>
> base-commit: a25497a280bbd7bbcc08c87ddb2b3909affc8402
> --
> 2.31.1
>

Polite ping.

Should I post version 3 to fix the problem of two "From: Jinrong Liang
<cloudliang@tencent.com>"?

Thanks
