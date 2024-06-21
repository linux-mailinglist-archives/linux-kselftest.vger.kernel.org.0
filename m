Return-Path: <linux-kselftest+bounces-12457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D90E7912BEA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 18:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11AFB1C2672B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 16:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B888E16A94D;
	Fri, 21 Jun 2024 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m5o8qY4Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD9515AACD;
	Fri, 21 Jun 2024 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988914; cv=none; b=X0Jvzo4z3NaEk5cv2oc0HsThsKvF3TieJKqhkIYpoLjA8UGIDyOq6S8LOHox5JLivVOa/fRZDuYFphwzGF87uF+xQlgoJU/YUekOC/Dkr2N90CQX9B2CYiqd1Bbla50pO1wYLmCm6zYtATIDmOIjlk7UGAGbIIsYbWnxPsEDvhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988914; c=relaxed/simple;
	bh=8RkqHSyBdChD8stu4ud6GUOOcHbfOh2wtj3FjDt+3wo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfZBEH6xn4Uiy0FEXe36XoXXx31SvQca5+qQmZzXD/hwkKMxM6cY2u3LRggU0GQug+U+sJ9xrWCqRH/P2PxYp586L8+Ck1UG0/X055T1ogd/yRlyN28sPM/WhXi0ibkD5St02OPq+xt8/yvKBU92zzApAxpvtITy2e9UfobBEy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m5o8qY4Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L8h2lY001792;
	Fri, 21 Jun 2024 16:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xjBhnWVYeSkonMyH/shTo5VS+kngpeBlajbqOkJ+y5M=; b=m5o8qY4QyoGLeMOU
	942+bApl0Kk30q9094Xl+0nyYbSG9aj41ZPniLdLl8N4NV+j/rkdykpCmZKrSN12
	5sC+hk/bhS83dpQJ5onGk4ihuC1MXHWjhpIqvmlD2nt2BM8Sa7QgXUNZbpCBblx9
	Ne//D5VvZUBvA+5flqPwozrW8F0SdfMpJRZMt0cH+HesYHleiByUZwskyf0vdlyZ
	6JGxZxY0em3R9J5ggZeh8pRc8k2//GCe1A3i8DbZ+3bsmWifkRXeH6znTIT+z8cQ
	8D9pLESg1PmukFtQLmDCtq9oZhUlOdNbbbWkTFE0P5aW1sqb4ympVWrFPTIU3ou5
	P+nPbQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yw68gs4nj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 16:54:56 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45LGstRC028010
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 16:54:55 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 21 Jun 2024 09:54:55 -0700
Date: Fri, 21 Jun 2024 09:54:54 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Fuad Tabba <tabba@google.com>
CC: David Hildenbrand <david@redhat.com>,
        David Rientjes
	<rientjes@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Jason
 Gunthorpe <jgg@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Matthew Wilcox
	<willy@infradead.org>,
        <maz@kernel.org>, <kvm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <20240621095319587-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <20240619115135.GE2494510@nvidia.com>
 <CA+EHjTz_=J+bDpqciaMnNja4uz1Njcpg5NVh_GW2tya-suA7kQ@mail.gmail.com>
 <ZnRMn1ObU8TFrms3@google.com>
 <CA+EHjTxvOyCqWRMTS3mXHznQtAJzDJLgqdS0Er2GA9FGdxd1vA@mail.gmail.com>
 <4c8b81a0-3a76-4802-875f-f26ff1844955@redhat.com>
 <CA+EHjTzvjsc4DKsNFA6LVT44YR_1C5A2JhpVSPG=R9ottfu70A@mail.gmail.com>
 <8e9436f2-6ebb-4ce1-a44f-2a941d354e2a@redhat.com>
 <CA+EHjTzj9nDEG_ANMM3z90b08YRHegiX5ZqgvLihYS2bSyw1KA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+EHjTzj9nDEG_ANMM3z90b08YRHegiX5ZqgvLihYS2bSyw1KA@mail.gmail.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QXDh3K7w48WsheqPI53a4Te-GVQCwGPf
X-Proofpoint-GUID: QXDh3K7w48WsheqPI53a4Te-GVQCwGPf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_08,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=708 lowpriorityscore=0
 clxscore=1011 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406210122

On Fri, Jun 21, 2024 at 11:16:31AM +0100, Fuad Tabba wrote:
> Hi David,
> 
> On Fri, Jun 21, 2024 at 10:10 AM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 21.06.24 10:54, Fuad Tabba wrote:
> > > Hi David,
> > >
> > > On Fri, Jun 21, 2024 at 9:44 AM David Hildenbrand <david@redhat.com> wrote:
> > >>
> > >>>> Again from that thread, one of most important aspects guest_memfd is that VMAs
> > >>>> are not required.  Stating the obvious, lack of VMAs makes it really hard to drive
> > >>>> swap, reclaim, migration, etc. from code that fundamentally operates on VMAs.
> > >>>>
> > >>>>    : More broadly, no VMAs are required.  The lack of stage-1 page tables are nice to
> > >>>>    : have; the lack of VMAs means that guest_memfd isn't playing second fiddle, e.g.
> > >>>>    : it's not subject to VMA protections, isn't restricted to host mapping size, etc.
> > >>>>
> > >>>> [1] https://lore.kernel.org/all/Zfmpby6i3PfBEcCV@google.com
> > >>>> [2] https://lore.kernel.org/all/Zg3xF7dTtx6hbmZj@google.com
> > >>>
> > >>> I wonder if it might be more productive to also discuss this in one of
> > >>> the PUCKs, ahead of LPC, in addition to trying to go over this in LPC.
> > >>
> > >> I don't know in  which context you usually discuss that, but I could
> > >> propose that as a topic in the bi-weekly MM meeting.
> > >>
> > >> This would, of course, be focused on the bigger MM picture: how to mmap,
> > >> how how to support huge pages, interaction with page pinning, ... So
> > >> obviously more MM focused once we are in agreement that we want to
> > >> support shared memory in guest_memfd and how to make that work with core-mm.
> > >>
> > >> Discussing if we want shared memory in guest_memfd might be betetr
> > >> suited for a different, more CC/KVM specific meeting (likely the "PUCKs"
> > >> mentioned here?).
> > >
> > > Sorry, I should have given more context on what a PUCK* is :) It's a
> > > periodic (almost weekly) upstream call for KVM.
> > >
> > > [*] https://lore.kernel.org/all/20230512231026.799267-1-seanjc@google.com/
> > >
> > > But yes, having a discussion in one of the mm meetings ahead of LPC
> > > would also be great. When do these meetings usually take place, to try
> > > to coordinate across timezones.
> >
> > It's Wednesday, 9:00 - 10:00am PDT (GMT-7) every second week.
> >
> > If we're in agreement, we could (assuming there are no other planned
> > topics) either use the slot next week (June 26) or the following one
> > (July 10).
> >
> > Selfish as I am, I would prefer July 10, because I'll be on vacation
> > next week and there would be little time to prepare.
> >
> > @David R., heads up that this might become a topic ("shared and private
> > memory in guest_memfd: mmap, pinning and huge pages"), if people here
> > agree that this is a direction worth heading.
> 
> Thanks for the invite! Tentatively July 10th works for me, but I'd
> like to talk to the others who might be interested (pKVM, Gunyah, and
> others) to see if that works for them. I'll get back to you shortly.
> 

I'd like to join too, July 10th at that time works for me.

- Elliot

