Return-Path: <linux-kselftest+bounces-28185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7153CA4D59D
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 09:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F24817369E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797471F8AD3;
	Tue,  4 Mar 2025 08:01:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41471E285A;
	Tue,  4 Mar 2025 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075298; cv=none; b=QG1sK1/dPRTLEhIRAg1sRymo/cKsPtKANbLkOe2t8xLNVZYXhxaAgVkeHec0EAOn/L+QuVzSzQYhidNoFfKD46n6ydSvIaWe2RsfpRM/kb2UfTAK1uzNhDGwCfRm+9hZY12IHrxTVX78ugPeL0AggaD33pt5c8OkWEqPV/IxWp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075298; c=relaxed/simple;
	bh=djMQJDCyKH40Nld1GGA0iDRvwhpOpB522rDI9oiSr4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQFyhzy2elVBNMuTuyM80lPFnZyUTRrtDJQ2wA+zXJjN9evtMHNT7eLQSACrJetXXvNRtwWmPf9yFA/jhugL2bAajn5mV11QIALKEYSQSmuTQOLHwbFPwy2rGauwEyFwsJzwzDC+q3Yc7K2eajwSrL5uFWh/P7+eZw0+CmTYW+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 52481W5s010217;
	Tue, 4 Mar 2025 09:01:32 +0100
Date: Tue, 4 Mar 2025 09:01:32 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 27/32] tools/nolibc: add snprintf() and friends
Message-ID: <20250304080132.GD9911@1wt.eu>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
 <20250304-nolibc-kselftest-harness-v1-27-adca7cd231e2@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-27-adca7cd231e2@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Mar 04, 2025 at 08:10:57AM +0100, Thomas Weißschuh wrote:
> +static int _sprintf_cb(intptr_t _state, const char *buf, size_t size)

So logically we should have "nolibc" in that name as well.

Willy

