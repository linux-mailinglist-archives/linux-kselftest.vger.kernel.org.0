Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3B274A841
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 02:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjGGAxD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 20:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjGGAxC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 20:53:02 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7F81BD3
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Jul 2023 17:53:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-314560a0f13so614896f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Jul 2023 17:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1688691179; x=1691283179;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r67n9FyRXMn2NIxHWlUhbk55uKQk9X6Dzb3qD8qYPqE=;
        b=esjLyRw9yG+IBiqgDC3zXqfCcnN/DbqAvEF78hFJzU3GMueXP0gDEe8GTEqkIWVxa3
         v5zA190KEwcagvtZcljHSX5zruOtY+4A2hJCW3xQ3kYhJ90qFeRfxiol/gEciWHjfH+V
         mSyV5wfea0jWsz4PHhQxxB5Beo4CjL8wQp1MdL2w0G7UKtRX2oxrtnD39TtmFgkTupMk
         WrOKCQbvpbAoBBwRglsxfn/NNxtlufKtOCK89XiZrAuUWobpoJwWEkM6LzWixFkAJGVS
         MnU63/tx7DAHW6EBB/ZRB4iDp07GMPxP25YJdWEYTFFIVGB2D/It7bRcDQ1rxLN1efdG
         V0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688691179; x=1691283179;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r67n9FyRXMn2NIxHWlUhbk55uKQk9X6Dzb3qD8qYPqE=;
        b=T65LfMaIQ7+Y+wr6mS9LXZbdIYM7qxLmg3R52FT0pW5aQjLW7yspyz4Zs9S/h1G/A/
         /W6sKdH5DHZhPGLGfQIHDw7KA7AC1GxdSuMEuE4Yp9BT0RmYB8HkZc/kg8qoWmxsNRaw
         ODfkzV3ADnpv5uSXd2SkJnYgeKNs/T7c8HUBnkPJ01GTJ/Jm5cECsjPGDQtb7VYKmQ0S
         Kd37bVSNQUmTNAei6GXlHgDJYUBPRVXVTJm8XLqrzF/y+tdk4uCsEZfjYea0L9IO0udZ
         g5P5Q0xJQSuzadvMiMgig3nnkMqpJI+JPXPpPStJrGpp/6ZT8MohKhtatYu25yWxh2U7
         xyew==
X-Gm-Message-State: ABy/qLZr3Lgx4/h6XNQQwWJ/fyzf5SXzgqG85PCciDkOpLEsFgh32CXf
        7Mh3oamKQ0Jl8RqK+VA8vFUsdQ==
X-Google-Smtp-Source: APBJJlG7B59PVAJXs+YJAtg1NQZvtbN9/7wzF9BiD0+Kq6eoLvFO+eLgMC5CjxyPq9DIG3O6/bYyWQ==
X-Received: by 2002:a5d:54d2:0:b0:313:f5f8:a331 with SMTP id x18-20020a5d54d2000000b00313f5f8a331mr2449781wrv.34.1688691178654;
        Thu, 06 Jul 2023 17:52:58 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id u15-20020a5d6acf000000b003143b7449ffsm3086566wrw.25.2023.07.06.17.52.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jul 2023 17:52:57 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [RESEND PATCH v3 1/2] RISC-V: mm: Restrict address space for
 sv39,sv48,sv57
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <ZKdUpzvyfy9f48MI@ghost>
Date:   Fri, 7 Jul 2023 01:52:47 +0100
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        mick@ics.forth.gr
Content-Transfer-Encoding: quoted-printable
Message-Id: <34483C0C-FA31-41E6-9263-1F9A08CEBE2C@jrtc27.com>
References: <20230705190002.384799-1-charlie@rivosinc.com>
 <20230705190002.384799-2-charlie@rivosinc.com>
 <2084462d-b11d-7a48-3049-6bafbe81e7b4@ghiti.fr> <ZKdUpzvyfy9f48MI@ghost>
To:     Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7 Jul 2023, at 00:56, Charlie Jenkins <charlie@rivosinc.com> wrote:
>=20
> On Thu, Jul 06, 2023 at 11:11:37AM +0200, Alexandre Ghiti wrote:
>> Hi Charlie,
>>=20
>>=20
>> On 05/07/2023 20:59, Charlie Jenkins wrote:
>>> Make sv48 the default address space for mmap as some applications
>>> currently depend on this assumption. The RISC-V specification =
enforces
>>> that bits outside of the virtual address range are not used, so
>>> restricting the size of the default address space as such should be
>>> temporary.
>>=20
>>=20
>> What do you mean in the last sentence above?
>>=20
> Applications like Java and Go broke when sv57 was implemented because
> they shove bits into the upper space of pointers. However riscv =
enforces
> that all of the upper bits in the virtual address are equal to the =
most=20
> significant bit. "Temporary" may not have been the best word, but this =
change=20
> would be irrelevant if application developers were following this =
rule, if I
> am understanding this requirement correctly. What this means to me is
> that riscv hardware is not guaranteed to not discard the bits in the =
virtual=20
> address that are not used in paging.

RISC-V guarantees that it will not discard the bits*. Java and Go =
aren=E2=80=99t
actually dereferencing the pointers with their own metadata in the top
bits (doing so would require a pointer masking extension, like how Arm
has TBI), they=E2=80=99re just temporarily storing it there, assuming =
they=E2=80=99re
not significant bits, then masking out and re-canonicalising the
address prior to dereferencing. Which breaks, not because the hardware
is looking at the higher bits (otherwise you could never use Sv57 for
such applications even if you kept your addresses < 2^47), but because
the chosen addresses have those high bits as significant.

* A page fault is guaranteed if the address isn=E2=80=99t sign-extended

Jess

