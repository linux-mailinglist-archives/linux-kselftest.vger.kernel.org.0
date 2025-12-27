Return-Path: <linux-kselftest+bounces-47972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFEFCDF418
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Dec 2025 05:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A35C33008896
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Dec 2025 04:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A752224DCF9;
	Sat, 27 Dec 2025 04:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P5OaCtnk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABE6239E63;
	Sat, 27 Dec 2025 04:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766809472; cv=none; b=TDwxZNOX3gnpOBrotxYLS8T63jKD99YcNz3Svh0MdlRdDKiZ68+RnnyZio25lRkazzXgd06KXyaqn+T84vb1h0M7gJsNK8x6Z/GH5ZrC2BN+S+YTvlX12YjIv46+5KKChCdIvnNsiB62biwI5Xj7ysd7Df3168FV6CQ5Ktjiu9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766809472; c=relaxed/simple;
	bh=0m0IUyh1qgdS2/DqcwxcLXWiO3+eicNUWxovMIf4IQU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGhBDVkOxRcZFvpuusxiHHaTXWJZUy4SxpljKFg7Q3nqJNCqhV3kHxlPwr66BjsvA1dEf5nzhRzgcjvFe0lqgxIOwWO+flD2+6dZ4YBI94B61WQgzsk1CI57zdOjQVqdvufdjL9ovPZqKKuOL5MhgNh96P/2OMrplVB90zkOYOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P5OaCtnk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BR2upmV010535;
	Sat, 27 Dec 2025 04:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Uc3XXm
	uzw+rGlrmHsoHoZKbq47rkIBsTmwgWoQtDbPg=; b=P5OaCtnkURd8VndWJ5qBeq
	pRuOJHtQTA0RZytQ4FmJ2iH0KEoAvtE64MJ1qSZYPPH5Uzx/Yr2lRB3torh/nYDy
	kddBDHdHBt2xNxUXWKBSu+I5p/po235JCaQUUbRSl3KWDOa5+cD+U66VzRnxu5DU
	4nLqttrh/ktnlj8DR7ybgFFL469NtsWb9I5SMwy8bEZmERyCBgaNnOFrbu6dJJYG
	PfDhF0dmO471+g4jGrxfcksVywhJbbBkm8z7zEPbzesGaMb3t/A4xQ9O45F4E31j
	hg6ILcVf6No4fUnP3lGpYR+rOt8xRyufjJ+Yhgg4zBqSpvCK0UOltvTfPh5jYjpw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba73vg4r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Dec 2025 04:24:09 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BR4O8vX027333;
	Sat, 27 Dec 2025 04:24:08 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba73vg4r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Dec 2025 04:24:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BQMjMa1005249;
	Sat, 27 Dec 2025 04:24:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b67mkjgr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Dec 2025 04:24:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BR4O6Zl37945646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Dec 2025 04:24:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C29220043;
	Sat, 27 Dec 2025 04:24:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E4EE20040;
	Sat, 27 Dec 2025 04:24:03 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.124.212.100])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 27 Dec 2025 04:24:03 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, shuah@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
        skhan@linuxfoundation.org, Christophe Leroy <chleroy@kernel.org>,
        Gopi Krishna Menon <krishnagopi487@gmail.com>
Subject: Re: [PATCH RESEND] selftests/powerpc/pmu/: Add check_extended_reg_test to .gitignore
Date: Sat, 27 Dec 2025 09:54:02 +0530
Message-ID: <176680916366.22434.4135136741244197220.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20250922004439.2395-1-krishnagopi487@gmail.com>
References: <20250922004439.2395-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8MdMPsW4acrGCwy_kz-BY5H7ayiMWajr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI3MDAzNSBTYWx0ZWRfX55K3sAyBWSj6
 ZmwLqmLCSUIz+0Ph5k/UARba5NwHuhK6fgXzvRy4FKqk/c+IXpTzzsc+EIe2EK3E1Apx6xsHCmA
 JB+FBOYyXw8YTU45ZERwDkeIV6Vpudipuhfu9coDGA30K9wFgXUyYmPzZ4epKdcCUI7Gs6zXwwU
 DweuEpNTVcMfqijchhGpBFjPnS551Wgro7TaQL/SLKFRC0pUkMtAwtc90yyiVsi0QiZIfQzRwBj
 J75mq870VoC28rnr7U+MEcETq6XVTSEkC/kqKBgjMcqhy5rlMAKXrzWLRgka0UOgPcnaCubEGw5
 c2GrNJvf8NYb8tGKvoFRoOnVi9X4WtZOkih2HGh5kK7dItO2KLAY0zxvSR4LZYW8PYr03fOYS2S
 jl5Oyf7Wg/bDS9vtzpvpFwk0zSozQe8yO4frchSNbLZFSD8yej+fCb64/pZIMjtg5iFad0ZSJws
 WTJKhQVhvsu1YReW7jg==
X-Authority-Analysis: v=2.4 cv=fobRpV4f c=1 sm=1 tr=0 ts=694f5f69 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=gLboIuWc-4I6dfgw9HwA:9 a=QEXdDO2ut3YA:10 a=UzISIztuOb4A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: FmnG9omquVb8lvckOcda3mYZmBSOh5VN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-27_02,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512270035

On Mon, 22 Sep 2025 06:11:23 +0530, Gopi Krishna Menon wrote:
> Add the check_extended_reg_test binary to .gitignore to avoid accidentally
> staging the build artifact.
> 
> 

Applied to powerpc/fixes.

[1/1] selftests/powerpc/pmu/: Add check_extended_reg_test to .gitignore
      https://git.kernel.org/powerpc/c/42f53b39004f45a6091109176c62ba33cc52ff96

cheers

