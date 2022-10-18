Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BD16036B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Oct 2022 01:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJRXkD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Oct 2022 19:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJRXkB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Oct 2022 19:40:01 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA3C48A27;
        Tue, 18 Oct 2022 16:39:59 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id l127so13121125iof.12;
        Tue, 18 Oct 2022 16:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SQny1BPtkzNGj7ldMA47rhjiJlgg7erY4ac0SwGdIYQ=;
        b=gyKQuaKXa791sgchUF23cA10pL+wyHyik86n5531IxeNu4A87kAC4BWuh2lr5+DOmj
         4yNghh/N1BJw+PHLDcDf07HXlFTTucREHCWEQav/Mjs/uMjAeK96zLoYNeDSH+Ii8klf
         Z3QXfzlcj7OSFyDp6fh8FinqkNJ30ZIVCxHDREurIN5ndppIcx5DFyq9cHVMy8wCXt7Y
         l0X8+BawNPe/JMf8di/+HqQdxI7KcCwe0ZgzxLKvR8w1GDuR8kylDlai5K8nnPo2ZvSD
         Jsp+LyVLgHwIvwl5KygEHK7zkFF2TiTfzTkvVR0VCxNB7oMpIExSviWRki0tDevklxS1
         2Vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQny1BPtkzNGj7ldMA47rhjiJlgg7erY4ac0SwGdIYQ=;
        b=Yv5nMe/g6w8dXBYVC8Ji0QZSzslsQTE8vdmsrUA/bDFQS0vUJFv1HFV12n2WDuMns9
         Je1a5yHt5x7xNPiJG/n681wokEkjVQyM726OEucIuIrHRmLy0aIi8TxvoLzDl+QI+oB0
         I7jcNt/CV7t+rN37OFsNJ/9UZa6vQ6PxufIe3wBVvt+TjbXpreY7gn39ID33hyLmTLh2
         M2hBKj7up6l0jObgCzAOnB/4YH1z0NDfEcr3uuGHj+2zV6gQxSf+I+bdzn2fB0Ohr303
         V/ZPr2RZ3+EipjoeSCWOv/XqLn+f9Td6Te9bhMMTcGpN31T9i60tSDhPC1n/DAhOGWu1
         xEPA==
X-Gm-Message-State: ACrzQf1kujwFAIz+qeOFpiJFUVigyI0UeUm6aUjfjn/Kbk84jBDzi84U
        fw3XpMFzU/eQhYHPMCl5nDSab4ZVyH5IN18qbRs=
X-Google-Smtp-Source: AMsMyM6YKLqCwHtPfLBSJBbnI8+TsIvgERke3CDtU0tjh/jN9V+SeSMrE4nwKYrNTaIfAcaHUoBvz56WjkqJl48wFwk=
X-Received: by 2002:a5d:9411:0:b0:6a7:f7ec:6dd8 with SMTP id
 v17-20020a5d9411000000b006a7f7ec6dd8mr3371256ion.44.1666136398884; Tue, 18
 Oct 2022 16:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221001002638.2881842-1-dlatypov@google.com> <CANiq72nU-eDOT94q26dTVgCFA_Hs1cGiLpDCmQ5n-cCVKAcsqQ@mail.gmail.com>
 <CAGS_qxqVUmjxULZ_Kt-gWRJb=+EYpG2_K89sQTq0BYbUighn5w@mail.gmail.com>
 <CANiq72m5nk4zvcYozFKjO=9gOXG2wx2MG1EYsgAZwB_PnHUSJA@mail.gmail.com> <CAGS_qxpi+93JPaKiowVM65WJJ0Nipd6EN6HYHe0ZO_McWy2woQ@mail.gmail.com>
In-Reply-To: <CAGS_qxpi+93JPaKiowVM65WJJ0Nipd6EN6HYHe0ZO_McWy2woQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 19 Oct 2022 01:39:48 +0200
Message-ID: <CANiq72=i4E7PczeiAt7G5qSMn1fyxe7iSXOsO==qiet8Dr591w@mail.gmail.com>
Subject: Re: [PATCH 0/4] kunit: more assertion reworking
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 19, 2022 at 1:26 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> No worries.
> You've had a very busy couple of weeks, I imagine.

Just a bit :) Nevertheless, it was my intention to reply :(

I have linked this thread from the PR noting that you warned me about
the future conflict [1], thanks again!

[1] https://github.com/Rust-for-Linux/linux/pull/915#issuecomment-1283138279

Cheers,
Miguel
