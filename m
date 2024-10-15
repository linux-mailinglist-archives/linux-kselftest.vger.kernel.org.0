Return-Path: <linux-kselftest+bounces-19737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABAF99EF09
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 16:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAA2A1F225E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 14:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094F91AF0AA;
	Tue, 15 Oct 2024 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N3tfYFbP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A9B1B2190;
	Tue, 15 Oct 2024 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001646; cv=none; b=NEtSThhbV5cLVRZvqHkPcT37veOzWzR79FmHaFBsghCRhN90fuB6GT0caDqHlLSmjx8VyrgDg4+yiMWVWxGXOXDNMVeBXpnllYRDu/X7SfqxHowXtyh7phAsqk66cxEIkUV1/liZ2gJGx2AVNGz6XCLjrtXX0L+C+rzUd29/XIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001646; c=relaxed/simple;
	bh=+yl6DaENwoDke1XWWndVkd+MbMm7iAHGKATG9p1j9QQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=dnDhyw2tHcTD1TpNtNd06rfqWmTk/th139InvFxeEiD81dVDBH/o5C2atQ2+X4NKnf+vhOEYLlx8XxXK2KquINLStEMbBsc+JRphpOAv5nTLeBjAEgF76YxKUb7BOhjGyHE9PLFF8Ia5PXd5AAngHNY1RinNLkTRuwN6jP6X7aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N3tfYFbP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FCP4El012311;
	Tue, 15 Oct 2024 14:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+yl6Da
	ENwoDke1XWWndVkd+MbMm7iAHGKATG9p1j9QQ=; b=N3tfYFbPP1QrfgOKPu8n6l
	NtTbx0Ba+0JPE2rJH9HjqXcau0oSBM4Q52uhzUTzfP20OaF6c1248X8cDk3bYARh
	K91NrgOMYLis+AfsTFXkwDh7sxKX2u0bsmLY6iQA3Lf1DGazVBeNYC5i31hMdahU
	k/y4T7DKl8xdlz6CggdL071MdKbjOtM95ns3TwNSPOHcH78QvwpXQDhkiEpXOPR2
	TlLGlbKX0lvUxrYgp9IVT56FVJMlDGobnjJVBapLATKsLy9UC9I1ilPqpm1rEMdX
	WFk+OVRQqj5CTURvdfMZiDUP48AurzASS4pyI1FJw6z0Ew4Xuy6L5Bzx/FiLXJ+A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429rcerkyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 14:14:02 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FE9i5V014583;
	Tue, 15 Oct 2024 14:14:01 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429rcerky9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 14:14:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FB1Qfr002408;
	Tue, 15 Oct 2024 14:14:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284emm9au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 14:14:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FEDuqq52625726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 14:13:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F0C62004E;
	Tue, 15 Oct 2024 14:13:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ECF42004B;
	Tue, 15 Oct 2024 14:13:56 +0000 (GMT)
Received: from darkmoore (unknown [9.179.10.245])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 14:13:56 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Oct 2024 16:13:51 +0200
Message-Id: <D4WFXC1EVZIE.3KIW0P0Z39PBA@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        "Paolo
 Bonzini" <pbonzini@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        "Christian
 Borntraeger" <borntraeger@linux.ibm.com>,
        "Janosch Frank"
 <frankja@linux.ibm.com>,
        "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        "David Hildenbrand" <david@redhat.com>
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v6 2/5] selftests: kvm: s390: Add uc_skey VM test case
X-Mailer: aerc 0.18.2
References: <D4WF2493HS7M.QHC37L73T9L5@linux.ibm.com>
 <20241015140623.54529-1-schlameuss@linux.ibm.com>
In-Reply-To: <20241015140623.54529-1-schlameuss@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _slZHKJWtnyvmZOvHZ3VJgz5JvAXoM4L
X-Proofpoint-ORIG-GUID: gaLH0zS6Pfq8pfmZG8bd6fNdE_3Xc6ta
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=430 clxscore=1015 phishscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150097

Please ignore this one. I tricked myself in my patch generation and regener=
ated
the original patch.

