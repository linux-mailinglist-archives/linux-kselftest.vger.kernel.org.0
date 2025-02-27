Return-Path: <linux-kselftest+bounces-27716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3C4A4773A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 09:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07190171E94
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 08:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DE1225A4F;
	Thu, 27 Feb 2025 08:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKirZCsX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C22222AC;
	Thu, 27 Feb 2025 08:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740643204; cv=none; b=kfrZg002xSQHcgW2ULddWtspiFWtNKHEaRJ7G589TlPcezVGGX0t+qMKJ8VL2XHc9K8cTcfekFWrQma89vY1VNUYC6LxhluTmpK5yjpdIcieN+rXq0tvFkF/X7Lqfbprx58C3t3wBZUPbPQH3pOBjVQ2HI3oDnMEyKczVS08pEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740643204; c=relaxed/simple;
	bh=F/Q/rQMBhG8QlQ0hvZO4Vy6dvWhPpbp2iZ88VJNmuaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRXF/bS6o70Ga/A4t5QwpIBN/zeO64lW5wAPMnetXX7KneDUwZPySH2sJsNj0orLAIWenTAwixlGhXlR70dA2zo8Ocyam9Bk1n1NUv84Mbc44IP04KsIQnUIg4qc++ZpmlaaYLlTmgk3iZqfWGetdBk1IzfbjeEJNSFIJ5wF8Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKirZCsX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22337bc9ac3so10294445ad.1;
        Thu, 27 Feb 2025 00:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740643202; x=1741248002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e+VhD1FcQ4v0IAeCPGXacuvSg0+RMPQMMHyVhpvcmHA=;
        b=UKirZCsX5tRGNE/5mAhj3FsL1I6H4QCbI7FZckmmbzJvaeZ1SqzGkHmTiUQwrO8npp
         R4IIjNNFFop1hbea9O4NeYjtez+qwp/cLPRotG1UeRPocyriETZShMUStWl+nI6omuUT
         Xk0t3oPlhS/nOeGWMX88byrEx+CvVe+AFvuVhoCSZ40YZJHjKTSMRPX3gW3K4IlhL0lZ
         8z9lJnwzut331eF0BH2HVT6U7xe24+4uKRr3Nt2mP5MFb8rusuylepI1w6/+p+qnznHa
         N3b8pgcSQFRsy+VZSgRuGqhBILWNaTxtePBSUHgPhrp1LmYh+9kSHJoa/eyXfCXTy2Er
         pvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740643202; x=1741248002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+VhD1FcQ4v0IAeCPGXacuvSg0+RMPQMMHyVhpvcmHA=;
        b=wuO76JAa62qrMx5U4+t7UMAivj2FHFgRZ+3PMpbvDkB+08vf6odnDvv4tP7zveYzRS
         ridw18lHUUopXlIKZxzWU8rWqfHdG1FSBHRRbHSMZ65ujMDm2VMq9Y2tmuNUJ5fc+TwI
         eKpXlCvOjm8tEKEVEx+LVS1VBUNnrq/FsW1ss29PCntpOt8DC42HsExmoSRtnh86tEL0
         5/koIYJJ+gvVuKhfKjJk+uvPwgLbX4RK2lvWXsL/JKSCX7KuDiWyFPJ5D71On8Xzlfb6
         9Xznu96ZEM3ouYqLL7qqjzwIg0oaqYI+enjumQDKPa3F0rywTcIceMCp7zsSwofBruI4
         OrWw==
X-Forwarded-Encrypted: i=1; AJvYcCUPL36GVOi+/4mDbfRMsyagvgicsi+6AUyAilcJc+JzCLR2I4E0tl4qlXDhOuEDvSA3LNHz9/iDALnK@vger.kernel.org, AJvYcCVaKzrv7czdjwUyBAqUKerBpNzHqOORW05kSVFzfWyjdd6oH+MUHnJtXRc1mwXROtQk8tc=@vger.kernel.org, AJvYcCXLlsjgBQkLaeo9ubVuTnHAvZv8PgeFLUDWJZhqdA2NPd33jLcj2miZi4mzF+t/a/juDqPI6GEc@vger.kernel.org, AJvYcCXct7HGDyN7KbTOUmZ6eCiWyGAObf+Yu0plSIOroU/woeiXfU+EWQd4tQUWqwd675ncDCNc2la8i5IBpZNM@vger.kernel.org, AJvYcCXkAGhnw/chUSLsGmiUQNDCfcpszDqkp4+w5Ip7ZAm1ESeIP/f++IdRUDTKCLAghRhiC0L/o2ZfkbMacrzmrJt+@vger.kernel.org
X-Gm-Message-State: AOJu0YzmMusFA6jxYwyQ5xJ+3o6YkGStT8fd3NeZT4P0FjexFqgDe4nL
	cUl2LAtMDCCtHlm2h8yYX81szpd/qhAnWUMNcZ4NZu2Ax6TcWj66
