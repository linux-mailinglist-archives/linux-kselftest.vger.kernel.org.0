Return-Path: <linux-kselftest+bounces-30327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F23BA7F34C
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 05:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5218518872C3
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 03:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB4E238170;
	Tue,  8 Apr 2025 03:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T2/M0gA/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4AB3FD4;
	Tue,  8 Apr 2025 03:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744083983; cv=none; b=cUxE12m61NLBnIxC4/WbgSenMlsVhihLc1MT8hZcC/b1PsMBH+iFDXN/A00SkZbk6p7LvwPCtBASkvPukCfLdvh0ToSlyTqWoRqzRoGG1XH1C3DtOv0xb2W0YkXEYEJUCirJw/zixeUCEucspL+QYwhe9OZ4sGcCZdkg+HppeLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744083983; c=relaxed/simple;
	bh=ftiJ95s+WRxYQeHttTck0PvuZoukLOdONyC0zBbhFXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+nDFTWGOrO4ulezw01AJb2EmgYiZKZRUreMC/KpKpnjuaNsgG1zvNAdyeJN6r295vIR1XIJrvLpAKAtXi28bcI+5Tg5y/XCgwu3M849fW1eEcdthnQQZfsV1GpD7D/wS3aZNAzucPvg6RTa34HDL4VQX/AaI+UuZnbn0EvM08g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T2/M0gA/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537JVObL000328;
	Tue, 8 Apr 2025 03:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BUJUFa
	B36sJxqSLzap8VGtMLtvbnpP+bEYqH+PwFuIU=; b=T2/M0gA/otPuCIKVC8Hbps
	AOoK1LvA1Rtbd/l8XbspAWP7G8K3km9g6nrOPpjJnlv+Bc0JOVrzgFJUR8jCGFvm
	ShjxyIou/TQEyGQ6+GTqDM9CK6fJo/jEwt1okJCmYAt+pJqddKpQqTUmqsDzKV/6
	OQYnBN37cvu0+az1u7+WLhQrUf8GDBIAxnD3nZiQKnGs+keY0NQ6l1mSAm++8DBq
	nHKJkayt4Xyr+NR97E5s95iapm6KvfGjVQ/KJih4PCriX6BbeHE/x7EgHZE/HfMB
	kWf0XDGoHjS4XT6YG2dA0oEenzs9svSqeeGc+h+QI/OJx2G8eSC+qx9YSY9TiTsg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ver7bwmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 03:46:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53820ohr024583;
	Tue, 8 Apr 2025 03:46:08 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ueut9388-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 03:46:08 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5383k8iD4588242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Apr 2025 03:46:08 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 080BD58056;
	Tue,  8 Apr 2025 03:46:08 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A7495804E;
	Tue,  8 Apr 2025 03:46:04 +0000 (GMT)
Received: from [9.109.245.113] (unknown [9.109.245.113])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Apr 2025 03:46:04 +0000 (GMT)
Message-ID: <c8f5199c-36ed-4675-a5b7-e23d5f2ecf49@linux.ibm.com>
Date: Tue, 8 Apr 2025 09:16:02 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest/mm: Make hugetlb_reparenting_test tolerant to
 async reparenting
To: Li Wang <liwang@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc: Waiman Long <longman@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dev Jain <dev.jain@arm.com>,
        "Kirill A. Shuemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>
References: <20250407084201.74492-1-liwang@redhat.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20250407084201.74492-1-liwang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8trCQhXusk4TAQQ4rTfhU88qiJ9Io20U
X-Proofpoint-GUID: 8trCQhXusk4TAQQ4rTfhU88qiJ9Io20U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_01,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1011 impostorscore=0 adultscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080022


