Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 242BD7C518
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2019 16:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfGaOjJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Jul 2019 10:39:09 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46803 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729906AbfGaOjE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Jul 2019 10:39:04 -0400
Received: by mail-lf1-f68.google.com with SMTP id z15so43356512lfh.13
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2019 07:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ctmBDHo9TX2dbSp2AaSHsPzQrsJdvD0Z0tQiKSJILjI=;
        b=vOqnA7p5rkZBV1OzvJdBY8iKuYdA1b4/1o8F1w0IN2uTr1QTWzn7WwJ2JFJulsfP9n
         w7SXEHZMs3OROdBscJxfm3yqK9ykTM2PKIM1oR1tL2f1241B9xYMdSVWTnrMHbmOd9VA
         mAPZDUO9HHBe830SnSJXzdgMSSIEPBHBeQe84S0kLGX8L+iv7XtRoPM2CXTUOuZ6dEH7
         B6aO1hPD3ht6n0bJLtnoxUg9cuq5DY7bj7JYiayjoj4jbBFKArFvRvlrFY6jxT+osgBK
         CDJg8qjTb01Y8yRl6THr9PaB5tdxxrnbZ70xpFwfysyJN6KNOtOOA/6JqLIDDSPmGMp5
         fVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ctmBDHo9TX2dbSp2AaSHsPzQrsJdvD0Z0tQiKSJILjI=;
        b=ON2g1pKNo96Wg1h/mGgsGUgSKAAqW+KxXpNh1Ud6Da9khVxaQvt9jannSNuZUVCoL0
         aCTYX3YgJd7XH0+f5pPtdmCxFvuXqTgJJTMzg7Zob/XnqoxPXGc7mPhtp6s/ulZ0yb/n
         cvT7f5tPQXJZTja62/Vd+kG6/MwAtvo9pp6jha2iAo69aWyQQMdbnaM6N8PWHXi+uOMa
         vKRD4yFK/k85jQBpmKNRT8IPmq6DyPiVBSYevPTaoOULlmPZ2BAsupygereBBfSISqu2
         b3KzaXX2baiBUQ5hYfvdlrGSWYWFsfAOV41lMXdMDiumJUbc14vN41jCQdc4gkN01BWC
         4meA==
X-Gm-Message-State: APjAAAUEzEkisjv2CRxq8OgSq5Bpu/l7rm2nPXWw2pxPqW9fpXKAIfrA
        7nHGPAkOlme1dMlBpVDINuCHS+oY+agcVN115jlIxw==
X-Google-Smtp-Source: APXvYqzUvYIZI+JTlouZm26wyL/S+M0wK6ZP0t5id5XDl31AGiIZPngdjFnaNrgG32VgIjVn4hRZhKk2bdPsATnEjw8=
X-Received: by 2002:ac2:482d:: with SMTP id 13mr46123622lft.132.1564583942340;
 Wed, 31 Jul 2019 07:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190731105540.28962-1-naresh.kamboju@linaro.org> <43fd5a9b-7ecd-3fff-2381-1dfce7b8618a@redhat.com>
In-Reply-To: <43fd5a9b-7ecd-3fff-2381-1dfce7b8618a@redhat.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 31 Jul 2019 20:08:51 +0530
Message-ID: <CA+G9fYvf_3JZFauHUzqjgdg9kir4i__oSsboiOGzBBS63zg7+g@mail.gmail.com>
Subject: Re: [PATCH] selftests: kvm: Adding config fragments
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        sean.j.christopherson@intel.com, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 31 Jul 2019 at 18:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 31/07/19 12:55, Naresh Kamboju wrote:
> > selftests kvm test cases need pre-required kernel configs for the test
> > to get pass.
> >
> > Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>
> Most of these are selected by other items.  CONFIG_KVM should be enough
> on ARM and s390 but MIPS, x86 and PPC may also need to select the
> specific "flavors" (for example Intel/AMD for x86).

If the below listed configs are not harmful i would like to keep all listed
configs. Because we (Linaro 's test farm) building kernels with maximum
available kernel fragments for a given test case to get better coverage.

>
> How are these used?  Are they used to build a kernel, or to check that
> an existing kernel supports virtualization?

"make kselftest-merge"
will get configs from tools/testing/selftests/*/config
and enables configs fragments and we build kernel for running
kvm-unit-tests, kselftests, LTP, libhugetlbfs, ssuite, perf and
v4l2-compliance.

- Naresh
