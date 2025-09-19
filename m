Return-Path: <linux-kselftest+bounces-41923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D721B88A68
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 11:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F9A16FE3E
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 09:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E96C286D4E;
	Fri, 19 Sep 2025 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SoxxNhd4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9501C3306
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275391; cv=none; b=o/XBJgkZZOSod5E38ZPTj6WFxymgg9XoGah/ZHN5aGaH0bIf26eEYy3QzNt0la4MUNyg8ofsLkaT5wohyxmvz4kyVdal9xSKKfusX4WsZ3+PFZPczzaCAmj2gbDsU91yEviadHL+m0LmKaYu5a8wjLZwRuEoFtg879Rg6jzonsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275391; c=relaxed/simple;
	bh=+vn2beOL9iMmMYtBKIdblfpGt0ByFQU+AXOHY7wMakQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GkGurby7lH3xnN+M/d+MPAVSeueoKQ/gISpKcKtkr/1lPCGbWe1kuvlttqAfSOg33/GGrQ9xxWD6lW40GUA8pF0F0UwdY5IKAbrqQ7uikNc2ciFiseT1zh11TCN77PyK2k2ICeH5J2C/pZqLSuyGRepRGtHlsu4sxLBvY4UOJIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SoxxNhd4; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d5fb5e34cso19736867b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 02:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758275387; x=1758880187; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VlTmVi594nSn7MW0oziVF2PMwb+/b26nYZTh/X3jURo=;
        b=SoxxNhd4qxOPCLTfLfMyg6V9quHrYYl76RID6alKKtBo6kSdEaRQ6YS1QrseFaoY7P
         CJhZdQcB54vDQQ2IdGSiEov7Qn1vi8frxMjWyIYszXAZmPk8U1VjXO3bLAKDiVur/3Ro
         GZACoi0x6f5tFzeY/IA9M9u9q+7qV4RLZkU3BhfW8EPmvhF6gB5IwMWzPEcjTNLf9Joa
         CaNhs8DNsoJgYaUkdrxLZlAy+uyuOtkQqfoGVQe7uXmPDREcI0cs0mQDhzPuiY7CoUe5
         q6CkNkg7MMMIQ3WB3tOCNoGQFb02gUXSKl5B4PD7D2FJL80fxULaKHo/EtzK6getU9Op
         dhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275387; x=1758880187;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VlTmVi594nSn7MW0oziVF2PMwb+/b26nYZTh/X3jURo=;
        b=gIvkaPOwXV5wh9ZdHLM/nxU0rMm1OgvjzMMSYxGpaXV/pv3b07B0032Oc5r8y1g/PJ
         Zjf9TCmmqF4U8LC7wn0kcWfziGzTFYk1mwYZ1SxnvpasmSy6iBZcAeiM4Zy1BUUZI510
         VrGA47XtXApZEBdQ/RGsvM0CFSD+rJL+riJCA7pjT9ccCTVdybY/JPCgsxHBfCfKZa1E
         /s/pCqZeavQRshfNioBTTol0phmRsyYM8q9HHSave8+j9M1oHkTCekJ+trfCX6S7xhGq
         c4bguYBlA/strl4Kpax8IhokHZRjKzDigbvSI/1vPfH8BgcdSBEvzQ0zkPmnGx8b41Zf
         3jNw==
X-Forwarded-Encrypted: i=1; AJvYcCWKSMn4wwcpeF59yIjykJyWTHNZe9KcegaVZtnHCyplyOq2lto1BJG05v3yNDQ/Fi77W6t9aTGAw2CRb1++COs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp9Bc3bV+q6gRRg685j/9353e1ug9f8Fk7by0w2jooY3zX9BHq
	CPbP4ZkbAZI1DgBi/VS1oYr+am8NTpwvrCgiZ4vgf1697hXTXzoALzx0GBFVEQakPr4=