X-Gm-Gg: ASbGncvA6sLkV/ApCYsYsdvDLwP4GDo0iK8YDL2v1OWqA8rYkJ48j6nNNlVzZ4YRypG
	v2Vd3uQyGHTVj2FsAXxTLdJD3EnQofFCwZZkGnlS/xvle3eOdfyp68O9WC0KAeoF2YTlBM+6EsZ
	vkws9L6m723OGL3VJWrd12SSqtKUz8x2vQ6zTay76tFtV4B/2QlqLXD1CQfEoiuUUZXatfOFpTA
	dbcqKFIaROoyKt+eu/KgJaG0V0tYwE+nH8tszslbr63KrewLinBp2GZ+2KOVrvSUHKkLow3Pom9
	6BKsuct9SFqkpasohO7gIsssEw==
X-Google-Smtp-Source: AGHT+IHbgNhJloGNS3WGI/ZiBYGWLiZc0ShwSla+EDWIC7+o+EwVg1hEUCizPi07PZDxpMZGk59OJg==
X-Received: by 2002:a17:903:2311:b0:220:dff2:18ee with SMTP id d9443c01a7336-221a0edbf42mr392893445ad.14.1740643201794;
        Thu, 27 Feb 2025 00:00:01 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223505336f9sm8356295ad.245.2025.02.27.00.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 00:00:00 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 55C6941296D8; Thu, 27 Feb 2025 14:59:58 +0700 (WIB)
Date: Thu, 27 Feb 2025 14:59:57 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v6 4/8] net: add devmem TCP TX documentation
Message-ID: <Z8AbfZg98HS_QQjb@archie.me>
References: <20250227041209.2031104-1-almasrymina@google.com>
 <20250227041209.2031104-5-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AMvatQGVE1g1y7TH"
Content-Disposition: inline
In-Reply-To: <20250227041209.2031104-5-almasrymina@google.com>


--AMvatQGVE1g1y7TH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 04:12:05AM +0000, Mina Almasry wrote:
> diff --git a/Documentation/networking/devmem.rst b/Documentation/networki=
ng/devmem.rst
> index d95363645331..1c476522d6f5 100644
> --- a/Documentation/networking/devmem.rst
> +++ b/Documentation/networking/devmem.rst
> @@ -62,15 +62,15 @@ More Info
>      https://lore.kernel.org/netdev/20240831004313.3713467-1-almasrymina@=
google.com/
> =20
> =20
> -Interface
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +RX Interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> =20
>  Example
>  -------
> =20
> -tools/testing/selftests/net/ncdevmem.c:do_server shows an example of set=
ting up
> -the RX path of this API.
> +./tools/testing/selftests/drivers/net/hw/ncdevmem:do_server shows an exa=
mple of
> +setting up the RX path of this API.
> =20
> =20
>  NIC Setup
> @@ -235,6 +235,148 @@ can be less than the tokens provided by the user in=
 case of:
>  (a) an internal kernel leak bug.
>  (b) the user passed more than 1024 frags.
> =20
> +TX Interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +
> +Example
> +-------
> +
> +./tools/testing/selftests/drivers/net/hw/ncdevmem:do_client shows an exa=
mple of
> +setting up the TX path of this API.
> +
> +
> +NIC Setup
> +---------
> +
> +The user must bind a TX dmabuf to a given NIC using the netlink API::
> +
> +        struct netdev_bind_tx_req *req =3D NULL;
> +        struct netdev_bind_tx_rsp *rsp =3D NULL;
> +        struct ynl_error yerr;
> +
> +        *ys =3D ynl_sock_create(&ynl_netdev_family, &yerr);
> +
> +        req =3D netdev_bind_tx_req_alloc();
> +        netdev_bind_tx_req_set_ifindex(req, ifindex);
> +        netdev_bind_tx_req_set_fd(req, dmabuf_fd);
> +
> +        rsp =3D netdev_bind_tx(*ys, req);
> +
> +        tx_dmabuf_id =3D rsp->id;
> +
> +
> +The netlink API returns a dmabuf_id: a unique ID that refers to this dma=
buf
> +that has been bound.
> +
> +The user can unbind the dmabuf from the netdevice by closing the netlink=
 socket
> +that established the binding. We do this so that the binding is automati=
cally
> +unbound even if the userspace process crashes.
> +
> +Note that any reasonably well-behaved dmabuf from any exporter should wo=
rk with
> +devmem TCP, even if the dmabuf is not actually backed by devmem. An exam=
ple of
> +this is udmabuf, which wraps user memory (non-devmem) in a dmabuf.
> +
> +Socket Setup
> +------------
> +
> +The user application must use MSG_ZEROCOPY flag when sending devmem TCP.=
 Devmem
