Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D056AB812
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 09:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCFIQY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 03:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCFIQX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 03:16:23 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3636211670
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Mar 2023 00:16:21 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:b745:671d:a946:57fa])
        by albert.telenet-ops.be with bizsmtp
        id UwGJ2900H4LuvSS06wGJm6; Mon, 06 Mar 2023 09:16:18 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pZ614-00AzHa-FV;
        Mon, 06 Mar 2023 09:16:18 +0100
Date:   Mon, 6 Mar 2023 09:16:18 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Chuck Lever <cel@kernel.org>
cc:     linux-nfs@vger.kernel.org, dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/41] SUNRPC: Enable rpcsec_gss_krb5.ko to be built
 without CRYPTO_DES
In-Reply-To: <167380331214.10651.11224254824457738270.stgit@bazille.1015granger.net>
Message-ID: <1331f5b4-66cb-4afa-4e81-64cf4bc696d@linux-m68k.org>
References: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net> <167380331214.10651.11224254824457738270.stgit@bazille.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

 	Hi Chuck,

On Sun, 15 Jan 2023, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Because the DES block cipher has been deprecated by Internet
> standard, highly secure configurations might require that DES
> support be blacklisted or not installed. NFS Kerberos should still
> be able to work correctly with only the AES-based enctypes in that
> situation.
>
> Also note that MIT Kerberos has begun a deprecation process for DES
> encryption types. Their README for 1.19.3 states:
>
>> Beginning with the krb5-1.19 release, a warning will be issued
>> if initial credentials are acquired using the des3-cbc-sha1
>> encryption type.  In future releases, this encryption type will
>> be disabled by default and eventually removed.
>>
>> Beginning with the krb5-1.18 release, single-DES encryption
>> types have been removed.
>
> Aside from the CONFIG option name change, there are two important
> policy changes:
>
> 1. The 'insecure enctype' group is now disabled by default.
>   Distributors have to take action to enable support for deprecated
>   enctypes. Implementation of these enctypes will be removed in a
>   future kernel release.
>
> 2. des3-cbc-sha1 is now considered part of the 'insecure enctype'
>   group, having been deprecated by RFC 8429, and is thus disabled
>   by default
>
> After this patch is applied, SunRPC support can be built with
> Kerberos 5 support but without CRYPTO_DES enabled in the kernel.
> And, when these enctypes are disabled, the Linux kernel's SunRPC
> RPCSEC GSS implementation fully complies with BCP 179 / RFC 6649
> and BCP 218 / RFC 8429.
>
> Tested-by: Scott Mayhew <smayhew@redhat.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Thanks for your patch, which is now commit dfe9a123451a6e73 ("SUNRPC:
Enable rpcsec_gss_krb5.ko to be built without CRYPTO_DES") in v6.3-rc1.

> --- a/net/sunrpc/Kconfig
> +++ b/net/sunrpc/Kconfig
> @@ -19,10 +19,10 @@ config SUNRPC_SWAP
> config RPCSEC_GSS_KRB5
> 	tristate "Secure RPC: Kerberos V mechanism"
> 	depends on SUNRPC && CRYPTO
> -	depends on CRYPTO_MD5 && CRYPTO_DES && CRYPTO_CBC && CRYPTO_CTS
> -	depends on CRYPTO_ECB && CRYPTO_HMAC && CRYPTO_SHA1 && CRYPTO_AES
> 	default y
> 	select SUNRPC_GSS
> +	select CRYPTO_SKCIPHER
> +	select CRYPTO_HASH
> 	help
> 	  Choose Y here to enable Secure RPC using the Kerberos version 5
> 	  GSS-API mechanism (RFC 1964).

While updating my defconfigs for v6.3-rc1, I noticed this change has an
interesting side-effect: if any of the CRYPTO_* algorithms were modular
before, RPCSEC_GSS_KRB5 was modular, too.
After this change, RPCSEC_GSS_KRB5 is promoted to builtin.

This is not necessarily bad in-se, but you might want to be aware of it,
and perhaps change the "default y".

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
