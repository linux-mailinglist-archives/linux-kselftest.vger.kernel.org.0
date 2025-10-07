Return-Path: <linux-kselftest+bounces-42814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9152BC0330
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 07:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B513BD580
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 05:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722AB1FECAB;
	Tue,  7 Oct 2025 05:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O8AIiczh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8771F13C914;
	Tue,  7 Oct 2025 05:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759814964; cv=none; b=qyI+HFmqtZk6U3ni/FKcjA+4KKRnJDIYBr/ArbL+yMnpvb5BBYk/+hAf+QUkeZ5ppA176vxhNPDEnI3ak3RJEKckHg5nsQNjHL6L3qAKewK+HIbnLPVIzDX/3VgwItsvEbvN1kT+tT6qMsxsTdS4YW5O+PGAKB+E+LR73ZFaLF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759814964; c=relaxed/simple;
	bh=0Kl+DZ/tc3LE3RVoiRvgwtqMaQkds4Urq32hQZZN8rE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=u6dIqLFVZCTY77EmdvzyRl6tcp7fINqbJwNBKoqAlNaF4D1jJk78nCcyAs6ceBXiG3CVArYtPoOMTCHtmqAT5HmpK0cSN9EUUnq5q2MHXUR9m7ahUIXKIowf1lPETVD8uTi5f+q+EnIFMjuGwj3NVSSw7X7cYnI0L3uVLPjK5co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O8AIiczh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596NktMr007671;
	Tue, 7 Oct 2025 05:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=BAtC0w6ddeGX7BZOYk+5ICrNsjc3
	qhw9wh5z9OzF+E8=; b=O8AIiczhDihTrZCXkGl9pdy+mSmr5WZOhwD+4Q30rXhw
	7QE65euY5kE6CjNDka2x01kSjdUiJ4T9JBJFiTDtKLxPYCZ7B32GpLnuTcphoDya
	WdR028sWzrJPM8XX5Yo0c22ULT/Qwr+vm5yI+/coDVHibQ60VIVGSz0gwyy4IMjX
	JkYvVNriMpS0eh5EAqrsTzHufomZz4ceLcouPvoau82s1nyi41En3Z3mkrm8VRTs
	1MZ9vI59AAec+XioyJd/ldYj6Z5KY4v5RPFPoZpLqpZIiDqEdhOm0qgMoGXCIkoN
	ifMUdadMOwgYV9gpjYUKkKVR1gaRHDp+L/DpxCtXLA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49js0scyt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 05:29:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5970pbX9031419;
	Tue, 7 Oct 2025 05:29:16 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49kfdk1m7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 05:29:16 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5975TGLH20185776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Oct 2025 05:29:16 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B34258056;
	Tue,  7 Oct 2025 05:29:16 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 691C45803F;
	Tue,  7 Oct 2025 05:29:14 +0000 (GMT)
Received: from [9.98.109.65] (unknown [9.98.109.65])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Oct 2025 05:29:14 +0000 (GMT)
Message-ID: <88f1df7e-8347-45f7-a2a1-e321e72e4009@linux.ibm.com>
Date: Tue, 7 Oct 2025 10:59:12 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linux-kselftest@vger.kernel.org
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [linux-next20251003] tmp2 selftests resulting in Kernel OOPs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e4a52d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=SFsY72qJKfksyYy68MgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ebr90XJ14DZht262LQfZO3Y8My_ywbwG
X-Proofpoint-ORIG-GUID: ebr90XJ14DZht262LQfZO3Y8My_ywbwG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAzMDIwMSBTYWx0ZWRfX9ui6U7Rw0QEJ
 YWtcihaCnZASBFRY756Ziy6swXBQZAxT9yha3QCyfbc8rwIz4kfT1OF8iQs/92kLk+tuLf8Pq8V
 LVGWlPKaMUivkINIXIg7QMF6kRcy40+GQ0rzKQlNCie52LTCP89qwMiVI5XwIknlKPyEWDoYWKC
 P6iht8pyVoHirkYqBLafJLem7nDQ3T7IjXb8sA2xjveHxDjaYKX70GYX4eTT38Te5WcA7qq+DIF
 SFn9o13d+0cE6wS4SuBJdMENlKC4K6ZUzQsws1qC+e+3IVYc7Yk16qOLWB2v67esI9r2So3iw8w
 ugljuLMecuk116SA+pPdTwMB/upL43q50m97SuO6OAFxpwwmjrb618/J22OfG4J7EEWKkGzZR5n
 Jy3FRAlJYF/8MwmW9K0MKyXGsZlPmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510030201

