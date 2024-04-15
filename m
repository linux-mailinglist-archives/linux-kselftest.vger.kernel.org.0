Return-Path: <linux-kselftest+bounces-7989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4638A5598
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14C19B22049
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 14:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BAA71B4F;
	Mon, 15 Apr 2024 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J/8KNIn1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3611E52A;
	Mon, 15 Apr 2024 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192735; cv=none; b=teWM4QxOkdC57y3VMLjXrZi6TNpyfMTbnbdV0wf4oVrKVdNz0YtN3qLvGRLXY1J+tuZRXckXRbZc04YfwSCafGUDsQmUmZHwO+zQat+gZXIMtf789gDSSW0hAPaxS6M/qg9lgfR6BdEN22qJsW/lcEy3ZTKFaP3cl50g8jOaJFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192735; c=relaxed/simple;
	bh=JrjwZDSK1xsC8X65AoUHKJtl1BMmtd6zoPIlPcHRKQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahcjPBElUOtWS/uhZj6eKJsmRRdqvQZDdtsZC9qVyhnE+LJCGFfNVwG3NDcaQxMP5XkVy9oweVz+kaVokV3ll4srMwVSVinmbbbBU2TLY/jGhEqzaQNrk08Yw2vwY2eKXawszFLkQn1NlYiiA9zpCKTdMRwLTqnFEXm3W9PD+Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J/8KNIn1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FETQDr007066;
	Mon, 15 Apr 2024 14:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=O96ldazLk0ZQV95WUC8Xi+BiOKFMt4aoAGFLPkYn+VQ=;
 b=J/8KNIn1oIscZmC7O3HOGKiwpt6FFUuR04bNP5NFAAnTq7uhT6m4v1LHwcBR2m5paXpL
 TmTYZu9o3EgBCt0z/PqyPbfnqHEsjAZhY4ImLyp/hTnRDJQJ5ajdv4Ja9rFTAPvnxEU5
 tFCfsgg6NPWo6cVtYPwwM8hXCU7PNilfpGnAjCTxnr+uFgS1AjlzLXiaslJvY2SaqxEb
 nZxFwYDxb36sqRLrhGm8XTP7eDXu6b2ZP1YCcBmu3K4Q+E7NIq+1JGpeo/8OkIk0nM5T
 R25uEkxHYz0+0sHlyi15poFjS/AhhHkCQLrYvIHtdMtawmOLAoOScAX6tIE9fuxN6tFe FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xh4r0r80v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 14:52:09 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43FEq9Nw010129;
	Mon, 15 Apr 2024 14:52:09 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xh4r0r80t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 14:52:09 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43FCNOrr023681;
	Mon, 15 Apr 2024 14:52:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5cnre1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 14:52:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43FEq2i211403734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 14:52:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A5572004D;
	Mon, 15 Apr 2024 14:52:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64D7320043;
	Mon, 15 Apr 2024 14:52:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 15 Apr 2024 14:52:02 +0000 (GMT)
Date: Mon, 15 Apr 2024 16:52:01 +0200
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
Message-ID: <Zh0/EaRmNqGAo0Bo@tuxmaker.boeblingen.de.ibm.com>
References: <20240412084329.30315-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412084329.30315-1-david@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RpJoQoTbB6ln9BBhjyX_vPpnUfie5PFK
X-Proofpoint-ORIG-GUID: avAcKcN0NG5JppCJT0GGz0-e2SO3sBMk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_12,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=788 mlxscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150096

On Fri, Apr 12, 2024 at 10:43:29AM +0200, David Hildenbrand wrote:
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../kvm/s390x/shared_zeropage_test.c          | 110 ++++++++++++++++++
>  2 files changed, 111 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/s390x/shared_zeropage_test.c

Applied, thanks, David!

