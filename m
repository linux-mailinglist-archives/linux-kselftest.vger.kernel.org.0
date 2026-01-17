Return-Path: <linux-kselftest+bounces-49228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0816CD38DB7
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 11:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6236D3020165
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 10:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C4225A62E;
	Sat, 17 Jan 2026 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XWY6bvHw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A73C19AD5C;
	Sat, 17 Jan 2026 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768645440; cv=none; b=exw+lLYdD3KP4SxRD5Zz0BTbmSO+op9KUPNLuo502FBibtU9bFL/2mXf+Lg4St0VhSTCKR0TdQktmpmADJFhmRenHEFIIvkF6AFSW3dNhdDMUzHKYqrwnWtraK4Qkw8HpjhI6tMDGQggC2/0iv01svf1Ed9kxCtfL+u+cQrNokw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768645440; c=relaxed/simple;
	bh=9+ruWewyAAsIpasFpeVzHvNgGJi63jz+cSzg2OhCkD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgMhWL5mJIcMIhOgrzLV2MxhVMSswecV47tJclpCfWOFx4F83ZLmieenv2+XegHibzOqZLKisu5U9B7GG6I1H+c9oRaYx3cRwxzPBhCkgOQBSSKWaKLOWXie09+aj8bq3Dq74b7TWt+Ns50vm3zEL6UyCjwFtrSe4Nyp8M0bPVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XWY6bvHw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60H9kX4h024330;
	Sat, 17 Jan 2026 10:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CUSquB
	lRCbu+cnGUxuLnQwBFojySlmEz7lFaSiF3+sI=; b=XWY6bvHwR8gqHfVatgB4gh
	yGUu8CgRrY3cjjrXTBZZgrnAVUdwYAROXIBUfDC8iXAUOsh/QzaZ2obrnO3bhDD6
	euRKJxhA79uREXIaFTjY31QZgloyR67LouG3aP4fGRVR5rN8NZlHwQXZJGXAupW3
	AVAA9sD5cUqRkxoFEfBmW/lW6qMbfQvc408gq0M2LH9l7BEEuXkBBwe6wH/etFlj
	VVxb/h+WicdlT9aXqme+2L2sFkPueEJ+BAHfDLsyNydnT6eBp8FL6whfaVl5uMuC
	MA6YS3FBq/2h+aPCpYFIrEHJKLvo1OSfzNt0P7c0QOvMjr+eYwt9bRuwaY8g5OVg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23rgxnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 10:23:23 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60HANNhH020392;
	Sat, 17 Jan 2026 10:23:23 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23rgxnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 10:23:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60H5b6ps027820;
	Sat, 17 Jan 2026 10:23:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bqv8wtk1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 10:23:21 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60HANHSh43975068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Jan 2026 10:23:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DA1020043;
	Sat, 17 Jan 2026 10:23:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89B1520040;
	Sat, 17 Jan 2026 10:23:11 +0000 (GMT)
Received: from [9.43.67.105] (unknown [9.43.67.105])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Jan 2026 10:23:11 +0000 (GMT)
Message-ID: <4728530f-41c8-4a26-aa8a-30f53f1fe629@linux.ibm.com>
Date: Sat, 17 Jan 2026 15:53:10 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] powerpc64/bpf: Support tailcalls with subprogs
To: adubey@linux.ibm.com, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sachinpb@linux.ibm.com, venkat88@linux.ibm.com, andrii@kernel.org,
        eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, memxor@gmail.com,
        iii@linux.ibm.com, shuah@kernel.org
References: <20260114114450.30405-1-adubey@linux.ibm.com>
 <20260114114450.30405-3-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260114114450.30405-3-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ng6asMzW3uKJzarXjSutdbXzQzx0rxcL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE3MDA4NCBTYWx0ZWRfX8TmSMslTMghW
 Tk0jZXS1PaHbIBAXpZNs+FUzVQvGkIq2ZLVfsagAirL7PGd4fvTSuHkLausxtSVqNO1WZUEZ+v+
 gAIgRqIL6Tj7A/aJaZ4uiyNFG5YLKtGtDvsVpGGK9hPLXsVNvFe/MKIVcs87g3ICoITRlWXU1f1
 GvFN3pdDy0J41TOIE7qxbjslEA8twIDp99ELaW81MIQMjuhLOBj3gmcCb+r30jdVFCszAdhX7dP
 M27rxtxwnv9H75wpZzDxxpZRmnVTtDBx0tNLCOAmvb3AzEEBcORE+Nzcmhn28IRIuS0yB+aKFeG
 k16Qt5YBS4bwCp1VMLQX7oq9iOSYICH/uZoBcE/Mdi0bWtnBJEhST91vbBBf+mG9Hrb5Ra9DCRv
 HXWf7TJoihTbYzD1lVYQ0NkfMqvSTn6jDJhUeXYQm0dw24MNPyfxoQ4ht0VwXrEh1rrZfd9slM2
 TVweamg7XPo94YbcqKA==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=696b631b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=ZXRHoZGWT0CIhGHxh5MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Ffd4gLHO7pbALdnPDjaTPn6owAgbrQ2o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_09,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601170084



On 14/01/26 5:14 pm, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey<adubey@linux.ibm.com>
> 
> Enabling tailcalls with subprog combinations by referencing
> method. The actual tailcall count is always maintained in the
> tail_call_info variable present in the frame of main function
> (also called entry function). The tail_call_info variables in
> the frames of all other subprog contains reference to the
> tail_call_info present in frame of main function.

I would rephrase:

"The tail_call_info variables in the frames of all other subprog
contains reference to the tail_call_info present in frame of
main function."

to:

"The tail_call_info field in the stack frame of subprogs contains
reference to the tail_call_info field in the stack frame of main
BPF program."

- Hari

