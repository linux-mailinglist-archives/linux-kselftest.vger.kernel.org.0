Return-Path: <linux-kselftest+bounces-35693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3168FAE6A0C
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 17:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52F107B3AEB
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 15:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A160A2D4B59;
	Tue, 24 Jun 2025 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0eX3oQm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1552D3A8C
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777435; cv=none; b=QgUllCsRc74IjK0IVEmU0/ILEhbAUq0Md7aHdOojp1sagWI4Cz8lXzBX/tUpAUJRj3jZUJKn9jR/ViMSOwBc0O7cHqHMLmmbsXxP2PB39NU7lUOk/sP+WIEy6blC3aeBYsUaK404M4/f3arJf11WvNrtqXm9ZF7FbsHuJ0HFfF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777435; c=relaxed/simple;
	bh=jMqEhYynkcennr8wKmYeLHiF+FQLXfcZxEhCzpHjGlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsyQJ2cnhId3WhHGfjTEGXIJewtHAX1NBtdptlJp4aJQaMpLKnYObvl3BR1Jl4S5UsbylzekBpgJcb9qKPWp2TEYkiWqiXy8k322dL6UM2GzXMTqCdy3oEXRaICNXT2Lh9th7Qt+FXlKc/de2dJ1LqeymV8wdMEraZdWq8XnKGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f0eX3oQm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750777432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AxFy/UyM/AcfaqdQA8jEfmKS1INzzcTgEZ1ohuEg38M=;
	b=f0eX3oQmF2Ju63tb1GA5G97H5aseefTznYhD+/r2/1UMcVCoBobZnDdf6qvDmZCqp3VsY/
	rZXnSGQLUQ7w0WXFqTkY1AaJZsKxgwVk26sJ+ffoB0IyH/eunFwyoF5HJmfA0EPDWug4gd
	1SZjzZCDHU869i9pzbcoE2UFUB0Q3Z8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-0Dvf_VhoMsOK8Wo2dU2v1A-1; Tue, 24 Jun 2025 11:03:50 -0400
X-MC-Unique: 0Dvf_VhoMsOK8Wo2dU2v1A-1
X-Mimecast-MFC-AGG-ID: 0Dvf_VhoMsOK8Wo2dU2v1A_1750777430
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d09bc05b77so890740685a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 08:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750777430; x=1751382230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxFy/UyM/AcfaqdQA8jEfmKS1INzzcTgEZ1ohuEg38M=;
        b=BRgGotFVsz1NFGlFrRNKu+hmGkHtZCh5LlMbmF98THzHEMjEoL7H3WKSL8cdvaWHas
         oaruiac4jWLddN3vIL3N2pePSinaA3knqvYpCQlJ+HVSeRQZRP/KUXWKMnCtx5GW+jiJ
         RWIgwpxUQGGu6IxtXZ1pxfB2XoE7ELdU6Thx+EYTuFbkikIsMOa0v1gEN4QEfir+5JRg
         O5NtAt6vxffLDGdnIRpFJWtn2Ps2L27RW3INkILRkRXJlLmd5vDCbfHH0hhoAWw5ZkZa
         fEgUxZpo1vyG40/Fp3UIpsIfeDA1pqdvw2vKtf5U2aB4lpPGQOrsEe+wup1JMCVcpbKq
         XQpg==
X-Forwarded-Encrypted: i=1; AJvYcCWGD3EQgym247GT0VAgxXPoecSy4XjHtxcLO96I3ebrnzzBpxFZN4maIahJTGoOrM7ExyCbWf+quhRrqBubWoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlHj5WCCly5qc2gUWgk87HK0mAYizmJIfwHnrdxEBiErETUXbi
	5wFo+b0ZRT349I83OIyiuoIBlw5lWBGv52cJlIwjajSzrr4a+BQANyBDGg/LON8rkLAP+wJ5JO9
	qoafznxRcSwua+gDIHkq1dcnAQtodVyczz7ibLe87rEExvBcrPunIMjZEugahWnEkIwOgVg==
