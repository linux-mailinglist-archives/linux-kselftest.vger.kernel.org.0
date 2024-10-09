Return-Path: <linux-kselftest+bounces-19324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CB3996222
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 10:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86FD4B21214
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 08:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F989188018;
	Wed,  9 Oct 2024 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ci3GN5jv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246E2184527;
	Wed,  9 Oct 2024 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461631; cv=none; b=kCT8Oea85QZDMvC1MpM1nLyDY4tRg7BitFZcILPgzTt5soH/KbPfpp5+5kuoIiGNjbZPz41ud0MR9Eq6WbBIhYWQIaB0gOZ0KvG5OeroTy/4R0/2wFNa/oWu4bR3Efgdmz7km8HMENBCTvnYYsTnvDQ2+i5AfcU7J/IHcYSdvtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461631; c=relaxed/simple;
	bh=f6d7lgrwfYcRDM65UbGeCYQR78jrZRuF6h8qJxLJvXE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=KqLZ3+wc5qTqRnF92KLy2XAKHnpFbQ+T9pqr60STHZgUUboDBbCop9aDuFePRmncC2/YbInpVuIMDJXtQKJgz/fhMI+rzNZUxWk0TlniZZuc1AWn7FzGxy1DaYAlHA8Bik+sbttmciK3lulPQ0IIXEdKxExmX7A1sQfZU9oASXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ci3GN5jv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4997FZfw016997;
	Wed, 9 Oct 2024 08:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	mime-version:content-transfer-encoding:content-type:date
	:message-id:from:cc:to:subject:references:in-reply-to; s=pp1;
	 bh=f6d7lgrwfYcRDM65UbGeCYQR78jrZRuF6h8qJxLJvXE=; b=Ci3GN5jvq3sf
	YwAjnTgQTb+mZARuZ5KnItTu9xmv6i8BtIHV5aAQB+hM8PUGztmjpSGRlf8UzfX4
	rSF1Nr5IH5DIJ71SYcTX2VLWYN2VZwL0UIdGHOBG4VAFQzRgOcyvszggtYJbR71e
	IIcBUiX6w+doejgHop0vRXQqbu3ofPPrSi8P8JsPjtjfcNYEnwaHO7QNJ9lSCTGc
	lOVTw2S7nVpkJgucG2d1AoNM2NwJrYWo2It1GdSyjQmYUFsXzsVgJxDAOIWez6zm
	K28RhV4WtzdLrP9SWl9b8luqP3dI1NC36lG/+OvsfzC7NZ4d+kBjJluWM1EKsI4g
	btuKffxBkQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 425n9f07sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 08:13:40 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4998Dd8Z028079;
	Wed, 9 Oct 2024 08:13:39 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 425n9f07sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 08:13:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49955krc010718;
	Wed, 9 Oct 2024 08:13:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 423j0jgh0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 08:13:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4998DZcX55050732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Oct 2024 08:13:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62BB920043;
	Wed,  9 Oct 2024 08:13:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4166720040;
	Wed,  9 Oct 2024 08:13:35 +0000 (GMT)
Received: from darkmoore (unknown [9.171.80.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Oct 2024 08:13:35 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Oct 2024 10:13:29 +0200
Message-Id: <D4R4I5P8CF25.3BEXWSI95E0XO@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        "Paolo
 Bonzini" <pbonzini@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        "Christian
 Borntraeger" <borntraeger@linux.ibm.com>,
        "Claudio Imbrenda"
 <imbrenda@linux.ibm.com>,
        "David Hildenbrand" <david@redhat.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v5 3/4] selftests: kvm: s390: Verify reject memory
 region operations for ucontrol VMs
X-Mailer: aerc 0.18.2
References: <20241008074253.370481-1-schlameuss@linux.ibm.com>
 <20241008074253.370481-4-schlameuss@linux.ibm.com>
 <fbed12b9-a6fb-4258-9ece-cee1b8559d92@linux.ibm.com>
 <f084bbf5-2109-4424-b1c1-217b4246a1b6@linux.ibm.com>
In-Reply-To: <f084bbf5-2109-4424-b1c1-217b4246a1b6@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m0QDaTWYnudSHKr-c1Khxt3c3IejioZA
X-Proofpoint-ORIG-GUID: MxTx6zj1t8a8f6lZ02giSOdU890aeDcZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_06,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=464 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410090053

On Tue Oct 8, 2024 at 3:03 PM CEST, Janosch Frank wrote:
> On 10/8/24 2:56 PM, Janosch Frank wrote:
> > On 10/8/24 9:42 AM, Christoph Schlameuss wrote:
> >> Add a test case verifying KVM_SET_USER_MEMORY_REGION and
> >> KVM_SET_USER_MEMORY_REGION2 cannot be executed on ucontrol VMs.
> >>
> >> Executing this test case on not patched kernels will cause a null
> >> pointer dereference in the host kernel.
> >> This is fixed with commit:
> >> commit 7816e58967d0 ("kvm: s390: Reject memory region operations for u=
control VMs")
> >=20
> > I'm going to remove the "commit" prefix from the line above when pickin=
g.
> >=20
>
> Argh, just found out that this is a checkpatch enforced style...
> Alright then.

Yes, sadly I did not find a way here so that checkstyle is completely happy=
 with
this :/

