Return-Path: <linux-kselftest+bounces-5641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B9986CAB7
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 14:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DFF28512E
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 13:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59755128820;
	Thu, 29 Feb 2024 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EuglddQq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6D912836A
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709214809; cv=none; b=jNc/LzhC9YZcxefcJ431139ZDzNm+MhJqmljLx3vpCVq1vdhHkBK+e8YLcR+pvHey4z4iB3Tq0guM+NhuYhzvuX0r6duzoBtzV7/n4kOo/rsSRINMKQG/WjLIAjnpocvaLf2sQGKbkxlofo1kS7EIXj5BfhUHs+NIU+OtApB8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709214809; c=relaxed/simple;
	bh=TV1GbrTdu9ustbXQ23a32UDnTWzrWPMnxdhX3oBXkLI=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=RrHmZwdHYgczNgdSBQbgGeIWZgFtCoWiAo7/0K1GDkNCXvZl3AGyX74riTrQ6C0sAPmubt2bI5Gglu6MVCWJB9PlpN5Oxp1XSihqeFDdF4wEOt/Y6ZnV/Uo2ybnElb2mxJ2DfcXWlv2vJHRgUqCvDd6ZWlRIksxN7xMPN184ixk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EuglddQq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41TDC2Dl014540;
	Thu, 29 Feb 2024 13:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=pp1; bh=7NAN/HeHdSbzCETUmBemDrt3oj+C73aX5z95QNceeME=;
 b=EuglddQqY59e/8ZfSn3BsN9GK/342L+QRk9H4VPGuA+dp+5o0anREcTg+FkLL57SW2cv
 jNKWyDX6NaB7O5o51ResB9iUVd+MPfcNz8j1Sk5g+f2oX3Iy47HYBU7meT4T0sCdbP1a
 xtUIYjLE3gEgY7tmuExUrmLmXh4mKOabMQaHgOIknU23E4buz95czbZV7XvlSUUjXXua
 NAfkU37g2x9GGw9pNnSIsihl/0gQwg/e//dknGFYZepG/Xt1tvCOkR9QO0Hs9E07OLFK
 V6siW82kaWGi+6MCaV/51KW6VSCSttvmdsjSS4/pEHOTuqYR6cpe+uTjh6g3WdqhFL3R sA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjtknsaap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 13:53:24 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41TDex0G005431;
	Thu, 29 Feb 2024 13:53:23 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjtknsa8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 13:53:23 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41TDaRop012312;
	Thu, 29 Feb 2024 13:53:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfwg2n745-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 13:53:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41TDrI8H9568830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 13:53:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A7432004B;
	Thu, 29 Feb 2024 13:53:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 537E420040;
	Thu, 29 Feb 2024 13:53:17 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.80.238])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Feb 2024 13:53:17 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: [kselftests/powerpc] Primitives test build failure with linux-next
Message-Id: <C11ED986-3959-4C4D-8780-ABD97D5FB0D1@linux.ibm.com>
Date: Thu, 29 Feb 2024 19:23:06 +0530
Cc: linux-kselftest@vger.kernel.org, tanzhasanwork@gmail.com,
        andy.shevchenko@gmail.com
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tlFuWMaYGOxJ8u8g8dnzpvawlC79KxYq
X-Proofpoint-ORIG-GUID: AD9XdlWXzVfnbtjbolv_XXqXnb8bvXla
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 mlxlogscore=996 malwarescore=0
 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402290107

Powerpc specific selftests (specifically powerpc/primitives) included in =
linux-next
tree fails to build with following error

gcc -std=3Dgnu99 -O2 -Wall -Werror =
-DGIT_VERSION=3D'"next-20240229-0-gf303a3e2bcfb-dirty"' =
-I/home/sachin/linux-next/tools/testing/selftests/powerpc/include  =
-I/home/sachin/linux-next/tools/testing/selftests/powerpc/primitives    =
load_unaligned_zeropad.c ../harness.c  -o =
/home/sachin/linux-next/tools/testing/selftests/powerpc/primitives/load_un=
aligned_zeropad
In file included from load_unaligned_zeropad.c:26:
word-at-a-time.h:7:10: fatal error: linux/bitops.h: No such file or =
directory
    7 | #include <linux/bitops.h>
      |          ^~~~~~~~~~~~~~~~
compilation terminated.

The header file in question was last changed by following commit

commit 66a5c40f60f5d88ad8d47ba6a4ba05892853fa1f
    kernel.h: removed REPEAT_BYTE from kernel.h

Thanks
=E2=80=94 Sachin=

