Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC4276C532
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 08:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjHBGTF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 02:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjHBGTE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 02:19:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10BF26A3
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Aug 2023 23:19:03 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a0c:5a83:9100:a000:7f51:fa54:ebdb:f0f4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 151F56607155;
        Wed,  2 Aug 2023 07:19:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690957142;
        bh=ytWKKUsBMFxlYkF9b6Hh0V2b5Q6ziIFpb4lNjrXzI9c=;
        h=From:To:Cc:Subject:References:In-reply-to:Date:From;
        b=Atr82Lb9QqW3Ss7XDdN0iJeeUlWGMrt5Z7Vgp+Ts2X4QLca0KcA2t8Ea5HPe5LmGa
         5TGGHS+7209fOqI7qUqtKa+VjmeN3VNQkBwndWzZjJdnaxZSW7jTobYH+e3T44j1um
         25jKia8aus3qZFsKjDycUuVrRE8q6gprNI7FF077lmW0FHPkkbYFMXSqIUBzv6vMMP
         G+J4CTPtBJEN1yLpt+5xA76dNNHMgxFUGGyrmfYIvkQoHaEfolWfGIKXV3JwADvqem
         08eb/BJhA0Rs8gNgFIrTM7myvs5yVeRDpMCR0sXiTLNcN1DTFclGj4LTlnrvEGYjFA
         qaMcC82ixzycg==
From:   Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel@collabora.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/lkdtm: Disable CONFIG_UBSAN_TRAP in test config
References: <20230801094329.1878928-1-ricardo.canuelo@collabora.com> <202308011724.C76E2B90@keescook>
In-reply-to: <202308011724.C76E2B90@keescook>
Date:   Wed, 02 Aug 2023 08:18:57 +0200
Message-ID: <871qgmhsq6.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Kees,

Thanks for reviewing the patch,

On mar, ago 01 2023 at 17:26:44, Kees Cook <keescook@chromium.org> wrote:
> I *think* instead, we can turn off TRAP but retain the ARRAY_BOUNDS
> kselftest by looking for either WARN or TRAP results:
>
> -ARRAY_BOUNDS
> +ARRAY_BOUNDS call trace:|UBSAN: array-index-out-of-bounds
>
> Can test that and send a v2?

Good idea! Sure, I can test it and I'll send v2 in a while.

Cheers,
Ricardo
