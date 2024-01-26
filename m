Return-Path: <linux-kselftest+bounces-3628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D50283DCA7
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 15:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32AAB282710
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 14:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9AC1C2AE;
	Fri, 26 Jan 2024 14:44:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0391CD33;
	Fri, 26 Jan 2024 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706280290; cv=none; b=nj8CkXRJbTGwHF6ZNwPjLf78Nz55+Ir8JDGjk6CA2wu+S2kzHFH+tQvhLMgbc7MGgWC5ZJW2BXYcNVpQ66jkEq9aMydWZd+cz+JBN+lQts6CmukdgvAZURvPA4P5f22AN3GPGDZlsBwa8oyyAwFdb9LL/G8gE3gKQ1zTQSZnxAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706280290; c=relaxed/simple;
	bh=HL+laULSRdMNS9F+oXN/bayng5Ap6VNpmdPowc6QUtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mbxrCQlOipB0p4UDDsmGHeBluu/Ai3ONMi4fv25cryjwdVWzHOQ81wFDzQf7rdLItVTrRhVrEdyP128BuknkkR90iTlZmCZ4EU8vHHjFbLRK1h9WzJlnlEt4SE9LLJ2dMdYWma0SDlb2hL7IOgsM5Bn81v9Fxy34jC5MgrWGKZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-db3a09e96daso387274276.3;
        Fri, 26 Jan 2024 06:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706280287; x=1706885087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNYqBEu+dCYuyt6Xnn2uU8Pn9mgOAidGZMsoGkc2AdQ=;
        b=N/zZCENd2MGB65x/Jbh8Zc9vA6aNOBStCjaLPggpmtN5Ghs5o0o22GaYZNwrKqarYF
         NtRYxxAu6GP69a4nde1YVTzVeqIOwahQXFjYYcKDUH5SurwFY9maepkTCss3iDlfLa39
         FkN3MJ8jW6L/xLuwh6yMABPJjCgpcMTZ/ubYDx6DcPj42zgcwc25kBC9q45s559zoZzI
         oC1aDTtaxBkLZmQwAYNhRVm7k8npd0h74Wu1C0vuJCA3U4TO24v9REDpFSuR/4UXUsia
         gzFXramPQVFDdw1mXdyZc5jpY+gm6rUIS1bmg3siWkyaOvPxTO7rtvHfhz+PS9go4nr9
         HVWA==
X-Gm-Message-State: AOJu0Yyork4e/XGxxmDDUGMkRFYl/Y0M706EvB+4mX0/T31blOrOGaj7
	HrFj6CJnOl2FjLwHwmEga8JZlqre7fNdaD30VfytvV5F35bT2Td6uyVu5kQ78GU=
X-Google-Smtp-Source: AGHT+IHQKjsbsoL34juyhZu2b4CyppRSj+oxIYW5RAH6O5gKhkPrbcDmGB4jfl2AD4Q+heEL12aTCw==
X-Received: by 2002:a25:2d23:0:b0:dbe:35b0:1708 with SMTP id t35-20020a252d23000000b00dbe35b01708mr1265241ybt.121.1706280286881;
        Fri, 26 Jan 2024 06:44:46 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id h1-20020a25e201000000b00dc63e73aaa0sm407470ybe.56.2024.01.26.06.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 06:44:41 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc21d7a7042so404197276.2;
        Fri, 26 Jan 2024 06:44:41 -0800 (PST)
X-Received: by 2002:a25:beca:0:b0:dc6:52da:3faa with SMTP id
 k10-20020a25beca000000b00dc652da3faamr254704ybm.43.1706280280507; Fri, 26 Jan
 2024 06:44:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110155948.90964-1-marpagan@redhat.com>
In-Reply-To: <20240110155948.90964-1-marpagan@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Jan 2024 15:44:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXTA9WK8vJYUYma33KZK7199MX+dghzHXTE4JKygTsbPg@mail.gmail.com>
Message-ID: <CAMuHMdXTA9WK8vJYUYma33KZK7199MX+dghzHXTE4JKygTsbPg@mail.gmail.com>
Subject: Re: [PATCH v4] kunit: run test suites only after module
 initialization completes
To: Marco Pagani <marpagan@redhat.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marco,

On Wed, Jan 10, 2024 at 5:01=E2=80=AFPM Marco Pagani <marpagan@redhat.com> =
wrote:
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
> kunit_test_suites section of the module, then the loading phase has
> failed and there's no memory to be freed.
>
> v4:
> - rebased on 6.8
> - noted that kunit_filter_suites() must return a virtual address
> v3:
> - add a comment to clarify why the start address is checked
> v2:
> - add include <linux/mm.h>
>
> Fixes: 2810c1e99867 ("kunit: Fix wild-memory-access bug in kunit_free_sui=
te_set()")
> Reviewed-by: David Gow <davidgow@google.com>
> Tested-by: Rae Moar <rmoar@google.com>
> Tested-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Marco Pagani <marpagan@redhat.com>

Thank you, this fixes the crashes I was seeing when running
platform_device_test, and which I bisected to the commit in the
Fixes tag.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

