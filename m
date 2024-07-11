Return-Path: <linux-kselftest+bounces-13583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E81FD92E845
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 14:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17DC11C215C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 12:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE3B15B57C;
	Thu, 11 Jul 2024 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MWZZNqYw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1916815B14C;
	Thu, 11 Jul 2024 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720700941; cv=none; b=Kuko1hawSEFVFMbSdkiNLltY5kpwjLltTD5GRVQYQrCekOGNVLJNV4AA8tP9rqvwCF9Mj1buPAbIHRhRM2Frg6GJxzB978Nq6Bw/mfgcj8fTYTwRKQarOqgaUj2wkKjkeAgWAwqB8bgwWzJUzxwg+J7Sd1HjVwQnvqilwlrwbjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720700941; c=relaxed/simple;
	bh=+/83SP1PbOGLKjMgg581I0Zhh8oWyOJtMUN6msfz2S0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ssTsDEdFRZpbObFRlAHW2mz6FITD/ZL2U4RpAZVwsq00MQUY+kHR4JUbgHhLN+oc2+w7Mx/ZgCC4Hk/Tv/D5F12/S+fRXmUR/DNVU1az/DFGR/gerXWiMQyPOj5UjgL9dmo1v9EZIQZIYXfou+5PD5fZUWBF4D9VWs5X5I8q23w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MWZZNqYw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BCDoFx022113;
	Thu, 11 Jul 2024 12:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	NNTPpaPvfiqoFF/AO9rb5Ffgjn7p7njpLbJAIiC6yXM=; b=MWZZNqYwNIpmxSDW
	skQFVwJ8sKmGcZQSzmm4zpxcHAcOatB9L83hk1o5sFOawhnBdII3nC1yr8rFyQqE
	Rz9S4XwVa5Ltwce6MuzPaNGcCaSmvU+UZevfnPTp3092lrBBpx7xoEopPxtdsR/r
	4aq2AVrRwXn5brzV1WHzAu61ksyM2EnKCkVEU2bRB/AUHYr2A0RHa0fGBvrHk/1P
	6CEPeDVE+00gqVTFtTxaDSPD4jSMrIloA1aJJInwkNJe4l7cghwOObAcss7QR6VX
	04hBSJd799ovhmvmxuK4tdN5MQ8xyrbuKoTI/N8P5CXS6D2eacye9ZMQGTFGzsMZ
	p207Mg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40aakegt5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 12:28:55 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46BCPmOS011732;
	Thu, 11 Jul 2024 12:28:55 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40aakegt58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 12:28:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46BBmFvm024664;
	Thu, 11 Jul 2024 12:28:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 407g8ugyaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 12:28:54 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46BCSm7d59113956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 12:28:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C02FF20043;
	Thu, 11 Jul 2024 12:28:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1807320040;
	Thu, 11 Jul 2024 12:28:48 +0000 (GMT)
Received: from darkmoore (unknown [9.171.19.34])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 11 Jul 2024 12:28:48 +0000 (GMT)
Date: Thu, 11 Jul 2024 14:28:45 +0200
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah
 Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand
 <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PATCH v1 5/9] selftests: kvm: s390: Add debug print functions
Message-ID: <20240711142845.7507f86f.schlameuss@linux.ibm.com>
In-Reply-To: <20240709183154.45770bdb@p-imbrenda.boeblingen.de.ibm.com>
References: <20240709125704.61312-1-schlameuss@linux.ibm.com>
	<20240709125704.61312-6-schlameuss@linux.ibm.com>
	<20240709183154.45770bdb@p-imbrenda.boeblingen.de.ibm.com>
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
X-Proofpoint-ORIG-GUID: A6j2fkSE_TEyTJnXsVurYNZ3pFArkOmJ
X-Proofpoint-GUID: 3ytxCF2kMbboUvQuFbmbFWOZTZdmdASx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_08,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=813 adultscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407110088

On Tue, 9 Jul 2024 18:31:54 +0200
Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:

> On Tue,  9 Jul 2024 14:57:00 +0200
> Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:
> 

[...]

> > +static inline void print_hex_bytes(const char *name, u64 page, size_t len)  
> 
> "page" is not an appropriate name, it's just an address, right? "addr"
> seems a more appropriate name
> 

Yes, this is a address. I guess I just carried the name forward from
when I really printed out a whole page...
Will change this to addr.

> > +{
> > +	pr_debug("%s (%p)\t\t8-0x08  12-0x0c  16-0x10  20-0x14  24-0x18  28-0x1c",
> > +		 name, (void *)page);
> > +	for (u8 pp_row = 0; pp_row < (len / 32); pp_row++) {
> > +		pr_debug("\n %3d 0x%.3x ", pp_row * 32, pp_row * 32);
> > +		for (u8 pp_block = 0; pp_block < 8; pp_block++)
> > +			pr_debug(" %8x", *(((u32 *)page) + 8 * pp_row + pp_block));  
> 
> why not printing in blocks of 64 bits? 
> 

Nothing against 64 bit blocks. Adjusting that for the next version and
also optimizing the functions to allow more reuse.

[...]

