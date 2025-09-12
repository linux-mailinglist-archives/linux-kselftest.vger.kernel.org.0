Return-Path: <linux-kselftest+bounces-41311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11759B549CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 12:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66332B6269C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 10:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7421F2E973D;
	Fri, 12 Sep 2025 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="aK0GaeJq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7F62820D6
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672513; cv=none; b=fT+LY3BtIjz3kTFVrYpDCMFwyB8CITuC9tJ0oWyOmP4mmzvPDbT7gYS147beby1RL0Ot2K0EFpDhXpqMB3B1TJF+khA1LFXoqpa1pIRMKwBqhJgrboTUFE9in8HusE717UaOQci1lnEsgEXTVyZcjmeXEsyMFOhKs2lPahSeNf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672513; c=relaxed/simple;
	bh=P4V6Jz0xrusjuOvs53isunD9sVLdstinhBFPBgsMGK4=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=q8ftMl3dtyQMwuzgCArwOSZuV4xCt05Yd+XqBgTU9cyYGV+BHAoUlgH1t84oIh/tmqpFtgMOA+Ry+2gdyChNGM2nPiY2C49rb7tqOyV77uj47BKWCsEok7BATPuT+7ZjJKp9PblhBVGoGL9C0F6wRq2onq4b7/9jvZK1d0f8Jeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=aK0GaeJq; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr10.hinet.net ([10.199.216.89])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 58CALkW2161050
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 18:21:49 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1757672509; bh=iHjs7SAZaFcj4phzP5bDgu5JqKA=;
	h=From:To:Subject:Date;
	b=aK0GaeJqHOPLhSKRhUsmqYDee/Mf7cdwwHwshX/WwF7YB3c+MaS21ip+zl4S2nMrg
	 Zvmfi5BRGV7FXGmxebTYjAdCpKklpZiuipZGf/e/lv4Tk/4IJ1t3zxWekNuLko4hrS
	 e2ivSYz5tSS19GjFIMN8q9m6oiITy7fMWhyCFX5U=
Received: from [127.0.0.1] (61-228-55-181.dynamic-ip.hinet.net [61.228.55.181])
	by cmsr10.hinet.net (8.15.2/8.15.2) with ESMTPS id 58CAF6Lh511552
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 18:16:16 +0800
From: "Info - Albinayah 868" <Linux-kselftest@ms29.hinet.net>
To: linux-kselftest@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gOTMwMzUgRnJpZGF5LCBTZXB0ZW1iZXIgMTIsIDIwMjUgYXQgMTI6MTY6MTQgUE0=?=
Message-ID: <9bfa3f2b-060d-9753-b35f-f04de3c051f6@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Sep 2025 10:16:15 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=Au5N3/9P c=0 sm=1 tr=0 ts=68c3f2f1
	p=OrFXhexWvejrBOeqCD4A:9 a=yt2vnJcufJgYEsdr2blA5A==:117 a=IkcTkHD0fZMA:10
	a=5KLPUuaC_9wA:10

Hi Linux-kselftest,

Please provide a quote for your products:

Include:
1.Pricing (per unit)
2.Delivery cost & timeline
3.Quote expiry date

Deadline: September

Thanks!

Kamal Prasad

Albinayah Trading

