Return-Path: <linux-kselftest+bounces-25673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 871F3A271BE
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 13:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB8C18818E0
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 12:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4811B20D51F;
	Tue,  4 Feb 2025 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dzKwy/C9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A9620A5D0;
	Tue,  4 Feb 2025 12:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738671811; cv=none; b=nBsUFidueI8Wk61+XqrAcbWLlmpNnof5aNYDVbW2uWpUPFAztcUw87auAyINaQhQVCg/DkLda1JOcmtQam+GbOPswlvKWKbNzX99KVymQR0fVmWTweZ5IlGGnjZGFVEzyKxmpluXcKYf2SM+Cr9s8WPrtIwf92kAbyig0M0g5hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738671811; c=relaxed/simple;
	bh=dG5tGVtQZTw25dqMdtJ1/zyy7NY53LArQnmaSzSHXlM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtLNAwN0xG48sfNxt9QeGXVIpaKX+4gjcJPPnAS+rsiMosCLHGG4J5mEqD8T+UoWRWTMmfiXMqm6F115tYl0Rn5ZUWWzv93gA+GkHg5w5xzlPxmaKyS3Oxcwn0fVhDHlqIPs5nwo7x8LFwd4YsAuI+juJYDhvUHWELqOhSU47gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dzKwy/C9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5145NlQ3008384;
	Tue, 4 Feb 2025 12:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UJ/Pfi
	/BfkwkEFANDeCNiXq+lhOSzYk/7Ikhm8IpmLU=; b=dzKwy/C9ik+0HIjNHd8nTE
	2zQpVD00//xmxf2wXK9XbKi6izU2Mq5Vv8s730Ducof6Ip34iQN6vogG+E6LGQJ0
	OpNSPWPyCWlk6fesqHMxr54iMLIiQmJh9qALHv7VWDklJCJPEU3X57MFrJo45eE9
	YbzwpYBbNuAEkq/iN5MHV7V4/iOTvt5okOcJLcQPZ5imXRKyy3klIyl3bhzgfSR/
	gmlM708D+g/Be8EQcSzM1xrxCrj/tLAGSLQwNm9tRyqLJyqygbbHLZZZkZhCXqKQ
	9AXUW+kcRynr80GU3vqnT6xmUGphKfEF+WUqBaxwfTPut/upvv9zvt2m3MX7ltUw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kcq7sw41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 12:23:24 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 514CNOG2024827;
	Tue, 4 Feb 2025 12:23:24 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kcq7sw3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 12:23:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 514Bda3b016416;
	Tue, 4 Feb 2025 12:23:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44hwxsbmcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 12:23:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 514CNJVT17891722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Feb 2025 12:23:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B085D20542;
	Tue,  4 Feb 2025 12:23:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E25520544;
	Tue,  4 Feb 2025 12:23:19 +0000 (GMT)
Received: from p-imbrenda (unknown [9.171.94.245])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue,  4 Feb 2025 12:23:19 +0000 (GMT)
Date: Tue, 4 Feb 2025 13:23:17 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank
 <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo
 Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Fix spelling mistake "initally" ->
 "initially"
Message-ID: <20250204132317.67d85b69@p-imbrenda>
In-Reply-To: <20250204105647.367743-1-colin.i.king@gmail.com>
References: <20250204105647.367743-1-colin.i.king@gmail.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -yyIbkPcCIgxgjB2b6kv5fNBMi9Us86a
X-Proofpoint-ORIG-GUID: X91T-z-FZSsJTojqkAtvXmRXxkwbzcY3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_05,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040096

On Tue,  4 Feb 2025 10:56:47 +0000
Colin Ian King <colin.i.king@gmail.com> wrote:

> There is a spelling mistake in a literal string and in the function
> test_get_inital_dirty. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  tools/testing/selftests/kvm/s390/cmma_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390/cmma_test.c b/tools/testing/selftests/kvm/s390/cmma_test.c
> index e32dd59703a0..85cc8c18d6e7 100644
> --- a/tools/testing/selftests/kvm/s390/cmma_test.c
> +++ b/tools/testing/selftests/kvm/s390/cmma_test.c
> @@ -444,7 +444,7 @@ static void assert_no_pages_cmma_dirty(struct kvm_vm *vm)
>  			 );
>  }
>  
> -static void test_get_inital_dirty(void)
> +static void test_get_initial_dirty(void)
>  {
>  	struct kvm_vm *vm = create_vm_two_memslots();
>  	struct kvm_vcpu *vcpu;
> @@ -651,7 +651,7 @@ struct testdef {
>  } testlist[] = {
>  	{ "migration mode and dirty tracking", test_migration_mode },
>  	{ "GET_CMMA_BITS: basic calls", test_get_cmma_basic },
> -	{ "GET_CMMA_BITS: all pages are dirty initally", test_get_inital_dirty },
> +	{ "GET_CMMA_BITS: all pages are dirty initially", test_get_initial_dirty },
>  	{ "GET_CMMA_BITS: holes are skipped", test_get_skip_holes },
>  };
>  


