Return-Path: <linux-kselftest+bounces-48869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 314C9D19997
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 15:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 982A93000B65
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 14:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9632BE03D;
	Tue, 13 Jan 2026 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iRy7or+o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8256E1624C0;
	Tue, 13 Jan 2026 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768315710; cv=none; b=nqRDkJQqPPDOWGwNR7+VU8rgI/qDgz+XE2DbZaqQO6C4BPp92184Oc5pk/m0yofg+ddWhfr9GVjgZpWg2bm4dEcuw6btMDfoQ8eoXpw5NOnbZ9fGS8AMnJLDhuNvMMBsIhAfcpcdPIT2TkhSXdoUbgaV8cV09DhBHMY6z0K068A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768315710; c=relaxed/simple;
	bh=n/4v6JRKodA8l8J+MqPjxD4pmOoWIsiWoSNBk1tvghE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAuXhgLdq+VUes4shwnn8bmymoAKG8PRocpl1f+9mwH+6VAmb6W5q7Fi0GQqvABKON3NqlYZ+t1ErNqG9t+cwYzFZb3EMuscDQuVoU9FMBYNKPYSw3IRt+gaBMvTpxa/Sbd+jrtypLWFcowU/MIpoDciLUJHC/y0S7kB3qi2wxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iRy7or+o; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768315694; x=1768920494; i=markus.elfring@web.de;
	bh=5V7saCrlm8+o/aYAnPRz07hEWKsTQO6YUJsKYE4FU4s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iRy7or+ofSdVY+UPKv5vmrw7PMohdGOoTVs04G4l3wHNVgNnqvX+XsItraYpofTc
	 F5UR6Wbjv1vPc2L5MVcBED6Ll5JK7GqDn/WPlIGBKwE9nTWENdpllumx9pSZ0uByp
	 GEbTA511F+X4uFqfjXeQZipYqcNXA1ave0G0sTgz5mqpRXaCQPX38YD5xbIJ4GQbv
	 tbJHtr7UqIW/LDEHa7petGE2d9EUk5M/+CtpJzHjCiaVwLEFD4RhEki2YwuesJX2H
	 l8XcEDoMzd2/Cyd0ftyoTirouoeiJHzn3vGLRLcMThDcFXc9l0jCykMPucbTqM/j0
	 4/RORZgdhJ6ps3RXIg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.174]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMAE-1wHk4G2kSc-00bZNp; Tue, 13
 Jan 2026 15:48:14 +0100
Message-ID: <607a0338-5e84-4aaf-b705-18dcd4aca05f@web.de>
Date: Tue, 13 Jan 2026 15:48:11 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] selftests: net: improve error handling in
 passive TFO test
To: Yohei Kojima <yk@y-koj.net>, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <cover.1768312014.git.yk@y-koj.net>
 <24707c8133f7095c0e5a94afa69e75c3a80bf6e7.1768312014.git.yk@y-koj.net>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <24707c8133f7095c0e5a94afa69e75c3a80bf6e7.1768312014.git.yk@y-koj.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ET4BCWm0N5mOCopr03R+Qz5iZDvzj1H9jy6HeDZ9LC1v8AwygyM
 uZN0fJPebdE7gHhIXBJdhjPyE0t94s/pZHjMazu0m1tAaCNCW1hZmCTro8TQLOY29XziVM0
 uY276/NULR6jQOF1y2YZQvo7jBwAHke1wbo0dkwlk32JTX7sVn1VshzCCY/75RStF55DkRY
 rjeR5tp3doy/ignMrgd1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tYjgDxRIADc=;+Z3gPnMzLjdYeev1AaxTeZWgPh/
 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
 CwJDS6PkZPUQ3fvKX+n6KkKZ4epoM

=E2=80=A6
> +++ b/tools/testing/selftests/net/tfo.c
> @@ -82,8 +82,10 @@ static void run_server(void)
=E2=80=A6
>  	if (read(connfd, buf, 64) < 0)
> -		perror("read()");
> -	fprintf(outfile, "%d\n", opt);
> +		error(1, errno, "read()");
> +
> +	if (fprintf(outfile, "%d\n", opt) < 0)
> +		error(1, errno, "fprintf()");
> =20
>  	fclose(outfile);
>  	close(connfd);
=E2=80=A6

Why was error detection omitted for close() calls here so far?

https://pubs.opengroup.org/onlinepubs/9799919799/functions/fclose.html

Regards,
Markus

