Return-Path: <linux-kselftest+bounces-27624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ED4A465E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 17:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8F519C1A74
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 15:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B05E19CC3E;
	Wed, 26 Feb 2025 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="LmfMVmtH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7242904;
	Wed, 26 Feb 2025 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585068; cv=none; b=uJy0i52IjC5CU7/zaOUm0ERLaAOMl9JsdVLqz0IE3CfwvY0+pm9DNDOYSTeTrpcGSFExbeA95XTEpHXEtptak5LVBKMMcPEwu5X/ubfXQ6DB8vYRGDNVDW/5fPNQuDaQlNnvHweEb+937quIoEEC0dZMfQhQj9Q0N7cMGvg7QdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585068; c=relaxed/simple;
	bh=qLjC8EE3OknpLXkqkBTQuQzocH/YaHfLD4Ws8Dwfis4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ZLHPwjlI/iRsZbWgM40NUhkBBXUz9Hwil5dOlS043U2TZ4Q0F6hkNb+sH/0TMnJNuapREygSZI/TSkLVx08WfEefn8fM+D6rX4Vxt5xHqAOMPY6n8mOrM6PoReE/WwmGn6iyOOSofOn2A3Q+l8K1IjuYefzMKR5sT1bRJlL33yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=LmfMVmtH; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740585042; x=1741189842; i=markus.elfring@web.de;
	bh=S+F6SpZ9ta8idotlXporaMgDhf86eKSQRHJcK09/2Jc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LmfMVmtHO9bFtC0wd3130UcjXxKJI13WWuZ0UWZx8bOmLPE7Jp56m642phRQSTqn
	 wiKTEizvyicwLnscPBlhRm/zd6GJNipniqGA8OLqUGnX54IX0MnIZPHLTjUdMbNEw
	 cRYFQx943KbwYkRANBckLs5eFZhOP8VkBBv5Z04ZVPUTUCdaEeTLgwM4t7J3BA3Vs
	 iH8odxpSE7vZsQw1RFmO4B6cMB0zr0YondVa47PfBXP83Xglgs/842IMpHniQ+VMx
	 9Sm5EZT1YAQU3Gg353yeBJGbyDMlv3VRhoy/VeO+wU82quZJa5rafeWwzPMs6vOUr
	 nA63Zn0Cj4GglD+35g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.43]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDdyH-1tcZ7N0fQt-00480y; Wed, 26
 Feb 2025 16:50:42 +0100
Message-ID: <e4f9a423-6c47-42ea-a6c8-6954a9b5ca2e@web.de>
Date: Wed, 26 Feb 2025 16:50:39 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hari Bathini
 <hbathini@linux.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <174055073461.4079315.15875502830565214255.stgit@mhiramat.tok.corp.google.com>
