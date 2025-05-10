Return-Path: <linux-kselftest+bounces-32820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79BFAB24EE
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 May 2025 20:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597881666CC
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 May 2025 18:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C79267B09;
	Sat, 10 May 2025 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastemail60.com header.i=@fastemail60.com header.b="CX2pwMie"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.fastemail60.com (mail.fastemail60.com [102.222.20.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329EB267B0C
	for <linux-kselftest@vger.kernel.org>; Sat, 10 May 2025 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=102.222.20.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746901139; cv=none; b=XVBMR/u++sTvR1d2cASCDEhnlWv/6jsSprFJjSZIps7d6Ht2XiNpneiieKgVw5zmIbKaRbBlODRBe/KPwpLxHIkYBJexciNfB5DQMs5QIB6m0kvlvAfChFRtQQfKav5GaproqGbjlJJ5S/Yzz65fOZyUY5KzB0w9EFPFIc6FAfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746901139; c=relaxed/simple;
	bh=0kM12Ki2v7eI61I1WvQrX7nQw+DKE1uiGUA45uahRZc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hkh3paa+bFPVtVumNL6iozFEcCDLzzf0mR/sATdDDQ6AvXFvPwaSiALknOLW/VE4MiZIPGgsVY62kStOENAoZ+eS7rSL2YveTyCTrnEvvc+Db05coaBXb07PlmHe6szRduIiz5QlVTE+3kEh0f/Rvr/Ad629VsAMnL21suAFkH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fastemail60.com; spf=none smtp.mailfrom=fastemail60.com; dkim=pass (2048-bit key) header.d=fastemail60.com header.i=@fastemail60.com header.b=CX2pwMie; arc=none smtp.client-ip=102.222.20.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fastemail60.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fastemail60.com
Received: from fastemail60.com (unknown [194.156.79.202])
	by mail.fastemail60.com (Postfix) with ESMTPA id 48094887AC8
	for <linux-kselftest@vger.kernel.org>; Sat, 10 May 2025 16:32:01 +0200 (SAST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.fastemail60.com 48094887AC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastemail60.com;
	s=202501; t=1746887522;
	bh=0kM12Ki2v7eI61I1WvQrX7nQw+DKE1uiGUA45uahRZc=;
	h=Reply-To:From:To:Subject:Date:From;
	b=CX2pwMie60WPOZ4u72wEIcGcEc9inukeWVh6a1D5RKuZkccHFg/ad6ky9O3aDb12W
	 cKxPELln30RyRopvzfSWyBw4VTLvgmiZWhbZQETM6oDpMXVKyVXca6XeihcZydt5R9
	 GBK8UeSk4MVQclu+wtg+E+AZKJoZ+ZO86zZkXukRiEJLDhe0qdh7Ak/b+pAeoFp/s6
	 ggDrSFHifjxGd/NGlKyzxljMg1tleQW7HsM7CT0/MFCaOID1q04zo2IX9OTDqUeG8b
	 bEJsS29jA7poDDl4i84A/TwDyXIXr4BjPkDs+UkVXSym0y7SqvEBJisHsNl4cWcBgR
	 nyDKpi1MuLdHQ==
Reply-To: import@herragontradegroup.cz
From: Philip Burchett<info@fastemail60.com>
To: linux-kselftest@vger.kernel.org
Subject: Inquiry
Date: 10 May 2025 10:32:00 -0400
Message-ID: <20250510103159.661B7D37983C5548@fastemail60.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (mail.fastemail60.com [0.0.0.0]); Sat, 10 May 2025 16:32:03 +0200 (SAST)

Greetings, Supplier.

Please give us your most recent catalog; we would want to order=20
from you.

I look forward to your feedback.


Philip Burchett

