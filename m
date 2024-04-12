Return-Path: <linux-kselftest+bounces-7849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D98948A34EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 19:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D25A1F22CEF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D376114D703;
	Fri, 12 Apr 2024 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFKxCu69"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA9F14C587;
	Fri, 12 Apr 2024 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943353; cv=none; b=aKy5yphHiYefV0aKs8SoRzLPRJPJx55g226dQDBj7Xd891fnLia1C2Y7YgMsNLnJXf0UFUj7enncs/5kmczCGki30lGU9VlbM/14u601s12nOuH+sBLQq2ZOTm2JfEXdu7e3pEntNZ0Geib48OOVMgc0YMw1KRR4AuAotrJAZI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943353; c=relaxed/simple;
	bh=Sv5fgKx/fGCIezkQaaMy5xPBh/Vr8DXtcK1tJ92CzN0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ErgoO2xc6DMqPXcqVYN4yGCgeZM3iEl9DktRtLFex7NWqHDlFMAquoCmRXAsKO1aNFrXx6ASu6+gCNBDv85EAc4HDwZ8V8ndjVMoJAgdoQJlj3RLE+pnUR7XWFHbN222jnPahwrWzLEo3q8HPc904QQIhecEnu5Cw/LcIdNLvSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFKxCu69; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d6c1e238so1402131e87.2;
        Fri, 12 Apr 2024 10:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712943350; x=1713548150; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sv5fgKx/fGCIezkQaaMy5xPBh/Vr8DXtcK1tJ92CzN0=;
        b=KFKxCu69mfQKvPJkGyd8uB0Gf1gT0SRnqiXrUeFw5hTJp0lBQREPr5CJADlF/R/ekt
         bTc5+JlhRpSi6GKFTbWXeD9zuHq9CP1+rAOAqjobNE0BQlM2JNFV4wrZMpcQ3Td5I8su
         bXnbu0zLxcst4ba0ZQA81D6/H/XivAkvx5RMGKW3Hp6sWbZtrdV0PlAP+RK/A3fndPoP
         //6r3DymgyJnDNO2FjqL3oK87888d6qm0/lbA/jj2q6sGT2ehurcTFEqdo9g3nZSLgoq
         QdX5BIS3mw1sz6wrRVi2jPEmOpqK17CZ/VDIJnjIYQf5sBBzCyV6fM/V7C1yRKPcsQWl
         MZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712943350; x=1713548150;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sv5fgKx/fGCIezkQaaMy5xPBh/Vr8DXtcK1tJ92CzN0=;
        b=nIe2XzvbFxBjLqc2HAYtuueUsle4jhG0u3DcRJp/SpnF9crU9AFOXmd+bSptcILDqV
         3EO+397H8Cvo4Wbtbep8Q7din//FbuklH9RHrFnWcfmn1AUOMdJmX3uH8loDKKlntHIz
         slZm0HlFQ1VC6xHnk1iAP9boPoJ8lRgw2E5t8FcEiBaQ1U+icamuGm0KT0/2jLACF/Jp
         +PtiRG0FQ9O817nQ/TWcyeTjxV2phIkmnhgwMJIOf4QIKhpAgGiej+Wkt7E3PVG3WO4B
         ZN3yUG8Yfaw+JWwC0jaykDiQLQNdV0w3J03rPayF6jHnh8bCYIDCyjEKnXcSORjespyY
         I9Sg==
X-Forwarded-Encrypted: i=1; AJvYcCW58+x9cuIlyVe3W/7xHgyzoL7k511L6Ng56INKH5XxOCNs0sVgb0g4qGvNwt26gvkN1POAQyNFwVrToa5TNb2CzlrUEBZtZXkOsrYlBWr5EYWOzw8tapCyaYLJGkGI3z/Xfw/1
X-Gm-Message-State: AOJu0Yxm2hMO33Ot9rf0tWtpTpwgr+QOuAnbGfP0pUzwTiWe5JNG0LwN
	U295fY0TZtWGnbQi2hfsgEwWaLydaihNvj2BTgLlnd3iXvIt1ODb
X-Google-Smtp-Source: AGHT+IGZ1/Plua9SppRYWLvAz3MAfAHOdTAUvblr9DnQ03j+oF9p2TI+EhwGkAwPITaSZ/udROAAMQ==
X-Received: by 2002:a19:4346:0:b0:516:bdf6:8db9 with SMTP id m6-20020a194346000000b00516bdf68db9mr1967855lfj.61.1712943350284;
        Fri, 12 Apr 2024 10:35:50 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id cs9-20020a0564020c4900b005682a0e915fsm1906428edb.76.2024.04.12.10.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 10:35:49 -0700 (PDT)
Message-ID: <a00ea33c695e74da7e48760f41e476520ccdfcf1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 11/14] selftests/bpf: Use
 start_server_setsockopt in sockopt_inherit
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Geliang Tang
 <geliang@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Andrii Nakryiko
 <andrii@kernel.org>,  Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,  bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 12 Apr 2024 20:35:48 +0300
In-Reply-To: <4d19829e-6e96-445f-8e2a-47f58b921281@linux.dev>
References: <cover.1712796967.git.tanggeliang@kylinos.cn>
	 <cf65883b5ad52bfe99e0dc02b6213aa0eaf51ead.1712796967.git.tanggeliang@kylinos.cn>
	 <4d19829e-6e96-445f-8e2a-47f58b921281@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-11 at 15:10 -0700, Martin KaFai Lau wrote:

[...]

> The start_server_setsockopt is only limited to integer socket option. It =
is not=20
> very flexible. It seems this is the only test that will be useful. Lets d=
rop=20
> start_server_setsockopt addition from this set for now and discuss it sep=
arately.

I agree with this suggestion from Martin.

[...]

