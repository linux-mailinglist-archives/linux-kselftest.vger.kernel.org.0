Return-Path: <linux-kselftest+bounces-15826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0D9959602
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 09:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E7B1C2189F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 07:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5547F1B81AC;
	Wed, 21 Aug 2024 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y+83ZX7W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6CC1B81AB;
	Wed, 21 Aug 2024 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225043; cv=none; b=rvBfjnM2ikvu9cuhGjVczGzTRc/yzCyb6sUNHuLOaQszdf2AWVQ27WUUSpk9ZYTj2gq4i0uo2SSqs04XNr/4mrvvHB5R2JWQlqXJfF//5O7AKFpkRzMqJlohVsvYFTNYf4mb6Y1LEhJIyjIhdwwRg8mgGhmE6dWZ76LJOp2EzLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225043; c=relaxed/simple;
	bh=cnEJWVJ8NnsybQxHZyKe6VmXNkzwQ3cGuKMpdZ2bW6U=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=JiltoUUpVTegA3P4st6vCWjTXmZxl463yaeyhFuqJW+JUOCcMsbFapbMxoVLw6svIPi7COmtJylL6bmxPzW9wg19BmiVJOZJr5WHrmweO68eUz7Vl8ZAs02T00v0jPkPR31AjNvXqCWyQkvD64pSuBEFk39OF0rs24HW/UArH6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y+83ZX7W; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L6IhAg001337;
	Wed, 21 Aug 2024 07:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	mime-version:content-transfer-encoding:content-type:date
	:message-id:from:cc:to:subject:references:in-reply-to; s=pp1;
	 bh=U9tyv1NeDTBx+ul5lr2oK3FxePEmwGnI5wqSJxRSf/0=; b=Y+83ZX7Wvov9
	EGyzY6inek5dwCZIMNcdpVhVd6pt+gAd56GZG5LuoR9QrQp89Y3yWlmntmRh7qEo
	Zlkr1ixiKeG0GINHUmcCtEjwMh5vABwPbPNc4fVvI5QgAkx+thcAyJmNlI0zfst8
	KGzBD+eZI9GgRlwjlsqf3kjQ8kpqDsBSpmKzlklFbm9aPlGDtPvwE+XgRDIJIT0L
	L4rgWhl/GVloFX1HWwaLJ//QMWyt4sKwp8CiNtS65sRBGHRj4V6pz4K4pX0fTeo5
	zohdhbSmzTXO9T0XgYOP/pIghOhYxy5qUhdBz6R6tdzv7Pewny7FAwT23Nb3TcmU
	n9J+n2NAjw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mbg0tr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 07:23:58 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47L7JcDi032103;
	Wed, 21 Aug 2024 07:23:57 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mbg0tr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 07:23:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47L6hIpf030060;
	Wed, 21 Aug 2024 07:23:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138dmed98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 07:23:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47L7NpHa44696036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 07:23:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2A8C2005A;
	Wed, 21 Aug 2024 07:23:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEB442004B;
	Wed, 21 Aug 2024 07:23:50 +0000 (GMT)
Received: from darkmoore (unknown [9.171.47.216])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Aug 2024 07:23:50 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Aug 2024 09:23:45 +0200
Message-Id: <D3LERDPJH3X6.11UZMMQUXVTSD@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <shuah@kernel.org>,
        <frankja@linux.ibm.com>, <borntraeger@linux.ibm.com>,
        <imbrenda@linux.ibm.com>, <david@redhat.com>, <pbonzini@redhat.com>
To: "Hariharan Mari" <hari55@linux.ibm.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] KVM: s390: selftests: Add regression tests for
 KMAC, KMC, KM, KIMD and KLMD crypto subfunctions
X-Mailer: aerc 0.17.0
References: <20240820065623.1140399-1-hari55@linux.ibm.com>
 <20240820065623.1140399-5-hari55@linux.ibm.com>
In-Reply-To: <20240820065623.1140399-5-hari55@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RoFii7i-nTyrJxriqR5xCYViWkTFgaJJ
X-Proofpoint-ORIG-GUID: A93MHUTMY9TCp4uJ9ul7hhDlGCF3lGrl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_07,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=797 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408210050

On Tue Aug 20, 2024 at 8:48 AM CEST, Hariharan Mari wrote:
> Extend the existing regression test framework for s390x CPU subfunctions
> to include tests for the KMAC (Compute Message Authentication Code),
> KMC (Cipher Message with Chaining), KM (Cipher Message) KIMD (Compute
> Intermediate Message Digest) and KLMD (Compute Last Message Digest)
> crypto functions.
>
> The test procedure follows the established pattern.
>
> Suggested-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Hariharan Mari <hari55@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

LGTM

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  .../kvm/s390x/cpumodel_subfuncs_test.c        | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)

[...]

