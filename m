Return-Path: <linux-kselftest+bounces-29121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C56D5A628AD
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 09:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 584177A8C4C
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 08:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644781DE2DB;
	Sat, 15 Mar 2025 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jevAfS+c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4991DC98B;
	Sat, 15 Mar 2025 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742026028; cv=none; b=C11uz6IdVQG6s9Aui2s40p1Ma8qUHd4eWgNPb+PWZ+pfkBkUTg0//HnFLpdhPu6Yd0M793cjWv/HH96kFbtjHcn3VB53krAd9toFSvmG27t/c7BMTfyz6iitppe9b1ySgZMK4qRfIev6eH7F+n7aK3LZwFCEWUIwTy+5otvEq90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742026028; c=relaxed/simple;
	bh=C5tWsuLYebqW+3y76WtKrIdRf2XYwkMQtn4K8NAAL+Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c4BhsphjSmbQPW1p8eLmj9gy8eHyfCYu+BTuX78BS4ZnuHfj4qnQ4AHKp07Qn+1Dig2CdY6CsKEbslimJtL648weG8tgeem1G4TIgdehBnN1z/YNfVdFix/4qW5vSrez+xp4SJJb6tjckQGfVg/0FsppS+tAyDac4XFG4o9kGeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jevAfS+c; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22409077c06so73144955ad.1;
        Sat, 15 Mar 2025 01:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742026026; x=1742630826; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C5tWsuLYebqW+3y76WtKrIdRf2XYwkMQtn4K8NAAL+Q=;
        b=jevAfS+c8N7Dy10wzETqOe52ZG1Iye6B/AIiqxBtEEQ4nbJzXPrbkTPqjYXinZeXyz
         7kTzsCJtzhyht2yYnCllYFfCmOkG0ajGvAUNAhjz6lbNqr5MmDQ3Oq47A0ypSiwpZkJB
         H4xVren0tDeFLxhAOxdDotyG69oQWFawFCd08ShnkH4XlbMCfH5CNPg8PDUVQC2Lub7z
         SpBIJcjz8k6QqfEfmj29ZYfxFeYFEUtqQt8Ah/7pn/TiqC/R/S1BoE9MatdQwkw/Rz5B
         rsLmtRQVOeZRPdvxsbRfc8v8gs3c2KwwphNGwwSgLRcaS+gnZJsZ24qoz0iZkT9tH6mw
         UURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742026026; x=1742630826;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5tWsuLYebqW+3y76WtKrIdRf2XYwkMQtn4K8NAAL+Q=;
        b=JIjG1OlY/zbQvnZSSW3U1QPLWaTchm2VUlk4yOzLTzxEeGObHg+/WeXiEpbNbDvB2X
         d6FpB0u0Wk8esqpy+oPbEwV+lnMaSmxPzVmh86mqZMRwVGTFsoq6UGQ38Ntx6EQgYT/i
         OEDJ4Cj3dpo89eWYMCfb7qCRq/7xTIsdsG2HhwpdtX5kXxUgVV4oqasJ/H0EpNkTMjDQ
         6Z4t9s1DyCK+2xprGZsPuAGVupYbhar6/9Ywo2mVFcrmXgb5MUCj3udceZBqR4Vy63bN
         yooADZfsxcXrxkhoOq5z+cYOaqmti8Hwk7O2SJL0m6sXubvWjHXXWkMx24nKj+yOU5uu
         ZT6A==
X-Forwarded-Encrypted: i=1; AJvYcCVnGi1vK0kGCGSHvYUnNTFNdzcJlwlav6d1IYC4d7hr+gakNDq5nY/HEOHWN9JbyUPj6GH1EfU2V9fokdgQ@vger.kernel.org, AJvYcCWzPBVdHEWzG8Tkxi/d+huE06EbyGL6sIW64RDxhyRPkoLR02Xn+bniGJQ788QgWFkz8QYgOC/ctp2bwFNOS+T0@vger.kernel.org, AJvYcCXwuDHci425dim4JmLUy/l1/dopm4wDtMDVo2usdCEnbmhJ4swYvsP8IlbLJ5KQv/ie9OU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz67gd6hQ7hfK1RHGUcVeiCfdTnCmThMjCbKGAWF4n5ozQvDkOG
	NKNSsHZYoUYiiduqVn1U/cpwd/bZgX67yV6NoUbELBlTVAicc8I2
X-Gm-Gg: ASbGnctSUw31Z5u4dJ/HXMM8KsvPM717Bewrzd+x3vUkf3IEePh5o4pia6Lsx4/CaU+
	theqamTY95h0EMVQUMxKE9wMoSnXkqQ+39tqZRpz14xEJSTVHms2wY0p8zndNhpto+YTDEWuVXW
	vkflrO5tXKvQ8OaQAMKdDN3cnD7JK0rmrOEC60j+6iYVodVfHz6vqqVg1WcGWMua+Ftgr+S5N1N
	VZiqvw9E6QyPBU/8/YTkGtqgxN4awRo38/CTlOqxE2mdTLcgggDLTuMDgusJVOLnMVOVTt/mIEe
	b6hORZwxEAaqKNamAbMXF1+KQij2uHBxzpP7cojR
X-Google-Smtp-Source: AGHT+IGkNV2xTO9dQHlWSeyy/i0XrYakerLhhNGAIMLNT4Ti+wVWJjCGhEhKRAxcpm1P6DPPcR4EQQ==
X-Received: by 2002:a17:902:ce0b:b0:223:668d:eba9 with SMTP id d9443c01a7336-225e0a15945mr71542395ad.10.1742026026102;
        Sat, 15 Mar 2025 01:07:06 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a80e3sm40085605ad.83.2025.03.15.01.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 01:07:05 -0700 (PDT)
Message-ID: <46a0770582be4f8f80701aca4eb17b1706609033.camel@gmail.com>
Subject: Re: [PATCH bpf-next 03/11] bpf: Return -EFAULT on internal errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Luis Gerhorst <luis.gerhorst@fau.de>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai
 <xukuohai@huaweicloud.com>, Catalin Marinas	 <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Hari Bathini	 <hbathini@linux.ibm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,  Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman	 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Mykola
 Lysenko	 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Henriette Herzog	
 <henriette.herzog@rub.de>, Cupertino Miranda
 <cupertino.miranda@oracle.com>,  Matan Shachnai <m.shachnai@gmail.com>,
 Dimitar Kanaliev <dimitar.kanaliev@siteground.com>, Shung-Hsi Yu	
 <shung-hsi.yu@suse.com>, Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, George Guo	
 <guodongtai@kylinos.cn>, WANG Xuerui <git@xen0n.name>, Tiezhu Yang	
 <yangtiezhu@loongson.cn>
Cc: Maximilian Ott <ott@cs.fau.de>, Milan Stephan <milan.stephan@fau.de>
Date: Sat, 15 Mar 2025 01:07:01 -0700
In-Reply-To: <20250313172919.1103397-1-luis.gerhorst@fau.de>
References: <20250313172127.1098195-1-luis.gerhorst@fau.de>
	 <20250313172919.1103397-1-luis.gerhorst@fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-13 at 18:29 +0100, Luis Gerhorst wrote:
> This prevents us from trying to recover from these on speculative paths
> in the future.
>=20
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> Acked-by: Henriette Herzog <henriette.herzog@rub.de>
> Cc: Maximilian Ott <ott@cs.fau.de>
> Cc: Milan Stephan <milan.stephan@fau.de>
> ---

Same as for previous patch.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


