Return-Path: <linux-kselftest+bounces-22708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E424D9E08D2
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 17:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D15165D87
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 16:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0597917B500;
	Mon,  2 Dec 2024 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUtlshLS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40DD13B797;
	Mon,  2 Dec 2024 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156339; cv=none; b=TPEty/yva3IdFecVSZ0x5DJO/DQxdplJ5h1CCsgalm1Z58GXxxLfYsX3eiZVeOr5aNLWrE085vKhcIn27sEhHtJ5itub/rajYxNczzyrVM6v3fdTkyEWDkA+cJif99AwE3ICGqMYwZENDpjUtuh7DdXw3ABJ9bZ7rEmzQnuM7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156339; c=relaxed/simple;
	bh=qfIaJ4ShSCmpqUV1XleP9ul0qvjJ8F7UcMNkf7an9qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTEg2nbnvgw1hYvmC5ZcCqG4i0eHEuLx/VrUxw2kIE5qulgn4+lngJrKhpMAyMpqa7inVT+bFGz89uL2uNECUiZ18SXZVZTSV1hg4iuce/sQkkavcnriKu7TEqo6f9cqYYaxBlirgHeuFlCBw9dQ+OXo6OlHQ49wtV638Hr90Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUtlshLS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2154e3af730so22581015ad.3;
        Mon, 02 Dec 2024 08:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733156337; x=1733761137; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RsOuljns2/quAly2UNcpAnHyOi4kXlWKKxpMymqaib8=;
        b=CUtlshLSGXZXVtGz6cbWh9Pp9df+PjwLBVhd9aY8PkT8XpU20bo0sN3gt/+otNomB8
         qPTA/k0fKLTuyhb1WfhR/rjgxW3K31012OKEb4wLusvTasO6UyzCuZgL9lD0HO15QkiW
         CoICCE41G/gcdUbs3R3ATihfSZz39agX74PTxwjvl7F6llWOZTg5Tu3NHC7QxBWvBnRD
         jD2uYDhsA1FjEvBORfR0xtKSwSaOwq4c62DZ5WwmkQAqTBOfSfbsfoUL0RvuFgv85+J/
         1FE8MTNC7VdyEymvvzmMwzB4qLpIofZpfh11nHi8UXB8NFuSig+SI9EVFS8ChGPImGjO
         m4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733156337; x=1733761137;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RsOuljns2/quAly2UNcpAnHyOi4kXlWKKxpMymqaib8=;
        b=MaWxatgOSei8JI8X52qFSRLlY0WbX5L/xArx/hfnj85fYH5yoh+yQ2vfyTVs0mMsHj
         ZlUXscPs/KKCXaCaMQrNAJJ1nhMLNOqGZkdev6AzpZ1+NTjowLOi//PZQ65T+Ai2YElR
         1iGcMFLQtTzGCiulkaUbE1q/gEe+SNwYUAhHD++aQhS1gwA/kJ0zHcGUj/Pad3AtF/xM
         399AVoWIY5fflPOkR3u5Ft7GNfHiEtpQqSBSJ7Vy/BEOp0rl7v9kr2vFbfXQ7yXKzs8Y
         OzG01fGtdOXBMG96kFVOqMeVWSDDvGwbO2u1A/9WzFA5qiqRKQCWNlAh90mNPGz3El7G
         QdMg==
X-Forwarded-Encrypted: i=1; AJvYcCVDg+f4b2CNO9u15A/pQznlM8HLkAu4T9ZhKzxpx2lxQryZBlJOU16YzQklFEFLSMlA3XU5CW3plgBkun7E4dJC@vger.kernel.org, AJvYcCVTzSvD+8HQca3kUowu+7BB9Gqz9fimUaPmb8zDGDrgYAnwdLCFRdwVFdr9tt95QeHvafQ=@vger.kernel.org, AJvYcCXKVLJ+uMSI44dr1Vr+89HqYKe1Iae79hIelsc6CUBExNgIuXcrh9kLFAwlfKpK1yL5VzYF2LgWjAWU3Cz1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq/l26FXaXJm5HXg1sYnotzqZ0eq6yo5rfxk1aOw7AUXGQ5fwE
	6dkoP0TYHCBR8ra7qlDcs0gFHXO8R0yL6gYNty+mHtcYGI6yjVA=
X-Gm-Gg: ASbGncswWTejEr5Fz8MTKvN7QmfvZr62t/Z7Vi9o1D6e4gdfLUuWzvNB95CxqDRIM5x
	w5beyu5PhnNCb0e+9L0OyiLGo5Hp6epNgiqg0FEvMAWhV8d0CLNQOmXMiERmLPQsGpyQ9olA1KL
	Qs36Naq+PuHE6N/+yv+QMIHZ48fOfXCL2I06FjOoxRPHQrO4XUk5Jg30biF78ZAR8CBYSEzrOyK
	4NJx3A9g30x286tHCGk71JrtuER8FOEzLw0+DpRUkwW0fEhMQ==
X-Google-Smtp-Source: AGHT+IF6AZPwROzlvBT9zSLGk0RRa3aXEZ9DLjEW3tv6xUKcm9Fkbfb3twVm1UvkwajoSg03oGZGrg==
X-Received: by 2002:a17:902:d4c7:b0:215:86c2:3fe0 with SMTP id d9443c01a7336-21586c242f4mr76817585ad.38.1733156336999;
        Mon, 02 Dec 2024 08:18:56 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215413d0579sm61600345ad.133.2024.12.02.08.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 08:18:56 -0800 (PST)
Date: Mon, 2 Dec 2024 08:18:56 -0800
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
	Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: ensure proper root namespace
 cleanup when test fail
Message-ID: <Z03d8FqVOVZJhxMu@mini-arch>
References: <20241128-small_flow_test_fix-v1-1-c12d45c98c59@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241128-small_flow_test_fix-v1-1-c12d45c98c59@bootlin.com>

On 11/28, Alexis Lothoré (eBPF Foundation) wrote:
> serial_test_flow_dissector_namespace manipulates both the root net
> namespace and a dedicated non-root net namespace. If for some reason a
> program attach on root namespace succeeds while it was expected to
> fail, the unexpected program will remain attached to the root namespace,
> possibly affecting other runs or even other tests in the same run.
> 
> Fix undesired test failure side effect by explicitly detaching programs
> on failing tests expecting attach to fail. As a side effect of this
> change, do not test errno value if the tested operation do not fail.
> 
> Fixes: 284ed00a59dd ("selftests/bpf: migrate flow_dissector namespace exclusivity test")
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

