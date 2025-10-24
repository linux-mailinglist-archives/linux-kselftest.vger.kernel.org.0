Return-Path: <linux-kselftest+bounces-43985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4285C06D0A
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 16:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5369E567773
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 14:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B44224A079;
	Fri, 24 Oct 2025 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KXbjyjvi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AD92494ED
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317713; cv=none; b=Q/HGx643rBOfjGykETHj62SiBak8NZFKRo7vib7USUrLqgkL3je0UCuFZmVCAKBVdui0uPL6eCn3hrVoM26iP7AA9Evbst7RyLWtel9bdRT0hIa3YNql711n9xhqsY8KXIlL3pOFIrMeSkY22taJKPE3BwAf1hL3U8+2I/Xunl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317713; c=relaxed/simple;
	bh=Sf64DSZxGyAJLjLTgjCXkLHz+iQIUb694K63qXKPMGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXYZeOWD5yrQKyngktAOAHlijClPtLRkzv8+lWu3c4rU716phvNLCzlbtJJTG+miKqGrtdSeU8OzEwZID2aVEEmtooqIHZKsf62wLfMVjhYlD9ehGGM479S6XyCbCGPUEkIjgiYv1AE1CQRkkiDlqigyybQCozDGMuNPf7vuuEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KXbjyjvi; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-85a4ceb4c3dso210780985a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761317710; x=1761922510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d5NlIoDgDHeWW4rVQCBPgiE2A9f1o4SvVODOB8YPwiI=;
        b=KXbjyjvigc1flnAGcCaXqKXcQWQpNWuLqlvvar8YS7PzUcgW5riFode2BCLV46Fw+I
         4+K7somroT4OgK9Q+f0mgPmI7OYDhQc0sRMgMO6jkCaNmAufpZ5+pYSnU+RxvuDbOKy3
         F+DroUDXO+f9PYtj5kt+VHYmiXlDTtpMU0B0hYg/PV3iACdGVxOCUL54pj9nX04lz5nA
         4pH2yZZbycyDBxcyBOnlm7s9fHzeU3bUBCoWWUU+qBkUoI0AdShWFBjIK/qcIngxQBY8
         dJLF0vBg73gCvhAV9BSnXfxttSVk1QydWoxakH5IoaxfslKzzBGRvA56xYhfD02fwcLi
         TcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317710; x=1761922510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5NlIoDgDHeWW4rVQCBPgiE2A9f1o4SvVODOB8YPwiI=;
        b=Qr2k6yBq0s3C3L3x9dMbyJTIWmPMIShmsQteiB7+gc68w9fdxi/eCiXFdTOeYloh44
         DTG1dDcWEMy0EMzLrWv05erU8mO0fvDd9kriSQXOo9t8T9hzqql3u59cIO0LQJ/tsSfr
         9Bo6H943A1GHd8u0KxQgSTlFnq7SzbHdZSjlKebvxk1IeEeBz11dTCjCvkrZ9kSESHHf
         aP6KUTeXmrYhi4FrNXehqa/SHIW3rQ3sxBHg/YGDgjJW8m1ji2xObN8YYqkndregLcEo
         8S5Xy9CyDIJn30ZMCHZ3RK0y9NL5ubKBl23D6jyVOa+5rhg6zkvEWU8n30OPQhXuEw/F
         LTbw==
X-Forwarded-Encrypted: i=1; AJvYcCWC9D0HVxGCHfP5E8E5lWu5KhOHwwM1e63MXcpvN7Bd7uPD7oODVR2HCvLpzCAbA6QgtE/ctxQ25EYyq3qDrHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Ofi9Ev4tvhzH3YiKvOAyqB722/oyRqfmUypp6V2/H6TTg8wM
	PNhuJjMlIeZt58JeC0qoEw5uGtxZjK1LlDlg3lu9RQ3k/ucgdN6z3Bwk/E9hbdE3LXU=
