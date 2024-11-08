Return-Path: <linux-kselftest+bounces-21668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C1C9C1B14
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 11:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D5C1F218C9
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 10:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1893A1E3764;
	Fri,  8 Nov 2024 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MYS4ExCf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6100847F69;
	Fri,  8 Nov 2024 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062991; cv=none; b=X99O/COvP6Agd6ppERTrr3lNSFlHiUU5sLW7hEryPPE3nGcORLzJZ0SDAe5A4BeQnj7AFeKkNrguw/TOsSmJ7tnB26nCMJ7oPmeVRRetHlj53wqkfI34SPYlrbQyHbwhLnmYSkuPeRn2GTg4NXF/FcTlOSYWMe3mkzimViRxYBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062991; c=relaxed/simple;
	bh=lYKOawxz1Q7nlDLuMR7vnOgcfTC8R84N0Ew8t0dU7Js=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=buKK+o9wSInbS8ODKrGdb4TN362BZgpuTgu4kpjlarOqfj9Gs0GsPPt9yyUfQQDXFHn9sBSO0bBj/L6+E47bbRIeWr2bfQYWS6I/iKDrqo5UxqJ7xvj9U4uGFAd77NcG3YkmwbulD98IpmxJZXOg09a145JjMHCDjxnAX8vtPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MYS4ExCf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8AeXJR031436;
	Fri, 8 Nov 2024 10:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xHgmF6
	UU6hfAi+WJL2nBRYQKhfD8a/G2aximWS/8Ces=; b=MYS4ExCf9qDYVg254pakAw
	sUVZ6X+4/X3D0n7Zs26EFcWI3w9jTf7UOuNCZkckKKgMFQfBWxybxObArv41Ov8w
	HxPygx2ITzMo0Ze18p4PSTNf2saMRz8iUeDj2CFtiLM3e/RBqRFQVJBl5U6OgQi3
	M+QK5T/JNtRCRFOSDZu1HclERf1aO+lY0rTiYY1z2uCd31Jwozi9xNQKuxEazRcE
	tUHsv7DLhfEihPh0HeX3e3cKqq9ZO3UBKCoIIIT2K1A7VtipSpew5tSCTe5cEXNX
	JD1laYV1sRSK31d6i7XYdCwJ6f5Jumv6Y5gH2/r8sIo8/IJ7yglXwNiGpmy2yuJA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42sh3br157-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 10:49:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7NjCXn013158;
	Fri, 8 Nov 2024 10:49:37 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p14120hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 10:49:37 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A8Anaxs49742418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2024 10:49:36 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83C0258063;
	Fri,  8 Nov 2024 10:49:36 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 041E258052;
	Fri,  8 Nov 2024 10:49:34 +0000 (GMT)
Received: from [9.179.28.136] (unknown [9.179.28.136])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Nov 2024 10:49:33 +0000 (GMT)
Message-ID: <13a96176-1bfa-4567-8ce5-a2b75b110afc@linux.ibm.com>
Date: Fri, 8 Nov 2024 16:19:31 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: hugetlb_dio: Check for initial conditions to
 skip in the start
From: Donet Tom <donettom@linux.ibm.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241101141557.3159432-1-usama.anjum@collabora.com>
 <5883b1c0-13c6-4593-9dd5-17f34c1319fe@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <5883b1c0-13c6-4593-9dd5-17f34c1319fe@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xo7lmAb9_QkAWEe77q2eSQoteq00qaQ_
X-Proofpoint-ORIG-GUID: Xo7lmAb9_QkAWEe77q2eSQoteq00qaQ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411080086


