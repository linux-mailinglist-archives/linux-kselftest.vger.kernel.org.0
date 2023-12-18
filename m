Return-Path: <linux-kselftest+bounces-2134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB95816975
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 10:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472CE2830B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 09:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9428111193;
	Mon, 18 Dec 2023 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCXuFLSt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C9917731;
	Mon, 18 Dec 2023 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28aea039fb4so2905581a91.1;
        Mon, 18 Dec 2023 01:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702890602; x=1703495402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z0p+SxUMexljgiKpEfYsnyxzMh4XZEHY+3ZkqAEbf0I=;
        b=kCXuFLStm9CvRp+/8jjhPrByOgg10HitdK4ONScaXLyuJSZ02kg0eaopZTAjnFJejj
         WCQi9EQn5kAaMHFLHGMSZD41GASUBLc0hmX/AhUhnh7BIScuSc8r/Ap7qBmT29diHigx
         Tga514zD4HbppyT50LTNhuflLYPPgKdzV4Q8fLaPnGOtYZWL4AE+4RbNNrmNBC0RNslI
         Qt5AqfMrBbEy88r5qR1D35DAwdjnJEj1lhTQbiGa+keCwJnRYz5t36pcfiTAnhR1JtH/
         Cukrmp1nYt8uXufV2MMrplxM4+9xu1HUbestG2fZHTGTtfp3qYuCbZTvfG1E1sWvNW5V
         UUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702890602; x=1703495402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0p+SxUMexljgiKpEfYsnyxzMh4XZEHY+3ZkqAEbf0I=;
        b=r7pGVdg8+mkW27598cqcPTfC1dNGh9wwkRwbDQFXkvm0YpZ97zJYQfdPBjJulLqZxV
         Bm7uv21lROMUfT5cl9/hITysCUEIitB0709/CIoY52OaoK5IqQhAQIEnn5C5PLbjKRDg
         /+woTW4L7RqXB/NZxtd1vmmkEaCrg93FBWurUqFNLtjC15DxIEM9WZvmRthtQqZOdzeJ
         wqp+lZSoKmGWvqr/JQAvRhviJEYN7x1+z+mo8qz3AqrWW7DLlggTBjsOvXDeVQRDwAuX
         +nGe9FFmyCiy3BWDAeEaNG4aTspa1zJjDcpFRXpB71mlXERsYvWtyXabynrrYC3ejzSZ
         Bjow==
X-Gm-Message-State: AOJu0YzEIhrCLdUeecp51ifeGKZ81VodlNakph/5DzgS/Bu/A2edAUfR
	2UGu3KuEblaMvn5MV0scFuA=
X-Google-Smtp-Source: AGHT+IGigKNQwa8yVXPZGk1nr/RuTKPX41vgNftV2O3rP3ukB/RGRXinpCDVjw6TR7zSkBcSjwhOuw==
X-Received: by 2002:a17:90a:9318:b0:28b:70b:1939 with SMTP id p24-20020a17090a931800b0028b070b1939mr9138207pjo.6.1702890602353;
        Mon, 18 Dec 2023 01:10:02 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902bd8500b001c9d011581dsm18480621pls.164.2023.12.18.01.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 01:10:01 -0800 (PST)
Date: Mon, 18 Dec 2023 17:09:56 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Dmitry Safonov <dima@arista.com>
Cc: Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Salam Noureddine <noureddine@arista.com>,
	Bob Gilligan <gilligan@arista.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH 07/12] selftests/net: Add test/benchmark for removing MKTs
Message-ID: <ZYAMZE07FfZVYHH2@Laptop-X1>
References: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
 <20231215-tcp-ao-selftests-v1-7-f6c08180b985@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215-tcp-ao-selftests-v1-7-f6c08180b985@arista.com>

