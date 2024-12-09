Return-Path: <linux-kselftest+bounces-22968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B51B39E8B2B
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 06:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB3B188577F
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 05:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AE720FAAF;
	Mon,  9 Dec 2024 05:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C06ci2Cm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D24120FA99;
	Mon,  9 Dec 2024 05:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733723420; cv=none; b=W/Ve4gWomUtY+uf8sL3pLMPHAaskOXMqK6QRdHAL6bP30zdUxMK1ElmwkJkW4tdUQ+KRAqvk5z3we7KO5AHnIudcOzaUxghWK7bPLOzjbZqyLLZPl/Rx4GzAH/Dfgiy5EBiqGsQ+hBJnJiKZBKB+787WcUSXWOgjJQ/45lVnBGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733723420; c=relaxed/simple;
	bh=Ex8UPG6CwAQ6xUsLWGEkaQPXLJ0yfO3PEJgWAw2xrZI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PAaqo6avbo9aUBnbR9UrrCq3qgZ796EDtUbJAe223qnQyjPSklwgPfgzvVRYSrvl/YTi9eBZJnv/P9LmvgjE9YRFg6uMwa4p0miisdod9iYT4LAlHNDgNtX5dZZzKPZGx67IByZKGydjrh2WVtJIRPMotlkvk55S8Q1E4J4x1ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C06ci2Cm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cf3e36a76so33964765ad.0;
        Sun, 08 Dec 2024 21:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733723417; x=1734328217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9D2sckr5O/tHBe9aJUjYE0OKwXCJIknFnRJ4CB/T3Q=;
        b=C06ci2Cm6VAHz0h4gR4ht/+2KwTRNz6chRm8NewL3Dju1rPKKhcuuZOqiccBEwHOIy
         I2XUr9GZO/0wSAeYzT8EUipa2f1yQerl2Xs39BTf7lXNDRvkUAmG5Vn6JuraFZxaE8Ry
         /ep3UOzV0OKj1548VpQ4DdOUHOM8AHVIS2I4XW+4s8G5aTeISIHQKdOyRzkDHNcWWUDT
         8HF+fP7y67hbgVPBlhnLRD7TuoDfqtZfLew7JEsbolVkQJpX47kXZ97Bj7NKqKNLyzQ2
         hkcvl+r1MqIeAkgIukRsBs2SF9xsyIJQ0uBWjv/2srX39z595BHs7e4yXlQdmcQ3yyW2
         FTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733723417; x=1734328217;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C9D2sckr5O/tHBe9aJUjYE0OKwXCJIknFnRJ4CB/T3Q=;
        b=tycREdb6q/vzu30q74RSokAGMbJoGmBc5GdOhYI5cpcFWsDA4HMdAcRs8wRN8KTOWs
         uNs0+F8lqOHLwQ+DhdU0NSWL/5NN/HPcnRl317mfY+bp+Bz1KtCQfDlmD5qVWIofocM8
         5DHQJYxYsWCL1GQaxxHHEZKxAYNLIVQFGWg3ZTdiJndDhwfi2n5isHt3wDJFSWiLzSxY
         zGoY1+JRXOmFS3BIV/B2fn4MvzuIM0tfL5WsfGRSWwe74vOgc7tS4oT8mDoEByaPfO56
         zLT4iUzEMYSxypTW1d6Km6MjKikSIxaLrE4rl19jrxjoqA1kzPHiEG8EDqoRxI1dpqu6
         V5UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl7GuilVk/aQJSd0OO3QtStgX6kiJPyXkv74lCTB5EYX7yYiyHrQaX5VHZlxU2Qd38X74oqnD4@vger.kernel.org, AJvYcCXS5YAaVuIaJEKJjZ3007r3sRMzLTNYRCgILoQC8YQaaewlwOJVPSz+TFIXJp6cs+LIbqz610lNbPvmOpGmXQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzEY3leSTjNq2fCBV8uRB+05Khfm8sn7lmqzCt2wBaPXlE0OdW
	EmWpsMvHjvr+tE2IWuy/Ba+3MDRgUPUgTv4WKjEz4RmqVgEjPRemi2marw==
X-Gm-Gg: ASbGncu0hcwTncDgdseFySLO3fszGS/ldmvHVBRrh+BSjfEwnBHy3bNuRWEwi6HQgcN
	eHVlGy4PsiJQwBGXirqi3jRePvtF4gkq7JK8hozoXEGjCV/KrEQHA3keCuj2Nx0/T/ucEv0kAHE
	xIXk9zAjTFB+S+SGl8R1dg9lfmH5x3JpsSefnvif1KQx1Lm/4shQo/KMPEYigLO1G0RFVOvtL/t
	JCFOj8zK+0P8uU6gAf0fuFj+r+0XxVtBaqbxstsu+7AV3PAW1w=
X-Google-Smtp-Source: AGHT+IFheNWKW2FH8d0p9eycnLA3MBLryQfKMlDkEhW+W4ofgLSZvs8W1weJ6uxWSQycMSDfUc1+fQ==
X-Received: by 2002:a17:903:138a:b0:20c:9821:69af with SMTP id d9443c01a7336-21614dc5115mr161081525ad.45.1733723417557;
        Sun, 08 Dec 2024 21:50:17 -0800 (PST)
Received: from localhost ([98.97.37.114])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162e519f6bsm30642815ad.30.2024.12.08.21.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 21:50:17 -0800 (PST)
Date: Sun, 08 Dec 2024 21:50:16 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Michal Luczaj <mhal@rbox.co>, 
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
 Stanislav Fomichev <sdf@fomichev.me>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
Message-ID: <6756851812aa6_1abf208f@john.notmuch>
In-Reply-To: <20241202-sockmap-replace-v1-2-1e88579e7bd5@rbox.co>
References: <20241202-sockmap-replace-v1-0-1e88579e7bd5@rbox.co>
 <20241202-sockmap-replace-v1-2-1e88579e7bd5@rbox.co>
Subject: RE: [PATCH bpf 2/3] selftest/bpf: Extend test for sockmap update with
 same
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michal Luczaj wrote:
> Verify that the sockmap link was not severed, and socket's entry is indeed
> removed from the map when the corresponding descriptor gets closed.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

