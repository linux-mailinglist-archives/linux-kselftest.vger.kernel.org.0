Return-Path: <linux-kselftest+bounces-38858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12641B24BD1
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 16:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1101B665CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 14:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74162F0C62;
	Wed, 13 Aug 2025 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErExK45K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA5B2ED159;
	Wed, 13 Aug 2025 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095137; cv=none; b=sVgCipSDEfkFrUrn4kKX1Il3taEpgOnQ7rYD5H8fvIf9Y8m7jB9wonPFqJxy8xjenYKnrACvV+dEgXHjw/lUgNgnSDxF0AIRW+tAcHMNGmiIagY3J2ebElo5A41fzI96vEW96pOf6dvw2UZGF5X+eZQKSNMBhMYGN+ge+/ditrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095137; c=relaxed/simple;
	bh=s9+rxMFL44IKToOutqxDtZw5jz/ESi8pUno0QbbD/hc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XYEoXIf0ecHNL4BK7DA/Lrsp9ieUBbjzKUaO5eQ88SrInZUZNyi009s8w5je6w8ATSRZziKm+oXn64I20sX5qA8DNtNEiRXm7JGp2pz6BHeixXQc1TEj6umNIL1d5MMtdEVf6LbAxSTDIbTBmlNlob3SwfrbR9NfE7mc0cEQIlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErExK45K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E096C4CEF6;
	Wed, 13 Aug 2025 14:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755095137;
	bh=s9+rxMFL44IKToOutqxDtZw5jz/ESi8pUno0QbbD/hc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ErExK45KAh3taU5Ay7lJ7MJ0BMkjWDiD1DN0JR/zuy5xUd2msBop/vOSselq0P951
	 xqaTacLr4JhC6juOA4x7iB/ICnUr91Z6DOwtkW7YEBLK8BOn6VMNdPLf6s/gJAyqDf
	 wz9mpbOVw45GKbGKmjoqBkjluU1Kbvsvyb6kJTUtCyZcPX8JRc1HxQl06bXJNhzkER
	 ce9WafJQZ8HSp7R53BwGs/NZ53f2B42giPZrrJllQc+T8yfZx9Ko5Zwzg2Alnu/cJR
	 Grg83L4s85KTn/NZGLzo8tA2ilXtoRL7JIw9wePMzXiMSqBRw8ZumQmP0uYiEH8+oT
	 jgB7rSEXyuNog==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Graf <graf@amazon.com>,  Baoquan
 He <bhe@redhat.com>,  Changyuan Lyu <changyuanl@google.com>,  Pasha
 Tatashin <pasha.tatashin@soleen.com>,  Shuah Khan <shuah@kernel.org>,
  Thomas Weischuh <linux@weissschuh.net>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH 1/3] kho: allow scratch areas with zero size
In-Reply-To: <aJycKRCEqbW0pgwR@kernel.org>
References: <20250811082510.4154080-1-rppt@kernel.org>
	<20250811082510.4154080-2-rppt@kernel.org> <mafs0349vwd1i.fsf@kernel.org>
	<aJycKRCEqbW0pgwR@kernel.org>
Date: Wed, 13 Aug 2025 16:25:34 +0200
Message-ID: <mafs0ikiruwm9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 13 2025, Mike Rapoport wrote:

> On Wed, Aug 13, 2025 at 03:45:29PM +0200, Pratyush Yadav wrote:
>> On Mon, Aug 11 2025, Mike Rapoport wrote:
>> 
>> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> >
>> > Parsing of kho_scratch parameter treats zero size as an invalid value,
>> > although it should be fine for user to request zero sized scratch area
>> > for some types if scratch memory, when for example there is no need to
>> > create scratch area in the low memory.
>> 
>> Can the system boot with 0 per-node memory? If not, then perhaps we
>> should only allow lowmem scratch to be zero?
>
> In most cases yes because most of boot time allocations have fallback to
> "any node".
> And there's also an option to omit the "global" scratch and boot with only
> per-node scratch areas, so I'd keep the possibility of setting any of these
> to 0.

Makes sense. In that case,

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

>
>> > Treat zero as a valid value for a scratch area size but reject
>> > kho_scratch parameter that defines no scratch memory at all.
>> >
>> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> > ---
>> >  kernel/kexec_handover.c | 7 ++++++-
>> >  1 file changed, 6 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
>> > index e49743ae52c5..c6ac5a5e51cb 100644
>> > --- a/kernel/kexec_handover.c
>> > +++ b/kernel/kexec_handover.c
>> > @@ -385,6 +385,7 @@ static int __init kho_parse_scratch_size(char *p)
>> >  {
>> >  	size_t len;
>> >  	unsigned long sizes[3];
>> > +	size_t total_size = 0;
>> >  	int i;
>> >  
>> >  	if (!p)
>> > @@ -421,11 +422,15 @@ static int __init kho_parse_scratch_size(char *p)
>> >  		}
>> >  
>> >  		sizes[i] = memparse(p, &endp);
>> > -		if (!sizes[i] || endp == p)
>> > +		if (endp == p)
>> >  			return -EINVAL;
>> >  		p = endp;
>> > +		total_size += sizes[i];
>> >  	}
>> >  
>> > +	if (!total_size)
>> > +		return -EINVAL;
>> > +
>> 
>> Looks good. BTW, unrelated to this patch, but should we also check that
>> p == '\0' here to make sure the whole argument was consumed?
>
> Care to send a patch? ;-) 

Will do :-)

>  
>> >  	scratch_size_lowmem = sizes[0];
>> >  	scratch_size_global = sizes[1];
>> >  	scratch_size_pernode = sizes[2];
>> 
>> -- 
>> Regards,
>> Pratyush Yadav

-- 
Regards,
Pratyush Yadav

