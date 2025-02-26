Return-Path: <linux-kselftest+bounces-27630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D658A46652
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 17:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68593A16EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 16:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA2621CC50;
	Wed, 26 Feb 2025 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VUUaK42l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CDE21C9E8;
	Wed, 26 Feb 2025 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586426; cv=none; b=srQKlPMmYd/0sNbYidX8LbfzPlwGDBAJqqRtQ5NbDPXpJRXRoLcvuuuzTYYzOH3l/jUMKy18w9pJpXd087sXfbsuGYIizAzHOORfl5J7s9jJArinpT+LC5/h9NU5FCAW7ZoxAn6/HNu1c+7zFjMsq2yes93isqv/yNh4EWhGW9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586426; c=relaxed/simple;
	bh=nbk32YFzMdxsXfzMgqNjh2MOqm+b8/DeI5pYD18xT44=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=sljEep1FefXojWdu/cdRekQ4qvgkrP+UbC5CXfV0oOShxRTklYQZXe+SR0IFO5gWpjqTn1P69+i0danCf052Ty5po+AdKLv5px280gv//6HnLblQpmHzHTAYBOgrjVx94gTthIPv/uErKBLVEmKvHtKlpZtQdPlrcU6RNMtNYk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=VUUaK42l; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740586399; x=1741191199; i=markus.elfring@web.de;
	bh=C3c05qXcKU5hYx1ptwwL1abjQhPrDsvUvAbpYz2Al6M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VUUaK42lfERESAXrLV120LCFragepAPzgvI9ZM2xzkwhRfWz2rCQI0xrnzCXbXOe
	 s1AdW0bqYJnBXuSuEeDjvELiRCWXl+m9p+UTWrlpApBnJMB5djX8WCI3EnfAH1KOn
	 DsYY/sjIOy1jz9gZM6y2S7+TxohVfYBvEu5V3oPDWPVwSVzqsC3rc/ctaG8UPPB0x
	 4SIaFmw0DMQ9WtSU0Cb6xT/jlY6EoOCrh1V09nGeD2tHo1PSHSoFiXFZcALLvEe7O
	 oKpJaVlzJNxMaOLdIalXHQMc1POlQRfeujOmuW5EUVvP0OhGGlTq33/44AlyKJ7+O
	 5jXtJHQnEpewF8vYhg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.43]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLifq-1u4zRW3dui-00Iw5U; Wed, 26
 Feb 2025 17:13:18 +0100
