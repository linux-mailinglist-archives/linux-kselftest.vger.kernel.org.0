Return-Path: <linux-kselftest+bounces-48922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31497D1E7F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 12:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31F6C3015D11
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 11:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B92392B97;
	Wed, 14 Jan 2026 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jg5Fy0rA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF852765C4;
	Wed, 14 Jan 2026 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768391158; cv=none; b=syufqEzm5tXCn0cNUOAzPpLhcXBOBW6uvNxU6IQJ8paD78lE8vbcTIlv4IYC6QrY1T2fteRFFZTNzjKlauWu0P7DszAfEBSDAz1oFCikP3roBFtNk73wvk7ShDCNZFSd1sgEoyfWjGfwN04GOP1Gv4xe0nbEMVDY+cPAYGxgVpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768391158; c=relaxed/simple;
	bh=VPDDaMaEHjsdK1Mh3+JWo2WxY0i7D5Nz7nDz8gXXB1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGPOAsk1G0zkj2/EKb5zTz/B5HZO2DS8ce0l+xtZCowUCZhI+CIi8tfroB6f9YWnA6o67D82vaK/B2VS8zgqa4/gjsrXipZNPUD2AyDKNul06K0oXdpsSJvKizamY/6gNt744f1bMoviiyaxtx0opscx3oEO41HyWa8Fhg/PD9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jg5Fy0rA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60E4cFPg019307;
	Wed, 14 Jan 2026 11:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=WV+OWYKEIVeMcpz1svAZC+IJRhC6pnf54j2kmIgVQ
	fw=; b=Jg5Fy0rAniaLYbbY6ZRRtdLCi2fylyvGfGpHsxruXs4/VhtW3XzQAfLET
	LEjcREENkYWRHas7aZoG9ICZKli9Y+AJnOJojUKo8HXqnSl/v50WnGzWvmIdrHCM
	YUIg1b6K687UJKHmafOtkhAZ5/+PNwpB89UK+MRRVwvr/3gCwqLUwA+QKXeyetlf
	iPWPw2KJbt1SMLf0EbH9S0W+0XWRrddEAuijptV2yJKVDJMTj64ILCBIRT658tXe
	K87/bqpnSi6B39AP5VT/B8X9YFYEmYmbS92Y1FX//eqrWRwHR2n20qXQc3jsJpao
	VdxDxmLC/uuygh3oYQ0tJx5AFOyLw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkd6e8u50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 11:45:16 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60EBjF0w017939;
	Wed, 14 Jan 2026 11:45:15 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkd6e8u4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 11:45:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60E9sj6B002510;
	Wed, 14 Jan 2026 11:45:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm13ssy6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 11:45:14 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60EBjAK551053028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 11:45:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9321D20043;
	Wed, 14 Jan 2026 11:45:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4315A20040;
	Wed, 14 Jan 2026 11:45:04 +0000 (GMT)
Received: from abhi.. (unknown [9.124.217.65])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Jan 2026 11:45:04 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, memxor@gmail.com,
        iii@linux.ibm.com, shuah@kernel.org,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v2 0/6] powerpc64/bpf: Support tailcalls with subprogs & BPF exceptions
