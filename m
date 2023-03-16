Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1FF6BCEC1
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 12:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCPLxg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 07:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCPLxf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 07:53:35 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B65CDD4;
        Thu, 16 Mar 2023 04:53:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pclyg6cyLz4x7s;
        Thu, 16 Mar 2023 22:53:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1678967612;
        bh=b/pQ2wE5S7nHv3es7WZVEfLm9S28WgiyyZ+VQ07K+Ks=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qIzjIba+mLcN086XIllglaE3vpNgjSbNqfTWiHDhkQI/yDg9IRVyGDcDRkvLrgBm9
         w686YLSGO77RfMqR0D0LaJKZBKz0cMIEkBLpasaVnjoC2N/CMSCm/T3V2wZFufdsAh
         +ag39Zz2ywZP5NTmBUZQ2cTXvvSG1H1GxsylB3DiO9IYE4Hdc+ZhYPRyataH7ZvVy8
         Z84sTgzD3Ooomk2dJ+phz1hOWkWILTW6fJrz5zPhB19Bvc/G21W+5nfZawGNyvx1xH
         5/wSSVYKPsa9Y78wVDOWkf3lYWaolMNfklGMxMCMdRMpzuevSkuMJtYYmIFWGhb4SX
         o6YTUUoRp+XAw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Shuah Khan <shuah@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] KVM: PPC: support kvm selftests
In-Reply-To: <20230316031732.3591455-1-npiggin@gmail.com>
References: <20230316031732.3591455-1-npiggin@gmail.com>
Date:   Thu, 16 Mar 2023 22:53:26 +1100
Message-ID: <87ilf0nc95.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:
> Hi,
>
> This series adds initial KVM selftests support for powerpc
> (64-bit, BookS).

Awesome.
 
> It spans 3 maintainers but it does not really
> affect arch/powerpc, and it is well contained in selftests
> code, just touches some makefiles and a tiny bit headers so
> conflicts should be unlikely and trivial.
>
> I guess Paolo is the best point to merge these, if no comments
> or objections?

Yeah. If it helps:

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
