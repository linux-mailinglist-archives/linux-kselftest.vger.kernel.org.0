Return-Path: <linux-kselftest+bounces-25453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84204A23797
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 00:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6EB3A772F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 23:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298431F130D;
	Thu, 30 Jan 2025 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPMVWsL5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFA619006F;
	Thu, 30 Jan 2025 23:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738278328; cv=none; b=adedlU8ICXii6bkKYuml8h3V0B2ZuACndozv2l1QKeQCgrkDd6yhaKNQ3TTWsoOmtTZWJaBfnA3SmSVpACeXAQewqJSJ/XtUqkL4mOzI7G7hkANOXLtUF4RvhhUDURDf6idilvHP09WErPY8fqtIvozSofdaa3SBP0Q3k6yKN98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738278328; c=relaxed/simple;
	bh=oX+vDadGyUiqv4+oWeZ2tS8At04HdG1Fuw71i+G+9M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzutQqthex/W8hoiXIxT0cJJWdz8AINOW9C70KBU1hoCXI3gkrB056u3Geic4SezQHgTJna2fS5w2mEHVOqt9JdfhliscPHtWzmtiMhnvimLb7GtNnSS0Zpz2uRZnZUTKwRwqAjjGlUMJZMnnqr/ktcdU/CHa571xUs25FtKQSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPMVWsL5; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso1831322a91.1;
        Thu, 30 Jan 2025 15:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738278325; x=1738883125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WICdH51S127J9PzlzomBDnMtgVSX3AbSg3nriL6O+OA=;
        b=jPMVWsL52RgwxD17LOFShz0djBng5o/xqLCJvnpdBGTCH3Ixl1uDdoVCl4USCDN4sd
         Uz6eC0kzZhDZAAmKTPqYGYWWGJAZzG0ryMPytVdkK3+FNMEpHjUeSQKNyhL5nD3HsuTA
         cly1H7Y+mWRqBllVX2TF06jt2PrTCOiqPi8JciT3SPdf4/h7pgUbA8n6B4stljAzinWC
         RnNCJ7s2eneAct8kMlLqavOd3lvOPINyqnw+9ShXObqHbx7NsrTNaUZfMFZxOQqcQHSe
         O/mS1JrYA4iLWoadB1YWKNZr6Kiq/i1BiZKm8Eyd9isBj3VwD0k2P/o0SRSOEiZAmRCN
         isHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738278325; x=1738883125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WICdH51S127J9PzlzomBDnMtgVSX3AbSg3nriL6O+OA=;
        b=ljC2HCTqzXhPlb6kyTKB/Wro3OQTROer4uhB5jp2LBRY2MwsvojkptE4Y/Mz4dRudr
         yPsZyZ6pIxD+U/AapwAGXu5wtawMIWQllkvF5AVDWBUsiE9W6g+IZVBZyomOePYp8Gw5
         qN5ldMuLBt6//QTZ9iMax1ZGAa5wHAJTDTGDlnkMzQpb/E8FX8lMwblHR0sWwbt+LcVg
         Kn15qf7Fy89VQsTSK9lI/YYXh34zQt51todSrIU1sZ+WNDUQQZUBiarXgZQq9yn3OqbK
         PZaW1V6pQJQFltGIlKtzOHHbwNYs0Q9zP8WHWqSFz5AwatuoMCoXT/6Bt0YHGcJ8m0x4
         JoSw==
X-Forwarded-Encrypted: i=1; AJvYcCUT0evTQP3h//otQSYADoJXtCAHmXqM/wq1sm4YO4vR0Q7b6JJqnlZi35K+CYQGht1dl+LH8zsgBzMKmR3O@vger.kernel.org, AJvYcCUYaiJTd4TunBByDLwyLoIGYbzmge2sSOlZ9g7qS79h6YI9wzBTMVsePbhGtNBN/2YdaeaKJMsyHG+M@vger.kernel.org, AJvYcCWFu+5N0cONvrF2fqsogH0UKWpSD3L4qdoCQZeKVzdUyuFcNRyYj5XoPUPl9XkXNvGisC4mnveEJtDdyQUuWxh7@vger.kernel.org, AJvYcCXBA4toagfgGIw/uZe2tCZvxqfhY39Sh5u8Ug/V7QbLsdxn9FkNBfsvZH/zvvvVCvaVJkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx82/J1vu4qVfpHEfBDgR8J+ah6lIAUcGC5PBUmvBvEOykkEVZq
	GkwPIAoO8pIfOzjuyYy/2G/fCUBvbppj5jvZhnp72j4Ztnf+n2Q=
