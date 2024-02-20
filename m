Return-Path: <linux-kselftest+bounces-5028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C9B85BD3E
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 14:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332F41C21296
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 13:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5ED6A331;
	Tue, 20 Feb 2024 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nyIAckuz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268416A330;
	Tue, 20 Feb 2024 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436099; cv=none; b=gOAVmVfhpDrdAWqipLVXvjzYENgF2Quq3vK79TxVCgpOmxoJ9QXDvxJj4OuRvoz2/2k1wjM0eLK97RdwwMK36YNeDTpsqTJSmb0LLyIcsjoVHbQwDGgTvhY57fnSRJ7K4KyguHJRCB5Rb4T1q8TDz2M8AhaloNl6pbyJLqhiWlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436099; c=relaxed/simple;
	bh=s33Wk6+5bN8DuFeX/OYawEEVewmpIJsyEU/lFdKVqa4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I93kjaEriKDUAzwxucX1PAEZxDcJGLruhy7OpI3jtCKO/MFBX77EbdQjr3IP9cg/hGUoUPfJYo5s/qC+xCzYa+4ZIKXHP7sFao83vPWB54rOJBX5rEhK6lQiMLKrFHTa0s/ghDWjXIRuBZFEVDpyhSA3RsjLhVheAUp7sbpWNtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nyIAckuz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KCicT3026931;
	Tue, 20 Feb 2024 13:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=B8lLttoACaBGlu7Jo9nikgkeMCNCXiH/JeUZSRVDr0c=;
 b=nyIAckuzTugO1tM7eBQKnFx0pK0djnCuA9YlLcrbrIlTQwWz/f6t7mD5ZkcKqpW4nrBr
 GsoHKMzwra++rIvB55XYM+2v2rBXFCa6ioyI83OZeuazNAC8lKQVai85RrkhhWppRUkz
 nJiy8fonMQptBxppTSfASKCvMRmh5HQM4gnFvtxvkV3tihNIW33cft0Pg3RSHGDs1b1s
 /CDI2kHBsS6bxkhuRpBX77cYbQA3+WqXA7zyLDGgL7hzI+Tbqu2PyeHhLSR1ucolRKKc
 guflBWrFxQ/manvXohWfzpqWdeOszzLQD2lzTAvcrDxqACW9R11/LT/ivR6zRN1FNppH ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcv6fhqwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 13:34:47 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41KDW3tQ016286;
	Tue, 20 Feb 2024 13:34:47 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcv6fhqwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 13:34:47 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41KD7Qvm031117;
	Tue, 20 Feb 2024 13:34:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9bkqy53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 13:34:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41KDYfef65929570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 13:34:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB18020063;
	Tue, 20 Feb 2024 13:34:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4551E2004B;
	Tue, 20 Feb 2024 13:34:40 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown [9.171.28.134])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Feb 2024 13:34:40 +0000 (GMT)
Message-ID: <43ab557a097f2e64b0869861866569e6ac372972.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] KVM: s390: selftests: memop: add a simple AR test
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Eric Farman <farman@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio
 Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan
 <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Date: Tue, 20 Feb 2024 14:34:40 +0100
In-Reply-To: <20240215205344.2562020-3-farman@linux.ibm.com>
References: <20240215205344.2562020-1-farman@linux.ibm.com>
	 <20240215205344.2562020-3-farman@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K6rTS800l5PHxjmqnrJLAEiBzA0b8WRD
X-Proofpoint-ORIG-GUID: 2a0hFO4FaaD3bFdcFdwJx1ENQzo_IQr_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402200097

On Thu, 2024-02-15 at 21:53 +0100, Eric Farman wrote:
> There is a selftest that checks for an (expected) error when an
> invalid AR is specified, but not one that exercises the AR path.
>=20
> Add a simple test that mirrors the vanilla write/read test while
> providing an AR. An AR that contains zero will direct the CPU to
> use the primary address space normally used anyway. AR[1] is
> selected for this test because the host AR[1] is usually non-zero,
> and KVM needs to correctly swap those values.
>=20
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

> ---
>  tools/testing/selftests/kvm/s390x/memop.c | 28 +++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/se=
lftests/kvm/s390x/memop.c
> index bb3ca9a5d731..be20c26ee545 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -375,6 +375,29 @@ static void test_copy(void)
>  	kvm_vm_free(t.kvm_vm);
>  }
>=20
> +static void test_copy_access_register(void)
> +{
> +	struct test_default t =3D test_default_init(guest_copy);
> +
> +	HOST_SYNC(t.vcpu, STAGE_INITED);
> +
> +	prepare_mem12();
> +	t.run->psw_mask &=3D ~(3UL << (63 - 17));
> +	t.run->psw_mask |=3D 1UL << (63 - 17);  /* Enable AR mode */
> +

I feel like part of the commit message should be a comment here

/*
 * Guest AR[1] should be zero, in which case the primary address space is u=
sed.
 * The host makes use of AR[1], its value must not be used for the memop.
 */
> +	CHECK_N_DO(MOP, t.vcpu, LOGICAL, WRITE, mem1, t.size,
> +		   GADDR_V(mem1), AR(1));
> +	HOST_SYNC(t.vcpu, STAGE_COPIED);
> +
> +	CHECK_N_DO(MOP, t.vcpu, LOGICAL, READ, mem2, t.size,
> +		   GADDR_V(mem2), AR(1));
> +	ASSERT_MEM_EQ(mem1, mem2, t.size);
> +
> +	t.run->psw_mask &=3D ~(3UL << (63 - 17));   /* Disable AR mode */

Any reason for this? It's not necessary since the vm is going to be destroy=
ed.
> +
> +	kvm_vm_free(t.kvm_vm);
> +}
> +
>  static void set_storage_key_range(void *addr, size_t len, uint8_t key)
>  {
>  	uintptr_t _addr, abs, i;
> @@ -1101,6 +1124,11 @@ int main(int argc, char *argv[])
>  			.test =3D test_copy_key_fetch_prot_override,
>  			.requirements_met =3D extension_cap > 0,
>  		},
> +		{
> +			.name =3D "copy with access register mode",
> +			.test =3D test_copy_access_register,
> +			.requirements_met =3D true,
> +		},
>  		{
>  			.name =3D "error checks with key",
>  			.test =3D test_errors_key,


