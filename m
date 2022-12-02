Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EE3640DFE
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 19:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiLBS5N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 13:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbiLBS5L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 13:57:11 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3963E2A7
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 10:57:07 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso9183527pjt.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Dec 2022 10:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Rz5UpMzXYgZMoXyZZE4qCEdFA3R1Id3Mcb4Kneqx3w=;
        b=SDnpom0zJ2R3+zJOhy9tvwU5UK6M3o9KuLtx8Y0qdcQZqTAD8yh/73ZTPJhiYvFMWn
         tDzDtAElkQKNodOy4M7562Uk8qGEktEb0sKtmmOhhbyZCziD16xlpuaEuH4riRMKQ4Nh
         8GBCtRS4v1NYDxvMzcXtM5bNedNNsjhAFWMwpPnXRjAe+CIoGY99owsfTzqGsjje2ayb
         jRHglDYNZOS8SUz5C7rqlmK6yS5/cczkvBCNN9xSt7j4IjA78TkTPnBgsP8sFskn7dgc
         HnXufQHgbfEKaKRE7v3NOB5xY0LenfGj3nPpzYSTrkJqu7pYLj+FLf7PxNcJH4p0SnRO
         WKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Rz5UpMzXYgZMoXyZZE4qCEdFA3R1Id3Mcb4Kneqx3w=;
        b=4h8nt0COgM6+88e1oC0bcl9b8DCsoUOmDQQC3k0Uk5Mq01SCKUoYT4CVcmp1fQOYDZ
         bagogrfUeDWb6EJnBooP82qTmZPwiE5ZcYvw8vJxKs3QLuDDpAtHy0dYRySsn4nrl2LG
         MyYmJIHzEHV5wJppFU3Mo5pZQLqCb0upgwOf2EDgOfozJMetylJRBpHNsyxnaqI41wwq
         zS7nmxZ3d3ak7NDXhQOafZCVzq84RrrDXOXg5EcsaNvy0inAbQx+6cdR04N25QikU2Y9
         LXB2KTffFue9qours2RLruPCxR/aWQxTEL4IQFQIAqWtd9NJ8B7Vm0FWLivFQgl4oNXC
         JGGA==
X-Gm-Message-State: ANoB5plPRjN39mEJNubueiJXInPhwUx42DAQQQQvnKt1pG0smCZK+Luj
        h7zSTwP17nDDd5d5w6EI4nN7sQ==
X-Google-Smtp-Source: AA0mqf7GepBk/7wa0KAS7905LJy/piMKUiywHc+G7GcK8dlK1+LrqnuCZga3Va1UccoiqVkZlqcPPg==
X-Received: by 2002:a17:902:8212:b0:187:2430:d37d with SMTP id x18-20020a170902821200b001872430d37dmr66172536pln.28.1670007426676;
        Fri, 02 Dec 2022 10:57:06 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id b7-20020a63cf47000000b00477def759cbsm4470494pgj.58.2022.12.02.10.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 10:57:06 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:57:02 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Colin King (gmail)" <colin.i.king@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] KVM: selftests: Fix spelling mistake
 "probabalistic" -> "probabilistic"
Message-ID: <Y4pKfrX1ZfKhAT6y@google.com>
References: <20221201091354.1613652-1-colin.i.king@gmail.com>
 <Y4o0Nq4SKGZgDOxi@google.com>
 <10445a4d-0175-3e5e-aa74-9d232737a7c2@gmail.com>
 <Y4pEaaQsnDWEOxjH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4pEaaQsnDWEOxjH@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 02, 2022, Sean Christopherson wrote:
> On Fri, Dec 02, 2022, Colin King (gmail) wrote:
> > You may be better off with using codespell
> 
> Heh, my kind of nitpicking people :-)
> 
>   MSDOS->MS-DOS
> 
> Thanks a ton, that's exactly what I was looking for!

For anyone following along and/or laughing at me, checkpatch even supports using
codespell, e.g.

  ./scripts/checkpatch.pl -g HEAD --codespell
