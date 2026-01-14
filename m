Return-Path: <linux-kselftest+bounces-48911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B3ED1D21B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 09:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CE6730088B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 08:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA89E37F113;
	Wed, 14 Jan 2026 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="UKdymQ6p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52A13033C1;
	Wed, 14 Jan 2026 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768379608; cv=none; b=FWRlMXbEO65/Wlgz0jxrcILD5bz1v8JiGpSXuCuvRLvILWwqE5yZLOrhBYSoUT1t+4xTFEEA8O8nNWkmvjv8WdlHB/OfPiOfkMHn2ZNKns4yn76u9f18hp0IINkqdOVI5lBfWB42s7cdr6t43+dTdStL/XlhCVXX8NpVtpFz6ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768379608; c=relaxed/simple;
	bh=BkBu5Mtlsmey9tJILFjIfJcRcQ7gOy1PeJvA1cfKMo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQ67lsyLw78Glt0aY50fNlpvhcQ1KWzKGj7cPfeqb7Zx31gAdp806NTmDaUPlke3kqXQ5Lsc377JehiJS02PTyMDpku9P2MA9Lk+/l8IN5FdDzdn7gnt6SKZcAhNVwgYbJk0xwfNSe2un0GJYACDW3O+VwKdjKk7oQ/VpZT360M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=UKdymQ6p; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768379595; x=1768984395; i=markus.elfring@web.de;
	bh=BkBu5Mtlsmey9tJILFjIfJcRcQ7gOy1PeJvA1cfKMo0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UKdymQ6pMxWApEdft+Qmx8RZjUP3RzWHpVt4syDzVgEhjJK4Vytw417wqJ878+6p
	 4QsLIxRkB5BaTAlzxT739n+xa8qDNAIauklFk9t/3UBp3da+9VDT6mres6ue7XCid
	 rAGdyHBaiNahYSje5ws/Ys7OIApKma6inTqIRKIljEnfaTPnLy+1kCSEJrXFTlNZO
	 6A6tONZTe5IrCqhBqoSQwVXpXzWbYz7HVm0sOlJg7NbtRWZKlG6M6GuSnUF7TUbLB
	 Gv41PwA88w2+xvn5YBy6Bqq87qSDcHyt0OWsqsFDOrgf3lrtpu6AR1SEtV7+UHEx6
	 FILGRjN6fB/39A5nhw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.218]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6pUQ-1vksWz0KaM-0002vM; Wed, 14
 Jan 2026 09:33:15 +0100
Message-ID: <1696424e-2092-4e47-bd4f-293e2992056b@web.de>
Date: Wed, 14 Jan 2026 09:33:12 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] selftests: net: improve error handling in
 passive TFO test
To: Yohei Kojima <yk@y-koj.net>, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
References: <cover.1768312014.git.yk@y-koj.net>
 <24707c8133f7095c0e5a94afa69e75c3a80bf6e7.1768312014.git.yk@y-koj.net>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <24707c8133f7095c0e5a94afa69e75c3a80bf6e7.1768312014.git.yk@y-koj.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:hhJqR3IQr+txnzUVkcPyaBlCfVoApQ7DagF0TTCLt9x5UFWRCNZ
 CgF2OQUHxVZ4SOwu7Mru0SP/i/vBKDY11L1+bsrIVqQyJgKN7JFIZaGbbSzDIV+TzWJVs0e
 fec4aR1BIB8BmrufwjPl75rPfu/1bF8t/sadoIRHyNaFrutyky3+ZNuD+PBaEXdojEKmrNk
 8T0iCtl3We8sem0G4sHEQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VkSw+WaBbFk=;PgHe9vIfM+/iAq1F4GpxgJSAbva
 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

> Improve the error handling in passive TFO test to check the return value
> from sendto(), and to fail if read() or fprintf() failed.

You propose to adjust error detection and corresponding exception handling another bit.
How do you think about to take also another look if further function implementations
would be similarly affected?

Regards,
Markus

