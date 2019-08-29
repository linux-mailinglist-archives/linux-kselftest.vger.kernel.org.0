Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C327A1A04
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2019 14:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbfH2M1X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Aug 2019 08:27:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbfH2M1X (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Aug 2019 08:27:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 938B4308AA11;
        Thu, 29 Aug 2019 12:27:22 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-53.ams2.redhat.com [10.36.116.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D77691001B14;
        Thu, 29 Aug 2019 12:27:14 +0000 (UTC)
Subject: Re: [PATCH v2] KVM: selftests: Add a test for the KVM_S390_MEM_OP
 ioctl
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20190829121412.30194-1-thuth@redhat.com>
 <1d3eb743-464f-58d6-9a0e-3bb2515f1744@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <f04624eb-1c96-cdc6-7f86-a2109f1cc5b7@redhat.com>
Date:   Thu, 29 Aug 2019 14:27:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1d3eb743-464f-58d6-9a0e-3bb2515f1744@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OkFalos8lQQjDlYYFWlDnPC9G6Att1Gri"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 29 Aug 2019 12:27:22 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OkFalos8lQQjDlYYFWlDnPC9G6Att1Gri
Content-Type: multipart/mixed; boundary="cDDaWW4PZAqPC6U7miDKHizLTNuYgmHhC";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <f04624eb-1c96-cdc6-7f86-a2109f1cc5b7@redhat.com>
Subject: Re: [PATCH v2] KVM: selftests: Add a test for the KVM_S390_MEM_OP
 ioctl
References: <20190829121412.30194-1-thuth@redhat.com>
 <1d3eb743-464f-58d6-9a0e-3bb2515f1744@linux.ibm.com>
In-Reply-To: <1d3eb743-464f-58d6-9a0e-3bb2515f1744@linux.ibm.com>

--cDDaWW4PZAqPC6U7miDKHizLTNuYgmHhC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29/08/2019 14.21, Janosch Frank wrote:
> On 8/29/19 2:14 PM, Thomas Huth wrote:
>> Check that we can write and read the guest memory with this s390x
>> ioctl, and that some error cases are handled correctly.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v2: Check the ioctl also with "size" set to 0
>>
> [...]
>> +
>> +	/* Zero size: */
>> +	ksmo.gaddr =3D (uintptr_t)mem1;
>> +	ksmo.flags =3D 0;
>> +	ksmo.size =3D 0;
>> +	ksmo.op =3D KVM_S390_MEMOP_LOGICAL_WRITE;
>> +	ksmo.buf =3D (uintptr_t)mem1;
>> +	ksmo.ar =3D 0;
>> +	rv =3D _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
>> +	TEST_ASSERT(rv =3D=3D -1, "ioctl allows 0 as size");
>=20
> Test for errno =3D=3D -EINVAL?

Assuming that my "Test for bad access register and size at the start
 of S390_MEM_OP" goes in first, yes, I can add that check.

Otherwise, the current kernel still returns ENOMEM.

>> +
>> +	/* Bad flags: */
>> +	ksmo.gaddr =3D (uintptr_t)mem1;
>> +	ksmo.flags =3D -1;
>> +	ksmo.size =3D maxsize;
>> +	ksmo.op =3D KVM_S390_MEMOP_LOGICAL_WRITE;
>> +	ksmo.buf =3D (uintptr_t)mem1;
>> +	ksmo.ar =3D 0;
>> +	rv =3D _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
>> +	TEST_ASSERT(rv =3D=3D -1 && errno =3D=3D EINVAL, "ioctl allows all f=
lags?");
>> +
>> +	/* Bad operation: */
>> +	ksmo.gaddr =3D (uintptr_t)mem1;
>> +	ksmo.flags =3D 0;
>> +	ksmo.size =3D maxsize;
>> +	ksmo.op =3D -1;
>> +	ksmo.buf =3D (uintptr_t)mem1;
>> +	ksmo.ar =3D 0;
>> +	rv =3D _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
>> +	TEST_ASSERT(rv =3D=3D -1 && errno =3D=3D EINVAL, "ioctl allows all f=
lags?");
>=20
> Wrong report string
Oops, stupid copy-n-paste bug ... I'll fix it in v3...

 Thanks,
  Thomas


--cDDaWW4PZAqPC6U7miDKHizLTNuYgmHhC--

--OkFalos8lQQjDlYYFWlDnPC9G6Att1Gri
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl1nxJ0ACgkQLtnXdP5w
LbW8sw//Qj5XBPlZ6OpwwCOMRqTagd5Eknde5AKOlN/GtmRrsTgK4FVhd/p9K1mm
caxdAQKZ+LlJo+pQP79PEJ/NlTGjhtGrdu34sMJjeiHSGP+VySxJeg7E5EZOe2b0
ur8rBVJVgHik1kY2kMjHCsqYYTOGoa6XSLcQEY9p2rWroVJtpSZnzhxKA9rKbCvq
IOOXK40Etfhs34pmjhDtqaCPoMvDfaVFviJmFtqGORJ/NLN2/34y781UzU2vUWD3
Jo8eKh5jExX/PZhrVXrSCQyf+GyVYnvpoFeys05uySUI0Yc+NVdZ4r8Xj7AGcEPH
UEQLzAmbzifW5vR/Cm2Qthr+5jercfQZ0QrCYWS9+2bJ4jlRqADfLUWEK7sje5E1
8t33gUaAsHcST0F0IYABEIEwHYACHH3uuWMS2THEPhVkLWVUr9iwuEyMmY3SjBTY
wWTpA6iqxkUFZ+ILCMBIhWYq7ZbymylCOgFhkSix+L2vpPtq/LeoHgUwq0n2itjQ
z7tPfUIADgspNCP/pRjAdOPqIl6FViJ0wHW4R+ONyfVz8zqh5g1nDGqmiEYZ+s/6
dkgrIv6jVDKI5cvgaxz3QDut3Pekl+NfaSZifnCq1xC3kM9GJs+u7UUuSa6LVNNT
HOI/RNotuCxAtLtWDcBCF0mw7TEqeJHeuQ7M0b8flfaXfAUFdvI=
=8/GR
-----END PGP SIGNATURE-----

--OkFalos8lQQjDlYYFWlDnPC9G6Att1Gri--