Date: Wed, 14 Jan 2026 17:14:44 +0530
Message-ID: <20260114114450.30405-1-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kGNkf1GgfCOKnJIkCrA78MFK8kpOj1iH
X-Authority-Analysis: v=2.4 cv=LLxrgZW9 c=1 sm=1 tr=0 ts=696781cc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=rhI0E6_HooCo6thlJxMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA5MyBTYWx0ZWRfX6/XoNKVkPY0e
 LBgWiiWI4o6p0bjcjTuYZRqkp0vn/5L/xWkZq0iSfRespIykgCtN6V7K6OOaNrzy3EZtD6/XZmz
 QZBkd4+0RBvzy27uticjidmqFpcI9hfbDlScu3/nDJc7o+LZxmT5qouoaW6D0/wps8WiuYNi8Lg
 u11Et8+Siafg6FTlueUSl1+ArAz/qGiitEWLcMYtl4KpEJ1pzzTK7PSZS+bw+SHFOEn/tBjIPX+
 qfKAWRJvi7DwYRGSwyJH1ldm4oeR2arOzbmjq2Il80NVVxBGe1RACZCLc2UX/gVNyh/OUbvq7+C
 uLGP8BI4tDPQ5rwV19UJeMlvkZVeNRBX1MXLkd9j1zoJUlfbC8s+WP3McBCIXBN10A1r07Fbdtc
 vdDbp4PfsEh3YUB3Deh8MlnLtGXQEzCD/nJT3W9cYyLKZSuZSDQDfU+mJPTnKwzAeYTv4M2yo6L
 3o3bhnPJ27FxNDNri4Q==
X-Proofpoint-ORIG-GUID: 6enXm8th8r8d5YXDS4d_YAiTJ1qizIqh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601140093

From: Abhishek Dubey <adubey@linux.ibm.com>

This patch series enables support for two BPF JIT features
on powerpc64. The first three patches target support for
tail calls with subprogram combinations. The first patch
supports realignment of tail_call_cnt offset in stack frame.
Implementation details are provided in the commit messages.

The last three patches add support for BPF exceptions. An
architecture-specific stack walker is implemented to assist
with stack walk during exceptions.

All selftests related to tailcalls and exceptions are passing:

# ./test_progs -t tailcalls
#442/1   tailcalls/tailcall_1:OK
#442/2   tailcalls/tailcall_2:OK
#442/3   tailcalls/tailcall_3:OK
#442/4   tailcalls/tailcall_4:OK
#442/5   tailcalls/tailcall_5:OK
#442/6   tailcalls/tailcall_6:OK
#442/7   tailcalls/tailcall_bpf2bpf_1:OK
#442/8   tailcalls/tailcall_bpf2bpf_2:OK
#442/9   tailcalls/tailcall_bpf2bpf_3:OK
#442/10  tailcalls/tailcall_bpf2bpf_4:OK
#442/11  tailcalls/tailcall_bpf2bpf_5:OK
#442/12  tailcalls/tailcall_bpf2bpf_6:OK
#442/13  tailcalls/tailcall_bpf2bpf_fentry:OK
#442/14  tailcalls/tailcall_bpf2bpf_fexit:OK
#442/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:OK
#442/16  tailcalls/tailcall_bpf2bpf_fentry_entry:OK
#442/17  tailcalls/tailcall_poke:OK
#442/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
#442/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:OK
#442/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:OK
#442/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:OK
#442/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:OK
#442/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
#442/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
#442/25  tailcalls/tailcall_freplace:OK
#442/26  tailcalls/tailcall_bpf2bpf_freplace:OK
#442/27  tailcalls/tailcall_failure:OK
#442/28  tailcalls/reject_tail_call_spin_lock:OK
#442/29  tailcalls/reject_tail_call_rcu_lock:OK
#442/30  tailcalls/reject_tail_call_preempt_lock:OK
#442/31  tailcalls/reject_tail_call_ref:OK
#442     tailcalls:OK
Summary: 1/31 PASSED, 0 SKIPPED, 0 FAILED

