Return-Path: <linux-kselftest+bounces-45579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE15C59BC3
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 20:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14073B5C9A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 19:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A9731AF34;
	Thu, 13 Nov 2025 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggaObx1e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF8E31A7F1
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763061700; cv=none; b=ktEpkPJLBBCXvW3pqTUrXawTSIoUGjbSaJLreuGlyHJVW4DY1bN8eppyCjXoJc8yEBiWLXK/kyxVjirXsgjjpPKbIyiwnaeCd/gTOHb69lErHV0PEizvN43Gr1/hdzNu79JAfgue5BkFtvcV4D6kjVPGFEV/sRQLI+ByCIidgNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763061700; c=relaxed/simple;
	bh=AYtztYVup5T03MHn4c8xhs3DR93dO970wpen2NEDUfU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OnFotjUkc/FVBQgCkBh1ydmlrStHF1MuE3xRTUZWYDMmBHskg5qVAPru9VzRn2ydcEgVVGPOsCE7Rni09ARtWYZZ/VkUPLRt1ChNJlvQBzcIi3OilxTvnJ+wWadlzKj75MkEn3YtwHhCelQm5Pbv0UgvNcjoQViNm3peQPRD26g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggaObx1e; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-782e93932ffso997408b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 11:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763061697; x=1763666497; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TJ6F75cdyKPn7EP37WUo29NbKa0V6/VXv3lYpIW9bQY=;
        b=ggaObx1e+Dnm3LeQ+DxSUVEucD1A+2f75lQ5Qo6Yjl7CGbcnXvJYMWtAKbi4MFKEsr
         s9pN/uW8tWUWQMNkS486HYxUtjgWDsSAOoJ+bDs4X1S0lsafMXXfVCayQghsjLWJaxxe
         QsVU1nfE8gnKcO18DK95IQ4XxcJz/qOYo+F7g88RX9r7S8ZMzhiYSERMl9k7LskogFq/
         gkO5J3WxfXdCN1lInW+mYL4rt8pj/FZPrnacnGxnCkSPdlhaXRi8BYglZ1TNvNCvQsp8
         D7qw+ghSKRuELPOgM1izSHe0bYSP+9Z3XTiZR8IHSyw4O+NRAM5jlutf+JYZbjWeL8pG
         qt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763061697; x=1763666497;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJ6F75cdyKPn7EP37WUo29NbKa0V6/VXv3lYpIW9bQY=;
        b=M5Md2PDeSYENQ5aqYqEqqhoec1qfKDUz1DC6a2zpdhGLerwQOOU9AWK/LfOzr/M432
         uW7juLjQwQciwZcmFztjz0g4xXUjVYvUcSUP7iNGADPNrZXeul8Lv9SRcRp9ixP2OnQj
         T5ycZ0vmA8NDXEMQvUCIirSs5zx7INQLWfwKV0QHThMSj1mxsFhAfh9nvhpWk3R49jcB
         q+ZoQ1ExqyA88tutJfM0sfccSWaJ0ENb9714fd4EKb1E8Pl2NzvNvj4jZQCJCmsqnmbb
         wbFdes5fWiBqooyDNTUT+OjlsOg7xNOBpRrqvTk35bZM+6MLEwhhRBOhQaGagMBS9Q5y
         gd2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBy9yeiRF3owkpST0QY3wUyx7uZAqcmd8dmTU2yqsw8X3qszYbNzpOxjy2rO/y2L9eUDjB4l15I6GNXnmHOik=@vger.kernel.org
X-Gm-Message-State: AOJu0YySH2Hrd8KAWFfjH+LCu9Xy7Xj8zCvCQnt5oM64R09002ktjAgY
	uUbcSuWqbCAcAsLb/woIXdwNvASNCKnj3smZPm1V0cax7gC1v5os9aBa
X-Gm-Gg: ASbGncuXG9e5Jodd8XLP+qZr2fyDV2o4n1GzVhAvexFXT4y9hexjW5/VdqbEd991004
	miUd/I6faqP3GN3neC7k5RlHrnz8SjYqj0l0CEduKJTPyRoVNj+cJkl/0/THv82hPo1ql7r9w+3
	nzXxWWpruET4V1uLHe7eQ8xchKNNPf17xziMZVC4J+DRJxZhdpxQ0yPeY5UyvwGRdBzGhxcPO0U
	W5ITs2BEARat3xgr59G7DWkQGNDZNHnqgOWNVIaqoFDUdd/RQ3hBWOc1ZIqIy04EGu3uqv9SeYZ
	sKJecHPKl72U4sJkimTEwRwywvdhKMC+kfjauHxk4AfFw12Zk7mP4K7sT2/zLuhpTSa86ve4VyX
	sEiVD8rbyeVx8C+QXQFd+v+vjeVoMDFcPqC9czvgkGC2rDdJX252G0AOMuWKhXt/bgJ7/9Zgu6l
	uWtgJvI9UV
X-Google-Smtp-Source: AGHT+IErLkIL9gN4gIwgNJG1OhCmBNwlAbpLnKJJ9UX1z6We9W1weijWSJmhBdP/H/gc1C/6rybrkw==
X-Received: by 2002:a05:6a20:9144:b0:341:c255:7148 with SMTP id adf61e73a8af0-35ba1d9c626mr927853637.28.1763061697417;
        Thu, 13 Nov 2025 11:21:37 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc375177be4sm2870160a12.19.2025.11.13.11.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 11:21:37 -0800 (PST)
Message-ID: <b092107702eeb245424e56907ebe9e830ce198d8.camel@gmail.com>
Subject: Re: [PATCH v4 2/2] selftests/bpf: add BTF dedup tests for recursive
 typedef definitions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Houssel <paulhoussel2@gmail.com>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Martin Horth <martin.horth@telecom-sudparis.eu>, Ouail Derghal	
 <ouail.derghal@imt-atlantique.fr>, Guilhem Jazeron
 <guilhem.jazeron@inria.fr>,  Ludovic Paillat <ludovic.paillat@inria.fr>,
 Robin Theveniaut <robin.theveniaut@irit.fr>, Tristan d'Audibert	
 <tristan.daudibert@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,  Paul Houssel
 <paul.houssel@orange.com>
Date: Thu, 13 Nov 2025 11:21:34 -0800
In-Reply-To: <9fac2f744089f6090257d4c881914b79f6cd6c6a.1763037045.git.paul.houssel@orange.com>
References: <cover.1763037045.git.paul.houssel@orange.com>
	 <9fac2f744089f6090257d4c881914b79f6cd6c6a.1763037045.git.paul.houssel@orange.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-13 at 13:39 +0100, Paul Houssel wrote:
> Add several ./test_progs tests:
>     1.  btf/dedup:recursive typedef ensures that deduplication no
> 	longer fails on recursive typedefs.
>     2.  btf/dedup:typedef ensures that typedefs are deduplicated correctl=
y
> 	just as they were before this patch.
>=20
> Signed-off-by: Paul Houssel <paul.houssel@orange.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

