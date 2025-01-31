Return-Path: <linux-kselftest+bounces-25494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010C5A24231
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 18:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6001B1686BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 17:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59581F2C29;
	Fri, 31 Jan 2025 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QO5UK8lU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F971F2360;
	Fri, 31 Jan 2025 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738345548; cv=none; b=s33bf7AOJLAK88vWJ9laBN/MR3gY8C4WOZ6FjAGv8OXjJxdqrZa9jxJWdGrMl2m8FJRwqK/YlUFaZvkp0o3Nyl8mi4UZLAwQJj0fnBb7LpkL7xFJQlMHlnMw/Fw3TAAboBNV1EWAOnFHA19AmAC+eTqNtgVYEcTkA97xGuoyKx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738345548; c=relaxed/simple;
	bh=LtizhXTHtfGr0a4uyDDlAcCu32NCBWRWgX358My2va0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueQAhwaKg0KtC+vkd9pw3Vg/zJQLfJM38aJpfsnpn6aDlcJ7db4AUlIX+pWRw0uP3ItgeDbh1Ju7+8wcg8SVqhq6fRNd2LXbQ0jfXyrxikQ7Ev78ruCslvGDe4UW8VMlrccUfdQ7IPpGCE7gTrCM0eJHosemhyzMLHv1tmyyiPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QO5UK8lU; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21669fd5c7cso40691265ad.3;
        Fri, 31 Jan 2025 09:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738345546; x=1738950346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AHGax4hoNoCFK8uMn60wvh4xfs/D3J09QEwYzNMX7L8=;
        b=QO5UK8lU30rp5pENEcglL7dQBChyckvao6Y7ZXnnV7JH/DITdC3Ol+ENgNzWtCCaCv
         0EIY72pDzNvu241fJEyiuAz9qFTA/4yombP8I/0wf/ecQcVqqUUNKtznSALQmWt5d628
         2sdYFYNil3q1TOt4USoazfWjqpao84C7vn2z+FLkpDJuadW6rDCtw13EjDnj+2BcrVQ5
         +4Pk92OGgDrHbuz418/kr/T4otXmd1PSjhw/5ZG7VX9OmZRMzfEEGMmtHN+mLsHeebHE
         Qr1p/rkr1FCqV/mG4KCNgF77Ni98hkejaBhfzpIMcNa7LQ1LQkM0OPjmDYJNySAZuGME
         g1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738345546; x=1738950346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHGax4hoNoCFK8uMn60wvh4xfs/D3J09QEwYzNMX7L8=;
        b=fh88PAaErhwiCN8tfKeuGWyon3CMEL2v/lNIm3aOeKTa8kNbef3lM77af+IPIefD9C
         Fih08VypTFIpXs8DZMqP6eR/pcb3BVxedTxuyKUyHDDexaTZmNmBXX4k+v4yzeVgPKdB
         c4SLZmtIS6eDrSJKYzHPjj9Zu8lz92cXOD7hBUUjNNgDKRWTHHqUOZRzFezM7NmTTijl
         WHXA0KoQUhdg3/CdOs1OqeSawQ4/uEv2dFuqsiPSMwx3TcIGMJpgWBynl6nayOPYPO0k
         OwbAaDuSQjXt6rYLErHXO9Ft74MRnP3HTjW8v3HHAE1wSOyk2xNmKzOMdzeBElLX4kC2
         0kaw==
X-Forwarded-Encrypted: i=1; AJvYcCVf8Fu3ih/ib/QOlOU3E+WOT2Qlif9L1JAVVQn8RDMdkCEQ4RDnlBnNzLGjXWe8g7Sn4E0Z0OPwOdHyPq4aUNON@vger.kernel.org, AJvYcCVxbZvFxBiKkG4sHZXoFBAsX1UkAKKepfwy1Xye4wxwCqvRU6TTwza3IwAf+IfIgpwWFSVsBNUPGtzA@vger.kernel.org, AJvYcCWVZtC5Mg3AJAb6R/1CazworJFvVGUpFNq6OtqCtT3FUExFBhItUGgYfshyMaGyHIhjNIFPO3uClRdWRQW2@vger.kernel.org, AJvYcCXJblFc4hGu5tdoKzOi23qwHw2F65CXMV7tGWzGhDb1EpN53NGw46iU7M/1LEXvYaMIkys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAjVKf2G7cP2JMdHbKhkpTMnvBRt75LjHxqBY1UP5Qutb/Piam
	4R6NXPYg3+9PC2xL9MBASaq5c3/5NBFxY9YO+1aBVV8sPtiHOno=
