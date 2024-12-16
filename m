Return-Path: <linux-kselftest+bounces-23413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23709F3111
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 14:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17E416363F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 13:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11122204C02;
	Mon, 16 Dec 2024 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EBijulku"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558F91FF7B0;
	Mon, 16 Dec 2024 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734354106; cv=none; b=c1/5BYX2vU/PIszIHyxNXMYf4/eij5HPhnRW/rtqGWShR5qi4nKrDKUx7lPfRaZgSYuXfKfuVEYp3h7Wd91LmQzh3lr9wSy6d5u1zugLet3l2Fi7YRhsaW58gAYMegspOAF6/IcLfdM1OUpStlCvkCEBNRwF1TVGuuD26zSLc1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734354106; c=relaxed/simple;
	bh=OiSOwvAMfV++1rE2sZ1BGHeU0ogM8VACM0mzRBJJUJs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OCbPFUzIt6G6Du4TTq76AtTJMGpAoOJEFIcGOut1fcJ5gxLZCnLdrmdcfY0ZtfkdA0KZ183Xm37I/5DMSt8UjiMGgBDYkVJ2dnr7LjYtAfNzSgwTYygSHliChJu8kDXN5tSMH30DDRypLRit1sHrSPY8T5K5WXp6kcsFSwCN+xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EBijulku; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGBNPfg029846;
	Mon, 16 Dec 2024 13:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=V4lSrq
	dwsAREjYwhtFNMiajU9lP7NFLlPqAcVZTS7PU=; b=EBijulkuFT58PplkAaU0GH
	lkf6iiLBN3HoJQ7PjPJmE/UXZPNZqkn/q28k9OsG7odSI6SPTr+KxM1uYExn/Pkj
	vCSHa/5n/4b4Tq3b55qkyd/YZBI+QxGaDo1JJBjgTTa+ld4CMqie5MxiCjNEvvFS
	53lThrPRkNj7W5VD06yaoP3sC04GSZQ/AGktt8+9tSyWCGKnZKYOqBMmasCtMFF6
	tNkR5UaAX4t+/uiM2cZqO1mbs8Tzui18E78P1QWeufBUanOZyI7cCFHjuzM5jeR9
	SkdwL94CnmOnE9i5/Mie5Gv5NCK1jfJ3gEbJQSr75lKEprP95DsxtgZu3+L7I68A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43j0k4c317-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 13:01:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG8ULED014320;
	Mon, 16 Dec 2024 13:01:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hmqxx342-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 13:01:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BGD1Z0C59113978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 13:01:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F45120040;
	Mon, 16 Dec 2024 13:01:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E495520049;
	Mon, 16 Dec 2024 13:01:34 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Dec 2024 13:01:34 +0000 (GMT)
Date: Mon, 16 Dec 2024 14:01:33 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christoph Schlameuss <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand
 <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan
 <shuah@kernel.org>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Ulrich Weigand
 <ulrich.weigand@de.ibm.com>,
        Dominik Dingel <dingel@linux.vnet.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 0/6] selftests: kvm: s390: Reject invalid ioctls on
 ucontrol VMs
Message-ID: <20241216140133.07bc6104@p-imbrenda>
In-Reply-To: <20241216092140.329196-1-schlameuss@linux.ibm.com>
References: <20241216092140.329196-1-schlameuss@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S7Y8Py567Sr5bTHJtS4RITaUvHZIwmx6
X-Proofpoint-ORIG-GUID: S7Y8Py567Sr5bTHJtS4RITaUvHZIwmx6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxlogscore=939
 clxscore=1015 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412160110

On Mon, 16 Dec 2024 10:21:34 +0100
Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:

> This patch series adds more test case issuing ioctls to ucontrol VMs and
> its floating interrupt controller.
> The test cases trigger three possible null pointer dereferences within
> the handling of the KVM_DEV_FLIC_APF_ENABLE,
> KVM_DEV_FLIC_APF_DISABLE_WAIT and KVM_SET_GSI_ROUTING ioctl.
> 
> All of these issues do only exist on ucontrol VMs. Fixes for the issues
> are included within the patch series.

Whole series:
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> 
> v2:
> - added documentation changes
> - simplify uc_flic_attrs; remove .getrc and .setrc from uc_flic_attrs
> (Thanks Claudio)
> 
> Christoph Schlameuss (6):
>   kvm: s390: Reject setting flic pfault attributes on ucontrol VMs
>   selftests: kvm: s390: Add ucontrol flic attr selftests
>   kvm: s390: Reject KVM_SET_GSI_ROUTING on ucontrol VMs
>   selftests: kvm: s390: Add ucontrol gis routing test
>   selftests: kvm: s390: Streamline uc_skey test to issue iske after sske
>   selftests: kvm: s390: Add has device attr check to uc_attr_mem_limit
>     selftest
> 
>  Documentation/virt/kvm/api.rst                |   3 +
>  Documentation/virt/kvm/devices/s390_flic.rst  |   4 +
>  arch/s390/kvm/interrupt.c                     |   6 +
>  .../selftests/kvm/s390x/ucontrol_test.c       | 194 ++++++++++++++++--
>  4 files changed, 189 insertions(+), 18 deletions(-)
> 


