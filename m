Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB52A19F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2019 14:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfH2MVm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Aug 2019 08:21:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727065AbfH2MVi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Aug 2019 08:21:38 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7TC7e2D073974
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2019 08:21:37 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2upeeh0gmb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2019 08:21:36 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 29 Aug 2019 13:21:35 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 29 Aug 2019 13:21:31 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7TCL8BZ42336766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 12:21:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64B2B4C04A;
        Thu, 29 Aug 2019 12:21:30 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DED204C04E;
        Thu, 29 Aug 2019 12:21:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.55.105])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Aug 2019 12:21:29 +0000 (GMT)
Subject: Re: [PATCH v2] KVM: selftests: Add a test for the KVM_S390_MEM_OP
 ioctl
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20190829121412.30194-1-thuth@redhat.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date:   Thu, 29 Aug 2019 14:21:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190829121412.30194-1-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VH0V11buHJolHVSnrjUsKPZNowBV4xxTS"
X-TM-AS-GCONF: 00
x-cbid: 19082912-0012-0000-0000-000003443F90
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082912-0013-0000-0000-0000217E801A
Message-Id: <1d3eb743-464f-58d6-9a0e-3bb2515f1744@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=569 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908290135
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VH0V11buHJolHVSnrjUsKPZNowBV4xxTS
Content-Type: multipart/mixed; boundary="7nvqrNMeaw2pDck1czdWj2FaX5P1Su04d";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <1d3eb743-464f-58d6-9a0e-3bb2515f1744@linux.ibm.com>
Subject: Re: [PATCH v2] KVM: selftests: Add a test for the KVM_S390_MEM_OP
 ioctl
References: <20190829121412.30194-1-thuth@redhat.com>
In-Reply-To: <20190829121412.30194-1-thuth@redhat.com>

--7nvqrNMeaw2pDck1czdWj2FaX5P1Su04d
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/29/19 2:14 PM, Thomas Huth wrote:
> Check that we can write and read the guest memory with this s390x
> ioctl, and that some error cases are handled correctly.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Check the ioctl also with "size" set to 0
>=20
[...]
> +
> +	/* Zero size: */
> +	ksmo.gaddr =3D (uintptr_t)mem1;
> +	ksmo.flags =3D 0;
> +	ksmo.size =3D 0;
> +	ksmo.op =3D KVM_S390_MEMOP_LOGICAL_WRITE;
> +	ksmo.buf =3D (uintptr_t)mem1;
> +	ksmo.ar =3D 0;
> +	rv =3D _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
> +	TEST_ASSERT(rv =3D=3D -1, "ioctl allows 0 as size");

Test for errno =3D=3D -EINVAL?

> +
> +	/* Bad flags: */
> +	ksmo.gaddr =3D (uintptr_t)mem1;
> +	ksmo.flags =3D -1;
> +	ksmo.size =3D maxsize;
> +	ksmo.op =3D KVM_S390_MEMOP_LOGICAL_WRITE;
> +	ksmo.buf =3D (uintptr_t)mem1;
> +	ksmo.ar =3D 0;
> +	rv =3D _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
> +	TEST_ASSERT(rv =3D=3D -1 && errno =3D=3D EINVAL, "ioctl allows all fl=
ags?");
> +
> +	/* Bad operation: */
> +	ksmo.gaddr =3D (uintptr_t)mem1;
> +	ksmo.flags =3D 0;
> +	ksmo.size =3D maxsize;
> +	ksmo.op =3D -1;
> +	ksmo.buf =3D (uintptr_t)mem1;
> +	ksmo.ar =3D 0;
> +	rv =3D _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
> +	TEST_ASSERT(rv =3D=3D -1 && errno =3D=3D EINVAL, "ioctl allows all fl=
ags?");

Wrong report string





--7nvqrNMeaw2pDck1czdWj2FaX5P1Su04d--

--VH0V11buHJolHVSnrjUsKPZNowBV4xxTS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl1nw0kACgkQ41TmuOI4
ufhprg/+JWsfyYseRODgGebPKs9fLkn+seVTXPNVwifNIetSyTcblsd2ivD2OBgw
AyyOG9C4GLnNfBJ5wUGodWcUs6qtv+wbia/z6/vu4l1JIxrsMhryJW3prCVWWQxJ
+6+BZdaVIq6zIriWS8AeoS7G+qp83zAEVDYjOqLRIylhebrCMf9ZTIiyxVN9DwVZ
e/ZswQ9T/G7u203dntrTE4JbHse52s/rUYfxMng6g8S+OaGixBsXT6XouAOURC9I
aawf7TvqybeSIDa3Tqb7+IAChkEhk834YoOaTuXCwgWtlzQFnCCSX4/axwAXiN7Y
Xa9S54TLQAw3TKK4aBkYXKvJ7tJKbAMvJete8Uc+VXJs2N17dNx8RKmOViJuoeKR
nPHNg5LHyaZkK9SAQlE1JH+AnmkjGQl/T7yjv0k/dJm+UadqI8XGMiOmz7ydCRFn
K+Sh5WCpUkVKBKxmZlGBOjpXEWp+UkEnPFuHv8CE3KGlj7Mr90j6G4lhC8XDRg1H
3yoAGKC4kRwAGCLaspTMegzsTgw2xmVoX6cjyt4/OPdjHDieWfDZGY1MmTp1GXHL
QN01hy0jWt/LM2y3OTlCJkjQyWp4NYyoLgi5YuDPapIqyTUflIfxFcN4bb6Y7LrH
8T1mYyTJikKsq/Dgkgb5Q1weOtG4IBc2Le4NRm8sDIpErlWswYw=
=QEMa
-----END PGP SIGNATURE-----

--VH0V11buHJolHVSnrjUsKPZNowBV4xxTS--

