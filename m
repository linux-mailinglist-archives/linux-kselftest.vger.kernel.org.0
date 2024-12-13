Return-Path: <linux-kselftest+bounces-23293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E17F9F0303
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 04:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2AA28446D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 03:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0455A13A26D;
	Fri, 13 Dec 2024 03:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rt+/u5Eq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F3239AEB;
	Fri, 13 Dec 2024 03:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734060078; cv=none; b=YlB6hgGcmebtmq5U2scrEEBOKToiZPVDEgFRKGCCDr5SADmAId+pL/spxoiIYKJUgPYE92plfXLkB95YzVzmCY0QeKZwPLBSEWtN72aYN3n7D9wqOio0XEI732X1mIdP1GsjTuO9bhDN06DyeJo1W9Ol6i2XUi4q/wbLlMqMvSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734060078; c=relaxed/simple;
	bh=0oMFQzpVIHd8WJVb/2Kqsg1QFhYtZRYi/4aVvaFGNMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqDopAlglS18fCJQtFskLW2LkbOuFuASNc75yS4EMGebwSSSxlHuDmyXK6/zbxu7d9hUAyJHhK/YF5a1rML2OoF+xeGCSZvInH5nGASQNMx/qAf01j4P+EHOH3lxuQ/dQLTq/e4yUeFPmVvvo7LZBQ1lexicOR03cBVrZtSyr0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rt+/u5Eq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD1vrCf029655;
	Fri, 13 Dec 2024 03:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wwqtwk
	WWnH5nao7UTyaduT5sV32y3v5muNnqixvJuAs=; b=rt+/u5EqqR1fjUlag9ibp5
	G0Y2964ev+xVUvPIGXe7Z30T9auMBCIZQck2vQXnkEiTwmM8THOtrrQPjUwd613S
	ZDVkHZKv8lSEn/Hm2iIf+VYwPvjaBHe+GE4AIdlmrr0ecK4Xf4BbHpQKncGH6Ou3
	O1xBQI6yiXyu7KD9agNmNQsNUk276BrqVJk1ZMFgTmQsToLlvLxqetXueqbU/5dn
	FjmkyIywOt+EByvgDqG9im8ru3HBuMMOce4TOunMmqRQxnKA37Ez8yIO7r32Lxqt
	OnkEdYX70nAv4mIav+0GnOoE/Oc1RA+h0grXUZO02GMOgr97sl9Dj70SbGGwe9+Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjxnxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 03:20:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD08o6R017052;
	Fri, 13 Dec 2024 03:20:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12ym1ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 03:20:45 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BD3KhWK32768732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 03:20:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4168720043;
	Fri, 13 Dec 2024 03:20:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06DDD20040;
	Fri, 13 Dec 2024 03:20:42 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.in.ibm.com (unknown [9.204.206.207])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 03:20:41 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: shuah@kernel.org, Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/powerpc: Fix typo in test-vphn.c
Date: Fri, 13 Dec 2024 08:50:41 +0530
Message-ID: <173405995390.325393.4623287844597085204.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204080149.11759-1-zhujun2@cmss.chinamobile.com>
References: <20241204080149.11759-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wCBx2gDigqEbpsuzOL9zlUb8Hn95KpDl
X-Proofpoint-ORIG-GUID: wCBx2gDigqEbpsuzOL9zlUb8Hn95KpDl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=536
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412130022

On Wed, 04 Dec 2024 00:01:49 -0800, Zhu Jun wrote:
> The word 'accross' is wrong, so fix it.
> 
> 

Applied to powerpc/next.

[1/1] selftests/powerpc: Fix typo in test-vphn.c
      https://git.kernel.org/powerpc/c/3a7a53c8d4813ef510a731f529b8c58208ab8896

Thanks

