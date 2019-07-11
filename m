Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF1FA65E49
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2019 19:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfGKROX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Jul 2019 13:14:23 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44488 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGKROX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Jul 2019 13:14:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so3342898plr.11
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2019 10:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ucw9rSRviGvxmtHa1eJcbGqoOfZIZgp2Nd0u5B3lWZA=;
        b=Da22eipDrFV3sVjp5lhMK1Ag4ov7GIbghnsCPMLPbWr4HTpMO+0Xb4J2rn8DRx6qHT
         raOPgwKUlI6vG5+eZKye7qCGQQETow7AmhpRoh5cHUdPCXlRT2cKL12Jq3MiFeBw679W
         wk1YpqERzczakZBDQQ8pko2DW4C1f70wJ9S/ns+5k4w9umeU1hYehewCAr5tVqqhs2DW
         GqdMBotLNyKw4ICag2o2Axnjtx62CvFcXWSjSNMUtdvoLBIYxzy7ujuT7vx9Sj96r9wA
         vjLfAdfQxMO9pCXH+JWhO4dfi00ckikjgNwJov9+WJZ2h2rnzwxooDe//g0ahmSlempo
         WnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ucw9rSRviGvxmtHa1eJcbGqoOfZIZgp2Nd0u5B3lWZA=;
        b=dgkDX0SHLiaMApsmPSKM+sdiNAQUys/aWhV4xhoZFwr1qcIm2soX1dNgVPtzLrkYLr
         u3uzsFYG2iX39u+dXy7BB8TRO2F9P6+d5W9z2VUzbPOYefecp5TUNqjmpdbkfE0d3/CK
         EYy17v+F6AbJHpY/ceia/gAv49NIW8mYj90CHYWuyUiESeVQAV14d4EaLqNGSQWRR3s2
         uCddN36RtgoE+9laVg7ochABI8Qec72R+GnSoGeidMYWdVgetkzOMT35l7m44DHXIkCD
         UzCgnZHimP6zvQyTvXUMnrT+3oHID1Gks05dyqKrn7e+/SsQ7fy2wFWAPEHEHaYLR8n3
         UY+w==
X-Gm-Message-State: APjAAAU3Z1+4uO+6xiKWSq+yTgokDWJlf7stfX8Mblb2eeZIT2/L3Gb7
        rvwnDXBSOjmZXBr2ChUv6dg/Box6lLXoWA44yFD4AQ==
X-Google-Smtp-Source: APXvYqyCiqSqHnYjKAeXDLQuC0c8sZpZJD60JXgP1quXPWouPH4pF7fZdEdLqQyRgFNNeHBCL0hiMDCMtYcdYDM2b4s=
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr5777071plq.223.1562865261987;
 Thu, 11 Jul 2019 10:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190710130206.1670830-1-arnd@arndb.de> <33511b0e-6d7b-c156-c415-7a609b049567@arm.com>
 <CAK8P3a1EBaWdbAEzirFDSgHVJMtWjuNt2HGG8z+vpXeNHwETFQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1EBaWdbAEzirFDSgHVJMtWjuNt2HGG8z+vpXeNHwETFQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 11 Jul 2019 10:14:10 -0700
Message-ID: <CAKwvOdkubvsRCnJKCaesB=PF=DgXfsBzwzR8kyE9NzWPU8Gehg@mail.gmail.com>
Subject: Re: [PATCH] vsyscall: use __iter_div_u64_rem()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 11, 2019 at 5:28 AM Arnd Bergmann <arnd@arndb.de> wrote:
> clang does not like an inline assembly with a "=q" contraint for
> a 64-bit output:

Seems like starting in GCC 7, GCC may not like it either:
https://godbolt.org/z/UyBUfh
it simply warns then proceeds with code gen.  Another difference may
come from when GCC vs Clang perform dead code elimination (DCE) vs
semantic analysis.

-- 
Thanks,
~Nick Desaulniers
