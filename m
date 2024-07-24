Return-Path: <linux-kselftest+bounces-14156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8013093B480
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 18:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF0C4B22DD7
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4633F15B554;
	Wed, 24 Jul 2024 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UxeOLKNo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD99B5336B;
	Wed, 24 Jul 2024 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837255; cv=none; b=JcYSSP1TJHcYw+i8UbK2vvYbv89vEjVJlGk+vsm6yzEeF3OCPKR8kpSq5fkOGY3LLohOVbYUeWX88hDntrRpheTKvczN8hwPWgp0qpz+Nl+OfJLHcNeuc1RyDkd9M719ztEbe0OujqHmWOHSAWkfZj70fe/MZ1RB+tyVuknQRk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837255; c=relaxed/simple;
	bh=R11c7PQtEVi66A+QE33uLi7Y93ezm0Dbp8NwV2s8FVc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZiHfw0K9pbu3/7lgcUjyZHqxRobMwZHNs/JE8EsGulV4j+m0Cva5r5RKhFtra7VnWk7SXGOrbslP2+E5Q/1YDtosJkhaAm+PlH8fhy76AlKXM2QHuHovu91BB1EULdF0FdYnu/d4if7nImoiRSFtv9gvFqeNXXeJ1evmChYu54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UxeOLKNo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OFU9Ei021083;
	Wed, 24 Jul 2024 16:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	4dJjK6vN2+yI9YITqzlpdMdXVVN4oNs9S20bCberJII=; b=UxeOLKNoRWbwMctw
	cJUDCCN19/x5FeUGIOMRauEUd40Qh1V3SIHMfKmPOWfsOmfDgy5yCb0SbG1tPdWy
	ZsmsXsswuYumtyOEb22LRoUjVfe+UGajQWpkFzTjR2vHdEVu2PqMYTcqJ0/CsosL
	Z70HrVw4aklNBEhwidszG3oal3Xi+tluAya9WfqMw2SDlEWfXjauBi/k91JX5pQG
	iIaxNOVBLhCifLBTee0Uet6PI9uhUvYb5vBH7Y43ZDamdVMn+xylo7njk+sHF1nK
	yhvT/DUHpr967kvwMiJp3l8Urt+73MUxYtIPQetKaZ9qCQMziaFf5uOTZlxUH/De
	qtZY9g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40k49w854p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 16:07:24 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46OG7NG6027664;
	Wed, 24 Jul 2024 16:07:24 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40k49w854j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 16:07:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46OF62Ud006227;
	Wed, 24 Jul 2024 16:07:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gqjuj5dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 16:07:22 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46OG7H8w29819560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 16:07:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5217E2004B;
	Wed, 24 Jul 2024 16:07:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE28020040;
	Wed, 24 Jul 2024 16:07:16 +0000 (GMT)
Received: from darkmoore (unknown [9.171.89.145])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 24 Jul 2024 16:07:16 +0000 (GMT)
Date: Wed, 24 Jul 2024 18:07:14 +0200
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah
 Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand
 <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PATCH v2 02/10] selftests: kvm: s390: Add kvm_s390_sie_block
 definition for userspace tests
Message-ID: <20240724180714.13a571c1.schlameuss@linux.ibm.com>
In-Reply-To: <8ce4cef5-1516-4e49-be2a-a185848fd639@linux.ibm.com>
References: <20240723093126.285319-1-schlameuss@linux.ibm.com>
	<20240723093126.285319-3-schlameuss@linux.ibm.com>
	<8ce4cef5-1516-4e49-be2a-a185848fd639@linux.ibm.com>
Organization: IBM
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QJNTkwLYcIp9w1Ie0Rb9sPR1v-CcstSs
X-Proofpoint-ORIG-GUID: s7dLTnH7nkChVM4Njo2xy4w_hd4GrFCc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_15,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=668 mlxscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240115

On Wed, 24 Jul 2024 16:39:28 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 7/23/24 11:31, Christoph Schlameuss wrote:
> > Subsequent tests do require direct manipulation of the SIE instruction.
> > This commit introduces the SIE definition for the selftests.  
> 
> AFAIK ucontrol doesn't allow to manipulate the instruction, it allows 
> manipulation of the *SIE control block* that's handed over as an operand 
> to SIE.
> 

I will clarify that.

Christoph

> > 
> > There are already definitions of this within the kernel.
> > This differs in two ways.
> > * This is the first definition of this in userspace.
> > * This does not require atomicity for the flags.
> > 
> > With the userspace definition of the SIE block layout now being present
> > we can reuse the values in other tests where applicable.
> > 
> > Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>  
> 
> Code looks fine though.


