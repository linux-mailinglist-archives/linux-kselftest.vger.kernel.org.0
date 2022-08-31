Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7695A5A76CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 08:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiHaGjq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 02:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiHaGjb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 02:39:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14235BE4C5;
        Tue, 30 Aug 2022 23:39:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50CAA61662;
        Wed, 31 Aug 2022 06:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31386C433D6;
        Wed, 31 Aug 2022 06:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661927962;
        bh=0j1TZFU3wRwvcEdOj3ffsesLckkpCIBHnhXRNCyuF7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=De4XeRyuI6UvL8VuhBaRTNKiG2uSI4fvhDoyr8nvE0T77G1LpcIyzb7D+jMS1gZgQ
         2eoU1VfZ/b+2KGx9VL3fgiB4dy7NIp/iQpzUWnHiNpB8sR2Kom1UvPWzVeFbJLt5Nv
         IxTW6wpcMTG09GVS9/sOEVkUKCEvxNrKhDpUMMrTs2/cthD3ev2eH1jxroMpbZO5lF
         3pBN1GIkWe5ionUvfrFV4MaYUrOhlizpN2FpQGi5JKKrStQU/yheWXsEA9wRCjSu9t
         YQMWjppI3SNkbeV4BrSqjkI46xJZQb4TDgTIabw4woo/lsrYsWtuECOhNxrknype0K
         1Y4Go4OO8m1tQ==
Date:   Wed, 31 Aug 2022 09:39:17 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dhanuka <wdnuka@gmail.com>
Cc:     dave.hansen@linux.intel.com, shuah@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/sgx: Fix OpenSSL deprecated warning for
 ERR_get_error_line
Message-ID: <Yw8CFRhbs8buYYnx@kernel.org>
References: <20220828061859.181061-1-wdnuka@gmail.com>
 <Ywyt4tvHrK4r48RK@kernel.org>
 <Yw17hyrjX1AiELZG@kernel.org>
 <86e2c049-b289-8b1f-9fc2-8938abefa7d4@gmail.com>
 <Yw60DQEbmQDKka9G@kernel.org>
 <a226891f-e589-04ea-f595-fed3d1f75691@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a226891f-e589-04ea-f595-fed3d1f75691@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 31, 2022 at 06:33:26AM +0000, Dhanuka wrote:
> On 8/31/22 01:06, Jarkko Sakkinen wrote:
> > On Tue, Aug 30, 2022 at 11:18:03AM +0000, Dhanuka wrote:
> > > On 8/30/22 02:52, Jarkko Sakkinen wrote:
> > > > On Mon, Aug 29, 2022 at 03:15:30PM +0300, Jarkko Sakkinen wrote:
> > > > > On Sun, Aug 28, 2022 at 11:48:59AM +0530, Dhanuka Warusadura wrote:
> > > > > > These changes fix the "error: ‘ERR_get_error_line’ is deprecated:
> > > > > > Since OpenSSL 3.0" warning.
> > > > > > 
> > > > > > Signed-off-by: Dhanuka Warusadura <wdnuka@gmail.com>
> > > > > > ---
> > > > > >    tools/testing/selftests/sgx/sigstruct.c | 2 +-
> > > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
> > > > > > index 50c5ab1aa6fa..671d9b58e274 100644
> > > > > > --- a/tools/testing/selftests/sgx/sigstruct.c
> > > > > > +++ b/tools/testing/selftests/sgx/sigstruct.c
> > > > > > @@ -136,7 +136,7 @@ static bool check_crypto_errors(void)
> > > > > >    			break;
> > > > > >    		had_errors = true;
> > > > > > -		err = ERR_get_error_line(&filename, &line);
> > > > > > +		err = ERR_peek_last_error_line(&filename, &line);
> > > > > >    		ERR_error_string_n(err, str, sizeof(str));
> > > > > >    		fprintf(stderr, "crypto: %s: %s:%d\n", str, filename, line);
> > > > > >    	}
> > > > > > -- 
> > > > > > 2.37.2
> > > > > > 
> > > > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > Actually NAK.
> > > > 
> > > > This fix is not complete:
> > > > 
> > > > sigstruct.c: In function ‘get_modulus’:
> > > > sigstruct.c:151:9: error: ‘RSA_get0_key’ is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declarations]
> > > >     151 |         RSA_get0_key(key, &n, NULL, NULL);
> > > >         |         ^~~~~~~~~~~~
> > > > In file included from /usr/include/openssl/x509.h:36,
> > > >                    from /usr/include/openssl/pem.h:23,
> > > >                    from sigstruct.c:16:
> > > > /usr/include/openssl/rsa.h:217:28: note: declared here
> > > >     217 | OSSL_DEPRECATEDIN_3_0 void RSA_get0_key(const RSA *r,
> > > >         |                            ^~~~~~~~~~~~
> > > > sigstruct.c: In function ‘gen_sign_key’:
> > > > sigstruct.c:168:9: error: ‘PEM_read_bio_RSAPrivateKey’ is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declaration
> > > > ]
> > > >     168 |         key = PEM_read_bio_RSAPrivateKey(bio, NULL, NULL, NULL);
> > > >         |         ^~~
> > > > /usr/include/openssl/pem.h:447:1: note: declared here
> > > >     447 | DECLARE_PEM_rw_cb_attr(OSSL_DEPRECATEDIN_3_0, RSAPrivateKey, RSA)
> > > >         | ^~~~~~~~~~~~~~~~~~~~~~
> > > > sigstruct.c: In function ‘encl_measure’:
> > > > sigstruct.c:364:9: error: ‘RSA_sign’ is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declarations]
> > > >     364 |         if (!RSA_sign(NID_sha256, digest, SHA256_DIGEST_LENGTH,
> > > >         |         ^~
> > > > /usr/include/openssl/rsa.h:348:27: note: declared here
> > > >     348 | OSSL_DEPRECATEDIN_3_0 int RSA_sign(int type, const unsigned char *m,
> > > >         |                           ^~~~~~~~
> > > > sigstruct.c:377:9: error: ‘RSA_free’ is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declarations]
> > > >     377 |         RSA_free(key);
> > > >         |         ^~~~~~~~
> > > > /usr/include/openssl/rsa.h:293:28: note: declared here
> > > >     293 | OSSL_DEPRECATEDIN_3_0 void RSA_free(RSA *r);
> > > >         |                            ^~~~~~~~
> > > > sigstruct.c:382:9: error: ‘RSA_free’ is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declarations]
> > > >     382 |         RSA_free(key);
> > > >         |         ^~~~~~~~
> > > > /usr/include/openssl/rsa.h:293:28: note: declared here
> > > >     293 | OSSL_DEPRECATEDIN_3_0 void RSA_free(RSA *r);
> > > >         |                            ^~~~~~~~
> > > > cc1: all warnings being treated as errors
> > > > make: *** [Makefile:39: /home/jarkko/work/linux-sgx/tools/testing/selftests/sgx/sigstruct.o] Error 1
> > > > 
> > > > BR, Jarkko
> > > Thanks for the review.
> > > 
> > > But, my intention was to just fix the `ERR_get_error_line` deprecated
> > > warning (as mentioned in the commit header) and not all the OpenSSL
> > > deprecated warnings found in `sigstruct.c`
> > > 
> > > Do I need to fix all these OpenSSL deprecated warnings in `sigstruct.c` in
> > > order to get this patch merged?
> > Yes, it is incomplete as it is.
> > 
> > BR, Jarkko
> 
> Understood. Will try to resolve the remaining deprecated warnings as well.

Yeah, it would be way more valuable instead of dozen
of oneline patches. Thank you.

BR, Jarkko
