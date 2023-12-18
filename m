Return-Path: <linux-kselftest+bounces-2157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B776381747A
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 15:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41E92B23261
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527383D564;
	Mon, 18 Dec 2023 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VwOE0JWN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BA13A1D3;
	Mon, 18 Dec 2023 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIDlPlk031382;
	Mon, 18 Dec 2023 14:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=1K/ldSBpqvmUpzKM7qL6iZlu4kgIL+gWWCt58O6ZgKM=;
 b=VwOE0JWNROqyj9LOc+TF7Vt9mUQFpVPm1dWu0pLtB9T6JejStF5Av3yB1wL7WBY50q8F
 a1tLbJZC2WvpLYlLYSPqY5PPfDAbysKmuRH5gSk2Xrii2CuZ3IFgUX12oHFfoKxsNKFP
 hl91OlJhY/jz5wsyIVfM9kaxVdd5ZBs8Y1086dAzng0vOBPt4yhn6xaPZssBzCyuQhij
 ZfWqQp3GiKUFg7dUMbYgsciJ0ZE0MVFocaBkpGhyWlZW2GQM07tFNev0UmEvseXJ0rru
 K/nkrlE4aDY2hjNoqfPF/7U+jfF2PY4hBp5bHcItRIykm/Rf3XPU9bKG5sYraWdn7uFH BA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v2q93stwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 14:59:06 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIDmYFI001759;
	Mon, 18 Dec 2023 14:59:06 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v2q93stvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 14:59:05 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIE1JLE027076;
	Mon, 18 Dec 2023 14:59:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v1rejs3n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 14:59:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BIEx2NM41812704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 14:59:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C48020043;
	Mon, 18 Dec 2023 14:59:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9465720040;
	Mon, 18 Dec 2023 14:59:01 +0000 (GMT)
Received: from p-imbrenda (unknown [9.171.92.197])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 18 Dec 2023 14:59:01 +0000 (GMT)
Date: Mon, 18 Dec 2023 15:58:59 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: s390: selftest: memop: Fix undefined behavior
Message-ID: <20231218153358.14acb611@p-imbrenda>
In-Reply-To: <59621e88c5c29bdff8bc06f68b02b2c7a420a09a.camel@linux.ibm.com>
References: <20231215161125.943551-1-nsg@linux.ibm.com>
	<20231215180206.740df738@p-imbrenda>
	<59621e88c5c29bdff8bc06f68b02b2c7a420a09a.camel@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: puXqm3mI9E2kD8Nrm3NTqq7KtU-NhgJB
X-Proofpoint-ORIG-GUID: 6OtjiZE-V-I4wm8dogwuxslZvV8tlwUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=857
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312180109

On Mon, 18 Dec 2023 13:18:14 +0100
Nina Schoetterl-Glausch <nsg@linux.ibm.com> wrote:

[...]

> > > diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> > > index bb3ca9a5d731..2eba9575828e 100644
> > > --- a/tools/testing/selftests/kvm/s390x/memop.c
> > > +++ b/tools/testing/selftests/kvm/s390x/memop.c
> > > @@ -485,11 +485,13 @@ static bool popcount_eq(__uint128_t a, __uint128_t b)
> > >  
> > >  static __uint128_t rotate(int size, __uint128_t val, int amount)
> > >  {
> > > -	unsigned int bits = size * 8;
> > > +	unsigned int left, right, bits = size * 8;
> > >    
> > 
> > ...why not just:
> > 
> > if (!amount)
> > 	return val;
> > 
> > ?  
> 
> That works if you move it one statement down (128 would also trigger UB).

oops, yes it has to be after

> % 128 does the trick, is branchless and there is a bit of a symmetry going
> on between right and left.
> But I can use an early return if you want.

I think it's more readable, and furthermore...

> 
> >   
> > > -	amount = (amount + bits) % bits;
> > > +	right = (amount + bits) % bits;
> > > +	/* % 128 prevents left shift UB if size == 16 && right == 0 */
> > > +	left = (bits - right) % 128;
> > >  	val = cut_to_size(size, val);
> > > -	return (val << (bits - amount)) | (val >> amount);

...this is a more idiomatic syntax for a rotate operation 

> > > +	return (val << left) | (val >> right);
> > >  }
> > >  
> > >  const unsigned int max_block = 16;
> > > 
> > > base-commit: 305230142ae0637213bf6e04f6d9f10bbcb74af8  
> >   
> 


