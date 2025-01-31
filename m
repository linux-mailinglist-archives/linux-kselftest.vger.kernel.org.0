Return-Path: <linux-kselftest+bounces-25493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB6AA24205
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 18:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104D2188987A
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 17:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1BD1F03F0;
	Fri, 31 Jan 2025 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUK+CXF5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AE41C54BE;
	Fri, 31 Jan 2025 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738345314; cv=none; b=sCGih6qsZ9Pgz129uwjt5ckpKH4WWzcp2qnaONkgI21Krt5zn1nexEyzLQSyA1QgVkGjKOx/swMOvKAjLTHZ/OdaI6o63CXP/USPHPgzIuEkRMW/OqHHHHXcIth3aJQnVUBHUkKK8Yf8jz9Mclz8Al2Yjn4EUYrRv31X7EG+DZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738345314; c=relaxed/simple;
	bh=bAGFgqEdTV83hpoQAyIT384UT6xy08QOsstKqB6QyGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfqWGH/naBIFwWPrOKzc052TCEbVdq8o502S3qyUwFJ9H6sSLHz/qaeg4HyDxDXUwat6GG+mSm1L2NnKcuCAwIRT1KMrOHLJHt65os9GjKxE7HY2t4fAIOSi2azRa+5Y5pf+sffimk7vmMueMSlqbt3LQiljn3tt+8ayZ0e8hhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUK+CXF5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2166022c5caso36194025ad.2;
        Fri, 31 Jan 2025 09:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738345312; x=1738950112; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G1TYB5ZCQ1ybqW72UIewmwEmMgd2Fd93EG20+CEEoDY=;
        b=iUK+CXF51DFeq8d1v9UJxKd8BHJdNNGrLXPrFvDS5hdOslyNklB7Qy1m0mp6Wd/4Vh
         ClZ2t5Ab/GEMQQVdolrggivZf0K8nCPboG8HhJ11oV8ZuL670UNr+Lhn5t7356I4D1ni
         sb47dZwkRzQ0nfrlKpQDoeWKGih1YUOrJ2LrklNjDrPAAUSQft+OvFznoqzrhQs4xZmi
         phFP6HHHZu6mZvIfQNLuFUKKZMHLgZIxLeJFDYnNAVcMzdruf6BNg5aW8hMvptZfEwEw
         /KFPa7VaXHSISWxk8s4/Q9eXFT/7FaFqkf4/TPuXBg9Fx6Tdh/knHPwNAiASonHUFXoj
         hqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738345312; x=1738950112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1TYB5ZCQ1ybqW72UIewmwEmMgd2Fd93EG20+CEEoDY=;
        b=IekvA8Mk4VCK8fVO9N9xlB2TtDoF3B8aQKy7LEbakH+/OQMu4F7oujC6jnzdtl0fBe
         Eas8MtzuNkbx20NEAlhjliC9SENssPAo6EaSYOcdsqhYsxKJ9RDLFmERuJXrRkus7xl5
         ZKMn2R0Md4knuUhgXvR6LW5uL6Pe6hY4nVWctBFsisRq75ojcy+Hbmuklu1wpmgYZBBx
         Z+fT4kbBy7nOxluYd5atBHgk4YEyVDhtsZugF+tWpVB8tHkS5A9nSv1TDfCxZdtpQF8m
         WckvrxoZASuEIXnPbGcCzSQc5ZkD1HGgFpZNT4gG7++/Vk1l0kRgb2lAXbHV1MkSmnak
         eCLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0JcxxABqWLQFs7LMsWzPYdhhJTsDgvy+sSi7FYVBDDE/jf9L+ILp7Al2G0oNgTmKy7OnafQpf6D2PgLd7usXY@vger.kernel.org, AJvYcCVUiEu97N44wgDLGJy4DymeNco9C3m+LEXyejR/qwmRDe8+Ot9ZbunnyKhKIm30n2n4SjiR+y7emNEP@vger.kernel.org, AJvYcCWSH7ZYZMC+iH2F8O3EvmSeTLdgAwTHlCaAzsmPDaIwUHAuggA0C2aJzcPV9h/gNt+pTXq40mEjsVuAObDX@vger.kernel.org, AJvYcCXaa6NQ1VcQL9R0yWsOOMqdGxPSjC6xanY+58yFLN1fBo9kPs69fr9DYJwwDTTSEuzyicI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXAdIOlVrGDlSqgQ++3Wk1mq8GdtZBnBq49PmaKiVmCsYsQelo
	D0ghbmu3spzeYN6JjGOhx9mVvsVLUKa8H8ZTeULaj3u6L1W13kQ=
