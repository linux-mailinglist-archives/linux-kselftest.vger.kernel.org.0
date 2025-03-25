Return-Path: <linux-kselftest+bounces-29732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FA7A6EA5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 08:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33FC1897100
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 07:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53685252914;
	Tue, 25 Mar 2025 07:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W9nj+wnD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920952528EF;
	Tue, 25 Mar 2025 07:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742887142; cv=none; b=SfNbVSbeoSi+oIG6gRYH7pUIyNZTPkRHZJcChRqVwTplqevv9O89q6VnuQ9qq5Qqz9j3vVudjInm2VvuMJTw557ojqCqeYOGh9M8wQ71R27Qq9LbDlpEJM9HwcIAbNM0XsQ1C57Lih15YJRTJ+AC3L5oPaNIWnnnpJNhlcUogI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742887142; c=relaxed/simple;
	bh=YmsmDvk1eDJdWuGZWu65fR0f6nXMIm/0tiNweNHUDEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGBlaye921aLlAjyfykcf50NWmwu7P0usIQgSS04uORTUbCgThPyXbiVRfPpQzO5CCS+C6L2U92BSXTg90eSor29CMRAAX+CmoZAOk57Z/LQB5sxiKtwmyDlpc+rJWD+lGbbcH3B2rs996GPdO44B0avIpF230bU/iZTuI0tDlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W9nj+wnD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OKd9Kn025385;
	Tue, 25 Mar 2025 07:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5f+/pj
	WXI/gI8XUyHfAD2JcQiCYo3UKqJIx4hlCMUas=; b=W9nj+wnDW7Lycmzfwf5sSP
	IiS7+KagsWbY+ejmLifJewXo+1VsD38MWdMuoxAFidr3RsRs4wiHBugFDOzXAhPR
	B0UeXdOODh9La+UkjlEVvXXKMZvShj24ZbDKDaXmNFWlnAdEWdiYJMu/JALeJAsn
	PEH66N9u2QOosCFBqcn4NBh7ZIMFXh9LmMt7lMjNAZNH+l4wXm7e/OTaoSISjWE/
	SZ0xPy+ABtiIkECYxU+nDBpMiEwlGuybYqtazLxbHy2QiZqQJ4svYOZWfdj7pMOK
	WlZIPJ8/IXJTbisZgj9MeNaAr78biWkucpDHSkjVZBt92LrJY73a+C9Po2TcQhqQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kekyt3ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 07:18:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52P6VdJe006295;
	Tue, 25 Mar 2025 07:18:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ja829uts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 07:18:43 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52P7IfTC50725150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 07:18:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B511720040;
	Tue, 25 Mar 2025 07:18:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 858692004B;
	Tue, 25 Mar 2025 07:18:41 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 25 Mar 2025 07:18:41 +0000 (GMT)
Date: Tue, 25 Mar 2025 08:18:40 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 3/3] selftests: vDSO: chacha: Provide default definition
 of HWCAP_S390_VXRS
Message-ID: <20250325071840.7910A12-hca@linux.ibm.com>
References: <20250324-s390-vdso-hwcap-v1-0-cb9ad001ceba@linutronix.de>
 <20250324-s390-vdso-hwcap-v1-3-cb9ad001ceba@linutronix.de>
 <20250324155513.12139G44-hca@linux.ibm.com>
 <20250325074319-b478adcc-3e04-447f-81b5-c92741c91bfd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250325074319-b478adcc-3e04-447f-81b5-c92741c91bfd@linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tRHRfYYFR4bGTRgxKEHPQDB4M_afMlWi
X-Proofpoint-GUID: tRHRfYYFR4bGTRgxKEHPQDB4M_afMlWi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=542 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250047

On Tue, Mar 25, 2025 at 07:48:48AM +0100, Thomas Weiﬂschuh wrote:
> On Mon, Mar 24, 2025 at 04:55:13PM +0100, Heiko Carstens wrote:
> > On Mon, Mar 24, 2025 at 03:03:17PM +0100, Thomas Weiﬂschuh wrote:
> > > s390 does not provide a hwcap.h UAPI header.
> > > 
> > > Add an inline definition for the constant HWCAP_S390_VXRS until a proper
> > > UAPI header is introduced.
> > > 
> > > Fixes: 210860e7f733 ("selftests: vDSO: check cpu caps before running chacha test")
> > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > > ---
> > >  tools/testing/selftests/vDSO/vdso_test_chacha.c | 3 +++
> > >  1 file changed, 3 insertions(+)

...

> > >  #elif defined(__s390x__)
> > > +#ifndef HWCAP_S390_VXRS
> > > +#define HWCAP_S390_VXRS	(1 << 11)
> > > +#endif
> > >  static bool cpu_has_capabilities(void)
> > >  {
> > >  	return getauxval(AT_HWCAP) & HWCAP_S390_VXRS;
> > 
> > How did this cause a problem?
> > 
> > Did you use something different than glibc(-devel) on your test
> > system? Just wondering since glibc-devel provides the define since
> > ages and is also required for getauxval().
> 
> I used nolibc (from the kernel tree at tools/include/nolibc/) to make cross
> platform usage of the tests easier. See also [0].
> I got confused by the existence of hwcap.h in the kernel UAPI headers for
> various architectures and didn't check the libc headers.
> So this isn't really a bug right now, and the hwcap changes will only really be
> necessary once my other work goes upstream.

Thanks for explaining!

Acked-by: Heiko Carstens <hca@linux.ibm.com>

