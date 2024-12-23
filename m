Return-Path: <linux-kselftest+bounces-23738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD8F9FB3E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 19:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56291666D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 18:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E586D1BEF9D;
	Mon, 23 Dec 2024 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VEpJcF84"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6E912C544;
	Mon, 23 Dec 2024 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734977673; cv=none; b=cfkmXabPUfpzzvje++Q6B3y6NDKHqukE2zVoAUUo0qczs9StQobXsW/3l3iiFU5AvyRb1ecv6Vz6sW5hWnvfckoAmpiiHgfUFcCSm4Og5kefGtEsKFm6pqa8+BtPqAaXdyI7z9wxfCbvGM8LKknF6iMdZfaqVw/mh32eOSBic0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734977673; c=relaxed/simple;
	bh=ACi8vxZdg1xtJrN+M3qMtrF4XVnDsm9UPrvFVgwgpFw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmrHPMxb9rVfC/M4msh0t9B7He+a8kSmISvGeLcuRXo354p6APKhm7NVA0b3Pieqx0NYFxUgjoh852Q8IICGvQgEGEKjzKiBQvfeHRcC3ca88Aobu5xA1cIS4G33gU89oyTxPtnJeRRuzvaZAp8ytVIbMiMdlsOT1UmX3NrHPdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VEpJcF84; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNBw84j019164;
	Mon, 23 Dec 2024 18:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+rHQBPfBA3sp/wpNzoOEpYr7
	By9U3FbqOwM5hpdHtv4=; b=VEpJcF84xE/W+8ybUAkMtJelp+ThEbKlyfO/+zjq
	mw10ilhp2oF/2hRdYBCTIdd2zyXg17dIVUXvWwn+IOxGdcu7mDQXpP3jdoUS4rF7
	97opp87KPu9iqoblpYy+jqHvsj5iLFMdZLsHoibVwgsgdbMyG9AN6HaW7GOrS8ON
	FwIRbWFMjKoZcxJg4N5Du8jOWJOQmC/tECwu58UvVvW6p7xWK6nZllByNfYUlLWV
	fAfeFDkxnKvY6p8OUfbP0XDPvmtLGXNDJNf0SJ17CtlOXej4NiFRgtj/LW1kZyFJ
	rCm2DBbKe2PnmQZFvLYUEsJyD7QkeS0DWW9XKKysHpgRfg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43q7ev1afn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 18:13:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BNIDuQd028444
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 18:13:56 GMT
Received: from PHILBER.na.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 23 Dec 2024 10:13:49 -0800
Date: Mon, 23 Dec 2024 19:13:46 +0100
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
Message-ID: <wcxdbqhoe4cppukyy5rvkq5am4ht6wk5u6d6g2k2swqhidjw7i@6nar5vuusm35>
References: <20241219204208.3160-1-quic_philber@quicinc.com>
 <20241219204208.3160-2-quic_philber@quicinc.com>
 <Z2WLGHRdlsRpT6BL@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z2WLGHRdlsRpT6BL@hoboy.vegasvil.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lo_CQoVfd-cd2w2zqVfOdmlKGtmptnZ2
X-Proofpoint-GUID: lo_CQoVfd-cd2w2zqVfOdmlKGtmptnZ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230162

On Fri, Dec 20, 2024 at 07:19:52AM -0800, Richard Cochran wrote:
> On Thu, Dec 19, 2024 at 09:42:03PM +0100, Peter Hilber wrote:
> > Ioctl PTP_SYS_OFFSET_PRECISE2 provides cross-timestamping of device time
> > and system time. This can be used for virtualization where (virtualization)
> > host and guest refer to the same clocksource. It may be preferred to
> > indicate UTC time, rather than TAI. It is then useful to indicate when and
> > how the host processes UTC leap seconds (stepping or smearing on leap
> > seconds),
> 
> If the VM host provides TAI, then the guest may freely derive UTC and
> leap seconds on its own.  Whether to smear leap seconds or not is
> properly an administrative configuration choice in the VM guest.
> 

The precise synchronization of the VM guest with its immediate
environment can also be important; a VM guest may depend the decision
about leap second smearing on its environment. Also, the administrative
configuration choice may change over the lifetime of a system.

> Leap seconds are scheduled to be deleted in 2036.  If, between now and
> then, another one occurs, it will be global event, not determined by a
> VM host.  The way you find out about leap seconds is through
> networking using the NTP (or even just downloading the published list
> once in a while).  VM clients typically have networking, and so
> they can learn about a leap second all by themselves.
> 

The intent is to also support (embedded) VM clients which are themselves
not necessarily internetworked, which do not get a lot of maintenance,
and which are not guaranteed to get an update within the typically less
than 6 months between leap second announcement and occurrence. I will
document this in the patch message.

> > in particular if the guest is not guaranteed to have an
> > up-to-date Time Zone Database or similar.
> 
> Time zones are not connected to leap seconds.
> 

The IANA Time Zone Database includes a leap seconds list.

> > Also, a host may have a notion of how accurate its clock is w.r.t. the
> > hosts' reference clocks.
> 
> I'm opposed to having device drivers try to claim any kind of clock
> quality.  All of the clock control, servos, statistics, etc, are done
> in user space, and so only user space software can generate meaningful
> clock quality metrics.  Putting some kind of hand wavy values into
> kernel drivers is just plain wrong IMO.

I agree that a device driver should not determine clock quality metrics.
The intent is that the driver forwards metrics, if such are advertised
by the device. These metrics should describe the accuracy etc. of the
device itself. The patch message should document this more clearly. The
metrics can be determined e.g. by virtualization host user space
software. The device driver would just expose the device metrics to user
space.

Thanks for the feedback,

Peter

