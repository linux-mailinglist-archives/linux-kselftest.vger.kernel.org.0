Return-Path: <linux-kselftest+bounces-44878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FB2C396A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 08:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96AC63459A1
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 07:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CD223BF91;
	Thu,  6 Nov 2025 07:35:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from zpanel.taknet.net (unknown [130.185.75.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897E1273D6C
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.185.75.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762414548; cv=none; b=oxvR3dEA/6PBb1L5FH3oVLwhHYzYkZmyY/xBVvLqlQvmBjOlkJ21GBCsin6rR0dg2MfPpHmLAA5SsofGdXepmB1kZjy5izvlkG78A+rn1gE0M5p+UrXkaYUZSp49+f4gsrveUIUrCtS+QxR5478VTCvdRX/00Vj38Bi/rGkbH/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762414548; c=relaxed/simple;
	bh=Ol7exvCQAqv6YpENP860vQiYxr5AQ7EuSItPTN/8a+0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jBeaKProrxY4E0KXNdaJmfdWhbcGJ9/KkN6OKYRh/BzWZAtuRUP3C+F/PScSvmMDK9mn/W4tBX1dVvoQeC4QaYm9+uTH4pyjH0i10/It57onltdCG2OIpwJoobFlj1OTkwVEYObxI0QoowtmNXm8PsO+qSKuDd/pMv0F2pvAxGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=virakshop.com; spf=none smtp.mailfrom=virakshop.com; arc=none smtp.client-ip=130.185.75.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=virakshop.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=virakshop.com
Received: from [36.255.98.22] (port=53659)
	by zpanel.taknet.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <supervisor@virakshop.com>)
	id 1vGuWu-0002W6-2I
	for linux-kselftest@vger.kernel.org;
	Thu, 06 Nov 2025 08:35:44 +0100
Reply-To: harry.schofield@lexcapital-group.com
From: Harry Schofield ESQ <supervisor@virakshop.com>
To: linux-kselftest@vger.kernel.org
Subject: /Re,
Date: 5 Nov 2025 23:35:44 -0800
Message-ID: <20251105233544.DEE1C7B7610D231A@virakshop.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - zpanel.taknet.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - virakshop.com
X-Get-Message-Sender-Via: zpanel.taknet.net: authenticated_id: supervisor@virakshop.com
X-Authenticated-Sender: zpanel.taknet.net: supervisor@virakshop.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Re: Good day,
Hope you are well, my first email returned undelivered, please=20
can I provide you with more information through this email?.
Best regards,
Harry Schofield

