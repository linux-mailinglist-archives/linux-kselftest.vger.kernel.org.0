Return-Path: <linux-kselftest+bounces-43976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D2DC06772
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 15:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB1714E21C5
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 13:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C34631B13A;
	Fri, 24 Oct 2025 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HDHGMijU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DF7319867
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312119; cv=none; b=hlWgm2EhCPseP/PoVT0mkOJRT6Pka8MG5Ei5+H1OwVraAODpsh2/D6l0zkczWSqNMAtkiNT91534XwHbLOsS5AQ996AuWe7X2m1iGlMQ5v2C5ESbkahvz0sFExcP/T2GkGn3YNoq40MzdleadAJRFmzoVXNmhlNfHu9croflNgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312119; c=relaxed/simple;
	bh=RPCzSX1oysyX6317kBY4C69cJS7GZoh7NbUICcDmhcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXIFF/FXEH4vPP8I7ElG4PaW9ZGhL6iQo86g+B28z/82ByGQKUdBc2IdUtHX2gLqhO1Dgh8lWDeYsHQkVVbsXdlG2Xk8iSPEOGa46VtrzA8P0Zjg1W7i2YNoj4dhnoKkU7NBwgdy8DCLCYGqc6lYItwMXo9ZsK1yMVlsP6W6i38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HDHGMijU; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8915bd01244so331532085a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 06:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761312116; x=1761916916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SAQ779KA4rgqpBPvYfGfpoeCfLnfK7s3JhseOdjjejg=;
        b=HDHGMijUvIGtwcUK2yjuSrnVPHSpn9VB4tFX549rxEmiaPwfKmalf+NVDeRzOG/jvc
         a0H1hU22mMlaGW8SKpk1568+1t/E8lvLk7JD2/rgGXUoR+ssSP5a5PwIj0tpI8PN+hCy
         Onh1vAsL6N0grY62c6QPzx0C3qvCAyVnAzIilK0gdrtDwewIGkKuD83LPt+8aw/YI5Qb
         AlfR1/fvONLKqQhjKYxC6B66Or7GqBXJ6bQ1ROoQ68PSdL2Hm5kqS97PBgzD/B/M+AfA
         AAiHCYzEBoqa5+wxZF2SyYlKOedsrVG8m0CXFezzxCAdu9ckOB6d82BgEvQGoQrMHBVm
         hAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761312116; x=1761916916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAQ779KA4rgqpBPvYfGfpoeCfLnfK7s3JhseOdjjejg=;
        b=AwpxjmOuln5oUoY11O2sD/IFT6LDb8ITrvLNO4nb0wDDiXOIOCvjT04auvk9698x75
         xBW50Wqf1Gx3z/ida3+VRy1PCY7ejDeZexic0NMSmeeotJtdQAccazlSKpo7LlMtsunv
         nIssmHHULr1E7mKna9Gks1iwecAfz3nWHSf9XHBCti8M6MO8wXRk2AKQPSxk7wVpX2pz
         /0aK+5qyQaMMeBjuGgHPb7HayGVqt8dN/pjI6RZDJDYmB/u0r+Use7rdWLAoryoxaE16
         8z+08cfXNwF0DL518pyAaRID8RyX/zf/MbXBk4HQiUigT/EbttdmhyJL2dVyY/3Upxgd
         7FoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGPDvcIDYvQbReG1ghTfu0M9akmj51BUHcj9d9VkXZTUWqU6WxztBwVQUdi1cruzZr+Z3rECfFXvTjLnJygTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBfQ0j6BJA83HWo9Y/pgoSkogAXIRZoCT2WxgzOXBt/4BeUenA
	4Z2Ye5D9OJA3gvExJ4crAhVts5PhgkkR9KRs5a2ENlLSqdg+4zCakuo4ML4EXsnUDoQ=
X-Gm-Gg: ASbGncul0VAbEoUu2uAeTM/0P4z0IfafrW529HO1PhNpGL+JcEBC1h35VDQEmsVJjQp
	bZ6E2ixIfmrArEFFCIil62PpvbN0GshF/VX1tlph1Q25bFk8auo+S7IbfatsenvL5yu8m+hN7g3
	g3DlPRhkI5uEDhRPeXNrGu/ZZfL38YQwtYup+PInr9N3dhWcAFRa4W6qrNdd+v9JocYZKHIRAgw
	F2gMcwRIwyfQoZLZGXR5ajjKgvf7Tc/mkSnvy+cAOWdUZxNCE3/xghheu/nThPmzJHAAJRIz1JL
	3Ml6+NyIlqojY9BC43t4d+X3TOXPL9ngUgY2zOzqPvcwnM6/aXiIGsu87gvr0B9QCBPcnIAGI2N
	B2aZYaJAibaYpPauZQqq4Tt5t6yqw/DV6jGj5fA8lN6RVnfsEJSINaLRFB04RCXJuOCLCwZnZaO
	jQuIAKwa+HEFCfeI6dJJ1Ogeymn5e8pVRd6fJXOMJXGAjDTw==
X-Google-Smtp-Source: AGHT+IF631U7b/Uv4UfsWkET0fESocT6MB8PTnMKWhD//uyVN3fsa04WJmaAsspdgQynojvxMNqoYw==
X-Received: by 2002:a05:620a:46a8:b0:890:379d:9807 with SMTP id af79cd13be357-8906fd18325mr3332613385a.41.1761312116477;
        Fri, 24 Oct 2025 06:21:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c120567b1sm384070085a.51.2025.10.24.06.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 06:21:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vCHjv-00000003hqy-1N7J;
	Fri, 24 Oct 2025 10:21:55 -0300
Date: Fri, 24 Oct 2025 10:21:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org,
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Subject: Re: [PATCH 2/2] liveupdate: kho: allocate metadata directly from the
 buddy allocator
Message-ID: <20251024132155.GA760669@ziepe.ca>
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-3-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015053121.3978358-3-pasha.tatashin@soleen.com>

On Wed, Oct 15, 2025 at 01:31:21AM -0400, Pasha Tatashin wrote:
> -	elm = kzalloc(sz, GFP_KERNEL);
> +	order = get_order(sz);
> +	elm = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
>  	if (!elm)
>  		return ERR_PTR(-ENOMEM);

Please add a function to allocate preservable non-scratch pages then
:\ I don't think we should be sprinkling __get_free_pages() all over
the place.

You can then add a cleanup.h for the new function and so on.

It should allocate frozen pages, accept a size_t and return a void *.

If this issue is only related to kfence then the new function could
have an if IS_ENABLED(KFENCE) and use slab when it is safe.

Jason

