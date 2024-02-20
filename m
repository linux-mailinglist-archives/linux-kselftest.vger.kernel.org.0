Return-Path: <linux-kselftest+bounces-5037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21A685BF73
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 16:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0FD8B21B01
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 15:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1274974274;
	Tue, 20 Feb 2024 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LlqDbtmD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2766567E91;
	Tue, 20 Feb 2024 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441675; cv=none; b=Dy3VBh2HQvEovNBZD8yZuE9jN3Qk0zG4USGs2Xz7ZVz5VQPCSRiPmcI4IQgZax9Ky/OdEmDCAPgtxQdhoOILVgqb47U6Abmeca0MhdnEjmgdKYCP08NZat8Xu+qRv2w9g5t4I5ft61cJhDw2Mlmgch4bPP03PfJdiasMJ/Cj0T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441675; c=relaxed/simple;
	bh=ZDzLH1MgGRqC40omlvKASh98mas379oOsEHtBmsnDyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTQyvmrO1vxUfk3M6cNwFbDHBHfHAk5cNlgg6w6Yk7AeKfifOJxyYF7YHU33y1k+BrhBVpFUJMyZhV9PsKf90I1+Bz/dHDrbirelYvRSjQP8+H8z+W4WaT8vZqcqpAqmAVnZh7VZplXZ8dtHK3P+66muNrt0kZ1S9zcds8yubhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LlqDbtmD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KE7dwo017031;
	Tue, 20 Feb 2024 15:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uBd4hmbnYL31Rg6qKJ2+8BWN7CbCn5NMA5cF3iL2g70=;
 b=LlqDbtmDSi0NAwZQ5EeFLulJsFEwez8PJeZbonbVs1Mo+ksaJULMvgFzbGAgMiKEJ6Up
 VBJCINNDhWsPUahiGUpm7WVqYN8VOWPYy34s4F5xDKU4pw99CWPBAaThkEhA18fMcRCO
 5cPqPu66xJY/rJuFcPnDu9wuc7OVXmCWScrT2VijrNnITzLWrAxi6IPGQHRlJTl5f5MQ
 8OO/6gdh8X3vDaqtjLn679pbD133FWmBkS79wwqB1sqpQCn2EK9RlXMOQNazjpQU1FVV
 m/4X0U21VNWFIfq2wzBnztUmZCMRUtnKttpt9WPtrhuyx7NthPZzi/bjLruG4R79QcWC Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcwjjhq9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 15:07:44 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41KF0gKv020168;
	Tue, 20 Feb 2024 15:07:44 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcwjjhq99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 15:07:44 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41KEpFTc009547;
	Tue, 20 Feb 2024 15:07:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84p8tvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 15:07:42 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41KF7aBh2228986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 15:07:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D956120067;
	Tue, 20 Feb 2024 15:07:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3BAE2004D;
	Tue, 20 Feb 2024 15:07:36 +0000 (GMT)
Received: from [9.152.224.41] (unknown [9.152.224.41])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Feb 2024 15:07:36 +0000 (GMT)
Message-ID: <4312394b-ceb6-4328-be3e-f21a0d8ac67d@linux.ibm.com>
Date: Tue, 20 Feb 2024 16:07:36 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] KVM: s390: selftests: memop: add a simple AR test
To: Eric Farman <farman@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20240216213616.3819805-1-farman@linux.ibm.com>
 <20240216213616.3819805-3-farman@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20240216213616.3819805-3-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K5mMrd8JHJfNHpPArQsRkSJeb9vhPcvZ
X-Proofpoint-ORIG-GUID: RXL8ZU2z2tEqla2RhQZxov8RzYVv55A-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 mlxlogscore=703 impostorscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402200108



Am 16.02.24 um 22:36 schrieb Eric Farman:
> There is a selftest that checks for an (expected) error when an
> invalid AR is specified, but not one that exercises the AR path.
> 
> Add a simple test that mirrors the vanilla write/read test while
> providing an AR. An AR that contains zero will direct the CPU to
> use the primary address space normally used anyway. AR[1] is
> selected for this test because the host AR[1] is usually non-zero,
> and KVM needs to correctly swap those values.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

