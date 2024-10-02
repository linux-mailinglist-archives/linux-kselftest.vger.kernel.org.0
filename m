Return-Path: <linux-kselftest+bounces-18939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9021598E649
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 00:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DFB1C21215
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 22:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DF519AD5C;
	Wed,  2 Oct 2024 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pkODkwGG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F87284A36;
	Wed,  2 Oct 2024 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727909497; cv=none; b=sxB853qB9TPHZWsb4/ogLg/Qrm+RGUYmOZKiApBYzjv4EI0UhUYeVQvnGI4WkXHyJ5NlGZrUeiFOliKwQ2mBEY076BucYDUS1uI2PxrUj1+EackMGOKs3WtfpLphc5w2+B3E4Q+UCjPfgqVlm3ma1amwb/VqxP3VzzAmUiEiVPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727909497; c=relaxed/simple;
	bh=LHF6cjHOsqNYEtLDffhXnFlQNHqbt+kBOmXpQkUcibA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pa8HwQokf8Thz7WYeirI3wLSI7shzFxPI71MLFQgbHpQjx0AZle+PNKnXtOOWBPNlERL4nsja1KjMAxS6O19Ut4mPx5WndpXgCjqCX/Dg83oHY7glcK0AOHBhNI0cJ97UuUC/E1xJyEtZ6NzaA4IxlJGKHI9NWB96AZxiJnP7TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=pkODkwGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5136C4CEC2;
	Wed,  2 Oct 2024 22:51:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pkODkwGG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727909483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LHF6cjHOsqNYEtLDffhXnFlQNHqbt+kBOmXpQkUcibA=;
	b=pkODkwGGbc8L88SA2VTIqijfaALPjpnA0PTFbZBGb2PyOntCa4p5nryVLTaZx3WdgJ7CY9
	Git6yqYTm0dn4toEVaOAF5jvSPk/ss8whj/+1ms8J39PYm4vyZUT4f12x6gckWgJtf2SUL
	RzNX6Z0uAncBCckp+uKIvZOk0KgOpKM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 06d81745 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 22:51:23 +0000 (UTC)
Date: Thu, 3 Oct 2024 00:51:21 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: SurajSonawane2415 <surajsonawane0215@gmail.com>, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/vdso: Add linux/sched.h to fix CLONE_NEWTIME
 build error
Message-ID: <Zv3Oaf4gMFyIFrV6@zx2c4.com>
References: <20241002152849.111841-1-surajsonawane0215@gmail.com>
 <543d4b19-e530-45e3-876c-522101f9a5e6@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <543d4b19-e530-45e3-876c-522101f9a5e6@linuxfoundation.org>

Wasn't this already submitted and commented on?

https://lore.kernel.org/all/20240919111841.20226-1-liaoyu15@huawei.com/

