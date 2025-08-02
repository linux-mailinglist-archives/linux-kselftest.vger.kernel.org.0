Return-Path: <linux-kselftest+bounces-38202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A69B18A6F
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 04:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0B41AA0B5F
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 02:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225EF38DDB;
	Sat,  2 Aug 2025 02:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OixhEDSP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF95372
	for <linux-kselftest@vger.kernel.org>; Sat,  2 Aug 2025 02:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754102038; cv=none; b=mSThNSifLWfNY5L8SZ9V629UB/DhNl5MkGhW1uEv71f81T6PEBG8GiW1BP11OsIku/99doRhHvL4JTJ2Y+c7o+C4JtWW38PgFo2CYDP7bfanKaqLhfsGCldwtwGLcUw/IqTOXSmqGAw3Z2/RaL/6cfVx+ioc1BUC/RCJI879q78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754102038; c=relaxed/simple;
	bh=f5jTvnQpPFMVvJjbsi+y3geSzdHPE97vaNVq/IKJh1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogXU5LjKVDKyTATykER1WeRoX5L7nDJGggMlvrqo/8mtpNQBOEepM/CoXr6gSTn3rI9mEovbjOcFwqHcO9qObyWZXNFVUWCilMWYbASIeQag3BvHYj7LThwkpTww35SK100d+BKDLBb/5YSKaHWNvwfi/D8j5EP/rSRhZHZ4Ce0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OixhEDSP; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-615aa7de35bso5376963a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Aug 2025 19:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754102035; x=1754706835; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5hSBiZ/cKqJM58oRIaionb2Z3usqZlXR2SNTwitsQU=;
        b=OixhEDSPk0xTF1SkZnS7yRxQ+9qY4xaec51ZfIWpGNj6RlGyjw4dmDcZvjF5768mXp
         dA3cJHXpmIRgxwSkKlhwU6e9b/8A+yxr/95otz58KiZeijJQ0mWh5mnG9bkqUGz82riy
         kc3keZSxWB4+auYjh7fasop0dCpObZy8Z4seySXiaIpzdoiJ1EMZ3G675TrUVb/muJjB
         l1cWYhTuPtCF5HfSfojzX9JzJnLRgTCDVLf7xfRldcA64TMDgVKiJ+bTkha0we/zx+SW
         Lw9GVwrydxUAY8zbycrmC3/inCxAuEngHv/YjNtB6iN3moPswsPobsLoAdInJCtGDY/i
         z/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754102035; x=1754706835;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r5hSBiZ/cKqJM58oRIaionb2Z3usqZlXR2SNTwitsQU=;
        b=sED6juJ7wKBTO9K2JP3/yHgjedrlrPadA1+/6OaJaMTqZKnce4SRvg/8j2vx7DHdw8
         4QgMncA0TIZi3liVZApifF6NiWEqlC8b0/1m89FMjVlbXHPS51GukK2Y/D9ULB3UHiIq
         +5o8N76DugyUI9+JZBrohxPI7og6GDJUpz0+Vze2FjKhzfl6BICA7ZlpoPKZ3yS0Z4cR
         QgoKlS74XTLDz2X+1Ad6aUpsYBR2w/m1FCB5fOxRwXbF9ibwc7d6HSQjw2/nh338zlSg
         xkHi/1G++th4MBKIUuURnLSAFmLRMc/6anrrzxEcYHoOBEtyMJ2afTyihsLUDtOWI+oH
         fMHg==
X-Forwarded-Encrypted: i=1; AJvYcCWSf+8VIyVu2kC39tMkIAWT3XeaSI2nOdMGNRyeWmdTsVkR8AVeDNr7IoEwylBO75lp6lhNtPGIW7JBTYoJnU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz24b6yfad0Eu798h8AdzIXxCwe3chp0fPDmAp/Lp/07uO8CqOe
	cwXYP+gO2mgoezDCZpLCU0+hlziWyVzIFo4C9nRnwuPXpA9EbCQ4SgHG
X-Gm-Gg: ASbGncs5eV6AkkzUVVd0V2bIho+zlaHCHiJJVr7ebqIBdlKPO0DI4KM6mChZR6zQ+CP
	92zupCE0zwvuI9Xq7gCPRUTj/r2Cyuat3WKwa2KP1+BQ5rOXM/H6VB5DhksLn1M+iEVtulq7ehw
	YTspFOaKTtscFbGYcofunOFcAXBjOkkVTI6FpxEvy4RBJw5xOLTqdRiSOdRw2v87u4+sl+cFINj
	ukQ8e/hK9r4HMabQe1JeTEHIULrx4NIZ3GXkCDYZtRIrUQZppmqFg3X82RdcaQ0Xaunmvx6xLcx
	wdOvIob3SiRPmk+8MUFY/hW0CbTRq4i8YKW4SNgovgdMuOeg43l7M7ObPCElklrhqGWIULUx1a/
	f5qHBUrWeSs+zUkGgNtY3aQ==
X-Google-Smtp-Source: AGHT+IEYXjXLB/W/F13Bzhx+kA582GaDn8mNpPncwxNcA1mYi2Mc3vcqPib7FOBB07/wQRnY02U11w==
X-Received: by 2002:a05:6402:3510:b0:615:4728:f07 with SMTP id 4fb4d7f45d1cf-615e6ef372dmr1495701a12.15.1754102034533;
        Fri, 01 Aug 2025 19:33:54 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f15a66sm3591482a12.16.2025.08.01.19.33.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Aug 2025 19:33:54 -0700 (PDT)
Date: Sat, 2 Aug 2025 02:33:53 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>,
	Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH] selftests/mm: link with thp_settings when necessary
Message-ID: <20250802023353.jknszntp64x2lvih@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250801085444.27182-1-richard.weiyang@gmail.com>
 <566ff1f0-e6f4-4888-a901-4995a84d15b7@redhat.com>
 <de1d81bd-0178-4649-97a7-016f6f349cf4@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de1d81bd-0178-4649-97a7-016f6f349cf4@lucifer.local>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Aug 01, 2025 at 12:14:34PM +0100, Lorenzo Stoakes wrote:
>On Fri, Aug 01, 2025 at 11:02:35AM +0200, David Hildenbrand wrote:
>> On 01.08.25 10:54, Wei Yang wrote:
>> > Currently all test cases are linked with thp_settings, while only 6
>> > out of 50+ targets rely on it.
>> >
>> > Instead of making thp_settings as a common dependency, link it only
>> > when necessary.
>>
>>
>> You don't state why we should care about that? I don't see how binary size
>> is a problem, why do you think it is?
>
>Yeah overall I'm with David on this, I'd rather we keep things simple (so
>you don't need to remember to link against this file) and just plonk all
>the stuff you need to link to together in the Makefile.

I have thought about this, while current implementation do specify its
necessary dependency for some target like uffd-common.c/pkey_util.c.

So I thought we may keep the same style.

>
>It's not really a big deal when it comes to test stuff I don't think.
>

Yes, this is not a big deal in general. I come up with this idea because my test
machine is too old. This change could same me some time during
coding/debugging.

>Cheers, Lorenzo

-- 
Wei Yang
Help you, Help me