On Fri, Dec 15, 2023 at 02:36:21AM +0000, Dmitry Safonov wrote:
> Sample output:
> > 1..36
> > # 1106[lib/setup.c:207] rand seed 1660754406
> > TAP version 13
> > ok 1   Worst case connect       512 keys: min=0ms max=1ms mean=0.583329ms stddev=0.076376
> > ok 2 Connect random-search      512 keys: min=0ms max=1ms mean=0.53412ms stddev=0.0516779
> > ok 3    Worst case delete       512 keys: min=2ms max=11ms mean=6.04139ms stddev=0.245792
> > ok 4        Add a new key       512 keys: min=0ms max=13ms mean=0.673415ms stddev=0.0820618
> > ok 5 Remove random-search       512 keys: min=5ms max=9ms mean=6.65969ms stddev=0.258064
> > ok 6         Remove async       512 keys: min=0ms max=0ms mean=0.041825ms stddev=0.0204512
> > ok 7   Worst case connect       1024 keys: min=0ms max=2ms mean=0.520357ms stddev=0.0721358
> > ok 8 Connect random-search      1024 keys: min=0ms max=2ms mean=0.535312ms stddev=0.0517355
> > ok 9    Worst case delete       1024 keys: min=5ms max=9ms mean=8.27219ms stddev=0.287614
> > ok 10        Add a new key      1024 keys: min=0ms max=1ms mean=0.688121ms stddev=0.0829531
> > ok 11 Remove random-search      1024 keys: min=5ms max=9ms mean=8.37649ms stddev=0.289422
> > ok 12         Remove async      1024 keys: min=0ms max=0ms mean=0.0457096ms stddev=0.0213798
> > ok 13   Worst case connect      2048 keys: min=0ms max=2ms mean=0.748804ms stddev=0.0865335
> > ok 14 Connect random-search     2048 keys: min=0ms max=2ms mean=0.782993ms stddev=0.0625697
> > ok 15    Worst case delete      2048 keys: min=5ms max=10ms mean=8.23106ms stddev=0.286898
> > ok 16        Add a new key      2048 keys: min=0ms max=1ms mean=0.812988ms stddev=0.0901658
> > ok 17 Remove random-search      2048 keys: min=8ms max=9ms mean=8.84949ms stddev=0.297481
> > ok 18         Remove async      2048 keys: min=0ms max=0ms mean=0.0297223ms stddev=0.0172402
> > ok 19   Worst case connect      4096 keys: min=1ms max=5ms mean=1.53352ms stddev=0.123836
> > ok 20 Connect random-search     4096 keys: min=1ms max=5ms mean=1.52226ms stddev=0.0872429
> > ok 21    Worst case delete      4096 keys: min=5ms max=9ms mean=8.25874ms stddev=0.28738
> > ok 22        Add a new key      4096 keys: min=0ms max=3ms mean=1.67382ms stddev=0.129376
> > ok 23 Remove random-search      4096 keys: min=5ms max=10ms mean=8.26178ms stddev=0.287433
> > ok 24         Remove async      4096 keys: min=0ms max=0ms mean=0.0340009ms stddev=0.0184393
> > ok 25   Worst case connect      8192 keys: min=2ms max=4ms mean=2.86208ms stddev=0.169177
> > ok 26 Connect random-search     8192 keys: min=2ms max=4ms mean=2.87592ms stddev=0.119915
> > ok 27    Worst case delete      8192 keys: min=6ms max=11ms mean=7.55291ms stddev=0.274826
> > ok 28        Add a new key      8192 keys: min=1ms max=5ms mean=2.56797ms stddev=0.160249
> > ok 29 Remove random-search      8192 keys: min=5ms max=10ms mean=7.14002ms stddev=0.267208
> > ok 30         Remove async      8192 keys: min=0ms max=0ms mean=0.0320066ms stddev=0.0178904
> > ok 31   Worst case connect      16384 keys: min=5ms max=6ms mean=5.55334ms stddev=0.235655
> > ok 32 Connect random-search     16384 keys: min=5ms max=6ms mean=5.52614ms stddev=0.166225
> > ok 33    Worst case delete      16384 keys: min=5ms max=11ms mean=7.39109ms stddev=0.271866
> > ok 34        Add a new key      16384 keys: min=2ms max=4ms mean=3.35799ms stddev=0.183248
> > ok 35 Remove random-search      16384 keys: min=5ms max=8ms mean=6.86078ms stddev=0.261931
> > ok 36         Remove async      16384 keys: min=0ms max=0ms mean=0.0302384ms stddev=0.0173892
> > # Totals: pass:36 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> From the output it's visible that the current simplified approach with
> linked-list of MKTs scales quite fine even for thousands of keys.
> And that also means that the majority of the time for delete is eaten by
> synchronize_rcu() [which I can confirm separately by tracing].
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Tested-by: Hangbin Liu <liuhangbin@gmail.com>

