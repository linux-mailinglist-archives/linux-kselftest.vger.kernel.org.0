Return-Path: <linux-kselftest+bounces-7976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEFE8A5394
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9CC1C2172B
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 14:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D653B81211;
	Mon, 15 Apr 2024 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WZrksUYi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B96762D2;
	Mon, 15 Apr 2024 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191245; cv=none; b=DS7dcDz7q3C9Ag/vcSd+E5R8aatrkLscOww2eWZbLVOG/1XK7LAqKMG9N27R16m0J6rcvfwKLE62sV87tsRCtGOj4qrKql+zErL6kAyAvjf24nk9UF2frbaQnjrsQsUvdLcYiIa72f8WrRk6+FywgjI6blQN4SXIKiGIjiQ2bpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191245; c=relaxed/simple;
	bh=U8+VhHtVtHYm99pwI9LXA/ypd0RLVR9GZnPOqy4ulUk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aGnBqHcPXw/FE4iSI3epp+6Q4n0Ye8AjUw1dOUUAh/niV0z436I7iDXn38UBvLt+b1Oz6lRBrJK8Nn/HosEAK206sFxBsFKPPEuVYts919pYbGBU9NuA1oRjw6FKZNEtgU+3kw3SuHwr5NPfLR2aMnWrshrcZIYkjFDT3/fP2ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WZrksUYi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FEQXoW001397;
	Mon, 15 Apr 2024 14:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PN5/ARZMuUxRRpX+S1l+ndAR/7ixTDYrllzhIU8GDgQ=;
 b=WZrksUYigDTsgLOK9ZdeecgKLxcSKnggI+E0yMaNB58dUxJ23v755TThJt/XzjGKzk/e
 YD//8jiHXP8IEjQ4yEO4qgXNjnkSvc8zIVRtuYlEQ4J6PPkWOqsyQoXWSCTh8qazuh6W
 yZGQk048U2ZNDkuuAAiozD8DZnz5LcrkJI8Z4xBWgH+iYfKxByQ/KvAzr/mADxEx2Wey
 E+4HaiAws5TJhwIb01gUGKMZkTZYJaQwHOW2grhNUux6Qa2LDrM4PiNrUiZ5S4n02fAb
 yT7t2CZ+fgBM1bfrAh67sOzO0Hlk4IvOUK9Uyvvpidi+YGi9vCaWyRgZUdHFIDrV37JK Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xfh2jm48g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 14:27:21 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43FERK9B002996;
	Mon, 15 Apr 2024 14:27:20 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xfh2jm48e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 14:27:20 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43FDiM4p021347;
	Mon, 15 Apr 2024 14:27:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg6kk7ynt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 14:27:19 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43FEREXh49938780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 14:27:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EC5420043;
	Mon, 15 Apr 2024 14:27:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CE9B20040;
	Mon, 15 Apr 2024 14:27:14 +0000 (GMT)
Received: from [9.155.199.94] (unknown [9.155.199.94])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2024 14:27:14 +0000 (GMT)
Message-ID: <743bd638-2a9d-4c53-bc44-14292edef58a@linux.ibm.com>
Date: Mon, 15 Apr 2024 16:27:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] KVM: s390x: selftests: Add shared zeropage test
Content-Language: en-US
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
References: <20240412084329.30315-1-david@redhat.com>
 <Zh03fI2oA0UkE0Kp@tuxmaker.boeblingen.de.ibm.com>
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <Zh03fI2oA0UkE0Kp@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FT_VEbQt5d-W0Wbkq9NOT1W9eDcmA1cJ
X-Proofpoint-ORIG-GUID: ruadlHnHpqBXQJv0mOBmsUmd1-A1fvBg
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_11,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 clxscore=1011 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150094



Am 15.04.24 um 16:19 schrieb Alexander Gordeev:
> On Fri, Apr 12, 2024 at 10:43:29AM +0200, David Hildenbrand wrote:
> Hi David,
>>   tools/testing/selftests/kvm/Makefile          |   1 +
>>   .../kvm/s390x/shared_zeropage_test.c          | 110 ++++++++++++++++++
>>   2 files changed, 111 insertions(+)
>>   create mode 100644 tools/testing/selftests/kvm/s390x/shared_zeropage_test.c
> 
> Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>
> 
> @Janosch, Christian,
> 
> I think this patch should go via s390 tree together with
> https://lore.kernel.org/r/20240411161441.910170-3-david@redhat.com
> 
> Do you agree?

Yes, thank you

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

