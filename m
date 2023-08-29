Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA28E78CF9A
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 00:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbjH2Wqu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 18:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjH2WqX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 18:46:23 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C07C1BE;
        Tue, 29 Aug 2023 15:46:20 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a3e943762so4260066b3a.1;
        Tue, 29 Aug 2023 15:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693349180; x=1693953980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmtPeHug/B1HLimSxaxEYtqxY0pc6mcFWzO4yPWTFzg=;
        b=ZLyjxeShdMA35jz35zIapNzj1ho8NU0+F8RIHEURwRa1kT3RDNBQ761G4zCwB+dIE4
         y1YBh4pgRaPs9p9VS1Rd+hLbtn7PH8e7rnYLpI64+RHPd+TWX0ZPVtHDKHBGleK/GJt9
         V56GtJ0ljPhBGReHEJu05coGhdFbBXc/mhldAdowVGB/dLZeB18VSEU0mymdwE/2ige7
         u/9WOpBr/DW4RmV+SQcE90OvwAzF7rubqjP+HKF8CSqbvW/qYWOTNQ9I2+zwSwmE6mG+
         Vy9qnypb93o60PFuh9N0F/sN7XUEHqLuGrwF522PP8ZxCRaqgy8NhNdvt/Kd5tIHXzRD
         1qSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693349180; x=1693953980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmtPeHug/B1HLimSxaxEYtqxY0pc6mcFWzO4yPWTFzg=;
        b=LB7TrGWmRTp+INli5uoJAw6fxdztkXiBsoNABGDpM34YWoBd42FRornJmp5h8/MD8r
         92k3rh9gZIxpCPXK4mSDhgcepKTZv+u+7+4KZPIwnG4yHat4/+V7tpMOrUya8JwxYl8w
         j5hqhTzP9mg+sM1sEdr8/G9yKIhXShDDcuJwoKO9DfRA6oje6XiViI8OeJm5LjLU6h2m
         m95k6aSKoPTUN+iEKEYnjsXTEHk03M07p1BAyYL4Hh5POMllnhX06IBayRNSQ/N1cZLc
         HuwixJtDllqRbYQe22h2mx6ITNmg2Ow3/R6fF3yruYyJDftaeJt7PczM0REC5kIOikCA
         7VUA==
X-Gm-Message-State: AOJu0YwDrS1mJ/YgjbpcKRDTw5sDi55VR1rLEAHdCy82nERtEkGi2icH
        FiG4tPM25Yy5seoDgLVR968=
X-Google-Smtp-Source: AGHT+IGCpIvjcAOXk62bqo0JiOihhnI3WAfLwnQwUXMuYUlIn87BMRurVpn7UfaAB9AYKGEZcIl/FA==
X-Received: by 2002:a05:6a00:2316:b0:68c:71df:7433 with SMTP id h22-20020a056a00231600b0068c71df7433mr721000pfh.0.1693349179850;
        Tue, 29 Aug 2023 15:46:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z7-20020a056a001d8700b0068c69ed223esm1559229pfw.77.2023.08.29.15.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 15:46:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 29 Aug 2023 15:46:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        keescook@chromium.org, linux-hardening@vger.kernel.org,
        jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org
Subject: Re: [PATCH v3 4/9] kunit: Add ability to filter attributes
Message-ID: <55950256-c00a-4d21-a2c0-cf9f0e5b8a9a@roeck-us.net>
References: <20230725212522.1622716-1-rmoar@google.com>
 <20230725212522.1622716-5-rmoar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725212522.1622716-5-rmoar@google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Tue, Jul 25, 2023 at 09:25:15PM +0000, Rae Moar wrote:
> Add filtering of test attributes. Users can filter tests using the
> module_param called "filter".
> 
> Filters are imputed in the format: <attribute_name><operation><value>
> 
> Example: kunit.filter="speed>slow"
> 
> Operations include: >, <, >=, <=, !=, and =. These operations will act the
> same for attributes of the same type but may not between types.
> 
> Note multiple filters can be inputted by separating them with a comma.
> Example: kunit.filter="speed=slow, module!=example"
> 
> Since both suites and test cases can have attributes, there may be
> conflicts. The process of filtering follows these rules:
> - Filtering always operates at a per-test level.
> - If a test has an attribute set, then the test's value is filtered on.
> - Otherwise, the value falls back to the suite's value.
> - If neither are set, the attribute has a global "default" value, which
>   is used.
> 
> Filtered tests will not be run or show in output. The tests can instead be
> skipped using the configurable option "kunit.filter_action=skip".
> 
> Note the default settings for running tests remains unfiltered.
> 
> Finally, add "filter" methods for the speed and module attributes to parse
> and compare attribute values.
> 
> Note this filtering functionality will be added to kunit.py in the next
> patch.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: Rae Moar <rmoar@google.com>

This patch causes all my s390 boot tests to crash.

