Return-Path: <linux-kselftest+bounces-18863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2448F98CC82
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 07:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5767B223CA
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 05:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5458328B6;
	Wed,  2 Oct 2024 05:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBizqqRR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1C611187;
	Wed,  2 Oct 2024 05:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727848164; cv=none; b=VALCcLaOtjtJSZUaqRuF46vwsGKUva64TAA4ApfMb1XvQI+5WUTN4gzGwNythR7lBEo+xXfXfod0V2jwRR3gilSFSlSt2q/52Wx2G/0xXb/Rx3LecpINUON0JI23XLhLiZBIR4SXDVN4U6lh5ePNiXK2A6PI8Us1jby/y8WGwqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727848164; c=relaxed/simple;
	bh=jN9gZYCswg6gKZaVN94WrWBooJCLjdCRYJVy0+NyVfA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=IkC81wwWUSzf3q7H1KnYVi42LoB0lywiJvL8wNXMicpzdMN08CW2n+7lK6h//cM5NXZE5LnV1hEQo30BHm23cdhyfTc+8XyF1y43h2eEod+JjKdpIT9tx1XPO54QJ0qLHWWtU+Bv6US4YDqnotY0rWHuHj+caZtNs12s7eealFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBizqqRR; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7198de684a7so4446878b3a.2;
        Tue, 01 Oct 2024 22:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727848162; x=1728452962; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nAi3+Jj7VO1oSuzWLs/Xs3zSVfvIN3Gva8xKesxmS0Q=;
        b=NBizqqRRsN5ScM/Vgzp6H/4ijP/QT6e191wLTs4Dk32qVbmAx8o7xL9I8Y0T7Ct+7Q
         dQEUzEJ26OWt7LUBfWHDmZjASikA+fWltRrw9Pw+oUTCp4xJ1sef3PG31Ym6bn5TpDuE
         Es0QwiFIxY6mNrMF/dLtSXGzoIbcj7WHqhPzyTEPpv61nARPLTOwNt4sD2VTDHsuJRHN
         gfC4EGbvaY830noenYYTylTG0OQ5EJuBMOcQU+TN/jvG4zVUH9KpmNYwP6jNUZTjV98Z
         RO3N1Ou5O5fu3r3p2t7bTmbIFgKfLscWxJAReon9NS9IzVYKm4VgGoY9b5zGx8u3KDPI
         su5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727848162; x=1728452962;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAi3+Jj7VO1oSuzWLs/Xs3zSVfvIN3Gva8xKesxmS0Q=;
        b=wz2+Dd0NF9fUGexpcpZ3qVKpQd7hFg5UIXPgFt+BsKG6vcNUdK5ge16wo0cutFLKpH
         1SXlzjYQt8xML/fB37lfgpjNHTumADegc/gPVqkd6c+xL9313Wk1nGBwQ3s1ErSYwum5
         LjmFyE83xVnWbKP171cvzII/s9KG6yP5PyhnruMQhP0LopzR59z+kHF6VG72OZTPuO6s
         78/M+i+Smcd+vatXm5/ENrqswkU0BIunELjDXQ6dwiNIIDW3LeY1OHRc+WA3WU9u+u60
         M9Ydt1u2EYDnVc6iUNf3vj047tu2p06Uo3it2TT083zXpu2JphUGr4tdtjUfsqGoGtEA
         E7XQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2fwRTY+5P/urV5KH7hhXxlv9WuiVTV5mmPrdWPWkw74QtPqUkk65OyQJo87lbIoo6t0SncCbCBkcq9B4GBGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6GEnRykX5jz73dHF/RYeucELa7+NRHQgM+RXqmfSCFkkFOJmp
	YUlflYtRdKncd5G8t+iEXw3APuyy9btd6v0etajvyu/5M9mUlx8y
X-Google-Smtp-Source: AGHT+IEctg1bG1h01FMpZ7KPv7MN8I3/B8gsYF6W6p4t+ELncb4q7gaLjWWJyeNYbzuFubS/soGvgQ==
X-Received: by 2002:aa7:8886:0:b0:70d:2e7e:1853 with SMTP id d2e1a72fcca58-71dc5d54399mr3506061b3a.19.1727848162143;
        Tue, 01 Oct 2024 22:49:22 -0700 (PDT)
Received: from dw-tp ([171.76.83.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bcca6sm9114024b3a.78.2024.10.01.22.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 22:49:21 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, shuah@kernel.org, zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: Re: [PATCH v2] selftests/powerpc: Remove the path after initialization.
In-Reply-To: <20240930012757.2395-1-zhangjiao2@cmss.chinamobile.com>
Date: Wed, 02 Oct 2024 11:15:11 +0530
Message-ID: <87frpfxdlk.fsf@gmail.com>
References: <20240930012757.2395-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

zhangjiao2 <zhangjiao2@cmss.chinamobile.com> writes:

> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
>
> If there were no anamolies noted, then we can
> simply remove the log file and return, ....

after the path variable has been initialized.

(minor nit)


>
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
> v1->v2:
> 	Remove the path after initialization.
>
>  tools/testing/selftests/powerpc/mm/tlbie_test.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)


Thanks for the fix. Looks good to me. 
Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

