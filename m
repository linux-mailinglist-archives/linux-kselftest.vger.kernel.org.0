Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C6E20C11C
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jun 2020 13:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgF0LvD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Jun 2020 07:51:03 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35605 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgF0LvD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Jun 2020 07:51:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49vBsc3mjmz9sQt;
        Sat, 27 Jun 2020 21:51:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1593258661;
        bh=xEz22EEr1iFHSE8pxhjh5L52uRmZW6PEMk3Lae+vbDs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ph+imXs0fshohkeTLr3Ki0t07qSdSKZA98keKJfxmeDUMjdfJQiZP1S9/xOFr+h0H
         K8Ad510DKnHsGmlhEW2TkBsAb1oUSFg/Wgzjr8KuAe1bvI/Xjq1+ousAjSrZlZ01/X
         3AZurdHAvmB51BoJXBCYAyeN1x4QqzW3SaUFQ0Ntm5T35Ov38HVhKpMxOxxhxE2sCn
         nTr6+MYxPY9sxuxU7qWBIKvP1iO6kOqppgoStmcX7m07ucB42br3QSXGm0qzV1s4+r
         zqJ/5lzHWV4jH7Rvw8JAHL2S75/RUVZOqq6y7MxL2GOqYaUA32nEmViT54OT2ULGF1
         0kTEFkePiv3Zw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/lkdtm: Use "comm" instead of "diff" for dmesg
In-Reply-To: <202006261358.3E8AA623A9@keescook>
References: <202006261358.3E8AA623A9@keescook>
Date:   Sat, 27 Jun 2020 21:51:31 +1000
Message-ID: <87k0zsbubg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> Instead of full GNU diff (which smaller boot environments may not have),
> use "comm" which is more available.

Although using "comm" requires CONFIG_PRINTK_TIME=y doesn't it?

Which is probably fine, but should be mentioned.

And I guess for completeness you could add:

diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftests/lkdtm/config
index d874990e442b..ae88bfb163ff 100644
--- a/tools/testing/selftests/lkdtm/config
+++ b/tools/testing/selftests/lkdtm/config
@@ -1 +1,2 @@
 CONFIG_LKDTM=y
+CONFIG_PRINTK_TIME=y


cheers

> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Link: https://lore.kernel.org/lkml/CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com
> Fixes: f131d9edc29d ("selftests/lkdtm: Don't clear dmesg when running tests")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  tools/testing/selftests/lkdtm/run.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
> index 8383eb89d88a..5fe23009ae13 100755
> --- a/tools/testing/selftests/lkdtm/run.sh
> +++ b/tools/testing/selftests/lkdtm/run.sh
> @@ -82,7 +82,7 @@ dmesg > "$DMESG"
>  ($SHELL -c 'cat <(echo '"$test"') >'"$TRIGGER" 2>/dev/null) || true
>  
>  # Record and dump the results
> -dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
> +dmesg | comm -13 "$DMESG" - > "$LOG" || true
>  
>  cat "$LOG"
>  # Check for expected output
> -- 
> 2.25.1
>
>
> -- 
> Kees Cook
