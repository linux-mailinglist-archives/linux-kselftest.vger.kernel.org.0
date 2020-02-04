Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2851151E44
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2020 17:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgBDQ0v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Feb 2020 11:26:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727307AbgBDQ0v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Feb 2020 11:26:51 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 014GBlwb073928
        for <linux-kselftest@vger.kernel.org>; Tue, 4 Feb 2020 11:26:50 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xxbmpmkmw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Feb 2020 11:26:50 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Tue, 4 Feb 2020 16:26:48 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Feb 2020 16:26:44 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 014GQhfj59769072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Feb 2020 16:26:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7DD811C04C;
        Tue,  4 Feb 2020 16:26:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14F9411C04A;
        Tue,  4 Feb 2020 16:26:40 +0000 (GMT)
Received: from [9.199.41.160] (unknown [9.199.41.160])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Feb 2020 16:26:39 +0000 (GMT)
Subject: Re: [PATCH v11 8/9] hugetlb_cgroup: Add hugetlb_cgroup reservation
 tests
To:     Mina Almasry <almasrymina@google.com>
Cc:     mike.kravetz@oracle.com, shuah@kernel.org, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
References: <20200203232248.104733-1-almasrymina@google.com>
 <20200203232248.104733-8-almasrymina@google.com>
From:   Sandipan Das <sandipan@linux.ibm.com>
Date:   Tue, 4 Feb 2020 21:56:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203232248.104733-8-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20020416-4275-0000-0000-0000039DE5A1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020416-4276-0000-0000-000038B20D7F
Message-Id: <0fa5d77c-d115-1e30-cb17-d6a48c916922@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_05:2020-02-04,2020-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002040108
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Mina,

On 04/02/20 4:52 am, Mina Almasry wrote:
> The tests use both shared and private mapped hugetlb memory, and
> monitors the hugetlb usage counter as well as the hugetlb reservation
> counter. They test different configurations such as hugetlb memory usage
> via hugetlbfs, or MAP_HUGETLB, or shmget/shmat, and with and without
> MAP_POPULATE.
> 
> Also add test for hugetlb reservation reparenting, since this is
> a subtle issue.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Cc: sandipan@linux.ibm.com
> 
> ---
> 
> Changes in v11:
> - Modify test to not assume 2MB hugepage size.
> - Updated resv.* to rsvd.*
> Changes in v10:
> - Updated tests to resv.* name changes.
> Changes in v9:
> - Added tests for hugetlb reparenting.
> - Make tests explicitly support cgroup v1 and v2 via script argument.
> Changes in v6:
> - Updates tests for cgroups-v2 and NORESERVE allocations.
> 

There are still a couple of places where 2MB page size is being used.
These are my workarounds to get the tests running on ppc64.

diff --git a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
index 2be672c2b311..d11d1febccc3 100755
--- a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
+++ b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
@@ -29,6 +29,15 @@ if [[ ! -e $CGROUP_ROOT ]]; then
   fi
 fi
 
