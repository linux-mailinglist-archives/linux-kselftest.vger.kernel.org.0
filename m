Return-Path: <linux-kselftest+bounces-22361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0289D3F7D
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 16:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038C61F21BF0
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 15:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128BD14C5B3;
	Wed, 20 Nov 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghpiq0Pr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848FF12BF02;
	Wed, 20 Nov 2024 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118162; cv=none; b=Va7utq+O2MeziYzyluBhs2P/BN7k8xAdlDu/aPPkr4EwdVjAZR7uBHKhBEV2xXzOi2sz9Xfg98w8c7BhDnWb5ZGX69XXg4pQE9J7CJMl25FpOHtmWiQiU2XiFOFACZw6v7Y2mu8fUiCUtbpriJMLy//28XUvdE3r8KGKAABQ3kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118162; c=relaxed/simple;
	bh=uKORy96Ltlla7k+W+k19Ldw9TgbC3BwqfJIKJK2OwcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bis7xVoshUjx+xAy70WtOIZb4jFYQtWwYdiRZUKAPwy0yvb74qVK8s15lHj9ZIHKBvZtxzpz+KJVgkQFOG6uSc9qICCWx8zoz4NTHBzIKL53MSvSnq0sWPpcbH7eR061Oo9xHnTUhdnZv0ic7Wmitl2j0ia1/HWjjJDP2/NmQU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghpiq0Pr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso1829971b3a.3;
        Wed, 20 Nov 2024 07:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732118160; x=1732722960; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R6P8AfY4fcOwCxfrbRjQeDlxc9zG8jwPd/y5Q9onAN0=;
        b=ghpiq0PrIWqh1OVvyyXaEY5Nn13/FfKlF99XfzyGs7/4ZPKy+6cd9w/OGNnxp30JtE
         rL0pLitAOBya0bl+oTAg5o9Bnilziq6Ti1hmUsYJmepy6qQ7QwxBJoa3CdbLwZBg3GGW
         QEqDFVmXFsg/IPnf75LX77e1Gz9jst6sE8lhsgQXELxtHhsHs1VLy/qi68S5Nuwt8Zq6
         xl4CJfq2focsIMcMHguezGD2T0rhcHEtwJCXSosN1fNN05r7LJS8W3hnWkXCQffYH4uc
         Rvy2vyUWUYKitnz3F8pw6LsiGCECTW9rUDJFUlz4mnp7IJglC8Q+7faC1j4P2KUxX0X+
         oARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732118160; x=1732722960;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6P8AfY4fcOwCxfrbRjQeDlxc9zG8jwPd/y5Q9onAN0=;
        b=vSg7+OD8Kqk4hkTNhXRlIWnHafV7okFwkHP7wu5r+FFbJzBZinxAKKD7deZuXtQCxu
         sZRlUsZhx8wHs2+Kjifprwom1fNk4A8k0R7760COWf/cARfuj4Tk+GQv5+4tx7HIBO+l
         Hi0ctvYB0icfm5869YkDpbCfY2UpWXFRQuqStYsKYVJbc1YrcqPBz3+qEZ2O9mET4YuG
         554rvQjtUCShVWFWXqQgF/JXvAOJEVqMow+xG3hIAuPeS1FtzJe2uBqzQKZVSD0NO0jr
         8jAk6sZPPUZs/IcT+HYWrTBTXr1EuOsEwxh2y9IAT4PBqOysw6mSat8UVsoOC8U3O9yj
         neqg==
X-Forwarded-Encrypted: i=1; AJvYcCU3H6aRkCdJujInAB1M+tsasn33xQutiE0Ii36VZkv7KRPjDw9T+DIDBL0TxA/yRSDJe30=@vger.kernel.org, AJvYcCVPCr1G4j6QY/uoJwGouG6tanWob6qExQ5ovvUbhMefMYWWmPyuv9jG3J+nihVRngYNK1Dm/toOa+XSAjbz@vger.kernel.org, AJvYcCVRMBLXVCQkrvkTqmdCxLBsGKZNeWLj2a1Ut3OHSMrnqHXZmfcNtjuLXdd2+YuVR5/QU4U+Csnh156H7nqEtIIR@vger.kernel.org, AJvYcCWLMDSt5M3bbD2XupkZssemVXL5lnZIITlp066QS8hKusCKbKUsnHcZfsrSoKyLO41XFBmmKKtQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy92rdhC+V3LOq1N/4iF2gWGYJrQlsoYhC2YQ74dKaKQ9+k6oHP
	UZ5C5zLOrp2e8+EKY9mCD/NfwMvgO9HJmh/b9JPJzXTMXHju39o=
X-Gm-Gg: ASbGncvqxEUzXocoy2WVjyvNqirUOO7Iw6K/LzheoSULUujhl/zbecw71N5YTT73Mh4
	q4Q0DjxA6Knlhvq4w8/hS1yI+rPelYRPg0rK0Kj9max68sZysOiGr24nwEMM+zpRWFHgNBF8EM3
	ol8XWdEMp0AHx9447gEGvYSrSGBA9VEkuJStzxjJSphQ+Q+7bSaXMjolcNrTpB7Kp4vrE4tyyaB
	QMu8tMj7FQye6Ce9Sg3DsSxh99aNvI9rm82dHLSiOr1Axf9vA==
X-Google-Smtp-Source: AGHT+IGJzonBm2WlVROsmz0zHJlKtcA59mQpq7ioztqJ7RR8UQOXb5AkxURIiHSzz8y8ldTiuElrAw==
X-Received: by 2002:a05:6a20:71d5:b0:1dc:bdbd:9017 with SMTP id adf61e73a8af0-1ddb0bff684mr3200168637.40.1732118159794;
        Wed, 20 Nov 2024 07:55:59 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724beefea80sm1848447b3a.68.2024.11.20.07.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 07:55:59 -0800 (PST)
Date: Wed, 20 Nov 2024 07:55:58 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Alexis =?utf-8?Q?Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 11/14] selftests/bpf: use the same udp and
 tcp headers in tests under test_progs
Message-ID: <Zz4GjuLfY8gAf8is@mini-arch>
References: <20241120-flow_dissector-v3-0-45b46494f937@bootlin.com>
 <20241120-flow_dissector-v3-11-45b46494f937@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241120-flow_dissector-v3-11-45b46494f937@bootlin.com>

On 11/20, Alexis Lothoré (eBPF Foundation) wrote:
> Trying to add udp-dedicated helpers in network_helpers involves
> including some udp header, which makes multiple test_progs tests build
> fail:
> 
> In file included from ./progs/test_cls_redirect.h:13,
>                  from [...]/prog_tests/cls_redirect.c:15:
> [...]/usr/include/linux/udp.h:23:8: error: redefinition of ‘struct udphdr’
>    23 | struct udphdr {
>       |        ^~~~~~
> In file included from ./network_helpers.h:17,
>                  from [...]/prog_tests/cls_redirect.c:13:
> [...]/usr/include/netinet/udp.h:55:8: note: originally defined here
>    55 | struct udphdr
>       |        ^~~~~~
> 
> This error is due to struct udphdr being defined in both <linux/udp.h>
> and <netinet/udp.h>.
> 
> Use only <netinet/udp.h> in every test. While at it, perform the same
> for tcp.h. For some tests, the change needs to be done in the eBPF
> program part as well, because of some headers sharing between both
> sides.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

