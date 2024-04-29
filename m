Return-Path: <linux-kselftest+bounces-9072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59EC8B62F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 21:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3879B2221A
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 19:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE6913AD1A;
	Mon, 29 Apr 2024 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWAcOLZ1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A55135A45;
	Mon, 29 Apr 2024 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420600; cv=none; b=qfjwiZdx/SZXR+K8W1+Q/u8fuUMXZ513uAoXf02fQXvIe7iKwfTmFL50yghlDMkJiL+b5lBsLH+22MtWYYRA1DHsVk1mFJRtZKV6Fncd5yE7XPPBSZzrmFqaINLr8Hthli0hsyuQTeoTvAbLe6VqoueAEGn3nNANRbwLYZgD+9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420600; c=relaxed/simple;
	bh=ugfBvgO4pi3Nerd82z5naa+ffkNEu404ci4vOpjh12Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=h5VN2i7SGlSxCpbDqtPFJDM0RXEv2S7vARxuPhc4jujRER5SvscY1d+SgATb0XUvf+WMitY+Zf5GXMJxABz3TbDAcVAp4w91UiaE4KuA85NLVAr1ZHsmQvySZKsPJXLkmXKFtW0lKJzwYXFm77lEql3c2su1trB1us7mBwkV+u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWAcOLZ1; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso4621308b3a.1;
        Mon, 29 Apr 2024 12:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714420598; x=1715025398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Qv0CSSzHoLhWNBGxxdT014HftCjhF6BCA+qFtQyWkc=;
        b=WWAcOLZ1AMjLc2mswiaf5JpdjD1YIZbDojpa5Nzq6bgJOQqrkGMX/839C/2cP7TXua
         M4rJii6RNP0xprFTK4XhzxDkGJC/U4owUEn+gyY8r7Wy7EHKqpbFAc8ZqsUlPUyL3AuG
         SZONgKoncQ/AyORnFVm6TUqMkFdcJEYXrSS9kd4HtHMIfQM3Sk553IJbP+0A82ZRo5jw
         kPFGqGcUNz3Cj5aLMXED8J4ZNxCpgQw/pHfSxdwBNaQwbS+KgfoX+HaILvPn58PjSlzf
         W/eLYQ9UobMBrGrkNAnjSo1A4PCj3Gw55FZ+6ZpHMUAG8DEWYt8dkWZiMOErtOq3z1jW
         hHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420598; x=1715025398;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Qv0CSSzHoLhWNBGxxdT014HftCjhF6BCA+qFtQyWkc=;
        b=m65JtCds9lI+fiy54TcFiKyWm128T/aHjE78mgGnWGJ6lDsSCWzgv50rgxwNh8l/WG
         JcEfjOovUauMg39Df7XkFbq2wWFU/ZZq5ccgNPm1fEMeffSE9oaRKXW5Yk+jjCkD56tF
         nA5uf2Dk64fwEhWdkOMGWrSVquB71ZHm0L/wegffEojKI7/g6+7aCG8amFGy7hdpvAzW
         qoYlCzeDPWSdPizS3tAMO9a3h+Vh9FNCi7r0w8/5/HT82DU9Bnv6M50rIXDoJzdVQkSr
         SMhQf2nRYOVf80Q88fVSP0nM+2Vl6EFVRyPOqeyjUTIsXgkFOvUPw+a0/TAilFgWBMEV
         X9Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUWWwvLlgzvya+dqZVxrcamgojd85ik5QBfE5e/MWxKf2WCEAt2J0m9HhiTxpJp1dSqzK7OW46iuPqxfQsQjBtSbQuUV7BPaTqkLqmx82JvHCjeKZv+gE2NPYJ9HgFNWmRQ3MXe
X-Gm-Message-State: AOJu0YwzqeLHrhghQGVkISfOxPQ5Kob1gtbdOXdq028BhHyQcBUv0IvO
	rXMUpFqrwzwavIYoLtT/hUMNPpyYgCK13UwpmRbfRihFr/92BPNk
X-Google-Smtp-Source: AGHT+IGGypGZsj7Ddkmjzc1ZZPnY43tASyaWPBP8S4SpDofayWG6mAhmBZvJUfMh9iv/y2HacN7dnw==
X-Received: by 2002:a05:6a20:ce4c:b0:1a9:694b:cfbd with SMTP id id12-20020a056a20ce4c00b001a9694bcfbdmr14717170pzb.5.1714420597952;
        Mon, 29 Apr 2024 12:56:37 -0700 (PDT)
Received: from localhost ([98.97.32.52])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902ce8c00b001e1071cf0bbsm20773268plg.302.2024.04.29.12.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:56:37 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:56:36 -0700
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
Message-ID: <662ffb7481640_20421208f2@john.notmuch>
In-Reply-To: <b76f2f4c550aebe4ab8ea73d23c4cbe4f06ea996.1714374022.git.tanggeliang@kylinos.cn>
References: <cover.1714374022.git.tanggeliang@kylinos.cn>
 <b76f2f4c550aebe4ab8ea73d23c4cbe4f06ea996.1714374022.git.tanggeliang@kylinos.cn>
Subject: RE: [PATCH bpf-next 1/2] selftests/bpf: Free strdup memory in
 test_sockmap
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
> duplicate of the string "ptr". Memory for the new string is obtained
> with malloc(), and need to be freed with free().
> 
> This patch adds these missing "free(ptr)" in check_whitelist() and
> check_blacklist() to avoid memory leaks in test_sockmap.c.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

