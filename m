Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E436F0CF3
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Apr 2023 22:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344171AbjD0USL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Apr 2023 16:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344045AbjD0USK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Apr 2023 16:18:10 -0400
X-Greylist: delayed 1121 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Apr 2023 13:18:09 PDT
Received: from ulthar.dreamlands.azazel.net (wan.azazel.net [81.187.77.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E13B3ABC;
        Thu, 27 Apr 2023 13:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20220717; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vVMK0DmoTVin8v+RKwMB1x+zt92VjiVf5R1eGxA+9Ks=; b=nH4/jvP+w5LbS4HpcOH1UgI3is
        /iytLTAfnnvZ/T5RRDqRq4usCneIywBasHitLIVdl6kRp4o3KEhIWUUX2rGkPrBkFLNhYpKvKuTlr
        56d7zW7RRQl4CKxLOY9fptKbCbgZuFr9hKJbNChLIzhummoEBhFS0b/4yO+ZCE9aBggtzghKEUFpt
        cESJEjjsUroeFS1XjPgydfgFoOuHF7Td485RW2bt6P1Hsa6+GGlQNht1bB0GAaLEEgRzKU1jLI5JM
        PE605vx6Z7S8aB6koS6eDY2OcahwIPdkW4gMmb+6+yX9A0emWv264cVcv0OSQ30lmADM0Af9jfKKk
        ObL+NzsA==;
Received: from azazel by ulthar.dreamlands.azazel.net with local (Exim 4.96)
        (envelope-from <azazel@azazel.net>)
        id 1ps7ks-0021kV-29;
        Thu, 27 Apr 2023 20:58:14 +0100
Date:   Thu, 27 Apr 2023 20:58:14 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf] selftests/bpf: fix pkg-config call building sign-file
Message-ID: <20230427195814.GE415348@azazel.net>
References: <20230426215032.415792-1-jeremy@azazel.net>
 <e1bd99a4ea209277d657f7fb7ccdc26451113fc9.camel@huaweicloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mRi/Sh4c9dkl2g8K"
Content-Disposition: inline
In-Reply-To: <e1bd99a4ea209277d657f7fb7ccdc26451113fc9.camel@huaweicloud.com>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: azazel@azazel.net
X-SA-Exim-Scanned: No (on ulthar.dreamlands.azazel.net); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--mRi/Sh4c9dkl2g8K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-04-27, at 08:52:27 +0200, Roberto Sassu wrote:
> On Wed, 2023-04-26 at 22:50 +0100, Jeremy Sowden wrote:
> > When building sign-file, the call to get the CFLAGS for libcrypto is
> > missing white-space between `pkg-config` and `--cflags`:
> >=20
> >   $(shell $(HOSTPKG_CONFIG)--cflags libcrypto 2> /dev/null)
> >=20
> > Removing the redirection of stderr, we see:
> >=20
> >   $ make -C tools/testing/selftests/bpf sign-file
> >   make: Entering directory '[...]/tools/testing/selftests/bpf'
> >   make: pkg-config--cflags: No such file or directory
> >     SIGN-FILE sign-file
> >   make: Leaving directory '[...]/tools/testing/selftests/bpf'
> >=20
> > Add the missing space.
> >=20
> > Fixes: fc97590668ae ("selftests/bpf: Add test for bpf_verify_pkcs7_sign=
ature() kfunc")
> > Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
>=20
> Thanks.
>=20
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
>
> Roberto

Thanks.  I was having e-mail problems yesterday when I sent the original
message with the patch in it, and it didn't reach some of the
recipients.  I'll send it again with your `Reviewed-by:` attached.

J.

> > ---
> >  tools/testing/selftests/bpf/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index b677dcd0b77a..ad01c9e1ff12 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -197,7 +197,7 @@ $(OUTPUT)/urandom_read: urandom_read.c urandom_read=
_aux.c $(OUTPUT)/liburandom_r
> > =20
> >  $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
> >  	$(call msg,SIGN-FILE,,$@)
> > -	$(Q)$(CC) $(shell $(HOSTPKG_CONFIG)--cflags libcrypto 2> /dev/null) \
> > +	$(Q)$(CC) $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null) \
> >  		  $< -o $@ \
> >  		  $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -l=
crypto)
> > =20

--mRi/Sh4c9dkl2g8K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEbB20U2PvQDe9VtUXKYasCr3xBA0FAmRK084ACgkQKYasCr3x
BA3WMw//dtfaKXgeSzYYSiB5uUJ91AnWV5EhEUZhFmgrxl9zATqbS+UimZ2X3JiV
uuHbQQixkxwB8FNUYmEVGQpIjuJonWnTFhorfWvVTzr4hDNTsycE/FyB9ROYUWBJ
0+T3aMcm8tBS8hqasPncs33TgEolPlO902kyUaB5NCfZOKNWW88wUOA6EiAILN5L
nEmOK8BwIt68gO55fAWm/zOObyG17YdYdmI6EBCdxW8UaVUCbO9K4DJDoPsy2e8u
QauB6vpiGLJAFQEnGaKeecEnBRYJFEGMop/bLEnuThRR9Cc6W8cW2iTo2ltF4ljy
CwwF6yO11Ua6cGF+0s/gvFnTfHwtOfuIRmQcSQEoaZyTWrE8M1bmK55WCxiaQb4B
Cpeylu3XnCCRZzHUoxQutc9+4lt87EdgQLRHVv1SbGVMYgJiDdhNMu/ZxXZp4eDN
VRFklTPVumtH1IUYGwjIfpIl8JCZAE+yOeLmMjE7PgrD3Ay+UB3FYE6irW8+Q/rp
GG1AdIMlqkq9Tuj6hv+9ymtfBgZBaaS6aCoFqJaEHKVmJwHBRxOA7DpeVh+zkLBd
Oh+fxnmvxm54Np/EjvyY/D2BvuIu2ZkhHACwozvIwydc51+9f86ksR3zKUWyHSlZ
UKoV4IlblMs98QvNiw3I91fBPwLCUsMzjI7UyDUMgsVpzCrQTZE=
=sPuM
-----END PGP SIGNATURE-----

--mRi/Sh4c9dkl2g8K--
