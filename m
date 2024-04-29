Return-Path: <linux-kselftest+bounces-9073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7048B62F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 21:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602F2280E38
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 19:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27CD13BC0D;
	Mon, 29 Apr 2024 19:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHUY/Jqc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64198135A45;
	Mon, 29 Apr 2024 19:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420660; cv=none; b=QpZF7Dym7qdGs7e93kYqlT9JIRKTBKme6ONEnq/Q+mFGrZN3snogWgsjwnDHZzGnPzMUxYMIIr6H4ueFFsekLcp5gJIJMf2HJI8b9J/xpMeZt9VoE9jf5REEBENfjPyRRTKjSVH72GdfPRuT8+Cxvxkxaa44lXV64Fzga0VJ8Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420660; c=relaxed/simple;
	bh=oMLyqDVxjzf+KQs2trfe4pMgfAv1EvAYu0VVeyrDyk4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Gn6PIMRCXMYhi1n+PGcotf3LZLZyK1pdYeh7hR8KAYSkCdGutAOJk4RoaZ97ULesCzZgVrnLXobWjlq2Af4irz4VQphob8Ss/W7kaV6OnTm77axGjwthoTW4PPfOL3qeZcyhQWMR9hQh3KwzFbV6E/O/pZdG59Gsc31h4ZWHviI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHUY/Jqc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e2bbc2048eso42747715ad.3;
        Mon, 29 Apr 2024 12:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714420658; x=1715025458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqUQXZ6RB2jdeJ+731dZ0CFm/c/d9ts8vyU9b8aiHp0=;
        b=HHUY/JqcqiSDJZYedPMqz8kyuBEC4Ano/l2N+sCP8r6oC40Mkz/ISb/zrlNpYEktq9
         vAx0NAko/5INOA0MvxkxTG8EuMGyzahWgDr3OcMas1wBf+fphoCaZ/z7URls1CaA0OYe
         Oy/ng4C69EHqa0GTWc18QGlIzdU0Y35fKm2D3soYW0WXMN6dk/XX5VDpFtrLLnnPuRxO
         VNI2sP6isKLcUAHN0RlxU4n1AP8wTCMnoeuAXcCeb6ZPm+63cibsZeOqi+eL1Tf+5yln
         M5cOUV4Kw1jJOomFeKQeEWMHby4rBj1vxOVUxOhNvlxe2Oaww6jMXjRVUtvb0GEFwnyb
         PoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420658; x=1715025458;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xqUQXZ6RB2jdeJ+731dZ0CFm/c/d9ts8vyU9b8aiHp0=;
        b=MumwtBw3dVp3WrQABPSYHfJp+XCoITiDuKV0VOgP9VBeipHTQn/lJmlixZ7bYvHSAl
         tdnSiD6V7JoHWhYeehsFshuaHAX3urwnEAN86K7Y4s8RaFUW8eFjgG1PUvxJbMZZMWV2
         P41fuB+NddxgMmTGwzZ7tORgf0Yjczj7wsjSxF+jIyMyhXE9ayEkql9hug2rFsXjigIA
         6lxed/ujPA3Xdji0huAna88jKWs3L62pEAgO4BA3Lo0iib7XOYg5WsZVOzu5edWUHSDR
         zg1B4beoXlQoQQGro9PINWMEUH902BaHdCo7K2gi7vO4NSpqCBkIUK/Lf+cRSqvwRQEp
         Pzfw==
X-Forwarded-Encrypted: i=1; AJvYcCUTUgdlevuPGAyI9IuPNie9M6fjyI+Gyv5NxJ4+ksMfBXtx2Tnb8ey/O0lMz1otae1BIlWrA2ZiWBDxQxESmfCG7BrFKaEKR1gxFBde7TrJfzr16pPRCqa+gAyL4WnPxkNnjixB
X-Gm-Message-State: AOJu0YwEO1St+uI9gxRz/UJqvrWkNvtTBAMJF7Zjscm2XpwSAtwGRnJX
	5yp3EYSuK4zQi+HsdPhkF2HC7gulBelBcF56dmUotUXH4w4m1ebu
X-Google-Smtp-Source: AGHT+IFImlrBmzVtEPGSc+uwUOwkaL06nmdLgDstTA1iWy/QUEsROc1TnCTsI8B2kehvyn9uDBG+ug==
X-Received: by 2002:a17:902:d507:b0:1e5:57ac:d402 with SMTP id b7-20020a170902d50700b001e557acd402mr14947406plg.63.1714420658598;
        Mon, 29 Apr 2024 12:57:38 -0700 (PDT)
Received: from localhost ([98.97.32.52])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709027c8e00b001e3e244e5c0sm20700539pll.78.2024.04.29.12.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:57:38 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:57:37 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Geliang Tang <geliang@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Geliang Tang <geliang@kernel.org>
Message-ID: <662ffbb148ea0_20421208ec@john.notmuch>
In-Reply-To: <ded44f8865cd7f337f52fc5fb0a5fbed7d6bd641.1714374022.git.tanggeliang@kylinos.cn>
References: <cover.1714374022.git.tanggeliang@kylinos.cn>
 <ded44f8865cd7f337f52fc5fb0a5fbed7d6bd641.1714374022.git.tanggeliang@kylinos.cn>
Subject: RE: [PATCH bpf-next 2/2] selftests/bpf: Free strdup memory in
 veristat
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The strdup() function returns a pointer to a new string which is a
> duplicate of the string "input". Memory for the new string is obtained
> with malloc(), and need to be freed with free().
> 
> This patch adds these missing "free(input)" in parse_stats() to avoid
> memory leak in veristat.c.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

