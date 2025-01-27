Return-Path: <linux-kselftest+bounces-25242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE6EA1DB08
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 18:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E26D1888BF1
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 17:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E10189528;
	Mon, 27 Jan 2025 17:10:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D110188736;
	Mon, 27 Jan 2025 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737997856; cv=none; b=MbbG7tIL/T/SUHCPqEsKEFyub+WjVV5eRGfA/fhkukiO23ynvUdy6aG6Y2Oy/3zsnupBxSWuwIYXxnKYRRNVQ+Hif7NgBIFx6NG+hpEgiqSBJ7VN485KzmLAdJ6sr+0/YAnsQjn3wZgwsEH4LXLrO6EqZDr5vNCtG9xNkq4XWgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737997856; c=relaxed/simple;
	bh=Bi+qspMKKsh4IalPW5ItwF1IXJOMsqx915Y+atCisKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/eLt8hdBp5vqZJBhbdzylGN8iuL0zOELrKX2mlIxPbq2MTtgSnJNVcnUTk5zWIyC6YaNfgXaCtKEPAPeIEmpXsujFB6WqkKmOpX00EkE4Vj9es9MrZKelaZ3Sxl0RrsQPuB/3JR77pJKYx/Psc6HsOnGrQ6cwokIaI+3oh0+28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d932eac638so9201757a12.1;
        Mon, 27 Jan 2025 09:10:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737997852; x=1738602652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVF05zC6+ZNJvFRi7LzbSSs7l9kPd2AWr8fGMwkBgvQ=;
        b=OnTM0pWEhHeBXpj7Ovj8RlOJsYqCUtDDnWAzQOErbi+57aM2kw4gHQ05FbNb1IbVd4
         9NgMb7RWa+IfMGuFQ9y1WK2ikR0slbYcvZYFJQ8o5BwRum292N1+/UYhvm1wRg9BZKH+
         4Bpk2ImtG3UTYXV9cbvOi8VLlDo98DiU/bv90Bxrm0MjB3UwW2TXRGIdIs+hxJFV/8R6
         jXSpRlsGgLxR/T+zUtF7TbL4zohS6Wg2u2YbDe53OZki8uTPikWGRX7Fsoy+8PQqjtUa
         5OQ5kjWPzwPCKUX6PMxW3jwq3M45nSuYJoMvT9F1+xiFDRssn9QnH6GRJZwB2+qHleja
         Fwjw==
X-Forwarded-Encrypted: i=1; AJvYcCUgG7ipDmTZ2M2e8xMCnkITN5MYgH2D7/zfj1D/cCTiDSur41MEZRXF8T9Q/766T6F5nSV6ICmoNeI=@vger.kernel.org, AJvYcCX2h0G7utKtAQFCxAGbJI42IQrMP/Hsxp/m3yzMCSjiBBc1EQJEsm5Jwcx0t9Y024+cKukxl0k1@vger.kernel.org, AJvYcCXPZ82bkyQSPekaHaJWxYAqPR4aKLG0z84Pd8OS1YgCQB1fbfEYcLHK6G2TTVF7utpfRQdXATbVWoldjmOC@vger.kernel.org, AJvYcCXiLWJhparBtVCPouam+GckBACNu4e8DggJnvaGUj00mR3EiTmtEtbOGzDPlzfhe0Sz4L79X8HMFxlj7NanCZKZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzPMZpTE8xGosC6QDb8C5ZWRp6h9tsi3bplNit1pTYjKI5IG++1
	tUHHqcnfRFgtGfqdv1Apy4bgdkLN0Dx2sMI3H/WtbQbJIfgwA+/J
X-Gm-Gg: ASbGncs821rqLRe9siR4lEX4Il1nQ0qpI+eKq3OVkd0Uxila3ZR0GWMcM0/diO+Z2zT
	Th7YotwHUuhVKH/wzOg8SVNoH8NPK4iOjl29N4fdTSVCQlj34L7lrtuXM7HqQOk2hZ9WVefMy9E
	uR32Xfb6HKU9EJrJ1QOHKLVtPm3YN+14DuSE8obxcXimgDvafDesMpc3L4+CYWLVRZ2z7RCNPEM
	B9LUoknKiVUgmx9RiGqdTIN5IZOOy8WpbqM6nDlCeatoZI2lSJNYGfMLQCdhlogthXk/4/C
X-Google-Smtp-Source: AGHT+IHMnJgkyhto2i1MusAfY+8Ds920O+thYSdmOl+AWDxF3QeeuCuyz+cNSCTcLes5zVM7LriJXg==
X-Received: by 2002:a17:907:3e1c:b0:aa6:a7ef:7f1f with SMTP id a640c23a62f3a-ab38b0bb338mr4133233766b.11.1737997852069;
        Mon, 27 Jan 2025 09:10:52 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbd46sm619285566b.135.2025.01.27.09.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 09:10:51 -0800 (PST)
Date: Mon, 27 Jan 2025 09:10:49 -0800
From: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, rdunlap@infradead.org,
	kernel-team@meta.com
Subject: Re: [PATCH RFC net-next v3 8/8] netconsole: docs: Add documentation
 for CPU number auto-population
Message-ID: <20250127-passionate-scallop-of-exercise-bcfa03@leitao>
References: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
 <20250124-netcon_cpu-v3-8-12a0d286ba1d@debian.org>
 <57392381-497c-49d8-9ad7-4b50c4939448@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57392381-497c-49d8-9ad7-4b50c4939448@lunn.ch>

On Fri, Jan 24, 2025 at 05:15:10PM +0100, Andrew Lunn wrote:
> > +CPU number auto population in userdata
> > +--------------------------------------
> > +
> > +Inside the netconsole configfs hierarchy, there is a file called
> > +`cpu_nr` under the `userdata` directory. This file is used to enable or disable
> > +the automatic CPU number population feature. This feature automatically
> > +populates the CPU number that is sending the message.
> 
> Biking shedding a bit, but to me `cpu_nr` is the number of a
> CPU. However, you want this to be an enable/disable feature. Would
> `cpu_nr_enable`, or `cpu_nr_auto_populate` be clearer?

Agree, I think `cpu_nr_enable` is way better than just `cpu_nr`. I will
update.


