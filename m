Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C5D57321E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jul 2022 11:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbiGMJKH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jul 2022 05:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiGMJKG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jul 2022 05:10:06 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144C3DA0FC;
        Wed, 13 Jul 2022 02:09:57 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.97.215]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MSLhm-1o0eHI3HDM-00SdqD; Wed, 13 Jul 2022 11:09:12 +0200
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id A2AC83C09F;
        Wed, 13 Jul 2022 11:09:10 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 50C39ACD; Wed, 13 Jul 2022 11:09:06 +0200 (CEST)
Date:   Wed, 13 Jul 2022 11:09:06 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anders Roxell <anders.roxell@linaro.org>, Tim.Bird@sony.com,
        kernel@collabora.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/4] Makefile: add headers to kselftest targets
Message-ID: <Ys6LsqvQC+h3eM46@bergen.fjasle.eu>
References: <cover.1657614127.git.guillaume.tucker@collabora.com>
 <745d1921a4d048ea25d262e33b40aad5ee470614.1657614127.git.guillaume.tucker@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <745d1921a4d048ea25d262e33b40aad5ee470614.1657614127.git.guillaume.tucker@collabora.com>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:623t/4l5SVDnwrpO8+8WDgkZZ9iYHqLEZ8zhDzgcMHqriwXRBjl
 7NRW/7Rv9O9PM8fsCx+g7OAVRNEds0IbN1WusDd1xO+VaRd8obo34+XhLlYpMe9PQHxWAGR
 wsA1qRPteXpxNlKSS7drRd0srLu0ZlPsbFIJ+mTduY8VOdrP8Bory9TWDOaETZwDTZ+h7tl
 kmMcAr/CVy6KBb3MqtHbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G904bOaoY5I=:CzHp39EbGa7Vw0N21TnTPF
 6Zl+4CLeQ7dWBN2Gz5yKj+y46R7wilWqZtojOH60AUjAyVFSGXx18rv8MERDEAOJARtegpli4
 tHQ/k2x67gefPxSNlQKrHiuMO2Zeu/Isc3hB6J6u3/iPq0nHTHdx8Dh/xPBhl2o2lSutQZ/yD
 n094Y32TghARn7ZvPMQPlmwsN0Nixo5050ptHukFB1ZZMRFSSF6zb0vLUMiVuxzvnF70OhQZF
 mHLUAUNLNUAOIuK4mxS5ReAcQax4x4e1OzLdyro1Ng5/NXM/CjmchdsC2WGKwg0Zu9VXHG+np
 /TH11Ipvu3X6Kgcrq1Gyr34Ydez6WMe05IZkDWP57nnaa1OVFcRMP0DWXpTa2+paDv4nM+Tjb
 CmhiUkStRLJC/6PrDT0Yd7rH3bYlPpwXYQAMBOwO9/Qq9T7uED/l1Dp7bCGIjsEKR7l57/nX5
 MCF9BZlPufJ3Hxj78wJIe5URNNdYxFWsMn2veCHTyv8fAZwg/11I97iTMyC2JPfM+RXuzjsDL
 47tvLfzxg4MSYI5p2a3w5snqxcBP7tNCRlukhZr/6vTwy3wWb5AwfD3ywT7IyAFi94ONAsWW3
 OFaxCnx6aJj1HECATsKxDLCQyDKKo9P4z921sJZuhCK80Sbtui0VZ8jZToApLWMHzE1FEtnIL
 rQX82merJpt+sLOJRnyqasyFfXL3l3R4bSl6/SkyadPZihUffslW/hB1F/nEOzXGdAemg6h2k
 /sN2TTqcAyidCemm1BQssHPPiF7EPMpGPKG+8A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 12 Jul 2022 09:29 +0100 Guillaume Tucker wrote:
> Add headers as a dependency to kselftest targets so that they can be
> run directly from the top of the tree.  The kselftest Makefile used to
> try to call headers_install "backwards" but failed due to the relative
> path not being consistent.
> 
> Now we can either run this directly:
> 
>   $ make O=build kselftest-all
> 
> or this:
> 
>   $ make O=build headers
>   $ make O=build -C tools/testing/selftests all
> 
> The same commands work as well when building directly in the source
> tree (no O=) or any arbitrary path (relative or absolute).
> 
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> ---

You might want to add the 'Reported-by: as you did in 
https://lore.kernel.org/linux-kbuild/a7af58feaa6ae6d3b0c8c55972a470cec62341e5.1657693952.git.guillaume.tucker@collabora.com/ 
?

Tested-by: Nicolas Schier <nicolas@fjasle.eu>

> 
> Notes:
>     v2: replace headers_install with headers
> 
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 1a6678d817bd..02502cc4ced5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1347,10 +1347,10 @@ tools/%: FORCE
>  # Kernel selftest
>  
>  PHONY += kselftest
> -kselftest:
> +kselftest: headers
>  	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
>  
> -kselftest-%: FORCE
> +kselftest-%: headers FORCE
>  	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
>  
>  PHONY += kselftest-merge
> -- 
> 2.30.2

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
