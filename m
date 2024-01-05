Return-Path: <linux-kselftest+bounces-2675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02FA825C7F
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 23:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADCE8B21A19
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 22:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB0625116;
	Fri,  5 Jan 2024 22:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B84dYjtE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4942536094
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Jan 2024 22:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso3615a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Jan 2024 14:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704493273; x=1705098073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfCFHI0ATH0yUix8nEn+6ml6f0afYfikXQ0pRh4IU04=;
        b=B84dYjtELAjWch+5ecEnjygH+6ylFpflDe1TarPUcHqEdelkA7AYENOCcV+qZbb3N7
         XvBvZc5fGob378QcKImcMpwtce2UvqPV+7UaqeiO1gTTYm6qads+HnouAWYNAxwiqNsi
         hGa8N2CTEyAcLSxt3CoTvfMIhtNG2ihYwTyH8iJEQ9GR5Nqh6arMioLGIqN1XFAgmvov
         vnOILbcaTS9UGDa7OOtbp8Bm1drXXoDT/sSQhJ6Yo9CokCzb/CmGYUpFJxFgBBPg05EB
         I3PKuiOH/kC4KoDnNHPi5aPS+cnw79ukv6Aco1202B866cy826bIEuQiYOFRcGRPy70V
         NwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704493273; x=1705098073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfCFHI0ATH0yUix8nEn+6ml6f0afYfikXQ0pRh4IU04=;
        b=tVq4tC9RS/2BTT6f27Rt7Fr3okxKr3C3ncCyz2E7+yBdLUwlFdT64V28TSZlR9Pts8
         G3oRm6PIRoIEXePyKhdJYbMWzuk9hBfn38pDChLcROtlGJvRgkOVcMjponUuaFeZtXhG
         QmyXO+atyEEvjBvFsveexguuq8f105I/GVLe0QVE0YhGCZ1j1l+cGiBB9vJuEQOZ0OJC
         LxOOTaELVTbqFD9NiI3PqnHDQ5Aog7bhUmU5DLCqzH4bAHhHK5a7E1S5rAE3TOzsU33X
         RDuw/hALO6c0XdkjXibMxI6PEX/7qLvm1bsP01pgcUwH1rtWLyA/m5Xy5mLVTCm3jfjX
         5dlg==
X-Gm-Message-State: AOJu0Yy5yWI67+1Q4s0C7pid7UH7nTmCBs00Ybt6/4oBJRQOB3Leb+4W
	IKku9SsN2EYiNLuyih5kZ9wixm1nsncqEcWaqEMglam7WuwAvqYCOIrxaCiwVg==
X-Google-Smtp-Source: AGHT+IGg4+IGzhJP7MIvozGiIxeCukCuJJWtYeZy+oldSqLHfpTJmlaKX6GIfSTR9p9KKXpwmgjCbmVxvClD41EsUtA=
X-Received: by 2002:a50:f605:0:b0:553:b7c6:1e47 with SMTP id
 c5-20020a50f605000000b00553b7c61e47mr51248edn.2.1704493273550; Fri, 05 Jan
 2024 14:21:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206150729.54604-1-marpagan@redhat.com>
In-Reply-To: <20231206150729.54604-1-marpagan@redhat.com>
From: Rae Moar <rmoar@google.com>
Date: Fri, 5 Jan 2024 17:21:02 -0500
Message-ID: <CA+GJov55Una_Ov9oKPhO0WY_zssyhn_agwhbbvpwSws7NuSgDQ@mail.gmail.com>
Subject: Re: [PATCH v3] kunit: run test suites only after module
 initialization completes
