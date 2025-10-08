Return-Path: <linux-kselftest+bounces-42863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 678BBBC4266
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 11:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F0734E4828
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 09:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5E52F533F;
	Wed,  8 Oct 2025 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XXTG+kHg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9654F1F936;
	Wed,  8 Oct 2025 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759915505; cv=none; b=Rby6hhWTTNaXO3trFwDBgWg4ZIG/vb3wI5diwMw3y0nJQw1HtHtui1nnTJkLaEthjVm62thhOcct6Ep0XvQwc+5C1UcFmbFwg0FW4pq9cC2GopUkyVYJrPWuNcLHTYQz+Dwm6t/4bTVfUzVytTvyfHsXlQC5pVTo7jGS7bpV5O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759915505; c=relaxed/simple;
	bh=EZ3fNNBM8erB0f13OOv9BmkyjXdeZeu/1uZQ7U03TdM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pMiHeWXGarhZNBwKoAMuQF2U+3dDXhGoaDbb0NRt6vGzumP1K1VRXoNmSm8xTB5VqJtyFTJbJREpNsyLy+Q8SJ9QCEy4GfhScsYVwcDFYgVI4pqLt2xHtAqpcrfJUqVl95JzpdaXtSFWwlhFrDNA8Wk3+sjufbelf86rlCcPank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XXTG+kHg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59865EGg024854;
	Wed, 8 Oct 2025 09:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZrzNfR
	RvcJS97NTmRhy4XBCnvSrdNrzkeiBtW6nAwxA=; b=XXTG+kHgvcejg23ihBRV+P
	DmBqVJ/lz1NVea5GWNLjTxPvdoYlF7W7uohkDpwIfR3vJ2TJc9OH6jIICZs3dpN3
	CXyeOkZ7JhRlSRzkBgRanszRGDi79HvV/Fuahkbey0ukGkZYoYFVZYosUdMTt7dk
	6Uepclcw8d1UyzQm2KLqBPfi7S1mrucOXr+eYXK85WGowB26X9Iixfyq/+Xo773G
	vQ12J1sMYDn6mtVNAPsDjDLKf+8WOdrX8lRUK3VJ/v3d7Xhq9cELAxkQ1jaA6+O8
	2sUp1Ca7kKFXvGEg6v5ZvvXrhGbFrRzls7Xq7bVthTZNpqTxHeT7lFnWif167DRQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49js0sksbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:24:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5986UrIa013189;
	Wed, 8 Oct 2025 09:24:39 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49kg4jqjpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:24:39 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5989OcUk64815450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Oct 2025 09:24:38 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7996358054;
	Wed,  8 Oct 2025 09:24:38 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CD5358050;
	Wed,  8 Oct 2025 09:24:35 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.98.109.65])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Oct 2025 09:24:34 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [bisected][linux-next20251003] tmp2 selftests resulting in Kernel
 OOPs
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <feadc4f6-839b-4c04-b6df-dedf279fb315@csgroup.eu>
Date: Wed, 8 Oct 2025 14:54:22 +0530
Cc: LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linux-kselftest@vger.kernel.org, daleksan@redhat.com,
        jstancek@redhat.com, jarkko@kernel.org, pmenzel@molgen.mpg.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <8540AB99-D3C8-42B1-9A1F-BCB74C8F5F20@linux.ibm.com>
References: <88f1df7e-8347-45f7-a2a1-e321e72e4009@linux.ibm.com>
 <3d7a5f70-7ece-48ba-92bd-8b6473fd8b6c@linux.ibm.com>
 <feadc4f6-839b-4c04-b6df-dedf279fb315@csgroup.eu>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e62dd8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=UqCG9HQmAAAA:8 a=VwQbUJbxAAAA:8
 a=e5mUnYsNAAAA:8 a=1UX6Do5GAAAA:8 a=VnNF1IyMAAAA:8 a=VabnemYjAAAA:8
 a=NEAV23lmAAAA:8 a=tNIM7thpAAAA:8 a=FhxJebokv2ALl9HGJ60A:9 a=QEXdDO2ut3YA:10
 a=Vxmtnl_E_bksehYqCbjh:22 a=Et2XPkok5AAZYJIKzHr1:22 a=gKebqoRLp9LExxC7YDUY:22
 a=Hj2ravQqDRfZqFUSZohz:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: SyXWYQGnZbccR51a1P-XjyuZiT8GSNHZ
