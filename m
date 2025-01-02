Return-Path: <linux-kselftest+bounces-23834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B77AA00131
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 23:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F783A2357
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 22:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED2E1BD000;
	Thu,  2 Jan 2025 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoopmKfw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA9F1BCA1C;
	Thu,  2 Jan 2025 22:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735857057; cv=none; b=pbQWlMqg0FoqyyoyiPh58PY9SzVPKomjtfOM59+OLP6g4WuT/aUtRLNtVJ53lgbCEu/zforOcE+XWWR5bp+DE1axA6Cu8Wk4guRSI+n2YDJYJyoFR6feqtLbhdbnqV33GVxHCeEyOYl5PiBWpL1WmHbZ3I/FOSkEEjmSAbIuLv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735857057; c=relaxed/simple;
	bh=knH3x8yBz11NMkT/X48OqIJAi2mjgYRl1KyTLT6ooO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2ICcI+fWurodRiwOUMDglZUdJvbWbVpXv6BMv6heR6hGKllQqmZSaAoBVBDVQjfTqagbrlADMHoehKj70IhhNEsdGr4AC7y9/ntMJFrYSxoPLyI1JWr6xwx1o9ftvC80EqYii9t+8lRUXug3MiaN/S0C/it1c1hthMptQiF09g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoopmKfw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21683192bf9so161405715ad.3;
        Thu, 02 Jan 2025 14:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735857055; x=1736461855; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GgvqTEGZlDWFBkSHH+Qh2GLJWXsZlbhoi9i1eLoV0B8=;
        b=eoopmKfweqY5V31oNLAmPBUd4SD68CI5Jf+3TXy8YflWdB2EEv89u3Yi7kitTo+3fw
         TXBgCX/ciPc/8GbbwMVZBzOj4qp8U6bZWxF1SITmJsn2MboaLZ2/0feqBZvvciLsg6pG
         qX7IkbYLqihgCSZiT50z3iaOqxFQZHRRx550qzlx1sNDIgJDBPpZ10e+22sRRJun5FO9
         T5ZmvUt//piB5LKA+35IA/Ody5eBqkMshtyHddEh2ZBZCjrJ5QdyaCNlVHMLRfEIqHI5
         sE161XQ8aIpzWsRDh03W9gU7pk5tP91EfRE6tgT8uAb7mKypIQcm6uhzNvLhvbj0UsP9
         ZKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735857055; x=1736461855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GgvqTEGZlDWFBkSHH+Qh2GLJWXsZlbhoi9i1eLoV0B8=;
        b=dzqTX1kPYQZkDduM9h4wa63yIs2w2qOaiH/Lqvo/p8B9dn03q9GtLcQVmk7MRJiIcx
         snJglnmnzHMoRYQMNGICU8tpggUhdr6GwoMOQu0kL6ex7E25kNGDEK/q+G/W301XPUgS
         02ISiCqrBep/61Nu7oQJq9gFpUTAeybi79EPzhP3oo29gq3qCf/vnaQKPbPWlZ0I+DsZ
         Z+UCFC8loEUK/V+ntykB91bMAIVmghfk6RRHCSX7Zfyt4IrQFrOLyAqzLSLeUC1yDl2M
         A8hFwwFPN13ARZPfkyVi3o5PoGcY20lUQwVoUY8eLHUBWSNI3qkf2OeZXSgaFLEaVIAv
         VjPA==
X-Forwarded-Encrypted: i=1; AJvYcCU3C2pPQ+mdnObLfBrTeYRHIt0Wq4+eEXb23zZXZ0Xtf0i6sp0a1uEopvRaFSX1a9LiQnb61dD5VkbRnJQxyBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp8oHabAHy2iLWhGlwmFJOSWiHw+mmExczcfT41oKdmqboXQA+
	Pbheip4At+ZNHBMFTjuJ0IC+ampQpn2yOx4MQmipZk84OyVIE8g=
X-Gm-Gg: ASbGncvL65ZlBrrXR7o7oKHxg+vqVxAP4oCPs2QWtSG5OKsrSs9eFgVW+IpeYGD3RXz
	e/zbeAwBG8ItDVFq1owb2rYXKVSFc97D5tdGXSdnMzkXUxQZ8gMetIHN39MlcR7ESswdFg3+YNj
	kkrWfR5y50kvETSDBbXJ1lCNpKY3if0RdjK+VmLsiYNQw4ExeGaPLg8Ikw9m61tfQ4BjXRy+tZN
	AWi2VL3skAvMdnZ9wYFwJRmRQvhKCmOQLdWtp8msGakl2eRhqOlraj7
X-Google-Smtp-Source: AGHT+IFA6psalCdH9hEvWe8JHoLwtOZXcHQWZL7qgrDBlWVOqh3DdbdnUlbzws6oBhmZZT1FbCt+Qg==
X-Received: by 2002:a17:903:244b:b0:216:34e5:6e49 with SMTP id d9443c01a7336-219e70dd211mr627952155ad.57.1735857055452;
        Thu, 02 Jan 2025 14:30:55 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cde19sm233558745ad.167.2025.01.02.14.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 14:30:54 -0800 (PST)
Date: Thu, 2 Jan 2025 14:30:54 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kselftest@vger.kernel.org
Subject: Re: Question about test_xsk.sh
Message-ID: <Z3cTnjss5soyUobX@mini-arch>
References: <e3d0bd36-c074-4cda-b6e1-5f873453ad30@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3d0bd36-c074-4cda-b6e1-5f873453ad30@bootlin.com>

On 12/20, Alexis Lothoré wrote:
> Hello all,
> 
> I was looking  at other test candidates for conversion to bpf test_progs
> framework (to increase automatic testing scope) and found test_xsk.sh, which
> does not seem to have coverage yet in test_progs. This test validates the AF_XDP
> socket behavior with different XDP modes (SKB, DRV, zero copy) and socket
> configuration (normal, busy polling).
> 
> The testing program looks pretty big, considering all files involved
> (test_xsk.sh, xskxceiver.c, xsk.c, the different XDP programs) and the matrix of
> tests it runs. So before really diving into it, I would like to ask:
> - is it indeed a good/relevant target for integration in test_progs (all tests
> look like functional tests, so I guess it is) ?
> - if so, is there anyone already working on this ?
> - multiple commits on xskxceiver.c hint that the program is also used for
> testing on real hardware, could someone confirm that it is still the case
> (similar need has been seen with test_xdp_features.sh for example) ? If so, it
> means that the current form must be preserved, and it would be an additional
> integration into test_progs rather a conversion (then most of the code should be
> shared between the non-test_progs and the test_progs version)

Since no one came back to you, here is my attempt to answer.. It is a
good target but it is indeed a good idea to preserve the ability to
run it outside of test_progs framework. Maybe we can eventually run
it with the real hw (in loopback mode) from
tools/testing/selftests/rivers/net/hw. And I don't think anybody
is working on integrating it into test_progs. But Magnus/Maciej should
have more context...

