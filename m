Return-Path: <linux-kselftest+bounces-13389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B2A92C224
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 19:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A489D294805
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 17:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EFF18EA9A;
	Tue,  9 Jul 2024 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zk1ddaep"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FE118EA64;
	Tue,  9 Jul 2024 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720544880; cv=none; b=qTWWW2QvtNeaTL7rZRVSUY1Qago9E/4V0XcRq6IDZHqaVMeXx2N6nFkNgqdAVR9xCVJzS3jfoTakMJqF85y0leYCfWMCyQM+pT72IjcaanMs4vOaYxwEyWHnTRKMhM7C/k35bLamtsSmL6B5yILOjFrKjcSBYEsBP4IgOWq2Rj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720544880; c=relaxed/simple;
	bh=9eGOYZfwQWm9ejTalI33vh42aTLQRdzymTbvStLEUxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfvlEX1AW1A7cIB2sZL/nyeiuTxhti6MyOxYal6Z/vK4SzBz08n6jj/wDoqTBBcyY0RBX3IawPnT00rETyRP7jbYWSlSRKjOH2cVMRf4EMOYSMiUfICmfOyvJai4PDFVFTJBjIsMydIX0Ox5qCqgaJVoR16Cq1IrR8lfFi/RWbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zk1ddaep; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469FuvN0000932;
	Tue, 9 Jul 2024 17:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	+cVaZ04eF+3iXGKG7pEKeiHpeKa8DWFu6RfLBt8Mw4c=; b=Zk1ddaepL8Q3L+x0
	WLZmQZ+CqBLT6IxEtNMXCKsiHof+vrDJ8jFmFOqDjFZ/Pz4JKII1HFo7TqL6PhzO
	mdGiBLa7ZO100OMLuABpjtq0R1eCkOzQ+CKUt814eMHuE81LoCHU3Vhx+kQy5htZ
	6VTkCXwed+do5fxGvAdP+oyzNbuhfABo7TKJv/FY+doP9ksuCzj69SsfJXHteBPG
	Xar4gUQkqkFHsjQONNL5Ph+PN3UWAfdJVvq4Qqw7Z0HM9E9yvF4Y+YBVRNvIBvFu
	oDLVqgsBV1gCWaj3p2j4lu8QYAmy9b/nAp5UZxc51cuCWw4lBw76GZkJ9WP+qey6
	PkOCUQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4095848wrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:50 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 469H7nQF013680;
	Tue, 9 Jul 2024 17:07:49 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4095848wrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 469E9Q8t024670;
	Tue, 9 Jul 2024 17:07:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 407g8u5xs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 469H7h8P47120676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 17:07:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49B3D2004D;
	Tue,  9 Jul 2024 17:07:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E8F320040;
	Tue,  9 Jul 2024 17:07:43 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jul 2024 17:07:43 +0000 (GMT)
Date: Tue, 9 Jul 2024 17:40:22 +0200
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
Subject: Re: [PATCH v1 2/9] selftests: kvm: s390: Add kvm_s390_sie_block
 definition for userspace tests
Message-ID: <20240709174022.348db1a9@p-imbrenda.boeblingen.de.ibm.com>
In-Reply-To: <20240709125704.61312-3-schlameuss@linux.ibm.com>
References: <20240709125704.61312-1-schlameuss@linux.ibm.com>
	<20240709125704.61312-3-schlameuss@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: MnPgpkJ9oQSV5aNuF7J30vUBnBqQFzlv
X-Proofpoint-GUID: hIZPoUUECHzzba_IY7Po4MDm24VlkVWN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_06,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=788 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090112

On Tue,  9 Jul 2024 14:56:57 +0200
Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:

> Subsequent tests do require direct manipulation of the SIE instruction.
> This commit introduces the SIE definition for the selftests.
> 
> There are already definitions of this within the kernel.
> This differs in two ways.
> * This is the first definition of this in userspace.
> * This does not require atomicity for the flags.

you say this here,

[...]

> +#define PROG_BLOCK_SIE	BIT(0)
> +#define PROG_REQUEST	BIT(1)
> +	atomic_t prog20;		/* 0x0020 */

but then you define this as atomic.

Is this a mistake, or is there a good reason?

[...]

