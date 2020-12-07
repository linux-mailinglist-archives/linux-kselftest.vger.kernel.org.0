Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5972D0B9A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Dec 2020 09:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgLGIRv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Dec 2020 03:17:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49912 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726219AbgLGIRu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Dec 2020 03:17:50 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B782MFr018211;
        Mon, 7 Dec 2020 03:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : cc : references :
 from : subject : message-id : date : mime-version : in-reply-to :
 content-type; s=pp1; bh=QObTJv3lotnSCVdSgOmtL14VwH/CrgRuf+Bq2UTzPAY=;
 b=Kco6fuBMrIGitBTIkQi3G0psFi2rGouUFlOpxK8tzwzBDCZMOTIpQrgQPoLe+Cno5YV6
 ERaf+xW1BvfP6dv6PB5yQGEeSaitTVL3tkLvj73vMU6buXECkRo3kSEFUl0WUitGIGoK
 qBT2vDezg/SzGUPszAbEIzhpEiqjwWnBo27nSQPvVNBKqAMkGxD03UtAtrNwV81zr2ab
 oiR0LookZVXW8PP0rt94zqzZfdIofRRgVtpIVbv7yn1OCsLnCaRGrqgRHiCYjBIe9A9t
 hXpp+Yry3d2m/zIk6H3/LC8kli46wduhdLgwt0b+sLrHu7UAPSdjOcP4cB78cYEbszui ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 359dkgmpp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 03:17:05 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B783HPd023469;
        Mon, 7 Dec 2020 03:17:04 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 359dkgmpnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 03:17:04 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B78CMgu002564;
        Mon, 7 Dec 2020 08:17:03 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3581u814nt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 08:17:02 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B78GxLI7733940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Dec 2020 08:16:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFE0CAE058;
        Mon,  7 Dec 2020 08:16:59 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29797AE051;
        Mon,  7 Dec 2020 08:16:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.66.18])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Dec 2020 08:16:59 +0000 (GMT)
To:     Collin Walling <walling@linux.ibm.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     david@redhat.com, thuth@redhat.com, cohuck@redhat.com,
        borntraeger@de.ibm.com, pbonzini@redhat.com, imbrenda@linux.ibm.com
References: <20201203215212.243145-1-walling@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3] self_tests/kvm: sync_regs test for diag318
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
Message-ID: <39f22c09-788c-4ba7-9cf8-018f86b10803@linux.ibm.com>
Date:   Mon, 7 Dec 2020 09:16:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201203215212.243145-1-walling@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NqXOaa89OI35wjbO0CSVwRlUn25VPs3KR"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-07_05:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 suspectscore=2
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070046
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NqXOaa89OI35wjbO0CSVwRlUn25VPs3KR
Content-Type: multipart/mixed; boundary="0dkJRyxk8uT91uj5g8MyqqYrnurb9Sik6";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Collin Walling <walling@linux.ibm.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: david@redhat.com, thuth@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, pbonzini@redhat.com, imbrenda@linux.ibm.com
Message-ID: <39f22c09-788c-4ba7-9cf8-018f86b10803@linux.ibm.com>
Subject: Re: [PATCH v3] self_tests/kvm: sync_regs test for diag318
References: <20201203215212.243145-1-walling@linux.ibm.com>
In-Reply-To: <20201203215212.243145-1-walling@linux.ibm.com>

--0dkJRyxk8uT91uj5g8MyqqYrnurb9Sik6
Content-Type: multipart/mixed;
 boundary="------------AA75F92451910E1959E7AA1B"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------AA75F92451910E1959E7AA1B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/3/20 10:52 PM, Collin Walling wrote:
> The DIAGNOSE 0x0318 instruction, unique to s390x, is a privileged call

s/call/instruction/

> that must be intercepted via SIE, handled in userspace, and the
> information set by the instruction is communicated back to KVM.
>=20
> To test the instruction interception, an ad-hoc handler is defined whic=
h
> simply has a VM execute the instruction and then userspace will extract=

> the necessary info. The handler is defined such that the instruction
> invocation occurs only once. It is up to the caller to determine how th=
e
> info returned by this handler should be used.
>=20
> The diag318 info is communicated from userspace to KVM via a sync_regs
> call. This is tested during a sync_regs test, where the diag318 info is=

> requested via the handler, then the info is stored in the appropriate
> register in KVM via a sync registers call.
>=20
> If KVM does not support diag318, then the tests will print a message
> stating that diag318 was skipped, and the asserts will simply test
> against a value of 0.
>=20
> Signed-off-by: Collin Walling <walling@linux.ibm.com>

