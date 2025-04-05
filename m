Return-Path: <linux-kselftest+bounces-30157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C090A7C87F
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Apr 2025 11:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7A2188F9AE
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Apr 2025 09:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4878B1D9A50;
	Sat,  5 Apr 2025 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0fqSA6s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80EB1C861A;
	Sat,  5 Apr 2025 09:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743845099; cv=none; b=o/Z/iwMBtI6y0+feY22eaEwP8yPqnaG0BmbUux0Tpui8nh8KAr8nUw8ZlgutV6GonbZwCAS3NZEYH2WmnP8llinl4b/icuPCzCT4uCqWzhG7vQGKGCd/VR/0J8womtSLXh3uzkitB5XnSLC+3ywfE2RpIt7og1KKylnijfeLsCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743845099; c=relaxed/simple;
	bh=CYC+j8DE1LKhEPIIAtWsmhv3JgdGMKg+YUwLj9onV54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9Mn2XeqzU7iwFz3dATtqVw1GjDCkj+/bHX/ZxvXywWuAz6kgTQLpfWUu+Jsl+fp1sUvVzDJIJ88YNz2buhRB/Qf/MDZkShy5LUvL43P91h07D2vec46wIkJ6sDKUAEmuU3dgDvtJQcVRMAXbRyc9htxof1UN+z6HTp+9NP5H6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0fqSA6s; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7399838db7fso2562106b3a.0;
        Sat, 05 Apr 2025 02:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743845097; x=1744449897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dEK0W0QpAa1ZezYhp/Ge5p3VJ+97NZtwm+z2v9PIHNw=;
        b=I0fqSA6sQj/0zzw30vfPDTIc2k4qiKmNNjjulS5lwaBtXAQnnpWUlORXP1SXp3ZDsO
         wotSjHUGfgn8Y4Jl7RHh4m2nPqxrglhB9uXCdVPf9JUhKs6+9HMge9VoIaWTidYQE0Uv
         qXwpGHheTNhhG4WJDDoUUo9Z5oSsOpROGxeGgV6SnnnQpex28dOx/gwcNty3ERptjMYC
         lKkMc323bkjMALVwI1zqHOIkc3/b+PNvMzn/71BaQoAP6IbKn6+bi/zjsDsfP+62Famy
         vFTWq+V0wSxP2n3Nq4FA4XvKodzhYUB8V8s/hPEXtKbp5yJ65FeHHhMbckh6s8DAI3a8
         C3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743845097; x=1744449897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEK0W0QpAa1ZezYhp/Ge5p3VJ+97NZtwm+z2v9PIHNw=;
        b=d9KMjNfSeJCXsGLuw8HbINSbQMtmYnfPQvok1wmPUtm/aYZ5VyTcLLvnPnBBwyAQBb
         zulxaexJhQ1rOdbSSoWKctJnV9SLo9unAAc+rOgoBHLz5x4aNU6MhlEIfSrvWwm9CY+9
         ssKneTAq56r0LzrbrM6wnCs+ND4ut8DwWHzs/yMjFiikTbKXC+846ufovLWnrX7H7U2E
         Tqzv193U5jMAqd+dceJ0doONsTEwI6AmhSVUVXjuE5txl21UwZUdsCUugZGjP46yQubB
         usH6tmfK98pc7kjAYuAep7lEay5+wX1+eiVcy8gtDPnj/Jz8AVv98iAUVgMQbjVUXZaw
         VwyA==
X-Forwarded-Encrypted: i=1; AJvYcCUy/h47WIg/i5XCwrI3KDNp7IyYszm0mWTS11zk1h7MxBT3iESpZ3qrIKYcIFC2aKNQRZYmdqQHkiMXgyViRGex@vger.kernel.org, AJvYcCVde5KqDiNwsTL+YAHNU307Ug+C0zEDKeGenXxWW47622aEuP+ElGuMwjxwpkIPiKXZHtBoXvfmQO8ro5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQlCfLnhEtJ05U0CMKDUiSyDj4kojUCU3AmC1m5XB6c7tTtXvg
	M3n1mGThn0jU0w9xXnDY5pJfCAqUYmDf8qOWFD7Gtu9G1CrQ49yo
X-Gm-Gg: ASbGncvadCrwTditiZ99JQvVq7LBSYGIGDxTlbCHSmGFnq3wcQMXEnDj0BpiXTfKrA9
	drG7VYvfrHNEgCVncpV9PPzgwapE1KTI8NPNvhKl/nB4PBPRNtQ2T+M93ncjOVhXomNBhQ6FtB+
	OlqFBAqBGhEQzu1ZcWsokvTaulV/GqwC+30c0uj1FYpuJh5jPAJtDovAmdprIOoEwhe4NbMwJoY
	8jO7APYgNsI1Lfx7558cz3Kga/8sNSrKtVmHXM/W8m1/Q3KXZcsRNzUdpj957eX/EX27AZUuc0w
	CPqJg2IyhIb3yMO/K+Xe4gyylKAQj7fa3G7cBlnZ85mWhkaUxBPXsU1KsGW13Q==
X-Google-Smtp-Source: AGHT+IHSH7e84O9pcdFgnOtCs0i95OtpNIn1swFj4yYiGDsyPfoRCp6D/9QBy7kZxrLD01zIqjbo+A==
X-Received: by 2002:a05:6a00:c92:b0:736:4d05:2e35 with SMTP id d2e1a72fcca58-739e590a313mr8719587b3a.3.1743845096937;
        Sat, 05 Apr 2025 02:24:56 -0700 (PDT)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:fb4b:850a:b504:c8c8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97effb7sm5017104b3a.60.2025.04.05.02.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 02:24:56 -0700 (PDT)
Date: Sat, 5 Apr 2025 17:24:52 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: akpm@linux-foundation.org
Cc: shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] selftests/mm: Add missing gitignore file
Message-ID: <Z_D25JBTUcZia2GW@vaxr-BM6660-BM6360>
References: <20250405091913.520889-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405091913.520889-1-richard120310@gmail.com>

On Sat, Apr 05, 2025 at 05:19:13PM +0800, I Hsin Cheng wrote:
> Add "guard-pages" binary file into .gitignore.
> 
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> ---
>  tools/testing/selftests/mm/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index c5241b193db8..c9fd69ece95c 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -58,3 +58,4 @@ hugetlb_dio
>  pkey_sighandler_tests_32
>  pkey_sighandler_tests_64
>  guard-regions
> +guard-pages
> -- 
> 2.43.0
>

Sorry, please ignore this. I overlook it's being renamed to
"guard-regions".

Best regards,
I Hsin Cheng

