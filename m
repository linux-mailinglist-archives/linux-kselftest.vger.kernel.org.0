Return-Path: <linux-kselftest+bounces-25457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E56A237D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 00:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988B1165862
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 23:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C1B1F1532;
	Thu, 30 Jan 2025 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ebtU0B/u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF1D1F0E57
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Jan 2025 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738279814; cv=none; b=FgiHBLRAT8b8muVZuWSzsTsz6LeFweGGGDoZg8r7PZtn08/dRbu6jVMpXyjcPPGpEmNttPSOlzqxyOKqPbmq4vYdZ5lXk7yc8mVgRn+oMcXDnDTOXYRnL/yizlEixG8QnnxX7VYBxyq5v4n6XCyoXOOr/BKJd0QIwdKKwZIYGJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738279814; c=relaxed/simple;
	bh=j1zJsxZDjmgRXarrUjCuotIAKoRYOS5g0bOFikrRh64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tl5okWHBIa8wI/ZyQyqRNzJ7aXtcQnlivOqgHn+YDqfjodxJ9LIwRfWlE+k8qXkV3cgYBoenlbsVqADaDMvadM0KOmVI1sDXTvCDL+l6XlDFCrbt89mzaCl8YOJ4GzyMsvAyOy49lQNNL0jRU4FQc2ORXXY7DAktGqGYLY+tAI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ebtU0B/u; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21625b4f978so48045ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Jan 2025 15:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738279812; x=1738884612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rmIesab6i2p3RCJXlVDBZqIYZ/awInCMyNBMuFmviI=;
        b=ebtU0B/uGfDkO8tUxFKtKkduhi1YuBR1gS5w8Ic4YpTySruqa7JWFzve29C1STke9h
         2Is4GPtWaWLXnQx0UV7OTacnj4R6uVs+TarHdYBH0rwLcZ52gAIS3tQGdOW1Wr07JM43
         nr9igxJXaGbLmLkCU2o1wciBGyHrMLXbHVnOJeE3yZWJCm4o7UMGBmr3j66U6nRPhpNv
         q9CDWrlZdkQ6fbS+DfqSVaGqhtFlQw32Ot6PGuv/oAEGQVASfg538T6PAiPID6go5a/i
         CdpYc7YLyzfGPWZhIUqim9VtCOmvFA3+SWHYEgGIwykWefq5zEGSfxfKeTlzYCGXUOf9
         4Cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738279812; x=1738884612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rmIesab6i2p3RCJXlVDBZqIYZ/awInCMyNBMuFmviI=;
        b=lWz8bTKNwivAo085lIB28j5NWdTAsAOvs9bupXujVJExdsJDHnOhttTuQX4HbhT7L/
         tuHG8J+xUbE7HTpoy27UOBcNNR4CSHes3I4UrzuIqZ8EkBR2aBgsNgiGUPpZ2fzXvU6R
         Tvurog9KRnH09c8WfZJUT/I1uiYLW6j8LogJVmDedNXi+9QLyCsxXCYm4V68AV6qiRJp
         hZKW1dUgibcPufo0c23NyIb659D+e3ck+NIogmK/8ZB//snXqyApbcHAbk77H3BwA5yJ
         5FJepTtlIdCdVtds0xXo39S+86u1jrj3zodBE5Ei61SIKznKg7k02PJDLqeygTr1RAsg
         XYrg==
X-Forwarded-Encrypted: i=1; AJvYcCUjr1KHN4R6nUMO8mziyE1qYopWIO/slVj75sOfstyABdd3Tcnc5eJ1o7cVubSX+PVFEhFHU3xr6tFznOMhJEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLwgJLprvM8zmoFoYLVseExlGaOcOtNDvyrA4qIGJSEO6CMKK3
	9R9rwYa6Lm9ciLiaArG8EvNtaGdMW+gBhXtR8VS07UfS+tICV5HyVbV8J+oWnFbzitomHPFIQ3z
	P5jg81izWVdKUmMUIimFOK1tvFKyh+vSe30k5