X-Gm-Gg: ASbGnctKjaYJAh5eYfXqxuTQYBNPnaVJmvOh0j8V/g19SbIZQD6PUHhNE0P73cEPE/7
	KDJBfoqNpjr/RHkHKUvQmWc9xdELf8I10xcwvWqSs+eCy7voEGhNF7ZRF0/JWs+/Tx1DLEcxIZV
	xceVCNlyRlbb6LRuIXLQDKlgzRbDNShI+lWTlhAbs3t7TXBFp6y5pusRPC03rfIxOykVlehtjYj
	cYfOrsS4a/87/9IveMhubi8rWk89mi1X3t4nNjaTjkBYpsPfOrQfGLXy4QKVti/mLWnb2Mudzzx
	IdHf2GYoQ6XWQA==
X-Received: by 2002:a05:620a:3726:b0:7c3:d7ef:f7f5 with SMTP id af79cd13be357-7d3f98e8ce4mr2496898785a.18.1750777425302;
        Tue, 24 Jun 2025 08:03:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxt6W2DfGa+HmFsUHcXkovy7hDYYpKWKE9TlINSHExnbk0f2RIUiJOZpDemdOGrRyZaI6fZA==
X-Received: by 2002:a05:620a:3726:b0:7c3:d7ef:f7f5 with SMTP id af79cd13be357-7d3f98e8ce4mr2496847285a.18.1750777420052;
        Tue, 24 Jun 2025 08:03:40 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f999a10fsm507225485a.23.2025.06.24.08.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 08:03:39 -0700 (PDT)
Date: Tue, 24 Jun 2025 11:03:36 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Nadav Amit <nadav.amit@gmail.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Li Wang <liwang@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kselftest@vger.kernel.org,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Keith Lucas <keith.lucas@oracle.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>,
	Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2] selftests/mm: Fix UFFDIO_API usage with proper
 two-step feature negotiation
Message-ID: <aFq-SAFB3eWdwwwf@x1.local>
References: <20250622081035.378164-1-liwang@redhat.com>
 <20250624042411.395285-1-liwang@redhat.com>
 <dfd7650d-1154-467d-ae70-c126610413f6@redhat.com>
 <4fd18a1c-aba2-468a-881f-0507953f2904@redhat.com>
 <611F9598-A1A4-47B6-B37E-09BF7B4D17D0@gmail.com>
 <239f75e4-1868-4ac9-882f-664a8863b781@redhat.com>
 <495dc88a-c0b2-4090-a89c-00f000b62a2f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <495dc88a-c0b2-4090-a89c-00f000b62a2f@redhat.com>

On Tue, Jun 24, 2025 at 01:48:50PM +0200, David Hildenbrand wrote:
> The man page was updated with
> 
> commit db3d5cc1a17b0ace008ebe1eaf0ac4d96b4b519a
> Author: Axel Rasmussen <axelrasmussen@google.com>
> Date:   Tue Oct 3 12:45:44 2023 -0700
> 
>     ioctl_userfaultfd.2: Correct and update UFFDIO_API ioctl error codes
>     First, it is not correct that repeated UFFDIO_API calls result in
>     EINVAL.  This is true *if both calls enable features*, but in the case
>     where we're doing a two-step feature detection handshake, the kernel
>     explicitly expects 2 calls (one with no features set).  So, correct this
>     description.
>     Then, some new error cases have been added to the kernel recently, and
>     the man page wasn't updated to note these.  So, add in descriptions of
>     these new error cases.
> 
> @Axel, did you ignore the automatically-set UFFD_FEATURE_INITIALIZED and the
> repeated calls never worked, or was there actually a time where repeated
> UFFDIO_API calls would not result in EINVAL?

The man-pages was inaccurate before. It got updated recently after Kyle
asking similar questions, see:

http://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/commit/?id=6a949e9b08fd1ad4e77584276b9566e45fc07a93

Li's v2 change on using the temp fd looks correct.

Thanks,

-- 
Peter Xu


