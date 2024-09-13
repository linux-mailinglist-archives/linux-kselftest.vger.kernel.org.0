Return-Path: <linux-kselftest+bounces-17954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5648978624
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 18:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5565C1F25A0E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 16:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3066B8C11;
	Fri, 13 Sep 2024 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e/pUwrOV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6AA2F24;
	Fri, 13 Sep 2024 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246101; cv=none; b=Jr7f/5kzPFycABj2sLqfWTPitgmK07w+aQWC9cZmGubyGUGqtCN6hSWAiLCNCbPsK/4tYFzdrm9bl1aP/BkttQmd5ANSKEerOxrlB5Wv5XxhcVckMx3tgudgT5uQbe+t/n3GfIsfWrr9aopLdv0uap9cUf4Fw1DaeCq5jPO3WDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246101; c=relaxed/simple;
	bh=ZwF8ETPKvqKaK+P8O736nlAA5Nyj44s/IlN4CwhVTno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fc+mhf1z5obo31OfmYGI6fWxWV5BDmsWwUm1Notg8Qc7l2G8flvN+Ad09LSvVPK1Z/MggiA9oeH1fMus6iFs8/uRMas1GahtGUAVBqlZE1+U1qKIGLiYUkBMTomI4JWW7pf2nHNjL+Mwhs1H7vn0ZSgm42CsoeeNxniPh/dQwA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e/pUwrOV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DGBYOY014574;
	Fri, 13 Sep 2024 16:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	T+zoDRxA2zWjojSloQf96YaxC6A15cv21sTavDzKElU=; b=e/pUwrOV9crL6RXv
	Hiatneam46SMQ5sPVq5mEpMi/LHpqh2yk8JpBmB5blo29MUb8TSzkt5XYg9pyNZJ
	j2aw8+CdfqNm2IDv7GMqUdVUJ5+VcOPBvq2/sB3odUQWwsCj6p436TKoTILyqEF0
	vMmOZkuGIBytodcG093eNDt/kTBcfSXG6n6FnBEYN65NA4CBy7H5WbFM2KyFJmsG
	FxMfNUuQ7f5kOmI9BQZnGNtght5U87Xw8VNp5NCmNhYU/G0xbCRVhDLxG0qiVmtk
	ONSKAgYS5DVmEe/d6BMKVuMQGZZ8AobkiZEH1/2Ce2IpDCjRS0zD8aoAiF2gojfn
	6wFl4A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41geg0340n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 16:48:09 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48DGm8Xt025207;
	Fri, 13 Sep 2024 16:48:08 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41geg0340j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 16:48:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48DFepDv013465;
	Fri, 13 Sep 2024 16:48:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3cmq7d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 16:48:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48DGm4YM29819486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 16:48:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B354220043;
	Fri, 13 Sep 2024 16:48:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B6A220040;
	Fri, 13 Sep 2024 16:48:04 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Sep 2024 16:48:04 +0000 (GMT)
Date: Fri, 13 Sep 2024 18:48:02 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christoph Schlameuss <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah
 Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand
 <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] selftests: kvm: s390: Add uc_map_unmap VM test
 case
Message-ID: <20240913184802.3365e253@p-imbrenda>
In-Reply-To: <20240913115248.211071-2-schlameuss@linux.ibm.com>
References: <20240913115248.211071-1-schlameuss@linux.ibm.com>
	<20240913115248.211071-2-schlameuss@linux.ibm.com>
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
X-Proofpoint-GUID: XaA7VJMyPzolCF2jJdZdGcJpDoT-1evt
X-Proofpoint-ORIG-GUID: 4Kh--M2BIEzrNmKnxgiNoIb8Dyv_e8vW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=942 priorityscore=1501
 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130117

On Fri, 13 Sep 2024 13:52:46 +0200
Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:

> Add a test case verifying basic running and interaction of ucontrol VMs.
> Fill the segment and page tables for allocated memory and map memory on
> first access.
> 
> * uc_map_unmap
>   Store and load data to mapped and unmapped memory and use pic segment
>   translation handling to map memory on access.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>  .../selftests/kvm/s390x/ucontrol_test.c       | 145 +++++++++++++++++-
>  1 file changed, 144 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> index 030c59010fe1..084cea02c2fa 100644
> --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c

[...]

>base_gpa + self->code_gpa;
> @@ -222,6 +244,60 @@ TEST(uc_cap_hpage)
>  	close(kvm_fd);
>  }
>  
> +/* calculate host virtual addr from guest physical addr */
> +static void *gpa2hva(FIXTURE_DATA(uc_kvm) * self, u64 gpa)

why the space? I would have expected *self

> +{
> +	return (void *)(self->base_hva - self->base_gpa + gpa);
> +}
> +
> +/* map / make additional memory available */

[...]

