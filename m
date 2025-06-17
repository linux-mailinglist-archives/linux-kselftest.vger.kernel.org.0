Return-Path: <linux-kselftest+bounces-35221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A099ADDA8C
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 19:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7653BF9D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 17:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169C428504F;
	Tue, 17 Jun 2025 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3OG3ntj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D2A2FA632
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750180963; cv=none; b=GvKP488otGNUSYAgrRKzn1hwz6rrRbZcvembuq2Metgd+NVoDrloztGkDF1gkq8KZKiCuN4+pNQlD8ncJ//Y4QQUtrrlbpiaXrfbChmWs53BmZlcUY2qRmkiM8HbbNakNkHmwsoffp6UgGB/ZC8KDo34eRT1oTkKXDejMThh61I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750180963; c=relaxed/simple;
	bh=fkSOfdAa8FY7s1fiIR9x8hwRIn5eu9HjdWI0CIobf48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2/A8CFcA0BW/iIIVaOQKS2ZdIK40D5oqggco3woU+ZcLqxUN29WW+YewBMgmV4K2o1sfFFM9IRkSIDVLzfRAQuDwH/X/KlBWouWSXhaGKaWqwgTb+CSCJOlBWPAr3feJxTpDu73grr2ItTSrOjsc6jkQjjEifTGzCHMMYkxGlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h3OG3ntj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750180959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=34DKIigEpcgfa4tv94Inm/gSRCZZNbs35BdPm5ILfHc=;
	b=h3OG3ntjL0Min7R6XomFqByaPlb76RuMxrt7RreqVQQQL6Pu9YOmibUfNk7I0ggb9yYv82
	wsYgVPR22y0/si14hHNL742aOUi7AYj3fcUmFfgyWe+AMLf3vwuY9H0jvR/gbYtRT0YNSz
	V+bPOFZLbExy3VOt2ll6ZLv1d+CMwCQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-uXSjoH1JO9WjCbBsS6Y_Pg-1; Tue, 17 Jun 2025 13:22:37 -0400
X-MC-Unique: uXSjoH1JO9WjCbBsS6Y_Pg-1
X-Mimecast-MFC-AGG-ID: uXSjoH1JO9WjCbBsS6Y_Pg_1750180957
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7425efba1a3so4911541b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 10:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750180957; x=1750785757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DKIigEpcgfa4tv94Inm/gSRCZZNbs35BdPm5ILfHc=;
        b=mHnnld6WH6ZgaR9X7H/eDSNFsanhWfSrV84ZUcZJL7s1nkPFeRQ9omykZyK9W+Xjb7
         bKHzEzH9YKBa1AIPXVonK5Yy59RWOS5M9OIH2pqzWT5AUmUh3iEwUBfMgpQ1n5grcdlY
         lCHMVwiZo44v749v+tM+Udtmo3Ftjl7/xWXudaaZGyIDyi/gNRYjZYV0J1eDTGB/1lxJ
         k3Rer8MYK2AThK9u+guSEprQTRXcNwzLkeu+QkauPMQCMj2if3AXYKSC7mw9SKu9XGlD
         wvSvpqDSF/dqpEbDqITVbO55KDzLifExOO4f9WCGQEQN4iZGwduIwrx30lRXz0Hplulh
         4xmg==
X-Forwarded-Encrypted: i=1; AJvYcCWpY9YXbt//i5ZAwI+9dQl5iExzADVcB+oqaYRQ+LCYGEvHBlFTNKe03eHQyNwpSZvLA7aC2+YkDdn6ziVhXVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIsEL9priexwjjs1xub8rdbUsnudoS4GZ9SKZEB7zr5A/9/KAb
	HMURv2eT/nyUnVnVavAPi9q3lRJlEOVN2WhExAB/EcQLiLSJHO2EXExMKIQ3H3XkAaOFQflGO4a
	GSicgt7PRz+QCFa+NDhKISb2/A4qRDTxEn0aQJb3ZP8QpDNsDvrDXoncsznNcPfRpnnhuZg==
