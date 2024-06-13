Return-Path: <linux-kselftest+bounces-11856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AA7907413
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 15:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537681F221D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 13:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DA51448E8;
	Thu, 13 Jun 2024 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nwk3vody"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8352A144D36;
	Thu, 13 Jun 2024 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286137; cv=none; b=P7DU1vObWSTBuxWX0CI/Hwzf7MDDCZl0E0zY9PvNV7mWLDM2v8s9PrZ/jummO4OKT4def1dF/I/9GUpFVkaBL50KExMDNr24GIJ+RsgZ1MbfZnur964OXCcPgrRZHdQB+n8x+OcLBr3SFc8x5C0B8QgxF2Jcu111BTR4VisUiyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286137; c=relaxed/simple;
	bh=gEBQjHna2XbzIzD705NXiOjgONId5w03PKl+TxkD1yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbXz4nVB2Cf/osaZ173qjWATdDrygcjKaNVeM1ygUS6TEG1Vbb90yR2s9ho3FcDb+OBO5CjBuiTqjOOfs3gfirSb+81ZYQZTdzqCr5PSOObdsDTd54CJqc7ePWrSaAA6DfGfpgPxKQFfxlBbY+xu5bkigMmalnw44F8SBHj5aLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nwk3vody; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DDKYdr011166;
	Thu, 13 Jun 2024 13:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=B
	h3yFA46dPP9BP4RFwHcMW7E8X0pV417kdUP+kIvhw4=; b=nwk3vodyUucAMrLTx
	7XAVhau3ZuTPC5JX/Hza/L9n7LJdAq3wmTPM+Ly8kB3Eq/aHWhbjnvVkEaKYZB9i
	IR1E69N4uG7yYjBiUgOwlS6oExV6lVDVlFlGZqufpuWGqolUtWFMoe8JhYwupQce
	DEDztcOey/E4f8tOSUxrI6Ow/VWX4vgU8BmxdFk0DCQ+szftCz2M+ZpZcZBECQx3
	MqT4FIGxNtSqUzpPN3csCrpy8F2dkFFl44oZyEvGOusQrF+mKvj3SpyayiVsIqUY
	ofMD6We5foSbZXK+kG9zXcJQdC70E45ELfKbaknOWt+oA1cVEEZnb6M/uiJXyb0a
	1+dWw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqq4u1p32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 13:42:02 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45DDf9Pa011175;
	Thu, 13 Jun 2024 13:42:01 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqq4u1p2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 13:42:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45DD24WS027246;
	Thu, 13 Jun 2024 13:42:01 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn21183u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 13:42:01 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45DDfwi123528170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 13:42:00 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A88E25803F;
	Thu, 13 Jun 2024 13:41:58 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A573A5804E;
	Thu, 13 Jun 2024 13:41:54 +0000 (GMT)
Received: from [9.109.198.180] (unknown [9.109.198.180])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Jun 2024 13:41:54 +0000 (GMT)
Message-ID: <c475f0d8-3bc9-4d65-8fce-586f4b75b4fc@linux.ibm.com>
Date: Thu, 13 Jun 2024 19:11:52 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, paulmck@kernel.org, davidgow@google.com,
        akpm@linux-foundation.org, venkat88@linux.vnet.ibm.com
References: <20240612155135.3060667-1-kbusch@meta.com>
 <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
 <ZmrscxG51gFRDVlM@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ZmrscxG51gFRDVlM@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yOj-B8kJC8OQ0h8P5quDiiU1kMCIz3af
X-Proofpoint-ORIG-GUID: iQODFnnSfOi94haZX-PGOdDd8fq0PmCa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_05,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130098



On 6/13/24 18:26, Keith Busch wrote:
> On Thu, Jun 13, 2024 at 10:26:11AM +0530, Nilay Shroff wrote:
>> On 6/12/24 21:21, Keith Busch wrote:
>>> +static inline void list_cut(struct list_head *list,
>>> +		struct list_head *head, struct list_head *entry)
>>> +{
>>> +	list->next = entry;
>>> +	list->prev = head->prev;
>>> +	head->prev = entry->prev;
>>> +	entry->prev->next = head;
>>> +	entry->prev = list;
>>> +	list->prev->next = list;
>>> +}
>> I am wondering whether we really need the _rcu version of list_cut here?
>> I think that @head could point to an _rcu protected list and that's true 
>> for this patch. So there might be concurrent readers accessing @head using
>> _rcu list-traversal primitives, such as list_for_each_entry_rcu().
>>
>> An _rcu version of list_cut():
>>
>> static inline void list_cut_rcu(struct list_head *list,
>> 		struct list_head *head, struct list_head *entry)
>> {
>> 	list->next = entry;
>> 	list->prev = head->prev;
>> 	head->prev = entry->prev;
>> 	rcu_assign_pointer(list_next_rcu(entry->prev), head);
>> 	entry->prev = list;
>> 	list->prev->next = list;
>> }
> 
> I was initially thinking similiar, but this is really just doing a
> "list_del", and the rcu version calls the same generic __list_del()
> helper. To make this more clear, we could change
> 
> 	head->prev = entry->prev;
> 	entry->prev->next = head;
> 
> To just this:
> 
> 	__list_del(entry->prev, head);
> 
> And that also gets the "WRITE_ONCE" usage right.
Yeah this sounds reasonable.

> 
> But that's not the problem for the rcu case. It's the last line that's
> the problem:
> 
>  	list->prev->next = list;
> 
> We can't change forward pointers for any element being detached from
> @head because a reader iterating the list may see that new pointer value
> and end up in the wrong list, breaking iteration. A synchronize rcu
> needs to happen before forward pointers can be mucked with, so it still
> needs to be done in two steps. Oh bother...

Agree and probably we may break it down using this API:
static inline void list_cut_rcu(struct list_head *list,
 		struct list_head *head, struct list_head *entry, 
		void (*sync)(void))
{
 	list->next = entry;
 	list->prev = head->prev;
	__list_del(entry->prev, head);
	sync();
 	entry->prev = list;
 	list->prev->next = list;
}

Thanks,
--Nilay


 




