Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9E27B56B4
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Oct 2023 17:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbjJBPgc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 11:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238138AbjJBPgZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 11:36:25 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD036DC
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Oct 2023 08:36:21 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-577fff1cae6so2223001a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Oct 2023 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696260981; x=1696865781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RgMLD9dSESZx52XLswNxjXiae7bjz6p9TOP3CQJHyA=;
        b=oky/oqG2dLxveE0LCaeozY/1eKrsOFkx/QIfqtBzkf9wQXi+RSSxI+IAzKe5SePCIR
         +SgKbhHh0n1FeXE76779o5YLUAGOwVkyoDt78Wwzp6L2ZjdGArDi9UumFpkQNRLd3/21
         m4LE0R1onuyCZvn0aW9y5JwsVdnD4AWxKO5dSn1jkg2ttlWrYFy2WrJY3e2F1badcnYU
         bZSgJldjWYsHLhchTN6VOdlYvrQEcaAo/KHm2i8v6fe0Dws64FE58UJvgqvNB48MtmJf
         +1n2VuC4RC4gTrQ8EK7uEyUUejfCa5lSPo+efD/TVTsa6zYh7GpWVLnkzb4OhwcbF2eR
         zM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696260981; x=1696865781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RgMLD9dSESZx52XLswNxjXiae7bjz6p9TOP3CQJHyA=;
        b=FIeE1Wbfw/ZwbOikcPCVQhpM+U6jPN64CAab/jUuS2i3rz7L0KtBhkH3E9isKeNlKQ
         qcBwd3g83lpVMRC80B9StE5ur1ZU+q+Z7rbqwwfYJ8po6y4vBVcHDmelH1IPf7zk1zZ4
         fLt8JNf6pZtL78kgeF02rNUVrEeKkuTktxISjgXgvbj+1gSLfXPtvY+yMlwehwIvkDEI
         9rC2iygL/+mxZKFJhRLI3WEhnwJ9NfiZWD/+JDS6L8jGS57XuRGTWgLrLvRQ1BHVDlu6
         rb5ETgjhklWCXSvbqPjH8OeQ41+Yq3sCsoMpQChHDXdfuBDPpo8FSAEk/tzvprVdXym4
         tbyQ==
X-Gm-Message-State: AOJu0Yyb+XZxpP/0wCRS+u7waakZJaR1rPTddLhb2dp+AFyWhkHgzxKb
        rMJzuG9mMwhpcSPvPclGF5zW3OukLr5UwF42O5gCMw==
X-Google-Smtp-Source: AGHT+IHdUbkKZ2bTW3F9Qg4PjCMCpRtqgGBYo+9VzsIQ8Arz7Ddo4OzAJxCLa36qrqP4KqitPbbTePoaUqx96PBwxCI=
X-Received: by 2002:a17:90a:b396:b0:277:422d:3a0f with SMTP id
 e22-20020a17090ab39600b00277422d3a0fmr18387610pjr.17.1696260981095; Mon, 02
 Oct 2023 08:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230919035343.1399389-1-apatel@ventanamicro.com>
 <20230919035343.1399389-2-apatel@ventanamicro.com> <ZRpitP5y1yhzKwbE@infradead.org>
In-Reply-To: <ZRpitP5y1yhzKwbE@infradead.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 2 Oct 2023 21:06:08 +0530
Message-ID: <CAK9=C2XyQtHy3__i+fahbi49=j5Z3Z_Bv5s3Ptqjmuaa5q18LA@mail.gmail.com>
Subject: Re: [PATCH 1/7] RISC-V: Detect XVentanaCondOps from ISA string
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 2, 2023 at 11:57=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Sep 19, 2023 at 09:23:37AM +0530, Anup Patel wrote:
> > The Veyron-V1 CPU supports custom conditional arithmetic and
> > conditional-select/move operations referred to as XVentanaCondOps
> > extension. In fact, QEMU RISC-V also has support for emulating
> > XVentanaCondOps extension.
> >
> > Let us detect XVentanaCondOps extension from ISA string available
> > through DT or ACPI.
>
> Umm, I though Linux/riscv would never support vendor specific
> extensions?
>

We already have few T-Head specific extensions so Linux RISC-V
does allow vendor extensions.

Regards,
Anup
