Return-Path: <linux-kselftest+bounces-22593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B599DB271
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 06:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80F5EB2269F
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 05:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3424012D758;
	Thu, 28 Nov 2024 05:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SG1bhClx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F3BAD4B;
	Thu, 28 Nov 2024 05:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732771041; cv=none; b=WgMReH+6KQxGLiUMsGUeshCUVWIDHO3cREHQ6ZrOf2KlXrw7rs2UX8YLLYwuzkJDldWepnSHatqIBQ6KB33Y3NHmyoH8z8J6Oufc0LS+y3KdD2fYXMGy7OmHgQZIKiG4Brx6v+cmg4Qschn/uk/QFd05chLg95x2YVQs9WEiaic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732771041; c=relaxed/simple;
	bh=axw8GZUDEJnuGgv5liNFiPSxzG9BMlaL8C/F0uNUl38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiXNUd5DjEod7ljvDjw9V5eYBa452SAKRELXzOqsLuAjydcNW1DOJjg38RtN3nJQ6xAcBwsD+Z8aF9e+5bIM8Eowwy2Bp4P/QlWBNBoGsg0wRVfCNZ5XIXjbt7yZzeleft1hbopqfUmpvGb4sJMU9NoWEj8v7CTUOnJc/g1qDMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SG1bhClx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ARHY5vG023453;
	Thu, 28 Nov 2024 05:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QEtc7N
	tViimDoFDdgLXWudJ4k4WGhKfg8PoKOO7OHVk=; b=SG1bhClxyHpEOrPWMkDw6y
	KlSb44pSJl349hzfFZulsyeWQGXRViKjDWwtzl+SOKPT7BB+aQtMyTG/fIV7ZIRl
	MyeIGYTuCO7COmbNZYWMaXfuJkFDlv8bmVtMWSNBdoRsQhVpX3UoTap8H4GhN3w7
	mZsDtJe5IoIQmV5Y3fARgyxNYMD2wE6w0/LTytEdamb/QBZf3gPHZT/xf3nc/xWI
	KOIYznETM8f3+DfUEjlV/tOc5o9pL5AxJis87q/EzYIpltjc3n1uVAfnBnOTGWVO
	6RaQ9+AVLomVRWu3JdMBwJYJSof6JRDj7grFC6a4Xp7XmSaopIAvz7zkeC9P7V7Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4366ywjxk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 05:17:04 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AS5H33A010314;
	Thu, 28 Nov 2024 05:17:03 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4366ywjxjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 05:17:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AS4iVna009796;
	Thu, 28 Nov 2024 05:17:02 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43672f6cqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 05:17:02 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AS5H15K17891944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 05:17:01 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAA2C58053;
	Thu, 28 Nov 2024 05:17:01 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCAC358043;
	Thu, 28 Nov 2024 05:16:58 +0000 (GMT)
Received: from [9.171.2.153] (unknown [9.171.2.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Nov 2024 05:16:58 +0000 (GMT)
Message-ID: <8174031c-b9b1-4e32-806e-28f1b2c1dee0@linux.ibm.com>
Date: Thu, 28 Nov 2024 10:46:56 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: hugetlb_dio: Fix test naming
To: Mark Brown <broonie@kernel.org>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241127-kselftest-mm-hugetlb-dio-names-v1-1-22aab01bf550@kernel.org>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20241127-kselftest-mm-hugetlb-dio-names-v1-1-22aab01bf550@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wosSQ4wwott07zOshz_l1TmyE3Ju3Ys1
X-Proofpoint-ORIG-GUID: E2TCnRoXf8oDsq9DL7HtmSlWStGa_7tz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411280038


On 11/27/24 21:44, Mark Brown wrote:
> The string logged when a test passes or fails is used by the selftest
> framework to identify which test is being reported. The hugetlb_dio test
> not only uses the same strings for every test that is run but it also uses
> different strings for test passes and failures which means that test
> automation is unable to follow what the test is doing at all.
>
> Pull the existing duplicated logging of the number of free huge pages
> before and after the test out of the conditional and replace that and the
> logging of the result with a single ksft_print_result() which incorporates
> the parameters passed into the test into the output.
>
> Fixes: fae1980347bf ("selftests: hugetlb_dio: fixup check for initial conditions to skip in the start")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/mm/hugetlb_dio.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/selftests/mm/hugetlb_dio.c
> index 432d5af15e66b7d6cac0273fb244d6696d7c9ddc..db63abe5ee5e85ff7795d3ea176c3ac47184bf4f 100644
> --- a/tools/testing/selftests/mm/hugetlb_dio.c
> +++ b/tools/testing/selftests/mm/hugetlb_dio.c
> @@ -76,19 +76,15 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
>   	/* Get the free huge pages after unmap*/
>   	free_hpage_a = get_free_hugepages();
>   
> +	ksft_print_msg("No. Free pages before allocation : %d\n", free_hpage_b);
> +	ksft_print_msg("No. Free pages after munmap : %d\n", free_hpage_a);
> +
>   	/*
>   	 * If the no. of free hugepages before allocation and after unmap does
>   	 * not match - that means there could still be a page which is pinned.
>   	 */
> -	if (free_hpage_a != free_hpage_b) {
> -		ksft_print_msg("No. Free pages before allocation : %d\n", free_hpage_b);
> -		ksft_print_msg("No. Free pages after munmap : %d\n", free_hpage_a);
> -		ksft_test_result_fail(": Huge pages not freed!\n");
> -	} else {
> -		ksft_print_msg("No. Free pages before allocation : %d\n", free_hpage_b);
> -		ksft_print_msg("No. Free pages after munmap : %d\n", free_hpage_a);
> -		ksft_test_result_pass(": Huge pages freed successfully !\n");
> -	}
> +	ksft_test_result(free_hpage_a == free_hpage_b,
> +			 "free huge pages from %u-%u\n", start_off, end_off);

Hi Mark

This test allocates a hugetlb buffer and adjusts the start and end offsets of the buffer based
on|start_off|  and|end_off|. The adjusted buffer is then used for Direct I/O (DIO). If I understand
correctly,|start_off|  and|end_off|  are not free huge pages but rather DIO buffer offsets. Should we
change this message to "Hugetlb DIO buffer offset"?

Thanks
Donet

>   }
>   
>   int main(void)
>
> ---
> base-commit: 6f3d2b5299b0a8bcb8a9405a8d3fceb24f79c4f0
> change-id: 20241127-kselftest-mm-hugetlb-dio-names-1ebccbe8183d
>
> Best regards,