X-Gm-Gg: ASbGnctw1PXZmc/hOMiVIDnayN9BcWD7THQfEcKCYBdoMUAHX7bJ98iPZFCKfWW1UIc
	jLpuYIeB8OMC4DPdEQjFVDx+81lirAXLglJQTDuJdB/ekNq4JsmMHEgW7kfIrbnWs/KFZ0hXAZz
	09nu1ayfZhoagI6yDyK1y6YOJZec2Ju8cFSXNzVbyvXw9CN1iZ9uixP2l1wBUN+yqwgnGHLP2jR
	GAPukkcV74QCliLlqsjjwijGFTp04i4W+yiThImZDELu9QQtW0EcUrLDfohZlCNunicvR5eoY4d
	1GELKkx8OFhK768=
X-Google-Smtp-Source: AGHT+IGdacTBFsgqVod2DHsmK3HjZmnZudg8Nfs3KkTZyJqoDPkmRpC/K1f6p2Tya31UjoWh9t0ipg==
X-Received: by 2002:a05:6a00:2c88:b0:725:ea30:ab15 with SMTP id d2e1a72fcca58-72fd0bc25a9mr11543951b3a.1.1738278324804;
        Thu, 30 Jan 2025 15:05:24 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe653a9f3sm2008544b3a.75.2025.01.30.15.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 15:05:24 -0800 (PST)
Date: Thu, 30 Jan 2025 15:05:23 -0800
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
Message-ID: <Z5wFs3-6pNWARhRL@mini-arch>
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
> +	ret = parse_address(client_ip, atoi(port), &client_sin);
> +	if (ret < 0)
> +		error(1, 0, "parse client address");
> +
> +	ret = bind(socket_fd, &client_sin, sizeof(client_sin));
> +	if (ret)
> +		error(1, ret, "bind");
> +
> +	ret = setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
> +	if (ret)
> +		error(1, ret, "set sock opt");
> +
> +	fprintf(stderr, "Connect to %s %d (via %s)\n", server_ip,
> +		ntohs(server_sin.sin6_port), ifname);
> +
> +	ret = connect(socket_fd, &server_sin, sizeof(server_sin));
> +	if (ret)
> +		error(1, ret, "connect");
> +
> +	while (1) {
> +		free(line);
> +		line = NULL;
> +		/* Subtract 1 from line_size to remove trailing newlines that
> +		 * get_line are surely to parse...
> +		 */
> +		line_size = getline(&line, &len, stdin) - 1;

Why not send the '\n' as well? If we skip the '\n', it's not keeping
netcat-like behavior :-(

> +
> +		if (line_size < 0)
> +			break;

[..]

> +		mid = (line_size / 2) + 1;
> +
> +		iov[0].iov_base = (void *)100;
> +		iov[0].iov_len = mid;
> +		iov[1].iov_base = (void *)2000;
> +		iov[1].iov_len = line_size - mid;

This seems a bit hard-coded. We should at least test that mid is < 2000?

But ideally we should have two modes for tx with a flag (and run them
both from the selftest):
- pass one big iov, this will test the sendmsg path which creates
  multiple skbs internally
- break 'line' into N sections (as you do here), but maybe have more
  control over the number of sections?

Maybe let's have a new --max-iov-size flag? Then we can call ncdevmem
with --max-iov-size <some prime number close to 4k> to exercise all
sorts of weird offsets?

(seems ok to also follow up on that separately)