X-Gm-Gg: ASbGncvdx/evncY5p2kk/8g0YczUNasmtBGla8n9psp0NYJyMkv+w2KVk8VQOvkjGbq
	eI8zLkvFX5G0TRRkS/txGr0a8KWPOW7Pf1aHlJ5Z4hiShsh8nSYjXyd3AvFffWr1d8W1jxrmHuG
	v61PGW7b2b6gHiLr22FrZKIpnCgjoMFVxHdCTeHPg0PxnDsbLUVGHHnrKkmGaFkG6nTE/AFm4Kh
	95VWoHHA9IB7bDNbLO1TITomAYirgzKDFpmQ5UIBwYpNLBTiZPnb4+57BpdjxCl0oWwl3zrEpp1
	JSN+DAwI/uzIwA==
X-Received: by 2002:a05:6a00:b8b:b0:748:6a12:1b47 with SMTP id d2e1a72fcca58-7489c47e470mr18490190b3a.10.1750180956724;
        Tue, 17 Jun 2025 10:22:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM6/AhfqpvtyHQaLreUDoYWYWZc8npPOOqClxjD7RFi7IF9gRDq4KeeMPXcwtHEi9K0833AA==
X-Received: by 2002:a05:6a00:b8b:b0:748:6a12:1b47 with SMTP id d2e1a72fcca58-7489c47e470mr18490157b3a.10.1750180956304;
        Tue, 17 Jun 2025 10:22:36 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890083bb2sm9450419b3a.94.2025.06.17.10.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 10:22:35 -0700 (PDT)
Date: Tue, 17 Jun 2025 13:22:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ujwal Kundur <ujwal.kundur@gmail.com>, shuah@kernel.org,
	jackmanb@google.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
Message-ID: <aFGkVh-rs2ZqcL6g@x1.local>
References: <20250501163827.2598-1-ujwal.kundur@gmail.com>
 <20250616100406.2853-1-ujwal.kundur@gmail.com>
 <20250616172618.0609127a8b1e406d4c228d24@linux-foundation.org>
 <aFGPVPDKGLOIEucg@x1.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aFGPVPDKGLOIEucg@x1.local>

On Tue, Jun 17, 2025 at 11:52:52AM -0400, Peter Xu wrote:
> On Mon, Jun 16, 2025 at 05:26:18PM -0700, Andrew Morton wrote:
> > On Mon, 16 Jun 2025 15:34:06 +0530 Ujwal Kundur <ujwal.kundur@gmail.com> wrote:
> > 
> > > Refactor macros and non-composite global variable definitions into a
> > > struct that is defined at the start of a test and is passed around
> > > instead of relying on global vars.
> > 
> > Well I guess that's nicer.
> > 
> > >  5 files changed, 616 insertions(+), 542 deletions(-)
> > 
> > It needs to be!
> > 
> > Thanks, I'll queue it for testing while Peter thinks about it :)
> 
> I didn't pay much attention on this one as I saw Brandan was actively
> reviewing it, which was great.
> 
> This is definitely an improvement to the test.  Thanks both!

I did give it a quick run today, but I found I hit this:

$ ./uffd-unit-tests
Testing UFFDIO_API (with syscall)... done
Testing UFFDIO_API (with /dev/userfaultfd)... done
Testing register-ioctls on anon... done
ERROR: munmap (errno=22, @uffd-common.c:277)

IIUC it's because after moving most globals to stack, they are not properly
zero-initialized anymore. In this case it failed at MEM_ANON of
register-ioctls test, trying to munmap() some address that will start to be
random garbage since it's on the stack.  So maybe we at least need
something like this?

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index bed96f41c578..0b66ca3e7b82 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -1744,7 +1744,7 @@ int main(int argc, char *argv[])
                        mem_type = &mem_types[j];
 
                        /* Initialize global test options */
-                       uffd_global_test_opts_t gopts;
+                       uffd_global_test_opts_t gopts = { 0 };
 
                        gopts.map_shared = mem_type->shared;
                        uffd_test_ops = mem_type->mem_ops;

Even with that, it fails somewhere later.

Ujwal, can you reproduce these issues and have a look?

Thanks,

-- 
Peter Xu


