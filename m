Return-Path: <linux-kselftest+bounces-3244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B68832A39
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 14:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB6F1F21FA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 13:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E55D524CD;
	Fri, 19 Jan 2024 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BXjmABxR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E704F1E6;
	Fri, 19 Jan 2024 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670394; cv=none; b=R6L163ncTPxpTudOhKoj2ZySJZLzU1VTc4cg29kwqtNaQmFPQWk+sqcAuEUlekKac6GFe9ne3wevAxitmuYjUEvdvRkTe6nTWWX4JDYAZOWxj+fEkXJcZg1OMuXzTYw9ji54voEKVquv63LpGDUe9c5eMmEfWS4alqaw8INhyak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670394; c=relaxed/simple;
	bh=dJgYMSNA/LU7JWwce+WL2E1J0qhV5ha58/4r5V6HnYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOtMdTLeRCOHGkJGC5cBRGDG+x9M2rd5BBkCZpf811OojlhEIzQIwQlNvGHLEx8maw9ZevFWGIqbYRLe6mZjHNErZDUhMXK2qHVsQwUXAk+WpvRDxRNGsVtkWf6Eg17gmuGu+sw0R9k8112wXgRYQ4AAaGTih6pQDuHZJADPGJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BXjmABxR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40JCqqq8014644;
	Fri, 19 Jan 2024 13:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Qvu2UtNYQDPQTnD9i9bszivXKf7tCMpnBb8vcZMonug=;
 b=BXjmABxRmEVa3dgZzvIgAapAMi7y1mCh/C/jsvGDaZ27DVy08dDepFOXimGTmz6vkILN
 3swZJ8UmYzfQDEEWbYIWHf8w47KSY8d/FBf47l8PGUui+yUlXEWpSLt7t+84Ba1vrADT
 vEexTjSIvZKxZi1sT3/nRpLMDzOfZfe6W3CuaOTABNHfy8IW7Iik4tF/umAFRgSZqtmh
 OB33RVaHerE4+XVW+b/sy0gtecNeNo4JtMN/1HbFblOBq3XcWjxaeMNMMze44pI2lOIM
 sKSGO7RNGZzxFUSdFGEzTM35ntoa0UmsjKJQ6I8tMTZfi6GXnOf1dCA8UpJV1Q5xqJg+ HA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vqsfcgp2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 13:19:43 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40JCxs0L030790;
	Fri, 19 Jan 2024 13:19:43 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vqsfcgp26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 13:19:43 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40JB0F4r030427;
	Fri, 19 Jan 2024 13:19:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm72khbn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 13:19:41 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40JDJdrG22020654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jan 2024 13:19:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 307EA20040;
	Fri, 19 Jan 2024 13:19:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02EFA20043;
	Fri, 19 Jan 2024 13:19:38 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.85.177])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 19 Jan 2024 13:19:37 +0000 (GMT)
Date: Fri, 19 Jan 2024 14:19:36 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v6 2/3] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
Message-ID: <Zap26MINbbxREt4c@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240112-send-lp-kselftests-v6-0-79f3e9a46717@suse.com>
 <20240112-send-lp-kselftests-v6-2-79f3e9a46717@suse.com>
 <Zap04ddls7ZvbL/U@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zap04ddls7ZvbL/U@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DrA398G5w-678hUFOYdvtmSK8cLVFn6c
X-Proofpoint-ORIG-GUID: Y9Lss7BHjSHspnm5KUirWOZ-K54LSjfL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_07,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=513 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401190069

On Fri, Jan 19, 2024 at 02:11:01PM +0100, Alexander Gordeev wrote:
> FWIW, for s390 part:
> 
> Alexander Gordeev <agordeev@linux.ibm.com>

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