X-Gm-Gg: ASbGnctY8DKDHg6KtbaxnqlzI9K/cMYpsC4RZCibrv1mxLXpyxWUsSVR6N/QCoReVEX
	oZX9B7sPy0ptu/G9IIFS/FUrldcUVl4QWQ9qcQ0jHjXtQiuXDzwq8CDFOMcC4rK/bb3sBl0TFUl
	O+GohM8Qw4OZfJZNSXSLczj0AbpB+vcT7RMgw25pL2ymSWbGSWtfvPzwtY54RQYDEe7Sh7Ys4QJ
	bcBQgZqsfIjYv3ZKQVXCjhLvRih49fBMTyN6XSp+VF7aB0JH7hgZhUdUgtk/JVCzR9qt8zXcxlF
	oLQ+7GApFJ1nfzM=
X-Google-Smtp-Source: AGHT+IEDHDzv7RAmp8QmxLThaKTDa7b92WGnlrEIgiqe204TaejmpERmkO80pcT42x8kXjbsxadIog==
X-Received: by 2002:a17:902:d4d2:b0:215:a190:ba10 with SMTP id d9443c01a7336-21dd7c4ed29mr178570895ad.15.1738345312045;
        Fri, 31 Jan 2025 09:41:52 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21de33007f1sm33197245ad.174.2025.01.31.09.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 09:41:51 -0800 (PST)
Date: Fri, 31 Jan 2025 09:41:50 -0800
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
Message-ID: <Z50LXqkUwTBOdBe4@mini-arch>
References: <20250130211539.428952-1-almasrymina@google.com>
 <20250130211539.428952-3-almasrymina@google.com>
 <Z5wFs3-6pNWARhRL@mini-arch>
 <CAHS8izMMm--CSCm1c9Ud1WdjxLeCXdNiqLzjeM_ACgKUP35O0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMMm--CSCm1c9Ud1WdjxLeCXdNiqLzjeM_ACgKUP35O0w@mail.gmail.com>

