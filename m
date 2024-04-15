Return-Path: <linux-kselftest+bounces-7967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 854668A52F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3875F1F229CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 14:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B0474E3A;
	Mon, 15 Apr 2024 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fji4A0Zh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE97274C0C;
	Mon, 15 Apr 2024 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190797; cv=none; b=LNFIcSR9VlUKftL+L6e5pQlPrG0EEDlc69g4f1curg33OmiYP032Z26/t1lBMQYJU93Z6ZywP1LwWioHR2xmM4RbeQo+Kq3ucANDZWCBm/1RX5wryK3DIo1vkX+S+zochbjzMhR0SjtOPElt04cMnjE9r8BT/2te4hs8Li12WzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190797; c=relaxed/simple;
	bh=dY9MqYRHRSblztt6G5CqZs1JFTSKs4bDbhO3gGKGD9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eAH+cvFjXg0FZYt9xPPdEH/X8cHQ/sUvcLKo2FlXZFPQP3mkFx1aeYtyRELzPw3FYpvTNxMYJjW1rBhkApX8u++dDSdyCsjFXjlHqOP6/NCTqEsfIRVHPYstCBo+mw/JUfrl53DmEVlagrIpIP8NxabfJN9olzfYbepl+iuzgWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fji4A0Zh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FEA93H032061;
	Mon, 15 Apr 2024 14:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=yYN0iXWcoJJiantPVb/9gPgT9BaYF5YNtHpuEqT9lE8=;
 b=fji4A0ZhXCDrdJytiepWsq7a72AD7ZpY8aDsJtHtu66dRMuFH1QKCoF6CCxiEOLYUYC+
 ByDACJpqdSR1MKAXqOHCd0KhBD4mbuUKl5HmR15gdzTZSbhSMC1/S8S1POvMW+5COQDI
 l1pivmjBkRDASD89UUcx0rU0dmFNrwm7ce7q1QqabRBglb+QRQ36jd5RWT5nURbd01/3
 QT2GtNSuE6dC5pnNVqBRpNmvyTQKDmMeABHz21laUdRVjSCRY2nRHiDdn/JbWBQqcSY8
 VaOBk46Rai+HukRar70leGD/nLUWaTyKE/JOSA9bmZFmdRMrUXZFLVag79AHDsUceZuo +g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xff7wm82d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 14:19:49 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43FEJnFY014777;
	Mon, 15 Apr 2024 14:19:49 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xff7wm82a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 14:19:49 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43FCxcFJ023555;
	Mon, 15 Apr 2024 14:19:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5cnr9au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 14:19:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43FEJgb850987268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 14:19:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81C5320040;
	Mon, 15 Apr 2024 14:19:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55C442004B;
	Mon, 15 Apr 2024 14:19:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 15 Apr 2024 14:19:42 +0000 (GMT)
Date: Mon, 15 Apr 2024 16:19:40 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1] KVM: s390x: selftests: Add shared zeropage test
Message-ID: <Zh03fI2oA0UkE0Kp@tuxmaker.boeblingen.de.ibm.com>
References: <20240412084329.30315-1-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412084329.30315-1-david@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -OS8mCdrcK8rXay1uSeXBH_-4MLIOrwB
X-Proofpoint-ORIG-GUID: UxvNCPy4c2SrntS5NyDOJmtB_tCCC1Gx
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_11,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=860 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150092

On Fri, Apr 12, 2024 at 10:43:29AM +0200, David Hildenbrand wrote:
Hi David,
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../kvm/s390x/shared_zeropage_test.c          | 110 ++++++++++++++++++
>  2 files changed, 111 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/s390x/shared_zeropage_test.c

Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>

@Janosch, Christian,

I think this patch should go via s390 tree together with
https://lore.kernel.org/r/20240411161441.910170-3-david@redhat.com

Do you agree?

Thanks!