Acked-by: Janosch Frank <frankja@linux.ibm.com>

Some nits below.

> ---
>=20
> v3 changes: no longer testing the reset code, as it is handled
> entirely via userspace. The respective reset tests have been removed
>=20
> ---
>  tools/testing/selftests/kvm/Makefile          |  2 +-
>  .../kvm/include/s390x/diag318_test_handler.h  | 13 +++
>  .../kvm/lib/s390x/diag318_test_handler.c      | 82 +++++++++++++++++++=

>  tools/testing/selftests/kvm/s390x/resets.c    |  1 +
>  .../selftests/kvm/s390x/sync_regs_test.c      | 16 +++-
>  5 files changed, 112 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/s390x/diag318_t=
est_handler.h
>  create mode 100644 tools/testing/selftests/kvm/lib/s390x/diag318_test_=
handler.c
>=20
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selft=
ests/kvm/Makefile
> index 3d14ef77755e..426c78449044 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -36,7 +36,7 @@ endif
>  LIBKVM =3D lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/sparsebi=
t.c lib/test_util.c
>  LIBKVM_x86_64 =3D lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/s=
vm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
>  LIBKVM_aarch64 =3D lib/aarch64/processor.c lib/aarch64/ucall.c
> -LIBKVM_s390x =3D lib/s390x/processor.c lib/s390x/ucall.c
> +LIBKVM_s390x =3D lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/dia=
g318_test_handler.c
> =20
>  TEST_GEN_PROGS_x86_64 =3D x86_64/cr4_cpuid_sync_test
>  TEST_GEN_PROGS_x86_64 +=3D x86_64/evmcs_test
> diff --git a/tools/testing/selftests/kvm/include/s390x/diag318_test_han=
dler.h b/tools/testing/selftests/kvm/include/s390x/diag318_test_handler.h=

> new file mode 100644
> index 000000000000..b0ed71302722
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/s390x/diag318_test_handler.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Test handler for the s390x DIAGNOSE 0x0318 instruction.
> + *
> + * Copyright (C) 2020, IBM
> + */
> +
> +#ifndef SELFTEST_KVM_DIAG318_TEST_HANDLER
> +#define SELFTEST_KVM_DIAG318_TEST_HANDLER
> +
> +uint64_t get_diag318_info(void);
> +
> +#endif
> diff --git a/tools/testing/selftests/kvm/lib/s390x/diag318_test_handler=
=2Ec b/tools/testing/selftests/kvm/lib/s390x/diag318_test_handler.c
> new file mode 100644
> index 000000000000..1e0b766efeb7
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/s390x/diag318_test_handler.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Test handler for the s390x DIAGNOSE 0x0318 instruction.
> + *
> + * Copyright (C) 2020, IBM
> + */
> +
> +#include "test_util.h"
> +#include "kvm_util.h"
> +
> +#define VCPU_ID	5

The sync_regs test has the same ID, will this be a problem?

