Return-Path: <linux-kselftest+bounces-39730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 795A6B32423
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464CB606890
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894AC2E2EE5;
	Fri, 22 Aug 2025 21:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kONTZkki"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA01027780C;
	Fri, 22 Aug 2025 21:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897948; cv=none; b=NmKTiOBiTth0kM9Kjr5jhuBUr0lRV9BI14LhhegaFeyWQa29Cp7/j+MSrDCXlXz6sVskoeMRPxzp8favRiqxx7e7miG7ArvNvfru+q1MgwLHND0L6uiCN5r3tWJbgs61rxybQ0t6aE0Z8Bo8nMnSlwjkFHGz6e38Q7fMCbIQ/1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897948; c=relaxed/simple;
	bh=PyEJE4lX8bJRA4X2yjT0Huc+ZpwR/rAt/m/T/q1s4Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/rD0fqJv1EH/KskUwaTaeIj3jYdSP7T8HooiQRLEIXPfDu41YbYUy8DJf4cs3Fca0jixrcqAma7KHaRr+aFsl+i0WqUbSRtDnYlX6RVzc5Vh2Ins0bpWkBnk6Sk2uUutb/xweuUMv1VyDJXaxkIrQQrfRNpl9JW3MiqiMsEIuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kONTZkki; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24457f581aeso19651115ad.0;
        Fri, 22 Aug 2025 14:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755897946; x=1756502746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=noPk3pDZKA1ESTkZuU1/asvypuJ7e5/Eo8H7HZAECl0=;
        b=kONTZkki44PC2urLVNCXcs+gwsgpXsH7OkHAzbtHkoSbfBmIPB8sArXpSxVV5iErQ9
         vabu/YNayhaTXvbx1tjHKmouwM1ZRFlX8KeVoFcraYqgyhU5bJBUQt+NiZ556rVUfPFH
         BaJ4SkLiZyYgnlo2F05j/DrB7bZ0b0pleWjj/9y22fEksJg3Cn/Ip5L0z1p/S+jau0fv
         TDGUsnZDtWqc68wbnPgWbXyL9jH/UBKCVsp3Pk9nLLSH1CmVp3sUtI5mnQYVddEIdlOH
         AE/1zaf08mQKVlplga8j0ypuMkaU/syxkzzKyT5Nvkh/VxzJpn3R6FlIrTitZmaVJSvK
         2P9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897946; x=1756502746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noPk3pDZKA1ESTkZuU1/asvypuJ7e5/Eo8H7HZAECl0=;
        b=mVX4A7qI8y+tJvITTqRMntAClA2uzQJlE1kqQ24j+yGevFW4njOvpsmfLmvecswkXz
         ZVYXq4gGAfHmx+m6zu9QuY2egUDXswnF/NwxC9dQts4uEGgqcxjjhvjuuZprtBSyGkL1
         DkHjdx9lxGbjBkbMipkAwfpGrnV+0kzZVI8s7WkzfkJJpImStyGXcN3+Ud537Wh7qlyW
         S7UlM0eZ1qAYPjxgfOvUjCMBq0d1hG3Fl2mvRApNnsk1goptC7SU5OXmolxLP/I9AjXa
         j/X/LGhwJqDwec/WXhKiJ2lI8Gq/cNMWlskd6XJrBKYjFY3nptvG0J+uVmhS6pWLQI5W
         s0Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWqFZsdUkojLv53hFKxRpo9ko8u8lTXfx4dVeIJEZmp1Q2vyr04LdgK6AP8jmiuckbFgBdBMfx3@vger.kernel.org, AJvYcCXGz7wr/PN8+X+0tQVIW4d4VgIhQM/JjLXdchSbtfjcNZc3vxSSmjo1+FG+Fg1vwqUGob6ZHDq7ESNCDognIz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIrcl2WcKA8DVddlnB3x/xuj4DVEs2/9f/YbTi8HttmUy1fAJe
	/p9zI2eptb5J6hhICqXhJS6aeFxJpDiitCycxVs74fRLPUWdVxQKsGE=