X-Proofpoint-ORIG-GUID: SyXWYQGnZbccR51a1P-XjyuZiT8GSNHZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAzMDIwMSBTYWx0ZWRfX6J18HCQz0M8Y
 TgLQTFesrMhv21aZpTqbxv4bfvoA+Y8vcrsWoUHrVmHwE24pbRjYTRuvpf4t9xFIuSrkbDAous4
 XuDVGaVpAw5Sd/ubxt3H2V1z6pwvMIqQfx2u1RID/dsNO7XwXpB/2mRYmfMtqTdV6T2CcrVIar4
 wlb+ZkTvmFCdBixxRuV/UpM1Fe/QH5L5rys8T5w+h0Mg9Iu6vx9jWtaSey9+oKKmmBaCHgF6E1z
 4La2Gn4K784L9w/joNYL6KMfxToZGArP3GInGJNDu6nFGYYGvusX0gd7YyksbfvxgLwxP1Wq0OI
 h59QLihfahOCOID/7L4FF+sbZP3G7wnq1In6QR3FQVc5teULQO5KPq4cVtjgRjRMYJOwcoZ9l2p
 Nt0fxjYLFEeKcpL48t0lJcGnEMxcsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510030201



> On 7 Oct 2025, at 9:29=E2=80=AFPM, Christophe Leroy =
<christophe.leroy@csgroup.eu> wrote:
>=20
>=20
>=20
> Le 07/10/2025 =C3=A0 17:08, Venkat Rao Bagalkote a =C3=A9crit :
>> On 07/10/25 10:59 am, Venkat Rao Bagalkote wrote:
>>> Greetings!!!
>>>=20
>>>=20
>>> IBM CI has reported a kernel OOPs while running TPM2selftests on IBM =
Power11 system with linux-next20251002 kernel.
>>>=20
>>>=20
>>> Test Case:
>>>=20
>>> make run_tests
>>> TAP version 13
>>> 1..3
>>> # timeout set to 600
>>> # selftests: tpm2: test_smoke.sh
>>> # test_read_partial_overwrite (tpm2_tests.SmokeTest) ... ok
>>> # test_read_partial_resp (tpm2_tests.SmokeTest) ... ok
>>> # test_seal_with_auth (tpm2_tests.SmokeTest) ... ok
>>> # test_seal_with_policy (tpm2_tests.SmokeTest) ... ok
>>> # test_seal_with_too_long_auth (tpm2_tests.SmokeTest) ... ok
>>> # test_send_two_cmds (tpm2_tests.SmokeTest) ... ok
>>> # test_too_short_cmd (tpm2_tests.SmokeTest) ... ok
>>> # test_unseal_with_wrong_auth (tpm2_tests.SmokeTest) ... ok
>>> # test_unseal_with_wrong_policy (tpm2_tests.SmokeTest) ... ERROR
>>> #
>>> # =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> # ERROR: test_unseal_with_wrong_policy (tpm2_tests.SmokeTest)
>>> # -----------------------------------------------------
>>>=20
>>>=20
>>> Traces:
>>>=20
>>>=20
>>> [  452.604333] BUG: KASAN: slab-use-after-free in =
tpmrm_release+0x78/0xa8
>>> [  452.604345] Read of size 8 at addr c00000001c650000 by task =
python3/1856
>>> [  452.604353]
>>> [  452.604358] CPU: 24 UID: 0 PID: 1856 Comm: python3 Kdump: loaded =
Not tainted 6.17.0-next-20251003 #1 VOLUNTARY
>>> [  452.604364] Hardware name: IBM,9080-HEX Power11 (architected) =
0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
>>> [  452.604368] Call Trace:
>>> [  452.604370] [c0000000c1867840] [c00000000187ea4c] =
dump_stack_lvl+0x84/0xe8 (unreliable)
>>> [  452.604380] [c0000000c1867870] [c000000000803754] =
print_address_description.constprop.0+0x11c/0x56c
>>> [  452.604388] [c0000000c1867910] [c000000000803c84] =
print_report+0xe0/0x358
>>> [  452.604394] [c0000000c18679e0] [c000000000804124] =
kasan_report+0x128/0x1f4
>>> [  452.604400] [c0000000c1867af0] [c0000000008062b4] =
__asan_load8+0xa8/0xe0
>>> [  452.604406] [c0000000c1867b10] [c000000000f2ec18] =
tpmrm_release+0x78/0xa8
>>> [  452.604412] [c0000000c1867b40] [c0000000008b6a2c] =
__fput+0x21c/0x60c
>>> [  452.604417] [c0000000c1867bc0] [c0000000008ada70] =
sys_close+0x74/0xd0
>>> [  452.604424] [c0000000c1867bf0] [c000000000039270] =
system_call_exception+0x1e0/0x460
>>> [  452.604431] [c0000000c1867e50] [c00000000000d05c] =
system_call_vectored_common+0x15c/0x2ec
>>> [  452.604438] ---- interrupt: 3000 at 0x7fffb7534ab4
>>> [  452.604443] NIP:  00007fffb7534ab4 LR: 00007fffb7534ab4 CTR: =
0000000000000000
>>> [  452.604446] REGS: c0000000c1867e80 TRAP: 3000   Not tainted =
(6.17.0-next-20251003)
>>> [  452.604449] MSR:  800000000280f033 =
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 44284422  XER: 00000000
>>> [  452.604466] IRQMASK: 0
>>> [  452.604466] GPR00: 0000000000000006 00007ffff65d76b0 =
00007fffb7c17700 0000000000000006
>>> [  452.604466] GPR04: 0000000000000000 0000000000000000 =
0000000000000000 0000000000000004
>>> [  452.604466] GPR08: 0000000000000000 0000000000000000 =
0000000000000000 0000000000000000
>>> [  452.604466] GPR12: 0000000000000000 00007fffb7e6b8e0 =
00000000000000a1 00007fffb67acec0
>>> [  452.604466] GPR16: 0000000164032ad0 00007fffb67aceb0 =
00007fffb76f6a90 0000000000000000
>>> [  452.604466] GPR20: 00007fffb6f21850 0000000000000000 =
00007fffb71062c0 0000000164034490
>>> [  452.604466] GPR24: 00007fffb6f2fea0 00007fffb67acea8 =
0000000164032b18 00007fffb7c45b32
>>> [  452.604466] GPR28: 00007fffb7c678e0 00007fffb67aceb8 =
0000000000000006 0000000164034490
>>> [  452.604510] NIP [00007fffb7534ab4] 0x7fffb7534ab4
>>> [  452.604513] LR [00007fffb7534ab4] 0x7fffb7534ab4
>>> [  452.604516] ---- interrupt: 3000
>>> [  452.604518]
>>> [  452.604601] Allocated by task 1856:
>>> [  452.604607]  kasan_save_stack+0x34/0x64
>>> [  452.604614]  kasan_save_track+0x2c/0x50
>>> [  452.604621]  kasan_save_alloc_info+0x58/0x74
>>> [  452.604628]  __kasan_kmalloc+0x12c/0x168
>>> [  452.604635]  __kmalloc_cache_noprof+0x1d8/0x71c
>>> [  452.604643]  tpmrm_open+0x88/0x168
>>> [  452.604649]  chrdev_open+0x1f4/0x484
>>> [  452.604656]  do_dentry_open+0x578/0x9cc
>>> [  452.604663]  vfs_open+0x68/0x23c
>>> [  452.604670]  do_open+0x514/0x74c
>>> [  452.604676]  path_openat+0x16c/0x380
>>> [  452.604682]  do_filp_open+0x104/0x230
>>> [  452.604689]  do_sys_openat2+0xb8/0x154
>>> [  452.604696]  sys_openat+0xcc/0x130
>>> [  452.604703]  system_call_exception+0x1e0/0x460
>>> [  452.604710]  system_call_vectored_common+0x15c/0x2ec
>>> [  452.604718]
>>> [  452.604722] Freed by task 1856:
>>> [  452.604726]  kasan_save_stack+0x34/0x64
>>> [  452.604733]  kasan_save_track+0x2c/0x50
>>> [  452.604739]  __kasan_save_free_info+0x64/0x110
>>> [  452.604747]  __kasan_slab_free+0xb0/0x10c
>>> [  452.604753]  kfree+0x220/0x624
>>> [  452.604760]  tpmrm_release+0x6c/0xa8
>>> [  452.604766]  __fput+0x21c/0x60c
>>> [  452.604772]  sys_close+0x74/0xd0
>>> [  452.604779]  system_call_exception+0x1e0/0x460
>>> [  452.604786]  system_call_vectored_common+0x15c/0x2ec
>>> [  452.604794]
>>> [  452.604797] The buggy address belongs to the object at =
c00000001c650000
>>> [  452.604797]  which belongs to the cache kmalloc-8k of size 8192
>>> [  452.604806] The buggy address is located 0 bytes inside of
>>> [  452.604806]  freed 8192-byte region [c00000001c650000, =
c00000001c652000)
>>> [  452.604815]
>>> [  452.604818] The buggy address belongs to the physical page:
>>> [  452.604824] page: refcount:0 mapcount:0 mapping:0000000000000000 =
index:0xc00000001c644000 pfn:0x1c60
>>> [  452.604833] head: order:3 mapcount:0 entire_mapcount:0 =
nr_pages_mapped:0 pincount:0
>>> [  452.604840] flags: 0x3ffffe00000040(head|node=3D0|zone=3D0| =
lastcpupid=3D0x1fffff)
>>> [  452.604849] page_type: f5(slab)
>>> [  452.604856] raw: 003ffffe00000040 c000000007012300 =
5deadbeef0000122 0000000000000000
>>> [  452.604864] raw: c00000001c644000 000000008020001e =
00000000f5000000 0000000000000000
>>> [  452.604872] head: 003ffffe00000040 c000000007012300 =
5deadbeef0000122 0000000000000000
>>> [  452.604879] head: c00000001c644000 000000008020001e =
00000000f5000000 0000000000000000
>>> [  452.604887] head: 003ffffe00000003 c00c000000071801 =
00000000ffffffff 00000000ffffffff
>>> [  452.604894] head: ffffffffffffffff 0000000000000000 =
00000000ffffffff 0000000000000008
>>> [  452.604900] page dumped because: kasan: bad access detected
>>> [  452.604905]
>>> [  452.604908] Memory state around the buggy address:
>>> [  452.604914]  c00000001c64ff00: fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc fc
>>> [  452.604920]  c00000001c64ff80: fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc fc
>>> [  452.604927] >c00000001c650000: fa fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb
>>> [  452.604933]                    ^
>>> [  452.604937]  c00000001c650080: fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb
>>> [  452.604944]  c00000001c650100: fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb
>>> [  452.604950] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> [  452.604955] Disabling lock debugging due to kernel taint
>>> [  452.604961] Kernel attempted to read user page (770) - exploit =
attempt? (uid: 0)
>>> [  452.604969] BUG: Kernel NULL pointer dereference on read at =
0x00000770
>>> [  452.604975] Faulting instruction address: 0xc0000000002b2e0c
>>> [  452.604982] Oops: Kernel access of bad area, sig: 11 [#1]
>>> [  452.604987] LE PAGE_SIZE=3D64K MMU=3DRadix  SMP NR_CPUS=3D8192 =
NUMA pSeries
>>> [  452.604996] Modules linked in: nft_fib_inet nft_fib_ipv4 =
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 =
nft_reject nft_ct nft_chain_nat nf_nat bonding nf_conntrack tls =
nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink sunrpc =
pseries_rng vmx_crypto fuse ext4 crc16 mbcache jbd2 sd_mod sg ibmvscsi =
ibmveth scsi_transport_srp pseries_wdt
>>> [  452.605073] CPU: 24 UID: 0 PID: 1856 Comm: python3 Kdump: loaded =
Tainted: G    B               6.17.0-next-20251003 #1 VOLUNTARY
>>> [  452.605084] Tainted: [B]=3DBAD_PAGE
>>> [  452.605089] Hardware name: IBM,9080-HEX Power11 (architected) =
0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
>>> [  452.605096] NIP:  c0000000002b2e0c LR: c0000000002b2e08 CTR: =
0000000000000000
>>> [  452.605103] REGS: c0000000c1867820 TRAP: 0300   Tainted: G B      =
 (6.17.0-next-20251003)
>>> [  452.605110] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: =
28284420  XER: 0000000d
>>> [  452.605132] CFAR: c000000000807920 DAR: 0000000000000770 DSISR: =
40000000 IRQMASK: 0
>>> [  452.605132] GPR00: c0000000002b2e08 c0000000c1867ac0 =
c00000000234a500 0000000000000001
>>> [  452.605132] GPR04: 0000000000000008 0000000000000000 =
c0000000002b2e08 0000000000000001
>>> [  452.605132] GPR08: 0000000000000020 0000000000000001 =
0000000000000001 a80e000000000000
>>> [  452.605132] GPR12: c00e0000009b1c8c c000000d0ddeb700 =
0000000000000000 0000000000000000
>>> [  452.605132] GPR16: 0000000000000000 0000000000000000 =
0000000000000000 0000000000000000
>>> [  452.605132] GPR20: 0000000000000008 0000000000000000 =
c000000008202f00 c00000007b9ff620
>>> [  452.605132] GPR24: c00000008a76cb20 c00000008a76cb40 =
c00000008a76cb08 c000000002201e80
>>> [  452.605132] GPR28: c000000061569248 0000000000000770 =
c00000008a76cb00 0000000000000768
>>> [  452.605227] NIP [c0000000002b2e0c] up_read+0x50/0x17c
>>> [  452.605237] LR [c0000000002b2e08] up_read+0x4c/0x17c
>>> [  452.605245] Call Trace:
>>> [  452.605249] [c0000000c1867ac0] [c0000000002b2e08] =
up_read+0x4c/0x17c (unreliable)
>>> [  452.605261] [c0000000c1867b10] [c000000000f2ec28] =
tpmrm_release+0x88/0xa8
>>> [  452.605271] [c0000000c1867b40] [c0000000008b6a2c] =
__fput+0x21c/0x60c
>>> [  452.605280] [c0000000c1867bc0] [c0000000008ada70] =
sys_close+0x74/0xd0
>>> [  452.605291] [c0000000c1867bf0] [c000000000039270] =
system_call_exception+0x1e0/0x460
>>> [  452.605301] [c0000000c1867e50] [c00000000000d05c] =
system_call_vectored_common+0x15c/0x2ec
>>> [  452.605312] ---- interrupt: 3000 at 0x7fffb7534ab4
>>> [  452.605319] NIP:  00007fffb7534ab4 LR: 00007fffb7534ab4 CTR: =
0000000000000000
>>> [  452.605326] REGS: c0000000c1867e80 TRAP: 3000   Tainted: G B      =
 (6.17.0-next-20251003)
>>> [  452.605333] MSR:  800000000280f033 =
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 44284422  XER: 00000000
>>> [  452.605362] IRQMASK: 0
>>> [  452.605362] GPR00: 0000000000000006 00007ffff65d76b0 =
00007fffb7c17700 0000000000000006
>>> [  452.605362] GPR04: 0000000000000000 0000000000000000 =
0000000000000000 0000000000000004
>>> [  452.605362] GPR08: 0000000000000000 0000000000000000 =
0000000000000000 0000000000000000
>>> [  452.605362] GPR12: 0000000000000000 00007fffb7e6b8e0 =
00000000000000a1 00007fffb67acec0
>>> [  452.605362] GPR16: 0000000164032ad0 00007fffb67aceb0 =
00007fffb76f6a90 0000000000000000
>>> [  452.605362] GPR20: 00007fffb6f21850 0000000000000000 =
00007fffb71062c0 0000000164034490
>>> [  452.605362] GPR24: 00007fffb6f2fea0 00007fffb67acea8 =
0000000164032b18 00007fffb7c45b32
>>> [  452.605362] GPR28: 00007fffb7c678e0 00007fffb67aceb8 =
0000000000000006 0000000164034490
>>> [  452.605450] NIP [00007fffb7534ab4] 0x7fffb7534ab4
>>> [  452.605456] LR [00007fffb7534ab4] 0x7fffb7534ab4
>>> [  452.605462] ---- interrupt: 3000
>>> [  452.605467] Code: fbc1fff0 7c7f1b78 f8010010 f821ffb1 e92d0c78 =
f9210028 39200000 3ba30008 38800008 7fa3eb78 48554af5 60000000 =
<ebdf0008> eb8d0908 7bc90764 fbc10020
>>> [  452.605501] ---[ end trace 0000000000000000 ]---
>>> [  452.613685] pstore: backend (nvram) writing error (-1)
>>> [  452.613691]
>>>=20
>>>=20
>> Git bisect is pointing to eb28a2adba0654878bcfd909b429bf567b35922b as =
first bad commit.
>=20
> Should be fixed by the following change ?
>=20
> diff --git a/drivers/char/tpm/tpmrm-dev.c =
b/drivers/char/tpm/tpmrm-dev.c
> index 13322dd9ac9e0..334b3ec2b36a5 100644
> --- a/drivers/char/tpm/tpmrm-dev.c
> +++ b/drivers/char/tpm/tpmrm-dev.c
> @@ -54,8 +54,8 @@ static int tpmrm_release(struct inode *inode, struct =
file *file)
>=20
> tpm_common_release(file, fpriv);
> tpm2_del_space(fpriv->chip, &priv->space);
> - kfree(priv);
> up_read(&fpriv->chip->open_lock);
> + kfree(priv);
>=20
> return 0;
> }

