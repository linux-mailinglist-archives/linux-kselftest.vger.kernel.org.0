Return-Path: <linux-kselftest+bounces-3153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 845788309EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 16:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09D541F247E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 15:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DDB22316;
	Wed, 17 Jan 2024 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RcIv86ss"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0839621A19;
	Wed, 17 Jan 2024 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705506091; cv=none; b=UlodXNK2v/G8OGuxU+wGddkdg8NHpAVHd2fCxLpenilclVFC8ay8t0qz/rcxL0qpVEtTRkOp0K4cicDxvEULU/Hs3MtQ+nffwqEUFgkhhzheG4TQ4yt3+9vY5uHXtdjz5AtsvoHS5tS2ssJMJlLcpCmWQt3S3as1WYT7XS4BlgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705506091; c=relaxed/simple;
	bh=yhlyvGOVc0FW/SQnx8rcyUJVQv4hP/dALX7MtsQQ+R4=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:Received:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=LWaJlM2tFzdXQfbT1QmX20yuKefnpVeGw/oSFKQOfVkhqUAJRty3A6lYjZy9OEQFJgEgWqcAUAR59+r4nIQW1z1dOeDmdS6J659SCOt9+vsZ+mSw0LX1GIURNBSS7gX2aylCjGGjvqxR8qqZ7QkzSQkC2z2/LlEBj779d6/j124=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RcIv86ss; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HFHVnS022560;
	Wed, 17 Jan 2024 15:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=yhlyvGOVc0FW/SQnx8rcyUJVQv4hP/dALX7MtsQQ+R4=;
 b=RcIv86ssfGnwo+8vgXH6za/DtmLnkrlvEXx6WZga9f9lZ92qwOfSq5Z1kvLti7i7d9cH
 o8vGYQvU2Y3Vz3iJJaex/O6H0RPcajgSsWIA/AUhQB23G7L/mgvC25GzQW7sDlqbu6Lk
 enQ6GVqZCqqjB3ibRjLPTzwRE4srOO9w3Xods9rMuyLddMWxWrZ7dBprGr8LdjnBvas9
 gLe1V/pkimbTwZJj8MjRgjea8Bq2+x25/bv1nKKkBzS9dXjIJrrhjsujVbZEN8Fui5D9
 RUxAH4W9C5px0nBILGc6UwHVzCg/+QA29WCb+JkWig42jWRUZiSp/uJA97Uvm6t51Bmn 1w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vphdb0r3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 15:41:18 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40HFJdB0027609;
	Wed, 17 Jan 2024 15:41:15 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vphdb0qqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 15:40:39 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40HENKcQ005320;
	Wed, 17 Jan 2024 15:40:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm7j1wp6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 15:40:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40HFeZ6k18678328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 15:40:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97A6420043;
	Wed, 17 Jan 2024 15:40:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5840E20040;
	Wed, 17 Jan 2024 15:40:35 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 17 Jan 2024 15:40:35 +0000 (GMT)
Date: Wed, 17 Jan 2024 16:40:34 +0100
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
Message-ID: <Zaf08hx8fBj6TW5/@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240112-send-lp-kselftests-v6-0-79f3e9a46717@suse.com>
 <20240112-send-lp-kselftests-v6-2-79f3e9a46717@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112-send-lp-kselftests-v6-2-79f3e9a46717@suse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _3iYNxT1FOrPnC60Y6LJUFeHWTv9eNKh
X-Proofpoint-ORIG-GUID: ActasdkG0_3XDYGMQlVTCphXIluTp9p6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_09,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=797 phishscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401170114

On Fri, Jan 12, 2024 at 02:43:51PM -0300, Marcos Paulo de Souza wrote:

Hi Marcos!

> Having the modules being built as out-of-modules requires changing the
> currently used 'modprobe' by 'insmod' and adapt the test scripts that
> check for the kernel message buffer.

Please, correct me if I am wrong, but with this change one would
require a configured build environment and kernel tree that matches
running kernel in order to run tests. Is that correct?

Thanks!

