Return-Path: <linux-kselftest+bounces-22185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BDB9D13E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 16:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3527A283BE5
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 15:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5455D1B0F24;
	Mon, 18 Nov 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idRq2uAO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A2E1AF0D9;
	Mon, 18 Nov 2024 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942139; cv=none; b=HfOOGcd1d25oswXPjDcI63LghRS34JpSbcRSuduPGXMnrVtQTam3OENiA1gYck4s6dormiIafDWY0d5phaz5Ewz+JXDolUhnvxSGnb271aX3zbTyp7UmVrU2VTc+tKCeMp/E1PkFhWe+QLnqqaVnM0AeSolsepV9T44jKp5R5tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942139; c=relaxed/simple;
	bh=0w2OynbYO+nrOmy4rb//EdFOurhjemtoUWrgafapEz4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=k2+XVAlWkY5Qtebtpzavo9RnwhVI8p+vSqgq1zrtuN4a3cY0hd3yOEjFz4fqJezlO9HRp7IAal7UiP4vY/gn9m6wumspz1V9ZcpLmVpoUPd0HUPo+sfR08wpU7S5NJVcFsZbEU/NeR1cBOZ9ka7xvVfCimImqPf7jvGj5EYyGB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idRq2uAO; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cc250bbc9eso25635076d6.2;
        Mon, 18 Nov 2024 07:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731942136; x=1732546936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRQSc3PSOGIXJkJ+LkMmHz+FFKZo/2EmDTEVlbJ4y0s=;
        b=idRq2uAO7PNs9lq3RKfKw6AwD1ZJQ8hf7zQLvdpRo3RybOaCqRN0SaAXjWsnXEazKy
         7RCCPUrX7KC1dvBEZUUz/l7v4wOZPdlHrGNPX+Ku94fLuJO34aRx4aD2e2PMrUEKc2mJ
         rUVQk+4cCUm88O+fD8GydNEJZw9S0pwoxCwM7ZJh5SilMaoL8KpqpWBIwIBY8Ay9gSWo
         COFKm52Hxcv9alOCfjJxdMx2j4IFMd57Azkozczj3FKA3wdVZu0yk/1f6/IPAJSdJzT8
         G2egannsbUmT2k/UTfXBCYpUW90VTs2PG7Edb0Z+O/lPdSzaEtDQupF5jjBdAXpjV/lY
         p3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731942136; x=1732546936;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SRQSc3PSOGIXJkJ+LkMmHz+FFKZo/2EmDTEVlbJ4y0s=;
        b=GzK37Gewi/iwteskFn35tQo2L+4UkQ56CU2m162CNQS3yfxISaeCJP9lqCBHpDyVJ2
         HKbmSCGfKz7x+l9NgKz7AwMoO2BzevTSNBrGSZkhvuI/XFtttstnfIRsUSu1TVjDCuM8
         Fss8vjU0rAyOOhL2aUnlKdvPg6siG9RvZwrsle0bGj/ZPi8+fUlywnHxNtJ03YXJXHAl
         3hZkxtGXeWpZA3LTunxgbjJgtSjBVwU6g5hlmpRDk1W2uQo6rf5A0F3w068i1PcnDGVz
         AvBCCPWqKDMwayZcX7MmScyWVpY3nHammjELWcZj4U/Iq9zyidJNCmpay9ryp/nhvPK8
         4tSA==
X-Forwarded-Encrypted: i=1; AJvYcCUhhnl4Xg8PgFzLxXDzN/xi31ZB9NofghZCYW9GZbCXmRN4ZqA9eyFU/Bbing2I4U7QOtZrUsXQ@vger.kernel.org, AJvYcCVOrgMLH52g5zaLCKvsqH02DN+UgH0m/ybnOXBbAS8/PbqgoxgjfKyXJVh5nW22DyumjB4P/n4uTblISyc=@vger.kernel.org, AJvYcCXuE3PsUxeGJzHNbomn6+C26D6OSEIeLXjA4+hf9G25ZNvTYev/VyiV/ZKKEMUcSGduevAxGFZfur29sfcaUdO2@vger.kernel.org
X-Gm-Message-State: AOJu0YxzZFptc6DavZE6m7aq2V6kuhy5kz2GPN2hH/EDZjbUDMbY2ABS
	65qvukhqnC3Q1+Me+fYNQEU3yR4r0nwxluUrGxi1Td2qhHADq78K
