Return-Path: <linux-kselftest+bounces-14080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F21B93A098
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 14:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC85282B95
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 12:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64D71509AF;
	Tue, 23 Jul 2024 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="shjDPULM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA5113D882;
	Tue, 23 Jul 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721738894; cv=none; b=TZY0h4lRvLMoxTYJXb4UZavQ6JYkRT7+ZMg8mZbzjLGoY3WC+XBbvojYGRFtVmxYUVnvOdeKY9gmL95cNvTxixCG1AxCnZXWEqV6FfQwAVt3wn05LuVvAxfTfTSRDYPe5PoxfIj93EmW02HHSBuVmrBEi4dIq8ErdLmwur6uucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721738894; c=relaxed/simple;
	bh=2WEYYMaTX072flqKEPj1SiAEfPGCpBNDBElimD51FzU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DB0Exg/gVn4CmHsNT9+32Lq5JXBRnPJ5T+c/AljL4WDMKgQ+MQTViLKzItBPWGCNMaK+Oum0Rg0jO4/kBiYDLEDkvJm3zKC0ZDBg/jgI8OwhBVENMH+2xfg/Z0PA193t+GeqqQqcxsfqBwc7Ny5AV7HppTOdinMEBDN4JoTsJ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=shjDPULM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NAwS1X008463;
	Tue, 23 Jul 2024 12:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	W0TeZu3HucHjAOTxOaIgEd5j79B3LAFx5e7/S1Yx9r4=; b=shjDPULMgoAysJsX
	JvjnkI+VHsQnnHHzQ8EndXuQ/IHevk0hO9EzGOuwc+lBnpyN5sIdHnhjwxrI1IRO
	SWB0UPeauDBwNgQDxHx5+QzEG8evDgWxPHwdj2svVX+UIYETO+cnGp3yIjWGvRFu
	QKuPp4SRsJz0gnGs4ye8TDaOQTqTJBlCwNzprxPuZkk2cub3bbbQhvU6a2A3wImP
	g6mz5vAp8yUcIYxEbLxCFS93ejyNJ/bZQRZpHNUoDQ0MgPkZn0a3ZdZuXszwTCYD
	4y8e94yW52DNNdwP/v6MzJ4c7JPRGox5O+FwtQZVJr7nS4piUsoCHLCx0pwO8pIN
	KFwvOA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j91m0hcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 12:48:09 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46NCm9ZW005972;
	Tue, 23 Jul 2024 12:48:09 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j91m0hce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 12:48:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46N8sBAa009111;
	Tue, 23 Jul 2024 12:48:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gt93ba5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 12:48:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46NCm2YW21824192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 12:48:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CFC62004D;
	Tue, 23 Jul 2024 12:48:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1674E2004F;
	Tue, 23 Jul 2024 12:48:02 +0000 (GMT)
Received: from darkmoore (unknown [9.171.64.70])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 23 Jul 2024 12:48:02 +0000 (GMT)
Date: Tue, 23 Jul 2024 14:48:00 +0200
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah
 Khan <shuah@kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio
 Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PATCH v2 10/10] s390: Enable KVM_S390_UCONTROL config in
 debug_defconfig
Message-ID: <20240723144800.6c6f48b0.schlameuss@linux.ibm.com>
In-Reply-To: <9cc8f685-70b2-4c31-9be5-e822ae52797a@linux.ibm.com>
References: <20240723093126.285319-1-schlameuss@linux.ibm.com>
	<20240723093126.285319-11-schlameuss@linux.ibm.com>
	<9cc8f685-70b2-4c31-9be5-e822ae52797a@linux.ibm.com>
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
X-Proofpoint-GUID: 4iFn36iVG9gw1z4IPxj7oDIpGH-e-as5
X-Proofpoint-ORIG-GUID: iLJQQQCx9BSjuXXjFTUqhu2R_TavfWZw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_01,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=725
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230089

On Tue, 23 Jul 2024 11:40:35 +0200
Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

> Am 23.07.24 um 11:31 schrieb Christoph Schlameuss:
> > To simplify testing enable UCONTROL KVM by default in debug kernels.
> > 
> > Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> > ---
> >   arch/s390/Kconfig.debug | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/s390/Kconfig.debug b/arch/s390/Kconfig.debug
> > index c4300ea4abf8..4798dded6d76 100644
> > --- a/arch/s390/Kconfig.debug
> > +++ b/arch/s390/Kconfig.debug
> > @@ -20,3 +20,6 @@ config CIO_INJECT
> >   	  This option provides a debugging facility to inject certain artificial events
> >   	  and instruction responses to the CIO layer of Linux kernel. The newly created
> >   	  debugfs user-interfaces will be at /sys/kernel/debug/s390/cio/*
> > +
> > +config KVM_S390_UCONTROL
> > +	def_bool y  
> 
> Isnt that enabling ucontrol for all configs? YOu probably wanted to patch
> arch/s390/configs/debug_defconfig

Yes, I double checked. You are of cause right.
I did verify that is generated into the ".config" with "make
debug_defconfig". But then I missed to check that it does not get added
with "make defconfig".

I will correct that in the next version.

Christoph