Subject: Re: [PATCH 2/8] tracing: tprobe-events: Reject invalid tracepoint
 name
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <174055073461.4079315.15875502830565214255.stgit@mhiramat.tok.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n2V73HTKUMsttjj+irp3DGXEpuKoblqa/jm149fQRGDv22nixeS
 pXiNxgQmN7UO4ybag6D0F+PmVCRcrYaO+KH43n+XYC6GIZRMXDTva7GGJEJRT+v40ADxsLd
 0CJGA445bBF5QNxtvAuUWK770eVor1tC5LtCvlWZyElCoh3DbJJPz2Hy35CyAzpiIfcU4l9
 kjxbE0h4r7vesANfv1qFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RMHg8zTBDfI=;Sm0cZFN09LdR3EYcBvKv3bikMCS
 /wJDKmyotCOgRx0A//I7yWUC20y2tpsOJ+Y0K78cWs/JEE2guRhYOW9oSTGL/8D1iUKUI1jEV
 24k7c5nhcqnHufWkVPe+gFCjRNdbllj0N9G+PPUYqD8bnjghqAd4BTa0vmaA1a65xBTFmds06
 jZkiTCmtkk77SaBqJ0o+w1WSZU6kruJAfdQw5C1jvNK0tRFoN97un5dTeVxLciL2bbC7u45yK
 zN6gVhoUyGzBw8lk1qGD0lA1vTJXe+cd9ofbHK5eHrkZjqIZ3pEM5TGNvF/mVRiruACGxeLOs
 gU4/TTI/GN0HNgB4Tjnnty1BuqPL7tBv7McqKfS3qm3lAAJlL3frbB6Ie4tyVAyPxnHPe97MG
 UfcVr10/G63vwQAJ0WTdr3YAgZMME6qTZAdLyq60A1zxs4FpMOJDnM6s+o2wDwt1kFyHztC+O
 CAnTULYqYN7Ip0AzvSknD3r1jy2KP2qK01eGH+G5a9B2OVT+wl4gOFCKF+Nuc2ChKtsjOJcZk
 dLR0PsLNVxdI1lM5jDA0oA2a23XGr6lKJb9rg3Q0At1/ggPK2rJPAaoKmtVLGUYaErdxA7R+r
 KOeEnB6Oq3RkHAvS5uSjhB6jo5sQ2MaGwGLcpfNotjnd2asxuqWzIbpZ6PSSHGFmAuq4tW42O
 3Cqr6I4B8zKRxQtMkIjEXcxckG047UTXwQtPKcLYTdB5WM8p2b3LrMspcnzfsCbrzzr1sp/UX
 RJAnvUFVNvAOtBzZumFfqRnh6njnusMkEwMe+fPDE9+sKfYxZKxyPF0JjMsseCjLyD0+23Wyo
 fuWdBE5LMeb9kOTztZGO5z3IPN+fO1IIbBS9HdXqJVv8n8uQ1Jyh0qMHIrJJqtjaQ9zUJfMUb
 lv1ISGbF+x8P+tS0HoN6HgxDPXZTLT0vEIvc5KH72f9H2gRI8/imyeuxQnmU7BstY1QVwDy1z
 dx1y5I1iRS5rt6ET4AVuRcO+5G/8UFxWstsKJgLBZHuZSNmmEdrqMbPmWf7uw4kinkmgbGKFk
 VlA5v7ZL2ttH4N30SyYQGdT19xLyKM+U9VJ2k19M+7JGUvwhT1ZL3rCqYinDcykzCkQ9kie+S
 3QDyqqg4jjElM0uXBx16rnIPsugAUF8mGRGEOp7OxPke1dCp3bHJHU1xwwl58RoieH8Nvr2WW
 7a7SoGH2VNEV50H8yPwUbdQKIdY1E7VTrKiTRRQ8aJzLNKOgqvSnLZEqVAY29ZPP2knhB9vZw
 e/IZCXWnqiJV2b9tQJ1MJML2keLruS6L8rISzfGLyFGJsNvHxU/B50dMMV8xXLpOqIInQmmZN
 AI4pP69yuJuxUpHAfdAEaCd6PyrBwu1jsQDGCM4wyF9XOSWJKHNYr/q6VWmtJtx+vaybPaEpX
 bnYH7dPts3ceq3JeXeA9rLBCM8VVajd3/sv25BvnIEGlYLU8TphQj2qml/p5cT50zvpS2q3+k
 +QMecKQ==

=E2=80=A6
> +++ b/kernel/trace/trace_fprobe.c
> @@ -1049,6 +1049,19 @@ static int parse_symbol_and_return(int argc, cons=
t char *argv[],
>  	if (*is_return)
>  		return 0;
>
> +	if (is_tracepoint) {
=E2=80=A6
> +			kfree(*symbol);
> +			*symbol =3D NULL;
> +			return -EINVAL;
> +		}
> +	}
=E2=80=A6

May a bit of exception handling code be shared by an additional jump targe=
t?
Will another goto chain become helpful here?

Regards,
Markus

