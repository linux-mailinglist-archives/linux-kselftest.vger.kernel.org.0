Return-Path: <linux-kselftest+bounces-5158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C7485D753
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 12:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88447B22113
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 11:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D5941740;
	Wed, 21 Feb 2024 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c6fEb7CJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E7E4122C;
	Wed, 21 Feb 2024 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515825; cv=none; b=VLTnQqW72n8YeUaBqcA1bXIexbsNOy9poMeVocdjbBHcyxfpcK2K7b460gNXwVUY4mEbXGmX700fZJUumffjnJ8el1wLyhf0LqzVe0u/lfmzbMEDny2nPTMLjNs9f/TFNaPnDRL9U1NgBAkzB6Svoce3kb4uwlKefxjfCn2FSXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515825; c=relaxed/simple;
	bh=IRRpfo0N2xcpSAdFSoJMt3sPGsOjRi/HyC7JiD918Sw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uHMJE3dn0SDmpy3GlmOMMWnFknZyj9UlQPf4u8DK8nKU89GIoSh9AXqIA59TGX1GwtlhisGsJi7UaDU91Ix3M1I8+hOKJFhUZ4qF14c6LDEA1/bCXTzzFMBvxfda65gBbKofsXxbCvGuMg+YWX4NU93vgRyMWjnT9/4NtAyTILs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c6fEb7CJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41L9rmFQ016405;
	Wed, 21 Feb 2024 11:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=IRRpfo0N2xcpSAdFSoJMt3sPGsOjRi/HyC7JiD918Sw=;
 b=c6fEb7CJda0YMRN+wjtGagvkXv1nu4pE3gXXj09cV2bQiDQ9Tjo5SsSerlVgZUoAZrNN
 czmhKrc7ZaX2YTcnnkUUobB4zMtwF4VZOvksEhj2ZLDu5ZE3C6aE3O/uaY3UrkZkB+H1
 ZFB/xa74tyYpNrfNI8LiuuU+h+jGYJtD8C78QfHtUi80Y463bTr5ur4/Pf6dzUFKAwcu
 jTph9JDQe0GJyk1PZkOsndFGq7f/NeZshRShftL+b/rugG4iGTjmScs0Uru329RtdXT7
 s25eI07DwLsI5CvJ+Mcij2v/wR6lvvwI4tZDRK08FUEO5HdhW1/Kfi7DcF3JBg8AQUng nw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wddp24jgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 11:43:41 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41LBRLKd028277;
	Wed, 21 Feb 2024 11:43:41 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wddp24jg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 11:43:41 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41LAKJGo031138;
	Wed, 21 Feb 2024 11:43:40 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9bkxcbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 11:43:40 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41LBhaJw18416160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 11:43:38 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9223158057;
	Wed, 21 Feb 2024 11:43:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DD885805D;
	Wed, 21 Feb 2024 11:43:35 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.61.38.214])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Feb 2024 11:43:35 +0000 (GMT)
Message-ID: <8c170301bf02a3889ca3c3f79ac48ee961217f41.camel@linux.ibm.com>
Subject: Re: [PATCH v4 0/2] KVM: s390: Fix AR parameter in ioctl
From: Eric Farman <farman@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda
 <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Date: Wed, 21 Feb 2024 06:43:35 -0500
In-Reply-To: <20240221112600.7561-B-hca@linux.ibm.com>
References: <20240220211211.3102609-1-farman@linux.ibm.com>
	 <bbe1db67-386b-4738-83d5-6e02cd3c9d58@linux.ibm.com>
	 <20240221112600.7561-B-hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uUqJcSllguAw-9crn87dQxGwdDbMDYH3
X-Proofpoint-ORIG-GUID: KyexTtdirze4GxtVktYqdD_j4t7ecKiG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=955 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210090

On Wed, 2024-02-21 at 12:26 +0100, Heiko Carstens wrote:
> On Wed, Feb 21, 2024 at 08:49:58AM +0100, Janosch Frank wrote:
> > On 2/20/24 22:12, Eric Farman wrote:
> > > Hi Janosch,
> > >=20
> > > Here is a new (final?) version for the AR/MEM_OP issue I'm
> > > attempting to
> > > address. Hopefully they can be picked up to whatever tree makes
> > > sense.
> > >=20
> >=20
> > I've got good and bad news for you :)
> >=20
> > You need to re-base this patch set on Heiko's feature branch once
> > my kvm fpu
> > patch is on there since the current version runs into conflicts
> > with Heiko's
> > fpu rework. We'll contact you once that's the case. The patch made
> > it onto
> > devel yesterday evening and I assumed you'd wait a bit until
> > sending a new
> > version but I was mistaken.
>=20
> I resolved the trivial merge conflict - no need to resend anything.
>=20
> Series applied, thanks!

Ah, sorry about that, I didn't notice the other fpu stuff go through.
Thank you, Heiko!

