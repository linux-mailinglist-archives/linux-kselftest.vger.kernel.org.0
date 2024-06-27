Return-Path: <linux-kselftest+bounces-12869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1442091AC65
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 18:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44DD01C220F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 16:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E008199E8A;
	Thu, 27 Jun 2024 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jWuuQLEj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CB919938C;
	Thu, 27 Jun 2024 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719504921; cv=none; b=cc4J4I9hUkG8G+Mktdmi8+w33BjWXTJdcRwKKJNGqAu55V7IwFVkLFpsyBosmPhuAZBC+QH/8oNWlkLVvmLURq+mFpPwIv9PoYcI3DJmEkS8EiaiPdZeziJsTYmdLO1mD9YVRvH90Bg9ZW0wuVeMqoWI7e6RFc8dujAiD7w7YV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719504921; c=relaxed/simple;
	bh=CDA54h0hWnLUGhTZX+zKgbXuYHV9KPWv43ZxtZveg8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=BtJW2N2xcVENsGeQbtwmbnVr7agiK97rg58K6cTLyuchPM9/8YaC8GKB/PHltIYIh0yMMG4pRJWKzhyHTa4h5PXAaArjw7vy5ReRrMTds0rRdkckTEGAQ+nBFjt2M/e2PVVB8ClB5MonWUR+0DPrGw9x3lAZH7Rlphi8q7qHWj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jWuuQLEj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45REuSjO019530;
	Thu, 27 Jun 2024 16:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=pp1; bh=1/BkFzRrzEfYPMmdOD5/4JC3K9
	WTbsso5dhAT+3LruU=; b=jWuuQLEjGfDF4VxF6OEZb2vYCY63ZENahB9D1jFnGe
	N2Rs1Sj/RLbF7irFXcWGkHzxceVjfmKhTsqrqsLp2GtZqIA1XMzebH2igA6k6/MI
	NTt4L7jNWFwqP0uaCRBZYz0+/jNnmra8nHLMbWYtEWsOUILqhWgErhqxHX1fPAW9
	roeP2PdWNafPOeE7BwSKgvxtyIufyy35YNj1AtIL9eGJVi2SoybK9LPgonj+E0H8
	R/fkB1PzrC62BuuHy0nEz2vqhdWzOCiNl8lSfvZU2k2u0sMo0eaiXjRyBSUiN+cg
	96YyD9pfgatkmpAvT8H3bQpcqag3jFJhzQIydw1gGMjA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400yaw1w9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 16:15:17 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45RGFHsN013469;
	Thu, 27 Jun 2024 16:15:17 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400yaw1w9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 16:15:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45REUQA1018103;
	Thu, 27 Jun 2024 16:15:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yx8xukugw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 16:15:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45RGFAHi38076726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 16:15:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D9442004E;
	Thu, 27 Jun 2024 16:15:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A5E42004D;
	Thu, 27 Jun 2024 16:15:10 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Jun 2024 16:15:10 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Yunseong Kim <yskelg@gmail.com>
Cc: Akanksha J N <akanksha@linux.ibm.com>,
        "Naveen N. Rao"
 <naveen.n.rao@linux.vnet.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        MichelleJin
 <shjy180909@gmail.com>, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: selftests/ftrace kprobe_eventname test fails on s390x QEMU
 (KVM/Linux)
In-Reply-To: <1add7a0a-f91d-4249-9632-424505597e45@gmail.com> (Yunseong Kim's
	message of "Thu, 27 Jun 2024 14:03:14 +0900")
References: <1add7a0a-f91d-4249-9632-424505597e45@gmail.com>
Date: Thu, 27 Jun 2024 18:15:10 +0200
Message-ID: <yt9dsewy746p.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LYnnZLIcyY3OFaiaYL_hgWz4e_d8nqrO
X-Proofpoint-GUID: wZ4mcCmB0kjLnm1tDifpTMLA_u79RN1r
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_12,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 clxscore=1011 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270121

Yunseong Kim <yskelg@gmail.com> writes:

> In my s390x archtecture, kprobe_eventname selftest have always failed
> because of rcu_sched stalls.
>
> My environment is QEMU Ubuntu 24.04 KVM Machine Linux version
> 6.8.0-36-generic (buildd@bos01-s390x-012) (s390x-linux-gnu-gcc-13
> (Ubuntu 13.2.0-23ubuntu4) 13.2.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #36
>
> 1 configured CPUs, Linux is running under KVM in 64-bit mode
>
>
>  qemu-system-s390x -no-reboot -name auto-inst-test -nographic -m 4096 \
>    -drive file=disk-image.qcow2,format=qcow2,cache=none,if=virtio \
>    -netdev user,id=enc0,hostfwd=tcp::10000-:22 \
>    -device virtio-net-ccw,netdev=enc0 \
>    -qmp tcp:localhost:4444,server,nowait
>
>
> Currently, This failure can be always reproduced by this kselftests script:
>
>  # tools/testing/selftests/ftrace/ftracetest
> tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
>
> I've investigating cause of line, then I find this line.
>
>  for i in `seq 0 255`; do
>    echo p $FUNCTION_FORK+${i} >> kprobe_events || continue
>  done

I think this is fixed with:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.10-rc5&id=c239c83ed5c558be3b5926c7f11639f02c8acd00

Regards,
Sven

