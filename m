Return-Path: <linux-kselftest+bounces-27816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8EEA48B86
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 23:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ACEF7A3912
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 22:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF67277809;
	Thu, 27 Feb 2025 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBuOerOu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04882777FB;
	Thu, 27 Feb 2025 22:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695185; cv=none; b=Zj1rI0F9z3gnMTe99wq/dJ7gkiwDOcyXHVvgn1xJu+0mUWUKtL+0eH4fbUX5YG9nEl24B2B8FfV7sIGAjRV0am3Fde8XRE9kfTCvIDlS4JydNE/nsZUcGw9MPg3jNwPevQioQgNISGEqXSkZ6fWFkmO7tHiUyh5bNnlWD+uSso8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695185; c=relaxed/simple;
	bh=gtM20++jDrE+rF2NeuuL1OFtGokuhEHrZ/ogXcm8k/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2aRZexb/ETXtLBazm4MHgPWr6A+eAAq0lYb+is6Wmhg+RtwRUnsRgt86aY5hA7mOhub+0FDQyVGfkGp8+aRenW5tpGpdoQsvucCOQtHVaU7nK/jwP1Ma9VRzjIKOph9WcsXmaActuhj5epRD6c6vJC3HyozP/tDMHD2Y4z4C/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBuOerOu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22334203781so38472645ad.0;
        Thu, 27 Feb 2025 14:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740695183; x=1741299983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HRAmuYxHtn4qlykZoKH68H6MRsOoeB/MCYKeQWiydf8=;
        b=LBuOerOuUcjRhfQBVdZYDSr0b1u6kWeSoy4j7AfwTcQ/K8NfwGGOQ7No0mO82Meff/
         jGNHHHXl4dyPlKx5CoFsJtsYSUqFXgyw39d9P7S3ZKHCA05HPx6xq8au9bhrGFIq+oad
         D7gMY14SKI3lP5tdf2PDEEB+2N4I0HpFTrOQUe4nksBSMSKv4kIZJ+mMHmjFMzH1yNGO
         EpVSxYUctduKeAEUA284DvfT3E9mOKbh7+MW1KGuX+ggJq+NH/LwqozUjolpa5h1JsC6
         f9xmKBmY9MNBgHFHrwQAMQHZANxJpIPvWjKDC8dVEKWPbdILTYRDANqj/C9IEJtwVLQT
         2dSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740695183; x=1741299983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRAmuYxHtn4qlykZoKH68H6MRsOoeB/MCYKeQWiydf8=;
        b=JuwvITZrROgLd1Dw1CzJQaYFQ4ksxiGXXKl4y6dlyu+dBinJzROaVXAQmfWD57LgVl
         llqGHNUH1ouyepB+bNgpyLW90elX/hvks/mhBiliSOQcZoNbp5NemqZmJScELgoP8aJZ
         Z3JuLwS1gl7P/UtZlnbnGdu/ZWOiw6bZN+3vmiK+BMtoLP/AcZ7NlZa1ABAQiTvdYIoC
         yfTdta47U7CEYdsKo9mf2s81wrLT3q7+PCjOBRZln0T3aGXELzdw4ECxh1Y6JB0xopPv
         z99Wtgkg0Osge3z+E9veiaNg0almGY4t/3n5n9ra5la9/Tmd/CIlS8AOAL3Q5vBoTp04
         1abQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx6Ww+F3sdv/T5RyALwutYwDsn7Q67fJBDg4jD3XtbjVt+09+aenPOrmeNiheRYbdxSnBsyiZrzLawR999@vger.kernel.org, AJvYcCWIXB3q0/94z5HjzWffycDAAwpRY9w+oeuvEvdCkQl3m4nOjcJkdp8+TSzNTEiB9zW2RzaTaOMLmejrD9hT8BtY@vger.kernel.org, AJvYcCXzIXS8ChIjZ6HYV7We9On9s8q6ogLTx0L/bARC+1rx0TkjY4cSRsFfl6dT61FUlZkKxTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOfAU1nmModPg+9+xV5wO3KYQL2RBXwPURScpgL5AM1HqxvfEF
	ECSZ8RG0CObeomLiR98Op0BFqt9d76Q+4FBVYZIP7NI2FJjWA+Y=
X-Gm-Gg: ASbGnct01SduJhvYusdMojpAblEW1daLT7kfy+uth0eKE/4Wikp6a31JjONOu1JsMr/
	GOuBan2AQt3LZqSs9sDiMVqLNy2yNAokRqgnj76h557Su8x7t0/l1ZiFlb3fXV2mxGXXM3vnz5e
	I1GVyQ9H9iULjaOULWVTUAr4tnEI/CNS1JebQvzrod0nu/9yI7SZMpC2ROYQfc64HwzPEFg1pE5
	AZrK8Zij8WUWm7GCX5rIAa6N3XldNZ97jnF8mHEuSgbcHNhpOlMOYuvvRca9ZL15zYv1Z5idowv
	eQNPUYronc9/2rMV3fkLM+RWcg==
X-Google-Smtp-Source: AGHT+IEJQxSeClVai5A355sKLh6sw/aFvTF8JXX8Pd/cKD3GtL23IGmP4/0X1s8ZRpAGKrAk/jMSPQ==
X-Received: by 2002:aa7:864e:0:b0:72a:83ec:b1cb with SMTP id d2e1a72fcca58-7349cea2519mr7370799b3a.0.1740695182960;
        Thu, 27 Feb 2025 14:26:22 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-734a0024b61sm2334686b3a.107.2025.02.27.14.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:26:22 -0800 (PST)
Date: Thu, 27 Feb 2025 14:26:21 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
	shuah@kernel.org, hawk@kernel.org
Subject: Re: [PATCH bpf-next v4 5/6] selftests/bpf: add test for XDP metadata
 support in tun driver
Message-ID: <Z8DmjRy9g_vFX4lj@mini-arch>
References: <20250227142330.1605996-1-marcus.wichelmann@hetzner-cloud.de>
 <20250227142330.1605996-6-marcus.wichelmann@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227142330.1605996-6-marcus.wichelmann@hetzner-cloud.de>

On 02/27, Marcus Wichelmann wrote:
> Add a selftest that creates a tap device, attaches XDP and TC programs,
> writes a packet with a test payload into the tap device and checks the
> test result. This test ensures that the XDP metadata support in the tun
> driver is enabled and that the metadata size is correctly passed to the
> skb.
> 
> See the previous commit ("selftests/bpf: refactor xdp_context_functional
> test and bpf program") for details about the test design.
> 
> The test runs in its own network namespace using the feature introduced
> with commit c047e0e0e435 ("selftests/bpf: Optionally open a dedicated
> namespace to run test in it"). This provides some extra safety against
> conflicting interface names.
> 
> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

