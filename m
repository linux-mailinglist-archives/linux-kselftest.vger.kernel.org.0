Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE004A0AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2019 14:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfFRMXI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jun 2019 08:23:08 -0400
Received: from ozlabs.org ([203.11.71.1]:60477 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFRMXI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jun 2019 08:23:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45SnKj1dGhz9s9y;
        Tue, 18 Jun 2019 22:23:04 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] selftests/powerpc: Add missing newline at end of file
In-Reply-To: <20190617145204.6810-1-geert+renesas@glider.be>
References: <20190617145204.6810-1-geert+renesas@glider.be>
Date:   Tue, 18 Jun 2019 22:23:02 +1000
Message-ID: <87muifozfd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:
> "git diff" says:
>
>     \ No newline at end of file
>
> after modifying the file.

Is that a problem?

Just curious because it was presumably me that broke it :)

cheers

> diff --git a/tools/testing/selftests/powerpc/mm/.gitignore b/tools/testing/selftests/powerpc/mm/.gitignore
> index ba919308fe3052f3..16861ab840f57e90 100644
> --- a/tools/testing/selftests/powerpc/mm/.gitignore
> +++ b/tools/testing/selftests/powerpc/mm/.gitignore
> @@ -3,4 +3,4 @@ subpage_prot
>  tempfile
>  prot_sao
>  segv_errors
> -wild_bctr
> \ No newline at end of file
> +wild_bctr
> -- 
> 2.17.1
