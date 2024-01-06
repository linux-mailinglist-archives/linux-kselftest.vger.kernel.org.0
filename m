Return-Path: <linux-kselftest+bounces-2682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB71982618D
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jan 2024 22:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F2F1C20E9D
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jan 2024 21:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7ADF4F8;
	Sat,  6 Jan 2024 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="dIOLKMKo";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="Jx1YnUfq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6818B101C0;
	Sat,  6 Jan 2024 21:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 4A2186017E;
	Sat,  6 Jan 2024 22:02:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704574959; bh=BxsZaTTHmQjXlXIaqqVDt2FbBWu5XHnBXUrmPbzAXXo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dIOLKMKonxQR+xdhK+tw8jExuVGCFyDRaRxlliUo9PPGfucFS+k7XW51tWb1QPv8L
	 jONHZMr6oR1vZLyZwT/EBhr3uKLs88/dcOEwIUXPTSUx/rrMnKgyNJuweXCLJCdGYB
	 L419HTGmnl2GBusDtjuotP9vUKCVzh8ZQOhegrZXpcNqw9mIU9IujBT9dBazKjj870
	 Gomb37NmV213J9ZD61Z3RaN2PB49o+X1Y0TlpnCZG/2QI0alH9ya4es1h1Tnbon7zR
	 idpD7A9QNJN4CJsVhWZ1qy5MfYLNYrQDIgB4aTPSposq2l7e0vwBah/riTQjMUCspk
	 r/4ZbxSrk/orw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kt8goUn3UaCk; Sat,  6 Jan 2024 22:02:37 +0100 (CET)
Received: from [192.168.92.51] (unknown [95.168.116.36])
	by domac.alu.hr (Postfix) with ESMTPSA id EFF5A60171;
	Sat,  6 Jan 2024 22:02:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704574957; bh=BxsZaTTHmQjXlXIaqqVDt2FbBWu5XHnBXUrmPbzAXXo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jx1YnUfqNzudmwmsJEs5asKbHizYvo4REnMQCZD16CZEUsyPpMgwXkjyHebyMNCko
	 bVa5aetB28wMyUTLK21O4JhBGiZtXfOrT2vNB51TCdBCEZddpY3EKRdMTlyEbVyvou
	 n/fZGVNYG1CfMFcyTVeeiCNaJrwXtNlcwRkfFz79CHSOIQ2hC+UwyKPfqFJ3SfnULJ
	 RmPNEqyr6Sf8wUruyoQNepiBj5HQ7Hit5REyQB4DW//PImVawJ6Ig2ltcPcaZx3Zi7
	 IX5sX6AbBw8jnPYK2+9I7q4M+Nl3Bf6AB29tPS8FpZ19sB00edADNgreMurUXcZJ63
	 9i1lWweHRXm2w==
Message-ID: <5f46cd87-ecad-4cad-bb03-b5bf22dff3b7@alu.unizg.hr>
Date: Sat, 6 Jan 2024 22:02:34 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: selftest: net: fcnal-test.sh TIMEOUT
Content-Language: en-US, hr
To: David Ahern <dsahern@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <0b9a2827-c9c5-41d6-a4f1-dbd91262c474@alu.unizg.hr>
 <e0a52f62-3ea8-48c4-a5c4-307f7642cd45@kernel.org>
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <e0a52f62-3ea8-48c4-a5c4-307f7642cd45@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06. 01. 2024. 17:16, David Ahern wrote:
> On 1/5/24 2:41 AM, Mirsad Todorovac wrote:
>> diff --git a/tools/testing/selftests/net/settings
>> b/tools/testing/selftests/net/settings index dfc27cdc6c05..ed8418e8217a
>> 100644 --- a/tools/testing/selftests/net/settings +++
>> b/tools/testing/selftests/net/settings @@ -1 +1 @@ -timeout=1500
>> +timeout=3600
> 
> bumping the timeout is fine to me. that script is running a lot of
> permutations.

Well, aren't bugs best discovered if all cases or permutations are tested?

I recall some cases with Giullaume and Ido fixing them the last Summer or so.

Thanks.

Regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

"I see something approaching fast ... Will it be friends with me?"


