Return-Path: <linux-kselftest+bounces-10733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 162A98D0929
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 19:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483DD1C22D74
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 17:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C853B15DBCC;
	Mon, 27 May 2024 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIxa8lo2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416D813AA5D;
	Mon, 27 May 2024 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716829574; cv=none; b=HOnLh8B7UiQ1bF75AIjRsNOS/rBVXgONHMBIuo95Fh9r98USlDrlNW0wVEnpmtWuzUMTCTlgqSo+6senhecKjnjpWTlx4us5KDRDDP8kvvB+At0JBqzw0gOHJzCQIP/Vu/HxF9lHxgrgKSDDEnKohsdKEZQArpuOkctsBHuO8ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716829574; c=relaxed/simple;
	bh=84eamenJgq4A/tn+KTdRHZthoV+N/4TniRmCmMxKp7M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NmRYw1SctH+z9ZK24w3xYOdsW0EJbCijShBCZnMKnc2YzWEe1RNujywEm1tR+s1eHV3pp9ClPmm9UOujHfgRElsagf8022fu+VhUaAhFrQXlXDrk+gSOiWVadVjIMgtmpOqUg0tK/qtI+rYsevk5ZK1ynYA1v74rcWwDNHHstPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIxa8lo2; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f8edddf756so2829468b3a.3;
        Mon, 27 May 2024 10:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716829572; x=1717434372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KlPAPiPcrB2pTgoNpsEEQCKvARESjKoFXEF62SyU14=;
        b=mIxa8lo2FZnogP+FOebFFoKU4KZsT8g51kqnoNb+PuCaaiiumTwX0j7Zkiacan0uYp
         m40C2ulEWLAQVQu929rBlLLSXgxXKKXH9K1Ifw8lVaI+xzJ58fgxQiVb9C0MdtY6HPai
         /xEiWfafsYJFHkaL+WMfKIEp6g6+uHZr2Pe8NKsSC6kZEH+Ar9lAyWYWTC6exgfFp6Tv
         aio7gZOImUig3/Rsnv4Jnt5uPoVntDf/ldKWcmKzYgqiW7t1WdSXYU2oYp+4GbaSOYXG
         Uov+UjzZlRzB/B9QMJBr3WWMvfhABzX8Eab5aNrZp9BxFXH6CM0s5s93xLf2002/ShaZ
         Ik6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716829572; x=1717434372;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/KlPAPiPcrB2pTgoNpsEEQCKvARESjKoFXEF62SyU14=;
        b=vo4eEZWEXNUH8IC7uJVUwr+idxgi2oh7uuWjqkpDwT8G45uyLWqHBakKY+PenAHl4R
         w7tPBQqR9/6Ea/0LO67QT+2XLh/moJ4hf8ijrClrv6NitmGTtTR+Q7r9y2aTK1G+hbrs
         rVBKGd7XSjKqcqPE+LyId4y5QpPFweAqunHkNGeu1LKC8Rezgs7K6kdmALLSTCk8e8by
         9nptOsV7SoErUgchq+Nw5n3rBLKPbbxwlo23xJ6HRa+yIp97o701dMhq0MK5I5olnakP
         qZl04sIoFsz3YfPQrU5mUAzb11bz5hL4LZwU4fHJ/zYcPe1RMU5zANytgm9XlLe9bbFr
         +DAA==
X-Forwarded-Encrypted: i=1; AJvYcCWbsM4qslA3vvjxLRVPKGRMuP4mLSJ6HQhmqlQp90AK3y4G0rUa7/lIvw66JB87Fg+5XJJHCqajL7EbUMINAvAGjHf+jLN6zpKVMAyFE7t5uHU9LOB6BrMNhiMnNiNUMMlFa0dL
X-Gm-Message-State: AOJu0Yyqd0+7l21bodoUXbjD6thBomiL/UlZ/7bjxwz/bH6rotGxQ5ih
	7SLANiep3WWFDEOh2aOjyf9NPcOb+LZYhh2j80BfiMXYcdzx7Ml9
X-Google-Smtp-Source: AGHT+IGFPG0ViaWTYJQ2Bl1vz//u/9CrYs7Q3c9mLsIwvTSZaY8ZaeYMK7z7zeiv56aIKjV6f92muA==
X-Received: by 2002:a05:6a21:3115:b0:1af:d0fe:9094 with SMTP id adf61e73a8af0-1b212cc036bmr17114559637.11.1716829572557;
        Mon, 27 May 2024 10:06:12 -0700 (PDT)
Received: from localhost ([98.97.41.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682219872desm6208253a12.30.2024.05.27.10.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 10:06:12 -0700 (PDT)
Date: Mon, 27 May 2024 10:06:11 -0700
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
Message-ID: <6654bd8326982_23de208e3@john.notmuch>
In-Reply-To: <0972529ee01ebf8a8fd2b310bdec90831c94be77.1716446893.git.tanggeliang@kylinos.cn>
References: <cover.1716446893.git.tanggeliang@kylinos.cn>
 <0972529ee01ebf8a8fd2b310bdec90831c94be77.1716446893.git.tanggeliang@kylinos.cn>
Subject: RE: [PATCH bpf-next 6/8] selftests/bpf: Fix size of map_fd in
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
> The array size of map_fd[] is 9, not 8. This patch changes it as a more
> general form: ARRAY_SIZE(map_fd).
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/test_sockmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> index e83ca0005721..3654babfac59 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -1285,7 +1285,7 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
>  			bpf_link__detach(links[i]);
>  	}
>  
> -	for (i = 0; i < 8; i++) {
> +	for (i = 0; i < ARRAY_SIZE(map_fd); i++) {
>  		key = next_key = 0;
>  		bpf_map_update_elem(map_fd[i], &key, &zero, BPF_ANY);
>  		while (bpf_map_get_next_key(map_fd[i], &key, &next_key) == 0) {
> -- 
> 2.43.0
> 

Acked-by: John Fastabend <john.fastabend@gmail.com>

