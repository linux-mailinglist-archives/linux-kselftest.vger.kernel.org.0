Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC177B85B9
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 18:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjJDQxT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 12:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjJDQxS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 12:53:18 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CE09B
        for <linux-kselftest@vger.kernel.org>; Wed,  4 Oct 2023 09:53:14 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-4527ba546d2so13895137.2
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Oct 2023 09:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696438394; x=1697043194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trfPvWlc2Z4z1gMaB+tLFdm/beJC1nNivy0/WxwIxQ0=;
        b=bNXQXmV0zD08F6kKmpGWVHS9LZQTmtobzoonvvPknnc+av5IWlE5IOzLD1VyE6Ajrp
         6EwbW9JZJnFkMByayCOFR9ZwgPLnfG3roV0UuuPVZrZBDogxyUTwK5+BEj3lxUrq3YjA
         GZCSwzqicVUzcLaaKGFEaDLjcTGYM3mtrTu/Sol5qdhsJ6RSgZgQnMD7cPWPC2/SMGzo
         sl4VCrb+bLBAJPdwhYxdPFP74E1PHHTxaVRx/WiSzwioXf/TZPl8D0+8hOsY9KBgj3YR
         A+AJJ6FMMYg6h3fPTPW/LapnEdQYJjOvcPb3lP277yo7YKijsAeQDU7DeDO4rVM6zUZ5
         O/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696438394; x=1697043194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trfPvWlc2Z4z1gMaB+tLFdm/beJC1nNivy0/WxwIxQ0=;
        b=ZNhPzZxYJTPpTovOp2NGejpz4hGPYgWmInja4fBTL7IqtZQigZ8xjsM+As2sIghb8I
         lXYThWqbmei0Je3g3zKOdFq8FBUCYolq1J4n7XOGxQcPR8Cwbx+OLhVWV3WWZTmaZowK
         8RSUUT2Fsa/2hkcntEqz6yF1dsuJfIxucp2t/5l/ehPU+BdjV4EgCKK1bxTUHoANnJDH
         tTH+cWBIIlEuhx3AUbuZDrgqR0g4Bsz+D5dD6xvDcbTMg90KEl9M1LZ5oXBm2RpJO75k
         pUT+oMdg0uNXSUS1vKE3/k7ObXjI6nRfTsT4eGclp/5rI19JQenEkiB6PoQbsN07Brw+
         lGqw==
X-Gm-Message-State: AOJu0YyHZrDWoqtyuOjV92UlTow7qIGHb4spzue0yn45ApvcuooUPyPp
        A6Pgl1ccJ2SUWsNP6XSU2baVS2O1RJowsD/yrc6q7A==
X-Google-Smtp-Source: AGHT+IEWCgvkfIvZj/B7L0SlMZXQCDSAI4lzHhqLl6NWb7K31ZFWxOCgbPKOxLXuc0v3xopPwsLqVue5HwUql+5JYvU=
X-Received: by 2002:a67:eb49:0:b0:44e:9f69:fa52 with SMTP id
 x9-20020a67eb49000000b0044e9f69fa52mr2366498vso.22.1696438393670; Wed, 04 Oct
 2023 09:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231004110905.49024-1-bjorn@kernel.org>
In-Reply-To: <20231004110905.49024-1-bjorn@kernel.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 4 Oct 2023 09:52:35 -0700
Message-ID: <CABCJKue8MW8dsrPG0PFC245jBRFx00JqcCEjzs=Os3TXwkcWFA@mail.gmail.com>
Subject: Re: [PATCH bpf 0/3] libbpf/selftests syscall wrapper fixes for RISC-V
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Bj=C3=B6rn,

On Wed, Oct 4, 2023 at 4:09=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Commit 08d0ce30e0e4 ("riscv: Implement syscall wrappers") introduced
> some regressions in libbpf, and the kselftests BPF suite, which are
> fixed with these three patches.

This series looks good to me. Thanks for fixing the issues!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
