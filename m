Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81DAE161436
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2020 15:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgBQOLP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Feb 2020 09:11:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59462 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgBQOLP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Feb 2020 09:11:15 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HE5P5W134565;
        Mon, 17 Feb 2020 09:11:03 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y6bp0811d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Feb 2020 09:11:03 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01HEAmZ9004672;
        Mon, 17 Feb 2020 14:11:02 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 2y6896esd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Feb 2020 14:11:02 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01HEB18s46072196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 14:11:01 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9195F112062;
        Mon, 17 Feb 2020 14:11:01 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7306A112061;
        Mon, 17 Feb 2020 14:11:00 +0000 (GMT)
Received: from leobras.br.ibm.com (unknown [9.18.235.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 17 Feb 2020 14:11:00 +0000 (GMT)
Message-ID: <f863080dd219faa73bb64b05312012f74026c25c.camel@linux.ibm.com>
Subject: Re: [PATCH] selftests/vm: Fix map_hugetlb length used for testing
 read and write
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date:   Mon, 17 Feb 2020 11:10:54 -0300
In-Reply-To: <59cdcd821f794a9cbd8ab315b441a7ee2e43e431.camel@linux.ibm.com>
References: <9a404a13c871c4bd0ba9ede68f69a1225180dd7e.1580978385.git.christophe.leroy@c-s.fr>
         <59cdcd821f794a9cbd8ab315b441a7ee2e43e431.camel@linux.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-OhqSPoXv3B77dbBkpEwa"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-17_08:2020-02-17,2020-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002170117
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--=-OhqSPoXv3B77dbBkpEwa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-02-15 at 03:49 -0300, Leonardo Bras wrote:
> Hello Christophe, thank you for the patch.
>=20
> On Thu, 2020-02-06 at 08:42 +0000, Christophe Leroy wrote:
> > Commit fa7b9a805c79 ("tools/selftest/vm: allow choosing mem size and
> > page size in map_hugetlb") added the possibility to change the size
> > of memory mapped for the test, but left the read and write test using
> > the default value. This is unnoticed when mapping a length greater
> > than the default one, but segfaults otherwise.
> >=20
> > Fix read_bytes() and write_bytes() by giving them the real length.
> >=20
> > Also fix the call to munmap().
> >=20
> > Fixes: fa7b9a805c79 ("tools/selftest/vm: allow choosing mem size and pa=
ge size in map_hugetlb")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > ---
> >  tools/testing/selftests/vm/map_hugetlb.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/vm/map_hugetlb.c b/tools/testing/s=
elftests/vm/map_hugetlb.c
> > index 5a2d7b8efc40..6af951900aa3 100644
> > --- a/tools/testing/selftests/vm/map_hugetlb.c
> > +++ b/tools/testing/selftests/vm/map_hugetlb.c
> > @@ -45,20 +45,20 @@ static void check_bytes(char *addr)
> >  	printf("First hex is %x\n", *((unsigned int *)addr));
> >  }
> > =20
> > -static void write_bytes(char *addr)
> > +static void write_bytes(char *addr, size_t length)
> >  {
> >  	unsigned long i;
> > =20
> > -	for (i =3D 0; i < LENGTH; i++)
> > +	for (i =3D 0; i < length; i++)
> >  		*(addr + i) =3D (char)i;
> >  }
> > =20
> > -static int read_bytes(char *addr)
> > +static int read_bytes(char *addr, size_t length)
> >  {
> >  	unsigned long i;
> > =20
> >  	check_bytes(addr);
> > -	for (i =3D 0; i < LENGTH; i++)
> > +	for (i =3D 0; i < length; i++)
> >  		if (*(addr + i) !=3D (char)i) {
> >  			printf("Mismatch at %lu\n", i);
> >  			return 1;
> > @@ -96,11 +96,11 @@ int main(int argc, char **argv)
> > =20
> >  	printf("Returned address is %p\n", addr);
> >  	check_bytes(addr);
> > -	write_bytes(addr);
> > -	ret =3D read_bytes(addr);
> > +	write_bytes(addr, length);
> > +	ret =3D read_bytes(addr, length);
> > =20
> >  	/* munmap() length of MAP_HUGETLB memory must be hugepage aligned */
> > -	if (munmap(addr, LENGTH)) {
> > +	if (munmap(addr, length)) {
> >  		perror("munmap");
> >  		exit(1);
> >  	}
>=20
> I agree with you, it's a needed fix.
>=20
> FWIW:
> Reviwed-by: Leonardo Bras <leonardo@linux.ibm.com>
Sorry, typo.
Reviewed-by: Leonardo Bras <leonardo@linux.ibm.com>

--=-OhqSPoXv3B77dbBkpEwa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl5Knu4ACgkQlQYWtz9S
ttRXyA//Yisq+PvM8Uzh/kxc8abgrggbW7RK8b4TqHbedTzzXA23kpqvXJZVXror
n7okrTtwXUbUtsMNlus0plf4a3UFzm8rP4M6/PPBFUgb99D/dmtkohzVZ2Kyc8Yd
FIMfsAHWS9mC7sVB6IIAjmz/79yl0Qvr7JUhMIIXUDDyfpSPNT21rDFT6JzCKz3o
JGG6BMAUXBNAUNx7V8rYvLfFhHlnqw0in28YGk9JbW7/ew9nbUF1Ob+5ZXsw3uRo
cSQ1ADKat8VB8suqG8/DxA3QZsgyN/okk/z0rRIpg6P4lH68iJz5drdfVo5Bhj6m
wQEi89mU1eVX21BiipRq22kR6CMnO3EwzRW11mLUoQSBWs9V9LqYPJOaPXm4Mxu1
cS8ZMrVuiiDo2KNCfg/0lof5GppL4Jpc4pQrYijkAv9LXJSs9g8AaN5x5d8KsIbG
7V+ogOv9czfvpER5AXwuX0S5RbTCA79SEuAdG1Zx7qRAq+dQIrCGmIeSYUVb5V9U
XwRBRby+2AtBF8YcYpwkXUlQ2AGMZvqZJsVJxMXjvUT5XeNhg9vGMnUiHbGSVJkt
aQilurNKaO49W7hY2Lwu+1RvYwAraUSXS67oURD/eMMBmNLfQgyoQtkZ1eP+i9h+
hGo9sYlOIGh7vnWAb8PD6dfBCYzkNA7Q75Tuu4hAM55I0+R3ZtM=
=l342
-----END PGP SIGNATURE-----

--=-OhqSPoXv3B77dbBkpEwa--

