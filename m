Return-Path: <linux-kselftest+bounces-23396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297E09F2CD6
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 10:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C742F1883AC1
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 09:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6BD202C21;
	Mon, 16 Dec 2024 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eiqNBbsm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC9820127A;
	Mon, 16 Dec 2024 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340934; cv=none; b=DksTgPsyojenGbBge9duJB/8cG563+JiNPS6r2QqWUFGgMxfSAiCfGYtQ+7OG9UcLkTklTwTSnsvqWujqM7n4+nc+12kmfEh2rqXy7GFn8/KZYTe3kSbZHJpNmF+W1lwDNjYM9POMbIhg08MF/tDLqZNr7a3SX4fbWNrgij0ph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340934; c=relaxed/simple;
	bh=sbEEUkpQe8slEBBADusNCTPxw48Fxk2pqpa2j2+J0Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KukHxwx2R5LEBc7se+OV/JzbWtfMOpf1vKIiBf983IGXy5rKcnF9CbB0alqQ5uFt53lfevEWIQhT3vnynkFJQgCDJyMIf2pKKh0pBvaTd2M1vwUGYpVEw6gc0jFNcktSNr99d5kU5eZ1vkNt+j0Wk4FqZ9b5mDv8zzUOvRp8yXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eiqNBbsm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BFNw7Yx006313;
	Mon, 16 Dec 2024 09:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=s7CDuadi59DbdJQYtEXF2MmygEGRsK2onQV1LrfHL
	MQ=; b=eiqNBbsmW3n9RWcPP2Z4o16EGaw8YwZW272w9W2Z6gEernZA1TG37DVqF
	GP4qS4LswrgsfCsDQe4mtaa3AKB1CXK1SMLdUmkoWUT+ADRe+dJGegDn4lsxdlZG
	U1FV1KKhOAhvsiIeEu6s4APiLreYK+nm3KqRNAlgQtRixOqQxnlOHcyJ+tq0cx+a
	Gm16tFkda1w1HmLbGUoy95BnIoYqAIM4IrryTeCR55iw93hgyYBg+hhWZvKDMZax
	tTfA88meVun/EkZhw+9O24kvR4M5/KIjJgvAPdkwW3LNfJ59TBR4fCbRBqCeEdh7
	YNjH5/FbSsy61youE5Pin6Obs3CWg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43j98h20d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:22:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG6BEJm011252;
	Mon, 16 Dec 2024 09:22:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hpjjw0na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:22:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BG9Lwgx52494770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 09:21:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A99620043;
	Mon, 16 Dec 2024 09:21:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5005620040;
	Mon, 16 Dec 2024 09:21:57 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.0.126])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Dec 2024 09:21:57 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Dominik Dingel <dingel@linux.vnet.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 0/6] selftests: kvm: s390: Reject invalid ioctls on ucontrol VMs
Date: Mon, 16 Dec 2024 10:21:34 +0100
Message-ID: <20241216092140.329196-1-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ioP2lhAIBxCiOCbpJk-EVV-7_VVCGrrn
X-Proofpoint-GUID: ioP2lhAIBxCiOCbpJk-EVV-7_VVCGrrn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=754 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160074

This patch series adds more test case issuing ioctls to ucontrol VMs and
its floating interrupt controller.
The test cases trigger three possible null pointer dereferences within
the handling of the KVM_DEV_FLIC_APF_ENABLE,
KVM_DEV_FLIC_APF_DISABLE_WAIT and KVM_SET_GSI_ROUTING ioctl.

All of these issues do only exist on ucontrol VMs. Fixes for the issues
are included within the patch series.

v2:
- added documentation changes
- simplify uc_flic_attrs; remove .getrc and .setrc from uc_flic_attrs
(Thanks Claudio)

Christoph Schlameuss (6):
  kvm: s390: Reject setting flic pfault attributes on ucontrol VMs
  selftests: kvm: s390: Add ucontrol flic attr selftests
  kvm: s390: Reject KVM_SET_GSI_ROUTING on ucontrol VMs
  selftests: kvm: s390: Add ucontrol gis routing test
  selftests: kvm: s390: Streamline uc_skey test to issue iske after sske
  selftests: kvm: s390: Add has device attr check to uc_attr_mem_limit
    selftest

 Documentation/virt/kvm/api.rst                |   3 +
 Documentation/virt/kvm/devices/s390_flic.rst  |   4 +
 arch/s390/kvm/interrupt.c                     |   6 +
 .../selftests/kvm/s390x/ucontrol_test.c       | 194 ++++++++++++++++--
 4 files changed, 189 insertions(+), 18 deletions(-)

-- 
2.47.1


