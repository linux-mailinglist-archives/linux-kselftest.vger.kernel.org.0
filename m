Return-Path: <linux-kselftest+bounces-16953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D031C96869D
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 13:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073B71C22948
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 11:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A039B1DAC4E;
	Mon,  2 Sep 2024 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FQUtnEG/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8A91D6DC3;
	Mon,  2 Sep 2024 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277829; cv=none; b=l73TMhamg9VOHMSVkulb2h06nyRjdhzJUWQMr9/xvYtLy2R4JXFn+GRBxATgqVrmG3Zw1BhWZfhVYCtkT6Ec4fIuTHCVQGmP2PQHkiKNdjSbyfvhASLiyikYdSKSn9/otWfxbS0Z5MnBDG6XLHhRll4gwRcPY/QeeeA0qqyrbXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277829; c=relaxed/simple;
	bh=b1gWB/W5jxkWE8tz6zGQIWLTWJS1B2cnqMVNhixlQJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YGOMQT5F81AzYney5m6+RB2HqsV1hmgeErz9A3yJuboWyd/towDMk8/iec60acQOixdMykwfbT7Pra0GJSKDkFW4efWeEwGnPNcN6rMJHQGR45z7Wjp1lU1E8T5jRzXmDrKWQhfjS302vYBGgZGH03pYbb7+P/ZopkuRlyIYvE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FQUtnEG/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4829qI4v027882;
	Mon, 2 Sep 2024 11:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=laodjB7vHpYaju0Q1Cg3xlafX+Jo4tpZ6anr2vD
	6mw8=; b=FQUtnEG/0i2DQle+XcPWGnEYy9PCy4efS6oJEhF7TzZoxMGeJ8niEs+
	/D6LAHG5alDiclPonEh9Ml8iaOuDjZhzVvVyYH7GZb6wSxf9yfWNQMqgrLbOYhkh
	mERx/FG6vt/nH59UQ6/tabwySbtY4Vd1Evob6lgy3DfVrU4AOlV1obe8MwckGdzp
	aGOSqWmO/hevnLjy9FOpRTuYUdDv0iIqnQbC39r4eLiYFh0Ykxd6Rd94wMpRdVR9
	/HHm+F2D5RFj9v8P0IEK+5TAmZiYIliXFYAVrEZhoG7n+OUON7WLkHZ9ODKTHBjj
	Xfx4JrR9ZENH6l4toYkpRB/tz0w5rHQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btp98qrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 11:50:20 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 482BoJHk010884;
	Mon, 2 Sep 2024 11:50:19 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btp98qrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 11:50:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4828j7Zt000941;
	Mon, 2 Sep 2024 11:50:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cf0mnvjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 11:50:18 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 482BoEgK14680514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Sep 2024 11:50:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71FB320040;
	Mon,  2 Sep 2024 11:50:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED19320043;
	Mon,  2 Sep 2024 11:50:13 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.60.16])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Sep 2024 11:50:13 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>, schlameuss@linux.ibm.com
Subject: [PATCH v2 0/3] selftests: kvm: s390: Add ucontrol memory selftests
Date: Mon,  2 Sep 2024 13:49:59 +0200
Message-ID: <20240902115002.199331-1-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rzOP2AzE2lSYy4LwyAdKBVWWhAoM7887
X-Proofpoint-ORIG-GUID: LmhAtroZQfSuMREmbZ4XGE7IeqZYvMq6
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
 definitions=2024-09-02_02,2024-09-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=797 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409020094

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
The test cases added here do depend on the fixture added in the earlier
patches.
From v5 PATCH 7-9 the segment and page table generation has been removed
and DAT
has been disabled. Since DAT is not necessary to validate the KVM code.

https://lore.kernel.org/kvm/20240807154512.316936-1-schlameuss@linux.ibm.com/

v2:
- Reenable KSS intercept and handle it within skey test.
- Modify the checked register between storing (sske) and reading (iske)
  it within the test program to make sure the.
- Add an additional state assertion in the end of uc_skey
- Fix some typos and white spaces.

v1:
- Remove segment and page table generation and disable DAT. This is not
  necessary to validate the KVM code.

Christoph Schlameuss (3):
  selftests: kvm: s390: Add uc_map_unmap VM test case
  selftests: kvm: s390: Add uc_skey VM test case
  selftests: kvm: s390: Verify reject memory region operations for
    ucontrol VMs

 .../selftests/kvm/s390x/ucontrol_test.c       | 232 +++++++++++++++++-
 1 file changed, 230 insertions(+), 2 deletions(-)

-- 
2.46.0


