Return-Path: <linux-kselftest+bounces-45776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A957C65FFB
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 20:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1772D4E938E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 19:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DB2333437;
	Mon, 17 Nov 2025 19:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCFSJUVS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="geEMxhT6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F63331234
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 19:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763408361; cv=none; b=aKWKrK7iryJiAitHeHcij15VINShjB23ZA+7wSLixVIsacD8FAC9RhtIgYGE1IZQ1J/PWe5pV1PvLBnaI4uSMy8La+8xkKlwQ56fZePZ38HoVyq7brNga3xOQZMnLjAT7jeYIfzqSpyhhu6ndp89WPWVvxfum1PHVhbRPmDdB3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763408361; c=relaxed/simple;
	bh=29tvvpCD+qGhy6fyzBHvXQq3vnNQo5h2KbSk1H50wjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ny5hujc3EF60uVu06IAenVw+j3cejgTZI8vojZv1hsakQTmA+fMG6mYsYMMhfcD6nAOp4f6CANH6+b+wPJXU7S/GjTXihDEIy3TNiz6H2Fu0b5PC8fWmWGzuZkanAFtJAFNIjBMY48he4nSp0NocGoOS4jqSIdbM2IBAUPLQcwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZCFSJUVS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=geEMxhT6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763408358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K36xwmi8QzbZYxYPWk/InVL39QSCuciwcJPm/PdZki0=;
	b=ZCFSJUVSbyJXAwvpQbj2ICnDq67ZLKaOZAo7XSuEyClw0JS8M1YXfCSq455RUUWX/eym1x
	n0bd6bu3OUhs8rKM2+xoDThSq31zQfkfv2iN5oFQ7ENSjin1nH8VVJv92OmWheXYDRwmeV
	ralRcpSTxanDyjyKeOSE0/ZswoyuxVE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-k_JuVb1pO0mALKO1nDEbsw-1; Mon, 17 Nov 2025 14:39:11 -0500
X-MC-Unique: k_JuVb1pO0mALKO1nDEbsw-1
X-Mimecast-MFC-AGG-ID: k_JuVb1pO0mALKO1nDEbsw_1763408351
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-880501dcc67so160309706d6.3
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 11:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763408351; x=1764013151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K36xwmi8QzbZYxYPWk/InVL39QSCuciwcJPm/PdZki0=;
        b=geEMxhT6OC9PKaHjaYOkGjoxff60Ds5axjcfCP5UxrqV/LYE60W8sffaN3UKg0mRWZ
         mB7a4hNuIdAenpAvNxobzQ0/fo7qabyj8K73rHE2xwK4vDz+rq1ri67wV81EYSyca40v
         RmKMKKp+c/rhK4tUuA4qIPTGcAwv2oueXK/cGCujbsY3vjWrRUBR0tyvBPn+YBPFoWrH
         dfQ4DVsHcGp9X0/hQ0OZT4SJ0DRBmwURbdPQEFnUuef1ldAU+9wLRDyF71rr7k3zbTla
         Zbi4HApC5h8+whMNHHQSR8qbrTvJWPiRYAIuFjP2GTtLgpOVWmh3/kdcoA/fMOZ+s5Ph
         gZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763408351; x=1764013151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K36xwmi8QzbZYxYPWk/InVL39QSCuciwcJPm/PdZki0=;
        b=s6tg9mEEef1QicL7RzDwHkl5eVaWOzB9+E3WUk3f10P7A16bhCzWzNeP+GIq1HnT6m
         KJBA+yBFI5gXRzS920exzwsCvsYOMT7GkPb38VO368ZcCNSq0k73DMKMCGAsSmOP8aWf
         4pfDnOIA+y5hjjYJy3OXFhc4A4fYBr1XzGssJ02JjbxrahqxmRJAq73c0xu9O79Rimt3
         UA/FU7Sceujr+02m+mO9wE90LM/HNek1v+oaqRPy0seytZKpdYTDo5axt0psKY7+6Xmm
         IBk+A4wm+1nCWxa9y90xYKXcpGS1mSesBPnoOV0oh1c0v17GB81Obz/qS7mOg+t191u3
         nC3A==
