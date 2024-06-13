Return-Path: <linux-kselftest+bounces-11830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3DD906331
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 06:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673411C22932
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 04:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7D213440E;
	Thu, 13 Jun 2024 04:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lq6hG4Gl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B48A133402;
	Thu, 13 Jun 2024 04:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718254616; cv=none; b=JW+b0hLlxpgR4nsGqkkzth6r7HQeu4WDxDgM/hrOZw/e26HZxU2+oy16w8d8mfhNhgLpn90kA2hyV5dmrsM5evh0xn1A08Jp0b/4w48llgJizyAvr/Ab2RgtboZ7vvhkb0or0w/I2DQSEg2tJZzmvyMYbRWu0zrHGeSG7TqRyTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718254616; c=relaxed/simple;
	bh=kgX3Nm4c9dD57nkkKSdjttYWL75oIEz2/ufa6W5fGjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eRE7v34vlD7VVY6B24iSLMoNaAfEeIJ/XBJRfaLgaulYGlYn37V2mZoadXLMow7A3xpoludYvJeDfpt+jLTMgNh8tFXGc2LQ1Xi0871/C77W5LEzJ620odFOB3n5FGaZiOGIpawFhrjkTB1LjcLdHC/OWiwiVgSC8yB1TDagzY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lq6hG4Gl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D3QG58004084;
	Thu, 13 Jun 2024 04:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=L
	cvDt7OPVUu3ArFq0u1SgjMVx8F4xgs1vND8lkroj6A=; b=lq6hG4Gl058C6i7c3
	4v1Hg+jcvKxjX0TflwCC5x/I7sC92RygQNlNFgu7Z6Eh0s3kcN0rY92zmIZZ+pGW
	mjR2xxKuOBJ3BeK1xREYta2hELpLeZ8voyyHMt1rJP542wvS3c/0rFQSXPmdR228
	MLsBt/VseRFz0Vj4m7y0NipscrQVzbE+m3zgY2vlfp7VNZls49S8MNUInvVHQW9L
	B8NCiBckVm8163aap/lGyH0x7WiQMZqFkECEorENXx9qMl7oan2jFecY0DNeS5N+
	05XpqXWoT57ScRM2bh8/Bcyvc2z4ewS9aIWodoMLZOS2+ES+NwX2r5C3PaabhelL
	bhUjg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqrexr7p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 04:56:20 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45D4uKFZ016879;
	Thu, 13 Jun 2024 04:56:20 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqrexr7p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 04:56:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45D2c5TV027234;
	Thu, 13 Jun 2024 04:56:18 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn2114a1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 04:56:18 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45D4uGKH12780262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 04:56:18 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5756D5806A;
	Thu, 13 Jun 2024 04:56:16 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8852F5804B;
	Thu, 13 Jun 2024 04:56:12 +0000 (GMT)
Received: from [9.109.198.180] (unknown [9.109.198.180])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Jun 2024 04:56:12 +0000 (GMT)
Message-ID: <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
Date: Thu, 13 Jun 2024 10:26:11 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: hch@lst.de, sagi@grimberg.me, paulmck@kernel.org, davidgow@google.com,
        akpm@linux-foundation.org, venkat88@linux.vnet.ibm.com,
        Keith Busch <kbusch@kernel.org>
References: <20240612155135.3060667-1-kbusch@meta.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240612155135.3060667-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X7BOL0pcpB9f662VV2on1fcsNMUG1n_b
X-Proofpoint-ORIG-GUID: 4K8fSil0TRknxnKhplPX_Ccm3UDHN2nG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_12,2024-06-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406130032



On 6/12/24 21:21, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Provide a helper to remove elements from a list to the end, and place
> those elements in a new list.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  include/linux/list.h | 20 ++++++++++++++++++++
>  lib/list-test.c      | 29 +++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/include/linux/list.h b/include/linux/list.h
> index 5f4b0a39cf46a..f22850e854820 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -520,6 +520,26 @@ static inline void list_cut_before(struct list_head *list,
>  	entry->prev = head;
>  }
>  
> +/**
> + * list_cut - cut a list into two from the entry
> + * @list: a new list to add all removed entries
> + * @head: a list with entries
> + * @entry: an entry within head, could be the head itself
> + *
> + * This helper removes elements from @head starting at @entry until the end,
> + * and appends them to @lists.
> + */
> +static inline void list_cut(struct list_head *list,
> +		struct list_head *head, struct list_head *entry)
> +{
> +	list->next = entry;
> +	list->prev = head->prev;
> +	head->prev = entry->prev;
> +	entry->prev->next = head;
> +	entry->prev = list;
> +	list->prev->next = list;
> +}
I am wondering whether we really need the _rcu version of list_cut here?
I think that @head could point to an _rcu protected list and that's true 
for this patch. So there might be concurrent readers accessing @head using
_rcu list-traversal primitives, such as list_for_each_entry_rcu().

An _rcu version of list_cut():

static inline void list_cut_rcu(struct list_head *list,
		struct list_head *head, struct list_head *entry)
{
	list->next = entry;
	list->prev = head->prev;
	head->prev = entry->prev;
	rcu_assign_pointer(list_next_rcu(entry->prev), head);
	entry->prev = list;
	list->prev->next = list;
}

Thanks,
--Nilay