> +cannot be copied by the kernel, so the semantics of the devmem TX are si=
milar
> +to the semantics of MSG_ZEROCOPY::
> +
> +	setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
> +
> +It is also recommended that the user binds the TX socket to the same int=
erface
> +the dma-buf has been bound to via SO_BINDTODEVICE::
> +
> +	setsockopt(socket_fd, SOL_SOCKET, SO_BINDTODEVICE, ifname, strlen(ifnam=
e) + 1);
> +
> +
> +Sending data
> +------------
> +
> +Devmem data is sent using the SCM_DEVMEM_DMABUF cmsg.
> +
> +The user should create a msghdr where,
> +
> +* iov_base is set to the offset into the dmabuf to start sending from
> +* iov_len is set to the number of bytes to be sent from the dmabuf
> +
> +The user passes the dma-buf id to send from via the dmabuf_tx_cmsg.dmabu=
f_id.
> +
> +The example below sends 1024 bytes from offset 100 into the dmabuf, and =
2048
> +from offset 2000 into the dmabuf. The dmabuf to send from is tx_dmabuf_i=
d::
> +
> +       char ctrl_data[CMSG_SPACE(sizeof(struct dmabuf_tx_cmsg))];
> +       struct dmabuf_tx_cmsg ddmabuf;
> +       struct msghdr msg =3D {};
> +       struct cmsghdr *cmsg;
> +       struct iovec iov[2];
> +
> +       iov[0].iov_base =3D (void*)100;
> +       iov[0].iov_len =3D 1024;
> +       iov[1].iov_base =3D (void*)2000;
> +       iov[1].iov_len =3D 2048;
> +
> +       msg.msg_iov =3D iov;
> +       msg.msg_iovlen =3D 2;
> +
> +       msg.msg_control =3D ctrl_data;
> +       msg.msg_controllen =3D sizeof(ctrl_data);
> +
> +       cmsg =3D CMSG_FIRSTHDR(&msg);
> +       cmsg->cmsg_level =3D SOL_SOCKET;
> +       cmsg->cmsg_type =3D SCM_DEVMEM_DMABUF;
> +       cmsg->cmsg_len =3D CMSG_LEN(sizeof(struct dmabuf_tx_cmsg));
> +
> +       ddmabuf.dmabuf_id =3D tx_dmabuf_id;
> +
> +       *((struct dmabuf_tx_cmsg *)CMSG_DATA(cmsg)) =3D ddmabuf;
> +
> +       sendmsg(socket_fd, &msg, MSG_ZEROCOPY);
> +
> +
> +Reusing TX dmabufs
> +------------------
> +
> +Similar to MSG_ZEROCOPY with regular memory, the user should not modify =
the
> +contents of the dma-buf while a send operation is in progress. This is b=
ecause
> +the kernel does not keep a copy of the dmabuf contents. Instead, the ker=
nel
> +will pin and send data from the buffer available to the userspace.
> +
> +Just as in MSG_ZEROCOPY, the kernel notifies the userspace of send compl=
etions
> +using MSG_ERRQUEUE::
> +
> +        int64_t tstop =3D gettimeofday_ms() + waittime_ms;
> +        char control[CMSG_SPACE(100)] =3D {};
> +        struct sock_extended_err *serr;
> +        struct msghdr msg =3D {};
> +        struct cmsghdr *cm;
> +        int retries =3D 10;
> +        __u32 hi, lo;
> +
> +        msg.msg_control =3D control;
> +        msg.msg_controllen =3D sizeof(control);
> +
> +        while (gettimeofday_ms() < tstop) {
> +                if (!do_poll(fd)) continue;
> +
> +                ret =3D recvmsg(fd, &msg, MSG_ERRQUEUE);
> +
> +                for (cm =3D CMSG_FIRSTHDR(&msg); cm; cm =3D CMSG_NXTHDR(=
&msg, cm)) {
> +                        serr =3D (void *)CMSG_DATA(cm);
> +
> +                        hi =3D serr->ee_data;
> +                        lo =3D serr->ee_info;
> +
> +                        fprintf(stdout, "tx complete [%d,%d]\n", lo, hi);
> +                }
> +        }
> +
> +After the associated sendmsg has been completed, the dmabuf can be reuse=
d by
> +the userspace.
> +
> +
>  Implementation & Caveats
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20

Looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--AMvatQGVE1g1y7TH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ8AbdwAKCRD2uYlJVVFO
o5L6AP94BQBQkG23E8CUzSu2bJ8z0CxxYycEKJqhqTQ+o4ZjrAEA+k30eIV66TQg
+CdsIvY8VaYj1OlgpJ5nlSex5IoycAg=
=GAXk
-----END PGP SIGNATURE-----

--AMvatQGVE1g1y7TH--

