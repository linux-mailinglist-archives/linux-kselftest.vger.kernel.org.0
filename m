Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BA73AD474
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jun 2021 23:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhFRVjd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 17:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbhFRVjc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 17:39:32 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F1EC061574;
        Fri, 18 Jun 2021 14:37:22 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h12so8754248pfe.2;
        Fri, 18 Jun 2021 14:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5F0/o83rPn6kF1SWIHORQRDoAw20SA/iZS1LAUQxvto=;
        b=e1TuHTIi91aVzlQxa54+NMMojBj3bHrti5EbzZ2htrtS2SdCleDjpi9LQ1qjPMURp1
         trsZXQdDdJEsShqcokOI+7xzBJgmrEHEoIlBTyEPhm6i16Cg/WhNPstTBMIlMW6NC3rk
         D3xEIUOe72C89Mlc2Z+Q461rQPLfrh2v0claYeiR1qaGQIaEgnRtlT3O6sgmkOZPBJFk
         9l1UVEg+zlbTQWfLXUSLAsZo9sUP6Tup9TJW2MESA0ogsFiZ6nydsX4NTtSmTKazIj3r
         0q7a1kY1UwizmVrlzoI5xo37fX5gMQZUfincvWoqf5YAeBpdJ6A6gBLmkGRgudNJVsYy
         1z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5F0/o83rPn6kF1SWIHORQRDoAw20SA/iZS1LAUQxvto=;
        b=I4lJMjq6h+nhvnUNv7rmA2zCj1a9MqiT6+e5MtJi4IqLh4jiUpThkCFRCPPdcy/yge
         1Dmw0C/3GJ4HPGwaZcWdNYg4oyFHEdjTqbVcCdJNv4HbUBwG58rmE8IEWONQt4hG5+/D
         lfj/6QL3anq0/cYiGQBSYw8i2/NvNbR/wuQ8qYuu0tfPxAoKgocSxytECCXMA88OErzA
         HipPHR6yci8NHb9M4JVIWpHMb0ufU5ACQZYTbiFo4fHWJjdwZrvovzJRXyTIKsH/jEMz
         2BCYXqGY5/AYbZSSWWCDVXFFXA1fS0hWEgChtMwfLiujFNNOQIw+gmr9KqrTRZQTXqq6
         Q46g==
X-Gm-Message-State: AOAM530FCa8UL+YfyYJlvt6YIsVBAQ6ylspZSkTTVSKMaxKHWadrCslu
        kT/Oe6ER1PfsEbzb9eqFh/Hjk1mu7kbuAqAWnjk=
X-Google-Smtp-Source: ABdhPJzgINR5Oh3qoN1vLBU6Th3toYjPFxtFBsXuIsw5EDHoYPGLW5qODh63bC9YBhL5jv8xT7nPgu6ZI8HoDswqovU=
X-Received: by 2002:a63:b00d:: with SMTP id h13mr11949770pgf.74.1624052241679;
 Fri, 18 Jun 2021 14:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210618143854.62967-1-andriy.shevchenko@linux.intel.com> <YMz80O2mkEWyl2Xx@yury-ThinkPad>
In-Reply-To: <YMz80O2mkEWyl2Xx@yury-ThinkPad>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 19 Jun 2021 00:36:44 +0300
Message-ID: <CAHp75Veti-7h=BoH9ZXXPMS1e8gq3rb19QS4TAB1J33GTdLKRg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] tools: Rename bitmap_alloc() to bitmap_zalloc()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ben Gardon <bgardon@google.com>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Yury Norov <ynorov@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 18, 2021 at 11:11 PM Yury Norov <yury.norov@gmail.com> wrote:
>
> On Fri, Jun 18, 2021 at 05:38:54PM +0300, Andy Shevchenko wrote:
> > Rename bitmap_alloc() to bitmap_zalloc() in tools to follow new coming
> > bitmap API extension in kernel.
>
> Can you please tell more about the new coming extensions?

Ah, this is outdated text. It was about the time when bitmap_*alloc()
was introduced in the kernel.

> Anyways,
> Acked-by: Yury Norov <ynorov@caviumnetworks.com>
>
> All bitmap patches together can be found here:
> https://github.com/norov/linux/commits/bm-f1

Should I resend with that fixed (I have also noticed that your address
in Suggested-by is outdated)?

-- 
With Best Regards,
Andy Shevchenko
