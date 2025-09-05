Return-Path: <linux-kselftest+bounces-40814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D2CB4517C
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 10:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B02E97B6949
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 08:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D663126B0;
	Fri,  5 Sep 2025 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GxqU0wHn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201DC3112C3
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Sep 2025 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060962; cv=none; b=tRG3VBzYD4xyQNHycOIEgErO/wWWj7zFvfz5g1uMJ8ELtldRdnxvO1kphhYs0xLZIDdzDJqx6j2hVnrkkmcL2/1NyL8Mwrlzaw2MlNrNdbIx/ul2TmriSNT/mjNoV2M4KaZP5cWlzejSkku3LTIzLEPdU1Bwln9AVXhUW7BwOvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060962; c=relaxed/simple;
	bh=kwtRzEimvtpLrmOqqyXZ2f1tX9zUnglfb92WvRi+wAc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G5yNjhTLioOx1LldDZJohyl+imvrGa0+tPiV0sSN6WoKnwqwKRiZ/3XWBNhORrsG/ZgyJlBFYBp6WlxyJ44OSaqczHY7+Gra/Bohsob/bGX6kDf9Nl150M0pKmHgUgZ0VUaPsu6+hQ2i/MIxH9KPVjbD3w/QikvM3JI3zf6ZS44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GxqU0wHn; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ceb9c3d98cso1134827f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Sep 2025 01:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757060958; x=1757665758; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AjrpyuHiQ2iH5gQyFoJsWbyIGpc1VmBeELccX5MB0vw=;
        b=GxqU0wHnPbimGnQMJydFp9h6gRu+1fM/didYq1YsDD96ZNHK1tjOF15VNtlJmDn5Fa
         FFUvA1YwRjbDNi+wACdQhRBrOyoRMAJEmWK25CA6P88qrYUALoNbrIfHZJ6lJCxSTi9Y
         9yioZHy7uM3rpybbvtMQvsF3YNzA7KrhiePIJyJdkCv/2fA/UBl/oirI3jX+BRS0gbnA
         JSOyuJ5Ww58FfBwBF82qHuBb/twVgCFK3KYs2COTOztUBQpo3ktNKde+iVLSxwQ69JJI
         /4CKwGD6zsV0tzX+3VYft2qXLxNVht9ZF1fNEfgp3Y+dJ/bCDjUYQrvtIfnhx5wekKNh
         Ah/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757060958; x=1757665758;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AjrpyuHiQ2iH5gQyFoJsWbyIGpc1VmBeELccX5MB0vw=;
        b=wk1ZkJvvTL9Sci8lgo3/jBstIvAOLbUMSTp/dhweRcSAn+YLdLsh072P/rOU79mc0z
         FF+cDwieDWyZApIkW6G9XAqaTgNKkZV+Eu4tCbwYoQMBe9yGD718q/iXyk5lVXVHNE0q
         rYh1kZ4/6UDFCsLQUAGuHB3ahoR8MNg0X/GzvqlImwnsxqN0o1a2yst6m4zHV2BJj1ye
         EXMJJH+ydhqWyBS0gaH5bHReaTVRx2ANvU0kh6CsMmXj9xrZK30zGCe7VaUi5uVmaOJP
         l81DFJlJlQgKjuhw8O8o0lVv4Kjn2fnIiLyYWJOYc1fccnyL92udwYdKLix5zVQiVAgp
         z6qA==
X-Forwarded-Encrypted: i=1; AJvYcCVHYRSu82mx8tDwm1Ugp3DdzO+iICBA6BVECgmFawIQgTtfEwVScu0fL6v0uu56lkgEO7jgF5YwGuXnnLod5f8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQqXEARuz8Jfy77y0KY/jNFxN8y99qUZDyYI9FW3oHJNiPecHB
	X7u4akD92UznxEqvHYp0LB3WFRr6BfHarygR3MyMFjBmF9lwKcTnH6Q6SLAE2HfB+kk=
X-Gm-Gg: ASbGnct/YzESPLatx3CxGOgjSL//0SjClS2opcpaxVe2I+ElQ7epm4FvcodHYW/0pe0
	81/UPA+UNS6wYq9jKnHPYUwIhOW8Gu4duwj5kuaWHrnb7BwMTomg8GwoqbKQCwd43CWMvDg2iKg
	vpnii43NVLiiGGsA8GoWAdE+m00vnVIbIgs94U8nSA8+XKVSNft8AjrugzJlN3uPsUWboyCxLlB
	07frofa5r/7RrZBwylNYk8mx2cNWnhrR4spx5ZiSdnZOS2Gvpcuzj8JLljvH+aZFABw5jn/Thq0
	l/I8a1UjmIzaFSWyKybi83o58lO+O89nvJJNhqZ6A/6PHkTaBvvydOFdasytkRnxZshmoPBrYkv
	KvBdoAPbGFhQSOa9VjYcn2WfssxT1JOobNcXxzw==
X-Google-Smtp-Source: AGHT+IFEvCT7cftOHZO5jf4iWcOS3253s9HffuDuqj0+9u9GDfbc5U393v8kkgducPBi6qjGPaKlww==
X-Received: by 2002:a05:6000:22ca:b0:3ce:f0a5:d594 with SMTP id ffacd0b85a97d-3d1dca7bc64mr20100856f8f.13.1757060958381;
        Fri, 05 Sep 2025 01:29:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45dcfcba94esm37384985e9.2.2025.09.05.01.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:29:18 -0700 (PDT)
Date: Fri, 5 Sep 2025 11:29:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [bug report] selftest/bpf/benchs: Add benchmark for sockmap usage
Message-ID: <aLqfWuRR9R_KTe5e@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Jiayuan Chen,

Commit 7b2fa44de5e7 ("selftest/bpf/benchs: Add benchmark for sockmap
usage") from Apr 7, 2025 (linux-next), leads to the following Smatch
static checker warning:

    tools/testing/selftests/bpf/benchs/bench_sockmap.c:129 bench_sockmap_prog_destroy()
    error: buffer overflow 'ctx.fds' 5 <= 19

tools/testing/selftests/bpf/benchs/bench_sockmap.c
    123 static void bench_sockmap_prog_destroy(void)
    124 {
    125         int i;
    126 
    127         for (i = 0; i < sizeof(ctx.fds); i++) {
                                ^^^^^^^^^^^^^^^
This should be ARRAY_SIZE(ctx.fds) otherwise it's a buffer overflow.

    128                 if (ctx.fds[0] > 0)
                            ^^^^^^^^^^
Instead of .fds[0] it should be .fds[i], right?

--> 129                         close(ctx.fds[i]);
    130         }
    131 
    132         bench_sockmap_prog__destroy(ctx.skel);
    133 }

regards,
dan carpenter

