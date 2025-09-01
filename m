Return-Path: <linux-kselftest+bounces-40437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E7BB3E5E0
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 15:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4961A84921
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 13:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CD330F555;
	Mon,  1 Sep 2025 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffU6S9bo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18D518C031;
	Mon,  1 Sep 2025 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734340; cv=none; b=WGVudnKHJCppcav2wcOqyxO2wdI4sS+HyIIWuGxYaNTC7SlNmWBwUEMssbvwp1wJD9QbeClbG25+Orwvubv3rjuuLGRRKao7HSSQxajWGThbZ7nIo4P2Lplsbqad5uz9F1VzDGl/Ue8NmPQ2oXss3rm4OzPAUQJXwYVvqLKoe5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734340; c=relaxed/simple;
	bh=zUhb2Jpfmjjf8knvzp6hvnkIyqENIRiPfN7gIkKA9dI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Qg3Cw80AlbjI6FhzGDwHu2Hpf2F9wnZWOKXU399Nws0LVf4i8BpWiAIIXwWfgGsinefzu97mr/ONeJ7trY42MEwSs2zTLvYmv4qevc0uGsPzf4pf/+XnDqL5Yj8rZM7PNvSXdfM6BZPYKRqds6inqDQRpvarhrlwOyhhN5TzpVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffU6S9bo; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b109c6b9fcso43245291cf.3;
        Mon, 01 Sep 2025 06:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756734338; x=1757339138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnTbdSPn2NkfEUUrX/KyL5G6w1/N0r+8MK+VhlrrUMU=;
        b=ffU6S9bo8tO1nRvPbiySlPBSrRKqzkdZ4SFMSg+uzuGeGBDs0i7UIKRlILOSVxBFRF
         w7I6WA/1RONrg+77nTn8KR1419wkQL3u5Lzv8E/y9cEIXejHkfIDW4BtuUgN5VC/I3bj
         xTb0dYAaQ9gvRDJyduWHMi+SbmW7kfP+eEmMPt8QubxuKZHGF9PUDcQnm//kZ0aYJC5U
         KBKXURaHGSVo3tLE0fcFLUqQtponKCFnkByuf7m9OYpuZRSRcQsVae4ttHu/oM+j4ma0
         h7uzjwxU/6JiaE3hwMOBCzgOF2MO8iz80b75+0sxp7LASb3A2haYqaGFZ/LnYv/cEejt
         TQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756734338; x=1757339138;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rnTbdSPn2NkfEUUrX/KyL5G6w1/N0r+8MK+VhlrrUMU=;
        b=JNeNLwFL0UJiDPaEga0kK/hLA83rr59CCU5dCDmKS7OQuRvg6YwG+nUshv59HST2cK
         +DjxUdYQwHfE3kUXMcx2Yx+WWRqB4wWBF7RAJY97+xARU2qPaWwNmhySagieORMmD5UF
         7tVpxm1cR4puPxwJ4T8NXP0QtioJPiRTTR3l0e4Rd3Q5AHXDVP1I0UaIhKuUeimXW38y
         3PUuGoTilDxry4Tm7jGS3baJTCsjvCFK4nitBNGzsVSxnx7ZanBoy9RI3znU7t8FHYfY
         hzIHxe7ApuANhj1+0x1fB7raECXLzx0dlOegReYnvPHf06xhY2g6XOar5afpFiq7aIVb
         +/jA==
X-Forwarded-Encrypted: i=1; AJvYcCVZf8LGH7iExY1yLGNLbKN8KqReukxHApSMBYn2p8O98KkwEaxDLRT3pmNj5H4Q830rs4oPEcQX@vger.kernel.org, AJvYcCW65MzZnXtfSyCs97chspd9rEPELx9tPuX7CNEFqaeGV9ArgGUk9Rl7sYV2vNqCLbduXOUuU3ynrJ95snI=@vger.kernel.org, AJvYcCXjc6Ty1FZ0hhVVNaSEjsuir7eXNgPzp/TXTAotSpmVRSllwBm/brElkyAu776ItRCaT1f863lap7aaALeW9UEM@vger.kernel.org
X-Gm-Message-State: AOJu0YyhKaLOE1L2qKEQ12Qw2h1H2fPiAxqnI9P4HEDPCXGiyAR0xzF/
	GZXJvb5SOJVvHi0SEeGPvTvBNJl7BWghnQYwMTMu0ffd10ww008/t3QJ
X-Gm-Gg: ASbGncveAQgX6FvBe3ILcQ0oKwFcu5/JS3NLzZreZCp7ffRJc4TFq/GtzvpiOxGjeO0
	IeJt6S2JFDVQiI3mCPJ7y+KO7dkU3F5izp50pQW3F0jiGREuOu+lb8cv5fEueoFZTpbEmMRN+kT
	Gy/OJqrdl5wn879EOy/nwy3hhdvrEJjgRk9quXwZfetq5dwyL4EXL9BfGw6gUen4AKOwauDspau
	iGS8zx0nhWWPYvUfHjIsT6ODH/Nn31qWzzva5PPlH7N94MkgT4tR+Mf2IrKwRL1X4kfRHFPHrAX
	5QkJwEbcjgN7wIiBWaa4uDqyt9b+JEON1eTx3mN9bAHm2dXXBjeSayO5xn5Lpmkpy5b8KYwtKb8
	iFBAXdf/m8t04bfepPCZrk0zjjxQVFiJO8E+cfB6FkSksNEYLRbEEVA6qO1evYXzV7CiomxxajK
	XaMg==
