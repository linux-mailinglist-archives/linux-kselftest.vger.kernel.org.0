Return-Path: <linux-kselftest+bounces-2810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8749582A235
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 21:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E720328DFB0
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 20:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752574EB23;
	Wed, 10 Jan 2024 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL/T0cv2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7AC4E1C6;
	Wed, 10 Jan 2024 20:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2a360dbc11so472502066b.2;
        Wed, 10 Jan 2024 12:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704918437; x=1705523237; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+ifxwcFxOFVBNbmr2dc4l+kpKjVJS995UH0AOybvBx4=;
        b=GL/T0cv2JSTm4sCu6oNKcXAYqQlXE+a2D4+odFVTd0DQz1SBXO+eSucQhALHXmEzKP
         8f8WaponK4vvRWufAZ4A/FlcawOyRwBB10v4qwsWneGC21tw/1lucbztZV4y1V5GxoDi
         4j8FS5pdXEBgwj7JsKRPCqJILCzq62igSiMEKbFFXKIG+Xg3x7FykQTsaEhFhjMC45Su
         X+/grvlGv1GJsy0AD8tKphUk8/ZjeKYKy3NamXBIvT/7e6mVKHg/0WlFrznfeF9j1zD8
         h0Iac5g6p0DGniHR5FIhzdLopdwVtEusWWBx9ixAaxtJTYwMxh0x8HPtIhre2m1lLL+7
         G8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704918437; x=1705523237;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ifxwcFxOFVBNbmr2dc4l+kpKjVJS995UH0AOybvBx4=;
        b=L4HSZu0R0pzK/CHH4gelxTskdAyRNXX1A6g3Gg4qCegJn9SsD6LHGYowtOGpAu6Uvg
         04koAntflUaNdCVj5vOTrxM5R0IAjif9KrU+Sx6MHl4vuLS1cWdPxZSgnz0pnEi3xIfv
         jJp7Y7PaF8y14XTOZ1OtptB1rqfyzVsqxdnRdffhfbfP8Y408Qjh5mdLCcFQWDZaG9eA
         okmw3LGcSSDTzr8/IKR1a4r18qcVxFVfVR0uvPWHWJD34LdOXQygLOKU6oC51kn6e4dX
         NGwyl1H2vj3xmJRh+4X94EFTHtXnmjWqAd8QVaPPJY5tOiscHKW5DgH4N4u6isFk2vpE
         uhPw==
X-Gm-Message-State: AOJu0YzePGH7eLFCtW61+ptcihRahXdhMqeKRGFTJ3xc8Kel02+mZV5z
	oKe3CGbOMNBJL/IJDdKDp5ulpcUHsqxrXw==
X-Google-Smtp-Source: AGHT+IGehEnjUxM8XVp3Hp5quC/gIVgMUDjk4wCsrWYb27UVWSeswuPQvodJD6TC1d6vfePOgu7nYw==
X-Received: by 2002:a17:906:ad91:b0:a28:cb84:1888 with SMTP id la17-20020a170906ad9100b00a28cb841888mr55095ejb.2.1704918437064;
        Wed, 10 Jan 2024 12:27:17 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id dx16-20020a170906a85000b00a2bf9b00508sm660198ejb.141.2024.01.10.12.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 12:27:16 -0800 (PST)
Message-ID: <458ecf3d755ffd7df33913b87cd6ad6f8e1c07ef.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 15/15] selftests/bpf: states pruning checks
 for scalar vs STACK_{MISC,ZERO}
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Maxim Mikityanskiy
	 <maxtram95@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>, John Fastabend <john.fastabend@gmail.com>,  Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org
Date: Wed, 10 Jan 2024 22:27:13 +0200
In-Reply-To: <CAEf4BzaQzWLJqMuOtBX+wmH4EH43nYjTcuVun5nGUwEY_6E7RA@mail.gmail.com>
References: <20240108205209.838365-1-maxtram95@gmail.com>
	 <20240108205209.838365-16-maxtram95@gmail.com>
	 <CAEf4BzaQzWLJqMuOtBX+wmH4EH43nYjTcuVun5nGUwEY_6E7RA@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-09 at 16:27 -0800, Andrii Nakryiko wrote:
[...]
> same, please double check this STACK_xxx assumptions, as now we spill
> registers instead of STACK_ZERO in a lot of cases

Right, the test is outdated after your recent fixes for STACK_ZERO.
Thank you for catching this.