X-Gm-Gg: ASbGncvPB6ZAoSS9AGuRS9//0Rv4VAAgO0KhCoYHAq/DNfmzgNHNXRFTjUl95e2HoH8
	4eKtquCZs5nxl83fl/fhvl5p3KbWGgI+xmg7XoKbj+/JyB6IJ9AijhWGQNa7zn3u+/rFM9d2fuE
	YNUByQ42XiAokoSku5r2nNCZItfCDWQdKYIcKeNI9LhRGyjsLltP8Ks8wYsE2psia+BayJI/lKg
	l4BQY5MNgp02fZIbtSwdWKuzc4m3ejhufwYYeE7jfQ+9xCpCMk1f/y3+lygHZ1Xsa+nxWQusZbU
	QiNhtmlzHab6cXLaj7mP4joZeQOJqJSA1FBs0WU4TM1uN8feArcs/mxhQYGOUrsMHSSmTK6gUth
	i5XLRdMSV1MoIM4H2DC/pYfV/ZmgdOoOXQSF7XFwAN8IB/prh0YaCnudTg7srfMSBvjr5cZNef1
	2YmKZ9MqX48u4x/2xfKfWIW5WizKuLxnCoGFLecpTc4nLXKzY+f5gsvkv5v1vUKzyZ6EzXA0576
	4PK
X-Google-Smtp-Source: AGHT+IEGDqW6+HTW2RzMWj5gmi3mF4Tu6FZIcKtkuS/kUYAvwr8K1mdAa0goBkBIPSSKpl71Hq1TmA==
X-Received: by 2002:a17:903:11c5:b0:240:3b9e:dd65 with SMTP id d9443c01a7336-2462ef44573mr54642815ad.38.1755897945870;
        Fri, 22 Aug 2025 14:25:45 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2466885efc8sm5088955ad.90.2025.08.22.14.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 14:25:45 -0700 (PDT)
Date: Fri, 22 Aug 2025 14:25:45 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	almasrymina@google.com, sdf@fomichev.me, joe@dama.to,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] selftests: drv-net: ncdevmem: remove use of
 error()
Message-ID: <aKjgWZnfWShtvi8m@mini-arch>
References: <20250822200052.1675613-1-kuba@kernel.org>
 <20250822200052.1675613-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250822200052.1675613-2-kuba@kernel.org>

On 08/22, Jakub Kicinski wrote:
> Using error() makes it impossible for callers to unwind their
> changes. Replace error() calls with proper error handling.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

