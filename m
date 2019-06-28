Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D819B59243
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2019 06:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfF1EEk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jun 2019 00:04:40 -0400
Received: from ozlabs.org ([203.11.71.1]:37067 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbfF1EEk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jun 2019 00:04:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Zjnx6mG3z9s7h;
        Fri, 28 Jun 2019 14:04:37 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Denis Efremov <efremov@linux.com>,
        Simon Guo <wei.guo.simon@gmail.com>
Cc:     Denis Efremov <efremov@linux.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/powerpc: ppc_asm.h: typo in the header guard
In-Reply-To: <20190623155200.2147-1-efremov@linux.com>
References: <20190623155200.2147-1-efremov@linux.com>
Date:   Fri, 28 Jun 2019 14:04:37 +1000
Message-ID: <87ef3es6cq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Denis Efremov <efremov@linux.com> writes:
> The guard macro __PPC_ASM_H in the header ppc_asm.h
> doesn't match the #ifndef macro _PPC_ASM_H. The patch
> makes them the same.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'll merge this.

Please include linuxppc-dev on powerpc selftest patches.

cheers

> diff --git a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
> index d2c0a911f55e..2b488b78c4f2 100644
> --- a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
> +++ b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef _PPC_ASM_H
> -#define __PPC_ASM_H
> +#define _PPC_ASM_H
>  #include <ppc-asm.h>
>  
>  #ifndef r1
> -- 
> 2.21.0
