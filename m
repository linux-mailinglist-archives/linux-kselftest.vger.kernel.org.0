Return-Path: <linux-kselftest+bounces-13390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BFF92C24C
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 19:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1754B2A05E
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 17:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0844018EA9D;
	Tue,  9 Jul 2024 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SKPdmjwG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F9518EA62;
	Tue,  9 Jul 2024 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720544880; cv=none; b=Shd6bjqCg/Sir8ECRvaFSMEgp5N+4pvvcBPJJky1oQXdb/3r8y4ym+RIAyEQtJCRVPIa0P9YBSm54962AO7gMrF7DGQ6uIf5R7Td4MklJi/npiU1h3n30TafGYnJJ5WkHBach2ySJc0YDd/va1wqbD+gUpjF4Ffgc3Oz0kuFFyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720544880; c=relaxed/simple;
	bh=kCC41olboGCp9SWaquMfme5eBwVfYF+zg8YYPeTs7dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akuXmEiKBeXR1CrXHnByFUNywHXYzXmWjnwaTR1hMmgNv2MllUUMcdU0GnETl0GQN0XhEO9evSH5IG/UUJvt+CVAUDQIYcp0trbjI4ZtvkDWRNEhptTNPrhY8kHeaFMQcAdgQ63f/H+aqWIe8I95JeO9fZizBaXcAO6vtcCTfpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SKPdmjwG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469DuaSW031553;
	Tue, 9 Jul 2024 17:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	+YD6pMHcktlHGS89GzyLuK/bNSekQiEmkr9dEjN/qDA=; b=SKPdmjwGnB5D1ZI6
	Atg4dTh66FSzTKdothWJjvPHnQd1/rkdgrwJ7hpCG3pr2ySWWk7Ly+NyLRm5R2Ng
	sVDw2VYIVkW2K6o4hN5KsGjaBZZ8x6mahOv2+DHw4PTn4g39Vv7K0b70HQX8rLHy
	GljFJcN9ufuNAZ9poHgqm9AsxTPwYRiPbXJ1vTaR7HOeEocUuBiobttacGlIMFsN
	11/FqXxg4Rj2RPrEyP4v9drjd9ESz9zlSu2TJdH2sDyUNpyGfx/ihVlDikaqAMn6
	ix6tpoYLtV7tkzanhvhhK3hPw/gRcjf/vCMBODSRLlm3MEm3V199FrXoez+W4UTi
	0dUS4w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40932792r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:56 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 469H7tAT031042;
	Tue, 9 Jul 2024 17:07:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40932792r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 469FiucK024646;
	Tue, 9 Jul 2024 17:07:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407hrmnm8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:54 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 469H7nQL29753954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 17:07:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B6662004D;
	Tue,  9 Jul 2024 17:07:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2042A2004B;
	Tue,  9 Jul 2024 17:07:49 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jul 2024 17:07:49 +0000 (GMT)
Date: Tue, 9 Jul 2024 18:52:38 +0200
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
Subject: Re: [PATCH v1 6/9] selftests: kvm: s390: Add VM run test case
Message-ID: <20240709185238.1e1fe9cb@p-imbrenda.boeblingen.de.ibm.com>
In-Reply-To: <20240709125704.61312-7-schlameuss@linux.ibm.com>
References: <20240709125704.61312-1-schlameuss@linux.ibm.com>
	<20240709125704.61312-7-schlameuss@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nw4Rx3rJ2AUBkiQnrR--Tvw9HUG6bJWp
X-Proofpoint-ORIG-GUID: 0ALPYrpdWKTnEqVS9fc0zPItq_nBtVua
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_06,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0
 mlxlogscore=515 priorityscore=1501 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090112

On Tue,  9 Jul 2024 14:57:01 +0200
Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:

> Add test case running code interacting with registers within a
> ucontrol VM.
> 
> * Add uc_gprs test case
> 
> The test uses the same VM setup using the fixture and debug macros
> introduced in earlier patches in this series.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---

[...]

> +	/* run VM and expect immediate stop */

Why though? what is causing the immediate stop?

> +	ASSERT_EQ(0, uc_run_once(self));
> +	ASSERT_EQ(true, uc_handle_exit(self));
> +	ASSERT_EQ(self->code_gpa, sie_block->psw_addr);

[...]

the rest looks good