X-Gm-Gg: ASbGncvlyu1C5YIx/8tzIM59BbK9PzNqeV6kwUUdMVNw3y9GJ9IEfxpiyencH+Y2GRj
	jk/MmZlJ1edjFtgO8a2+2qhfMUbLQDwWV7nClqTrQA7tFDlyrv4Of7cajdDSYyp8T4sJ4odh+8o
	DQTdBRNmo47LDibQovMYA0q02IEhyqzthP/uyLmmTn4GiJgd0ifOlvqVJd2iKDU+UutqC+ys7dU
	4/gR7WsE9mlPXwOeddWxXYQKtb/vsC0bjbIzDyyomEiS1gnvBLBx2D2XUow/Bi7MzjVhztvUAaM
	mi4eo+fpox8G7q0=
X-Google-Smtp-Source: AGHT+IFmqTOI0/2HC2NK8R/nQ3xP1/wKaQScsH01OoR9/XrAZ3uJwlCmnrJ/mGKIBgwmAauKXsrbOA==
X-Received: by 2002:a05:6a00:2183:b0:725:c8ea:b30b with SMTP id d2e1a72fcca58-72fd0c0b836mr14940619b3a.11.1738345545868;
        Fri, 31 Jan 2025 09:45:45 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe69bbb7esm3702551b3a.106.2025.01.31.09.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 09:45:45 -0800 (PST)
Date: Fri, 31 Jan 2025 09:45:44 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: Re: [PATCH RFC net-next v2 2/6] selftests: ncdevmem: Implement
 devmem TCP TX
Message-ID: <Z50MSEBi2yQ99Y5z@mini-arch>
References: <20250130211539.428952-1-almasrymina@google.com>
 <20250130211539.428952-3-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250130211539.428952-3-almasrymina@google.com>

