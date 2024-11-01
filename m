Return-Path: <linux-kselftest+bounces-21298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5229B9270
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 14:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BCFC281266
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 13:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B650B175D2D;
	Fri,  1 Nov 2024 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JndgZ3c6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EE519CC2D
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Nov 2024 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468907; cv=none; b=J4Vv1Kp6ft96vHnnLp3p16RziSBkyppU2+RHuX+zVVYbh7ZHO5edIhSqtA16wJ2hkAHcu2NCqbLrdg9O0tD7ARxydUCVj0o3WQHC8PyKFFWH7qpzxQi7qf8zorNnG1DaqedDnpzx1yhhbjTlaKOZ0gQviX7wSqYAgSCIC+A/Ado=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468907; c=relaxed/simple;
	bh=s7R+wdV0+mmYmY9C610nIqKazjHMd4Jtw3jsp9IV9FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alGTe2TiFI0CnmuZzvmCKquKxa/Ut5Lu4rDb61wlHwi3s98ktut6eBOgLz3fWh+dMkzSN61ZS5ASfGyV83Rq97CH9UuubFPiRngmlFYhh9DNhiEbjfLyfZLx1g/b8lbRHOs3TxHM7nJm+m3r6DJ+HU1a8VE9vOlfLZqQkYuVYLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JndgZ3c6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730468904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F5YDS2IxgbCyYVyHmTnSV22QiC1yW1f4+0Ftmvdu5UQ=;
	b=JndgZ3c6yZiyh7npYH4QP2rTT2NCqlFBSfywvQqFfOK8RtkhadnC0kfzFniKla4pwinqtk
	e5KW03Scr8t+ZcS5N8G7pfBcyErrufv+bzvfrxORxc9qaw6IHXLQnpBzbfnPD6qUkAn6k5
	meJAgd3DYAHrYJGGM0IZcPs0tI+gn50=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-WYRCULxePMuRfkKJHXjwBg-1; Fri, 01 Nov 2024 09:48:23 -0400
X-MC-Unique: WYRCULxePMuRfkKJHXjwBg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cbd12b8b60so69310186d6.0
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Nov 2024 06:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730468902; x=1731073702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5YDS2IxgbCyYVyHmTnSV22QiC1yW1f4+0Ftmvdu5UQ=;
        b=eJDds/YCRtZQQoZEVZtHgK/3MnUfXuvsCrP5nKGBAgMFe7/WLsVJHASQBV7ibTRHZI
         U4rjTbLZqK0R3Go5cy6Xu5m0e8lwh4sTw41UdjJsl3U1FVfq/9vbRChYjCUjFRj7mRG3
         GEWRA/LdsJC/BptRGJtJqq3bh2wrBJRF4qxSwb3vxZLtHf6Xy0SbQHoblUhlJ/BZGBFA
         i9YbAQHoxG1OvJshBorckrwzud1dtmvQiBTKZEW87wqdc9z+Zjm9jdyFXY6ERfw4TF6g
         7OV8czttADqrWnjf5LNPbcXoEvowYAEv+EMFPo+y2rFRA7Gm61ZouoFe4xntz2kUidqs
         tYOw==
X-Forwarded-Encrypted: i=1; AJvYcCU+vcT4qxoSgbQz2MSz5nbf2m67AJM8WOw/z4EgF/kdBKafTu8OK+99x/Q77gZ0eiBaMypfXKplNtl/aZUOQa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9pBdU0bl72MKk7T2aMS+r2QBFwi9HXaq+AJAOGtKIW5Sw9L0n
	2y0ZsQnLfIU0orfwNJ3cCqcaXkCK6lwatvMlTWOC+qyemjzBESGA9GdvOamy24TTe39eapLtiPR
	aIOWTH54Qi7yw+lUtGt8kcU18xhPhEiLMbP9QPevBC3pXdzgN+xCS5O+voChNX5R8HQ==
X-Received: by 2002:a05:6214:3f88:b0:6ce:23c0:b5d3 with SMTP id 6a1803df08f44-6d354304791mr99767046d6.19.1730468902562;
        Fri, 01 Nov 2024 06:48:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbSckCZXlW9k8OKL6LD/JMrWFH2jo6zfSiWlytLvy9/1m4eOCAP+JBhW4y4WuHqZXBK6W5Ww==
X-Received: by 2002:a05:6214:3f88:b0:6ce:23c0:b5d3 with SMTP id 6a1803df08f44-6d354304791mr99766656d6.19.1730468902229;
        Fri, 01 Nov 2024 06:48:22 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353f9edfdsm19373306d6.6.2024.11.01.06.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:48:21 -0700 (PDT)
Date: Fri, 1 Nov 2024 09:48:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Mirsad Todorovac <mtodorovac69@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v1 2/2] selftests/mm: fix coccinelle WARNING recommending
 the use of ARRAY_SIZE()
Message-ID: <ZyTcJHUXWWaTIA7O@x1n>
References: <20241101111523.1293193-2-mtodorovac69@gmail.com>
 <20241101111523.1293193-4-mtodorovac69@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101111523.1293193-4-mtodorovac69@gmail.com>

On Fri, Nov 01, 2024 at 12:15:25PM +0100, Mirsad Todorovac wrote:
> Coccinelle gives WARNING recommending the use of ARRAY_SIZE() macro definition
> to improve the code readability:
> 
> ./tools/testing/selftests/mm/uffd-unit-tests.c:1484:32-33: WARNING: Use ARRAY_SIZE
> ./tools/testing/selftests/mm/uffd-unit-tests.c:1485:30-31: WARNING: Use ARRAY_SIZE
> 
> Fixes: 16a45b57cbf2 ("selftests/mm: add framework for uffd-unit-test")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