X-Gm-Gg: ASbGncvieYQgSj3ppR2ygZI2SjNOCIpzEKv8Uuqx4zDkyLDv7Jgst921Zj41l+146aQ
	CWQB2ODQ+Z8oll3FBdihIcwq4QY15Y0jvBJdRpXcKQtGXxsbhiDOk7ZXKncb7jIIy0KGr9Oz1Bf
	WSeGMuMb1ZBhLLBOoUgCHs+4URXF4=
X-Google-Smtp-Source: AGHT+IF4fex0zEZPDdhq4r0hwOdVVLdnLANJBfKGdI2Hv9YV8rfN/WnxP54e/v6+9MLpQlX+TdRkKqMftmE/vS75cus=
X-Received: by 2002:a17:902:778f:b0:216:25a2:2ee3 with SMTP id
 d9443c01a7336-21edf067fc8mr351855ad.25.1738279811617; Thu, 30 Jan 2025
 15:30:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130211539.428952-1-almasrymina@google.com>
 <20250130211539.428952-3-almasrymina@google.com> <Z5wFs3-6pNWARhRL@mini-arch>
In-Reply-To: <Z5wFs3-6pNWARhRL@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 30 Jan 2025 15:29:57 -0800
X-Gm-Features: AWEUYZkPTESrno2iYzeo1K78PcJfaZsMxGDDzhBy002v1BDbsQGxVfN2xbBIxT0
Message-ID: <CAHS8izMMm--CSCm1c9Ud1WdjxLeCXdNiqLzjeM_ACgKUP35O0w@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v2 2/6] selftests: ncdevmem: Implement devmem
 TCP TX
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 3:05=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 01/30, Mina Almasry wrote:
> > Add support for devmem TX in ncdevmem.
> >
> > This is a combination of the ncdevmem from the devmem TCP series RFCv1
> > which included the TX path, and work by Stan to include the netlink API
> > and refactored on top of his generic memory_provider support.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> >
> > ---
> >
> > v2:
> > - make errors a static variable so that we catch instances where there
> >   are less than 20 errors across different buffers.
> > - Fix the issue where the seed is reset to 0 instead of its starting
> >   value 1.
> > - Use 1000ULL instead of 1000 to guard against overflow (Willem).
> > - Do not set POLLERR (Willem).
> > - Update the test to use the new interface where iov_base is the
> >   dmabuf_offset.
> > - Update the test to send 2 iov instead of 1, so we get some test
> >   coverage over sending multiple iovs at once.
> > - Print the ifindex the test is using, useful for debugging issues wher=
e
> >   maybe the test may fail because the ifindex of the socket is differen=
t
> >   from the dmabuf binding.
> > ---
> >  .../selftests/drivers/net/hw/ncdevmem.c       | 276 +++++++++++++++++-
> >  1 file changed, 272 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/=
testing/selftests/drivers/net/hw/ncdevmem.c
> > index 19a6969643f4..8455f19ecd1a 100644
> > --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > @@ -40,15 +40,18 @@
> >  #include <fcntl.h>
> >  #include <malloc.h>
> >  #include <error.h>
> > +#include <poll.h>
> >
> >  #include <arpa/inet.h>
> >  #include <sys/socket.h>
> >  #include <sys/mman.h>
> >  #include <sys/ioctl.h>
> >  #include <sys/syscall.h>
> > +#include <sys/time.h>
> >
> >  #include <linux/memfd.h>
> >  #include <linux/dma-buf.h>
> > +#include <linux/errqueue.h>
> >  #include <linux/udmabuf.h>
> >  #include <libmnl/libmnl.h>
> >  #include <linux/types.h>
> > @@ -80,6 +83,8 @@ static int num_queues =3D -1;
> >  static char *ifname;
> >  static unsigned int ifindex;
> >  static unsigned int dmabuf_id;
> > +static uint32_t tx_dmabuf_id;
> > +static int waittime_ms =3D 500;
> >
> >  struct memory_buffer {
> >       int fd;
> > @@ -93,6 +98,8 @@ struct memory_buffer {
> >  struct memory_provider {
> >       struct memory_buffer *(*alloc)(size_t size);
> >       void (*free)(struct memory_buffer *ctx);
> > +     void (*memcpy_to_device)(struct memory_buffer *dst, size_t off,
> > +                              void *src, int n);
> >       void (*memcpy_from_device)(void *dst, struct memory_buffer *src,
> >                                  size_t off, int n);
> >  };
> > @@ -153,6 +160,20 @@ static void udmabuf_free(struct memory_buffer *ctx=
)
> >       free(ctx);
> >  }
> >
> > +static void udmabuf_memcpy_to_device(struct memory_buffer *dst, size_t=
 off,
> > +                                  void *src, int n)
> > +{
> > +     struct dma_buf_sync sync =3D {};
> > +
> > +     sync.flags =3D DMA_BUF_SYNC_START | DMA_BUF_SYNC_WRITE;
> > +     ioctl(dst->fd, DMA_BUF_IOCTL_SYNC, &sync);
> > +
> > +     memcpy(dst->buf_mem + off, src, n);
> > +
> > +     sync.flags =3D DMA_BUF_SYNC_END | DMA_BUF_SYNC_WRITE;
> > +     ioctl(dst->fd, DMA_BUF_IOCTL_SYNC, &sync);
> > +}
> > +
> >  static void udmabuf_memcpy_from_device(void *dst, struct memory_buffer=
 *src,
> >                                      size_t off, int n)
> >  {
> > @@ -170,6 +191,7 @@ static void udmabuf_memcpy_from_device(void *dst, s=
truct memory_buffer *src,
> >  static struct memory_provider udmabuf_memory_provider =3D {
> >       .alloc =3D udmabuf_alloc,
> >       .free =3D udmabuf_free,
> > +     .memcpy_to_device =3D udmabuf_memcpy_to_device,
> >       .memcpy_from_device =3D udmabuf_memcpy_from_device,
> >  };
> >
> > @@ -188,7 +210,7 @@ void validate_buffer(void *line, size_t size)
> >  {
> >       static unsigned char seed =3D 1;
> >       unsigned char *ptr =3D line;
> > -     int errors =3D 0;
> > +     static int errors;
> >       size_t i;
> >
> >       for (i =3D 0; i < size; i++) {
> > @@ -202,7 +224,7 @@ void validate_buffer(void *line, size_t size)
> >               }
> >               seed++;
> >               if (seed =3D=3D do_validation)
> > -                     seed =3D 0;
> > +                     seed =3D 1;
> >       }
> >
> >       fprintf(stdout, "Validated buffer\n");
> > @@ -394,6 +416,49 @@ static int bind_rx_queue(unsigned int ifindex, uns=
igned int dmabuf_fd,
> >       return -1;
> >  }
> >
> > +static int bind_tx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
> > +                      struct ynl_sock **ys)
> > +{
> > +     struct netdev_bind_tx_req *req =3D NULL;
> > +     struct netdev_bind_tx_rsp *rsp =3D NULL;
> > +     struct ynl_error yerr;
> > +
> > +     *ys =3D ynl_sock_create(&ynl_netdev_family, &yerr);
> > +     if (!*ys) {
> > +             fprintf(stderr, "YNL: %s\n", yerr.msg);
> > +             return -1;
> > +     }
> > +
> > +     req =3D netdev_bind_tx_req_alloc();
> > +     netdev_bind_tx_req_set_ifindex(req, ifindex);
> > +     netdev_bind_tx_req_set_fd(req, dmabuf_fd);
> > +
> > +     rsp =3D netdev_bind_tx(*ys, req);
> > +     if (!rsp) {
> > +             perror("netdev_bind_tx");
> > +             goto err_close;
> > +     }
> > +
> > +     if (!rsp->_present.id) {
> > +             perror("id not present");
> > +             goto err_close;
> > +     }
> > +
> > +     fprintf(stderr, "got tx dmabuf id=3D%d\n", rsp->id);
> > +     tx_dmabuf_id =3D rsp->id;
> > +
> > +     netdev_bind_tx_req_free(req);
> > +     netdev_bind_tx_rsp_free(rsp);
> > +
> > +     return 0;
> > +
> > +err_close:
> > +     fprintf(stderr, "YNL failed: %s\n", (*ys)->err.msg);
> > +     netdev_bind_tx_req_free(req);
> > +     ynl_sock_destroy(*ys);
> > +     return -1;
> > +}
> > +
> >  static void enable_reuseaddr(int fd)
> >  {
> >       int opt =3D 1;
> > @@ -432,7 +497,7 @@ static int parse_address(const char *str, int port,=
 struct sockaddr_in6 *sin6)
> >       return 0;
> >  }
> >
> > -int do_server(struct memory_buffer *mem)
> > +static int do_server(struct memory_buffer *mem)
> >  {
> >       char ctrl_data[sizeof(int) * 20000];
> >       struct netdev_queue_id *queues;
> > @@ -686,6 +751,207 @@ void run_devmem_tests(void)
> >       provider->free(mem);
> >  }
> >
> > +static uint64_t gettimeofday_ms(void)
> > +{
> > +     struct timeval tv;
> > +
> > +     gettimeofday(&tv, NULL);
> > +     return (tv.tv_sec * 1000ULL) + (tv.tv_usec / 1000ULL);
> > +}
> > +
> > +static int do_poll(int fd)
> > +{
> > +     struct pollfd pfd;
> > +     int ret;
> > +
> > +     pfd.revents =3D 0;
> > +     pfd.fd =3D fd;
> > +
> > +     ret =3D poll(&pfd, 1, waittime_ms);
> > +     if (ret =3D=3D -1)
> > +             error(1, errno, "poll");
> > +
> > +     return ret && (pfd.revents & POLLERR);
> > +}
> > +
> > +static void wait_compl(int fd)
> > +{
> > +     int64_t tstop =3D gettimeofday_ms() + waittime_ms;
> > +     char control[CMSG_SPACE(100)] =3D {};
> > +     struct sock_extended_err *serr;
> > +     struct msghdr msg =3D {};
> > +     struct cmsghdr *cm;
> > +     int retries =3D 10;
> > +     __u32 hi, lo;
> > +     int ret;
> > +
> > +     msg.msg_control =3D control;
> > +     msg.msg_controllen =3D sizeof(control);
> > +
> > +     while (gettimeofday_ms() < tstop) {
> > +             if (!do_poll(fd))
> > +                     continue;
> > +
> > +             ret =3D recvmsg(fd, &msg, MSG_ERRQUEUE);
> > +             if (ret < 0) {
> > +                     if (errno =3D=3D EAGAIN)
> > +                             continue;
> > +                     error(1, ret, "recvmsg(MSG_ERRQUEUE)");
> > +                     return;
> > +             }
> > +             if (msg.msg_flags & MSG_CTRUNC)
> > +                     error(1, 0, "MSG_CTRUNC\n");
> > +
> > +             for (cm =3D CMSG_FIRSTHDR(&msg); cm; cm =3D CMSG_NXTHDR(&=
msg, cm)) {
> > +                     if (cm->cmsg_level !=3D SOL_IP &&
> > +                         cm->cmsg_level !=3D SOL_IPV6)
> > +                             continue;
> > +                     if (cm->cmsg_level =3D=3D SOL_IP &&
> > +                         cm->cmsg_type !=3D IP_RECVERR)
> > +                             continue;
> > +                     if (cm->cmsg_level =3D=3D SOL_IPV6 &&
> > +                         cm->cmsg_type !=3D IPV6_RECVERR)
> > +                             continue;
> > +
> > +                     serr =3D (void *)CMSG_DATA(cm);
> > +                     if (serr->ee_origin !=3D SO_EE_ORIGIN_ZEROCOPY)
> > +                             error(1, 0, "wrong origin %u", serr->ee_o=
rigin);
> > +                     if (serr->ee_errno !=3D 0)
> > +                             error(1, 0, "wrong errno %d", serr->ee_er=
rno);
> > +
> > +                     hi =3D serr->ee_data;
> > +                     lo =3D serr->ee_info;
> > +
> > +                     fprintf(stderr, "tx complete [%d,%d]\n", lo, hi);
> > +                     return;
> > +             }
> > +     }
> > +
> > +     error(1, 0, "did not receive tx completion");
> > +}
> > +
> > +static int do_client(struct memory_buffer *mem)
> > +{
> > +     char ctrl_data[CMSG_SPACE(sizeof(struct dmabuf_tx_cmsg))];
> > +     struct sockaddr_in6 server_sin;
> > +     struct sockaddr_in6 client_sin;
> > +     struct dmabuf_tx_cmsg ddmabuf;
> > +     struct ynl_sock *ys =3D NULL;
> > +     struct msghdr msg =3D {};
> > +     ssize_t line_size =3D 0;
> > +     struct cmsghdr *cmsg;
> > +     struct iovec iov[2];
> > +     uint64_t off =3D 100;
> > +     char *line =3D NULL;
> > +     size_t len =3D 0;
> > +     int socket_fd;
> > +     int ret, mid;
> > +     int opt =3D 1;
> > +
> > +     ret =3D parse_address(server_ip, atoi(port), &server_sin);
> > +     if (ret < 0)
> > +             error(1, 0, "parse server address");
> > +
> > +     socket_fd =3D socket(AF_INET6, SOCK_STREAM, 0);
> > +     if (socket_fd < 0)
> > +             error(1, socket_fd, "create socket");
> > +
> > +     enable_reuseaddr(socket_fd);
> > +
> > +     ret =3D setsockopt(socket_fd, SOL_SOCKET, SO_BINDTODEVICE, ifname=
,
> > +                      strlen(ifname) + 1);
> > +     if (ret)
> > +             error(1, ret, "bindtodevice");
> > +
> > +     if (bind_tx_queue(ifindex, mem->fd, &ys))
> > +             error(1, 0, "Failed to bind\n");
> > +
> > +     ret =3D parse_address(client_ip, atoi(port), &client_sin);
> > +     if (ret < 0)
> > +             error(1, 0, "parse client address");
> > +
> > +     ret =3D bind(socket_fd, &client_sin, sizeof(client_sin));
> > +     if (ret)
> > +             error(1, ret, "bind");
> > +
> > +     ret =3D setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, size=
of(opt));
> > +     if (ret)
> > +             error(1, ret, "set sock opt");
> > +
> > +     fprintf(stderr, "Connect to %s %d (via %s)\n", server_ip,
> > +             ntohs(server_sin.sin6_port), ifname);
> > +
> > +     ret =3D connect(socket_fd, &server_sin, sizeof(server_sin));
> > +     if (ret)
> > +             error(1, ret, "connect");
> > +
> > +     while (1) {
> > +             free(line);
> > +             line =3D NULL;
> > +             /* Subtract 1 from line_size to remove trailing newlines =
that
> > +              * get_line are surely to parse...
> > +              */
> > +             line_size =3D getline(&line, &len, stdin) - 1;
>
> Why not send the '\n' as well? If we skip the '\n', it's not keeping
> netcat-like behavior :-(
>

Ah, this is to make the validation on the RX side work. The validation
expects a repeating pattern:

1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6, ....

With no newlines.

But it does become weird that TX doesn't match netcat. Let me think on
this a bit. Maybe I can resolve this in a way where the validation
works but also the tx side behaves like netcat. Maybe the RX
validation can skip newlines or something. Maybe I can massage how I
invoke the test.

This can become a rabbit hole because I do want to invoke multiple
sendmsg() in one iteration of the test as well, and not overcomplicate
the series.

> > +
> > +             if (line_size < 0)
> > +                     break;
>
> [..]
>
> > +             mid =3D (line_size / 2) + 1;
> > +
> > +             iov[0].iov_base =3D (void *)100;
> > +             iov[0].iov_len =3D mid;
> > +             iov[1].iov_base =3D (void *)2000;
> > +             iov[1].iov_len =3D line_size - mid;
>
> This seems a bit hard-coded. We should at least test that mid is < 2000?
>

Yep, I should do at least do that. FWIW (although missed it in this
iteration), at the top of the file I put docs that list exactly what I
run for others to repro the results (and nipa should eventually run
similar, I have that on my todo list), but the test should be more
flexible to at least catch instances where mid is too large.

> But ideally we should have two modes for tx with a flag (and run them
> both from the selftest):
> - pass one big iov, this will test the sendmsg path which creates
>   multiple skbs internally
> - break 'line' into N sections (as you do here), but maybe have more
>   control over the number of sections?
>
> Maybe let's have a new --max-iov-size flag? Then we can call ncdevmem
> with --max-iov-size <some prime number close to 4k> to exercise all
> sorts of weird offsets?
>
> (seems ok to also follow up on that separately)

Yeah, improvements to tests are always possible, lets have some
reasonable tests in the first iteration and expand.


--=20
Thanks,
Mina

