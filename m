Return-Path: <linux-kselftest+bounces-20495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A159AD13F
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 18:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D7C1C20DF0
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 16:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AC21CB535;
	Wed, 23 Oct 2024 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G3Ak+LEm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE4F1C9DFD;
	Wed, 23 Oct 2024 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729701810; cv=none; b=CvGzxYQmyPGdxofV2Qqje6cBqNPuJI654ALkVhPFURsfAtW2uj0NU56KS/SjJLblF/QyLeRWcn+TT6gRAlu47tyr1UiwLAwkcl8Za7SYWHe6GGU6j0Itt+OSlEQP//NHinzCx4aDn4xhgrf+vkwWdbnMfoKzXKQOeQFqKtnEbIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729701810; c=relaxed/simple;
	bh=vTR8hPLJtJyzypZ9ySnInbc9SOcpqdfoy1ZdIzD5No0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HbPMxVLnQTLair2eYYQdcmA7W+8FtitkCNf4V2qIYy320mezxkGDNVjBbzbpu3FIjm4jqiCbwYxy3WDDXaGK6iA9zCpsB3x+dUUbmsKXZ0mlbqhYkgSR5HRpiet7bloWha3NmGGJjmcGoBkZq8/pECJ7u5ZEaTWG7Pg46jkaW0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G3Ak+LEm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NF586Y018131;
	Wed, 23 Oct 2024 16:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=3P9+nc0XM0sZChW/3I1/7+Tx1jvhKrl/0O8BLOpRrX0=; b=G3Ak+LEm
	IxaLStPftg8/FzHagdZLBypkG2IxusC+cAw3PLwNHGVqHrGXR3H5w1xytEIlj0Y5
	6CxTXp8pgqkIuY+5UslQDPRwU7pX84t3F8+WlcRTrYWtTbYsy5Lj3MBjtmvqANs/
	kkniNF3s1/VqmNTzF4wZLOevgTIUr3W7biyVSj84jUwbPutTcbPhyaRGqLYTDZpf
	dWdv1qKLSQcryBlaif0oql4VmQxLOuvEjknKKEVIkYeS8a95pBsl0TwQeZ6aNqS0
	KRfzzbguW2CJbJiBRSUEkw60V3k+FhotZDdh0+igbb4Bv3C0zdmPt9lWA/XICPbv
	3sVoJP661SCeHg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emadv42h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 16:43:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFT7gS008851;
	Wed, 23 Oct 2024 16:43:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emkakte0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 16:43:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49NGhMk154722824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:43:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3C9720043;
	Wed, 23 Oct 2024 16:43:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD6A720040;
	Wed, 23 Oct 2024 16:43:21 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.211.29])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Oct 2024 16:43:21 +0000 (GMT)
Date: Wed, 23 Oct 2024 22:13:19 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: tj@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: selftests/sched_ext: enq_last_no_enq_fails testcase fails
Message-ID: <Zxknp7RAVNjmdJSc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 591Op6k61QPYL67VIV-E8TKWhA--J1DC
X-Proofpoint-GUID: 591Op6k61QPYL67VIV-E8TKWhA--J1DC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=910 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230102

Hi,

===== START =====
TEST: enq_last_no_enq_fails
DESCRIPTION: Verify we fail to load a scheduler if we specify the SCX_OPS_ENQ_LAST flag without defining ops.enqueue()
OUTPUT:
ERR: enq_last_no_enq_fails.c:35
Incorrectly succeeded in to attaching scheduler
not ok 2 enq_last_no_enq_fails #
=====  END  =====


Above selftest fails even when BPF scheduler is not loaded into the kernel. 

Below is snippet from the dmesg verifing bpf program was not loaded:
sched_ext: enq_last_no_enq_fails: SCX_OPS_ENQ_LAST requires ops.enqueue() to be implemented
   scx_ops_enable.isra.0+0xde8/0xe30
   bpf_struct_ops_link_create+0x1ac/0x240
   link_create+0x178/0x400
   __sys_bpf+0x7ac/0xd50
   sys_bpf+0x2c/0x70
   system_call_exception+0x148/0x310
   system_call_vectored_common+0x15c/0x2ec
sched_ext: "enq_select_cpu_fails" does not implement cgroup cpu.weight
sched_ext: BPF scheduler "enq_select_cpu_fails" enabled
sched_ext: BPF scheduler "enq_select_cpu_fails" disabled (runtime error)



static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
{
...
         ret = validate_ops(ops);
          if (ret)
                  goto err_disable;
...
  err_disable:
          mutex_unlock(&scx_ops_enable_mutex);
          /*
           * Returning an error code here would not pass all the error information
           * to userspace. Record errno using scx_ops_error() for cases
           * scx_ops_error() wasn't already invoked and exit indicating success so
           * that the error is notified through ops.exit() with all the details.
           *
           * Flush scx_ops_disable_work to ensure that error is reported before
           * init completion.
           */
          scx_ops_error("scx_ops_enable() failed (%d)", ret);
          kthread_flush_work(&scx_ops_disable_work);
          return 0;
  }

validate_ops() correctly reports the error, but err_disable path ultimately
returns with a value of zero

from: enq_last_no_enq_fails.c
static enum scx_test_status run(void *ctx)
{
        struct enq_last_no_enq_fails *skel = ctx;
        struct bpf_link *link;

        link = bpf_map__attach_struct_ops(skel->maps.enq_last_no_enq_fails_ops);
        if (link) {
                SCX_ERR("Incorrectly succeeded in to attaching scheduler");
                return SCX_TEST_FAIL;
        }

        bpf_link__destroy(link);

        return SCX_TEST_PASS;
}



