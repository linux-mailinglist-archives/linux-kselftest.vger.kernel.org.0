Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75EE76EDB8
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 17:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbjHCPNw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 11:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjHCPNv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 11:13:51 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40D1E77
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 08:13:50 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a741f46fadso829285b6e.0
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Aug 2023 08:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691075630; x=1691680430;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSK2FUGY1przyTtVFiZaUHO9KuKYI8oQjaSBCONicVY=;
        b=FgI6HJuCLmlIIfhgwxl2HYhgvvEO0gMnbnbo5JcS1tXxFRRW3EO9yVG41ccq44RWRy
         1x/q83ecGHJhoaaZU93W3GpWnoOM0h5hMYD0SD75A5flKg+3Ho7RFEtkK9ZQoqwfOl0A
         +cVLthsaYH5icLAo+tZX+lUq/wgFJK9YcCYjkaqnipVDrI++onoa5b+LZoJJ4L1Jr30I
         GloMos7v8AstvMeOEs2u3/1cX6hnqKM2g9RMJWofn+YyPYEtIvYojTzRZgHZJr/cBuIf
         LAKzWa0iNzLT7Gx6ZIcVX5IIzKdH9zS1KVKF/EICY+rOGY+4+pvj1r+e3UJCyX4CNYIP
         bVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691075630; x=1691680430;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSK2FUGY1przyTtVFiZaUHO9KuKYI8oQjaSBCONicVY=;
        b=e8MfsXnQlDRY+vRqAfiR0Wg3lB1fRVS8SHhWA7pMQ3jHicSCMOnOI+Jnz9X8h+Q2ei
         u15xFnwZiecjiqjURG7m6SB5bflIW+SVMvVazfu+lhMq98957gw7lgFMMM5Z2Psgxf4C
         RYVAWvrq1yWSKkPiWyE1qWvDhkKkh3vfOpu/qRJr4eScx5MiKf38ebPDOU5DIkX8NWgn
         gmbX2MGY4uo2Ti9fRjjgzQscoX9IGDQQWYpmg7shEID/28EvV3aNdcXW+nH98RWGMn5w
         LOHyvuN8FdoskrInEyjANJzFHMoprqJ9FZqM1j3eCdBKMtnPnPXgzFs++mRzs/WCrYlY
         3SOw==
X-Gm-Message-State: ABy/qLbgOBHT9E55NwwDp1lGXT8EHd1qbv3OTYihJew+0iXeOPjzP48h
        Hq2GiCtSl/sunSgKX7wUdllQuQ==
X-Google-Smtp-Source: APBJJlFVMdy6DDLkJxkMERnwGOiIBPbaX/0bBxceQP9420eI2mZRj6I9+lP/P1kOoB9353xoGfyMGA==
X-Received: by 2002:a05:6358:98a2:b0:134:c279:c829 with SMTP id q34-20020a05635898a200b00134c279c829mr10617038rwa.18.1691075629869;
        Thu, 03 Aug 2023 08:13:49 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id p27-20020a63951b000000b00563590be25esm1798pgd.29.2023.08.03.08.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 08:13:49 -0700 (PDT)
In-Reply-To: <20230712193514.740033-1-jhubbard@nvidia.com>
References: <20230712193514.740033-1-jhubbard@nvidia.com>
Subject: Re: [PATCH] selftests/riscv: fix potential build failure during
 the "emit_tests" step
Message-Id: <169107392499.27633.6579477595845776477.b4-ty@rivosinc.com>
Date:   Thu, 03 Aug 2023 07:45:24 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Evan Green <evan@rivosinc.com>,
        Hugh Dickins <hughd@google.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On Wed, 12 Jul 2023 12:35:14 -0700, John Hubbard wrote:
> The riscv selftests (which were modeled after the arm64 selftests) are
> improperly declaring the "emit_tests" target to depend upon the "all"
> target. This approach, when combined with commit 9fc96c7c19df
> ("selftests: error out if kernel header files are not yet built"), has
> caused build failures [1] on arm64, and is likely to cause similar
> failures for riscv.
> 
> [...]

Applied, thanks!

[1/1] selftests/riscv: fix potential build failure during the "emit_tests" step
      https://git.kernel.org/palmer/c/8c82d2bf5944

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

