Return-Path: <linux-kselftest+bounces-27651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253B9A46B3D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 20:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2665016C2F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 19:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0C7244EA1;
	Wed, 26 Feb 2025 19:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JUlJ19yh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCFD21D3FD;
	Wed, 26 Feb 2025 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598754; cv=none; b=kn8DEnZ14GVqDWlud/FOo2O+f4Eh36X9aaXUQmMFvhRvdJlnmvmW4jughI4n1ljfwB3A5DNNtHKCydoZe8C8Fb/jBS3xKT4HE4THAFEhL/v68XW8WnCpfV3mwhZhkD38OekuPVRr+Righ+0ZlHF1qvufm7sfCtmoDWDf6AYU9KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598754; c=relaxed/simple;
	bh=UE+m9vv62bRQym/uRamfQ8UcEzNrpPotmPVrRKnG6wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FskPs3wxShgkFOIVSW7kqo0quT3KX2ct6auqHRmVd3VLBqlpAdAtNdP00Zm48CX2+8W5/4xkEekXkcJEM7sR34JWqsCvBKXuMrwWPce7YfRY++Fr10fPJIkuBc8DcTK+RKJPOq4MIZYWZI1wNdgBOdITAcED6+zPAbl4WACvkQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JUlJ19yh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QGAbgO007251;
	Wed, 26 Feb 2025 19:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2NodUu
	DqBVgh06dQFbOnbxo6Vyl/71hN00dWquC3Hbo=; b=JUlJ19yhsTkUXsoA1AI8Bf
	xI/lDy0PPo2UPm221VeybLrn0su/4FdAzWpCPmnxV2v+g4j5cjaaq3tqhOLJRPIf
	1qqZ8REniygf6CGrC7mStIygwzXRmOK1mW3oqNZPaNXP1z6HbjxlvAMcYbOY0La9
	GfO/l05FBGK3Mf6l8832A6hhm+TuIKo0g7BG99QSz9hnUE6+dXBSNoUV/y6O0SH7
	dD3+dRbfLQxYLx4XpSTUqDOIEiz+UBoiOSTl4b9xsWme6/POBCMY0BZEa3CfcSm9
	XtP/JW7Yr4Xlnl7jwZYhctrmyArlR+PfRlOUm0oesA50IFEygWzk01X5GgH6hkQg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451xnp3ggy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 19:38:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QH4YBr027333;
	Wed, 26 Feb 2025 19:38:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum245uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 19:38:04 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51QJc12p17826152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 19:38:01 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28C2020043;
	Wed, 26 Feb 2025 19:38:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 882C120040;
	Wed, 26 Feb 2025 19:38:00 +0000 (GMT)
Received: from localhost (unknown [9.179.20.154])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Feb 2025 19:38:00 +0000 (GMT)
Date: Wed, 26 Feb 2025 20:37:59 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Fangrui Song <i@maskray.me>, Xi Ruoyao <xry111@xry111.site>,
        Heiko Carstens <hca@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/vDSO: fix GNU hash table entry size for
 s390x
Message-ID: <your-ad-here.call-01740598679-ext-1013@work.hours>
References: <20250217-selftests-vdso-s390-gnu-hash-v2-1-f6c2532ffe2a@linutronix.de>
 <your-ad-here.call-01739836346-ext-7522@work.hours>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <your-ad-here.call-01739836346-ext-7522@work.hours>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K5XKfpIqAJHYF1z-CT97MdAtdrnzuwQs
X-Proofpoint-GUID: K5XKfpIqAJHYF1z-CT97MdAtdrnzuwQs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=644 spamscore=0 phishscore=0
 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260153

On Tue, Feb 18, 2025 at 12:52:31AM +0100, Vasily Gorbik wrote:
> On Mon, Feb 17, 2025 at 02:04:18PM +0100, Thomas Weißschuh wrote:
> > Commit 14be4e6f3522 ("selftests: vDSO: fix ELF hash table entry size for s390x")
> > changed the type of the ELF hash table entries to 64bit on s390x.
> > However the *GNU* hash tables entries are always 32bit.
> > The "bucket" pointer is shared between both hash algorithms.
> --
> > On s390x the GNU algorithm assigns and dereferences this pointer to a
> > 64bit value as a pointer to a 32bit value, leading to compiler warnings and
> > runtime crashes.
> 
> I would rephrase it as follows:
> 
> On s390, this caused the GNU hash algorithm to access its 32-bit entries as if they
> were 64-bit, triggering compiler warnings (assignment between "Elf64_Xword *" and
> "Elf64_Word *") and runtime crashes.
> 
> And take it via s390 tree.
> 
> Shuah, if you don't mind, may I get your Acked-by?

Hello Shuah,

friendly ping. Could you please respond with "Acked-by" if you don’t
mind me taking this patch via the s390 tree? Or let me know if you plan
to take it via your tree.

Thank you!

