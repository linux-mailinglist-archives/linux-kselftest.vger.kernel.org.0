Return-Path: <linux-kselftest+bounces-23823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6FF9FFB62
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 17:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51BB1883782
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 16:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725071AF0BB;
	Thu,  2 Jan 2025 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GQracyhZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA95079E1;
	Thu,  2 Jan 2025 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735834317; cv=none; b=WU/vnSgMoiCeLliQtfwZfCZmVcrfiCzSgZhlN1XjKW4OUz+3Ie7qLkbMeLG+09FzbgbRdynOhKcUV2CY6bKUp5ReUIGiqG+K81OAM5Ug3Z0/DAT3Iqad2fBVBr8Brudn+WgnTIZwDyJj57Mz6tFAX+MsXqoRV/TaTd2720CxGDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735834317; c=relaxed/simple;
	bh=SkdBCFy4/NYiYeWlSPzQFSiysAAtTRucOg9v2ucffpU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfYFtUTvnwEEYT3m4nR5u0wXrhiI89CNRegsYPmi2F/VAAs90hH9cM1ggNog032GowRCK++P9upc1RXHGMFR4kYqWWHV7yaDY5yy0GqXMHfZXPK0VBh01EvQlBYlRCJ+2CJYs1uVE9fB5qmydkJ3qpbIU/nWnKpoiMPYHImIBVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GQracyhZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502G1LTs001672;
	Thu, 2 Jan 2025 16:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9lfWFz+UlOJFT1pVZfvVtOpg
	IDbcrmg5DUrHytsFqfk=; b=GQracyhZ6MwHkhSB7WoQJ5Ton7uenYr2lz4hABem
	HjdgWa84tVLGDVdtJbkkBzVxdS6U//kZ6jhYFJVrt775TtocRZ6TtkcjamTLEItf
	Zb5W1fDU4ygzuI1CHmUuBczMgd4cuCps2juxFG9CNhSWAdBhrQx8OIF5NdmRdRNw
	2WO2z9uvZzx39LlJvQg4J+XbyIDVC1FT6NiMg30JXNoaFHND2cFM8AO2gwbq+qlu
	jj1PnSfJRqVKQSw9rolqEutHiWA4Orw9RTNbSB+oYb+4IQlNuyD/a6ROTAmtzuJq
	ZD/qPASsH+6aK2v5+isiT0miNCe9+JtXGECZHUlR6Ubg2w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43wrefgq0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jan 2025 16:11:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 502GBBYO015448
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 Jan 2025 16:11:11 GMT
Received: from PHILBER.na.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 2 Jan 2025 08:11:04 -0800
Date: Thu, 2 Jan 2025 17:11:01 +0100
From: Peter Hilber <quic_philber@quicinc.com>
To: Richard Cochran <richardcochran@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>,
        <virtio-dev@lists.linux.dev>, <netdev@vger.kernel.org>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eugenio =?utf-8?B?UMOpcmV6?=
	<eperezma@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Jason Wang <jasowang@redhat.com>, Paolo Abeni
	<pabeni@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>,
        <linux-kselftest@vger.kernel.org>, <linux-api@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Ridoux,
 Julien" <ridouxj@amazon.com>,
        John Stultz <jstultz@google.com>,
        "Thomas
 Gleixner" <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Anna-Maria
 Behnsen" <anna-maria@linutronix.de>
Subject: Re: [RFC PATCH 1/2] ptp: add PTP_SYS_OFFSET_STAT for xtstamping with
 status
Message-ID: <a352mltlizneonxazn4bffydn57fyudrc3zougii2rnatg3jga@3yagssaob5sb>
References: <20241219204208.3160-1-quic_philber@quicinc.com>
 <20241219204208.3160-2-quic_philber@quicinc.com>
 <Z2WLGHRdlsRpT6BL@hoboy.vegasvil.org>
 <wcxdbqhoe4cppukyy5rvkq5am4ht6wk5u6d6g2k2swqhidjw7i@6nar5vuusm35>
 <Z2ymZuiFqY8mxihJ@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z2ymZuiFqY8mxihJ@hoboy.vegasvil.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 88onBiDbs699f8ZIpzTSAWzT212S52iY
X-Proofpoint-ORIG-GUID: 88onBiDbs699f8ZIpzTSAWzT212S52iY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501020142

On Wed, Dec 25, 2024 at 04:42:14PM -0800, Richard Cochran wrote:
> On Mon, Dec 23, 2024 at 07:13:46PM +0100, Peter Hilber wrote:
> 
> > The precise synchronization of the VM guest with its immediate
> > environment can also be important; a VM guest may depend the decision
> > about leap second smearing on its environment.
> 
> I thought that the whole point of using a VM is to isolate the guests
> from each other and the host.  What you describe is a promiscuous
> coupling between guest and host, and the kernel shouldn't be in
> the business of supporting such behavior.
> 

Why? There is already ptp_kvm etc. in the kernel.

Would it be more acceptable to just announce leap seconds, but not
whether to smear?

> > Also, the administrative
> > configuration choice may change over the lifetime of a system.
> 
> Right, which is why we should keep those choices out of kernel space.
> Kernel provides mechanism, not policy.
>  

As discussed, the policy would be forwarded, not determined, by the
kernel.

If the policy would be forwarded via NTP (by the NTP server smearing or
not smearing leap seconds), this would have the following disadvantages:

- need to use an NTP server just for announcing leap seconds

- redundancy of serving time both via NTP and via PTP clocks (for better
  precision)

- no awareness about leap seconds in case of smearing.

> > The intent is to also support (embedded) VM clients which are themselves
> > not necessarily internetworked, which do not get a lot of maintenance,
> > and which are not guaranteed to get an update within the typically less
> > than 6 months between leap second announcement and occurrence.
> 
> Again, I don't think the kernel should be the solution to guests that
> lack networking.  Instead, the place to fix the problem is at the
> root, namely in the guests.
> 

I do not understand. Is the point that guests should decide through
another channel about leap second smearing?

> > I agree that a device driver should not determine clock quality metrics.
> > The intent is that the driver forwards metrics, if such are advertised
> > by the device. These metrics should describe the accuracy etc. of the
> > device itself.
> 
> Overall, I don't trust devices to tell the truth about their
> qualities.  But putting that aside, we would need to see some kind of
> commonality in hardware implementation to advertise their metrics.
> However, AFAICT there is no such industry practice on the market.
> 

I hope there will be some feedback from third parties (at least related
to virtualization).

> > The patch message should document this more clearly. The
> > metrics can be determined e.g. by virtualization host user space
> > software. The device driver would just expose the device metrics to user
> > space.
> 
> Again, host user space shouldn't misuse the kernel to share random
> metrics with guest user space.  Isn't there another way to share such
> info from host to guest?
> 

For sure. But the aim of this proposal is to have an interoperable time
synchronization solution for VMs through a Virtio device. So the idea is
to include metrics, if a consensus on their usefulness can be reached.
AFAIU it is difficult to bypass the kernel for Virtio devices.

Thanks for the discussion,

Peter