# ./test_progs -t exceptions
#105/1   exceptions/exception_throw_always_1:OK
#105/2   exceptions/exception_throw_always_2:OK
#105/3   exceptions/exception_throw_unwind_1:OK
#105/4   exceptions/exception_throw_unwind_2:OK
#105/5   exceptions/exception_throw_default:OK
#105/6   exceptions/exception_throw_default_value:OK
#105/7   exceptions/exception_tail_call:OK
#105/8   exceptions/exception_ext:OK
#105/9   exceptions/exception_ext_mod_cb_runtime:OK
#105/10  exceptions/exception_throw_subprog:OK
#105/11  exceptions/exception_assert_nz_gfunc:OK
#105/12  exceptions/exception_assert_zero_gfunc:OK
#105/13  exceptions/exception_assert_neg_gfunc:OK
#105/14  exceptions/exception_assert_pos_gfunc:OK
#105/15  exceptions/exception_assert_negeq_gfunc:OK
#105/16  exceptions/exception_assert_poseq_gfunc:OK
#105/17  exceptions/exception_assert_nz_gfunc_with:OK
#105/18  exceptions/exception_assert_zero_gfunc_with:OK
#105/19  exceptions/exception_assert_neg_gfunc_with:OK
#105/20  exceptions/exception_assert_pos_gfunc_with:OK
#105/21  exceptions/exception_assert_negeq_gfunc_with:OK
#105/22  exceptions/exception_assert_poseq_gfunc_with:OK
#105/23  exceptions/exception_bad_assert_nz_gfunc:OK
#105/24  exceptions/exception_bad_assert_zero_gfunc:OK
#105/25  exceptions/exception_bad_assert_neg_gfunc:OK
#105/26  exceptions/exception_bad_assert_pos_gfunc:OK
#105/27  exceptions/exception_bad_assert_negeq_gfunc:OK
#105/28  exceptions/exception_bad_assert_poseq_gfunc:OK
#105/29  exceptions/exception_bad_assert_nz_gfunc_with:OK
#105/30  exceptions/exception_bad_assert_zero_gfunc_with:OK
#105/31  exceptions/exception_bad_assert_neg_gfunc_with:OK
#105/32  exceptions/exception_bad_assert_pos_gfunc_with:OK
#105/33  exceptions/exception_bad_assert_negeq_gfunc_with:OK
#105/34  exceptions/exception_bad_assert_poseq_gfunc_with:OK
#105/35  exceptions/exception_assert_range:OK
#105/36  exceptions/exception_assert_range_with:OK
#105/37  exceptions/exception_bad_assert_range:OK
#105/38  exceptions/exception_bad_assert_range_with:OK
#105/39  exceptions/non-throwing fentry -> exception_cb:OK
#105/40  exceptions/throwing fentry -> exception_cb:OK
#105/41  exceptions/non-throwing fexit -> exception_cb:OK
#105/42  exceptions/throwing fexit -> exception_cb:OK
#105/43  exceptions/throwing extension (with custom cb) -> exception_cb:OK
#105/44  exceptions/throwing extension -> global func in exception_cb:OK
#105/45  exceptions/exception_ext_mod_cb_runtime:OK
#105/46  exceptions/throwing extension (with custom cb) -> global func in exception_cb:OK
#105/47  exceptions/exception_ext:OK
#105/48  exceptions/non-throwing fentry -> non-throwing subprog:OK
#105/49  exceptions/throwing fentry -> non-throwing subprog:OK
#105/50  exceptions/non-throwing fentry -> throwing subprog:OK
#105/51  exceptions/throwing fentry -> throwing subprog:OK
#105/52  exceptions/non-throwing fexit -> non-throwing subprog:OK
#105/53  exceptions/throwing fexit -> non-throwing subprog:OK
#105/54  exceptions/non-throwing fexit -> throwing subprog:OK
#105/55  exceptions/throwing fexit -> throwing subprog:OK
#105/56  exceptions/non-throwing fmod_ret -> non-throwing subprog:OK
#105/57  exceptions/non-throwing fmod_ret -> non-throwing global subprog:OK
#105/58  exceptions/non-throwing extension -> non-throwing subprog:OK
#105/59  exceptions/non-throwing extension -> throwing subprog:OK
#105/60  exceptions/non-throwing extension -> non-throwing subprog:OK
#105/61  exceptions/non-throwing extension -> throwing global subprog:OK
#105/62  exceptions/throwing extension -> throwing global subprog:OK
#105/63  exceptions/throwing extension -> non-throwing global subprog:OK
#105/64  exceptions/non-throwing extension -> main subprog:OK
#105/65  exceptions/throwing extension -> main subprog:OK
#105/66  exceptions/reject_exception_cb_type_1:OK
#105/67  exceptions/reject_exception_cb_type_2:OK
#105/68  exceptions/reject_exception_cb_type_3:OK
#105/69  exceptions/reject_exception_cb_type_4:OK
#105/70  exceptions/reject_async_callback_throw:OK
#105/71  exceptions/reject_with_lock:OK
#105/72  exceptions/reject_subprog_with_lock:OK
#105/73  exceptions/reject_with_rcu_read_lock:OK
#105/74  exceptions/reject_subprog_with_rcu_read_lock:OK
#105/75  exceptions/reject_with_rbtree_add_throw:OK
#105/76  exceptions/reject_with_reference:OK
#105/77  exceptions/reject_with_cb_reference:OK
#105/78  exceptions/reject_with_cb:OK
#105/79  exceptions/reject_with_subprog_reference:OK
#105/80  exceptions/reject_throwing_exception_cb:OK
#105/81  exceptions/reject_exception_cb_call_global_func:OK
#105/82  exceptions/reject_exception_cb_call_static_func:OK
#105/83  exceptions/reject_multiple_exception_cb:OK
#105/84  exceptions/reject_exception_throw_cb:OK
#105/85  exceptions/reject_exception_throw_cb_diff:OK
#105/86  exceptions/reject_set_exception_cb_bad_ret1:OK
#105/87  exceptions/reject_set_exception_cb_bad_ret2:OK
#105/88  exceptions/check_assert_eq_int_min:OK
#105/89  exceptions/check_assert_eq_int_max:OK
#105/90  exceptions/check_assert_eq_zero:OK
#105/91  exceptions/check_assert_eq_llong_min:OK
#105/92  exceptions/check_assert_eq_llong_max:OK
#105/93  exceptions/check_assert_lt_pos:OK
#105/94  exceptions/check_assert_lt_zero:OK
#105/95  exceptions/check_assert_lt_neg:OK
#105/96  exceptions/check_assert_le_pos:OK
#105/97  exceptions/check_assert_le_zero:OK
#105/98  exceptions/check_assert_le_neg:OK
#105/99  exceptions/check_assert_gt_pos:OK
#105/100 exceptions/check_assert_gt_zero:OK
#105/101 exceptions/check_assert_gt_neg:OK
#105/102 exceptions/check_assert_ge_pos:OK
#105/103 exceptions/check_assert_ge_zero:OK
#105/104 exceptions/check_assert_ge_neg:OK
#105/105 exceptions/check_assert_range_s64:OK
#105/106 exceptions/check_assert_range_u64:OK
#105/107 exceptions/check_assert_single_range_s64:OK
#105/108 exceptions/check_assert_single_range_u64:OK
#105/109 exceptions/check_assert_generic:OK
#105/110 exceptions/check_assert_with_return:OK
#105     exceptions:OK
Summary: 1/110 PASSED, 0 SKIPPED, 0 FAILED

[v1]: https://lore.kernel.org/all/20260105105212.136645-1-adubey@linux.ibm.com/

Changes v1->v2:
        Move tail_call_cnt to offset 0 in stack frame
        Remove trampoline NVR remapping-patch3/6[v1]

Abhishek Dubey (6):
  powerpc64/bpf: Move tail_call_cnt to bottom of stack frame
  powerpc64/bpf: Support tailcalls with subprogs
  powerpc64/bpf: Tailcall handling with trampolines
  powerpc64/bpf: Add arch_bpf_stack_walk() for BPF JIT
  powerpc64/bpf: Support exceptions
  powerpc64/bpf: Additional NVR handling for bpf_throw

 arch/powerpc/net/bpf_jit.h        |  18 ++-
 arch/powerpc/net/bpf_jit_comp.c   |  98 ++++++++----
 arch/powerpc/net/bpf_jit_comp64.c | 240 ++++++++++++++++++++++++------
 3 files changed, 280 insertions(+), 76 deletions(-)

-- 
2.48.1


