Return-Path: <linux-kselftest+bounces-15419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B36953786
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 17:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13797B21B83
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 15:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599D915E88;
	Thu, 15 Aug 2024 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T3mOzxN4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8981A4F3B;
	Thu, 15 Aug 2024 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736751; cv=none; b=hT6dEbm+QONo2QECDRykI3R3vuMjv22LxXZ/VFoLcRvpGtA1jmSFizO9NMZP28RCZzrHN2I2ugtUGmexdkfMOmI+iBQpbbnzTdl16oBTjTmgJDzqU4S1w47VbnW3nGDOGD3WF4Vt/0TMSHTNh4qcN50gPQlSi1z7M9DQ4KF4Jpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736751; c=relaxed/simple;
	bh=c6FMcZ9Ro1bNyGdFqF+qhqczyAwQU8FuOvu8/tuyQc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VLL+WX+bUpjSCVlyyhFelsDfFZaQbvJ/sk2QmzCYNhKkFf+5AR0qi7d6ISCqS9hGBnCW3r9FGll7DTu/D0at30WDzQc3f7sUSTNJf1gBt7KqScSjeobvBHhodrmy4f33jTXjCyHrgjPzSFMJTp+IkspHTa6+D94StlvzXfe+wng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T3mOzxN4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FApERC011906;
	Thu, 15 Aug 2024 15:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=4xMYHboKlORg0xp/54DTE5qzUoPwtIBM67yaG+E
	cZns=; b=T3mOzxN4/xCToatHfcR01zb8CJDF3rID6dkxqnEWJezfpYDDa6+pgB+
	QQwahNqdsnGLkFBZGmbe4OVaQeVPDAeaovoPjdBlyd6yxYISNNd2/qedizCPmtts
	pzn8lKbBT7pwhpmm6mxjLrtS8yMYVdYpGSRc+4wZ22EV3PYxZrfsPpk57bBbWDto
	rVJpo6wm7yheUWfk3dk0N0jMwS/sLekxF9rHO0IDeeL+Ckf9aMbtKyrLuycpkQsr
	EEXu8a79G2jrZLfy+K04UUjUIOAlL++Z0kIAN0SZpXhfYZtqG6ZxOsCKZSiSfRbt
	T8RXqlmzvLNnekS63N8rnRjyBhx+xTQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d6cd1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 15:45:40 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47FFjd3Y005421;
	Thu, 15 Aug 2024 15:45:39 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d6cd1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 15:45:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47FCXbeM011523;
	Thu, 15 Aug 2024 15:45:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xjhufm7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 15:45:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47FFjXR957475518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 15:45:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42CBD2004B;
	Thu, 15 Aug 2024 15:45:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A352220040;
	Thu, 15 Aug 2024 15:45:32 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.32.201])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Aug 2024 15:45:32 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>, schlameuss@linux.ibm.com
Subject: [PATCH 0/3] selftests: kvm: s390: Add ucontrol memory selftests
Date: Thu, 15 Aug 2024 17:45:26 +0200
Message-ID: <20240815154529.628087-1-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mbhvlfLvbijOgEPLbOqkCAOt_u8MgiWM
X-Proofpoint-ORIG-GUID: 2dztltn4Be-GLIimnPyvb2ie2XxEA_Ed
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_08,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=770 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 adultscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408150113

This patch series adds a some not yet picked selftests to the kvm s390x
selftest suite.

The additional test cases are covering:
* Assert KVM_EXIT_S390_UCONTROL exit on not mapped memory access
* Assert functionality of storage keys in ucontrol VM
* Assert that memory region operations are rejected for ucontrol VMs

Running the test cases requires sys_admin capabilities to start the
ucontrol VM.
This can be achieved by running as root or with a command like:

sudo setpriv --reuid nobody --inh-caps -all,+sys_admin \
  --ambient-caps -all,+sys_admin --bounding-set -all,+sys_admin \
  ./ucontrol_test

---

The patches in this series have been part of the previous patch series.
The test cases added here do depend on the fixture added in the earlier patches.
From v5 PATCH 7-9 the segment and page table generation has been removed and DAT
has been disabled. Since DAT is not necessary to validate the KVM code.

Previeous series:
https://lore.kernel.org/kvm/20240807154512.316936-1-schlameuss@linux.ibm.com/

Also see:
https://lore.kernel.org/kvm/d97f4dec-31c3-45c0-ac33-90e665eb6e99@linux.ibm.com/

Christoph Schlameuss (3):
  selftests: kvm: s390: Add uc_map_unmap VM test case
  selftests: kvm: s390: Add uc_skey VM test case
  selftests: kvm: s390: Verify reject memory region operations for
    ucontrol VMs

 .../selftests/kvm/s390x/ucontrol_test.c       | 218 +++++++++++++++++-
 1 file changed, 217 insertions(+), 1 deletion(-)

-- 
2.46.0


