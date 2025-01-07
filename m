Return-Path: <linux-kselftest+bounces-24032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEC4A04B66
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 22:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8EEF166698
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 21:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F051F63F0;
	Tue,  7 Jan 2025 21:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="Uf5NZX7/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13CD1D8DFE;
	Tue,  7 Jan 2025 21:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736284268; cv=none; b=O6xw7UvnNF/fzyVovrxqc8NJuL204qmdXrcczobdJKZp4aprpw1t1kmKyGakReAP+f89fbjUICEyY1lJdPvPVK1eAFMulNjP1avVzujnPDhEB5KOexCglSoJAlborayM6/+9/bUzBhFzDARktz6UDFmKpDW7Ab1/rXO0rIMfjgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736284268; c=relaxed/simple;
	bh=WfcEzCEVu4DeR2h92Sq0A6eiH0nM6HU/BvVWJyg9gfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBVSfLMYv0nATLxP1uet6lqpAyLDAL3Mkm6Fr1Jj5+musqp2jvujzlU03oyjxTm9HMFh/591kGDvNs1Jn8YaIeSKpTLYGWSVjgsxtVCW93rQ576GQp3QmlGZMVkhBCkqDGfdVkcwRLwyQEqfvIEVpLvduD33Oxe3v7DJzhbQN0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=Uf5NZX7/; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Lndng4N3lO1ivo9syb5BDhuB4i7UvrhyhygqCR2rS2A=; b=Uf5NZX7/Mi4QtnsOxAyrXmNQtL
	aBFequoaRBP0u5aZt0Wr4/ZomaFQPqmGRxRW6Ufhhjy05EKZewosHc37L21+tjm2XpZZEc11O5ehB
	59JUaRVcOjS9kPlcSnSaEefCn6HTwEn1wjUvrVIPVIqbspfEQ32SnQRqaH+hKROfuhVuCmixgSOwR
	ZDHgysSKj8SkDWZki+r7vXFmXRubzkP0dxVAOmD8emXYof2O3ozJXmcXPc22uA2tSpDBBjIKiqGE6
	JyKezXKbRuDLDAAnTvFGyLDm9v4NjFueZNnCjKf/XG6cMPO8y+IrRjGNGoMbvIBoSknOuf0vMmUSt
	DEQpShAA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tVGqe-008hkY-3C;
	Tue, 07 Jan 2025 15:10:53 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v7 00/30] NT synchronization primitive driver
Date: Tue, 07 Jan 2025 15:10:48 -0600
Message-ID: <8516093.NyiUUSuA9g@camazotz>
In-Reply-To: <20250107194241.GC28303@noisy.programming.kicks-ass.net>
References:
 <20241213193511.457338-1-zfigura@codeweavers.com>
 <2025010738-amicably-art-f746@gregkh>
 <20250107194241.GC28303@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 7 January 2025 13:42:41 CST Peter Zijlstra wrote:
> On Tue, Jan 07, 2025 at 06:06:03PM +0100, Greg Kroah-Hartman wrote:
> > Given a lack of complaints, I've now applied this to my testing tree.
> > Thanks for sticking with it!
> 
> Right, so I acked v6, which wasn't preserved. The v7 changes are minor
> and seem fine (IIRc I even suggested them some very very long time ago).

I wasn't sure it was fine to preserve the ack across changes (even if they were the ones you suggested) and decided to err on the safe side.

Thank you for the review!