X-Google-Smtp-Source: AGHT+IGhgA/dHGCFIDyrq3rPlb1Z9bnrCzNhZrK1350dn5qjCRp6cQgukK65MSUGUxo/DnEb27XNUg==
X-Received: by 2002:a05:6214:2f85:b0:6cb:d4e6:2507 with SMTP id 6a1803df08f44-6d3fb802d51mr166801986d6.22.1731942136360;
        Mon, 18 Nov 2024 07:02:16 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dd205c6sm36585216d6.89.2024.11.18.07.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 07:02:15 -0800 (PST)
Date: Mon, 18 Nov 2024 10:02:15 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Leo Stone <leocstone@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 shuah@kernel.org
Cc: Leo Stone <leocstone@gmail.com>, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linuxfoundation.org
Message-ID: <673b56f7768fc_1ced1f294fa@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241117225950.138968-1-leocstone@gmail.com>
References: <20241117225950.138968-1-leocstone@gmail.com>
Subject: Re: [PATCH net-next] selftests: net/psock_lib: Handle EINTR and
 EAGAIN
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Leo Stone wrote:
> Make pair_udp_send_char handle EAGAIN, EINTR, and partial reads or
> writes.
> 
> Signed-off-by: Leo Stone <leocstone@gmail.com>

Did you observe actual issues or is this based on the comment in the
existing code ("Should really handle EINTR and EAGAIN").

AFAIK all the users of psock_lib use default blocking IO, so should
not see EAGAIN.

A simpler approach to dealing with EINTR is to ask glibc to restart
with sigaction or siginterrupt.

> ---
>  tools/testing/selftests/net/psock_lib.h | 39 +++++++++++++++++++------
>  1 file changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/psock_lib.h b/tools/testing/selftests/net/psock_lib.h
> index 6e4fef560873..e28bff95c8e2 100644
> --- a/tools/testing/selftests/net/psock_lib.h
> +++ b/tools/testing/selftests/net/psock_lib.h
> @@ -13,6 +13,7 @@
>  #include <string.h>
>  #include <arpa/inet.h>
>  #include <unistd.h>
> +#include <stdbool.h>
>  
>  #include "kselftest.h"
>  
> @@ -110,21 +111,41 @@ static __maybe_unused void pair_udp_open(int fds[], uint16_t port)
>  	}
>  }
>  
> +static void read_write_checked(int fd, char *buf, size_t sz, bool is_write)
> +{
> +	int bytes_processed = 0;
> +	int ret;
> +
> +	do {
> +		if (is_write)
> +			ret = write(fd, buf + bytes_processed,
> +				    sz - bytes_processed);
> +		else
> +			ret = read(fd, buf + bytes_processed,
> +				   sz - bytes_processed);
> +		if (ret == -1) {
> +			if (errno == EAGAIN || errno == EINTR) {
> +				continue;

Instead of busy looping, on return with EAGAIN should probably block.

> +			} else {
> +				fprintf(stderr, "ERROR: %s failed, bytes left=%lu\n",
> +					is_write ? "send" : "recv",
> +					sz - bytes_processed);
> +				exit(1);
> +			}
> +		}
> +		bytes_processed += ret;
> +	} while (bytes_processed < sz);
> +}
> +
>  static __maybe_unused void pair_udp_send_char(int fds[], int num, char payload)
>  {
>  	char buf[DATA_LEN], rbuf[DATA_LEN];
>  
>  	memset(buf, payload, sizeof(buf));
>  	while (num--) {
> -		/* Should really handle EINTR and EAGAIN */
> -		if (write(fds[0], buf, sizeof(buf)) != sizeof(buf)) {
> -			fprintf(stderr, "ERROR: send failed left=%d\n", num);
> -			exit(1);
> -		}
> -		if (read(fds[1], rbuf, sizeof(rbuf)) != sizeof(rbuf)) {
> -			fprintf(stderr, "ERROR: recv failed left=%d\n", num);
> -			exit(1);
> -		}
> +		read_write_checked(fds[0], buf, sizeof(buf), true);
> +		read_write_checked(fds[1], rbuf, sizeof(rbuf), false);
> +
>  		if (memcmp(buf, rbuf, sizeof(buf))) {
>  			fprintf(stderr, "ERROR: data failed left=%d\n", num);
>  			exit(1);
> -- 
> 2.39.5
> 



