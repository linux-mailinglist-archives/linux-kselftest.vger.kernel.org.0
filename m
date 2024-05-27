Return-Path: <linux-kselftest+bounces-10732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74E28D0916
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 19:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460D71F21CE0
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 17:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5DA15ECE0;
	Mon, 27 May 2024 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cK7wOu/5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7277F15A870;
	Mon, 27 May 2024 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716829414; cv=none; b=I6TAjrsWKuDKBCcqKDpLbvQAlq36aZIeuDq90SdCIXk51iMVN24FQW955XMCj+vpFJwgboQ133MjLhLl8jzU9cYWMlmmgqX6R1N2dSwNuT0tikNifHdJeyN8mjVsAbBl/Nu+s4v9aq4QZ4dRjfAdya4u+k+pdS93s1rrDXOyJIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716829414; c=relaxed/simple;
	bh=cypR+g0zFhtE7zY1PMkxYKKwvS5VxOe4Z0SwLJHhfhc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hXLf9hRybFDP3fyHnNunVus5o3LyAbW8yGjKCvyvihh3hdGUyV1sCN0dUSgGVJra4OQsJFb698wTjIF87PqgavzHObAxbjgdg9Y1TWcJHf4/gZO1ElM00/ZpdzcZX9cyGrHwLGi5bgH5z8oCHRnc6y0peAIZfGqDKTgbi+P//tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cK7wOu/5; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-68195b58daeso20739a12.2;
        Mon, 27 May 2024 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716829413; x=1717434213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2m1zWh4PmcbbQ/4vQeWDTlVzAcYxn8TniNE0ypJ7ZkY=;
        b=cK7wOu/5+fZ9QlA4+lGs6Vp3LvU/whsGAJh7MCIlWcpQ/s8OOmyHRjlRxlPbJpaKUy
         CM1UMfFMtOXM8ZdDMBryeiNEoBelzvcG726g7Qka8ZbBSiJx6qdkWBiaCN6SCIdGEz3C
         AJeDDW6ygAm7pdajp2fmHyuVGtDwzV/kd6jNWuBvllyZ/0/tXhfO/wFRmmR8x7NQiH+X
         hsqpUgnNy6JxWSpugHqP4a8jUSEgNO9qwG+CwtYFnegBCZBv1f5SQnStLUX4TSDg82lQ
         K6sPuSFVdsKrxbhsJxj5GbV6gmz3oUwIqS3N0yKaUZ8DIThl9KyafN/cOWRGsxBp2x1b
         VKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716829413; x=1717434213;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2m1zWh4PmcbbQ/4vQeWDTlVzAcYxn8TniNE0ypJ7ZkY=;
        b=L0/Cd6E3LTpqI1oWFU0EXWXj7MAeXey+Lzz/7SvwxO3F6zWA5OgdbyxDqscGZ6iQ9L
         V8K2NPWxMHKwFUuBsEjbmU5msC+ISMDwaSbf85v31IuRDxvFPLNlLdz8iRZWHNTPJzLv
         CEbZ5lxbrCoAE13hwP+LCbIAgokiTnGDhqb18zAmx1cWw558i/wcI64eMENGPMhATo3a
         AuAXxJSDluFXZpP4DRuGwsXUvMlmaI3eHFn40I5uv83/I9pesTUTCRey2kg/UE4cLw/X
         tS6swEtBUmbOkjYt9nOGCqGhwejcznFkAMM/aSuGSObFoL4WJdB8xRgofdmAjFfi5jdk
         M1rA==
X-Forwarded-Encrypted: i=1; AJvYcCWr3CgtkFNkJf5uwCQsOxeJaBh8DXVvMAZuuLzZ+WIxpBA1dxghxok6gjYnNgCrYy0GaE5/A8Zavppbn9KLtY8pSU5cI4Wz6aJT3wmkXhFdSO+8/3GQNke6KnMPbtTSvr4rSlPL
X-Gm-Message-State: AOJu0Yzh+ddBoYTMYrFi2H85SBH7uRd49baPP75isVJnzUnSQl0Piymg
	b2pWcYVDdwILFm6bBN8VbKJajMCEj+UmMW6LBqAYvFv399n+Yfk+
X-Google-Smtp-Source: AGHT+IFKfq+H9+x0YXQkHE+EojBqtVnPw7be5Ssr/5SPLjYAKXj+rVlue01t0WiGUA6aOay6Y0O9EA==
X-Received: by 2002:a17:902:db11:b0:1f4:5dc0:5fe8 with SMTP id d9443c01a7336-1f45dc06337mr99021015ad.15.1716829412633;
        Mon, 27 May 2024 10:03:32 -0700 (PDT)
Received: from localhost ([98.97.41.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c99d8c9sm62984535ad.214.2024.05.27.10.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 10:03:32 -0700 (PDT)
Date: Mon, 27 May 2024 10:03:31 -0700
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
 linux-kselftest@vger.kernel.org
Message-ID: <6654bce339d08_23de208fa@john.notmuch>
In-Reply-To: <8d690682330a59361562bca75d6903253d16f312.1716446893.git.tanggeliang@kylinos.cn>
References: <cover.1716446893.git.tanggeliang@kylinos.cn>
 <8d690682330a59361562bca75d6903253d16f312.1716446893.git.tanggeliang@kylinos.cn>
Subject: RE: [PATCH bpf-next 2/8] selftests/bpf: Drop duplicate definition of
 i in test_sockmap
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
> There's already a definition of i in run_options() at the beginning, no
> need to define a new one in "if (tx_prog_fd > 0)" block.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

