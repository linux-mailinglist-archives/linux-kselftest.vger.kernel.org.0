Return-Path: <linux-kselftest+bounces-2209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF448818B21
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 16:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464A51F23C63
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 15:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12BF1CA83;
	Tue, 19 Dec 2023 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m0CqMWwv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C951CABF;
	Tue, 19 Dec 2023 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJEgCH7016735;
	Tue, 19 Dec 2023 15:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=rZGTkydNf69G/JmroJGLXVMIAWOnNfgap9XVxfjYW7Q=;
 b=m0CqMWwvXWVYAVYEzi4BplVGAI3Z6FY2gtjkOIcYnDt9lI/qVhqQYz3PzVe5I4p0jt+z
 5NOip33klToGvLLkei+aoUe7bZivKIE2rWNZrcqTTmSHlBV6fHMmW10ioDKwW9hGXgXH
 iLGeNmMW69CaMa5l3ZzQHzoTerSudqNaZJTWVJED/mqN5Wz3zdwr4bAxeNt4ksFJQQRw
 1414AcjoSU/Lr8W3Tmg09pcyoIE52LXgobjkoL4qvWOxl1LaUPRjatb1i7Wg9UewwxXc
 zL5DUIH3MHvoXrKY2/yxzOmkDQ55vIbzPs7hvv8iddIqj6eelck0JiT1H8C5OrdKrJ9n zg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3d5u168v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 15:23:49 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJF6vgx001658;
	Tue, 19 Dec 2023 15:23:49 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3d5u168e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 15:23:49 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJEV0Xj012342;
	Tue, 19 Dec 2023 15:23:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v1rx1r5d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 15:23:48 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BJFNkGU62128384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 15:23:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A75B220043;
	Tue, 19 Dec 2023 15:23:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87B4720040;
	Tue, 19 Dec 2023 15:23:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 19 Dec 2023 15:23:46 +0000 (GMT)
Date: Tue, 19 Dec 2023 16:23:45 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
        linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: selftests/livepatch fails on s390
Message-ID: <ZYG1gXy3IodeOWuX@tuxmaker.boeblingen.de.ibm.com>
References: <ZYAimyPYhxVA9wKg@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <cf087c7e-d24d-5cee-eadd-dd1fe26efe39@redhat.com>
 <ZYDLZkXdJ22AXtLW@redhat.com>
 <ZYFmOfFgsOdeikec@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <8adb8209-d49b-4feb-5ab3-47ca4f3cefbc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8adb8209-d49b-4feb-5ab3-47ca4f3cefbc@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sW1M6UitXH19qdc7eRNMwLv-kr_KqPnu
X-Proofpoint-ORIG-GUID: 1O5iQdCE9DdVWzlyuTjri7IfY9eo0LcG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_08,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=711 clxscore=1015
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312190115

On Tue, Dec 19, 2023 at 09:50:18AM -0500, Joe Lawrence wrote:
> There is a loop_util() utility function in the script that could be used
> to wait, like:
> 
> 	log "$last_dmesg_msg"
> 	loop_until "dmesg | grep -q '$last_dmesg_msg'" ||
> 		die "Can't find canary dmesg entry, buffer overrun?"
> 	LAST_DMESG=$(dmesg | grep "$last_dmesg_msg")
> 
> That should catch 1) short latencies and 2) buffer rollover.  Maybe that
> is good enough?

I guess, if loop_until() would fail in case a message did not show up
in meaningful time, that would be it.

> -- 
> Joe
> 

