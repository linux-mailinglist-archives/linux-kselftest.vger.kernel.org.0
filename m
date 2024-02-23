Return-Path: <linux-kselftest+bounces-5324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB0B8607AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 01:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33001C223D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 00:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978BF9463;
	Fri, 23 Feb 2024 00:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmE73F4v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6D5372;
	Fri, 23 Feb 2024 00:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708648003; cv=none; b=lEYFPJ5zuhKulFbtq0hTjHoolj+nBbZGQdEJ1zgO7R6bw6LLKdErh3R8swTrh4+lY5jua/1FttXY1McH6BZyK9faIEtvddvKsEJ6hgd9BVFGjcfGu779Mu55AH23UBamu7bW0++5m6Mx/Qoa0JrRY9AHLJq55BV0vswD9R/Y/rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708648003; c=relaxed/simple;
	bh=QeLGwOTba/JGiatcd8fvw+dZvvzwqgngsTXchSiPfT4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dmTbyoEba6ZOiNfB3OlCEC2M8olm8GINHk61kj5axTGWVJTPWxu+PNQEeiFumvp05FBwhZOhRkk6QOkPg3P4+D80shCnI4lk6Tq++2zyx2ymbkPZazNpFdQeaKn9a0/1gI7f0+BDApgRzLFGN3TopTImWyzh69ym76HfYLJKab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmE73F4v; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3e552eff09so29113066b.3;
        Thu, 22 Feb 2024 16:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708648000; x=1709252800; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7sl3LZwYhteyadIe+Jzk/EoTxoeULHQwlWArFHu3FeM=;
        b=MmE73F4vqa0lNevu2AC9XKnRkPk8pRKimWz9wqWvtThnCoEDGoQXB8LoyOdNLxgxfL
         oukdXg+EwOqZxclICtmiR1bPmRjOiZ4vymMo9FdwqkIPUVkjt88robA+JOpX/A1GpClD
         iAqHGCXZsHmox+IqweX1s7jwXMrpMVsNfDvKWf3m0EQgcFo/Tj1SKmJgGC9tkPAwmH0P
         wvLZMSowkaF6mIP/VeW/WFbEjapCF7Jn7AtXhId5Ai3gzAgfedhmF2XPSOiEa4KO8aa8
         7ysCKyQubRKLr+3M80D7w8DjC00ub7uY+YHN+73Wt9ki88dVBVo5fRBXSIfMLY+etzLC
         hgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708648000; x=1709252800;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sl3LZwYhteyadIe+Jzk/EoTxoeULHQwlWArFHu3FeM=;
        b=XS6tMm65C0sCyfeH28bD8Kg8znQ/X3O2L45bpegOgXcEUS0TdSrLubJtl0lvwprWl5
         3ojny3mxEufKzq41XTfGfck933ssXliYKEm4olaBsFOFd2vBBUVfwDcwhLL3I2qeAFPH
         oprtR8SZEstYwz3MQ+ZsYlE2IYODcoAcL9dnD5n2s9z97Me3B2g4Z0cZRcsrx8lPsu9M
         KQ37K317jmJOuUb7tbmVOxcF8/cImPUgK/19yOb/mbixvFgb2KaTjrlplqMy+kyJ+S8e
         z/JSewuucAtIOY2dv747wAGkpFZkr8JdXSyW6PV15b4iHgfAoCibYjapmPCcT4/VfHuE
         PFQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZItCbgVq7Ge+tE5hyabwNAcKp36ESuMjoMYQdsBZYTiSWeGBKBCQkXbTUONxu3pW+0UNl+ZW7a9KKrAmk1wLOuJ/FnJD4VsGbm9qvEdPEsRSUWV4JCBSx7SYInPVNRNBq2gfpvq1Nqk0KZLlpQnMLULZa9sQ1mlE+0qrhcGqjzxpjT3DlCM//Us1213hGI3ImC/gdtrAJiocLBDQh5C6xrpmNuEI=
X-Gm-Message-State: AOJu0Yzq7ZsUcpu+9OWArasPvhW+nlxoIk5w1ej7c8DxRFrh6LG4+aJ4
	Lduj/rCkYiPQAZo6rPeREAgZKKpTEQeKmTPSF6lLST/ZXyodGiOe
X-Google-Smtp-Source: AGHT+IF2OQu/DLVAOaSMiv/biei+eT2gRWadinJDn6H227rgRLdcHK8nQhm4kQA3z2aD6v7iuECMfQ==
X-Received: by 2002:a17:906:2419:b0:a3e:9c2e:40d5 with SMTP id z25-20020a170906241900b00a3e9c2e40d5mr182764eja.5.1708647999827;
        Thu, 22 Feb 2024 16:26:39 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id cw4-20020a170907160400b00a3e45fa1c77sm5542901ejd.55.2024.02.22.16.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 16:26:39 -0800 (PST)
Message-ID: <ec6df1ee90f832dae90d69a5301bfe18c32e794f.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v3 05/16] bpf/verifier: add bpf_timer as a
 kfunc capable type
From: Eduard Zingerman <eddyz87@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>,  Benjamin Tissoires
 <benjamin.tissoires@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Fri, 23 Feb 2024 02:26:33 +0200
In-Reply-To: <dfbb1464e99e057d77f78395d985208d6510040d.camel@gmail.com>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
	 <20240221-hid-bpf-sleepable-v3-5-1fb378ca6301@kernel.org>
	 <dfbb1464e99e057d77f78395d985208d6510040d.camel@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-23 at 02:22 +0200, Eduard Zingerman wrote:
[...]

> > +			case BPF_TIMER:
> > +				/* FIXME: kptr does the above, should we use the same? */

[...]

> I tried the following simple program and it verifies fine:=20

Sorry, I meant that I tried it with the above check removed.