Greetings!!!


IBM CI has reported a kernel OOPs while running TPM2selftests on IBM 
Power11 system with linux-next20251002 kernel.


Test Case:

make run_tests
TAP version 13
1..3
# timeout set to 600
# selftests: tpm2: test_smoke.sh
# test_read_partial_overwrite (tpm2_tests.SmokeTest) ... ok
# test_read_partial_resp (tpm2_tests.SmokeTest) ... ok
# test_seal_with_auth (tpm2_tests.SmokeTest) ... ok
# test_seal_with_policy (tpm2_tests.SmokeTest) ... ok
# test_seal_with_too_long_auth (tpm2_tests.SmokeTest) ... ok
# test_send_two_cmds (tpm2_tests.SmokeTest) ... ok
# test_too_short_cmd (tpm2_tests.SmokeTest) ... ok
# test_unseal_with_wrong_auth (tpm2_tests.SmokeTest) ... ok
# test_unseal_with_wrong_policy (tpm2_tests.SmokeTest) ... ERROR
#
# ======================================================================
# ERROR: test_unseal_with_wrong_policy (tpm2_tests.SmokeTest)
# -----------------------------------------------------


Traces:


[  452.604333] BUG: KASAN: slab-use-after-free in tpmrm_release+0x78/0xa8
[  452.604345] Read of size 8 at addr c00000001c650000 by task python3/1856
[  452.604353]
[  452.604358] CPU: 24 UID: 0 PID: 1856 Comm: python3 Kdump: loaded Not 
tainted 6.17.0-next-20251003 #1 VOLUNTARY
[  452.604364] Hardware name: IBM,9080-HEX Power11 (architected) 
0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
[  452.604368] Call Trace:
[  452.604370] [c0000000c1867840] [c00000000187ea4c] 
dump_stack_lvl+0x84/0xe8 (unreliable)
[  452.604380] [c0000000c1867870] [c000000000803754] 
print_address_description.constprop.0+0x11c/0x56c
[  452.604388] [c0000000c1867910] [c000000000803c84] print_report+0xe0/0x358
[  452.604394] [c0000000c18679e0] [c000000000804124] 
kasan_report+0x128/0x1f4
[  452.604400] [c0000000c1867af0] [c0000000008062b4] __asan_load8+0xa8/0xe0
[  452.604406] [c0000000c1867b10] [c000000000f2ec18] tpmrm_release+0x78/0xa8
[  452.604412] [c0000000c1867b40] [c0000000008b6a2c] __fput+0x21c/0x60c
[  452.604417] [c0000000c1867bc0] [c0000000008ada70] sys_close+0x74/0xd0
[  452.604424] [c0000000c1867bf0] [c000000000039270] 
system_call_exception+0x1e0/0x460
[  452.604431] [c0000000c1867e50] [c00000000000d05c] 
system_call_vectored_common+0x15c/0x2ec
[  452.604438] ---- interrupt: 3000 at 0x7fffb7534ab4
[  452.604443] NIP:  00007fffb7534ab4 LR: 00007fffb7534ab4 CTR: 
0000000000000000
[  452.604446] REGS: c0000000c1867e80 TRAP: 3000   Not tainted 
(6.17.0-next-20251003)
[  452.604449] MSR:  800000000280f033 
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 44284422  XER: 00000000
[  452.604466] IRQMASK: 0
[  452.604466] GPR00: 0000000000000006 00007ffff65d76b0 00007fffb7c17700 
0000000000000006
[  452.604466] GPR04: 0000000000000000 0000000000000000 0000000000000000 
0000000000000004
[  452.604466] GPR08: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[  452.604466] GPR12: 0000000000000000 00007fffb7e6b8e0 00000000000000a1 
00007fffb67acec0
[  452.604466] GPR16: 0000000164032ad0 00007fffb67aceb0 00007fffb76f6a90 
0000000000000000
[  452.604466] GPR20: 00007fffb6f21850 0000000000000000 00007fffb71062c0 
0000000164034490
[  452.604466] GPR24: 00007fffb6f2fea0 00007fffb67acea8 0000000164032b18 
00007fffb7c45b32
[  452.604466] GPR28: 00007fffb7c678e0 00007fffb67aceb8 0000000000000006 
0000000164034490
[  452.604510] NIP [00007fffb7534ab4] 0x7fffb7534ab4
[  452.604513] LR [00007fffb7534ab4] 0x7fffb7534ab4
[  452.604516] ---- interrupt: 3000
[  452.604518]
[  452.604601] Allocated by task 1856:
[  452.604607]  kasan_save_stack+0x34/0x64
[  452.604614]  kasan_save_track+0x2c/0x50
[  452.604621]  kasan_save_alloc_info+0x58/0x74
[  452.604628]  __kasan_kmalloc+0x12c/0x168
[  452.604635]  __kmalloc_cache_noprof+0x1d8/0x71c
[  452.604643]  tpmrm_open+0x88/0x168
[  452.604649]  chrdev_open+0x1f4/0x484
[  452.604656]  do_dentry_open+0x578/0x9cc
[  452.604663]  vfs_open+0x68/0x23c
[  452.604670]  do_open+0x514/0x74c
[  452.604676]  path_openat+0x16c/0x380
[  452.604682]  do_filp_open+0x104/0x230
[  452.604689]  do_sys_openat2+0xb8/0x154
[  452.604696]  sys_openat+0xcc/0x130
[  452.604703]  system_call_exception+0x1e0/0x460
[  452.604710]  system_call_vectored_common+0x15c/0x2ec
[  452.604718]
[  452.604722] Freed by task 1856:
[  452.604726]  kasan_save_stack+0x34/0x64
[  452.604733]  kasan_save_track+0x2c/0x50
[  452.604739]  __kasan_save_free_info+0x64/0x110
[  452.604747]  __kasan_slab_free+0xb0/0x10c
[  452.604753]  kfree+0x220/0x624
[  452.604760]  tpmrm_release+0x6c/0xa8
[  452.604766]  __fput+0x21c/0x60c
[  452.604772]  sys_close+0x74/0xd0
[  452.604779]  system_call_exception+0x1e0/0x460
[  452.604786]  system_call_vectored_common+0x15c/0x2ec
[  452.604794]
[  452.604797] The buggy address belongs to the object at c00000001c650000
[  452.604797]  which belongs to the cache kmalloc-8k of size 8192
[  452.604806] The buggy address is located 0 bytes inside of
[  452.604806]  freed 8192-byte region [c00000001c650000, c00000001c652000)
[  452.604815]
[  452.604818] The buggy address belongs to the physical page:
[  452.604824] page: refcount:0 mapcount:0 mapping:0000000000000000 
index:0xc00000001c644000 pfn:0x1c60
[  452.604833] head: order:3 mapcount:0 entire_mapcount:0 
nr_pages_mapped:0 pincount:0
[  452.604840] flags: 
0x3ffffe00000040(head|node=0|zone=0|lastcpupid=0x1fffff)
[  452.604849] page_type: f5(slab)
[  452.604856] raw: 003ffffe00000040 c000000007012300 5deadbeef0000122 
0000000000000000
[  452.604864] raw: c00000001c644000 000000008020001e 00000000f5000000 
0000000000000000
[  452.604872] head: 003ffffe00000040 c000000007012300 5deadbeef0000122 
0000000000000000
[  452.604879] head: c00000001c644000 000000008020001e 00000000f5000000 
0000000000000000
[  452.604887] head: 003ffffe00000003 c00c000000071801 00000000ffffffff 
00000000ffffffff
[  452.604894] head: ffffffffffffffff 0000000000000000 00000000ffffffff 
0000000000000008
[  452.604900] page dumped because: kasan: bad access detected
[  452.604905]
[  452.604908] Memory state around the buggy address:
[  452.604914]  c00000001c64ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[  452.604920]  c00000001c64ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[  452.604927] >c00000001c650000: fa fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[  452.604933]                    ^
[  452.604937]  c00000001c650080: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[  452.604944]  c00000001c650100: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[  452.604950] 
==================================================================
[  452.604955] Disabling lock debugging due to kernel taint
[  452.604961] Kernel attempted to read user page (770) - exploit 
attempt? (uid: 0)
[  452.604969] BUG: Kernel NULL pointer dereference on read at 0x00000770
[  452.604975] Faulting instruction address: 0xc0000000002b2e0c
[  452.604982] Oops: Kernel access of bad area, sig: 11 [#1]
[  452.604987] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
[  452.604996] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 
nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct 
nft_chain_nat nf_nat bonding nf_conntrack tls nf_defrag_ipv6 
nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink sunrpc pseries_rng 
vmx_crypto fuse ext4 crc16 mbcache jbd2 sd_mod sg ibmvscsi ibmveth 
scsi_transport_srp pseries_wdt
[  452.605073] CPU: 24 UID: 0 PID: 1856 Comm: python3 Kdump: loaded 
Tainted: G    B               6.17.0-next-20251003 #1 VOLUNTARY
[  452.605084] Tainted: [B]=BAD_PAGE
[  452.605089] Hardware name: IBM,9080-HEX Power11 (architected) 
0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
[  452.605096] NIP:  c0000000002b2e0c LR: c0000000002b2e08 CTR: 
0000000000000000
[  452.605103] REGS: c0000000c1867820 TRAP: 0300   Tainted: G B          
       (6.17.0-next-20251003)
[  452.605110] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
28284420  XER: 0000000d
[  452.605132] CFAR: c000000000807920 DAR: 0000000000000770 DSISR: 
40000000 IRQMASK: 0
[  452.605132] GPR00: c0000000002b2e08 c0000000c1867ac0 c00000000234a500 
0000000000000001
[  452.605132] GPR04: 0000000000000008 0000000000000000 c0000000002b2e08 
0000000000000001
[  452.605132] GPR08: 0000000000000020 0000000000000001 0000000000000001 
a80e000000000000
[  452.605132] GPR12: c00e0000009b1c8c c000000d0ddeb700 0000000000000000 
0000000000000000
[  452.605132] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[  452.605132] GPR20: 0000000000000008 0000000000000000 c000000008202f00 
c00000007b9ff620
[  452.605132] GPR24: c00000008a76cb20 c00000008a76cb40 c00000008a76cb08 
c000000002201e80
[  452.605132] GPR28: c000000061569248 0000000000000770 c00000008a76cb00 
0000000000000768
[  452.605227] NIP [c0000000002b2e0c] up_read+0x50/0x17c
[  452.605237] LR [c0000000002b2e08] up_read+0x4c/0x17c
[  452.605245] Call Trace:
[  452.605249] [c0000000c1867ac0] [c0000000002b2e08] up_read+0x4c/0x17c 
(unreliable)
[  452.605261] [c0000000c1867b10] [c000000000f2ec28] tpmrm_release+0x88/0xa8
[  452.605271] [c0000000c1867b40] [c0000000008b6a2c] __fput+0x21c/0x60c
[  452.605280] [c0000000c1867bc0] [c0000000008ada70] sys_close+0x74/0xd0
[  452.605291] [c0000000c1867bf0] [c000000000039270] 
system_call_exception+0x1e0/0x460
[  452.605301] [c0000000c1867e50] [c00000000000d05c] 
system_call_vectored_common+0x15c/0x2ec
[  452.605312] ---- interrupt: 3000 at 0x7fffb7534ab4
[  452.605319] NIP:  00007fffb7534ab4 LR: 00007fffb7534ab4 CTR: 
0000000000000000
[  452.605326] REGS: c0000000c1867e80 TRAP: 3000   Tainted: G B          
       (6.17.0-next-20251003)
[  452.605333] MSR:  800000000280f033 
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 44284422  XER: 00000000
[  452.605362] IRQMASK: 0
[  452.605362] GPR00: 0000000000000006 00007ffff65d76b0 00007fffb7c17700 
0000000000000006
[  452.605362] GPR04: 0000000000000000 0000000000000000 0000000000000000 
0000000000000004
[  452.605362] GPR08: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[  452.605362] GPR12: 0000000000000000 00007fffb7e6b8e0 00000000000000a1 
00007fffb67acec0
[  452.605362] GPR16: 0000000164032ad0 00007fffb67aceb0 00007fffb76f6a90 
0000000000000000
[  452.605362] GPR20: 00007fffb6f21850 0000000000000000 00007fffb71062c0 
0000000164034490
[  452.605362] GPR24: 00007fffb6f2fea0 00007fffb67acea8 0000000164032b18 
00007fffb7c45b32
[  452.605362] GPR28: 00007fffb7c678e0 00007fffb67aceb8 0000000000000006 
0000000164034490
[  452.605450] NIP [00007fffb7534ab4] 0x7fffb7534ab4
[  452.605456] LR [00007fffb7534ab4] 0x7fffb7534ab4
[  452.605462] ---- interrupt: 3000
[  452.605467] Code: fbc1fff0 7c7f1b78 f8010010 f821ffb1 e92d0c78 
f9210028 39200000 3ba30008 38800008 7fa3eb78 48554af5 60000000 
<ebdf0008> eb8d0908 7bc90764 fbc10020
[  452.605501] ---[ end trace 0000000000000000 ]---
[  452.613685] pstore: backend (nvram) writing error (-1)
[  452.613691]



If you happen to fix this, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.


