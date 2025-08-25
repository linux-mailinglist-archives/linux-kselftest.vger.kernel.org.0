Return-Path: <linux-kselftest+bounces-39893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2214B34E6E
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 23:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED55218906AC
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 21:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3692264A3;
	Mon, 25 Aug 2025 21:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=msa.hinet.net header.i=@msa.hinet.net header.b="au+RDO+f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAD9296BDF
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 21:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756158730; cv=none; b=pbLANMEo17+YRO/9DlRL6ejLxbWBfD+XREc6TYGGgmPAFFJGNrk3bIs3BOr4F3RLoAulJYsntRbFb/Qk/PmJmvpCQQkQbEM+xkjylNAluPZmo6IeXqGXogpR8rWxa1JLvswCyBzaaY5KAe1ggf3lRmlvBi3W9tMRa5BW03CzITc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756158730; c=relaxed/simple;
	bh=Z1MdS5Urfw7ePm/p1D4MrWWCnqc/pjXbcAkk0qAPJOI=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=FKjXgc554a4dXENPdVvj1Y2/7Ku4zTMzJJB03i9byFDnc7ojNp/eJPV3Wl01et+ENXHXKAKu7Rp+qP/B0JFJ3BRaloLvWSDPqVJYRS1pdMnc0yxwE6OmSIPIVgH8xdrULxLG46gLaxsOisiUIX21bVplKoF57jllR1bZZxqqA64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=msa.hinet.net header.i=@msa.hinet.net header.b=au+RDO+f; arc=none smtp.client-ip=210.65.1.144
Received: from cmsr8.hinet.net ([10.199.216.87])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 57PLq6s6896121
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 05:52:06 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=msa.hinet.net;
	s=default; t=1756158726; bh=JBCbLQYoCHeAvUijnyWJT+nTyyE=;
	h=From:To:Subject:Date;
	b=au+RDO+fNsUcaJrSVG5+GaM0YXSxQXD6yRQ6hPb4a+cOynIsxLvgw/m6q4NQx2KaZ
	 JjaD35FO46RaX2K7f2UTSOEiWMbr1G7j0VEwCAadT1KH19G14fYwBqFPdcG2I9CiIg
	 58W8uS7NzJZuKptTAWVvGbZuWsW1dG2mQ86iR+FY=
Received: from [127.0.0.1] (118-171-30-179.dynamic-ip.hinet.net [118.171.30.179])
	by cmsr8.hinet.net (8.15.2/8.15.2) with ESMTPS id 57PLmtLr760228
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 05:48:58 +0800
Message-ID: <2d262685ca97dfb651c8bcecf8e52811ed93385bbb5491b381557f097dcf8626@msa.hinet.net>
From: Sales <europe-salesclue@msa.hinet.net>
Reply-To: europe-sales@albinayah-group.com
To: linux-kselftest@vger.kernel.org
Subject: September Quote - RFQ
Date: Mon, 25 Aug 2025 14:48:58 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=YdAe5BRf c=1 sm=1 tr=0 ts=68acda4b
	a=lFXb0aLNiSyhbXvmCvqasA==:117 a=kj9zAlcOel0A:10 a=OrFXhexWvejrBOeqCD4A:9
	a=CjuIK1q_8ugA:10

Hi,

Please provide a quote for your products:

Include:
1.Pricing (per unit)
2.Delivery cost & timeline
3.Quote expiry date

Deadline: September

Thanks!

Kamal Prasad

Albinayah Trading

