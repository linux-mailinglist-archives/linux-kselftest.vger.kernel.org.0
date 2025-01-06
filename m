Return-Path: <linux-kselftest+bounces-23955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0B0A02F48
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 18:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7034F3A4DFD
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 17:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287D6191F75;
	Mon,  6 Jan 2025 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VdunQCs8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BCD2AF06;
	Mon,  6 Jan 2025 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736185683; cv=none; b=F02OSdCCA1EmNW9VgtbMGIOE6msUrrwUQ6IDkwOhmoovLWYOysGzfj0SGHKxNfK75BDkUm9Ha40lLM7X9bJ5kQE0jsKBhguLXk1CFZ00M4tJwBC+vsRxIQOVLJqbL73OaSIwxbMVidZtjyH6Yp2yG/zHMrkezxD41YlUW3O189s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736185683; c=relaxed/simple;
	bh=dJwLyChi/EnOT24oVuUMdY6a6RUOFaJJrcDRbpRF8XM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJoI760RiBhnzDRZD3BMwOCUxMmM1TbsJWuaGgCZ6j83GvITxNAgFpmvo83ydAao3jbzHG/yRtezVTzn6Vlg4hRX5/wSyCqFvxSzF9fFwwuFbvtCzkLBxeetRLKDRG9CAn7j3hr3jubtx3Fw/KRHEZtey6ajs6x+mGXATkCzGzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VdunQCs8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506G2oDm001290;
	Mon, 6 Jan 2025 17:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=g1OlXN+r8fkCZxXYqiGEVezy
	SBUM+VtpKZlgxYr1d5Q=; b=VdunQCs8SYsDOiv4awx4CrGCyLFTKZsFRoJP5MAs
	gCXDAYo8FfCFgmVKQSOGuikcwyXQp7GKx8jyPTbvBpePGFyhrjKK2MBm8TMemFnF
	+KDd7t6oo4tt7qfejoWRUypayNjbrh4xih7GhcHzYv25J9nGNZZisBH9/QtUGFWv
	9ijqg1PX+tpp4gIe6JosD3AmbZ2EqJuAPjczm37TVwMdbj9DMiM6PrB4QJgNjS22
	bKWwhpOaUkp9brjRZb2sju2BTglSeZBS/nVEiKoHNzPBZ1UGxIi0DJPbapAvj6hr
	wVxcxBX/DSlOOsOyBksy90HuSh5oizXO20Xokh8uNIXJiQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 440jbmg7pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 17:47:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 506HlOFm025416
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 Jan 2025 17:47:24 GMT
Received: from PHILBER.na.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 6 Jan 2025 09:46:28 -0800
Date: Mon, 6 Jan 2025 18:46:17 +0100
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
Message-ID: <ae5hdnhewksv2wkshxyyt3262mqi6o45opkl4occ5nt5zidr5e@lii7fgucetvu>
References: <20241219204208.3160-1-quic_philber@quicinc.com>
 <20241219204208.3160-2-quic_philber@quicinc.com>
 <Z2WLGHRdlsRpT6BL@hoboy.vegasvil.org>
 <wcxdbqhoe4cppukyy5rvkq5am4ht6wk5u6d6g2k2swqhidjw7i@6nar5vuusm35>
 <Z2ymZuiFqY8mxihJ@hoboy.vegasvil.org>
 <a352mltlizneonxazn4bffydn57fyudrc3zougii2rnatg3jga@3yagssaob5sb>
 <Z3a892mBOSRl6BlN@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z3a892mBOSRl6BlN@hoboy.vegasvil.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: r9V-M1YzFMt2DWTG4Vxl7gdWGlCaAN0G
X-Proofpoint-ORIG-GUID: r9V-M1YzFMt2DWTG4Vxl7gdWGlCaAN0G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxlogscore=874 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501060156

On Thu, Jan 02, 2025 at 08:21:11AM -0800, Richard Cochran wrote:
> On Thu, Jan 02, 2025 at 05:11:01PM +0100, Peter Hilber wrote:
> > For sure. But the aim of this proposal is to have an interoperable time
> > synchronization solution for VMs through a Virtio device. So the idea is
> > to include metrics, if a consensus on their usefulness can be reached.
> > AFAIU it is difficult to bypass the kernel for Virtio devices.
> 
> Providing clock metrics only makes sense when there is some choice to
> be made based on those metrics.  If the "limited" VM guests don't even
> have networking, then they have no choice but to accept the time from
> the VM host, right?  In which case, the metrics do not provide any
> benefit to the guest.
> 
> Or what am I missing?

The proposal is not limited to guests with no networking.

Guests *might* not have internet access (might not be "internetworked").
Even then, guests can still interact with the environment (so metrics
can be important) and might decide to reduce features when the metrics
are too bad.

Thanks for the comments,

Peter