Message-ID: <516ea911-acc6-47c2-87d5-2df0a18468de@web.de>
Date: Wed, 26 Feb 2025 17:13:17 +0100
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
References: <174055075075.4079315.10916648136898316476.stgit@mhiramat.tok.corp.google.com>
Subject: Re: [PATCH 4/8] tracing: probe-events: Log errro for exceeding the
 number of arguments
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <174055075075.4079315.10916648136898316476.stgit@mhiramat.tok.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UZdbfm8Jyj5pDTg2dnA4FRZxSZY84azYIEQUKAQgH2svbyxX3gu
 08c1/2YY9/U6YbnQzqnDDT2auFa+9vVjjl6S16nghJZEWPGQ7obrvuxMMULQzw5S30hp0t6
 3mYCXYGrFIswosXM+Cje2vEYJ1qA/ceTfU5jvsfrZsmJLUyZMOBpC7FH5JzB9tBzhevGPFV
 +SM2PdtNd8yyWlMDLBFQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JXcb3I61tNg=;j+LC9tXYsMbwwkJH+9vLK8PTLft
 GTV0+z46Q4Buyk95uhIoHhh0x0ew1PNvQ59yD61Md0ylNf/mXVexSk7k8mqbKDQSqvg6hITtt
 oTSxNZLfW4zD1+KCrX+J1pKn+j0Cg3RWSEKcolqV36DEHsSVK5QzRfVm+tFOUDsZJjT1EvZv/
 xjhihTTDLG5PtBSBA+eoshvgKfUwMwi+xdEXH5Eultf22PEzNdOfMA2bON9FiJYtINuBnnCDM
 yXNCaDf+3WwWF2oo61QwUs7tASmMMYAOcSbH24PRv6Levs8pWJvVUhxer4xsrvj9g1ipGa/5e
 aXbhcKVz4U3mr54ERojgyXRISBHr9R/JVq1farA5z4b8X17oteG3UDEYZS+Tqt5nSNipMyK57
 jNEVekhGgkWqKmwS6TiWxkq69d6wimfAr22MqrrSEgMD5KcsIjROYILU/jGo8ghYApcGX488I
 LLV4PtjK8u0r/ZYNb2cpdMo9PSvIlUNz0CIAru8GE+0F9f/TVQtgdh/7Ehw/m5N5f1oFiM7GH
 qwCiO6VKfYSLYmywQJ7jnbr9VNCAYIwwQAqIx5Yqahs6rVzq5q5kTIAu+vzIkbeMKWtP0y3+5
 550amv7K5gY6tbxX7uN50H1fKDlNELnM+rn5icD7KX4ZuWrA2NJp00uH91RWBkJVoLYh7Qdct
 SAHQ56kPLqzDAyF+vJ9cXgcFMdpFzxZUW+FoqtI3+VUJJ9EGXwHKERQnbbuDAzdxIEm651Tpj
 Od7PW/4y0uLZnJcwCbCf0X2xRBs1bvvfMSu3l/e/Tkf+TssOR8W6/scogXnni2F9yGiAoZO1q
 f6Ui6tsWl8L6xMMegRn75XDQmoQl/ADXdwb59zF+Xm2eTzKkYUfV29q/JNuNVvbrBElxN6ezy
 cB6+Oubz/PAtw224atbNTcTM1FEK3QEhaAk4YFg87wbf1969RxzBH68VukVvM9eby55vjyf/I
 b3sZ4UB98h9TGvof5WhN4XsBJtRDz+jpA7WtW4HmWc3KbKyIveivvVbLoCR1INLUNinC6ilKO
 ZPHd0fAHy20sK0uMtXBvvlQLRcJtBqTzNaYAbLfv8P4EdratUae+HGfhj1OeDyvYTrorn/2kX
 17e9avdGI94T2r41jcl9LG6mTR839837KN0uUI0Us+lwzQy6kElnbQtQHG1wBwcey63lZGcvV
 lgi2B35cdFxU9SmHmEIA4XB18ZuvUwGBysNhUofUY1Jgv8O6/GDxBJDDBGBgBPeq4wPGKBkal
 VN7BS+RTSZvU7YRTRPFVUTt8CY+J0fJbZ6UIUs5gOtKAXdqAI/bVvZyHHvDU/zFDjDvDtV8pv
 4bKJj2R+VI5K7oBw8KMYuT4evKB/gLMKGUkyMp+Xk+whQTwCyfVvDSucWNBCzAsZXkp+J4NP6
 rv9s5Dpy4oSx3qgwtro+elBMlzTlU9WivbCaYjlSK30ghqEjhRg9ngrTUfCBtypKbwegEm6Ib
 GGgw+rQ==

=E2=80=A6
> +++ b/kernel/trace/trace_fprobe.c
> @@ -1201,8 +1201,11 @@ static int trace_fprobe_create_internal(int argc,=
 const char *argv[],
>  		argc =3D new_argc;
>  		argv =3D new_argv;
>  	}
> -	if (argc > MAX_TRACE_ARGS)
> +	if (argc > MAX_TRACE_ARGS) {
> +		trace_probe_log_set_index(2);
> +		trace_probe_log_err(0, TOO_MANY_ARGS);
>  		return -E2BIG;
> +	}
>
>  	ret =3D traceprobe_expand_dentry_args(argc, argv, &dbuf);
=E2=80=A6

May a bit of exception handling code be shared by an additional jump targe=
t?
Will another goto chain become helpful here?


How do you think about to avoid a typo in the summary phrase?

Regards,
Markus