> +
> +#define ICPT_INSTRUCTION	0x04
> +#define IPA0_DIAG		0x8300
> +
> +static void guest_code(void)
> +{
> +	uint64_t diag318_info =3D 0x12345678;
> +
> +	asm volatile ("diag %0,0,0x318\n" : : "d" (diag318_info));
> +}
> +
> +/*
> + * The DIAGNOSE 0x0318 instruction call must be handled via userspace.=
 As such,
> + * we create an ad-hoc VM here to handle the instruction then extract =
the
> + * necessary data. It is up to the caller to decide what to do with th=
at data.
> + */
> +static uint64_t diag318_handler(void)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_run *run;
> +	uint64_t reg;
> +	uint64_t diag318_info;
> +
> +	vm =3D vm_create_default(VCPU_ID, 0, guest_code);
> +	vcpu_run(vm, VCPU_ID);
> +	run =3D vcpu_state(vm, VCPU_ID);
> +
> +	TEST_ASSERT(run->exit_reason =3D=3D KVM_EXIT_S390_SIEIC,
> +		    "DIAGNOSE 0x0318 instruction was not intercepted");
> +	TEST_ASSERT(run->s390_sieic.icptcode =3D=3D ICPT_INSTRUCTION,
> +		    "Unexpected intercept code: 0x%x", run->s390_sieic.icptcode);
> +	TEST_ASSERT((run->s390_sieic.ipa & 0xff00) =3D=3D IPA0_DIAG,
> +		    "Unexpected IPA0 code: 0x%x", (run->s390_sieic.ipa & 0xff00));
> +
> +	reg =3D (run->s390_sieic.ipa & 0x00f0) >> 4;
> +	diag318_info =3D run->s.regs.gprs[reg];
> +
> +	TEST_ASSERT(diag318_info !=3D 0, "DIAGNOSE 0x0318 info not set");
> +
> +	kvm_vm_free(vm);
> +
> +	return diag318_info;
> +}
> +
> +uint64_t get_diag318_info(void)
> +{
> +	static uint64_t diag318_info;
> +	static bool printed_skip;
> +
> +	/*
> +	 * If KVM does not support diag318, then return 0 to
> +	 * ensure tests do not break.
> +	 */
> +	if (!kvm_check_cap(KVM_CAP_S390_DIAG318)) {
> +		if (!printed_skip) {
> +			fprintf(stdout, "KVM_CAP_S390_DIAG318 not supported. "
> +				"Skipping diag318 test.\n");
> +			printed_skip =3D true;
> +		}
> +		return 0;
> +	}
> +
> +	/*
> +	 * If a test has previously requested the diag318 info,
> +	 * then don't bother spinning up a temporary VM again.
> +	 */
> +	if (!diag318_info)
> +		diag318_info =3D diag318_handler();
> +
> +	return diag318_info;
> +}
> diff --git a/tools/testing/selftests/kvm/s390x/resets.c b/tools/testing=
/selftests/kvm/s390x/resets.c
> index b143db6d8693..b3d7d4ac2d54 100644
> --- a/tools/testing/selftests/kvm/s390x/resets.c
> +++ b/tools/testing/selftests/kvm/s390x/resets.c
> @@ -110,6 +110,7 @@ static void assert_clear(void)
> =20
>  	TEST_ASSERT(!memcmp(sync_regs->vrs, regs_null, sizeof(sync_regs->vrs)=
),
>  		    "vrs0-15 =3D=3D 0 (sync_regs)");
> +

Whitespace damage

