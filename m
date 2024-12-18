Return-Path: <linux-kselftest+bounces-23515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 621559F6991
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 16:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8FAC7A16D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 15:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541B61DF27F;
	Wed, 18 Dec 2024 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s0R+IbWn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1473C1DF75D;
	Wed, 18 Dec 2024 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534610; cv=none; b=MYJ6IhE/v37sfuStgQpD9MpqQKGb/pHHoL7QvDaHjVEdrYvHaccAJWAcY1tOrOhG1zga5TdLTbOcHC2bTeY8T87n4tt/PnTyfI1ukLD7TG1PcAmwjE8Jyw2vx6blCSQ02/xAYbFzV6UpiMTT6xyVGGBiESckM16o9VoR94+X4g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534610; c=relaxed/simple;
	bh=fSUp46VViPj8t/mf4IP5wd/i78vdvM8CNiHjFV4L03U=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=eDP6FNRadkzDd1ZuKgwENVBrucCn/ZSgQvKkyazyqJu8hb7D1rcQw6nD3h+6E5USakuo4E77eQF09NEW1TIWXifdLpblBOp8wCbeoAEy5n7SeA5qeRnzBTFHjj7FoaordjmJT8GLKggBMuh4hJ6C9V0hTLDa4MLwlOJTo/3j9D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s0R+IbWn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI85hUc027232;
	Wed, 18 Dec 2024 15:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jkLrwF
	TSsOx7w7Xa12nOrkPyqj2BG7RWSojsIJSN5Dc=; b=s0R+IbWnRx2Yzq8zXhcvRr
	nZHJsdwwNEgYGGs0H48d+AFxOS6zXq7JLpDxRVMzOEyIydyCaevPwG6khhq1sG6s
	82mjkfrjc2BV1m/UQJnMLY+gx0ECX+U2YZWP1QFguF9GdYLm4b/orSyoGy/0jPLL
	p13BJu6YKAaT8SUqsN3liABQQrrrxDZFRAQsCnCEH7zywfUwwHEjh6bF36VVAs0n
	C7jf6F2Zui1CsnApilB8PkYxJftfJWCX9BbJ19VFgw/1nw+hyF9TMIEOehrvAc9f
	CFrwfQY0XTtrIJukC5dQnuosTC1lr0tCXPABW28JUUyfPTzF755LX/1ODi1CNUBw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ktk2hyns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 15:10:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIDt055014383;
	Wed, 18 Dec 2024 15:10:02 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hq21r45e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 15:10:02 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BIFA0nF31392358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 15:10:01 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB5E658059;
	Wed, 18 Dec 2024 15:10:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF2F858058;
	Wed, 18 Dec 2024 15:09:59 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Dec 2024 15:09:59 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 18 Dec 2024 16:09:59 +0100
From: Hariharan Mari <hari55@linux.ibm.com>
To: Christoph Schlameuss <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda
 <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo
 Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Ulrich Weigand
 <ulrich.weigand@de.ibm.com>,
        Dominik Dingel <dingel@linux.vnet.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 6/6] selftests: kvm: s390: Add has device attr check to
 uc_attr_mem_limit selftest
In-Reply-To: <20241216092140.329196-7-schlameuss@linux.ibm.com>
References: <20241216092140.329196-1-schlameuss@linux.ibm.com>
 <20241216092140.329196-7-schlameuss@linux.ibm.com>
Message-ID: <ceed40f88610fb04c502415b7bbf9ed3@linux.ibm.com>
X-Sender: hari55@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MjeyKkPPE_EhfswMIJ47SkEwZAYvTFHt
X-Proofpoint-ORIG-GUID: MjeyKkPPE_EhfswMIJ47SkEwZAYvTFHt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 impostorscore=0 clxscore=1015 mlxlogscore=878 adultscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180117

On 2024-12-16 10:21, Christoph Schlameuss wrote:
> Fixup the uc_attr_mem_limit test case to also cover the
> KVM_HAS_DEVICE_ATTR ioctl.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Tested-by: Hariharan Mari <hari55@linux.ibm.com>
> ---
>  tools/testing/selftests/kvm/s390x/ucontrol_test.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> index ef3e391811b3..087496fe264d 100644
> --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> @@ -206,10 +206,13 @@ TEST_F(uc_kvm, uc_attr_mem_limit)
>  	struct kvm_device_attr attr = {
>  		.group = KVM_S390_VM_MEM_CTRL,
>  		.attr = KVM_S390_VM_MEM_LIMIT_SIZE,
> -		.addr = (unsigned long)&limit,
> +		.addr = (u64)&limit,
>  	};
>  	int rc;
> 
> +	rc = ioctl(self->vm_fd, KVM_HAS_DEVICE_ATTR, &attr);
> +	EXPECT_EQ(0, rc);
> +
>  	rc = ioctl(self->vm_fd, KVM_GET_DEVICE_ATTR, &attr);
>  	EXPECT_EQ(0, rc);
>  	EXPECT_EQ(~0UL, limit);

