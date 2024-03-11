Return-Path: <linux-kselftest+bounces-6227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5F88788ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 20:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A096B20D58
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 19:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6759354F9D;
	Mon, 11 Mar 2024 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhJVSfHI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B175054F83
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185314; cv=none; b=NAXWM1miW3+73jb8o0sxNyCmGnR5Btg9wRi4+jhFKfTJIISvCFkjE7V2r4nQzwIF0IJm/EA9fWhO+ROtNpqXFXSr83yeJw64jzJVF3LSonlRAEqkErSKcYUpPBBtBU1wD8co6ShdnAUhzc4g0K8O9lLCh9PZyqB5c/lcCG8Abmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185314; c=relaxed/simple;
	bh=o2h7eUf6KHi6kWXMN+bTe9GJKu4J7HhYQa+OrrVRTI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8Kyi64Rl8Ank45YoLM59Yygrsg2SiDAgRHHXkklDhmoJ8pG+BhjnYVoiX+fmZXNHDL6S+BFwqWfbuZld4bTUpjBzDi1w5NF+YrvnQZ6NpFw7ljDBZHJ0wBxmby4woTeeElduUh7sB/RwIFV2eaFWtNQNnA8vKhp5QGx7V8Az70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PhJVSfHI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710185311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FAVXB/mXoK7CZU4s1o0G19dHxslq0BXaeV69BqYUoiw=;
	b=PhJVSfHI2DRTSafBU7gJKuIAWZhB2mKMXxo690c4EwMjOkG2jUjtpuSlBGRmVrezJVUbzl
	ydDFowJAfYlUQnanclwdNtbxcWtOTqp4uKFDZYwSfV7kWkPYlieIUdIKyd6pXMvDp577oP
	gmdsEze2kGEIE0+YszXg8FiICAqmRLY=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387--fsPJTpsMB2qZKBml55pqQ-1; Mon, 11 Mar 2024 15:28:30 -0400
X-MC-Unique: -fsPJTpsMB2qZKBml55pqQ-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6e4e54fb7b4so2215637a34.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 12:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710185309; x=1710790109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAVXB/mXoK7CZU4s1o0G19dHxslq0BXaeV69BqYUoiw=;
        b=FrXZdtUu9CbH0dxDKNerazyJEkNQDVVjqw1co9aqO2U07mwN44RHbREaOlOR5wb3g7
         suJmRdXkGNOhsGoFWx75kCAYLcjxh6mOP46V4KoOsQLA2mQqaIXEehJWzmZ8f+8VJkun
         SrUdfojW/1F1+iepyVqW51p81jUqwlj600mhH1svt4d9I7o0IUS7/RdsTna4FZhxC0jS
         Jy6xDYWFS4Zqowr4lTV8U/B3HQvITTk8RhPRahtUx+hH7Go+Lge963Dc+zUs7cZ7EujS
         Jdt75FIM84B2PfdD14zWjSV71mGeJ8Tpx97gqksCFIPouhD9cO8txQDfZCw6iAhUXetS
         LDDA==
X-Forwarded-Encrypted: i=1; AJvYcCVIPLVcbjX4OM8uG4Gx7izhjVQEEuoBQDSxP5XCxuOnexiokDnvw2z4MCbymfDow8axDbnx7WrqV2pKCtmdhI1fPtHUX++MoF8dN/5Qplf3
X-Gm-Message-State: AOJu0Yzn/08bRhudDbmBjRtf76oR+Ft1UG/tSpJJmm+nMHv2Z6uhRQ+a
	ATuIjqWV7lthkz+o0OTCr0vmEC+6pZYCDnsMC8WqeO0TFRds47Dej1RJ/FIePnxuSFA2OF9Jssd
	35xrgdxpBsbm+saH0NsMiVrJnODuHze4ULmjbvtcF2jpSBCQZ1Tc+cJEI3BQAOZUh2A==
X-Received: by 2002:a4a:a44c:0:b0:5a2:3c1:a624 with SMTP id w12-20020a4aa44c000000b005a203c1a624mr3727471ool.1.1710185309490;
        Mon, 11 Mar 2024 12:28:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/VMFWq2kIQEJ16kIMzxcU9BTefs+9QqGcG3RbD0ZtdZlOIyjSBXC6THIfOoARSG3/qusrVQ==
X-Received: by 2002:a4a:a44c:0:b0:5a2:3c1:a624 with SMTP id w12-20020a4aa44c000000b005a203c1a624mr3727456ool.1.1710185309168;
        Mon, 11 Mar 2024 12:28:29 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id h7-20020a05620a400700b007882e50260fsm2950520qko.104.2024.03.11.12.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 12:28:28 -0700 (PDT)
Date: Mon, 11 Mar 2024 15:28:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: David Hildenbrand <david@redhat.com>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: BUG selftests/mm]
Message-ID: <Ze9bWkrD6UBZ2ErV@x1n>
References: <a9e3120d-8b79-4435-b113-ceb20aa45ee2@alu.unizg.hr>
 <4a5c8d28-7f73-4c15-b288-641f0ccc91c2@redhat.com>
 <Ze8Wr2qH8V0LMi_5@x1n>
 <b5ff4c70-6379-4cc7-8c92-778d80a6a658@redhat.com>
 <Ze8fYF5I4mlUGHd9@x1n>
 <CAJHvVcie+N+4j60m_Dxh7QzbZLmsjnq2-04peuqE8VkkMq984A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcie+N+4j60m_Dxh7QzbZLmsjnq2-04peuqE8VkkMq984A@mail.gmail.com>

On Mon, Mar 11, 2024 at 11:59:59AM -0700, Axel Rasmussen wrote:
> I'd prefer not to require root or CAP_SYS_ADMIN or similar for
> UFFDIO_POISON, because those control access to lots more things
> besides, which we don't necessarily want the process using UFFD to be
> able to do. :/
> 
> Ratelimiting seems fairly reasonable to me. I do see the concern about
> dropping some addresses though.

Do you know how much could an admin rely on such addresses?  How frequent
would MCE generate normally in a sane system?

> Perhaps we can mitigate that concern by defining our own ratelimit
> interval/burst configuration?

Any details?

> Another idea would be to only ratelimit it if !CONFIG_DEBUG_VM or
> similar. Not sure if that's considered valid or not. :)

This, OTOH, sounds like an overkill..

I just checked again on the detail of ratelimit code, where we by default
it has:

#define DEFAULT_RATELIMIT_INTERVAL	(5 * HZ)
#define DEFAULT_RATELIMIT_BURST		10

So it allows a 10 times burst rather than 2.. IIUC it means even if
there're continous 10 MCEs it won't get suppressed, until the 11th came, in
5 seconds interval.  I think it means it's possibly even less of a concern
to directly use pr_err_ratelimited().

Thanks,

-- 
Peter Xu


