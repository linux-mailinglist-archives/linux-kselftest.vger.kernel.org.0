Return-Path: <linux-kselftest+bounces-41642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4E7B7D712
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D16F87AE5AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 00:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE12A19F137;
	Wed, 17 Sep 2025 00:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fEJ3VkAV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396A81534EC
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 00:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758069350; cv=none; b=mzZuJPI2kn/LfSWDS0clE0oPZereTBYjvMx1Gzki6jakOZM4V5f4qnPqyeVONqo20m5kpgbw3WE5W4Z7RRsZ58+Nu7uu3TwOyJbeUSN4BzsgmKZq+mbFYrqPFroT1B6V8U3c/hKPjRBLu56fU8wJBj0V0lDJNljRaokL6o702lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758069350; c=relaxed/simple;
	bh=L8phg8Yd0a8z0cJtU511m+EDzsT+ImjO6rzk1+SZ1CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETeC1zS0/qpAwOTcftHbF7cTMHyOKnX6zkLfQGOKoN0N+Ytzs0IB3bfxzJUMSSXPp27V9dW+xCC+Db7569uaS4xshsdsL8bqNYFBwAFc1JKcqqbzI07uuyqoBj9DauTLzRgf/KkimrVC72KCR4on9aLpWzYo2EmQzjEQ4RAYsKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fEJ3VkAV; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-b4cb3367d87so4075399a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 17:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758069347; x=1758674147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sbI8L9M4JYXwDBQdPDmo55hFH7biVlrOkrfO/tfqIAg=;
        b=fEJ3VkAV4tAePxhBWANbdMBRIuG6tOVI/78Knllr+QP04AiZJ+nrBDvEp31BasMTyU
         Y+j0VBIwYVDV4CFVR7mFmoxpy0qfc6qZOR0+U07gnS+3AoPOmcNgzHMj/TdV2ED9d1hs
         4i3qthqegoY2NnzksO2tvsoI1Ocz3Ll72oayQx+YJiM1G/Qss+9Uv8INbY2VXEwYt9Dq
         m/spOD8I4JwFaeCKBgp/2nmynufp1WwGqaOhAArMNSR41C8DvZ4WITxgxjcIKrNtqNnD
         4IhOLHs1aA5uvX6I24dLj9McbejwiLLSyBRj3lU3AQkcLc6EhdOeLXTkFq9poEb4oMWX
         HsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758069347; x=1758674147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbI8L9M4JYXwDBQdPDmo55hFH7biVlrOkrfO/tfqIAg=;
        b=AvVaV6oLmC63CoHPc5x44cexsDxszqenJQ7nzgdNfDFpbIHC4pID1goh5liRCvyqhP
         tspSKXCkdDtRHdcJcq3UiXmicWSD2BmFlvF3IGgHxeSCkmNgfeuXMLLGGuTqhHD8YY0L
         IY1s5u9rFlL9BaR+yLKBCLc2V0zhaQjBvrRvJQJn9EdbSjpfNvqGgEaCCTWPirT1NM33
         YmI5U7lPnGr3MeJC/i2W/o9aqP7AqmNrzdm5b7iCGCvgD/AmOaYiah1YjIhUvLt70NrD
         VSUeNAZddJSoHJ3QPTX/JCWJNEXIHfOZf+MtTY+vClk9Er41X5ybRhy9RMrxpIJO8kvH
         TWIA==
X-Forwarded-Encrypted: i=1; AJvYcCVEMhgpfNZ0qTd9OXf6pzi173buMeh84kYA701fycDrZJw9AhutNOZPoiLpwLmBJdm0GjUVyBWtYL4JN5du2s0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw6MqYXetc/lKDL3hxKr7pZUWs2msGMvN0DbBlYZ8fC32DXVWW
	lICjT9vEzjaXx/0KOmuCn60NtZO+1Yy2D84QSNjJuQ2al93ST57rw+KR2RaMyco2U2gnnTqsaev
	IKcxlNr8V1tDcpwmVC/HGmggG315M4UZpQhHYgWjh0fDxJooQtHhb
X-Gm-Gg: ASbGnct4y1RjXs7rbDPAZg2uFBFdy5OWstGUuWGNo7Ip3pJq0luyO+sedDFcSEyFSmK
	v9tj1vcGz/J9R7U1nJGcLgD25G5ZqwLNPlgIm2QjSfoUD6o1kUugn88C+5+UsPuDFGi42vDutA8
	+j6DcXPdFSORWShRHqmJ7Rek3ht5uwH6WRYBY3LdD9vSFtlQV23RfWduOmZbQpUy0z3QtgVrJ9M
	Gka9jz3ijO1KFSuWtH6Mj8jzO0+lm/rU3OmLKR17emOm+RuWiQfBjRyHrwihKWln7Y9a7JxbXmq
	FGRgYBBg7hw7LAiNyoKwB8vSgt37s40UhMBqR0Xji5i2zo0Fws9wONqr+nQ=
X-Google-Smtp-Source: AGHT+IEiIDXkSrx5GtdhuqYIDr1VIfuMjIQs0tgYZcUIgrXb9WrfiLPKfhN0RTcxZ2Cl9VKZoSsr0L7/MMXA
X-Received: by 2002:a17:903:3d05:b0:267:44e6:11dd with SMTP id d9443c01a7336-26813bf0cb6mr2254435ad.53.1758069347404;
        Tue, 16 Sep 2025 17:35:47 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-267b5deb158sm4934865ad.46.2025.09.16.17.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 17:35:47 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id AED7E3402ED;
	Tue, 16 Sep 2025 18:35:46 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 9240BE40EC3; Tue, 16 Sep 2025 18:35:46 -0600 (MDT)
Date: Tue, 16 Sep 2025 18:35:46 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: ublk: fix behavior when fio is not installed
Message-ID: <aMoCYseJUVcbC7gl@dev-ushankar.dev.purestorage.com>
References: <20250916-ublk_fio-v1-1-8d522539eed7@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-ublk_fio-v1-1-8d522539eed7@purestorage.com>

On Tue, Sep 16, 2025 at 04:11:53PM -0600, Uday Shankar wrote:
> Some ublk selftests have strange behavior when fio is not installed.
> While most tests behave correctly (run if they don't need fio, or skip
> if they need fio), the following tests have different behavior:
> 
> - test_null_01 and test_null_02 try to run fio without checking if it
>   exists first, and fail on any failure of the fio command (including
>   "fio command not found"). So these tests fail when they should skip.
> - test_stress_05 runs fio without checking if it exists first, but
>   doesn't fail on fio command failure. This test passes, but that pass
>   is misleading as the test doesn't do anything useful without fio
>   installed. So this test passes when it should skip.
> 
> Fix these issues by adding _have_program fio checks to the top of all
> three of these tests.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Please disregard; it was pointed out to me that I missed a few tests.
Will post an updated v2 soon.