On 01/30, Mina Almasry wrote:
> On Thu, Jan 30, 2025 at 3:05 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 01/30, Mina Almasry wrote:
> > > Add support for devmem TX in ncdevmem.
> > >
> > > This is a combination of the ncdevmem from the devmem TCP series RFCv1
> > > which included the TX path, and work by Stan to include the netlink API
> > > and refactored on top of his generic memory_provider support.
> > >
> > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > >
> > > ---
> > >
> > > v2:
> > > - make errors a static variable so that we catch instances where there
> > >   are less than 20 errors across different buffers.
> > > - Fix the issue where the seed is reset to 0 instead of its starting
> > >   value 1.
> > > - Use 1000ULL instead of 1000 to guard against overflow (Willem).
> > > - Do not set POLLERR (Willem).
> > > - Update the test to use the new interface where iov_base is the
> > >   dmabuf_offset.
> > > - Update the test to send 2 iov instead of 1, so we get some test
> > >   coverage over sending multiple iovs at once.
> > > - Print the ifindex the test is using, useful for debugging issues where
> > >   maybe the test may fail because the ifindex of the socket is different
> > >   from the dmabuf binding.
> > > ---
> > >  .../selftests/drivers/net/hw/ncdevmem.c       | 276 +++++++++++++++++-
> > >  1 file changed, 272 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > > index 19a6969643f4..8455f19ecd1a 100644
> > > --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > > +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > > @@ -40,15 +40,18 @@
> > >  #include <fcntl.h>
> > >  #include <malloc.h>
> > >  #include <error.h>
> > > +#include <poll.h>
> > >
> > >  #include <arpa/inet.h>
> > >  #include <sys/socket.h>
> > >  #include <sys/mman.h>
> > >  #include <sys/ioctl.h>
> > >  #include <sys/syscall.h>
> > > +#include <sys/time.h>
> > >
> > >  #include <linux/memfd.h>
> > >  #include <linux/dma-buf.h>
> > > +#include <linux/errqueue.h>
> > >  #include <linux/udmabuf.h>
> > >  #include <libmnl/libmnl.h>
> > >  #include <linux/types.h>
> > > @@ -80,6 +83,8 @@ static int num_queues = -1;
> > >  static char *ifname;
> > >  static unsigned int ifindex;
> > >  static unsigned int dmabuf_id;
> > > +static uint32_t tx_dmabuf_id;
> > > +static int waittime_ms = 500;
> > >
> > >  struct memory_buffer {
> > >       int fd;
> > > @@ -93,6 +98,8 @@ struct memory_buffer {
> > >  struct memory_provider {
> > >       struct memory_buffer *(*alloc)(size_t size);
> > >       void (*free)(struct memory_buffer *ctx);
> > > +     void (*memcpy_to_device)(struct memory_buffer *dst, size_t off,
> > > +                              void *src, int n);
> > >       void (*memcpy_from_device)(void *dst, struct memory_buffer *src,
> > >                                  size_t off, int n);
> > >  };
> > > @@ -153,6 +160,20 @@ static void udmabuf_free(struct memory_buffer *ctx)
> > >       free(ctx);
> > >  }
> > >
> > > +static void udmabuf_memcpy_to_device(struct memory_buffer *dst, size_t off,
> > > +                                  void *src, int n)
> > > +{
> > > +     struct dma_buf_sync sync = {};
> > > +
> > > +     sync.flags = DMA_BUF_SYNC_START | DMA_BUF_SYNC_WRITE;
> > > +     ioctl(dst->fd, DMA_BUF_IOCTL_SYNC, &sync);
> > > +
> > > +     memcpy(dst->buf_mem + off, src, n);
> > > +
> > > +     sync.flags = DMA_BUF_SYNC_END | DMA_BUF_SYNC_WRITE;
> > > +     ioctl(dst->fd, DMA_BUF_IOCTL_SYNC, &sync);
> > > +}
> > > +
> > >  static void udmabuf_memcpy_from_device(void *dst, struct memory_buffer *src,
> > >                                      size_t off, int n)
> > >  {
> > > @@ -170,6 +191,7 @@ static void udmabuf_memcpy_from_device(void *dst, struct memory_buffer *src,
> > >  static struct memory_provider udmabuf_memory_provider = {
> > >       .alloc = udmabuf_alloc,
> > >       .free = udmabuf_free,
> > > +     .memcpy_to_device = udmabuf_memcpy_to_device,
> > >       .memcpy_from_device = udmabuf_memcpy_from_device,
> > >  };
> > >
> > > @@ -188,7 +210,7 @@ void validate_buffer(void *line, size_t size)
> > >  {
> > >       static unsigned char seed = 1;
> > >       unsigned char *ptr = line;
> > > -     int errors = 0;
> > > +     static int errors;
> > >       size_t i;
> > >
> > >       for (i = 0; i < size; i++) {
> > > @@ -202,7 +224,7 @@ void validate_buffer(void *line, size_t size)
> > >               }
> > >               seed++;
> > >               if (seed == do_validation)
> > > -                     seed = 0;
> > > +                     seed = 1;
> > >       }
> > >
> > >       fprintf(stdout, "Validated buffer\n");
> > > @@ -394,6 +416,49 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
> > >       return -1;
> > >  }
> > >
> > > +static int bind_tx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
> > > +                      struct ynl_sock **ys)
> > > +{
> > > +     struct netdev_bind_tx_req *req = NULL;
> > > +     struct netdev_bind_tx_rsp *rsp = NULL;
> > > +     struct ynl_error yerr;
> > > +
> > > +     *ys = ynl_sock_create(&ynl_netdev_family, &yerr);
> > > +     if (!*ys) {
> > > +             fprintf(stderr, "YNL: %s\n", yerr.msg);
> > > +             return -1;
> > > +     }
> > > +
> > > +     req = netdev_bind_tx_req_alloc();
> > > +     netdev_bind_tx_req_set_ifindex(req, ifindex);
> > > +     netdev_bind_tx_req_set_fd(req, dmabuf_fd);
> > > +
> > > +     rsp = netdev_bind_tx(*ys, req);
> > > +     if (!rsp) {
> > > +             perror("netdev_bind_tx");
> > > +             goto err_close;
> > > +     }
> > > +
> > > +     if (!rsp->_present.id) {
> > > +             perror("id not present");
> > > +             goto err_close;
> > > +     }
> > > +
> > > +     fprintf(stderr, "got tx dmabuf id=%d\n", rsp->id);
> > > +     tx_dmabuf_id = rsp->id;
> > > +
> > > +     netdev_bind_tx_req_free(req);
> > > +     netdev_bind_tx_rsp_free(rsp);
> > > +
> > > +     return 0;
> > > +
> > > +err_close:
> > > +     fprintf(stderr, "YNL failed: %s\n", (*ys)->err.msg);
> > > +     netdev_bind_tx_req_free(req);
> > > +     ynl_sock_destroy(*ys);
> > > +     return -1;
> > > +}
> > > +
> > >  static void enable_reuseaddr(int fd)
> > >  {
> > >       int opt = 1;
> > > @@ -432,7 +497,7 @@ static int parse_address(const char *str, int port, struct sockaddr_in6 *sin6)
> > >       return 0;
> > >  }
> > >
> > > -int do_server(struct memory_buffer *mem)
> > > +static int do_server(struct memory_buffer *mem)
> > >  {
> > >       char ctrl_data[sizeof(int) * 20000];
> > >       struct netdev_queue_id *queues;
> > > @@ -686,6 +751,207 @@ void run_devmem_tests(void)
> > >       provider->free(mem);
> > >  }
> > >
> > > +static uint64_t gettimeofday_ms(void)
> > > +{
> > > +     struct timeval tv;
> > > +
> > > +     gettimeofday(&tv, NULL);
> > > +     return (tv.tv_sec * 1000ULL) + (tv.tv_usec / 1000ULL);
> > > +}
> > > +
> > > +static int do_poll(int fd)
> > > +{
> > > +     struct pollfd pfd;
> > > +     int ret;
> > > +
> > > +     pfd.revents = 0;
> > > +     pfd.fd = fd;
> > > +
> > > +     ret = poll(&pfd, 1, waittime_ms);
> > > +     if (ret == -1)
> > > +             error(1, errno, "poll");
> > > +
> > > +     return ret && (pfd.revents & POLLERR);
> > > +}
> > > +
> > > +static void wait_compl(int fd)
> > > +{
> > > +     int64_t tstop = gettimeofday_ms() + waittime_ms;
> > > +     char control[CMSG_SPACE(100)] = {};
> > > +     struct sock_extended_err *serr;
> > > +     struct msghdr msg = {};
> > > +     struct cmsghdr *cm;
> > > +     int retries = 10;
> > > +     __u32 hi, lo;
> > > +     int ret;
> > > +
> > > +     msg.msg_control = control;
> > > +     msg.msg_controllen = sizeof(control);
> > > +
> > > +     while (gettimeofday_ms() < tstop) {
> > > +             if (!do_poll(fd))
> > > +                     continue;
> > > +
> > > +             ret = recvmsg(fd, &msg, MSG_ERRQUEUE);
> > > +             if (ret < 0) {
> > > +                     if (errno == EAGAIN)
> > > +                             continue;
> > > +                     error(1, ret, "recvmsg(MSG_ERRQUEUE)");
> > > +                     return;
> > > +             }
> > > +             if (msg.msg_flags & MSG_CTRUNC)
> > > +                     error(1, 0, "MSG_CTRUNC\n");
> > > +
> > > +             for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
> > > +                     if (cm->cmsg_level != SOL_IP &&
> > > +                         cm->cmsg_level != SOL_IPV6)
> > > +                             continue;
> > > +                     if (cm->cmsg_level == SOL_IP &&
> > > +                         cm->cmsg_type != IP_RECVERR)
> > > +                             continue;
> > > +                     if (cm->cmsg_level == SOL_IPV6 &&
> > > +                         cm->cmsg_type != IPV6_RECVERR)
> > > +                             continue;
> > > +
> > > +                     serr = (void *)CMSG_DATA(cm);
> > > +                     if (serr->ee_origin != SO_EE_ORIGIN_ZEROCOPY)
> > > +                             error(1, 0, "wrong origin %u", serr->ee_origin);
> > > +                     if (serr->ee_errno != 0)
> > > +                             error(1, 0, "wrong errno %d", serr->ee_errno);
> > > +
> > > +                     hi = serr->ee_data;
> > > +                     lo = serr->ee_info;
> > > +
> > > +                     fprintf(stderr, "tx complete [%d,%d]\n", lo, hi);
> > > +                     return;
> > > +             }
> > > +     }
> > > +
> > > +     error(1, 0, "did not receive tx completion");
> > > +}
> > > +
> > > +static int do_client(struct memory_buffer *mem)
> > > +{
> > > +     char ctrl_data[CMSG_SPACE(sizeof(struct dmabuf_tx_cmsg))];
> > > +     struct sockaddr_in6 server_sin;
> > > +     struct sockaddr_in6 client_sin;
> > > +     struct dmabuf_tx_cmsg ddmabuf;
> > > +     struct ynl_sock *ys = NULL;
> > > +     struct msghdr msg = {};
> > > +     ssize_t line_size = 0;
> > > +     struct cmsghdr *cmsg;
> > > +     struct iovec iov[2];
> > > +     uint64_t off = 100;
> > > +     char *line = NULL;
> > > +     size_t len = 0;
> > > +     int socket_fd;
> > > +     int ret, mid;
> > > +     int opt = 1;
> > > +
> > > +     ret = parse_address(server_ip, atoi(port), &server_sin);
> > > +     if (ret < 0)
> > > +             error(1, 0, "parse server address");
> > > +
> > > +     socket_fd = socket(AF_INET6, SOCK_STREAM, 0);
> > > +     if (socket_fd < 0)
> > > +             error(1, socket_fd, "create socket");
> > > +
> > > +     enable_reuseaddr(socket_fd);
> > > +
> > > +     ret = setsockopt(socket_fd, SOL_SOCKET, SO_BINDTODEVICE, ifname,
> > > +                      strlen(ifname) + 1);
> > > +     if (ret)
> > > +             error(1, ret, "bindtodevice");
> > > +
> > > +     if (bind_tx_queue(ifindex, mem->fd, &ys))
> > > +             error(1, 0, "Failed to bind\n");
> > > +
> > > +     ret = parse_address(client_ip, atoi(port), &client_sin);
> > > +     if (ret < 0)
> > > +             error(1, 0, "parse client address");
> > > +
> > > +     ret = bind(socket_fd, &client_sin, sizeof(client_sin));
> > > +     if (ret)
> > > +             error(1, ret, "bind");
> > > +
> > > +     ret = setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
> > > +     if (ret)
> > > +             error(1, ret, "set sock opt");
> > > +
> > > +     fprintf(stderr, "Connect to %s %d (via %s)\n", server_ip,
> > > +             ntohs(server_sin.sin6_port), ifname);
> > > +
> > > +     ret = connect(socket_fd, &server_sin, sizeof(server_sin));
> > > +     if (ret)
> > > +             error(1, ret, "connect");
> > > +
> > > +     while (1) {
> > > +             free(line);
> > > +             line = NULL;
> > > +             /* Subtract 1 from line_size to remove trailing newlines that
> > > +              * get_line are surely to parse...
> > > +              */
> > > +             line_size = getline(&line, &len, stdin) - 1;
> >
> > Why not send the '\n' as well? If we skip the '\n', it's not keeping
> > netcat-like behavior :-(
> >
> 
> Ah, this is to make the validation on the RX side work. The validation
> expects a repeating pattern:
> 
> 1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6, ....
> 
> With no newlines.
> 
> But it does become weird that TX doesn't match netcat. Let me think on
> this a bit. Maybe I can resolve this in a way where the validation
> works but also the tx side behaves like netcat. Maybe the RX
> validation can skip newlines or something. Maybe I can massage how I
> invoke the test.
> 
> This can become a rabbit hole because I do want to invoke multiple
> sendmsg() in one iteration of the test as well, and not overcomplicate
> the series.

Then let's do it for validation mode only? FWIW, my existing (python
wrapper) tests pass with your series. I'll be sending a bunch of minor
comments about the selftest part separately shortly..

