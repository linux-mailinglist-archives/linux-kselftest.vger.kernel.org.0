Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A3F730DB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jun 2023 05:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbjFODvv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 23:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjFODvv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 23:51:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FBC211D;
        Wed, 14 Jun 2023 20:51:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QhSyr4qs2z4wg8;
        Thu, 15 Jun 2023 13:51:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1686801108;
        bh=qGB4VmQpo0NG0SfVSZwSKZzT6dQGTcK0z6GE9CVlpHA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HUlBhzLnwGOuqz/Gh6n755jLbrwG/vJLsKNom07Ay3VJKFafsiXQmdJP4QkcVegHr
         TPv9WrgY+KwvsvgUvtxwnhgO/VZi7zvhdy58EOjeaGYvpTNcMTYYgV0MmUAN7AANof
         1hctcrLuo+FGcbqOhit+YywrNyXaTmrcXdbJlvNSgq39wX6+NpQe7vCIde0/9bqX/G
         /UydAteXIqvdHKE6b06jzhM3tCknRcuFOhJZTfaOnWIO9DmW/rm5l8ZAvrVxBMOlYD
         1YDO13QIF2j40mcPE3N+W2GlB8OxiovoCsRFsOztf1kT5H3Jxw6enTW1xKaoF7XNab
         70yM750BR17SQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     wuyonggang001@208suo.com, shuah@kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/powerpc: Remove unneeded variable
In-Reply-To: <553bb6053c7b7bee60eda3ca90470ac3@208suo.com>
References: <20230614070926.36395-1-zhanglibing@cdjrlc.com>
 <553bb6053c7b7bee60eda3ca90470ac3@208suo.com>
Date:   Thu, 15 Jun 2023 13:51:48 +1000
Message-ID: <87a5x1fkmj.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

wuyonggang001@208suo.com writes:
> Fix the following coccicheck warning:
>
> tools/testing/selftests/powerpc/alignment/alignment_handler.c:558:5-7: 
> Unneeded variable: "rc". Return "0"

The check is wrong.

> diff --git 
> a/tools/testing/selftests/powerpc/alignment/alignment_handler.c 
> b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
> index 33ee34fc0828..4980656c3f70 100644
> --- a/tools/testing/selftests/powerpc/alignment/alignment_handler.c
> +++ b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
> @@ -332,7 +332,7 @@ int test_alignment_handler_vsx_206(void)
>       STORE_VSX_XFORM_TEST(stxvd2x);
>       STORE_VSX_XFORM_TEST(stxvw4x);
>       STORE_VSX_XFORM_TEST(stxsdx);
> -    return rc;
> +    return 0;

rc is used in the macros.

cheers
