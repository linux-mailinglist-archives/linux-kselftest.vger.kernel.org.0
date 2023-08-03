Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E2276EDB9
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 17:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbjHCPNy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 11:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbjHCPNx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 11:13:53 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A69EE75
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 08:13:52 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686c06b806cso729159b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Aug 2023 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691075631; x=1691680431;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+a2fB54AlyWkzUEDuBDciIZSmupcAmDbViWZx3iiKns=;
        b=Ia16/ollXxBwMbhUVSz6hrN1tzd3JyT9/2JfyDWqgU811+gqlY2/F4J61JC5EvCmui
         A5diJaWmzz0zpBQIJhvmum3sz+EmiFTCz9CI5nCYorYmWtKYoiFDs/odDi0QI3S+2/R3
         1B5dMWtoqJDTScq0i6GhqmVryrks7vHhEDz17rWrQCpuIYcEYV69peyUjAKxvnrqnqra
         FDDSvBA1edVKuGCjMkgOmmqdi/MsJvjKYisoBApyRESUgn8Jl9eabBXcl8eDVt8qE0WT
         oAKuNEd6CZ1rldGMm6us9LM5dPZZm/bINtvp0r+ssEuAnQmKF4TazYbtaQDBo0Gh1sQL
         fy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691075631; x=1691680431;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+a2fB54AlyWkzUEDuBDciIZSmupcAmDbViWZx3iiKns=;
        b=HSuDeNl3dDPwehaMpfiHsAsJmeLES3GOSeS9wbe6DgS5NyU2kvb3Iof8miIx4zeZKy
         /M2tLnLxB2S5cV9eAWXgtQDSjUrj0e4kWj7CTF8jw1+MWKqq1z1qbzIH38KfQoIXodCe
         WvJXActMx0Se11wBQAyMFk4pRADpESjM1WVSt99hkF77H+HmIQjDTkE4Zl2gPWmHUS/0
         tAh+FIOllAEBwTPqhTkES1Hq3/F5gUZf5/wEcl3QMj6xzEMJb3RSwYSpm7p5PRSvdJxQ
         fM3g7iba7bQhQqvgrI445DcvotDZ+o5u2HpXP7XkGYG25X6CW+YwKIDrUH4Fn+05yr0P
         moCw==
X-Gm-Message-State: ABy/qLYIWpxBmVZZnxSJuf6jOAu9jC57ecACzKcZtSS9sB+7cAGSeD3k
        Isd2jXDWZLSn1Si500FL0ZrFMg==
X-Google-Smtp-Source: APBJJlFXAXyW8unSJ5ZlFzseZ1bjrOQHVX7phAzP8V10iSKpxZee3WmCWxSSSr3wjOFSUnrA5p1HQg==
X-Received: by 2002:a05:6a00:b8f:b0:687:472f:514a with SMTP id g15-20020a056a000b8f00b00687472f514amr11383383pfj.2.1691075631160;
        Thu, 03 Aug 2023 08:13:51 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id v13-20020a62a50d000000b0066ebaeb149dsm7176947pfm.88.2023.08.03.08.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 08:13:50 -0700 (PDT)
In-Reply-To: <20230713115829.110421-1-alexghiti@rivosinc.com>
References: <20230713115829.110421-1-alexghiti@rivosinc.com>
Subject: Re: [PATCH] selftests: riscv: Fix compilation error with
 vstate_exec_nolibc.c
Message-Id: <169107392503.27633.2191837906397435034.b4-ty@rivosinc.com>
Date:   Thu, 03 Aug 2023 07:45:25 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-901c5
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andy Chiu <andy.chiu@sifive.com>,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On Thu, 13 Jul 2023 13:58:29 +0200, Alexandre Ghiti wrote:
> The following error happens:
> 
> In file included from vstate_exec_nolibc.c:2:
> /usr/include/riscv64-linux-gnu/sys/prctl.h:42:12: error: conflicting types for ‘prctl’; h
> ave ‘int(int, ...)’
>    42 | extern int prctl (int __option, ...) __THROW;
>       |            ^~~~~
> In file included from ./../../../../include/nolibc/nolibc.h:99,
>                  from <command-line>:
> ./../../../../include/nolibc/sys.h:892:5: note: previous definition of ‘prctl’ with type
> ‘int(int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)
> ’
>   892 | int prctl(int option, unsigned long arg2, unsigned long arg3,
>       |     ^~~~~
> 
> [...]

Applied, thanks!

[1/1] selftests: riscv: Fix compilation error with vstate_exec_nolibc.c
      https://git.kernel.org/palmer/c/25696067202f

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

