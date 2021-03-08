Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1826C331947
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Mar 2021 22:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCHVU1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Mar 2021 16:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhCHVUG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Mar 2021 16:20:06 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FEFC06174A
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Mar 2021 13:20:05 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 75so7434985otn.4
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Mar 2021 13:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FqhqeZr2mP2g3hEZS37A37xiT1GPHwZWQBfQupiXH30=;
        b=ahF8ZpY5aS9BUJuXYF4jVKVBTNDL690Cx7GLbfjBpTt5c9gZ8q/QcXzIvw8kJ8zi8z
         YL++V2vWR93vH4UgccdaCP3yDW3JGrZ+bFHZNSCxCmsm0S9HWwANlEkfTZz6KjSiKr80
         dYExmlGIIYwsnwCOXbxyJyeRoEz2Zmkn9ilUDFqz6+2BSQUQYwUf68XtIGfOlDTTQjzx
         t7FRiEgwsk5MkeMsrD3L4TT7GecF4qRSB70Q14PL5lnp+AbvJ4bfbCFLV2GZcb6Qb7Ha
         hn8s4xD1pG8cOvtS40YJ91aKGDcEk5+BDmrRde2vhgUTRtVn1+ce0fEA+jxKeAdpE8Nw
         E9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FqhqeZr2mP2g3hEZS37A37xiT1GPHwZWQBfQupiXH30=;
        b=ZOxxLBfegIvJnmDkfmNMVuG3FK6rFSgopHNE44HVe4fkwojnG3xlnPBvPuLkEm0MSC
         kYuUsyXFKBBaVfZlXvu3vVLxj95PdqT8xtl2pVkoU4yLltJv0zLl94J1zvRxtbmjAvU+
         Lczo4NJihjgOSqSlUUHgpjrKeLGCArtxIwJDphrDSqTMophCnCSsibwsUAl6aXU2NnJO
         HiR4EL3NAdU7PX4tW0+XY3Oqu4ZJiAzUUC5ydyJ2StjSMVeqo1X1iqCeHL/GrIdvhW7L
         +0rW6qtzSc7fPuHn8NmgLkjyi/Rjxng3Qxr1ERzLkUAlCNYpW2R0yuCVyeeZEf//VHcO
         A7SQ==
X-Gm-Message-State: AOAM530TcLGf785ODVPpTtoGxr4iVVuyvtZMyN6XeodAvSfto8zFAwnQ
        pwj9YCTcTaAl/5+urqBV9h3JWeloVukG7wVH1iYtUg==
X-Google-Smtp-Source: ABdhPJwMChhvW0J5qVGiKwmT8+qXpOHEaHOaMDplKmxkeUv65+4bqIlOdB8cHzBqXGJrGRNTSBLug2GL0kvnBXGolaY=
X-Received: by 2002:a05:6830:15d2:: with SMTP id j18mr2640239otr.75.1615238405176;
 Mon, 08 Mar 2021 13:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20210308182830.155784-1-jean-philippe@linaro.org>
In-Reply-To: <20210308182830.155784-1-jean-philippe@linaro.org>
From:   Joe Stringer <joe@cilium.io>
Date:   Mon, 8 Mar 2021 13:19:31 -0800
Message-ID: <CADa=Ryz__dmwK7J--Tjt73_WvFrta=uJWcqt9GXsUqH_4zj1Zw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix typo in Makefile
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     shuah@kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, andrii@kernel.org,
        linux-kselftest@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Joe Stringer <joe@cilium.io>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 8, 2021 at 10:29 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> The selftest build fails when trying to install the scripts:
>
> rsync: [sender] link_stat "tools/testing/selftests/bpf/test_docs_build.sh" failed: No such file or directory (2)
>
> Fix the filename.
>
> Fixes: a01d935b2e09 ("tools/bpf: Remove bpf-helpers from bpftool docs")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Thanks for the fix.

Acked-by: Joe Stringer <joe@cilium.io>