To: Marco Pagani <marpagan@redhat.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Javier Martinez Canillas <javierm@redhat.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 10:07=E2=80=AFAM Marco Pagani <marpagan@redhat.com> =
wrote:
>
> Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
> kunit_free_suite_set()") fixed a wild-memory-access bug that could have
> happened during the loading phase of test suites built and executed as
> loadable modules. However, it also introduced a problematic side effect
> that causes test suites modules to crash when they attempt to register
> fake devices.
>
> When a module is loaded, it traverses the MODULE_STATE_UNFORMED and
> MODULE_STATE_COMING states before reaching the normal operating state
> MODULE_STATE_LIVE. Finally, when the module is removed, it moves to
> MODULE_STATE_GOING before being released. However, if the loading
> function load_module() fails between complete_formation() and
> do_init_module(), the module goes directly from MODULE_STATE_COMING to
> MODULE_STATE_GOING without passing through MODULE_STATE_LIVE.
>
> This behavior was causing kunit_module_exit() to be called without
> having first executed kunit_module_init(). Since kunit_module_exit() is
> responsible for freeing the memory allocated by kunit_module_init()
> through kunit_filter_suites(), this behavior was resulting in a
> wild-memory-access bug.
>
> Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
> kunit_free_suite_set()") fixed this issue by running the tests when the
> module is still in MODULE_STATE_COMING. However, modules in that state
> are not fully initialized, lacking sysfs kobjects. Therefore, if a test
> module attempts to register a fake device, it will inevitably crash.
>
> This patch proposes a different approach to fix the original
> wild-memory-access bug while restoring the normal module execution flow
> by making kunit_module_exit() able to detect if kunit_module_init() has
> previously initialized the tests suite set. In this way, test modules
> can once again register fake devices without crashing.
>
> This behavior is achieved by checking whether mod->kunit_suites is a
> virtual or direct mapping address. If it is a virtual address, then
> kunit_module_init() has allocated the suite_set in kunit_filter_suites()
> using kmalloc_array(). On the contrary, if mod->kunit_suites is still
> pointing to the original address that was set when looking up the
> .kunit_test_suites section of the module, then the loading phase has
> failed and there's no memory to be freed.
>

Hello,

I have tested this change and it looks good to me!

Although, it no longer applies cleanly on the kselftest/kunit branch
so it will need to be rebased.

So besides the need for a rebase,
Tested-by: Rae Moar <rmoar@google.com>

Thanks for the fix!
Rae

> v3:
> - add a comment to clarify why the start address is checked
> v2:
> - add include <linux/mm.h>
>
> Fixes: 2810c1e99867 ("kunit: Fix wild-memory-access bug in kunit_free_sui=
te_set()")
> Tested-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  lib/kunit/test.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 7aceb07a1af9..3263e0d5e0f6 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -16,6 +16,7 @@
>  #include <linux/panic.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched.h>
> +#include <linux/mm.h>
>
>  #include "debugfs.h"
>  #include "hooks-impl.h"
> @@ -775,12 +776,19 @@ static void kunit_module_exit(struct module *mod)
>         };
>         const char *action =3D kunit_action();
>
> +       /*
> +        * Check if the start address is a valid virtual address to detec=
t
> +        * if the module load sequence has failed and the suite set has n=
ot
> +        * been initialized and filtered.
> +        */
> +       if (!suite_set.start || !virt_addr_valid(suite_set.start))
> +               return;
> +
>         if (!action)
>                 __kunit_test_suites_exit(mod->kunit_suites,
>                                          mod->num_kunit_suites);
>
> -       if (suite_set.start)
> -               kunit_free_suite_set(suite_set);
> +       kunit_free_suite_set(suite_set);
>  }
>
>  static int kunit_module_notify(struct notifier_block *nb, unsigned long =
val,
> @@ -790,12 +798,12 @@ static int kunit_module_notify(struct notifier_bloc=
k *nb, unsigned long val,
>
>         switch (val) {
>         case MODULE_STATE_LIVE:
> +               kunit_module_init(mod);
>                 break;
>         case MODULE_STATE_GOING:
>                 kunit_module_exit(mod);
>                 break;
>         case MODULE_STATE_COMING:
> -               kunit_module_init(mod);
>                 break;
>         case MODULE_STATE_UNFORMED:
>                 break;
>
> base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
> --
> 2.43.0
>

