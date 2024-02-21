Return-Path: <linux-kselftest+bounces-5157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4BF85D6CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 12:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A9B1F22C7D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 11:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0344F3EA94;
	Wed, 21 Feb 2024 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aTPplzcF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1457028363;
	Wed, 21 Feb 2024 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514775; cv=none; b=iLXbmZUWhzoo+NfSylsNbxlnn6hVZe7NOi8m6uWxg0xnSCXHMpkBHPm+oYu6DJo1gu94vBjyqwRwmZcyMcPX9oRJcshkVy/QOpELLYAd+fdhaR+zIV+lHHAC89LD5yLyre+qfmZBDaqN0c87fAVSoSk1fHRNKQk10ZhcnXgrh8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514775; c=relaxed/simple;
	bh=dzV35kleisbWwPCZ+Ij6zPbPxfFNr0jJrkAuC8C3SeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFOnQNHZfISm0BuU1ndlNCosz92Jmw8Tnm5wFKfcxbrq3mDZDDOOj0nkWjkRkGdF6VJ90WbHRm3KCAqJEyBQxgwjjz8ZTqcfJWhAsGq24d4dF4CKK4dlslhH/8nAbnokIpCsM+Z7yxRTPGapBvZiNLwz5uWCUlbKOS2SD7jx0rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aTPplzcF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LB81xs008711;
	Wed, 21 Feb 2024 11:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=N9YmyLG40yaJjx1JWdzsXngF3Fgq/tPKFgXMZBCqznQ=;
 b=aTPplzcFEQZ4A3pyEDuP++afLpU3Tbo8NF5wmxUU9oKFqcl6/bpGIG5j6VqlN3RvhGU8
 bbR1kRQyli0ZvcCneRy/8wcuAcI9xtOjYG0lJLeFrnqWebObgbadPvEBDwvI1YDyM5zQ
 AedbXpAPuWSiCHxaIA2Tr12U0mO2sDKMPtajmNp/38rBKnTdi044zmg6maW1P7xxBHl8
 M6J4l47+ZFQSTX4xqUB+b6/qU0b23y7Z8rwriYqdozTktTk3DAD44P7IMpz1vmNnL3kq
 Ir7C241L4VljR5LZjUNB7sCf58id6gCaieyWJbkb5sS9U03ZiKkCJjhU9gHajnwrpqqh tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wdg1cgbwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 11:26:09 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41LB8Tb4009815;
	Wed, 21 Feb 2024 11:26:09 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wdg1cgbwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 11:26:08 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41LAVBrg014390;
	Wed, 21 Feb 2024 11:26:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9u2p5y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 11:26:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41LBQ23m14877290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 11:26:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A18A92004B;
	Wed, 21 Feb 2024 11:26:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DCFD20040;
	Wed, 21 Feb 2024 11:26:02 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 21 Feb 2024 11:26:02 +0000 (GMT)
Date: Wed, 21 Feb 2024 12:26:00 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/2] KVM: s390: Fix AR parameter in ioctl
Message-ID: <20240221112600.7561-B-hca@linux.ibm.com>
References: <20240220211211.3102609-1-farman@linux.ibm.com>
 <bbe1db67-386b-4738-83d5-6e02cd3c9d58@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbe1db67-386b-4738-83d5-6e02cd3c9d58@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uy7JRYCGIKeInksjV0lawtPxRzvStjlc
X-Proofpoint-GUID: qX4IFO9sAQviitnW0vZ_SVskpXacIfXf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=743 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402210087

On Wed, Feb 21, 2024 at 08:49:58AM +0100, Janosch Frank wrote:
> On 2/20/24 22:12, Eric Farman wrote:
> > Hi Janosch,
> > 
> > Here is a new (final?) version for the AR/MEM_OP issue I'm attempting to
> > address. Hopefully they can be picked up to whatever tree makes sense.
> > 
> 
> I've got good and bad news for you :)
> 
> You need to re-base this patch set on Heiko's feature branch once my kvm fpu
> patch is on there since the current version runs into conflicts with Heiko's
> fpu rework. We'll contact you once that's the case. The patch made it onto
> devel yesterday evening and I assumed you'd wait a bit until sending a new
> version but I was mistaken.

I resolved the trivial merge conflict - no need to resend anything.

Series applied, thanks!