On 01/30, Mina Almasry wrote:
> Add support for devmem TX in ncdevmem.
> 
> This is a combination of the ncdevmem from the devmem TCP series RFCv1
> which included the TX path, and work by Stan to include the netlink API
> and refactored on top of his generic memory_provider support.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> ---
> 
> v2:
> - make errors a static variable so that we catch instances where there
>   are less than 20 errors across different buffers.
> - Fix the issue where the seed is reset to 0 instead of its starting
>   value 1.
> - Use 1000ULL instead of 1000 to guard against overflow (Willem).
> - Do not set POLLERR (Willem).
> - Update the test to use the new interface where iov_base is the
>   dmabuf_offset.
> - Update the test to send 2 iov instead of 1, so we get some test
>   coverage over sending multiple iovs at once.
> - Print the ifindex the test is using, useful for debugging issues where
>   maybe the test may fail because the ifindex of the socket is different
>   from the dmabuf binding.
> ---
>  .../selftests/drivers/net/hw/ncdevmem.c       | 276 +++++++++++++++++-
>  1 file changed, 272 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> index 19a6969643f4..8455f19ecd1a 100644
> --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> @@ -40,15 +40,18 @@
>  #include <fcntl.h>
>  #include <malloc.h>
>  #include <error.h>
> +#include <poll.h>
>  
>  #include <arpa/inet.h>
>  #include <sys/socket.h>
>  #include <sys/mman.h>
>  #include <sys/ioctl.h>
>  #include <sys/syscall.h>
> +#include <sys/time.h>
>  
>  #include <linux/memfd.h>
>  #include <linux/dma-buf.h>
> +#include <linux/errqueue.h>
>  #include <linux/udmabuf.h>
>  #include <libmnl/libmnl.h>
>  #include <linux/types.h>
> @@ -80,6 +83,8 @@ static int num_queues = -1;
>  static char *ifname;
>  static unsigned int ifindex;
>  static unsigned int dmabuf_id;
> +static uint32_t tx_dmabuf_id;
> +static int waittime_ms = 500;
>  
>  struct memory_buffer {
>  	int fd;
> @@ -93,6 +98,8 @@ struct memory_buffer {
>  struct memory_provider {
>  	struct memory_buffer *(*alloc)(size_t size);
>  	void (*free)(struct memory_buffer *ctx);
> +	void (*memcpy_to_device)(struct memory_buffer *dst, size_t off,
> +				 void *src, int n);
>  	void (*memcpy_from_device)(void *dst, struct memory_buffer *src,
>  				   size_t off, int n);
>  };
> @@ -153,6 +160,20 @@ static void udmabuf_free(struct memory_buffer *ctx)
>  	free(ctx);
>  }
>  
> +static void udmabuf_memcpy_to_device(struct memory_buffer *dst, size_t off,
> +				     void *src, int n)
> +{
> +	struct dma_buf_sync sync = {};
> +
> +	sync.flags = DMA_BUF_SYNC_START | DMA_BUF_SYNC_WRITE;
> +	ioctl(dst->fd, DMA_BUF_IOCTL_SYNC, &sync);
> +
> +	memcpy(dst->buf_mem + off, src, n);
> +
> +	sync.flags = DMA_BUF_SYNC_END | DMA_BUF_SYNC_WRITE;
> +	ioctl(dst->fd, DMA_BUF_IOCTL_SYNC, &sync);
> +}
> +
>  static void udmabuf_memcpy_from_device(void *dst, struct memory_buffer *src,
>  				       size_t off, int n)
>  {
> @@ -170,6 +191,7 @@ static void udmabuf_memcpy_from_device(void *dst, struct memory_buffer *src,
>  static struct memory_provider udmabuf_memory_provider = {
>  	.alloc = udmabuf_alloc,
>  	.free = udmabuf_free,
> +	.memcpy_to_device = udmabuf_memcpy_to_device,
>  	.memcpy_from_device = udmabuf_memcpy_from_device,
>  };
>  
> @@ -188,7 +210,7 @@ void validate_buffer(void *line, size_t size)
>  {
>  	static unsigned char seed = 1;
>  	unsigned char *ptr = line;
> -	int errors = 0;
> +	static int errors;
>  	size_t i;
>  
>  	for (i = 0; i < size; i++) {
> @@ -202,7 +224,7 @@ void validate_buffer(void *line, size_t size)
>  		}
>  		seed++;
>  		if (seed == do_validation)
> -			seed = 0;
> +			seed = 1;
>  	}
>  
>  	fprintf(stdout, "Validated buffer\n");
> @@ -394,6 +416,49 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
>  	return -1;
>  }
>  
> +static int bind_tx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
> +			 struct ynl_sock **ys)
> +{
> +	struct netdev_bind_tx_req *req = NULL;
> +	struct netdev_bind_tx_rsp *rsp = NULL;
> +	struct ynl_error yerr;
> +
> +	*ys = ynl_sock_create(&ynl_netdev_family, &yerr);
> +	if (!*ys) {
> +		fprintf(stderr, "YNL: %s\n", yerr.msg);
> +		return -1;
> +	}
> +
> +	req = netdev_bind_tx_req_alloc();
> +	netdev_bind_tx_req_set_ifindex(req, ifindex);
> +	netdev_bind_tx_req_set_fd(req, dmabuf_fd);
> +
> +	rsp = netdev_bind_tx(*ys, req);
> +	if (!rsp) {
> +		perror("netdev_bind_tx");
> +		goto err_close;
> +	}
> +
> +	if (!rsp->_present.id) {
> +		perror("id not present");
> +		goto err_close;
> +	}
> +
> +	fprintf(stderr, "got tx dmabuf id=%d\n", rsp->id);
> +	tx_dmabuf_id = rsp->id;
> +
> +	netdev_bind_tx_req_free(req);
> +	netdev_bind_tx_rsp_free(rsp);
> +
> +	return 0;
> +
> +err_close:
> +	fprintf(stderr, "YNL failed: %s\n", (*ys)->err.msg);
> +	netdev_bind_tx_req_free(req);
> +	ynl_sock_destroy(*ys);
> +	return -1;
> +}
> +
>  static void enable_reuseaddr(int fd)
>  {
>  	int opt = 1;
> @@ -432,7 +497,7 @@ static int parse_address(const char *str, int port, struct sockaddr_in6 *sin6)
>  	return 0;
>  }
>  
> -int do_server(struct memory_buffer *mem)
> +static int do_server(struct memory_buffer *mem)
>  {
>  	char ctrl_data[sizeof(int) * 20000];
>  	struct netdev_queue_id *queues;
> @@ -686,6 +751,207 @@ void run_devmem_tests(void)
>  	provider->free(mem);
>  }
>  
> +static uint64_t gettimeofday_ms(void)
> +{
> +	struct timeval tv;
> +
> +	gettimeofday(&tv, NULL);
> +	return (tv.tv_sec * 1000ULL) + (tv.tv_usec / 1000ULL);
> +}
> +
> +static int do_poll(int fd)
> +{
> +	struct pollfd pfd;
> +	int ret;
> +
> +	pfd.revents = 0;
> +	pfd.fd = fd;
> +
> +	ret = poll(&pfd, 1, waittime_ms);
> +	if (ret == -1)
> +		error(1, errno, "poll");
> +
> +	return ret && (pfd.revents & POLLERR);
> +}
> +
> +static void wait_compl(int fd)
> +{
> +	int64_t tstop = gettimeofday_ms() + waittime_ms;
> +	char control[CMSG_SPACE(100)] = {};
> +	struct sock_extended_err *serr;
> +	struct msghdr msg = {};
> +	struct cmsghdr *cm;
> +	int retries = 10;
> +	__u32 hi, lo;
> +	int ret;
> +
> +	msg.msg_control = control;
> +	msg.msg_controllen = sizeof(control);
> +
> +	while (gettimeofday_ms() < tstop) {
> +		if (!do_poll(fd))
> +			continue;
> +
> +		ret = recvmsg(fd, &msg, MSG_ERRQUEUE);
> +		if (ret < 0) {
> +			if (errno == EAGAIN)
> +				continue;
> +			error(1, ret, "recvmsg(MSG_ERRQUEUE)");
> +			return;
> +		}
> +		if (msg.msg_flags & MSG_CTRUNC)
> +			error(1, 0, "MSG_CTRUNC\n");
> +
> +		for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
> +			if (cm->cmsg_level != SOL_IP &&
> +			    cm->cmsg_level != SOL_IPV6)
> +				continue;
> +			if (cm->cmsg_level == SOL_IP &&
> +			    cm->cmsg_type != IP_RECVERR)
> +				continue;
> +			if (cm->cmsg_level == SOL_IPV6 &&
> +			    cm->cmsg_type != IPV6_RECVERR)
> +				continue;
> +
> +			serr = (void *)CMSG_DATA(cm);
> +			if (serr->ee_origin != SO_EE_ORIGIN_ZEROCOPY)
> +				error(1, 0, "wrong origin %u", serr->ee_origin);
> +			if (serr->ee_errno != 0)
> +				error(1, 0, "wrong errno %d", serr->ee_errno);
> +
> +			hi = serr->ee_data;
> +			lo = serr->ee_info;
> +
> +			fprintf(stderr, "tx complete [%d,%d]\n", lo, hi);
> +			return;
> +		}
> +	}
> +
> +	error(1, 0, "did not receive tx completion");
> +}
> +
> +static int do_client(struct memory_buffer *mem)
> +{
> +	char ctrl_data[CMSG_SPACE(sizeof(struct dmabuf_tx_cmsg))];
> +	struct sockaddr_in6 server_sin;
> +	struct sockaddr_in6 client_sin;
> +	struct dmabuf_tx_cmsg ddmabuf;
> +	struct ynl_sock *ys = NULL;
> +	struct msghdr msg = {};
> +	ssize_t line_size = 0;
> +	struct cmsghdr *cmsg;
> +	struct iovec iov[2];
> +	uint64_t off = 100;
> +	char *line = NULL;
> +	size_t len = 0;
> +	int socket_fd;
> +	int ret, mid;
> +	int opt = 1;
> +
> +	ret = parse_address(server_ip, atoi(port), &server_sin);
> +	if (ret < 0)
> +		error(1, 0, "parse server address");
> +
> +	socket_fd = socket(AF_INET6, SOCK_STREAM, 0);
> +	if (socket_fd < 0)
> +		error(1, socket_fd, "create socket");
> +
> +	enable_reuseaddr(socket_fd);
> +
> +	ret = setsockopt(socket_fd, SOL_SOCKET, SO_BINDTODEVICE, ifname,
> +			 strlen(ifname) + 1);
> +	if (ret)
> +		error(1, ret, "bindtodevice");
> +
> +	if (bind_tx_queue(ifindex, mem->fd, &ys))
> +		error(1, 0, "Failed to bind\n");
> +

[..]

> +	ret = parse_address(client_ip, atoi(port), &client_sin);
> +	if (ret < 0)
> +		error(1, 0, "parse client address");
> +
> +	ret = bind(socket_fd, &client_sin, sizeof(client_sin));
> +	if (ret)
> +		error(1, ret, "bind");
> +

Can we wrap the two above in 'if (client_ip) {}'? For my case, as long as
we do SO_BINDTODEVICE, the autobind will do the right thing and I don't
have to explicitly pass '-c' (ncdemem crashes right now if it's
not passed).

> +	ret = setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
> +	if (ret)
> +		error(1, ret, "set sock opt");
> +
> +	fprintf(stderr, "Connect to %s %d (via %s)\n", server_ip,
> +		ntohs(server_sin.sin6_port), ifname);
> +

[..]

> +	ret = connect(socket_fd, &server_sin, sizeof(server_sin));
> +	if (ret)
> +		error(1, ret, "connect");

The most new error() invocations, you pass 'ret' as a second argument.
We need to use 'errno' instead where possible to give the users correct errors
for diagnostics.

> +
> +	while (1) {
> +		free(line);
> +		line = NULL;
> +		/* Subtract 1 from line_size to remove trailing newlines that
> +		 * get_line are surely to parse...
> +		 */
> +		line_size = getline(&line, &len, stdin) - 1;
> +
> +		if (line_size < 0)
> +			break;
> +
> +		mid = (line_size / 2) + 1;
> +
> +		iov[0].iov_base = (void *)100;
> +		iov[0].iov_len = mid;
> +		iov[1].iov_base = (void *)2000;
> +		iov[1].iov_len = line_size - mid;
> +
> +		provider->memcpy_to_device(mem, (size_t)iov[0].iov_base, line,
> +					   iov[0].iov_len);

This generates the following on my side:

ncdevmem.c:911:15: warning: format specifies type 'int' but the argument has type 'uint64_t' (aka 'unsigned long') [-Wformat]
  910 |                         "read line_size=%ld off=%d iov[0].iov_base=%d, iov[0].iov_len=%d, iov[1].iov_base=%d, iov[1].iov_len=%d\n",
      |                                                 ~~
      |                                                 %lu
  911 |                         line_size, off, iov[0].iov_base, iov[0].iov_len,
      |                                    ^~~
ncdevmem.c:911:20: warning: format specifies type 'int' but the argument has type 'void *' [-Wformat]
  910 |                         "read line_size=%ld off=%d iov[0].iov_base=%d, iov[0].iov_len=%d, iov[1].iov_base=%d, iov[1].iov_len=%d\n",
      |                                                                    ~~
  911 |                         line_size, off, iov[0].iov_base, iov[0].iov_len,
      |                                         ^~~~~~~~~~~~~~~
ncdevmem.c:911:37: warning: format specifies type 'int' but the argument has type '__kernel_size_t' (aka 'unsigned long') [-Wformat]
  910 |                         "read line_size=%ld off=%d iov[0].iov_base=%d, iov[0].iov_len=%d, iov[1].iov_base=%d, iov[1].iov_len=%d\n",
      |                                                                                       ~~
      |                                                                                       %lu
  911 |                         line_size, off, iov[0].iov_base, iov[0].iov_len,
      |                                                          ^~~~~~~~~~~~~~
ncdevmem.c:912:4: warning: format specifies type 'int' but the argument has type 'void *' [-Wformat]
  910 |                         "read line_size=%ld off=%d iov[0].iov_base=%d, iov[0].iov_len=%d, iov[1].iov_base=%d, iov[1].iov_len=%d\n",
      |                                                                                                           ~~
  911 |                         line_size, off, iov[0].iov_base, iov[0].iov_len,
  912 |                         iov[1].iov_base, iov[1].iov_len);
      |                         ^~~~~~~~~~~~~~~
ncdevmem.c:912:21: warning: format specifies type 'int' but the argument has type '__kernel_size_t' (aka 'unsigned long') [-Wformat]
  910 |                         "read line_size=%ld off=%d iov[0].iov_base=%d, iov[0].iov_len=%d, iov[1].iov_base=%d, iov[1].iov_len=%d\n",
      |                                                                                                                              ~~
      |                                                                                                                              %lu
  911 |                         line_size, off, iov[0].iov_base, iov[0].iov_len,
  912 |                         iov[1].iov_base, iov[1].iov_len);
      |                                          ^~~~~~~~~~~~~~

