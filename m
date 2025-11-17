Return-Path: <linux-kselftest+bounces-45780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB23C66124
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 21:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C8D8835EB6A
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 20:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6818D313276;
	Mon, 17 Nov 2025 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="HAwiyuIP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71EB3093AD;
	Mon, 17 Nov 2025 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763410417; cv=none; b=ODtiNy25qu9Dkp5CKPHM92OiYig73D3e87Uto9CaPjKzcywDU0U9PLfwuG8gsbwWLLD3Py47EqVioSo4H3QX6WiMVomCEbw+Ffn1q0N/wY+IlJKNvIGsGj9EGfIwXIgetJoEqDxsfT5dISXTsp8V/LdAuNozd4xgwSnxLkt0oZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763410417; c=relaxed/simple;
	bh=u06n2iTj4e8/ax0tNv9tzaRKTfmQb9rRLqxBVlHkBXE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNgehxf3gfj0p6USIntWZA19BYzrZ9l6r5LWxS+VTVN+BBoWo1/EP5dAHZ0WHlZ69kVE6y9ywKhPmkyjPMqvsKliXlC4TdKuFf/QQp3YOfhm2fARdeMCzuJdGQ2l5MqLQiuHkhzEzghlCUJGQMEkXpQpn3qt1DA9BOYWYOx+oMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=HAwiyuIP; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AHJ0Yrb578000;
	Mon, 17 Nov 2025 12:13:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=iD1kcxyo9iGvISC3CrJP
	d7zikK1YKwkZbNKgf+3H5DA=; b=HAwiyuIPel+7ZAqv9VtS3IrjxStMRctHyBto
	oc4ylHyJtMmZFq9pd4eQOWco7p5U8M0s9cArTap/HW9g59x6IsixiPld7tEr7vZg
	z95ywu3YgzrYGmFLFzudOCjqhp/cypt+7/muC2H7tvvcxs7S7NB4kFmibL97MjFG
	GCoSX2seQaEglaOuVQ2cGheCMn5LyKMkrK2KzIZixnP5X5VctPCJypH/2zvoNQBt
	bkBNTReB7Jk0GnalvqQNROol/uzEcafAJ9Fk64opdzGpEVeSr3GnpwTlQqpDjMDe
	FSjVACef0DuF+6Jyxy27zVkqegZWnmaHqM16MWo1M9ZDKhNM3g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ag6v92fa4-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 17 Nov 2025 12:13:28 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 17 Nov 2025 20:13:27 +0000
Date: Mon, 17 Nov 2025 12:13:23 -0800
From: Alex Mastro <amastro@fb.com>
To: David Matlack <dmatlack@google.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
        Alex Williamson
	<alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Josh Hilke
	<jrhilke@google.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Raghavendra Rao Ananta
	<rananta@google.com>,
        Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v2 00/18] vfio: selftests: Support for multi-device tests
Message-ID: <aRuB45aR1LVGO1If@devgpu015.cco6.facebook.com>
References: <20251112192232.442761-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112192232.442761-1-dmatlack@google.com>
X-Proofpoint-ORIG-GUID: myOdcBTS54_JPAj6nxOSwXMv9nflTe9Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDE3MSBTYWx0ZWRfX3yTgVqnihWTL
 Jo/014aTVoBDTe/uvVgxwbM3SQUcse7Lt/v/VUU6JMbevjXGJkXsgYeUlXBxj2EHS7yRrmw4RnQ
 yblw6NoYTcggF3uspoPtnKzDY66WXmfrphan7iNe1fSQVebrrbC1kX3Qrk1ttQ3zKyauIeOjhhp
 L5VItrT+yyVwK2ED3xLKF5Y0/RnRneze4Q+YIWSENiAlsYp5MtNQSW7V2X4VT/23mW8eWmDQUTQ
 aLaHwk1HsoMJEEe4wi+BfcnAp7dyhdiR9aa8zwO8jvVNfuAW+K0wnMZc4b6dx2ZcP9BN7lhk7n8
 YdqTqSCbFXzOGf9xI1SVAEA915x8HIS9k0Z/AJX1vhrZ7dZvFELL8GeaJyVHbSsdDOQnORndd5P
 uUJWnqtv1QLIGgNBSGtit5bGMieZCg==
X-Authority-Analysis: v=2.4 cv=F/Bat6hN c=1 sm=1 tr=0 ts=691b81e8 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=wOU0V_YN5uQqQRcwivcA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: myOdcBTS54_JPAj6nxOSwXMv9nflTe9Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01

On Wed, Nov 12, 2025 at 07:22:14PM +0000, David Matlack wrote:
> This series adds support for tests that use multiple devices, and adds
> one new test, vfio_pci_device_init_perf_test, which measures parallel
> device initialization time to demonstrate the improvement from commit
> e908f58b6beb ("vfio/pci: Separate SR-IOV VF dev_set").
 
Aside from the Makefile assignment issue in "Split run.sh into separate
scripts", LGTM.

Reviewed-by: Alex Mastro <amastro@fb.com>

