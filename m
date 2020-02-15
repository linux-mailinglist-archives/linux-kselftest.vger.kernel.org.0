Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16EA615FD27
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2020 07:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgBOGuB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Feb 2020 01:50:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbgBOGuB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Feb 2020 01:50:01 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01F6mtq3041788;
        Sat, 15 Feb 2020 01:49:48 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y4qyuxrt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Feb 2020 01:49:48 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01F6j3HL001799;
        Sat, 15 Feb 2020 06:49:47 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04dal.us.ibm.com with ESMTP id 2y6895hc4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Feb 2020 06:49:47 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01F6nkbk13632184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Feb 2020 06:49:47 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1C0F112063;
        Sat, 15 Feb 2020 06:49:46 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3FD4112062;
        Sat, 15 Feb 2020 06:49:44 +0000 (GMT)
Received: from LeoBras (unknown [9.85.178.59])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 15 Feb 2020 06:49:44 +0000 (GMT)
Message-ID: <59cdcd821f794a9cbd8ab315b441a7ee2e43e431.camel@linux.ibm.com>
Subject: Re: [PATCH] selftests/vm: Fix map_hugetlb length used for testing
 read and write
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date:   Sat, 15 Feb 2020 03:49:38 -0300
In-Reply-To: <9a404a13c871c4bd0ba9ede68f69a1225180dd7e.1580978385.git.christophe.leroy@c-s.fr>
References: <9a404a13c871c4bd0ba9ede68f69a1225180dd7e.1580978385.git.christophe.leroy@c-s.fr>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ZEi+P+decY37pq44DvhU"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-15_01:2020-02-14,2020-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002150056
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--=-ZEi+P+decY37pq44DvhU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Christophe, thank you for the patch.

On Thu, 2020-02-06 at 08:42 +0000, Christophe Leroy wrote:
> Commit fa7b9a805c79 ("tools/selftest/vm: allow choosing mem size and
> page size in map_hugetlb") added the possibility to change the size
> of memory mapped for the test, but left the read and write test using
> the default value. This is unnoticed when mapping a length greater
> than the default one, but segfaults otherwise.
>=20
> Fix read_bytes() and write_bytes() by giving them the real length.
>=20
> Also fix the call to munmap().
>=20
> Fixes: fa7b9a805c79 ("tools/selftest/vm: allow choosing mem size and page=
 size in map_hugetlb")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  tools/testing/selftests/vm/map_hugetlb.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/tools/testing/selftests/vm/map_hugetlb.c b/tools/testing/sel=
ftests/vm/map_hugetlb.c
> index 5a2d7b8efc40..6af951900aa3 100644
> --- a/tools/testing/selftests/vm/map_hugetlb.c
> +++ b/tools/testing/selftests/vm/map_hugetlb.c
> @@ -45,20 +45,20 @@ static void check_bytes(char *addr)
>  	printf("First hex is %x\n", *((unsigned int *)addr));
>  }
> =20
> -static void write_bytes(char *addr)
> +static void write_bytes(char *addr, size_t length)
>  {
>  	unsigned long i;
> =20
> -	for (i =3D 0; i < LENGTH; i++)
> +	for (i =3D 0; i < length; i++)
>  		*(addr + i) =3D (char)i;
>  }
> =20
> -static int read_bytes(char *addr)
> +static int read_bytes(char *addr, size_t length)
>  {
>  	unsigned long i;
> =20
>  	check_bytes(addr);
> -	for (i =3D 0; i < LENGTH; i++)
> +	for (i =3D 0; i < length; i++)
>  		if (*(addr + i) !=3D (char)i) {
>  			printf("Mismatch at %lu\n", i);
>  			return 1;
> @@ -96,11 +96,11 @@ int main(int argc, char **argv)
> =20
>  	printf("Returned address is %p\n", addr);
>  	check_bytes(addr);
> -	write_bytes(addr);
> -	ret =3D read_bytes(addr);
> +	write_bytes(addr, length);
> +	ret =3D read_bytes(addr, length);
> =20
>  	/* munmap() length of MAP_HUGETLB memory must be hugepage aligned */
> -	if (munmap(addr, LENGTH)) {
> +	if (munmap(addr, length)) {
>  		perror("munmap");
>  		exit(1);
>  	}

I agree with you, it's a needed fix.

FWIW:
Reviwed-by: Leonardo Bras <leonardo@linux.ibm.com>

--=-ZEi+P+decY37pq44DvhU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl5HlIIACgkQlQYWtz9S
ttS7OxAAwH0NauZuTxADtbg3X+UGv2GluaVEy2mQL3aZfSNO6caYZ7vkFMh2x7Ot
JahcPBeMG0b9nw/lz3CNjVy9ZELdcFT/740aYibRRM2jyXRu3SCu3SKZj7FS/fg2
JGRTibi5yRoGnhyHIlukySLnUtPD8AE2uIqiwsmlBPqma8Ny7jZ5ngXeVf70vTG1
ofchi7BFHFmv2ujuMvj7PlKMoZVA+AzOu+bpK84kF8fb2GLPy5VdvIh1tVoIx0KW
VpNJSvhJTYcBYRdh8z1/FnfMWgR9wRHl7l4GC+ArAtQQJhzcaxPR5kko2VrLn29D
oxUU0CmuKGazbiJkLjD5IzLXdRs3ZD2VjZpRoTqUdZO+6rozDnt2ku4RzzTaQDQW
kOiPrF3ozMPvrNXLae85q7/XZCQUpIfzib9A2D8Tbyu86XcDkigrdeD5/IuJMkR8
9VzSYuE+RYISRmwygFHWms1CXWFrmPkurMdmNuakpbKh8wDsq5uOMR24f3gAY3EK
BJwaDMeMZgGMfZpjf4H/i2gpXxt+GQxDu8IXI8j7lpF1qMnRmszC4KZcC/4mzi4y
3qSnuDCbj9O3gwUqBXJJ/tghN/g376Q6DTe+J7pMEMJ4h+T9BaTflRBENV9USsLd
S2S0dh0mWWiXGc0JD0cTd2haFR1OubCmhpNCJduE3ORRzvTT1xI=
=oY9v
-----END PGP SIGNATURE-----

--=-ZEi+P+decY37pq44DvhU--

