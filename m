Return-Path: <linux-kselftest+bounces-8227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B328A7635
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 23:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2FF283F67
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 21:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE5D6BFA1;
	Tue, 16 Apr 2024 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="iO2yfpko"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCC35A116;
	Tue, 16 Apr 2024 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302307; cv=none; b=MDudNpoP0WIaZ91bIKCiw3FY8c7Tyq6kJ0B8eDIOTW+KQOZlTITkB79VawvLpgwLKiqQ/liIIno5+y7tnqmIuFDnNKkUny3l5RMTlyhIEXU3JWm/FQY6olVnywbm5C+Pi7GOFxiepGcl1g8LeGrBwbBORqonrs8ZWiXKVq43blg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302307; c=relaxed/simple;
	bh=Cn6Ur+lEO6pXpUkyOQcSUlDluhnPLo/L86F4tFesbWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7yR3W/Fby2Ezr1Ys0Q0VOsDfQ+dmU9QqodXTo33ms5lpKJJbqjVpKEOm78H/mavz4X+bNlukpMYOHzVAlv2w90NTsBGYbKX5RAXh19Ixiul1H3iorbvzCJErZKZWS5Csstdy1XZyHkG6cSg5pNoyT1M5AJgxMI5cxVpZmztPrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=iO2yfpko; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=Aw853cVuuYpsncrsuUTwlxGwGrfDn8CepOCG8/9D2wg=; b=iO2yfpko1aoM88vBxSVUqL1HHH
	rpxUoaLEHf3Bk5TQYKkSvXqyhm2JQq+JVoHYZMRgMLdBZkYomdOfBJ72vJCYt84uOo7QL/Pa0a7hW
	75FojKi8upYzTG9wZbad0hatCWkqYIenMf7CWTz7b2DbO1GyoxW+4YjIUa6TJG0hA22lgbYhkHffx
	/ShCvMsmIltxaa8LleEDapEvFWE0d4b2IL++X8hjDNAR0iamZRrZA/5v1e35+6Ovj3k5UZYcC1hIv
	0f8x5aAMGZwsEYQ18Ma5rj1dwslSL7io4FKTecyfcPwRSxpufc/CqKRuYeYJGFUhF1wUYNc+yCaPd
	THOx0s9g==;
Received: from [10.69.139.14] (helo=terabithia.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rwqC3-00GSyv-31;
	Tue, 16 Apr 2024 16:18:20 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v4 00/30] NT synchronization primitive driver
Date: Tue, 16 Apr 2024 16:18:19 -0500
Message-ID: <2602449.Lt9SDvczpP@terabithia>
In-Reply-To: <20240416160553.GA30707@noisy.programming.kicks-ass.net>
References:
 <20240416010837.333694-1-zfigura@codeweavers.com>
 <20240416160553.GA30707@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 16 April 2024 11:05:53 CDT Peter Zijlstra wrote:
> On Mon, Apr 15, 2024 at 08:08:10PM -0500, Elizabeth Figura wrote:
> > The intended semantics of the patches are broadly intended to match those
> > of the corresponding Windows functions. For those not already familiar
> > with the Windows functions (or their undocumented behaviour), patch 27/27
> > provides a detailed specification, and individual patches also include a
> > brief description of the API they are implementing.
> 
> You happen to have a readable copy of patch 27 around? RST is utter
> garbage to read :/

An HTML copy should be available here now (thanks Arek):

    https://ivyl.gg/ntsync/ntsync.html

Let me know if that's good enough or if I should try to render it into plain 
text somehow.