> ---
>  .../selftests/drivers/net/hw/ncdevmem.c       | 528 ++++++++++++------
>  1 file changed, 364 insertions(+), 164 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> index 71961a7688e6..e75adfed33ac 100644
> --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> @@ -115,6 +115,21 @@ struct memory_provider {
>  				   size_t off, int n);
>  };
>  
> +static void pr_err(const char *fmt, ...)
> +{
> +	va_list args;
> +
> +	fprintf(stderr, "%s: ", TEST_PREFIX);
> +
> +	va_start(args, fmt);
> +	vfprintf(stderr, fmt, args);
> +	va_end(args);
> +
> +	if (errno != 0)
> +		fprintf(stderr, ": %s", strerror(errno));
> +	fprintf(stderr, "\n");
> +}
> +
>  static struct memory_buffer *udmabuf_alloc(size_t size)
>  {
>  	struct udmabuf_create create;
> @@ -123,27 +138,33 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
>  
>  	ctx = malloc(sizeof(*ctx));
>  	if (!ctx)
> -		error(1, ENOMEM, "malloc failed");
> +		return NULL;
>  
>  	ctx->size = size;
>  
>  	ctx->devfd = open("/dev/udmabuf", O_RDWR);
> -	if (ctx->devfd < 0)
> -		error(1, errno,
> -		      "%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
> -		      TEST_PREFIX);
> +	if (ctx->devfd < 0) {
> +		pr_err("[skip,no-udmabuf: Unable to access DMA buffer device file]");
> +		goto err_free_ctx;
> +	}
>  
>  	ctx->memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
> -	if (ctx->memfd < 0)
> -		error(1, errno, "%s: [skip,no-memfd]\n", TEST_PREFIX);
> +	if (ctx->memfd < 0) {
> +		pr_err("[skip,no-memfd]");
> +		goto err_close_dev;
> +	}
>  
>  	ret = fcntl(ctx->memfd, F_ADD_SEALS, F_SEAL_SHRINK);
> -	if (ret < 0)
> -		error(1, errno, "%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
> +	if (ret < 0) {
> +		pr_err("[skip,fcntl-add-seals]");
> +		goto err_close_memfd;
> +	}
>  
>  	ret = ftruncate(ctx->memfd, size);
> -	if (ret == -1)
> -		error(1, errno, "%s: [FAIL,memfd-truncate]\n", TEST_PREFIX);
> +	if (ret == -1) {
> +		pr_err("[FAIL,memfd-truncate]");
> +		goto err_close_memfd;
> +	}
>  
>  	memset(&create, 0, sizeof(create));
>  
> @@ -151,15 +172,29 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
>  	create.offset = 0;
>  	create.size = size;
>  	ctx->fd = ioctl(ctx->devfd, UDMABUF_CREATE, &create);
> -	if (ctx->fd < 0)
> -		error(1, errno, "%s: [FAIL, create udmabuf]\n", TEST_PREFIX);
> +	if (ctx->fd < 0) {
> +		pr_err("[FAIL, create udmabuf]");
> +		goto err_close_fd;
> +	}
>  
>  	ctx->buf_mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED,
>  			    ctx->fd, 0);
> -	if (ctx->buf_mem == MAP_FAILED)
> -		error(1, errno, "%s: [FAIL, map udmabuf]\n", TEST_PREFIX);
> +	if (ctx->buf_mem == MAP_FAILED) {
> +		pr_err("[FAIL, map udmabuf]");
> +		goto err_close_fd;
> +	}
>  
>  	return ctx;
> +
> +err_close_fd:
> +	close(ctx->fd);
> +err_close_memfd:
> +	close(ctx->memfd);
> +err_close_dev:
> +	close(ctx->devfd);
> +err_free_ctx:
> +	free(ctx);
> +	return NULL;
>  }
>  
>  static void udmabuf_free(struct memory_buffer *ctx)
> @@ -217,7 +252,7 @@ static void print_nonzero_bytes(void *ptr, size_t size)
>  		putchar(p[i]);
>  }
>  
> -void validate_buffer(void *line, size_t size)
> +int validate_buffer(void *line, size_t size)
>  {
>  	static unsigned char seed = 1;
>  	unsigned char *ptr = line;
> @@ -232,8 +267,10 @@ void validate_buffer(void *line, size_t size)
>  				"Failed validation: expected=%u, actual=%u, index=%lu\n",
>  				expected, ptr[i], i);
>  			errors++;
> -			if (errors > 20)
> -				error(1, 0, "validation failed.");
> +			if (errors > 20) {
> +				pr_err("validation failed");
> +				return -1;
> +			}
>  		}
>  		seed++;
>  		if (seed == do_validation)
> @@ -241,6 +278,7 @@ void validate_buffer(void *line, size_t size)
>  	}
>  
>  	fprintf(stdout, "Validated buffer\n");
> +	return 0;
>  }
>  
>  static int rxq_num(int ifindex)
> @@ -279,7 +317,7 @@ static int rxq_num(int ifindex)
>  		system(command);                                        \
>  	})
>  
> -static int reset_flow_steering(void)
> +static void reset_flow_steering(void)
>  {
>  	/* Depending on the NIC, toggling ntuple off and on might not
>  	 * be allowed. Additionally, attempting to delete existing filters
> @@ -292,7 +330,6 @@ static int reset_flow_steering(void)
>  	run_command(
>  		"ethtool -n %s | grep 'Filter:' | awk '{print $2}' | xargs -n1 ethtool -N %s delete >&2",
>  		ifname, ifname);
> -	return 0;
>  }
>  
>  static const char *tcp_data_split_str(int val)
> @@ -354,6 +391,11 @@ static int configure_rss(void)
>  	return run_command("ethtool -X %s equal %d >&2", ifname, start_queue);
>  }
>  
> +static void reset_rss(void)
> +{
> +	run_command("ethtool -X %s default >&2", ifname, start_queue);
> +}
> +
>  static int configure_channels(unsigned int rx, unsigned int tx)
>  {
>  	struct ethtool_channels_get_req *gchan;
> @@ -479,6 +521,7 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
>  
>  	*ys = ynl_sock_create(&ynl_netdev_family, &yerr);
>  	if (!*ys) {
> +		netdev_queue_id_free(queues);

Funny how you spotted this.. Ownership of these is complicated with ynl :-( 

