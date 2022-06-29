Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1737C56008E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jun 2022 14:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbiF2Mzx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jun 2022 08:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiF2Mzw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jun 2022 08:55:52 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CF02E9E0;
        Wed, 29 Jun 2022 05:55:51 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3D6114FA;
        Wed, 29 Jun 2022 12:55:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3D6114FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656507351; bh=XJl5q3/vT6FIjNUi1Eb8cZqtdz9msa9ZVePJ+Srhbno=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=g8zXpRz7bRSHh2wpmCa3bR+TZv80X7ujemiyJ30PgS4KXcMl5z63hNUSVC80KcyoD
         +MeF/mYx4AwKhljGaEeMCKdGLc+6q2dpN2QdpK7B4MuW77e6yOuPAHcVnHv+depega
         5hSKpLBzEY5p8wfepa2FoRKW1zERC2coUEcK2UmjxjNG8WswAamtiYUy8cPTP38QHU
         hISEGvAgIDdYUE7CGy/uJhPMQN98AQKR3O+05oJiAVtTPi5J3nM0jNTAKv01sPP/Aw
         aViVFbyBLygEtnHcqhys8P1jO0ojWDPFjSFEZ3gxs26BDLaoUaSU2tNCE9w9gf1vqO
         MvLLtSdVmGD8A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     David Gow <davidgow@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2] Documentation: kunit: Cleanup run_wrapper, fix x-ref
In-Reply-To: <CABVgOSkybS55KynNvSA-B=2Lemwe-iTOwZ55BO4PwaECokizTw@mail.gmail.com>
References: <20220626101553.1885428-1-davidgow@google.com>
 <20220629040605.2395481-1-davidgow@google.com>
 <321d069a-0db3-6abd-c25e-4da46f361bd7@gmail.com>
 <CABVgOSkybS55KynNvSA-B=2Lemwe-iTOwZ55BO4PwaECokizTw@mail.gmail.com>
Date:   Wed, 29 Jun 2022 06:55:50 -0600
Message-ID: <87tu83tyqx.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

David Gow <davidgow@google.com> writes:

> Thanks. The rest of this document is using "we" rather than "you", so
> I used "we'll" for consistency. If "you" is preferred generally, it'd
> be best to change it throughout the document (probably in a separate
> patch).

Nobody has ever tried to articulate a wider policy on first or
second-person usage for kernel docs, so far as I know, and I think
that's just fine.  We have far bigger things to worry about before we
get concerned about consistency at that level.

Thanks,

jon
