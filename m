Return-Path: <linux-kselftest+bounces-12952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD2B91C909
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jun 2024 00:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CAEF286794
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 22:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213F280C09;
	Fri, 28 Jun 2024 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="LgYJUz1e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8205F77F10;
	Fri, 28 Jun 2024 22:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719613439; cv=none; b=jBGU8xWdga86JcLut5Y6eaf2h+UszoZLp/VOtsfZihVEpTRGrwVSaMe2aouJOyz64bgEbHULqKXBPserzBx0nbwyIepbbFDxw65YJRYem4qAXmaDEI+5x5qjhMIDZ5C+l0r3KgDhlvcU3IlmGkWCTU7k3Y0VmNabQos9Rk23gXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719613439; c=relaxed/simple;
	bh=yWpDidoG0tNCH8bt6FciDlaBbMXMnRFfIlxkW5JUxFo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cTkTZKL0cizMsHYjxm9pAlnwKFKdTif4h7AqUFfwVkdMmb/BqrXuuzt/VqumOwgflOmR9cXw9/vaZqQM8o0xjPENdAiRE7yREXxZxpIk99Z/PWOs2tJD//uGIWT3JyCmALDQdaan6zIISrR4uvk8bbC6gPUI4at9G8QNJoHMd54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=LgYJUz1e; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Jkls7DPW/4o7NdOxSD9CxZNsNVkHS6JiAhzOjoNpQLo=; b=LgYJUz1eu9lsDGAtZqLeLHpK6k
	JmmM7cEYTQku5QNZS47zR+Hzc/AndCBjK1Vj03fF+rFnfsBW6R8unLWn7n2gbybr8z7bFDY6QzeSn
	xs+vSy7a/MIyVF8fhSQIwhKtG9TU6yWKbd7wlsCmURpfI2tZDxCnLCgNu0GsTC3SRUwYXjk6fAsnU
	YdAwyA4SulvUc9yVez2H+27ncpI9csp8nEzunmGZkFyfwX4AVkgKDX+Z9tZTMjiqMVRAAfkFrdh+H
	NMeLmY8z/c4/1Yv/xQ8dQ3+FJplTAXNee2BWMgPBLgxAiH30nn1FOdvIfTQxmpgEXcTkmC4c4tyi0
	kxCkLw4g==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sNJzz-0000No-Np; Sat, 29 Jun 2024 00:23:19 +0200
Received: from [178.197.249.38] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sNJzz-000DOB-0r;
	Sat, 29 Jun 2024 00:23:18 +0200
Subject: Re: [PATCH] selftests/bpf:fix a resource leak
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240627060107.8682-1-zhujun2@cmss.chinamobile.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <847bcc7c-e54e-648a-be47-59e0a6d0853e@iogearbox.net>
Date: Sat, 29 Jun 2024 00:23:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240627060107.8682-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27320/Fri Jun 28 10:37:18 2024)

On 6/27/24 8:01 AM, Zhu Jun wrote:
> The requested resources should be closed before return
> in main(), otherwise resource leak will occur
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/bpf/test_sockmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> index a34e95040994..03d5dd617c4a 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -2092,7 +2092,7 @@ int main(int argc, char **argv)
>   	if (err) {
>   		fprintf(stderr, "populate program: (%s) %s\n",
>   			bpf_file, strerror(errno));
> -		return 1;
> +		goto out;
>   	}
>   	running = 1;

There's one more when cgroup_setup_and_join() fails a bit higher up
where we end up leaking options.whitelist/options.blacklist. Maybe
could you reorder the free() towards the end, add a new label, set
err to cg_fd and jump there.

Thanks,
Daniel