>  }
> =20
>  static void assert_initial_noclear(void)
> diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools=
/testing/selftests/kvm/s390x/sync_regs_test.c
> index 5731ccf34917..caf7b8859a94 100644
> --- a/tools/testing/selftests/kvm/s390x/sync_regs_test.c
> +++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
> @@ -20,6 +20,7 @@
> =20
>  #include "test_util.h"
>  #include "kvm_util.h"
> +#include "diag318_test_handler.h"
> =20
>  #define VCPU_ID 5
> =20
> @@ -70,7 +71,7 @@ static void compare_sregs(struct kvm_sregs *left, str=
uct kvm_sync_regs *right)
> =20
>  #undef REG_COMPARE
> =20
> -#define TEST_SYNC_FIELDS   (KVM_SYNC_GPRS|KVM_SYNC_ACRS|KVM_SYNC_CRS)
> +#define TEST_SYNC_FIELDS   (KVM_SYNC_GPRS|KVM_SYNC_ACRS|KVM_SYNC_CRS|K=
VM_SYNC_DIAG318)
>  #define INVALID_SYNC_FIELD 0x80000000
> =20
>  int main(int argc, char *argv[])
> @@ -152,6 +153,12 @@ int main(int argc, char *argv[])
> =20
>  	run->kvm_valid_regs =3D TEST_SYNC_FIELDS;
>  	run->kvm_dirty_regs =3D KVM_SYNC_GPRS | KVM_SYNC_ACRS;
> +
> +	if (get_diag318_info() > 0) {
> +		run->s.regs.diag318 =3D get_diag318_info();
> +		run->kvm_dirty_regs |=3D KVM_SYNC_DIAG318;
> +	}
> +
>  	rv =3D _vcpu_run(vm, VCPU_ID);
>  	TEST_ASSERT(rv =3D=3D 0, "vcpu_run failed: %d\n", rv);
>  	TEST_ASSERT(run->exit_reason =3D=3D KVM_EXIT_S390_SIEIC,
> @@ -164,6 +171,9 @@ int main(int argc, char *argv[])
>  	TEST_ASSERT(run->s.regs.acrs[0]  =3D=3D 1 << 11,
>  		    "acr0 sync regs value incorrect 0x%x.",
>  		    run->s.regs.acrs[0]);
> +	TEST_ASSERT(run->s.regs.diag318 =3D=3D get_diag318_info(),
> +		    "diag318 sync regs value incorrect 0x%llx.",
> +		    run->s.regs.diag318);
> =20
>  	vcpu_regs_get(vm, VCPU_ID, &regs);
>  	compare_regs(&regs, &run->s.regs);
> @@ -177,6 +187,7 @@ int main(int argc, char *argv[])
>  	run->kvm_valid_regs =3D TEST_SYNC_FIELDS;
>  	run->kvm_dirty_regs =3D 0;
>  	run->s.regs.gprs[11] =3D 0xDEADBEEF;
> +	run->s.regs.diag318 =3D 0x4B1D;
>  	rv =3D _vcpu_run(vm, VCPU_ID);
>  	TEST_ASSERT(rv =3D=3D 0, "vcpu_run failed: %d\n", rv);
>  	TEST_ASSERT(run->exit_reason =3D=3D KVM_EXIT_S390_SIEIC,
> @@ -186,6 +197,9 @@ int main(int argc, char *argv[])
>  	TEST_ASSERT(run->s.regs.gprs[11] !=3D 0xDEADBEEF,
>  		    "r11 sync regs value incorrect 0x%llx.",
>  		    run->s.regs.gprs[11]);
> +	TEST_ASSERT(run->s.regs.diag318 !=3D 0x4B1D,
> +		    "diag318 sync regs value incorrect 0x%llx.",
> +		    run->s.regs.diag318);
> =20
>  	kvm_vm_free(vm);
> =20
>=20


--------------AA75F92451910E1959E7AA1B
Content-Type: application/pgp-keys;
 name="OpenPGP_0xE354E6B8E238B9F8.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="OpenPGP_0xE354E6B8E238B9F8.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBFubpD4BEADX0uhkRhkj2AVn7kI4IuPY3A8xKat0ihuPDXbynUC77mNox7yvK3X5QBO6q=
LqY
r+qrG3buymJJRD9xkp4mqgasHdB5WR9MhXWKH08EvtvAMkEJLnqxgbqf8td3pCQ2cEpv15mH4=
9iK
SmlTcJ+PvJpGZcq/jE42u9/0YFHhozm8GfQdb9SOI/wBSsOqcXcLTUeAvbdqSBZezuMRBivJQ=
QI1
esD9HuADmxdE7c4AeMlap9MvxvUtWk4ZJ/1Z3swMVCGzZb2Xg/9jZpLsyQzblDbbTlEeyBACe=
ED7
DYLZI3d0SFKeJZ1SUyMmSOcr9zeSh4S4h4w8xgDDGmeDVygBQZa1HaoLEsb8Y4avOYIgYDhgk=
Ch0
nol7XQ5i/yKLtnNThubAcxNyryw1xSstnKlxPRoxtqTsxMAiSekk0m3WJwvwd1s878HrQNK0o=
rWd
8BzzlSswzjNfQYLF466JOjHPWFOok9pzRs+ucrs6MUwDJj0ScITWU9Rxb04XyigY4XmZ8dywa=
xwi
2ZVTEg+MD+sPmRrTw+5F+sU83cUstuymF3w1GmyofgsUZ+/ldjToHnq21MNa1wx0lCEipCCyE=
/8K
9B9bg9pUwy5lfx7yORP3JuAUfCYb8DVSHWBPHKNjHTOLb2g2UT65AjZEQE95U2AY9iYm5usMq=
aWD
39pAHfhC09/7NQARAQABzSVKYW5vc2NoIEZyYW5rIDxmcmFua2phQGxpbnV4LmlibS5jb20+w=
sF3
BBMBCAAhBQJbm6Q+AhsjBQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEONU5rjiOLn4p9gQA=
Ljk
dj5euJVI2nNT3/IAxAhQSmRhPEt0AmnCYnuTcHRWPujNr5kqgtyER9+EMQ0ZkX44JU2q7OWxT=
dSN
SAN/5Z7qmOR9JySvDOf4d3mSbMB5zxL9d8SbnSs1uW96H9ZBTlTQnmLfsiM9TetAjSrR8nUmj=
Ghe
2YUhJLR1v1LguME+YseTeXnLzIzqqpu311/eYiiIGcmaOjPCE+vFjcXL5oLnGUE73qSYiujwh=
fPC
CUK0850o1fUAYq5pCNBCoKT4OddZR+0itKc/cT6NwEDwdokeg0+rAhxb4Rv5oFO70lziBplEj=
Oxu
3dqgIKbHbjzaEXTb+mr7VI9O4tTdqrwJo2q9zLqqOfDBi7NDvZFLzaCewhbdEpDYVu6/WxprA=
Y94
hY3F4trTrQMHJKQENtF6ZTQc9fcT5I3gAmP+OEvDE5hcTALpWm6Z6SzxO7gEYCnF+qGXqp8sJ=
Vrw
eMubUscyLqHoqdZC2UG4LQ1OJ97nzDpIRe0g6oJ9ZIYHKmfw5jjwH6rASTld5MFWajWdNsqK1=
5k/
RZnHAGICKVIBOBsq26m4EsBlfCdt3b/6emuBjUXR1pyjHMz2awWzCq6/6OWs5eANZ0sdosNqd=
q2v
0ULYTazJz2rlCXV89qRa7ukkNwdBSZNEwsD4eEMicj1LSrqWDZMAALw50L4jxaMD7lPLjJbaw=
sFc
BBABCAAGBQJbm7i8AAoJELvpdr8mrl3SNBQQANp57g9R15FxBxvKpu2TvP9eZJl/CeVCb6ED8=
NZL
TUweQmm3mMfzmtkbuBU9BWJwR/dfqWnjvNA/8awXDA1dxLUEUC76y1P2ya5F1DGeB9PzmK3hq=
iez
jeN0irBJwMx2ZHT190NML8InRHry1pOvkFXQBrtgwzlyvgXsuU5Und/YesGPzYwVvb0rFIbjM=
ncm
FjuIIlrVnIH3iOcr9yG+4hLHcmKcPcOBStJi5KJT/5d13i4HRKj8j3Q2wyK/XPvqBl7CBTpUv=
grr
gZA856rkOVRCwy9v9q3+F7soRwGoaKoUxhWLJt/cCXoQbRCIc9UmNxq5a2pQLrCU3MOqZEPJB=
GT/
sYfsRlNsK4Shop/pubhvRKgYVFLH/Bc8gSvBKalIOkwQxUHyH6t0YXTOFcaIymRlt+XlyH8+r=
3rq
TLIVDzjxUur0OKU/1yjG7IIBzwoFAGxXzdkeSIJ3V2oXqH4WdM+BdawllDaq3t3qMu5ykjCBR=
yxU
M4S3SoSiYyz5u5mSlSFApJXGqz0HudIUCwoO3gLruHNnj8kT0ScwyPTqS4U3zA8qYYr9+2n5n=
gN4
ZuYxWCX7/GDhYAIysdj5N+MuXElIOZeO5EUp3nIjcuoTivWTj8i4lcS56tWcEdJyporJRbHRt=
VyV
5HNGWjZIlRi8z5YBkKD11bDYdFZAPskHFFN7wsFcBBMBAgAGBQJbm7WQAAoJEIZFfh8x4fgdb=
4YP
/3v5dXvrJTUFs+8WFrY6zCmbCPDgMOu+Yw96XMqJOfdUSFgJsr9KzREGjmV43Z5p90c9dR7hP=
9j9
gv6R2N/Gn6GHljrW9F381iF1vZ7zmPTRMhXOmc6rbpisp3EicImmV+aWO5pn9C9RT2hrC4E2a=
cbv
at8LlHGbxEsRQhRtlUnfAKNxGbxkaBx8nIyjmkiFCvYUdIfdQZ5Pz6ePmUWeXVzDZKK7UO+Ca=
M+U
IMhnm44m7ud6aSS7xQFLDJr+8i5BnST1GBaAR9gr0+wQfeO077heB62Wtxgg0jr9wWIOPiD2X=
XHD
v3g3K1362+PR+nxTmcBelVjFqQpRXnw4Kcs6fmhCslHV+ixXN59q9GjOZ/OueU0JZHqZ6AFZQ=
zYl
TQD9X2cUwVbtfyOd4U1VAOVJ1F4YjD0iOkzfT8iGiEHNwtqPyWPcBvEK4/ZTDNVMUKnJPkqMa=
RKY
Q2JCv3aROtFYOCfyVoVAB/hXXGfpPWhhy1wo6gYdYe6ywt28zxXDdA9j5CBaUiQX4u24xOHbF=
aE3
+9kWLfv1MgPH5Kq7DZM6WJ3SvcqclQdaUlgPQlFTg03b2akkOXwmyQQfjA5u9G7Rz0q+8WJ+d=
zRj
2z0xgd1kAU4zckGs61M6GGGCQYcLlo1JLqUPcfBGUyRDVA8T+Tv3SmwvEuO5H+FpSVqAIykAn=
YI1
wsFcBBABAgAGBQJbm8vmAAoJEBF7vIC1phx84ccQAJCm6ibzB4lubSlWZ1fCK0vmJdBu1nxjV=
LEj
lMXw+L0xmqB2aEi5QuzoYlctnvmsL6PG7em9XO89NgPKBMVeJPSIHJ2ASOJgPk0gUknz+luOG=
MmF
1JKjfC8nwaB2GDEbj0vd3bfgLb6vOavg7XzvFavuGO4U4mzlvs8Ts+uSPBXEHDJH97AMhm+Lw=
TsR
92/a9lM95zX3jUJQvm/d8kwx1zbwXy21noOH8XmS4a8y9OKOjK6d2cxbWQJ3uio9sMyIfvp9T=
jE8
mw4U5W8bOcGDGQJhLXOiosJNl/QWCLjWdBfyXNdVIY6NXBQfvax2j9IZmugnd3u4/mFZsM16I=
CnO
fl3ULbs+PFJq9WHvmlUvbMTuGFL88TIlnKWfogRWtlaSvGBNFMAg+QxI1MHWq8PH4BNe8TqQd=
Zps
kWiRc8mvbziH59zX5EsIN90eRSmcbP6n4kBFutwtNDV9j19ee52c0GljELlJ1Q2F55LqTr0sy=
4j2
sEfObfLjIjkGs4DvLjeWbSllVKXPJ4JTUJCFO680EHE0jZ9p/VLkYNp3GDmrOSe3b7NjAUag/=
uom
x5X324p1vNzpP6Thd25q87ZljkuWayXcPp5r/9nLd33ZlGWSx5/eaUBpDSqOfXNAJTuYoFMfD=
a3U
kkC5H38e8TvJbnikKEstdT/50GZq5u2hLKiWNGVEwsFcBBIBAgAGBQJbm7/VAAoJEA0vhuyXG=
x0A
Y3sP/2Be0rwSRICIji9aNduvMknMBUfSG4IVF5+3icvWDJUJbuu0diNYmIRCpn7uJuwBrnDeV=
aYB
CTU45q95swUiSBaWliK9G1NQtLVZjSQ6kFBN/c3/Gn1/eVasJz3/5dIn+wAHFbdWWHc2m2Cr1=
r+Z
r3z3D5g6CDiFlFTvDPo6ZHbaqu7o+2QEcwg3fA5/HRcw5KG8B+boVAFqhNHxTHYFe+WEj5f6m=
qu8
LovDjhotTPq+inybSj8FbDhIwA4xpj4TrSoO+K1z0Kuc0+p9xLmlRB3QEB1FZt4iFxTSeh6oD=
TwW
X8STUaH0FlZSQQvDi1EWWkVhMu6wH9fzDDKwyaE8nn95tLv4WtceCyiRBv76RGx/Q+ejmvrvy=
6R7
0hwjWfM0Sdly2KaErnSgtEbB01qx9NCs6OBm/GNhn2WwskXnQD2oS6hAMJNI38y/XkRw8Y9SQ=
4K1
uFVBqoB+KGm2YoLfTKbGCf5U3wStWBn8a2k1j2h1hjlmlx2mA8uPkqfZQqti+HByT65rQUzFK=
OwZ
hLGhKoV8xYl8n8uVdC/NVNQI6wNoi8tEBJt0ctYnb8YdVHfRDOV5gQUsd+lCIA2dZCHWqjnLA=
D6m
kt+Q8iaVsp5eFKBlGsBSGYBpD20QLw9lixwaDzag3AhV71438ia7rjuK+bfcT8hvdFcOhcmjk=
Ors
jSvqwsFcBBIBAgAGBQJbm8iIAAoJECIOw3kbKW7CFN8P/RQk+RC0NnpL/yFAP3sF07D8ttzZN=
V3F
08ofvstZjZ4Cvc5HBUwVGehrVQO/hIjzEw8VmMFh0jnquuyvD3/OekcEAQ7aSSeJtU5+4WCPK=
0Aw
sV6S08J2EFKaNArBFUOwRCRENUgSdkDYidwtxZ6nsf8kGh80Bjr23yWcDz7lgGSzbj8JmwmVp=
kRn
OE+gpwx/QK/LZPbuJzhrDtwK5TKRTg57ZTcoD5NZ6OmKg3lSCn9eh4q8m6V0l48Y79lrZ2+ZC=
384
PsQwByoKacl1CS50UzHsd4i+wsWIjs4cl0vyRkn0Qk69yEWgG0WZHoP7WfVjCrWfgw5gBxHoW=
/QA
2aZOdSGcCLsJ1ubHh+KP43CSTNLm/+8oA49guZmBI+YsTyt4vr6/vYDvrSIz73n22edbgUr8Q=
OXN
h+sHJ7LH1sWG3kdZ8GptPqZOr7lAoGsz3QlvlEPJwqwYodShQb7sZmfT2d63YL0whBkeHOj7y=
FQp
PQYa5YDrBGQv+FLrCquysFS0cw3NzeJzhzAnDy/uSn/v6tpzvw/Qc16gMrJU0OdzfgKjzjF0N=
4Yq
IFiTPdq+bTXrvV5009ElR0uCTFjK/JF4ZVB2tn+QUwy5Jq972X3TsCQfUJKNS/O6sVM+XvcR5=
zw7
ZyqWBOMI9OEzUhqolfH+Vq36shpPjNR821NhMxh4yvWhwsBcBBABCAAGBQJc7pIqAAoJEL4Y/=
M44
5LLlLoEH/19s1qwYjKU5FushYDRtQGMXBHHqbuWHXuFgQqw9Ro9aIQTg1J3JiP04hfTIipKkU=
k8W
T7bp8oPxhoGTGhunkLGeel4VGzqew6KNgUjR4aOHly1rqWARgY6Vn1Zs2pOQwhvMHFZKzNyTX=
X0l
R67kGYDRiOY4DOYoEiSpWa0LpaIjAXzvpXgzsp9cQ73yS9wBs1CaFlgi2IleI/HM64j4gQHYm=
Hva
JngficYZBislT+6TasOJYcbjMgXtIBi8dfvox6qA7weXaTLwIixJijpUofb1IiQVAJDNCYzdA=
7aI
IZ2wCoNpIeqw7a+567ecdbcTe+8XQOMzCpqYVYO6HEV0XtnCwXMEEgEIAB0WIQTzlzFsIQqcA=
xIF
ZpFGfI7ScWqT1wUCXO7vlwAKCRBGfI7ScWqT13aVD/9s3dQVKgqwEvTyZztMtwiWtTqb2AMjf=
5/g
1MW8XbN+pim6tP+63suWYitIUG8jL8gPXvLMhE28Tndk2RkalG7RjhDrT+aiJDKFL1KegwZTh=
QBQ
9xQvLP2wk+5i0p+F5ABMn2NivCD7XVw1pk1MUM1xDyVXLvqPT8sc35RORbuny7OeM50ZgaTS+=
5wv
8cQ4Nl8SmdyOX7teGVPUTNpJz3/QXL56dcF3p/CLtF9kcJw0biPSh+7WpDWFLe45yobY7N6Hs=
2ur
ptA9K0B+1f5WNdYdbvH0r4coPJ9FSVlSt9K4hUFR31eA/NLlWaq2NJfixTyC5QP8uykLh+ZgR=
U9K
NaGbXoSZ4EoYc3EQ56i4YAA0jJGhIdfbIY++GNs42xJuyqhYuJEKl/y7sCRxHqYGx4l+E+1gs=
V8E
43XKDIizjkgUOu1+Zcrqeo64gSqllCaT99/3v8uJFrZmWDDH1sYLnoxMgPfb+ZdVwu8t8YDlU=
zmc
F0vcbAIKFDLI9/sSFuaYW8zrfSZturGAX6geZAH5S/SLn4OnMC8oZrqZmJHu7Ty3zpey5Vajs=
l9K
gEcQ06D+YH/qF5IZA4E8SwQ1j7fD7LQu7ud4VuAaF1lKU5UeE+ZBv3TYdJ+5HevRbM26LbKox=
LpL
GR+y5qwPaMwgvYLb3wQsgBy88HFgF8J9cpicJBokrs7BTQRbm6Q+ARAAwHFE0alxf2mOdzkh+=
yMC
CvZRSsSJtCKBZDhIeyzH6exRs2j+wDa2XXCM4WYt/McjpHGhWPp6RhFr5KO65SAJ9CaQTuMd4=
X4Z
oQQ/1kmPC0CBUDTYxJt786zKO2/SWyQKkMX21EWNw6pdxlM3lkxvbmidNLvhBD5WPM3FUoQ5b=
SJe
Ty4odtHvMYE5zc8eXNddJUErtImb9pQBOgzPtmyUE7DEmIsCpcE7r/SyPQoZ6KOvrbDeeTasj=
MWK
iYBJZN1c5U10q9/q7UgsH7atnIpxE288XNV7oSF+qbv2ghpzX7hJDN+G+xtQ+gj8wzKqJDRW8=
qDu
g0Nfn1unOYHLV4P5WetNohJeAuK4HK9/hKX6D1FsynjPCV7+SqauGA8Yb24ra/A5vIK9/PlCh=
WSp
Vi5cIUOeq/8wFL+iyLJtdRphbNv3JoA9W6gUzRx3E1sFrUUy4Jp6iW1YrDCbmCbeCjT6qYU1r=
D2P
EhLW7nyJWB1zidpalMzkXk64ntrtKnErxgG0n3nPWqUxZdl5KP3Xaj3GTKSoQYl5mPLSc0j5N=
/hu
Larq+Ok2AJuaLorSbIAEetQru7Pjzbqv6Uyw4SvuvzY5nPeDRgXEQOKk7srBBhO/b2Fj9qCAF=
OBb
+oKmlh2eDBCNl06h/MIsMz3QkD2LEhNH11omLuzm3hK0+oi0k2RseK0AEQEAAcLBXwQYAQgAC=
QUC
W5ukPgIbDAAKCRDjVOa44ji5+AwxD/0bsnJFuuUmXDxuHDHzYFsWRfK1Y3lZf/TwX8tNSvEdI=
Wo1
ONG1rV0jIm8u49P3TI8/fYzei/gCRyb6y8+KmEc59mLPON1vkX14+tmXXuGDQROUi4ycHkQmz=
Fim
iS4+uPfX3LcU8nm/fgDC0EuMkUsB7gGS5gG+QMgltYAXE1mW/DjeQZlp0anhpiIAtRLwpx8vv=
mgZ
x059Jvs1fPQYUy01Gpd+bXI1BcJbgWN/UdrsfxzZQTtRmN2flmF4Qb6u6pGrU4S42kEppzqzI=
c6m
JnUoT9ZXhU1W811FCGL/xm8pzv2Ky9oGkKWj9WxFBIvJVAH1yWxFhnZxxZHIq8otPdhPP/Y/P=
QyY
OJpmajmru07VMY0TJQXCJYl5M0i1JPkLw+CytZFonrybHuJrXhQXZFh3z+AR//vA8WqUXBtVA=
IXk
p0kUOS4judGp5zge6Fxfr4CiGontkwX2cUDRgLN0UPm4Gg3IQqhZuWnYkj+fjk+DY5ClHhqQX=
v2k
ckEpXv0a6KU4AovOaY3v47mBJ9j/VAIJHwSazh70PWftkr2vBUXetTSS5AieCxbpkZ/cEJV9o=
nBW
4vFA1d3aNIVyUUWE1gsax7HDIZKxVi4WIjxeIqYV+1DXTlgUPdKqR8gMR5g2s3aNu4BI377IG=
DHb
3ipJxDkxG+aYcMVoIOwXCA6CX/VDAg=3D=3D
=3DR9cN
-----END PGP PUBLIC KEY BLOCK-----

--------------AA75F92451910E1959E7AA1B--

--0dkJRyxk8uT91uj5g8MyqqYrnurb9Sik6--

--NqXOaa89OI35wjbO0CSVwRlUn25VPs3KR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl/N5PoFAwAAAAAACgkQ41TmuOI4ufjV
TQ/9HbQY7ky9HUoQqF5jCtwtgSjhR65tiIr6vtre4RhJ4VrpelqOhF1qAM8qE6B3jLj8HhM61Jnt
tht1hdX3rujCmVxfd1hGphxf3cwhMReHgI8BouVEzM0fgFCsDIcc1D0dzXfqgdnloj+CePfXOxnO
T54/nzdzCU87kjwG45LXpIjszs0/hnQLGh/n1KKToU3GwAyfGXf/xjbIKCBWsmGH1OdJryXTi77e
whuAuDrYrE/CjuFm9mDhzokBMS0KrNwmhROEG7xDICbEE28DJHjm/NU6aX7IyTgx2CN3/AizBaG6
M4UQpBhSloe6RaFD2tqUA6iNJW36DLZnBtEqj4jJL/6Cy2IFWlMgIzzcVOwXrlD4Fm5rI9rvyRGg
yOkPN/MDSpR37IBdQX+22X08aI2TMTAZwSkU5NMC7TNemqHaO0ZxUbs9DF83LU9PjWxVhBsKYgr1
yKoLCBvYtMzFNRq40Agqcn7NB6AJFsftTznd1TOywbCnEw009HJWYkj7zUMJX4xTCzZqaR5NoL2K
suUA39mx6EjEff9A3oYPgopqdzJjiKp1ddFpTaYX3v6XJN4e7sP00k0eUd6QPv+TSzq0DyOIeX33
Q1Qv8G2/Cjf8pAqZB5YuFE1SYh5DgDkynboJgnHLgRsei8KqsjEcADUoX1+RHNTAOnZrrke2qSmu
K6c=
=sIEa
-----END PGP SIGNATURE-----

--NqXOaa89OI35wjbO0CSVwRlUn25VPs3KR--

