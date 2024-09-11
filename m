Return-Path: <linux-kselftest+bounces-17733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C95974D7B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 10:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6C1288F45
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 08:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741BF15E5B8;
	Wed, 11 Sep 2024 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hd4zTXZv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163AD14A60E;
	Wed, 11 Sep 2024 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044626; cv=none; b=LLcNAJ5NFICxZsrRL20ryhoi9VGos9XWWyss4ioQ1ZzaUmVHzBI1hYfRKeRZpwXaaIk/pzIZ4LhG8YBMQJ5/y64wVTmWC2XEGurHv9YizA+enS9KyAyQbEg5gJ0otLOIh4VLnbEl7OYSCQzzl3BSRg4gU0LyATo3pF8Bnxsb9OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044626; c=relaxed/simple;
	bh=cYK3zsplXixZE4tQdoQ+vO3XwLj4lj+3tojQaOs9ghI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KDWtFXwnDktuZmTIbqvsXVawtfizDupi8ja+Pk2wq56hvEblMH4x0dR106l34cXPqNNmnuYNsQg0XWkGnoJkjdbOYSWKsNHcRtbZdeJU+z5AMraJ+zi0N8kEl0wBYmtzJ4mPHWB7Ws8DS1u/dxv7DIL8iL0B3Iqxik5/Fmd/sak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hd4zTXZv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B8EulX026104;
	Wed, 11 Sep 2024 08:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=c+mglZUFoLpQvuUjGX5VPJdarz
	CP8EYqnri0Iu0vBVc=; b=hd4zTXZv1Ok9nm3N80hKSSx4zYjaVVNTv/fX18s9Qx
	MV8pfrTxq8kzA51NBcqBI8nouihWuk1zDIFIl4+M5HgRxW9mUWSdyEg+T89dcaBo
	hMGpg4gHsdhRu8UOB0SmBUYB0BZpE0pOHmA4QB+qAe9BNGzIGg+r6SHYf4MBfKno
	IDgsqe/J3Y/66P0lCR1MThErGH4HJar4VrHIDIr5VRTECgce+60u+VayaaaC0Pcz
	+6UimrqWE1/wHo2PFIsnP2UzoKS4lOBuroCk8U1qiAI5oXQlFxNDL7Legtyl6+AU
	9Q24UgKqFNpqh7aShtZVlFzArXI7xQKhCxKvTKPYmGQA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gebachgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 08:50:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48B8Ebpx027308;
	Wed, 11 Sep 2024 08:50:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3v37yv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 08:50:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48B8oGIQ48955848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 08:50:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4093620043;
	Wed, 11 Sep 2024 08:50:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE06A20040;
	Wed, 11 Sep 2024 08:50:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Sep 2024 08:50:15 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Shuah Khan <shuah@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 0/2] selftests: vDSO: s390 fixes
Date: Wed, 11 Sep 2024 10:50:13 +0200
Message-ID: <20240911085015.3581722-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: A26qG9j2RjmpDXHys2TbdKfEPejS4C2z
X-Proofpoint-GUID: A26qG9j2RjmpDXHys2TbdKfEPejS4C2z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=802 impostorscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409110064

Two s390 fixes to make vdso selftests running on s390.

Jason, given that you carry already a lot of changes for vdso
selftests I guess these should be routed via the random tree.

Patches apply on top of current random.git master branch.

Thanks,
Heiko

Heiko Carstens (1):
  selftests: vDSO: fix vdso_config for s390

Jens Remus (1):
  selftests: vDSO: fix ELF hash table entry size for s390x

 tools/testing/selftests/vDSO/parse_vdso.c  | 14 ++++++++++----
 tools/testing/selftests/vDSO/vdso_config.h |  4 ++--
 2 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.43.0


