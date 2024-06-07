Return-Path: <linux-kselftest+bounces-11351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC5490019B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 13:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A02C284F6F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 11:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EEE18735E;
	Fri,  7 Jun 2024 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b="XitJNlei"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4930B187350;
	Fri,  7 Jun 2024 11:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758478; cv=none; b=sIyrFhsBLK3IgjWJZK2PmYW5Ppdty+ZmWJw965NfOVfWbesLyMlgWi43os6QiYZVYmGVP9RIBUYKElB/vkPX0t30I7EaAZi9BYPCrSOVTsDsgbJNW12ZZyTbWbOrJBKmviSzt0BoNq6uOtw9ixB3lcuU3mOnmrD6+zn4x8YEHM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758478; c=relaxed/simple;
	bh=n0Kvyk+T+RtB/i+4T/qp6gEW7032T5bG4AfcmuA3ORA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qhlNmmYrX/4o1wUfT3f+JlnLrPiMZiGtqdKIbeUNBKE3KBKVpnT8Ome0GrewcGjsTvyd7hNCsup/Fnu79JYYD+RZDV8e7xqio5jdUySCXooXAd1X3OuiHTgFmJjr5IyDY4SNTp7lzBRWBEaDeYJMCsGvZyGaWUNJ+4RbyzdTCh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io; spf=pass smtp.mailfrom=gtucker.io; dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b=XitJNlei; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gtucker.io
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C1BC1BF204;
	Fri,  7 Jun 2024 11:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gtucker.io; s=gm1;
	t=1717758468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJUCbM546q0LNVWlhbxcY9aawRMHmngLwnBnq4OdBYc=;
	b=XitJNlei8F6drUPTvnCYDL/f93y60prNCd9OHDeWV92QxHGeTgQTsd6f9bCuk9DLPWMbSq
	26ziB2MEtIT20BO8XyGai8wQ/nV67nEMAC8Uj+DHPO309VXac1msGXy7Dg/SXSvE7WFrXW
	Aupejt5cq9TCsgf39zkzzzwfhYrpq7/Iove7FNg2sikueRw8aplSP0GRNYwdVNFHrmLAhF
	+5KjvYE0TWkAcsOVmb8xfDfmLuRb5xg9d/9nFZrrNuT1eDz4Ky2iHY5JF0ga1mphGl66GQ
	gz7iU9aDQg88jwBw2ngoXr1RwK/iD2FgPrg72sDPPiOBpJrk5b5y4Lwi6aPJSw==
Message-ID: <e7ca4831-4e4a-4a7a-a310-459f102154e5@gtucker.io>
Date: Fri, 7 Jun 2024 13:07:47 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel Testing & Dependability Micro-Conference at LPC 2024
From: Guillaume Tucker <gtucker@gtucker.io>
To: automated-testing@lists.yoctoproject.org, kernelci@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kunit-dev@googlegroups.com
Cc: Shuah Khan <skhan@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
References: <aba2b2c0-ebb9-45e3-b14a-2321b7770e03@gtucker.io>
Content-Language: en-GB
Organization: gtucker.io
In-Reply-To: <aba2b2c0-ebb9-45e3-b14a-2321b7770e03@gtucker.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: gtucker@gtucker.io

On 10/05/2024 20:43, Guillaume Tucker wrote:
> Hello,
> 
> We're pleased to announce the return of the Kernel Testing &
> Dependability Micro-Conference at Linux Plumbers 2024:
> 
>   https://lpc.events/event/18/contributions/1665/
> 
> You can already submit proposals by selecting the micro-conf in
> the Track drop-down list:
> 
>   https://lpc.events/login/?next=/event/18/abstracts/%23submit-abstract
> 
> Please note that the deadline for submissions is *Sunday 16th June*

The deadline has now been extended to *Sunday 14th July*

This is to be better aligned with other MCs and to give more time
to submit topics.  The reason for having a rather early deadline
was based on the feedback that it helps to have a response early,
especially for those who need approval to book their trip.

So the new deadline is when we'll start finalising the schedule
to submit to the LPC organisers (Steven).  If you do require any
earlier feedback then please let us know when sending your
proposal and we'll take a look on a case-by-case basis.

> The event description contains a list of suggested topics
> inherited from past editions.  Is there anything in particular
> you would like to see discussed this year?
> 
> Knowing people's interests helps with triaging proposals and
> making the micro-conf as relevant as possible.  See you there!

Thanks,
Guillaume