+function get_machine_hugepage_size() {
+  hpz=$(grep -i hugepagesize /proc/meminfo)
+  kb=${hpz:14:-3}
+  mb=$(($kb / 1024))
+  echo $mb
+}
+
+MB=$(get_machine_hugepage_size)
+
 function cleanup() {
   echo cleanup
   set +e
@@ -67,7 +76,7 @@ function assert_state() {
   fi
 
   local actual_a_hugetlb
-  actual_a_hugetlb="$(cat "$CGROUP_ROOT"/a/hugetlb.2MB.$usage_file)"
+  actual_a_hugetlb="$(cat "$CGROUP_ROOT"/a/hugetlb.${MB}MB.$usage_file)"
   if [[ $actual_a_hugetlb -lt $(($expected_a_hugetlb - $tolerance)) ]] ||
     [[ $actual_a_hugetlb -gt $(($expected_a_hugetlb + $tolerance)) ]]; then
     echo actual a hugetlb = $((${actual_a_hugetlb%% *} / 1024 / 1024)) MB
@@ -95,7 +104,7 @@ function assert_state() {
   fi
 
   local actual_b_hugetlb
-  actual_b_hugetlb="$(cat "$CGROUP_ROOT"/a/b/hugetlb.2MB.$usage_file)"
+  actual_b_hugetlb="$(cat "$CGROUP_ROOT"/a/b/hugetlb.${MB}MB.$usage_file)"
   if [[ $actual_b_hugetlb -lt $(($expected_b_hugetlb - $tolerance)) ]] ||
     [[ $actual_b_hugetlb -gt $(($expected_b_hugetlb + $tolerance)) ]]; then
     echo actual b hugetlb = $((${actual_b_hugetlb%% *} / 1024 / 1024)) MB
@@ -152,7 +161,7 @@ write_hugetlbfs() {
 
 set -e
 
-size=$((2 * 1024 * 1024 * 25)) # 50MB = 25 * 2MB hugepages.
+size=$((${MB} * 1024 * 1024 * 25)) # 50MB = 25 * 2MB hugepages.
 
 cleanup

diff --git a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
index fa82a66e497a..ca98ad229b75 100755
--- a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
@@ -226,7 +226,7 @@ function write_hugetlbfs_and_get_usage() {
 function cleanup_hugetlb_memory() {
   set +e
   local cgroup="$1"
-  if [[ "$(pgrep write_to_hugetlbfs)" != "" ]]; then
+  if [[ "$(pgrep -f write_to_hugetlbfs)" != "" ]]; then
     echo kiling write_to_hugetlbfs
     killall -2 write_to_hugetlbfs
     wait_for_hugetlb_memory_to_get_depleted $cgroup
@@ -264,7 +264,7 @@ function run_test() {
   setup_cgroup "hugetlb_cgroup_test" "$cgroup_limit" "$reservation_limit"
 
   mkdir -p /mnt/huge
-  mount -t hugetlbfs -o pagesize=2M,size=256M none /mnt/huge
+  mount -t hugetlbfs -o pagesize=${MB}M,size=256M none /mnt/huge
 
   write_hugetlbfs_and_get_usage "hugetlb_cgroup_test" "$size" "$populate" \
     "$write" "/mnt/huge/test" "$method" "$private" "$expect_failure" \
@@ -318,7 +318,7 @@ function run_multiple_cgroup_test() {
   setup_cgroup "hugetlb_cgroup_test2" "$cgroup_limit2" "$reservation_limit2"
 
   mkdir -p /mnt/huge
-  mount -t hugetlbfs -o pagesize=2M,size=256M none /mnt/huge
+  mount -t hugetlbfs -o pagesize=${MB}M,size=256M none /mnt/huge
 
   write_hugetlbfs_and_get_usage "hugetlb_cgroup_test1" "$size1" \
     "$populate1" "$write1" "/mnt/huge/test1" "$method" "$private" \

---

Also I had missed running charge_reserved_hugetlb.sh the last time.
Right now, it stops at the following scenario.

Test normal case with write.
private=, populate=, method=2, reserve=
nr hugepages = 10
writing cgroup limit: 83886080
writing reseravation limit: 83886080

Starting:
hugetlb_usage=0
reserved_usage=0
expect_failure is 0
Putting task in cgroup 'hugetlb_cgroup_test'
Method is 2
Executing ./write_to_hugetlbfs -p /mnt/huge/test -s 83886080 -w  -m 2  -l
Writing to this path: /mnt/huge/test
Writing this size: 83886080
Not populating.
Using method=2
Shared mapping.
RESERVE mapping.
Allocating using SHM.
shmid: 0x5, shmget key:0
shmaddr: 0x7dfffb000000
Writing to memory.
Starting the writes:
.write_result is 0
.After write:
hugetlb_usage=16777216
reserved_usage=83886080
....kiling write_to_hugetlbfs
...Received 2.
Deleting the memory
Done deleting the memory
16777216
83886080
Memory charged to hugtlb=16777216
Memory charged to reservation=83886080
expected (83886080) != actual (16777216): Reserved memory charged to hugetlb cgroup.
CLEANUP DONE


The other test script (hugetlb_reparenting_test.sh) passes.
Did not observe anything unusual with hugepage accounting
either.


- Sandipan

