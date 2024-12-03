Return-Path: <linux-kselftest+bounces-22719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1117B9E0F8A
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 01:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED57282FF3
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 00:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6332500B6;
	Tue,  3 Dec 2024 00:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSTXGLGH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD26163B9;
	Tue,  3 Dec 2024 00:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733184906; cv=none; b=e6yBAlirAQUc0EYYGN9Kao8RqqD4I3z++FKAhpPpOwSuzLbukEuP1dVRuo9UuvPESkyckv/IoNpmK8I96xW6ulefrhS9bUh9Jv8nJ8REcmJzepH/L6wz9pHcPbS1eClaNKmVbdAzArch31litP82gW+N2USV61PKbK6bFghdvag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733184906; c=relaxed/simple;
	bh=sFpARMD5DEnpcvy3BKqI9LW6BSUs9SACQXTXuoBRu7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4W2l6M5SB31GoPIOb5gyYYJ+oJc450bSCez9qTUOvHy8Ft5A6DUSElsFtXeb+ZHtbyn2q6zkinE92sPGUxT64Z+Lz/wyPaIRpOfU5tmpIqXTpESrn2MjJftVMNF7mFN6YrLuU+mkUzlqxr6UfnZokbcXggpw0za1pNrs7b+kps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSTXGLGH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-211fb27cc6bso38952515ad.0;
        Mon, 02 Dec 2024 16:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733184904; x=1733789704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P799PVpPLal4v1SIHjVIekWVJppU4272KgWygSJqrNM=;
        b=QSTXGLGHz8Ee17aOddBZ2hLPZK24HVPs1QBthZ4G9ny5atfcW7i3/AggD3q+qt0XrU
         23r5acjwr84brC5OZwtJliryUFRLoZsdF4Wt5qmgiH3IG9sAkdz6rUBFD6sfzPHc//9W
         jjF10iXJKcmLzCX1sQNFLMRpuX+gtt8uZb4WyQsDnZxWRCGgCCmScIgdw/A2BU+7xIGO
         T1/sUU9HF/4CdpcPBy1SOfTU4dyP5mG1fUcpPC8oxmszIoVqoQq3Cw9riI6GV6QR8FWx
         O875TN2hDspZlVSWs0SVdx/EKAIU0cYDfFsVZy92RbsOvz/Vdo30TbnraaJFzlkHRF5k
         Ho0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733184904; x=1733789704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P799PVpPLal4v1SIHjVIekWVJppU4272KgWygSJqrNM=;
        b=ZJJCZ5/r2xFuJsLcs4eP5O3NkZblu1VtVi2ZJ3RMcHyICxFeraKQy3v1CrzaDwUYOt
         aaPXjySjZf5w/C0RVM4FfDd16wrWrv7UhD/tAWz4GdXBfehX9hvKiFCXsUrSbCtl0LZy
         t5LRE90adHIwhfgf8qnYLHl1F6+JBPC0GizvAiqgqGpjDZUx3J4Usy+8q2IuEb+hOZ7H
         QjtBeOPpsak0yxIE/t08RvAY5Ljm+EiYjS86OsUxkySHrSEe1Vj4FYN1802rqRYMR2nx
         2ohz9cA+Xt+ZPTBf7/SxeKIBV5qWkTDXWYx1mQwIEKhXqBWskqHpX+C7t9X4+SUCYqCm
         GijA==
X-Forwarded-Encrypted: i=1; AJvYcCUL3DUlDYY+ki6pE+9rltwDAHDNkErt425J3Ed9hb8JcxLtlPIy6bSuO8LBpw4gHJR7caI=@vger.kernel.org, AJvYcCVb4dwqKm6Ips12gg7Ad9YCvlNUClrYKUpOzG6U4UpmsNT/U1VrIt+kPt6z9APdDeG0NHpvlAhAB29tggMr5GQj@vger.kernel.org, AJvYcCWKV1yU1B1mjEPlRoWiVom7Hw5CIXvAscTa0urWR3KquW+5Emto1Kj9DNdCJYdZG0LlXAvEDgs62fj1+lhF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8m00GuowvgFMizVvnz3WRIGWtkMRQ6BcjaNCNO2/pzokpRr5p
	rV7TJZcGqbXR2QjDnZXMP8lR/3crwY9tHUf0z5BMlDk7cmTltjM=
X-Gm-Gg: ASbGncsDyOpMQWBzSbRAhV4mO1P0DN6mqLYsofeEzmFNMAESVicZVa1js3Ql6pMZWz2
	erdS21kuB3c51/td+uMdRIpM4clBF0FSRhbQNo/zfEqvkUUDXCIwc2UGrvi1sdbtKg8XMkWh58z
	JpcjKnHBazt/OJEgNOpligotJpTKQBEF0ZWYQXMPypdHUYcEbv5/BlPC9RQVuu++Fd+AU6QqDQ0
	S+vdZ2yT9zSJ4ALcaLxKVjNdVhMWV85XN+PKIe9mjtgwVazbQ==
X-Google-Smtp-Source: AGHT+IEE13VgAHt+B51vFr1A06FMBG0kR2b3nUwpxvlGKx/VNPWE5tC0MM+Effxm7wknS84m3P5qMA==
X-Received: by 2002:a17:902:ecc4:b0:215:a028:4ed with SMTP id d9443c01a7336-215bceb3e5amr7595615ad.20.1733184904014;
        Mon, 02 Dec 2024 16:15:04 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417611dcsm9160425b3a.3.2024.12.02.16.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 16:15:03 -0800 (PST)
Date: Mon, 2 Dec 2024 16:15:02 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Marco Leogrande <leogrande@google.com>
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
	"Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>,
	willemb@google.com, zhuyifei@google.com, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] tools/testing/selftests/bpf/test_tc_tunnel.sh:
 Fix wait for server bind
Message-ID: <Z05NhvyagBbHs8Gq@mini-arch>
References: <20241202204530.1143448-1-leogrande@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241202204530.1143448-1-leogrande@google.com>

On 12/02, Marco Leogrande wrote:
> Commit f803bcf9208a ("selftests/bpf: Prevent client connect before
> server bind in test_tc_tunnel.sh") added code that waits for the
> netcat server to start before the netcat client attempts to connect to
> it. However, not all calls to 'server_listen' were guarded.
> 
> This patch adds the existing 'wait_for_port' guard after the remaining
> call to 'server_listen'.
> 
> Fixes: f803bcf9208a ("selftests/bpf: Prevent client connect before server bind in test_tc_tunnel.sh")
> Signed-off-by: Marco Leogrande <leogrande@google.com>
> ---
>  tools/testing/selftests/bpf/test_tc_tunnel.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
> index 7989ec6084545..cb55a908bb0d7 100755
> --- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
> +++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
> @@ -305,6 +305,7 @@ else
>  	client_connect
>  	verify_data
>  	server_listen
> +	wait_for_port ${port} ${netcat_opt}
>  fi
>  
>  # serverside, use BPF for decap
> -- 
> 2.47.0.338.g60cca15819-goog
> 

Do you see this failing in your CI or in the BPF CI? It seems ok
to add wait_for_port here, but the likelihood of the issue seems
minuscule. There is a bunch of ip/tc/etc calls between this
server_listen and the next client_connect (and I'd be surprised to hear
that netcat is still not listening by the time we reach next
client_connect).