X-Forwarded-Encrypted: i=1; AJvYcCX/RahxLKbZus091irBlPljxr5h5Z0JPg5rTEKt5Hc8PLA4/XLaRmOIl4JSz6Vbun3d5KSoRs/GR7mMcs+W+Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeFzXmeMUvp1MjQ+qbJ33wJcXuhHmgzsLt+C7e8L94Ova8k3Bs
	H8oN2l/XeS9igaGR3Q7ovq6Xa1SAE5ZOzSK0EAnbM6BGWyv+30wcKCuCqswJ7iaMqJBglIgv3T8
	1R6/e4V9jcRKf+Mqyoqirmhia/TN2XDoRWwQxAKBi7EEYhrw45LQnOjFMsMur9+zmIC1fdg==
X-Gm-Gg: ASbGnctqAOtvvENZOjTaiddFIbGmvGhbFag9SRIlZBvQ1zXP3FQvoTG+peuBSzoE+sC
	KVr/vYqgMEANBIJgimDLOTnyFzkc1l1joIKqo0eUnXQLi2+TDeSlQSMUU4Anr+BFs3KijpZPz5p
	6A7oi6ozHf/qhdqSfoVFBTSLbb21W7VmBAOX3U7t9BFPI71XfKhUPA7GADSU0rH49zNa3s1W0xD
	JCtjWOK74j6WI5nY+0O5bODWJu/9UWY+ZFShJI3NCEgrh+LSgvNQKwGLkM6uuHyW8EZTEJ4NYQs
	gc5ofgffx84ZcZXShvlKraAdp/ApKgYC+R/0BNNUFRLt4EVm3oO5zhJztRSD4PD5jNKV33jVoA7
	bhg==
X-Received: by 2002:a05:6214:c28:b0:802:a79d:3132 with SMTP id 6a1803df08f44-8829267c1c6mr192021106d6.47.1763408351060;
        Mon, 17 Nov 2025 11:39:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdehJMTGS035Eb/OzG7cG5rRd+07wCiKuKE4YM34HxqUOjomc6mUNHGC8OLoiF8h+l5gT9Zw==
X-Received: by 2002:a05:6214:c28:b0:802:a79d:3132 with SMTP id 6a1803df08f44-8829267c1c6mr192020686d6.47.1763408350619;
        Mon, 17 Nov 2025 11:39:10 -0800 (PST)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828658ae99sm97099586d6.48.2025.11.17.11.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 11:39:10 -0800 (PST)
Date: Mon, 17 Nov 2025 14:39:06 -0500
From: Peter Xu <peterx@redhat.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] mm, kvm: add guest_memfd support for uffd minor
 faults
Message-ID: <aRt52tDCh72ytIp1@x1.local>
References: <20251117114631.2029447-1-rppt@kernel.org>
 <a5531d06-dd11-402b-a701-a7c6a62186a7@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5531d06-dd11-402b-a701-a7c6a62186a7@amazon.com>

On Mon, Nov 17, 2025 at 05:55:46PM +0000, Nikita Kalyazin wrote:
> In our use case, Firecracker snapshot-restore using UFFD [1], we will use
> UFFD minor/continue to respond to guest_memfd faults in user mappings
> primarily due to VMM accesses that are required for PV (virtio) device
> emulation and also KVM accesses when decoding MMIO operations on x86.

I'm curious if firecracker plans to support live snapshot save.  When with
something like ioctls_supported flags, guest-memfd can declare support for
wr-protect support easily too, and synchronous userfaultfd wr-protect traps
will be an efficient way to do live save.

I'm guessing it's not an immediate demand now or it would have been asked
already supporting both MINOR and WP, but I just want to raise this
question.  Qemu already supports live snapshot save, so it'll always be
good gmem can also support wp at some point, but it can be done later too.

Thanks,

-- 
Peter Xu


