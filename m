Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC2527E522
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Sep 2020 11:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgI3J2r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Sep 2020 05:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgI3J2q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Sep 2020 05:28:46 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E1BC0613D2
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 02:28:45 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id q21so1147562ota.8
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 02:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FCLVZ13s2A1DgySuwXRnxGS7cpstquPbJaPgNjBvO64=;
        b=Nf+iXt9Q+W3wuykljBC0zdhMYnMqxjUojtb8TRh4984evIAub+t9Qi9FyokxlZVkz1
         JgGp1og7inZFVLDQee/ePVlah3cclhQZicb4KltFZ3hGwtbIsFDjlm1QCDOfy4+Y9eE3
         CSrLDPdSvfT1RcbZ/GbrmHhOxXlminFXHfhXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FCLVZ13s2A1DgySuwXRnxGS7cpstquPbJaPgNjBvO64=;
        b=kYYDIBDxbbjv/xmstbOwc7QCdstICersYM8PFLSe0sPvHCRuVJqlNLQKfFK2ItaU4f
         ajg5b0hrcg4MkJr5UohQvv+V1+iQAGPScVhfCLzeNm+dVIGoOiSJTmMb1vOgdZgJ2msW
         QlsUBxHqZ16blhgjATRJLFYJFPprMb+BwxWN50wLV78EmREXK2wggMil8Drk1ins6zNU
         ZyOYSWfY7XaPmKVYtQFUYZKm4vYkLdRTwSM3p5jesXpfzpJ8Iudb8yGJpeiM1XCQnQN3
         igowxrzH+5nIvW6GoNUDeZhJTQ/ZOawNSsMD89/4FSNlLO5diI+vYBkHveiuErDOa5tr
         CNrQ==
X-Gm-Message-State: AOAM531rSbc6cXL+b2zoasXDMqjNth3bDqltU71J8XoIM7wGc5AtXERN
        Tp23R3Y+xGRq+9n2EhvokjLa7AesYlYx5pMUR0DOVg==
X-Google-Smtp-Source: ABdhPJySlEuKD+GqJiylXHWVvB1hpaCEqGmXDnomoKNWIy72Tv+613MZTN7zgjkgfOZu3h1OhisP/gWLBIPZs6kr928=
X-Received: by 2002:a05:6830:12c7:: with SMTP id a7mr1025005otq.334.1601458124389;
 Wed, 30 Sep 2020 02:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200928090805.23343-1-lmb@cloudflare.com> <20200928090805.23343-3-lmb@cloudflare.com>
 <20200929055851.n7fa3os7iu7grni3@kafai-mbp> <CAADnVQLwpWMea1rbFAwvR_k+GzOphaOW-kUGORf90PJ-Ezxm4w@mail.gmail.com>
In-Reply-To: <CAADnVQLwpWMea1rbFAwvR_k+GzOphaOW-kUGORf90PJ-Ezxm4w@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 30 Sep 2020 10:28:33 +0100
Message-ID: <CACAyw98WzZGcFnnr7ELvbCziz2axJA_7x2mcoQTf2DYWDYJ=KA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] selftests: bpf: Add helper to compare
 socket cookies
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@cloudflare.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 29 Sep 2020 at 16:48, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:

...

> There was a warning. I noticed it while applying and fixed it up.
> Lorenz, please upgrade your compiler. This is not the first time such
> warning has been missed.

I tried reproducing this on latest bpf-next (b0efc216f577997) with gcc
9.3.0 by removing the initialization of duration:

make: Entering directory '/home/lorenz/dev/bpf-next/tools/testing/selftests=
/bpf'
  TEST-OBJ [test_progs] sockmap_basic.test.o
  TEST-HDR [test_progs] tests.h
  EXT-OBJ  [test_progs] test_progs.o
  EXT-OBJ  [test_progs] cgroup_helpers.o
  EXT-OBJ  [test_progs] trace_helpers.o
  EXT-OBJ  [test_progs] network_helpers.o
  EXT-OBJ  [test_progs] testing_helpers.o
  BINARY   test_progs
make: Leaving directory '/home/lorenz/dev/bpf-next/tools/testing/selftests/=
bpf'

So, gcc doesn't issue a warning. Jakub did the following little experiment:

jkbs@toad ~/tmp $ cat warning.c
#include <stdio.h>

int main(void)
{
        int duration;

        fprintf(stdout, "%d", duration);

        return 0;
}
jkbs@toad ~/tmp $ gcc -Wall -o /dev/null warning.c
warning.c: In function =E2=80=98main=E2=80=99:
warning.c:7:2: warning: =E2=80=98duration=E2=80=99 is used uninitialized in=
 this
function [-Wuninitialized]
    7 |  fprintf(stdout, "%d", duration);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


The simple case seems to work. However, adding the macro breaks things:

jkbs@toad ~/tmp $ cat warning.c
#include <stdio.h>

#define _CHECK(duration) \
        ({                                                      \
                fprintf(stdout, "%d", duration);                \
        })
#define CHECK() _CHECK(duration)

int main(void)
{
        int duration;

        CHECK();

        return 0;
}
jkbs@toad ~/tmp $ gcc -Wall -o /dev/null warning.c
jkbs@toad ~/tmp $

Maybe this is https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D18501 ? The
problem is still there on gcc 10. Compiling test_progs with clang does
issue a warning FWIW, but it seems like other things break when doing
that.

--
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
