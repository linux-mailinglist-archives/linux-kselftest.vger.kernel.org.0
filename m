Return-Path: <linux-kselftest+bounces-22600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0139DB82B
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 13:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C727016323D
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 12:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FD41A0B04;
	Thu, 28 Nov 2024 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C8Bumpu+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8704154BEC;
	Thu, 28 Nov 2024 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798727; cv=none; b=j3uI1Ziviov8Wo79Itfe6ER5VpwJZcQWdi8Bbklssv1QkDPefcm/hns7ChIn72ivtDxcAPqzygjAqebiPPl+8gg3ouiUKQQyFad59xVKiCEQ3IiMXoMFXFUVGXp5gOk/sCcGOVlxP+HRdo+CP+gIdO+C3PLy3D5ZFZBAivlI86U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798727; c=relaxed/simple;
	bh=p7c/rBF1cnsqrfwvU+YW/YI8oedRL6OskFnoO6vdTYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/EfV+u3f552CNOBXYVuwk5KdW4MZ8UfwMAySaDHUs5CyL3oXOWp3UAzPwNkrbIOTvhAFMjjJ+/8SlrHVe/LfS2B5TsfavHX9bO7D8fKfBlIp5S+x+ubVUgc2JEoeCyB+LS3V+zO3JDswu0enrDSk1UtqCQ9Os4Or27zPGMQU6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C8Bumpu+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AS7WIG2019105;
	Thu, 28 Nov 2024 12:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+vP4jR
	IW/scQLgDo6yiVzbWB+2Xrjyu4I+pVdj7iaCo=; b=C8Bumpu+gZ/j08L6sz/4m0
	IFvAYUueFJjZjQTDfbvugLiwXrvb55lgCUsKU+XbmpUiob8Y/UTYqP/8sbQaCmHF
	O5V0eu6qSpcJ4F6KSyVzeFsjkZJAjK8ObyofFUIxx5pRuMzu+Cb37oIJKK+C8glp
	qoakBDVlhkN8fdD8iQjYZoqGYL/D7yw+probTmEPeDtftaVXfkkrYXyvqYWBR4fB
	QCiTu3KtI3sLhK/xYkKiKh7fxYo0p+vyblg9scNuILBe/vG7KxKBqY0WCYrMsp6l
	IHIEKK3pVXCFx5sJ+PTqndiJqClKTTyAErMsQ4OYH/SplhMylheYzuwKXSP9gxfw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4366ywn181-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 12:58:37 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ASClQhN014163;
	Thu, 28 Nov 2024 12:58:37 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4366ywn17q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 12:58:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASCopvo002445;
	Thu, 28 Nov 2024 12:58:36 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43672ghrnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 12:58:36 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ASCwZVd25690712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 12:58:35 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5235258043;
	Thu, 28 Nov 2024 12:58:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFC5858053;
	Thu, 28 Nov 2024 12:58:31 +0000 (GMT)
Received: from [9.171.2.153] (unknown [9.171.2.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Nov 2024 12:58:31 +0000 (GMT)
Message-ID: <0290e481-48b2-48c5-acd1-66b80af66575@linux.ibm.com>
Date: Thu, 28 Nov 2024 18:28:29 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: hugetlb_dio: Fix test naming
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241127-kselftest-mm-hugetlb-dio-names-v1-1-22aab01bf550@kernel.org>
 <8174031c-b9b1-4e32-806e-28f1b2c1dee0@linux.ibm.com>
 <ed5c2cd6-9090-444e-9da1-9d8c7376a6e2@sirena.org.uk>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <ed5c2cd6-9090-444e-9da1-9d8c7376a6e2@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _U24e7_TUcdr63VY5czgIxE2DkFXuqEG
X-Proofpoint-ORIG-GUID: kJVN5rkCMhHjMS5aSPhzuXziSrldDySe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=679 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411280098


On 11/28/24 18:14, Mark Brown wrote:
> On Thu, Nov 28, 2024 at 10:46:56AM +0530, Donet Tom wrote:
>> On 11/27/24 21:44, Mark Brown wrote:
>>> +	ksft_test_result(free_hpage_a == free_hpage_b,
>>> +			 "free huge pages from %u-%u\n", start_off, end_off);
>> This test allocates a hugetlb buffer and adjusts the start and end offsets of the buffer based
>> on|start_off|  and|end_off|. The adjusted buffer is then used for Direct I/O (DIO). If I understand
>> correctly,|start_off|  and|end_off|  are not free huge pages but rather DIO buffer offsets. Should we
>> change this message to "Hugetlb DIO buffer offset"?
> Sure, so long as the message is consistent it doesn't really matter what
> it is from the point of view of the tooling.  I also noticed while doing
> this that the test doesn't verify that a huge page is actually used at
> any point, I was thinking about doing an incremental change for that
> too.

Sure. Thank you.

>
> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.

