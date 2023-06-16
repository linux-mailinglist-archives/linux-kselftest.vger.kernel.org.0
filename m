Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478E573287B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jun 2023 09:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjFPHLP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Jun 2023 03:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241156AbjFPHKr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Jun 2023 03:10:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04734297A;
        Fri, 16 Jun 2023 00:10:44 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a0c:5a83:9106:d00:27a:a702:1397:9647])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 044206606F61;
        Fri, 16 Jun 2023 08:10:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686899443;
        bh=OaC1nUKdnxfa6K3QRDHYonpcCa70eHiwXnh/es/qfhs=;
        h=From:To:Cc:Subject:References:In-reply-to:Date:From;
        b=XJNz+vis7E9WaQQYxIJBmj7bz72IwFZpEksccqocNsKW7/KYpg9eyC3MRIVC+kZ7A
         DyPFv4AIC45g4nR2msp6Ssh2XQ1gl9RecLkdhkrQbKlpQ7VeyPxNNE4h2VsMclujlf
         0o9P/W2llNpjmjYbmBJKB+mwFc0Thou+gyKgCpA/jZ4+JWhKXqfE3O769mgDJEpN0n
         3kieBNxZO0v48Hb4iMVFdc8gN0wfgS8wL5FNgwe7nOQv5g6l3pl2Z1j6AHLtz9e6Rg
         rg2iyujO02hKA1mgzweTd06Fc4cYZsVhrkprCUdnuARHHg62hPag8ptEj6HT/GDhez
         ZYw04T+FCYFug==
From:   Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>,
        kernel@collabora.com, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: Increase kselftest timeout
References: <20221213183242.1908249-1-nfraprado@collabora.com> <2ee34e21-44bd-71e7-6da2-f4bea9a35452@linuxfoundation.org> <20230515094310.hulpyhhtb4sxxn7i@rcn-XPS-13-9305>
In-reply-to: <20230515094310.hulpyhhtb4sxxn7i@rcn-XPS-13-9305>
Date:   Fri, 16 Jun 2023 09:10:39 +0200
Message-ID: <87sfarj30w.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Hi Shuah,

Gentle ping for this

On lun, may 15 2023 at 11:43:10, Ricardo Ca=C3=B1uelo <ricardo.canuelo@coll=
abora.com> wrote:
> Is there a downside to that? There'll be some tests that take more time,
> I don't think that's a problem with the tests or a reason to let them
> timeout. IMO it's the test framework which should adapt to the needs of
> different types of tests, and the solution provided by this patch is
> good enough, it addresses the problem for this particular test suite.
>
> If the solution is still unacceptable, do you have an alternative
> proposal in mind that we can try to implement?

There are some tests failing because of this and we're trying to address
these problems to clean up the regression results.

Thanks,
Ricardo