On 4/7/25 2:12 PM, Li Wang wrote:
> In cgroup v2, memory and hugetlb usage reparenting is asynchronous.
> This can cause test flakiness when immediately asserting usage after
> deleting a child cgroup. To address this, add a helper function
> `assert_with_retry()` that checks usage values with a timeout-based retry.
> This improves test stability without relying on fixed sleep delays.
>
> Also bump up the tolerance size to 7MB.
>
> To avoid False Positives:
>    ...
>    # Assert memory charged correctly for child only use.
>    # actual a = 11 MB
>    # expected a = 0 MB
>    # fail
>    # cleanup
>    # [FAIL]
>    not ok 11 hugetlb_reparenting_test.sh -cgroup-v2 # exit=1
>    # 0
>    # SUMMARY: PASS=10 SKIP=0 FAIL=1


I was also seeing this failure. I have tested this patch on my powerPC
setup and it is passing now.

./hugetlb_reparenting_test.sh -cgroup-v2
cleanup

Test charge, rmdir, uncharge
mkdir
write
Writing to this path: /mnt/huge/test
Writing this size: 52428800
Populating.
Not writing to memory.
Using method=0
Shared mapping.
RESERVE mapping.
Allocating using HUGETLBFS.

rmdir
uncharge
cleanup
done


Test child only hugetlb usage
setup
write
Writing to this path: /mnt/huge/test2
Writing this size: 52428800
Populating.
Not writing to memory.
Using method=0
Shared mapping.
RESERVE mapping.
Allocating using HUGETLBFS.

Assert memory charged correctly for child only use.
actual = 10 MB
expected = 0 MB
cleanup


Feel free to add
Tested-by Donet Tom <donettom@linux.ibm.com>