X-Gm-Gg: ASbGncv+LeBvcnWOvoazmVoDm/uwymNoI5rfk0sx6w8zEtq0vOi2bPNysYNkjzMBvoq
	KW8Qy1tba0K8b286MwVCKWWMngtNC4zlJsuD2MRzlyS56guglqvatzAZV+sd+IYF2Ls11NjgMmv
	fjENBH0o1iB4FuMMBR7EN5v7mY9wUm3tBS9ccgq2rtyTwfj1IOOo43Zm1DKO6fub4zfwIZ9IDm5
	VOFVUxktoNTx61EicgVML4X3p4B/R8c0u0GGfhIg2EiprHCwhIneFdhK+8xrkyo6fJyLA1OVbnC
	YhmwE8UUuBPu9r6s6O2kD4EdaFJEtdLUnnexE/7xqdcRR8zBNF0XHd24zkqKSErr5zwyZPjs8rr
	9bHFBeb/uf1T2kQ==
X-Google-Smtp-Source: AGHT+IFpVVlH/GN9+lAL03mMctGhSJiZkSMnotDqIFxVyomur2G0cmwXdfQol97zehSveNubfzRMoQ==
X-Received: by 2002:a05:690c:2502:b0:71a:2a13:1e44 with SMTP id 00721157ae682-73cc45b4c3cmr26463757b3.4.1758275386983;
        Fri, 19 Sep 2025 02:49:46 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:2432::39b:31])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-633bcd08b24sm1610356d50.8.2025.09.19.02.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:49:46 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,
  John Fastabend <john.fastabend@gmail.com>,  KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/5] selftests/bpf: sockmap_redir: Fix OOB
 handling
In-Reply-To: <20250905-redir-test-pass-drop-v1-2-9d9e43ff40df@rbox.co> (Michal
	Luczaj's message of "Fri, 05 Sep 2025 13:11:42 +0200")
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
	<20250905-redir-test-pass-drop-v1-2-9d9e43ff40df@rbox.co>
Date: Fri, 19 Sep 2025 11:49:44 +0200
Message-ID: <87jz1uu5zb.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sorry for the super-long time-to-feedback.

On Fri, Sep 05, 2025 at 01:11 PM +02, Michal Luczaj wrote:
> In some test cases, OOB packets might have been left unread. Flush them out
> and introduce additional checks.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  tools/testing/selftests/bpf/prog_tests/sockmap_redir.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
> index c1bf1076e8152b7d83c3e07e2dce746b5a39cf7e..4997e72c14345b274367f3f2f4115c39d1ae48c9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
> @@ -184,6 +184,19 @@ static void handle_unsupported(int sd_send, int sd_peer, int sd_in, int sd_out,
>  			FAIL_ERRNO("unsupported: packet missing, retval=%zd", n);
>  	}
>  
> +	/* af_unix send("ab", MSG_OOB) spits out 2 packets, but only the latter
> +	 * ("b") is designated OOB. If the peer is in a sockmap, the OOB packet
> +	 * will be silently dropped. Otherwise OOB stays in the queue and should
> +	 * be taken care of.
> +	 */
> +	if ((send_flags & MSG_OOB) && !pass && !drop) {

Nit: There's a similar check a few lines before that:

	if (pass == 0 && drop == 0 && (status & UNSUPPORTED_RACY_VERD)) {

For readability it might make sense to introduce a helper flag:

        bool no_verdict = !pass && !drop; /* prog didn't run */

> +		errno = 0;
> +		n = recv_timeout(sd_peer, &recv_buf, 1, MSG_OOB, IO_TIMEOUT_SEC);
> +		/* Ignore unsupported sk_msg error */
> +		if (n != 1 && errno != EOPNOTSUPP)
> +			FAIL_ERRNO("recv(OOB): retval=%zd", n);
> +	}
> +
>  	/* Ensure queues are empty */
>  	fail_recv("bpf.recv(sd_send)", sd_send, 0);
>  	if (sd_in != sd_send)
> @@ -192,6 +205,9 @@ static void handle_unsupported(int sd_send, int sd_peer, int sd_in, int sd_out,
>  	fail_recv("bpf.recv(sd_out)", sd_out, 0);
>  	if (sd_recv != sd_out)
>  		fail_recv("bpf.recv(sd_recv)", sd_recv, 0);
> +
> +	fail_recv("recv(sd_peer, OOB)", sd_peer, MSG_OOB);
> +	fail_recv("recv(sd_out, OOB)", sd_out, MSG_OOB);
>  }
>  
>  static void test_send_redir_recv(int sd_send, int send_flags, int sd_peer,

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