[   17.009188]     # module: kunit
[   17.009239]     1..8
[   17.014967]     ok 1 parse_filter_test
[   17.020755]     ok 2 filter_suites_test
[   17.026350]     ok 3 filter_suites_test_glob_test
[   17.033102]     ok 4 filter_suites_to_empty_test
[   17.035422] Unable to handle kernel pointer dereference in virtual kernel address space
[   17.035546] Failing address: 0000000001501000 TEID: 0000000001501407
[   17.035617] Fault in home space mode while using kernel ASCE.
[   17.035833] AS:0000000002164007 R3:000000001f71c007 S:000000001f711000 P:000000000150131f
[   17.036313] Oops: 0004 ilc:2 [#1] SMP
[   17.036851] Modules linked in:
[   17.037026] CPU: 0 PID: 193 Comm: kunit_try_catch Tainted: G                 N 6.5.0-01207-g1c59d383390f #1
[   17.037106] Hardware name: QEMU 8561 QEMU (KVM/Linux)
[   17.037199] Krnl PSW : 0704e00180000000 0000000000950e18 (kunit_next_attr_filter+0xc8/0x1c8)
[   17.037451]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
[   17.037531] Krnl GPRS: 0000037f00000000 000000000150120a 000000000000003e 000000000000003e
[   17.037583]            0000038000197e04 0000038000197c04 0000038000197df0 000003800000000a
[   17.037629]            0000038000000005 0000000001501203 00000000015011fe 0000037f0000000c
[   17.037675]            0000000005404100 0000038000197e08 0000000000950dda 0000038000197cd8
[   17.038176] Krnl Code: 0000000000950e0a: b9180098		agfr	%r9,%r8
[   17.038176]            0000000000950e0e: a7080000		lhi	%r0,0
[   17.038176]           #0000000000950e12: e32090000090	llgc	%r2,0(%r9)
[   17.038176]           >0000000000950e18: 92009000		mvi	0(%r9),0
[   17.038176]            0000000000950e1c: b904003a		lgr	%r3,%r10
[   17.038176]            0000000000950e20: c418007bd73c	lgrl	%r1,00000000018cbc98
[   17.038176]            0000000000950e26: b25d0013		clst	%r1,%r3
[   17.038176]            0000000000950e2a: a714fffe		brc	1,0000000000950e26
[   17.038625] Call Trace:
[   17.038679]  [<0000000000950e18>] kunit_next_attr_filter+0xc8/0x1c8
[   17.038749]  [<000000000094e5f2>] parse_filter_attr_test+0x92/0x360
[   17.038796]  [<000000000094e39a>] kunit_generic_run_threadfn_adapter+0x32/0x48
[   17.038840]  [<0000000000186702>] kthread+0x142/0x148
[   17.038884]  [<0000000000103138>] __ret_from_fork+0x40/0x58
[   17.038927]  [<000000000102df9a>] ret_from_fork+0xa/0x30
[   17.038984] INFO: lockdep is turned off.
[   17.039027] Last Breaking-Event-Address:
[   17.039062]  [<0000000000950da4>] kunit_next_attr_filter+0x54/0x1c8
[   17.039303] Kernel panic - not syncing: Fatal exception: panic_on_oops

Bisect log is attached.

Guenter

---
# bad: [1c59d383390f970b891b503b7f79b63a02db2ec5] Merge tag 'linux-kselftest-nolibc-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
# good: [2dde18cd1d8fac735875f2e4987f11817cc0bc2c] Linux 6.5
git bisect start '1c59d383390f' 'v6.5'
# good: [42a7f6e3ffe06308c1ec43a7dac39a27de101574] Merge tag 'x86_microcode_for_v6.6_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 42a7f6e3ffe06308c1ec43a7dac39a27de101574
# good: [330235e87410349042468b52baff02af7cb7d331] Merge tag 'acpi-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect good 330235e87410349042468b52baff02af7cb7d331
# good: [5a31cc7297072a7266a910ca5266b640d27803b4] Merge tag 'linux-kselftest-next-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
git bisect good 5a31cc7297072a7266a910ca5266b640d27803b4
# good: [eea70cdac61087fdb7a1c1e6f306c0bf38ec39d4] tools/nolibc: riscv: shrink _start with _start_c
git bisect good eea70cdac61087fdb7a1c1e6f306c0bf38ec39d4
# good: [faeb4e09fe77262f9a6b2f9f874eec0b6850721e] selftests/nolibc: add test support for ppc64
git bisect good faeb4e09fe77262f9a6b2f9f874eec0b6850721e
# bad: [76066f93f1df27657eb937b7c9c091e3a6abf4db] kunit: add tests for filtering attributes
git bisect bad 76066f93f1df27657eb937b7c9c091e3a6abf4db
# good: [64bd4641310c41a1ecf07c13c67bc0ed61045dfd] MAINTAINERS: add Rust KUnit files to the KUnit entry
git bisect good 64bd4641310c41a1ecf07c13c67bc0ed61045dfd
# bad: [529534e8cba3e60f843a682e2a3149612b30d608] kunit: Add ability to filter attributes
git bisect bad 529534e8cba3e60f843a682e2a3149612b30d608
# good: [02c2d0c2a84172c3c7ec0229c61db55d23dd4730] kunit: Add speed attribute
git bisect good 02c2d0c2a84172c3c7ec0229c61db55d23dd4730
# good: [a00a72709175a4d53096301a8792b8171d1223e5] kunit: Add module attribute
git bisect good a00a72709175a4d53096301a8792b8171d1223e5
# first bad commit: [529534e8cba3e60f843a682e2a3149612b30d608] kunit: Add ability to filter attributes
