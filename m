Return-Path: <linux-kselftest+bounces-17642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4449997411E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 19:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13483287096
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 17:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6AD1A2C3C;
	Tue, 10 Sep 2024 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z1rpb4OY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ACE1A01C3
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990743; cv=none; b=MLEcxjWhPeV2mmlxbob8AvBkKYeIwXyRPoH02GbTLjxNYjKTYX+Us/jvyhSCIiLneTXFgc8zXvSymIEzLJBUEXOoqqWAABm4yedErd8t9GiGSJMaN4d/o9hYw/szba8fIIvHFF0Opu1s0e/ptvLIbJGpn8FIGKjEgvpeVBwVvr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990743; c=relaxed/simple;
	bh=uUC/LUTIl8hUF4sn0aUm+OU92Gx1QknzMJSuTqMK0Xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQnR9ffL70rRZVuj1AtSMBoVlKxvuG7Ws57DQyFgwS4NUJNBv7QLzF788rmWVcnNxP9lEndyfO1GjSsiNQzxguxr5v7t+tRtbS/rQGVvJT3Cu9MMdnmKXBpT33Hblp+wTzzeoMTbOSc+xVVSHP3d+hBai0Is+nrHKQ3jxol87L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z1rpb4OY; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1cc769ba-c732-4155-8d96-5b40140a0d49@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725990739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=30hcu7YNX07HZZ50nf3TiuENhN/I9WggUliJj2wyfWE=;
	b=Z1rpb4OYtr6CBe3FpXBt0pWJlkEqh/AAuw+S5vKeOMDrt4r5HvgtoN58R5uTiaVKoQmWRn
	z1Q/Ihu/uDvR4Ov+9cS0WUbNglvQZMnt+zI2xbiacaFX3FNjmdKvSwobVUecc0yDBccRX3
	vESBq361H4DhxC56GFV8VJzj64aoem0=
Date: Tue, 10 Sep 2024 13:52:14 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] selftests: net: csum: Fix checksums for packets with
 non-zero padding
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <20240906210743.627413-1-sean.anderson@linux.dev>
 <66dbb4fcbf560_2af86229423@willemb.c.googlers.com.notmuch>
 <9d5bf385-2ef0-435d-b6f9-1de55533653b@linux.dev>
 <CANn89iJaXgR6c+moGB5kX6ATbLX6fMP0mUBQN=SAsZfdz5ywNw@mail.gmail.com>
 <66df2fd2d6595_3bff929459@willemb.c.googlers.com.notmuch>
 <20240909165116.1bdb4757@kernel.org>
 <66df9a6d42871_81fd3294e8@willemb.c.googlers.com.notmuch>
 <6d5ca057-87a3-4ec2-a733-8f0c1fb11158@linux.dev>
 <66e084ff8f8aa_c435329483@willemb.c.googlers.com.notmuch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <66e084ff8f8aa_c435329483@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/10/24 13:42, Willem de Bruijn wrote:
> Sean Anderson wrote:
>> On 9/9/24 21:01, Willem de Bruijn wrote:
>> > Jakub Kicinski wrote:
>> >> On Mon, 09 Sep 2024 13:26:42 -0400 Willem de Bruijn wrote:
>> >> > > This seems to be a bug in the driver.
>> >> > > 
>> >> > > A call to skb_put_padto(skb, ETH_ZLEN) should be added.  
>> >> > 
>> >> > In which case this test detecting it may be nice to have, for lack of
>> >> > a more targeted test.
>> >> 
>> >> IIUC we're basically saying that we don't need to trim because pad
>> >> should be 0? In that case maybe let's keep the patch but add a check 
>> >> on top which scans the pad for non-zero bytes, and print an informative
>> >> warning?
>> > 
>> > Data arriving with padding probably deserves a separate test.
>> > 
>> > We can use this csum test as stand-in, I suppose.
>> > 
>> > Is it safe to assume that all padding is wrong on ingress, not just
>> > non-zero padding. The ip stack itself treats it as benign and trims
>> > the trailing bytes silently.
>> > 
>> > I do know of legitimate cases of trailer data lifting along.
>> 
>> Ideally we would test that
>> 
>> - Ingress padding is ignored.
> 
> I think the goal of a hardware padding test is to detect when padding
> leaks onto the wire.

Which is the subject of my second bullet.

> If not adding a new test, detect in csum and fail anytime padding is
> detected (i.e., not only non-zero)?

As noted below, this is only a problem if we leak kernel memory in the
padding. Otherwise, any kind of padding at all is completely standard
conformant.

>> - Egress padding does not leak past the buffer. The easiest way to
>>   handle this would be to check that it is constant (e.g. all the
>>   padding uses the same value), but this could have false-positives for
>>   e.g. timestamps.
>> 
>> --Sean
> 
> 

