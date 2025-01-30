Return-Path: <linux-kselftest+bounces-25422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4844CA22BE8
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 11:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BF016849B
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 10:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2BF1BEF9A;
	Thu, 30 Jan 2025 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pXsco+d6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE1F1BEF91;
	Thu, 30 Jan 2025 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738234161; cv=none; b=kNWLVf9qo2T5QkCmcz5CThltMXH7Oa5e1DiHdarOUz+gRiw2W0JoT6bmvIJrTjeXnpt81bgeZwo7xV1hfpvRlEwHweAEJBk4ZutvGaaQlvLBa5uF/SzJvDGKulf8h/lNFO2f38h8yIcT1InHUZ0sbWnh0vzhCiPyzJOZ87lRRxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738234161; c=relaxed/simple;
	bh=K/7NsZgIrjKsuEex5ZvC88K7F2tkcUpl+oNZ/6zISaM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IdqO/O5Fd91jtqYtKqgKYf3yR28Cin0DVNDVXo+PxNRrh5hFGYtS0Rk/QX3C/zWocQUcoP+SZfME672DnSgz8poQ3ebqW2HhHs6UoXbRn3xLrCDLcWt7Kgc+s7wHx3+CVB4DMllCoSaEuqceEbxjT8u0BPipPLqsZwL5QbSBF/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pXsco+d6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U17pAr028982;
	Thu, 30 Jan 2025 10:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=K/7NsZ
	gIrjKsuEex5ZvC88K7F2tkcUpl+oNZ/6zISaM=; b=pXsco+d6ocPYaR8/WOHSbg
	velSBjxr/03t4VCDPTmYw6mEL1Ch0PZyS5EWZIXktVbtXhWVmw+VNm4Eq+rV2Mw/
	MoOsaUYDug8XAKUxDrsIXYpdq/j3FmHgo2hx2E7VntWCw22j9YYEh+yG0ZakMiHH
	ayKrbo3ccmcF/+P5B8m6h4NXZINJUGCohMVS9j/Fy5yXQVrN4WQfQiLqIkdaW9OF
	9mxvv2YcJ98DKGgKYgJjdv6q6YTMxZ4904QgUWnhZohRNQwXDjDswqIGLMHV3O5P
	F8N1xk5FLdD+XRE/j01cEicQX7t9WB+49kC1jDm9ht29AfBZRQceUWJbQjkfUlQg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fyg9a6uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 10:48:51 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50UAUAum030383;
	Thu, 30 Jan 2025 10:48:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fyg9a6uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 10:48:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50U71YNx012476;
	Thu, 30 Jan 2025 10:48:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44danydvb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 10:48:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50UAmlQo27263592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 10:48:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4E91200BD;
	Thu, 30 Jan 2025 10:48:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B47CC200BB;
	Thu, 30 Jan 2025 10:48:46 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown [9.171.93.188])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 30 Jan 2025 10:48:46 +0000 (GMT)
From: "Marc Hartmayer" <mhartmay@linux.ibm.com>
To: Daniel Xu <dxu@dxuuu.xyz>, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: shuah@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 4/5] bpf: verifier: Support eliding map
 lookup nullness
In-Reply-To: <f7rhmwrp3fgx3qd7gn3pzczxeztvsg45u4vrl6ls3ylcvflapx@3yi3shfnrmb3>
References: <cover.1736886479.git.dxu@dxuuu.xyz>
 <68f3ea96ff3809a87e502a11a4bd30177fc5823e.1736886479.git.dxu@dxuuu.xyz>
 <78b2e750b4568e294b5fc5a33cf4bc8f62fae7f6.camel@linux.ibm.com>
 <hsgmutuoi4kvjkr7erm5ty2fdrhdrjpz4fpp5doe65l3pzguxv@lcbmvmjpyykq>
 <f7rhmwrp3fgx3qd7gn3pzczxeztvsg45u4vrl6ls3ylcvflapx@3yi3shfnrmb3>
Date: Thu, 30 Jan 2025 11:48:45 +0100
Message-ID: <87v7twk25u.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rbcTz21OcV-kXIN5hrfaK2av094Ai-Fz
X-Proofpoint-GUID: JJk2nesWaLPlyEjwN1he4ky6oOUdvs_l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=800
 priorityscore=1501 suspectscore=0 spamscore=0 mlxscore=0 malwarescore=0
 clxscore=1011 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501300081

On Wed, Jan 29, 2025 at 10:45 AM -0700, Daniel Xu <dxu@dxuuu.xyz> wrote:
> On Wed, Jan 29, 2025 at 09:49:12AM -0700, Daniel Xu wrote:
>> Hi Ilya,
>>=20

[=E2=80=A6snip=E2=80=A6]

>
> I cribbed the source from [0] and tested before and after. I think this
> should work. Mind giving it a try?

Hi Daniel,

thanks for the fix! I=E2=80=99ve tested the fix and it fixed the problem.

Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>

[=E2=80=A6snip=E2=80=A6]

