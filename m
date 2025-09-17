Return-Path: <linux-kselftest+bounces-41727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA4CB80779
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 17:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B7A188A8BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 15:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B04D332A27;
	Wed, 17 Sep 2025 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kdxUpA6n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D0636D;
	Wed, 17 Sep 2025 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122054; cv=none; b=rmUYSjaTPcF8aZgRANMr4s0kKdN2VVgWZyI5Rq00P0VKSKNXYm9k4dbx1MYxV/vlN1JxmYqL0YKy9kblxUSFqWalu7h7GGowm0ILfJTxQ3lTdZ8tR1f5QJiQ2abDQvhIA7xzgdyez2kDtKd/jkfJcu6eEMoSHDj2i+41uEOSDjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122054; c=relaxed/simple;
	bh=GY7K1aT3tuUAjWTK54bkuu3gu8Ndi5nWOnazTRGkPWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2ZW8zduobd/GibzooqG1DwBE4ehXyjHO8NbynAm/H+oUT91w77fMzd5H+ZIhw2HYIhh+GrDsFg6rb4NNnX4+spUGv7T7z/SmJwb4NAm/k8kslNrhGGIO4M2G/8gYUuWR9zaq4UCHFROT/WMxwoUtPJukTOzy1Wr/U987z7aBbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kdxUpA6n; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HB2heh031364;
	Wed, 17 Sep 2025 15:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Gpbsl9
	9AcwvMMY8pjAz45RrL3lV0my41naP5Lagcwqg=; b=kdxUpA6nW5Tmi7rGB3AJGR
	NM/xNi5WIURhafGfjEHgdYGB/psocIFarKbLZ7LR+Xi/jETeHKEloI5I2HX/qqfU
	Bw/WhoOHsJKnFaPkecwpriLEG/ZyJitxlMMNELYp7qCZLx5Npqe/zn8hm3XPgwhC
	l+PBZEdcPvlprtcxn3x5dt84pRqYpc7U3cfTn3dW2pzL+3/lWD/I6q7U46UHtbji
	IqD0yPQyJs7nSLrExCmTcnhUGCyGTEK2EOM1a2I6/Ufxa+rqU7cP2qp3dmd79kFq
	WX+YEdoojkGTAJa3RoNX4kIiWGtUajT7XIe8Y9oTHLdeXx/vRgxo1jzZ2CbTPo6Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hmj47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 15:13:07 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58HEej22030065;
	Wed, 17 Sep 2025 15:13:06 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hmj43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 15:13:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58HDRm4L029498;
	Wed, 17 Sep 2025 15:13:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kb122kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 15:13:04 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58HFD1rn61604222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:13:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A51020043;
	Wed, 17 Sep 2025 15:13:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFF1620040;
	Wed, 17 Sep 2025 15:13:00 +0000 (GMT)
Received: from osiris (unknown [9.152.212.133])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 17 Sep 2025 15:13:00 +0000 (GMT)
Date: Wed, 17 Sep 2025 17:12:59 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Nick Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Russell King <linux@armlinux.org.uk>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Shannon Nelson <sln@onemain.com>, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 20/36] s390/time: Set up vDSO datapage later
Message-ID: <20250917151259.29680Ba8-hca@linux.ibm.com>
References: <20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de>
 <20250917-vdso-sparc64-generic-2-v3-20-3679b1bc8ee8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917-vdso-sparc64-generic-2-v3-20-3679b1bc8ee8@linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -lB8-8Z2vm3Dr2RcdiTeItlnik0kFd3-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX0LRupd/nMATB
 xRH1x3KPf+TeGsBgHzb9CxxubzjsPM3xnWjDFBXVrXb1xnl8dkY4T15BQGOP8AXD1NzuOTVMI9T
 vyt++8gNnq27pcVi2bYCJP2Zpv85C47f6+JnGasi5qzD4b22Pw8Tfd54sawYgj/G0nN6qX4T+2t
 KxWPoCxw7oflQSA8CrXDGMKVfJ2GY1fGWARKyxRnD13aQtZjs6NrRvJl8QAdmjvZRG/l8MnuZhS
 1G/MCeX/1CDgCgS9UnA+Qf1KwX9KGF/03p/MXyO2dxPmZjecD5qvqxQ2OqtIWFAs2LDX0H7HXO2
 1nPDh0fFMqwAjjUFIZbTuRTKdnI0IGr7TwS3bye7rcJIUN/UE+jxDh65KInj/nk1m1BgQN9b8vk
 KjCbgU2p
X-Proofpoint-GUID: 9tPi08vdJaon8TFVV3QLHKMPbM8_3wa7
X-Authority-Analysis: v=2.4 cv=co2bk04i c=1 sm=1 tr=0 ts=68cad003 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=IMH0LFUbUW6ywGf4fkUA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=0lgtpPvCYYIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160204

On Wed, Sep 17, 2025 at 04:00:22PM +0200, Thomas Weißschuh wrote:
> Upcoming changes to the generic vDSO library will mean that the vDSO
> datapage will not yet be usable during time_early_init().
> 
> Move the initialization to time_init() which is called later. This is
> valid as the value of tod_clock_base.tod does not change during the
> lifetime of the machine and the vDSO datapage is only used much later.

This is not true; tod_clock_base is a union and the tod member is changed
implicitly within clock_sync_global():

	tod_clock_base.eitod += delta;

However that happens only in stop_machine() context. Therefore moving the
initialization to time_init() is indeed ok, since it is called very early
when even preemption is still disabled.

I would appreciate if you would change the commit message a bit.

In any case:
Acked-by: Heiko Carstens <hca@linux.ibm.com>