>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
> Cc: Shuah Khan <shuah@kernel.org>
> ---
>   .../selftests/mm/hugetlb_reparenting_test.sh  | 96 ++++++++-----------
>   1 file changed, 41 insertions(+), 55 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
> index 11f9bbe7dc22..1c172c6999f4 100755
> --- a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
> +++ b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
> @@ -36,7 +36,7 @@ else
>       do_umount=1
>     fi
>   fi
> -MNT='/mnt/huge/'
> +MNT='/mnt/huge'
>   
>   function get_machine_hugepage_size() {
>     hpz=$(grep -i hugepagesize /proc/meminfo)
> @@ -60,6 +60,41 @@ function cleanup() {
>     set -e
>   }
>   
> +function assert_with_retry() {
> +  local actual_path="$1"
> +  local expected="$2"
> +  local tolerance=$((7 * 1024 * 1024))
> +  local timeout=20
> +  local interval=1
> +  local start_time
> +  local now
> +  local elapsed
> +  local actual
> +
> +  start_time=$(date +%s)
> +
> +  while true; do
> +    actual="$(cat "$actual_path")"
> +
> +    if [[ $actual -ge $(($expected - $tolerance)) ]] &&
> +        [[ $actual -le $(($expected + $tolerance)) ]]; then
> +      return 0
> +    fi
> +
> +    now=$(date +%s)
> +    elapsed=$((now - start_time))
> +
> +    if [[ $elapsed -ge $timeout ]]; then
> +      echo "actual = $((${actual%% *} / 1024 / 1024)) MB"
> +      echo "expected = $((${expected%% *} / 1024 / 1024)) MB"
> +      cleanup
> +      exit 1
> +    fi
> +
> +    sleep $interval
> +  done
> +}
> +
>   function assert_state() {
>     local expected_a="$1"
>     local expected_a_hugetlb="$2"
> @@ -70,58 +105,13 @@ function assert_state() {
>       expected_b="$3"
>       expected_b_hugetlb="$4"
>     fi
> -  local tolerance=$((5 * 1024 * 1024))
> -
> -  local actual_a
> -  actual_a="$(cat "$CGROUP_ROOT"/a/memory.$usage_file)"
> -  if [[ $actual_a -lt $(($expected_a - $tolerance)) ]] ||
> -    [[ $actual_a -gt $(($expected_a + $tolerance)) ]]; then
> -    echo actual a = $((${actual_a%% *} / 1024 / 1024)) MB
> -    echo expected a = $((${expected_a%% *} / 1024 / 1024)) MB
> -    echo fail
> -
> -    cleanup
> -    exit 1
> -  fi
> -
> -  local actual_a_hugetlb
> -  actual_a_hugetlb="$(cat "$CGROUP_ROOT"/a/hugetlb.${MB}MB.$usage_file)"
> -  if [[ $actual_a_hugetlb -lt $(($expected_a_hugetlb - $tolerance)) ]] ||
> -    [[ $actual_a_hugetlb -gt $(($expected_a_hugetlb + $tolerance)) ]]; then
> -    echo actual a hugetlb = $((${actual_a_hugetlb%% *} / 1024 / 1024)) MB
> -    echo expected a hugetlb = $((${expected_a_hugetlb%% *} / 1024 / 1024)) MB
> -    echo fail
> -
> -    cleanup
> -    exit 1
> -  fi
> -
> -  if [[ -z "$expected_b" || -z "$expected_b_hugetlb" ]]; then
> -    return
> -  fi
> -
> -  local actual_b
> -  actual_b="$(cat "$CGROUP_ROOT"/a/b/memory.$usage_file)"
> -  if [[ $actual_b -lt $(($expected_b - $tolerance)) ]] ||
> -    [[ $actual_b -gt $(($expected_b + $tolerance)) ]]; then
> -    echo actual b = $((${actual_b%% *} / 1024 / 1024)) MB
> -    echo expected b = $((${expected_b%% *} / 1024 / 1024)) MB
> -    echo fail
> -
> -    cleanup
> -    exit 1
> -  fi
>   
> -  local actual_b_hugetlb
> -  actual_b_hugetlb="$(cat "$CGROUP_ROOT"/a/b/hugetlb.${MB}MB.$usage_file)"
> -  if [[ $actual_b_hugetlb -lt $(($expected_b_hugetlb - $tolerance)) ]] ||
> -    [[ $actual_b_hugetlb -gt $(($expected_b_hugetlb + $tolerance)) ]]; then
> -    echo actual b hugetlb = $((${actual_b_hugetlb%% *} / 1024 / 1024)) MB
> -    echo expected b hugetlb = $((${expected_b_hugetlb%% *} / 1024 / 1024)) MB
> -    echo fail
> +  assert_with_retry "$CGROUP_ROOT/a/memory.$usage_file" "$expected_a"
> +  assert_with_retry "$CGROUP_ROOT/a/hugetlb.${MB}MB.$usage_file" "$expected_a_hugetlb"
>   
> -    cleanup
> -    exit 1
> +  if [[ -n "$expected_b" && -n "$expected_b_hugetlb" ]]; then
> +    assert_with_retry "$CGROUP_ROOT/a/b/memory.$usage_file" "$expected_b"
> +    assert_with_retry "$CGROUP_ROOT/a/b/hugetlb.${MB}MB.$usage_file" "$expected_b_hugetlb"
>     fi
>   }
>   
> @@ -174,7 +164,6 @@ size=$((${MB} * 1024 * 1024 * 25)) # 50MB = 25 * 2MB hugepages.
>   
>   cleanup
>   
> -echo
>   echo
>   echo Test charge, rmdir, uncharge
>   setup
> @@ -195,7 +184,6 @@ cleanup
>   
>   echo done
>   echo
> -echo
>   if [[ ! $cgroup2 ]]; then
>     echo "Test parent and child hugetlb usage"
>     setup
> @@ -212,7 +200,6 @@ if [[ ! $cgroup2 ]]; then
>     assert_state 0 $(($size * 2)) 0 $size
>   
>     rmdir "$CGROUP_ROOT"/a/b
> -  sleep 5
>     echo Assert memory reparent correctly.
>     assert_state 0 $(($size * 2))
>   
> @@ -224,7 +211,6 @@ if [[ ! $cgroup2 ]]; then
>     cleanup
>   fi
>   
> -echo
>   echo
>   echo "Test child only hugetlb usage"
>   echo setup

