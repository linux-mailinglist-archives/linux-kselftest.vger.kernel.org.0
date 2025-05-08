Return-Path: <linux-kselftest+bounces-32660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24455AAFC55
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 16:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99829E08C9
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 14:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC65C242D65;
	Thu,  8 May 2025 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eXgSkB2N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D3E226D19
	for <linux-kselftest@vger.kernel.org>; Thu,  8 May 2025 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746713067; cv=none; b=JC/3kPy1+EsnPsAaI8Dqbr2i5VRnBdiN4/ZzlsTCH0KdKYSUkEcy1V+uwWEQJFF3R3mDl+CB5sK5l/Qq9Us11FBwiWYc/l0uEMuz915T0KokHGwLrsbYvYtWuQxWxi24E9IERt2pmEa/pmi370zu/MDsGdx6JVZ5hFRtc4Bfdk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746713067; c=relaxed/simple;
	bh=RbK/9v+ee2pYpO2N9wpE0C8ABX7e2vw/PINumgYZ1XE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J5EJwb6vMSoFIxdUx9+cInW8dDiCZM8qQZQkn73PMsVKrQZXmDQFkF/u/XTJORfN78KWnpD7AS3XIAZdg3PYofyLMtFM0ps9W6ZvFjxU3Duq6FN/FXEEWGZiArKrrwt8g2DiVSbsb/OCOJMbVUs7lClhqWVbz+F2LG+vjdJyo4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eXgSkB2N; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30ad9303655so1716773a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 08 May 2025 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746713065; x=1747317865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V2tf3xEZy1dGL+3t3eFy4J00XNnFfVlwiE6sUM4MGp4=;
        b=eXgSkB2N7iJ0p3fztNgeCYvb2nWZq+W0DWu9tB3u8Wxo8sDcEzXdq4rtYbFa4D47hK
         XjYPu/ikWw4fyudax7CLUQ8gf5KYeeSpmTIZu3Dg26xAFQQVLi8eWzSfIeWQIcKCK2Qf
         8d6pjTy7z1DgldpI6ZEQ1udKyAEpHP8/qitsnM2nZajHG/KrEWg034fLheTnpQqrO/Uh
         aFvThM6gY7UQbuht/FJjHG+Nvuz2c9R68XkCihVCWoCI/mq63GYiBHhvaZLf+5ccX1mV
         h1n+9WLIfbdoeCwntY0r7sOevEuD1oKnlswD/NKebnlidHYmJWW29NDQfIr48nPf0pGO
         SblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746713065; x=1747317865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2tf3xEZy1dGL+3t3eFy4J00XNnFfVlwiE6sUM4MGp4=;
        b=CjQ1opl0KHqpzMck7GY6LurgjKXNpF2oRXZ7MoTwT/h5VnOLH4GLaEB/1zALuV44dc
         oihaJK8aAeONo3c+jZ3Kw33C+d0M+D/cvuEXDt+rLdZJPScNCCBZ2qY2//g96svMiev/
         /xzKEYHR4o/PBgVndm9lFmm5vTPisy4w3UNlL+owoYizt2RMmcB4Si1PWMqTjSwkZZmr
         TXG6ol4kbu8L443UP7UaHkTj+7EPHbUFgdH1joyJRaQCt4/i4xoDVvjOV3AGe/6R3Gln
         QOihfOlsijYkjjoUGHCMuaVqZblSHNtwav1qvv8DJRu0AIhghwUpcrh4EcVcaJQjWZD1
         LpSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXmnN60+rQzfQ53ERqb0/FSGUyXF9Bib2tNSrZGDoA5tV5MYXF1gr4LEbAyb7GeJe08xa9HYgogNr/MUKYNE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCw0TarStNGUySq/xtv5K6Wo6R9Jz12yL5tQXyBNeepGt64J6m
	GkTLesOonfsuXvpVKMTJ9hYtq7iqui12Tw9JVO8D166o4gvZKMPp5Ro/r3F+B7HKWxkpFoyemxh
	3mQ==
X-Google-Smtp-Source: AGHT+IHihdEq9WLfghzMNio7YGXsAlKJr+fbU3ATJJQrX+sg9sIwzP998JJJm0pKRjkHt2JyM4XtawG+d/Q=
X-Received: from pjbpb5.prod.google.com ([2002:a17:90b:3c05:b0:30a:8ffa:9154])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e08:b0:2fe:a515:4a98
 with SMTP id 98e67ed59e1d1-30aac2bb314mr10385069a91.31.1746713065404; Thu, 08
 May 2025 07:04:25 -0700 (PDT)
Date: Thu, 8 May 2025 07:04:23 -0700
In-Reply-To: <e87bbc68-0403-4d67-ae2d-64065e36a011@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <6dd57f0e-34b4-4456-854b-a8abdba9163b@nvidia.com> <e0b9d4ad-0d47-499a-9ec8-7307b67cae5c@linuxfoundation.org>
 <3687348f-7ee0-4fe1-a953-d5a2edd02ce8@nvidia.com> <e87bbc68-0403-4d67-ae2d-64065e36a011@linuxfoundation.org>
Message-ID: <aBy5503w_GuNTu9B@google.com>
Subject: Re: The "make headers" requirement, revisited: [PATCH v3 3/3]
 selftests: pidfd: add tests for PIDFD_SELF_*
From: Sean Christopherson <seanjc@google.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>, 
	Christian Brauner <christian@brauner.io>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 07, 2025, Shuah Khan wrote:
> The issues Peter is seeing regarding KHDR_INCLUDES in the following
> tests can be easily fixed by simply changing the test Makefile. These
> aren't framework related.
> 
> kvm/Makefile.kvm:    -I ../rseq -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES)

...

> You can make the change to remove the reference to KHDR_INCLUDES.
> If don't have the time/bandwidth to do it, I will take care of it.

Please don't remove the KHDR_INCLUDES usage in KVM's selftests, KVM routinely
adds tests for new uAPI.  Having to manually install headers is annoying, but
IMO it's the least awful solution we have.