Thanks for the fix. It fixes reported issue.

Please add below tag also, while sending out the patch.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,
Venkat.
>=20
>=20
>> eb28a2adba0654878bcfd909b429bf567b35922b is the first bad commit
>> commit eb28a2adba0654878bcfd909b429bf567b35922b
>> Author: Jonathan McDowell <noodles@meta.com>
>> Date:   Tue Sep 23 18:10:00 2025 +0100
>>     tpm: Ensure exclusive userspace access when using /dev/tpm<n>
>>     There is an is_open lock on /dev/tpm<n> that dates back to at =
least
>>     2013, but it only prevents multiple accesses via *this* =
interface. It is
>>     perfectly possible for userspace to use /dev/tpmrm<n>, or the =
kernel to
>>     use the internal interfaces, to access the TPM. For tooling =
expecting
>>     exclusive access, such as firmware updates, this can cause =
issues.
>>     Close the userspace loophole by changing the simple bit lock to a =
full
>>     read/write mutex. Direct /dev/tpm<n> access needs an exclusive =
write
>>     lock, the resource broker continues to allow concurrent access =
*except*
>>     when /dev/tpm<n> is open.
>>     Signed-off-by: Jonathan McDowell <noodles@meta.com>
>>     Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>>     Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>>  drivers/char/tpm/tpm-chip.c  |  1 +
>>  drivers/char/tpm/tpm-dev.c   | 14 ++++++++------
>>  drivers/char/tpm/tpmrm-dev.c | 20 ++++++++++++++++++--
>>  include/linux/tpm.h          |  3 ++-
>>  4 files changed, 29 insertions(+), 9 deletions(-)
>> Git bisect log:
>> git bisect log
>> git bisect start
>> # status: waiting for both good and bad commits
>> # good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
>> git bisect good e5f0a698b34ed76002dc5cff3804a61c80233a7a
>> # status: waiting for bad commit, 1 good commit known
>> # bad: [47a8d4b89844f5974f634b4189a39d5ccbacd81c] Add linux-next =
specific files for 20251003
>> git bisect bad 47a8d4b89844f5974f634b4189a39d5ccbacd81c
>> # good: [f79e772258df311c2cb21594ca0996318e720d28] Merge tag 'media/ =
v6.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux- =
media
>> git bisect good f79e772258df311c2cb21594ca0996318e720d28
>> # good: [6bda5a67f6a2ae4c0153e693e96bd408d054c732] Merge branch =
'xtensa- for-next' of https://eur01.safelinks.protection.outlook.com/? =
url=3Dhttps%3A%2F%2Fgithub.com%2Fjcmvbkbc%2Flinux- =
xtensa.git&data=3D05%7C02%7Cchristophe.leroy2%40cs- =
soprasteria.com%7C18e20b6baa664009b66c08de05b37367%7C8b87af7d86474dc78df45=
f69a2011bb5%7C0%7C0%7C638954465485179363%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0e=
U1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjo=
yfQ%3D%3D%7C0%7C%7C%7C&sdata=3D0Y%2BuK%2B%2BkZRoXNH%2FK4Ni4hd3RVZJmX8c2Sqo=
Ld40qq2Q%3D&reserved=3D0
>> git bisect good 6bda5a67f6a2ae4c0153e693e96bd408d054c732
>> # bad: [09026363ffabf7bb33e0ce000d8bff3e41b0c3de] Merge branch 'next' =
of =
https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.ke=
rnel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fpcmoore%2Faudit.git&data=3D0=
5%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C18e20b6baa664009b66c08de=
05b37367%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638954465485205361%7=
CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJ=
XaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DXuvSxtgtEAP=
Pm3jl6X02nRyTfSh0EXMCUorpI21Y6Cs%3D&reserved=3D0
>> git bisect bad 09026363ffabf7bb33e0ce000d8bff3e41b0c3de
>> # good: [c32d529ea3e39ba4918f3865ef90ef6bddaa498c] Merge branch 'for- =
next' of =
https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.ke=
rnel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fhid%2Fhid.git&data=3D05%7C02=
%7Cchristophe.leroy2%40cs-soprasteria.com%7C18e20b6baa664009b66c08de05b373=
67%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638954465485215132%7CUnkno=
wn%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zM=
iIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DeOflHx6SriPsE%2FE=
wEURKIEzRciXVlmsDJ7F%2F1tTJVtk%3D&reserved=3D0
>> git bisect good c32d529ea3e39ba4918f3865ef90ef6bddaa498c
>> # good: [3fa51882336f09d1a8a03edf107ef43e3b872fc1] Merge branch =
'next' of =
https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.ke=
rnel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fiwlwifi%2Fiwlwifi-next.git&d=
ata=3D05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C18e20b6baa664009b=
66c08de05b37367%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C6389544654852=
23439%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIs=
IlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dkf7T=
2nWCNZ3zKqCl%2FFyIMWoWDqerBMMJJmwEDC3dldo%3D&reserved=3D0
>> git bisect good 3fa51882336f09d1a8a03edf107ef43e3b872fc1
>> # good: [acc26ceeebaa1880ceb70379abb3fac92d1007d5] Merge branch =
'drm-xe- next' of =
https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab=
.freedesktop.org%2Fdrm%2Fxe%2Fkernel.git&data=3D05%7C02%7Cchristophe.leroy=
2%40cs-soprasteria.com%7C18e20b6baa664009b66c08de05b37367%7C8b87af7d86474d=
c78df45f69a2011bb5%7C0%7C0%7C638954465485231891%7CUnknown%7CTWFpbGZsb3d8ey=
JFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIs=
IldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DrAhIU15LaLZVLiCngMMd%2FD8WZFNbBbxlqb=
95l4ZqN3E%3D&reserved=3D0
>> git bisect good acc26ceeebaa1880ceb70379abb3fac92d1007d5
>> # good: [3e06c10cef8079782836155d66c2a91798600cfc] Merge branch 'for- =
next' of =
https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.ke=
rnel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fdevice-mapper%2Flinux-dm.git=
&data=3D05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C18e20b6baa66400=
9b66c08de05b37367%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C63895446548=
5239888%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMC=
IsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D96=
H7h%2FqU8AOA6BMX3gRIqFvbwree0RrwBKFiyAbbWqw%3D&reserved=3D0
>> git bisect good 3e06c10cef8079782836155d66c2a91798600cfc
>> # bad: [cf305bb4070bef42cea469a6c4e751a63f5cacf2] Merge branch 'next' =
of =
https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.ke=
rnel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fjarkko%2Flinux-tpmdd.git&dat=
a=3D05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C18e20b6baa664009b66=
c08de05b37367%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638954465485248=
529%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIl=
AiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DaYTIA0=
7yF9iCvHBin54NcH7%2Bhcn4wpuUR1%2BCGncndKQ%3D&reserved=3D0
>> git bisect bad cf305bb4070bef42cea469a6c4e751a63f5cacf2
>> # good: [19766d4984c39d75393d22cbdad14974cb7f9366] Merge branch =
'next' of https://eur01.safelinks.protection.outlook.com/? =
url=3Dhttps%3A%2F%2Fgithub.com%2Fcschaufler%2Fsmack- =
next&data=3D05%7C02%7Cchristophe.leroy2%40cs- =
soprasteria.com%7C18e20b6baa664009b66c08de05b37367%7C8b87af7d86474dc78df45=
f69a2011bb5%7C0%7C0%7C638954465485256294%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0e=
U1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjo=
yfQ%3D%3D%7C0%7C%7C%7C&sdata=3DSAfMhKzF9h2YURPEqPu6ze2oIUJ87TNyRIFC%2B1JjW=
GE%3D&reserved=3D0
>> git bisect good 19766d4984c39d75393d22cbdad14974cb7f9366
>> # good: [4e349e68974e71da13d4b34988f795f4cfe29650] tpm: use a map for =
tpm2_calc_ordinal_duration()
>> git bisect good 4e349e68974e71da13d4b34988f795f4cfe29650
>> # bad: [b6889908d493fe03a1db28aa9afdade6bceda158] tpm: Allow for =
exclusive TPM access when using /dev/tpm<n>
>> git bisect bad b6889908d493fe03a1db28aa9afdade6bceda158
>> # bad: [eb28a2adba0654878bcfd909b429bf567b35922b] tpm: Ensure =
exclusive userspace access when using /dev/tpm<n>
>> git bisect bad eb28a2adba0654878bcfd909b429bf567b35922b
>> # good: [11baa7201b1baefd281e5a7faf7de5b7e407364c] tpm: Prevent local =
DOS via tpm/tpm0/ppi/*operations
>> git bisect good 11baa7201b1baefd281e5a7faf7de5b7e407364c
>> # first bad commit: [eb28a2adba0654878bcfd909b429bf567b35922b] tpm: =
Ensure exclusive userspace access when using /dev/tpm<n>
>>>=20
>>> If you happen to fix this, please add below tag.
>>>=20
>>>=20
>>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>>=20
>>>=20
>>> Regards,
>>>=20
>>> Venkat.