X-Google-Smtp-Source: AGHT+IH8M9rH4vv23ATVd61t3Zi6RxFtLvxmp2lXF8X5fC1CN4BhB6ApLNK/rW1SxQaTjNebzoYudw==
X-Received: by 2002:a05:622a:394:b0:4b2:9b56:84c5 with SMTP id d75a77b69052e-4b31d9e45a9mr90841861cf.26.1756734337774;
        Mon, 01 Sep 2025 06:45:37 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b30b54d06csm60055641cf.13.2025.09.01.06.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 06:45:37 -0700 (PDT)
Date: Mon, 01 Sep 2025 09:45:36 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Brett A C Sheffield <bacs@librecast.net>, 
 willemdebruijn.kernel@gmail.com
Cc: bacs@librecast.net, 
 davem@davemloft.net, 
 edumazet@google.com, 
 gregkh@linuxfoundation.org, 
 horms@kernel.org, 
 kuba@kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 willemb@google.com
Message-ID: <willemdebruijn.kernel.2e347bb16a45e@gmail.com>
In-Reply-To: <20250901123757.13112-1-bacs@librecast.net>
References: <20250901123757.13112-1-bacs@librecast.net>
Subject: Re: [PATCH net-next v4] selftests: net: add test for ipv6
 fragmentation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Brett A C Sheffield wrote:
> Add selftest for the IPv6 fragmentation regression which affected
> several stable kernels.
> 
> Commit a18dfa9925b9 ("ipv6: save dontfrag in cork") was backported to
> stable without some prerequisite commits.  This caused a regression when
> sending IPv6 UDP packets by preventing fragmentation and instead
> returning -1 (EMSGSIZE).
> 
> Add selftest to check for this issue by attempting to send a packet
> larger than the interface MTU. The packet will be fragmented on a
> working kernel, with sendmsg(2) correctly returning the expected number
> of bytes sent.  When the regression is present, sendmsg returns -1 and
> sets errno to EMSGSIZE.
> 
> Link: https://lore.kernel.org/stable/aElivdUXqd1OqgMY@karahi.gladserv.com
> Signed-off-by: Brett A C Sheffield <bacs@librecast.net>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
> v4 changes:
>  - fix "else should follow close brace" (checkpatch ERROR)

Reminder to send only only iteration to netdev per 24 hrs.
 
> v3 changes:
>  - add usleep instead of busy polling on sendmsg
>  - simplify error handling by using error() and leaving cleanup to O/S
>  - use loopback interface - don't bother creating TAP
>  - send to localhost (::1)
 

> +/* no need to wait for DAD in our namespace */
> +static int disable_dad(char *ifname)
> +{
> +	char sysvar[] = "/proc/sys/net/ipv6/conf/%s/accept_dad";
> +	char fname[IFNAMSIZ + sizeof(sysvar)];
> +	int fd;
> +
> +	snprintf(fname, sizeof(fname), sysvar, ifname);
> +	fd = open(fname, O_WRONLY);
> +	if (fd == -1)
> +		error(KSFT_FAIL, errno, "open accept_dad");
> +	if (write(fd, "0", 1) != 1)
> +		error(KSFT_FAIL, errno, "write accept_dad");
> +
> +	return close(fd);
> +}

Is this needed with loopback?

> +int main(void)
> +{
> +	struct in6_addr addr = {
> +		.s6_addr[15] = 0x01, /* ::1 */
> +	};
> +	struct sockaddr_in6 sa = {
> +		.sin6_family = AF_INET6,
> +		.sin6_addr = addr,
> +		.sin6_port = 9      /* port 9/udp (DISCARD) */

htons

> +	};
> +	char buf[LARGER_THAN_MTU] = {0};

That's a large stack allocation. static char?

> +	ns_fd = setup();
> +	s = socket(AF_INET6, SOCK_DGRAM, 0);
> +send_again:
> +	rc = sendmsg(s, &msg, 0);
> +	if (rc == -1) {
> +		/* if interface wasn't ready, try again */
> +		if (errno == EADDRNOTAVAIL) {
> +			usleep(1000);
> +			goto send_again;
> +		}
> +		printf("[FAIL] sendmsg: %s\n", strerror(errno));
> +	} else if (rc != LARGER_THAN_MTU) {
> +		printf("[FAIL] sendmsg() returned %zi, expected %i\n", rc, LARGER_THAN_MTU);
> +	} else {
> +		printf("[PASS] sendmsg() returned %zi\n", rc);
> +		err = KSFT_PASS;

slight preference to just fail with error() in the two error cases and
let the expected common path be linear and succeed:

    if (rc == -1) {
            if (..)
                    goto send_again;
            error(KSFT_FAIL, ..);
    }
    if (rc != LARGER_THAN_MTU) {
            error(KSFT_FAIL, ..);
    }

    printf(..)
    return KSFT_PASS;

> +	}
> +	close(s);
> +	close(ns_fd);

ns_fd is always -1. Check all system calls return values. Now that
setup internally can fail with error() no need for return values at
all.

> +	return err;
> +}
> 
> base-commit: 864ecc4a6dade82d3f70eab43dad0e277aa6fc78
> -- 
> 2.49.1
> 



