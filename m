Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6EA6F8D44
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 May 2023 02:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjEFA4M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 May 2023 20:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjEFA4K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 May 2023 20:56:10 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79D17298
        for <linux-kselftest@vger.kernel.org>; Fri,  5 May 2023 17:56:03 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-ba1815e12efso2203381276.3
        for <linux-kselftest@vger.kernel.org>; Fri, 05 May 2023 17:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683334563; x=1685926563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKg9ooWeNyIkgIgwiRq1E2syoa7nncxzMKLzyswsRsc=;
        b=oEYCubX2MVaZ3lIzvYofKvwQIDmS/lXvTaPe+nx4JYIouIEOq7/VZNJBz/955TtNWl
         rYZHJ+9qECqeg4RDvNtvrHP7Ui0lGMPDX2ubGmDW8gNEBQ4HBdjErLbRCtIQE4/ErBRb
         UlUMiTVsTHoQ8RelA4t0FXBYWpOlPMnSpnz4cQsoVWkXnKmP9FEXp+ofhhYThW6YyuE1
         IHUvMHy+BC8pzZGtWZNz6yAWNfS98wy2U8g8HBZK4UcJlfQuJKNgMLKe1XbotZB+DRQJ
         E6hjwHB7/x0k7bAxrYPgZylFDAG4hiLFoxg569IPVzorgRuRk9NqLc9+2y4ttTt5sYY5
         aecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683334563; x=1685926563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKg9ooWeNyIkgIgwiRq1E2syoa7nncxzMKLzyswsRsc=;
        b=EXdoNFwCExaapjhYK6XG/pydpzSvQhj1cARPefZL8NgoHjjbJYKgQl8DBW0W2CKrHA
         Fx1e7/boGV3xlnuUrPVFqwaSlX71zdxCMpikgB85rDMmZXs9HHGhDi6Ro1TFb+/s5A8G
         dr69I5bgSHskNv3hI/wYa11ujHHM9Fv7GlzbJksYOKIRJ4RGZE7CeGL3GQet3U0Bzqne
         1CHKdiWvO5yVE4mwAqNLz86hkr7DMA6GOrDOK3PRt1UVpPjSS74xBTpwTA9tie3Ox4UT
         VwgOE7bLKg1xfFJnpDLSBVLAnugFBZ+BFDXlSnmtgVvcKpbgkil2zeFH4Aoue0HRswtD
         8ayw==
X-Gm-Message-State: AC+VfDzwXrWeAxWMK7RYLooRf+eZUczdn7BlFW5OMy7U16+Lc0+760aA
        SinwlX/tFr0Rah/trCGjsBHhFFyFkVQyTx/zGoHfLw==
X-Google-Smtp-Source: ACHHUZ7wTUegv3WyR7/Hq6e7DeiGJOrweEWBdXtRxu9dBQrh9sKO2r4H3TUs5GZtQPSXUUdXPbUlcJtY7oipXngdTpg=
X-Received: by 2002:a0d:cb44:0:b0:556:b029:e101 with SMTP id
 n65-20020a0dcb44000000b00556b029e101mr3457366ywd.19.1683334562650; Fri, 05
 May 2023 17:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230421165305.804301-1-vipinsh@google.com> <20230421165305.804301-10-vipinsh@google.com>
 <86pm7xjh3y.wl-maz@kernel.org>
In-Reply-To: <86pm7xjh3y.wl-maz@kernel.org>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Fri, 5 May 2023 17:55:26 -0700
Message-ID: <CAHVum0d4W0emmyS0G8_nCXQuvgZN-8utDiT6TMYrOq7dF60aAw@mail.gmail.com>
Subject: Re: [PATCH 9/9] KVM: arm64: Run clear-dirty-log under MMU read lock
To:     Marc Zyngier <maz@kernel.org>
Cc:     oliver.upton@linux.dev, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
        aleksandar.qemu.devel@gmail.com, tsbogend@alpha.franken.de,
        anup@brainfault.org, atishp@atishpatra.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, seanjc@google.com, pbonzini@redhat.com,
        dmatlack@google.com, ricarkol@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 21, 2023 at 10:11=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrot=
e:
>
> On Fri, 21 Apr 2023 17:53:05 +0100,
> Vipin Sharma <vipinsh@google.com> wrote:
> >
> > Take MMU read lock for write protecting PTEs and use shared page table
> > walker for clearing dirty logs.
> >
> > Clearing dirty logs are currently performed under MMU write locks. This
> > means vCPUs write protection fault, which also take MMU read lock,  wil=
l
> > be blocked during this operation. This causes guest degradation and
> > especially noticeable on VMs with lot of vCPUs.
> >
> > Taking MMU read lock will allow vCPUs to execute parallelly and reduces
> > the impact on vCPUs performance.
>
> Sure. Taking no lock whatsoever would be even better.
>
> What I don't see is the detailed explanation that gives me the warm
> feeling that this is safe and correct. Such an explanation is the
> minimum condition for me to even read the patch.
>

Thanks for freaking me out. Your not getting warm feeling hunch was
right, stage2_attr_walker() and stage2_update_leaf_attrs() combo do
not retry if cmpxchg fails for write protection. Write protection
callers don't check what the return status of the API is and just
ignores cmpxchg failure. This means a vCPU (MMU read lock user) can
cause cmpxchg to fail for write protection operation (under read lock,
which this patch does) and clear ioctl will happily return as if
everything is good.

I will update the series and also work on validating the correctness
to instill more confidence.

Thanks
