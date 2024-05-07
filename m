Return-Path: <linux-kselftest+bounces-9600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CE88BE647
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 16:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F981F23D81
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 14:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526C415FA67;
	Tue,  7 May 2024 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRT5LAzr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC75A156F39;
	Tue,  7 May 2024 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093033; cv=none; b=HSxohsMz1TIkWULJA1zw1rJ6dcdX8z55+eb638/JXIyILsPw9QK+BQkC53cEDK/TJyfjdZbPqHy4t/FlMfa5MnBKyXJM3B2GCwRWf3AycbniGnnPav4ZxXoaAk136z8oJS2kGaAlPCsZ2td46nMXl3lB4WK8Be2+FrmL4aMBC38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093033; c=relaxed/simple;
	bh=cVK00FVDWLzEDng1ImuaW8RdJLe7pFz6qhNng9TB52w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsmL83J9qgyQqpqU51kIwEACkBRThBQbwZCtjrzmv1tlnEIxoenJgQMZ8KWdOiEPQuxS5frcK23Wn/VRHJy0v2dneYWTv9wrvlQvKydrk/k0VKL0HyNIAnP9/F5FmMpAY3K30PqlUY+1XZYbAVokhfDIKPpteFYjYNa3HARI6jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRT5LAzr; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34e7a35d5d4so2413424f8f.2;
        Tue, 07 May 2024 07:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715093030; x=1715697830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bM5RjluxHipg60pIjQCs1Kdq4Li1XFga7CcO2QMKNA=;
        b=IRT5LAzrgTDwtonDzUoI5cmF6WkEZrb4Kdff8G5dzDYdL0UOehPFnnn4jQyucGMVNh
         xjbSPUV7o7ne4svcyMAJGhk9lSiHY09I9bUIP2DlPoFA3KfsFHUViFDG9cZXyuz6kIfP
         YknA2lt75aMkeZEA2BziEuYQ0S49lpj43co9I3/+zDFRId+vFT01WLsBTzhEH5JrN0ul
         ofm2BbO2vBbZRnw8cnB9ZiGsrGVUhnwi64hyrj/mFZwyIjrCa9f6QNasdZGQe8dr/aW0
         zWt02ej9L+AooRBsKvnmQdq56q2Oj7S4O2uWowGZLZVXaYalCmpjVlD4RMoHUgCVrH5B
         9fKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715093030; x=1715697830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bM5RjluxHipg60pIjQCs1Kdq4Li1XFga7CcO2QMKNA=;
        b=amBwxvfaJ1QAH9jfyKcxOSfj98uiHDu+FJM6t3jmSVPcxkUAmakDAnhy+e9anr37mW
         Xxy+6xKFuleFVK9zLvUmf9H2lct8LJXJBrcxoCCXwfcQcTGZA5q2tzosCWhXZkuvOjEr
         RJXGPSH8EK+X+DHLDr2L9kt9VzlvczRLhvxvqBzaIIRKBf0Cjx06N5TDcEqtZt4GvF+j
         5ao/7arABXL/gKZSqmXBv7YTsAPJGVjFuwdsUaWWzhbTL6cl+2PPJK+2235QHjsRT7Sc
         VEvUANivpexQawZv0qSMBSRrLew6hAiqeW1xdIRbLVoW9P4fkzKT+TQZ+pbF7PCwv6je
         4dYA==
X-Forwarded-Encrypted: i=1; AJvYcCVNISGbTtAKlGaw7ymPqRozg9kzFPuqOXiNQNbzLf/5pBoCzGOlrWVREZlElrqqdUVJZzrfi63iha4KiAkzB7SoiZZcbzXUmn/IqwlQfVt3sFGC4PdFH5kws7Pf/ySZ9xnvxu1ugmSg2DXqUGKpf9C7Go1IpCTG6FSBWNRWKLsji5TP+zYHeTESFJIzA/TfiEdqcIvXVp/kmHO6
X-Gm-Message-State: AOJu0YxuQ9U35RNO6qG4cWz5omXDSTca5zRURn75+a9ztSSUG/x9uqJ/
	GzonDJ2Uf/qtfiki70aTgZzbYBO7TdmTS6ofN6cagS3PCMSXIYf7rgdS0NSJy0JLVxEtoRUaznA
	jc6/XQ/htKsa+6RLFDToKXRiIk98=
X-Google-Smtp-Source: AGHT+IGohbKdu5N5Ex+4EkZMkPfNXVJa4QuvuOwWy2p6XWZL9RHKYD+h27FqkUdbOj4eiHLrpqiOUEpbKJrSf/ZV38w=
X-Received: by 2002:a5d:42d2:0:b0:34a:56e7:5cc4 with SMTP id
 ffacd0b85a97d-34fca14b3bamr36578f8f.2.1715093030024; Tue, 07 May 2024
 07:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org>
 <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-1-e2bcbdf49857@kernel.org>
In-Reply-To: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-1-e2bcbdf49857@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 May 2024 07:43:39 -0700
Message-ID: <CAADnVQKWCVfUhQnoYBoEZaZbfiX8MROcj7Ct-nB4-axhZqMecw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: Handle SIGINT when creating netns
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 3:53=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> It's necessary to delete netns during the MPTCP bpf tests interrupt,
> otherwise the next tests run will fail due to unable to create netns.
>
> This patch adds a new SIGINT handle sig_int, and deletes NS_TEST in it.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/bpf/prog_tests/mptcp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testi=
ng/selftests/bpf/prog_tests/mptcp.c
> index 274d2e033e39..baf976a7a1dd 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -64,11 +64,18 @@ struct mptcp_storage {
>         char ca_name[TCP_CA_NAME_MAX];
>  };
>
> +static void sig_int(int sig)
> +{
> +       signal(sig, SIG_IGN);
> +       SYS_NOFAIL("ip netns del %s", NS_TEST);
> +}
> +
>  static struct nstoken *create_netns(void)
>  {
>         SYS(fail, "ip netns add %s", NS_TEST);
>         SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
>
> +       signal(SIGINT, sig_int);
>         return open_netns(NS_TEST);

That's a drop in the bucket.
ctrl-c of test_progs doesn't really work.
Such clean up needs to be generic as part of network_helpers.c

