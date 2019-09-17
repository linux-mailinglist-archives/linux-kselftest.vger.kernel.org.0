Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEBDB47E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2019 09:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404434AbfIQHMa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Sep 2019 03:12:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44522 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388782AbfIQHM2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Sep 2019 03:12:28 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <marcelo.cerri@canonical.com>)
        id 1iA7ez-0008Hr-PK
        for linux-kselftest@vger.kernel.org; Tue, 17 Sep 2019 07:12:25 +0000
Received: by mail-wr1-f71.google.com with SMTP id w10so946959wrl.5
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Sep 2019 00:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3mJ7H9Vd/KYYHK2hKEza3o32eBLR4dUC6S3+MRraUY0=;
        b=rttxuPLrhgiLZ1c3pgang8BRhXwuNJi7tYC2FUl0FNolZRCNozGhEgOCfQA+VMPdrE
         SM7xsN76sm7j0MminWBMZAAzvYgXXRk/si/lapPMnXWvwjjsvRHYyaBOoxYHuo6JnIyn
         0ijPMlQOJ6aHRuNXYOA6H1lWjD7TYD5Ya/jd4CduOF+rGy4VMXQYgwYR88zAXcs83w3d
         7prGjHOTWFwOefDrMkjZzdYWEv7qlXJ6cVLxVxa1x+UPxMaf1xhflYxe/H2hCgBFeRV0
         g5NsqrTKetyi8phKTjYFvm7Dju7peMTALyoLXlqzvXtU0U2ULxVkTATytN+dVcR5a0gV
         wk6g==
X-Gm-Message-State: APjAAAUWfYM1+MYRnUaQSzxIaiszw1+hDbXzQNKPr8Nqb51LTmnrb5oT
        lv2qSpDD02EETgR2KMqIRh9XKnCKM4NXFG3fHBLBZuEizZ0AtCfdy2JDALzpqO1QtEWmqoYPL6S
        4qYKKmmpMIMf0GeZUvBK+lVb/IWm5sv9nV+X79LTB9MXg
X-Received: by 2002:a05:6000:110f:: with SMTP id z15mr1536460wrw.328.1568704345356;
        Tue, 17 Sep 2019 00:12:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzNNylg8z2QXdHZ6GX64UAW0YItRdOYiMPBiABGeWFNQO1sX9E5y78KYLlTPB8RardpZerdyQ==
X-Received: by 2002:a05:6000:110f:: with SMTP id z15mr1536441wrw.328.1568704345031;
        Tue, 17 Sep 2019 00:12:25 -0700 (PDT)
Received: from gallifrey (static-dcd-cqq-121001.business.bouyguestelecom.com. [212.194.121.1])
        by smtp.gmail.com with ESMTPSA id l13sm1267363wmj.25.2019.09.17.00.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 00:12:23 -0700 (PDT)
Date:   Tue, 17 Sep 2019 04:12:22 -0300
From:   Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
To:     shuah <shuah@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/net: replace AF_MAX with INT_MAX in socket.c
Message-ID: <20190917071222.6nfzmcxt4kxzgpki@gallifrey>
References: <20190916150337.18049-1-marcelo.cerri@canonical.com>
 <212adcf8-566e-e06d-529f-f0ac18bd6a35@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sjt5zxil7puotrgx"
Content-Disposition: inline
In-Reply-To: <212adcf8-566e-e06d-529f-f0ac18bd6a35@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--sjt5zxil7puotrgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

So the problem arises because the headers we have in userspace might
be older and not match what we have in the kernel. In that case, the
actual value of AF_MAX in the userspace headers might be a valid
protocol family in the new kernel.

That happens relatively often for us because we support different
kernel versions at the same time in a given Ubuntu series.

An alternative is to use the headers we have in the kernel tree, but I
believe that might cause other issues.

On Mon, Sep 16, 2019 at 10:09:13AM -0600, shuah wrote:
> On 9/16/19 9:03 AM, Marcelo Henrique Cerri wrote:
> > Use INT_MAX instead of AF_MAX, since libc might have a smaller value
> > of AF_MAX than the kernel, what causes the test to fail.
> >=20
> > Signed-off-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> > ---
> >   tools/testing/selftests/net/socket.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tools/testing/selftests/net/socket.c b/tools/testing/selft=
ests/net/socket.c
> > index afca1ead677f..10e75ba90124 100644
> > --- a/tools/testing/selftests/net/socket.c
> > +++ b/tools/testing/selftests/net/socket.c
> > @@ -6,6 +6,7 @@
> >   #include <sys/types.h>
> >   #include <sys/socket.h>
> >   #include <netinet/in.h>
> > +#include <limits.h>
> >   struct socket_testcase {
> >   	int	domain;
> > @@ -24,7 +25,10 @@ struct socket_testcase {
> >   };
> >   static struct socket_testcase tests[] =3D {
> > -	{ AF_MAX,  0,           0,           -EAFNOSUPPORT,    0 },
> > +	/* libc might have a smaller value of AF_MAX than the kernel
> > +	 * actually supports, so use INT_MAX instead.
> > +	 */
> > +	{ INT_MAX, 0,           0,           -EAFNOSUPPORT,    0  },
> >   	{ AF_INET, SOCK_STREAM, IPPROTO_TCP, 0,                1  },
> >   	{ AF_INET, SOCK_DGRAM,  IPPROTO_TCP, -EPROTONOSUPPORT, 1  },
> >   	{ AF_INET, SOCK_DGRAM,  IPPROTO_UDP, 0,                1  },
> >=20
>=20
> What failure are you seeing? It sounds arbitrary to use INT_MAX
> instead of AF_MAX. I think it is important to understand the
> failure first.
>=20
> Please note that AF_MAX is widely used in the kernel.
>=20
> thanks,
> -- Shuah

--=20
Regards,
Marcelo


--sjt5zxil7puotrgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDWI6S4SUeUOX/xHQzxpLxzTV7UcFAl2Ah1YACgkQzxpLxzTV
7Ufo+gf8DIFj52cwhgSs/1wvN9sW40b15Wsaj2kzqF0UVueUb5nzGg5z8CYnW1wX
z+GLzbXJrts8i4PLO1UTcgPPTUXb3CJOyT5jZRehx1fN0fmMHr3DLmHhbRtz+m4G
IIHrcJxCk5vrH9LmXMFSUK42C7olzihTBDATk9sQ0drHvf7LV0cpRtqlY0i4tEwm
KnMVdTfjQLjCYcaAmvXr5X5EcdY9C1JsFnTjlrHbGSEiSp3Wrvxlal2FdMHRFXfe
sbYKKu2CCfob6EIFMyX6v6+DGdghrhNcx65DYgzPCXWX4TmPANGDqiPrEl/1sQow
nwCqqWSH0dNbaJyyAGtmfgZOLPGzyw==
=ikQl
-----END PGP SIGNATURE-----

--sjt5zxil7puotrgx--
