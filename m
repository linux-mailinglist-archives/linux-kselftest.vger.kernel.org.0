Return-Path: <linux-kselftest+bounces-41277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51579B5414F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 05:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3D9AA11AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 03:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B4826FA54;
	Fri, 12 Sep 2025 03:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LX0Sr5GC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE73B26E6E2;
	Fri, 12 Sep 2025 03:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757649420; cv=none; b=PHiiTF3UEO/rQJSLWP1gSM2M+fiMRj0WFczppsKnEOnzjDqsFHKbt0Y0ccbaqaxVl2Rgj28CdnnyPqqgY0IYA0ZFuO0IMO/nu00zGGdr6vIVpLh1dHDlbhFG6heTm6pNjhzzx8UxMhWCtq12myEb0uxIYxTIMbhAVFDOqype4qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757649420; c=relaxed/simple;
	bh=ZbrmobRaTPjafpy6SyOGVwCIKw1DRN30UH3X6lZ4kN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDwTuA+ojo0TMFSXhJh8tgJvNWFOY9T2IKUZYToccikWN7PJLlyUVxs48E5jTQ//2LOUFjkHf8BRClFTz18fkUYPV5j7a/jQd1AMJlr2pwwMySPPC973Wwb4iyecscfM6nnE4Qws1FlLPNfe8ZTL81t39vd/TUpLIwXqyDwfdCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LX0Sr5GC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BMC9vx020534;
	Fri, 12 Sep 2025 03:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PrHogM
	U41dlBVB//0xF9JvxaxOCwljW7x6kJLn9nQ3g=; b=LX0Sr5GCZbMVn/g+LauJIY
	qL6OwuSBv7xy68rFOqL6BX2anRbsl8ixWcqZzLcHgXyyq5OicCeghLiYAhGIl1I5
	Y/OlJcGZyf1BTKBGSsPeGVEQ8g2BF63NsMObLR+YmPfchdJ6HV5cKxclzU1YxOmF
	UQpY9inLGM15XuQbIoUVLhcceF0gYh7rBxdE6OTofNLlatA+yzR0tMbziKFLeV3X
	e05Y0P5NJBkOxyQDnYhNvS9f8Z68YI0M98sqxS8qq7qG/dbWv69ao9U6loRrEZUH
	g8q7FzgcfVMw81Woj8KGC7fYnOTruhZheRxL7RPQnCIYPjaEKpAiL1is4Trxe2Ng
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx9013-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:56:26 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58C3t4vJ023762;
	Fri, 12 Sep 2025 03:56:25 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx900x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:56:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1ifaZ007895;
	Fri, 12 Sep 2025 03:56:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109q11e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:56:24 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58C3uKn456230360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 03:56:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B8FA2004B;
	Fri, 12 Sep 2025 03:56:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEBF520040;
	Fri, 12 Sep 2025 03:56:13 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.in.ibm.com (unknown [9.98.111.108])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Sep 2025 03:56:13 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, naveen@kernel.org, mpe@ellerman.id.au,
        npiggin@gmail.com, memxor@gmail.com, iii@linux.ibm.com,
        shuah@kernel.org
Subject: Re: [PATCH bpf-next v3 0/4] powerpc64/bpf: Add support for bpf arena and arena atomics
Date: Fri, 12 Sep 2025 09:26:12 +0530
Message-ID: <175764920910.610338.6618492148160203933.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250904100835.1100423-1-skb99@linux.ibm.com>
References: <20250904100835.1100423-1-skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RZT36PBqIzol4GxpIGDrRZZfvntecn7l
X-Proofpoint-ORIG-GUID: CCQzVuEKXN62e_0pPcEIHssxkogmdAnM
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c399ea cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=PIuWED_YQay8gXFd4KMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfXxCDChkiMf+hS
 OMWFchcLm2q4tXL4Yzv9pYOwuZJxO/WnLI4dHsPxfmnA9Mb9SU/jBdfHnQJxcTZRGaYDlxMt0w1
 fx0mkII9CB7aGcJRL0JQZkGKd9Jqx6ZXlWjjNfdGgyYDF1DAwZgMIwadryP3D8LGcrz+cUJy2Np
 4qhHx4nwvE22E/l8vrzjofrlce4jfIiJcOr1TlMwdvldfOfJg+A4umyT3lbjLvXWkdqF0NerwkE
 HLmKUV+67QzYHQhORLdzrnGWhft3l84uevjHaLYxCfNCw2uYXFyEOmu7qogOIFtRU+DwxX2h1kH
 IHK2WRuoZeKq3mUKdmcAxrtptkmTB+yPXTJZFIUDC/gF7ueJZL9CrywrUjlp5FgTVWPTLh5eC0J
 7W4RXILw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

On Thu, 04 Sep 2025 15:38:31 +0530, Saket Kumar Bhaskar wrote:
> This patch series introduces support for the PROBE_MEM32,
> bpf_addr_space_cast and PROBE_ATOMIC instructions in the powerpc BPF JIT,
> facilitating the implementation of BPF arena and arena atomics.
> 
> All selftests related to bpf_arena, bpf_arena_atomic(except
> load_acquire/store_release) enablement are passing:
> 
> [...]

Applied to powerpc/next.

[1/4] powerpc64/bpf: Implement PROBE_MEM32 pseudo instructions
      https://git.kernel.org/powerpc/c/47c7f3b7038787ee42cb9ed69825e6790dba9410
[2/4] powerpc64/bpf: Implement bpf_addr_space_cast instruction
      https://git.kernel.org/powerpc/c/a2485d06cad3741303b9414e44f9b6d76d3713f2
[3/4] powerpc64/bpf: Introduce bpf_jit_emit_atomic_ops() to emit atomic instructions
      https://git.kernel.org/powerpc/c/45ed2e8b0591eb6211d79f436f76c3af31e626af
[4/4] powerpc64/bpf: Implement PROBE_ATOMIC instructions
      https://git.kernel.org/powerpc/c/0c1da35b0188dd565cec907a16cb5d1bd425e0e4

Thanks