X-Gm-Gg: ASbGncvtQI5p6P+0+jxWhFMWA1x/jdBwcWspGKMND0RACBgXJZpSiysnZHz3qdAyFG8
	WOLVHFXYiYJdKJq5+tyCtLS0zkQ5U0ftH2t36qL+KTTxj8KWjlD6Dr4EsJOFBfN0Mt3OrYpKaY2
	cL6wf40oPZEoLUQf5Jyk+ZyweBKa5R7lyKk4075kgxcUCUrLuTeGHkRyT4ilWKOlre5dl8s8TJz
	2W+nMQlVRdQTknke/v8pNNC+PbhubFTGbwnQ2DcbJ+SslNUF4/WnZqgFRKJVLy3bFRq9eakPfte
	rzVYLfpwXtyO7/Dvoy9OMFzUFvHINM9IbsKAklzy+YvjNkR8O7yTdQrLHi45QM8EwtYLQk97Bep
	BeKOgbSaAGZk4LLc0g2d1a1cVNNS3yuPrC/q8LCtpWk38xrgLwH7OLSVpgotlGX9E4frT3CvJY9
	bP2Mm5PwiSNgQIYBaSQUiNm10mszDjLSpCmq4wvBjhiyQXcVaqOvbGoTDqWRhQlKHjftE=
X-Google-Smtp-Source: AGHT+IE8bWbSj+1CYY4XBt2q7DKvHPV/vSXNeg3vYjWLWdmaOWjBRdAAspelX2MJNOVxeS8YnHa73Q==
X-Received: by 2002:a05:620a:2986:b0:891:993a:361e with SMTP id af79cd13be357-89dc25ba951mr300274485a.62.1761317709926;
        Fri, 24 Oct 2025 07:55:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89eadc0ab82sm32465685a.53.2025.10.24.07.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:55:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vCJC8-00000003jd8-3fUq;
	Fri, 24 Oct 2025 11:55:08 -0300
Date: Fri, 24 Oct 2025 11:55:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, akpm@linux-foundation.org,
	brauner@kernel.org, corbet@lwn.net, graf@amazon.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, masahiroy@kernel.org, ojeda@kernel.org,
	rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org,
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com,
	glider@google.com, elver@google.com
Subject: Re: [PATCH 2/2] liveupdate: kho: allocate metadata directly from the
 buddy allocator
Message-ID: <20251024145508.GD760669@ziepe.ca>
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-3-pasha.tatashin@soleen.com>
 <mafs0v7kgjoxq.fsf@kernel.org>
 <CA+CK2bCG011xf7v9nGMq4WQAUta9wDt05+W8KmRuc-JE7ZTwqg@mail.gmail.com>
 <20251024132509.GB760669@ziepe.ca>
 <CA+CK2bA_Qb9csWvEQb-zpxgMg7vy+gw9eh0z88QBEdiFdtopMQ@mail.gmail.com>
 <20251024142014.GC760669@ziepe.ca>
 <CA+CK2bAmPN+v7SYsdHA+RL4kFfnoQvKqTqZ2YQ4wdq6dnFkotg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAmPN+v7SYsdHA+RL4kFfnoQvKqTqZ2YQ4wdq6dnFkotg@mail.gmail.com>

On Fri, Oct 24, 2025 at 10:36:45AM -0400, Pasha Tatashin wrote:

> We do not zero memory on kexec/KHO/LU; instead, the next kernel zeroes
> memory on demand during allocation. My point is that the KHO interface
> retrieves a full page in the next kernel, not an individual slab.
> Consequently, a caller might retrieve data that was preserved as a
> slab in the previous kernel, expose that data to the user, and
> unintentionally leak the remaining part of the page as well.

I don't think preventing that is part of the kho threat model..

> 
> > > There's also the inefficiency. The unpreserved parts of that page are
> > > unusable by the new kernel until the preserved object is freed.
> >
> > Thats not how I see slab preservation working. When the slab page
> > is unpreserved all the free space in that page should be immediately
> > available to the sucessor kernel.
> 
> This ties into the same problem. The scenario I'm worried about is:
> 1. A caller preserves one small slab object.
> 2. In the new kernel, the caller retrieves the entire page that
> contains this object.
> 3. The caller uses the data from that slab object without freeing it.

4. When slab restores the page it immediately makes all the free slots
  available on its free list.

> > other patches are small and allocating a whole page is pretty wasteful
> > too.
> 
> If we're going to support this, it would have to be specifically
> engineered as full slab support for KHO preservation, where the
> interface retrieves slab objects directly, not the pages they're on,

Yes

> and I think would require using a special GFP_PRESERVED flag.

Maybe so, I was hoping not..

Jason

