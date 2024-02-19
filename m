Return-Path: <linux-kselftest+bounces-4924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFDC85A058
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 10:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE524281BCC
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 09:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F46324A1C;
	Mon, 19 Feb 2024 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YyUfmviw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ECE2376D;
	Mon, 19 Feb 2024 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336577; cv=none; b=V28HpdasAt2Bgbjj+qxrHhMvcbH4Jvle4OwR+WrzWvZpS6AJe6IbmQnp+0KxBQOOPf8MiXYe+rzSdD4FvIkrxyhEfyPlyXxE/DJBckt1HwdZpZUTdoEGJjcdt+VJ2RynBPjLk9tDQlEg8msSaTYjSjIjtnYdYSEogsL1jasN0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336577; c=relaxed/simple;
	bh=2nyB8T+iXscwt/64Gp8yWn/0MYu6ga9UjkgpF7d0iiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppWjKSI65Eg3CDtfQNnP48DdKOCW/H1OWL8Gz69fBZ+T0zWJhY7W19W4YadeocOQKA8PGpve9hKnbLybmpRki4J9goip518T/W7sj/6jF/N/QAqWVighTBaNFDoH9njCLu15JnCQp7J9VoRg7qCw+gbSP6VPc1Yit2pk6mqtdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YyUfmviw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41J8EMtg006585;
	Mon, 19 Feb 2024 09:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=sEF3BR3j5CI5oIwhgA17thDvzyqbnINjyAe6Jfq9dE0=;
 b=YyUfmviwzaySs6roGwlinGEymsCZhu+OBV4BYSZ3YZd2xZG9h+IloBwISVIF1AQ6Y+Dd
 OXvk9KmrQTNxUt9aZ3+Qtcq2jSdV48JptVP5xJbjS93SsfMi4G9ZQuH0Fuh6gFZPOeRN
 obGwIheCv1znB1fkZ6JaQnimLQLDgs1aiivoNM0LR+n5dwW71qzlA7LgmMmzAf/vZATb
 PbFMm5Fkxe4WEW6kw46rO8A1rjftoliXnSwC2wOGmCxmDubRQFAKV0Ad+6b3tYBPpMO/
 MB9JKi6L1WcC31zg0ekjr96ptop4IfxnngEbRrJW7q+ED++tuHaj8KTppsNcuH1LzQVr Og== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wb2p8d0ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 09:56:06 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41J9u6rk030041;
	Mon, 19 Feb 2024 09:56:06 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wb2p8cyxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 09:56:06 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41J8GpfD009583;
	Mon, 19 Feb 2024 09:51:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84p0cnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 09:51:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41J9pRhS19792556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 09:51:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 843E52004B;
	Mon, 19 Feb 2024 09:51:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D691A20043;
	Mon, 19 Feb 2024 09:51:26 +0000 (GMT)
Received: from osiris (unknown [9.171.27.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 19 Feb 2024 09:51:26 +0000 (GMT)
Date: Mon, 19 Feb 2024 10:51:25 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Eric Farman <farman@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/2] KVM: s390: fix access register usage in ioctls
Message-ID: <20240219095125.16287-A-hca@linux.ibm.com>
References: <20240216213616.3819805-1-farman@linux.ibm.com>
 <20240216213616.3819805-2-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216213616.3819805-2-farman@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fKrwOyR9pRPZeF4Tdm_R3lhUAjFktFA_
X-Proofpoint-GUID: TXWfuKj9RrWVJkjr0tAAHLfd2nTX1U-4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_07,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=675 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190074

On Fri, Feb 16, 2024 at 10:36:15PM +0100, Eric Farman wrote:
> The routine ar_translation() can be reached by both the instruction
> intercept path (where the access registers had been loaded with the
> guest register contents), and the MEM_OP ioctls (which hadn't).
> Since this routine saves the current registers to vcpu->run,
> this routine erroneously saves host registers into the guest space.
> 
> Introduce a boolean in the kvm_vcpu_arch struct to indicate whether
> the registers contain guest contents. If they do (the instruction
> intercept path), the save can be performed and the AR translation
> is done just as it is today. If they don't (the MEM_OP path), the
> AR can be read from vcpu->run without stashing the current contents.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 1 +
>  arch/s390/kvm/gaccess.c          | 3 ++-
>  arch/s390/kvm/kvm-s390.c         | 3 +++
>  3 files changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