On 11/8/24 16:05, Donet Tom wrote:
>
> On 11/1/24 19:45, Muhammad Usama Anjum wrote:
>> The test should be skipped if initial conditions aren't fulfilled in
>> the start instead of failing and outputting non-compliant TAP logs. This
>> kind of failure pollutes the results. The initial conditions are:
>> - The test should only execute if /tmp file can be allocated.
>> - The test should only execute if huge pages are free.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Before:
>> TAP version 13
>> 1..4
>> Bail out! Error opening file
>> : Read-only file system (30)
>>   # Planned tests != run tests (4 != 0)
>>   # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
>>
>> After:
>> TAP version 13
>> 1..0 # SKIP Unable to allocate file: Read-only file system
>> ---
>>   tools/testing/selftests/mm/hugetlb_dio.c | 19 ++++++++++++-------
>>   1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/hugetlb_dio.c 
>> b/tools/testing/selftests/mm/hugetlb_dio.c
>> index f9ac20c657ec6..60001c142ce99 100644
>> --- a/tools/testing/selftests/mm/hugetlb_dio.c
>> +++ b/tools/testing/selftests/mm/hugetlb_dio.c
>> @@ -44,13 +44,6 @@ void run_dio_using_hugetlb(unsigned int start_off, 
>> unsigned int end_off)
>>       if (fd < 0)
>>           ksft_exit_fail_perror("Error opening file\n");
>>   -    /* Get the free huge pages before allocation */
>> -    free_hpage_b = get_free_hugepages();
>
> Hi Muhammed Usman Anjum
>
> Reading the free pages is required before starting the test. This 
> value will be compared to the free pages after the test. If they are 
> not the same, the test will be considered a failure.
>
> Since reading the free pages before the test was 
> removed,|free_hpage_b|  is always 0, causing the test to fail.
>
> ./tools/testing/selftests/mm/hugetlb_dio TAP version 13 1..4 # No. 
> Free pages before allocation : 0 # No. Free pages after munmap : 100 
> not ok 1 : Huge pages not freed! # No. Free pages before allocation : 
> 0 # No. Free pages after munmap : 100 not ok 2 : Huge pages not freed! 
> # No. Free pages before allocation : 0 # No. Free pages after munmap : 
> 100 not ok 3 : Huge pages not freed! # No. Free pages before 
> allocation : 0 # No. Free pages after munmap : 100 not ok 4 : Huge 
> pages not freed! # Totals: pass:0 fail:4 xfail:0 xpass:0 skip:0 
> error:0 I think below changes are required. --- 
> a/tools/testing/selftests/mm/hugetlb_dio.c +++ 
> b/tools/testing/selftests/mm/hugetlb_dio.c @@ -44,6 +44,9 @@ void 
> run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off) if 
> (fd < 0) ksft_exit_fail_perror("Error opening file\n"); + /* Get the 
> free huge pages before allocation */ + free_hpage_b = 
> get_free_hugepages(); + /* Allocate a hugetlb page */ orig_buffer = 
> mmap(NULL, h_pagesize, mmap_prot, mmap_flags, -1, 0); if (orig_buffer 
> == MAP_FAILED) { With this change the tests are passing. 
> ./tools/testing/selftests/mm/hugetlb_dio TAP version 13 1..4 # No. 
> Free pages before allocation : 100 # No. Free pages after munmap : 100 
> ok 1 : Huge pages freed successfully ! # No. Free pages before 
> allocation : 100 # No. Free pages after munmap : 100 ok 2 : Huge pages 
> freed successfully ! # No. Free pages before allocation : 100 # No. 
> Free pages after munmap : 100 ok 3 : Huge pages freed successfully ! # 
> No. Free pages before allocation : 100 # No. Free pages after munmap : 
> 100 ok 4 : Huge pages freed successfully ! # Totals: pass:4 fail:0 
> xfail:0 xpass:0 skip:0 error:0 Thank
>
> Donet
>
>
Sorry. Please ignore above mail.

Reading the free pages is required before starting the test. This
value will be compared to the free pages after the test. If they are not the same, the test will be considered a failure.

Since reading the free pages before the test was removed,free_hpage_b is always 0, causing the test to fail.

./tools/testing/selftests/mm/hugetlb_dio
TAP version 13
1..4
# No. Free pages before allocation : 0
# No. Free pages after munmap : 100
not ok 1 : Huge pages not freed!
# No. Free pages before allocation : 0
# No. Free pages after munmap : 100
not ok 2 : Huge pages not freed!
# No. Free pages before allocation : 0
# No. Free pages after munmap : 100
not ok 3 : Huge pages not freed!
# No. Free pages before allocation : 0
# No. Free pages after munmap : 100
not ok 4 : Huge pages not freed!
# Totals: pass:0 fail:4 xfail:0 xpass:0 skip:0 error:0

I think below changes are required.

iff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/selftests/mm/hugetlb_dio.c
index 60001c142ce9..4b52106b8124 100644
--- a/tools/testing/selftests/mm/hugetlb_dio.c
+++ b/tools/testing/selftests/mm/hugetlb_dio.c
@@ -44,6 +44,9 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
         if (fd < 0)
                 ksft_exit_fail_perror("Error opening file\n");
  
+       /* Get the free huge pages before allocation */
+       free_hpage_b = get_free_hugepages();
+
         /* Allocate a hugetlb page */

         orig_buffer = mmap(NULL, h_pagesize, mmap_prot, mmap_flags, -1, 0);

         if (orig_buffer == MAP_FAILED) {

  With this change the tests are passing.

./tools/testing/selftests/mm/hugetlb_dio

TAP version 131..4
# No. Free pages before allocation : 100
# No. Free pages after munmap : 100
ok 1 : Huge pages freed successfully !
# No. Free pages before allocation : 100
# No. Free pages after munmap : 100
ok 2 : Huge pages freed successfully !
# No. Free pages before allocation : 100
# No. Free pages after munmap : 100
ok 3 : Huge pages freed successfully !
# No. Free pages before allocation : 100
# No. Free pages after munmap : 100
ok 4 : Huge pages freed successfully !
# Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0

Thanks
Donet


>> -    if (free_hpage_b == 0) {
>> -        close(fd);
>> -        ksft_exit_skip("No free hugepage, exiting!\n");
>> -    }
>> -
>>       /* Allocate a hugetlb page */
>>       orig_buffer = mmap(NULL, h_pagesize, mmap_prot, mmap_flags, -1, 
>> 0);
>>       if (orig_buffer == MAP_FAILED) {
>> @@ -94,8 +87,20 @@ void run_dio_using_hugetlb(unsigned int start_off, 
>> unsigned int end_off)
>>   int main(void)
>>   {
>>       size_t pagesize = 0;
>> +    int fd;
>>         ksft_print_header();
>> +
>> +    /* Open the file to DIO */
>> +    fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
>> +    if (fd < 0)
>> +        ksft_exit_skip("Unable to allocate file: %s\n", 
>> strerror(errno));
>> +    close(fd);
>> +
>> +    /* Check if huge pages are free */
>> +    if (!get_free_hugepages())
>> +        ksft_exit_skip("No free hugepage, exiting\n");
>> +
>>       ksft_set_plan(4);
>>         /* Get base page size */

