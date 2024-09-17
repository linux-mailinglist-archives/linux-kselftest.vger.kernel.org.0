Return-Path: <linux-kselftest+bounces-18084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DB697B278
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 18:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3748A2884CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 16:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99D0176AC2;
	Tue, 17 Sep 2024 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SJZb3PBs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E223A17335E
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Sep 2024 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726588832; cv=none; b=IHKiZ8+TZdLgpKp7bEutyV2CCKrjcwg5HbnAX7KvBFk9FM5LVVSvyt0cxbOZ+JYAc70f+v1BIzGDhSQWcnEh4Nua3j0KPhEbfRrXpaxBWVrr2DIy7vuaHNHlR+FQcyyl+nbiuvRzQ0GABZZ9Ze635Z5Qc/2pQ3Fu0lZDtwNUUr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726588832; c=relaxed/simple;
	bh=iwhaIuE2h6sVer3uexfprQjPfDuKxTFnO2orokxvbjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Az+dmku8WQLTZzKbQenFj4wIX42M9mdJO2cI+mf0zf4zfz4Us5ElXFNvX3gtAOkVxn5ucc2RSzHQp/hX91K4AhMCbyIlrrMDn8Ec/9HRlSFuY8/Hniy5Xx3QVhFav2Z4cXnWObiyhnLm7BycucuIr0GYscpmUxv4mV7RSD2BqSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SJZb3PBs; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374bfc395a5so3768045f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Sep 2024 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1726588829; x=1727193629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GzdDM52YJ5QqZgf2ijfzw5JmBHoLQaTemNy6F79uMx8=;
        b=SJZb3PBsuGonG+ptKeQS2P6ofza9yIldqBv/W2aHahEbvr8Ax0OC0TQqd4hW5ldwAR
         SlCSgGLAcVZ3YIgjWr5MKKPLM4IJpxMskTgy7i84fxIltuF+SsEROKEpD3P0/iE9YV8y
         v3PtU6Ey05X0IuD6KwzAx2kBdF1ctEI6Z/Ha5bE66H+Ua/7NHl69J+CwPFpnomWC476z
         U3TE9mFVbIUdPXgGlUDq6DsuSTpIClbURudeOszlONHKnpb+BUE53uGH+IWO4wkvVzRj
         phbNyZEt6SxWK8cT23m6uv4D59hOZzXds791pPBsV0eHCNgEN20XoR4UbnQhDHtNvpss
         AtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726588829; x=1727193629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzdDM52YJ5QqZgf2ijfzw5JmBHoLQaTemNy6F79uMx8=;
        b=fY1V9CAnKhNfJw+fmsDt910O5bFQQSy/ignV0LlwtArfH6OsyqSEDQzLkfxYePxImp
         /cqwOkWjC+4sDjLD7kj5BpzwNcXhqKzdUTc+A1fM0kvCZWYSB2sK6hagdQO+HTousUSi
         p7DsVk9X+gHPWjNGM/PbdNObS5VH9wlI0CNgi3ue0ODTOl+fGENBCF36W2l2UgwLMONw
         jE6CdXQP2xsU4V4aRlESm9SrCAJbkx6iGAMDQCIKyIijPf+RKWwJ9fWbbkaaYK/6tIKE
         BlwHTPBIRwpbefQrtbPoXU4gkDFlUcS1GwnrA99qCXaTMIR7HFpp+7worTxvdRLc8MA6
         1Niw==
X-Forwarded-Encrypted: i=1; AJvYcCUpUhRex8qhIHQ4wPDqQtl7gaQth1qd0zbXNlk7MOiFRXYvjX0SX7+gEYjDtoB2jFOJnwb0ZPkgrZg+4Nc0L/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3c7LGU2mn6LoNNPDk7oXkGsolybeNwKu92NgxyqKJtThq1Zga
	+bSj8TpthiQogB6X+7UbSjrftYTIcTe2M7Ymna+/ria3LblLv1oMS3bmqfxOqkk=
X-Google-Smtp-Source: AGHT+IGiLZWARlLw1w001NS+/MT9IxxbVcl3J2mqD02KxtsHkKPX5hJJBnZPHFNkpPuN3Vvo5pqZSw==
X-Received: by 2002:a05:6000:bc7:b0:374:b6e4:16a7 with SMTP id ffacd0b85a97d-378a8a0b864mr12922145f8f.8.1726588828834;
        Tue, 17 Sep 2024 09:00:28 -0700 (PDT)
Received: from GHGHG14 ([2a09:bac5:50ca:432::6b:83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b19493bsm141491855e9.45.2024.09.17.09.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 09:00:28 -0700 (PDT)
Date: Tue, 17 Sep 2024 17:00:19 +0100
From: Tiago Lam <tiagolam@cloudflare.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Jakub Sitnicki <jakub@cloudflare.com>, kernel-team@cloudflare.com
Subject: Re: [RFC PATCH 3/3] bpf: Add sk_lookup test to use ORIGDSTADDR cmsg.
Message-ID: <Zumnk3MEqINMnTf6@GHGHG14>
References: <20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com>
 <20240913-reverse-sk-lookup-v1-3-e721ea003d4c@cloudflare.com>
 <8d5469d2-7525-420b-b506-8de2ecf04734@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d5469d2-7525-420b-b506-8de2ecf04734@linux.alibaba.com>

On Fri, Sep 13, 2024 at 08:10:24PM +0800, Philo Lu wrote:
> Hi Tiago,
> 
> On 2024/9/13 17:39, Tiago Lam wrote:
> > This patch reuses the framework already in place for sk_lookup, allowing
> > it now to send a reply from the server fd directly, instead of having to
> > create a socket bound to the original destination address and reply from
> > there. It does this by passing the source address and port from where to
> > reply from in a IP_ORIGDSTADDR ancilliary message passed in sendmsg.
> > 
> > Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>
> > ---
> >   tools/testing/selftests/bpf/prog_tests/sk_lookup.c | 70 +++++++++++++++-------
> >   1 file changed, 48 insertions(+), 22 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> > index ae87c00867ba..b99aff2e3976 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> > @@ -75,6 +75,7 @@ struct test {
> >   	struct inet_addr listen_at;
> >   	enum server accept_on;
> >   	bool reuseport_has_conns; /* Add a connected socket to reuseport group */
> > +	bool dont_bind_reply; /* Don't bind, send direct from server fd. */
> >   };
> >   struct cb_opts {
> > @@ -363,7 +364,7 @@ static void v4_to_v6(struct sockaddr_storage *ss)
> >   	memset(&v6->sin6_addr.s6_addr[0], 0, 10);
> >   }
> > -static int udp_recv_send(int server_fd)
> > +static int udp_recv_send(int server_fd, bool dont_bind_reply)
> >   {
> >   	char cmsg_buf[CMSG_SPACE(sizeof(struct sockaddr_storage))];
> >   	struct sockaddr_storage _src_addr = { 0 };
> > @@ -415,26 +416,41 @@ static int udp_recv_send(int server_fd)
> >   		v4_to_v6(dst_addr);
> >   	}
> > -	/* Reply from original destination address. */
> > -	fd = start_server_addr(SOCK_DGRAM, dst_addr, sizeof(*dst_addr), NULL);
> > -	if (!ASSERT_OK_FD(fd, "start_server_addr")) {
> > -		log_err("failed to create tx socket");
> > -		return -1;
> > -	}
> > +	if (dont_bind_reply) {
> > +		/* Reply directly from server fd, specifying the source address and/or
> > +		 * port in struct msghdr.
> > +		 */
> > +		n = sendmsg(server_fd, &msg, 0);
> > +		if (CHECK(n <= 0, "sendmsg", "failed\n")) {
> > +			log_err("failed to send echo reply");
> > +			return -1;
> > +		}
> > +	} else {
> > +		/* Reply from original destination address. */
> > +		fd = socket(dst_addr->ss_family, SOCK_DGRAM, 0);
> > +		if (CHECK(fd < 0, "socket", "failed\n")) {
> > +			log_err("failed to create tx socket");
> > +			return -1;
> > +		}
> Just curious, why not use start_server_addr() here like before?
> 

Thanks, you're right. Initially I rebased this on commit
e3d332aaf898ed755b29c8cdf59be2cfba1cac4b (v6.6.31), which didn't have
start_server_addr(), and used bind() instead. I must have messed up the
rebased.

I've fixed this and included your other suggestion in the patch below
and will fold it into the next revision.

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index b99aff2e3976..0628a67681c5 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -374,7 +374,7 @@ static int udp_recv_send(int server_fd, bool dont_bind_reply)
        struct iovec iov = { 0 };
        struct cmsghdr *cm;
        char buf[1];
-       int ret, fd;
+       int fd;
        ssize_t n;
 
        iov.iov_base = buf;
@@ -427,19 +427,12 @@ static int udp_recv_send(int server_fd, bool dont_bind_reply)
                }
        } else {
                /* Reply from original destination address. */
-               fd = socket(dst_addr->ss_family, SOCK_DGRAM, 0);
-               if (CHECK(fd < 0, "socket", "failed\n")) {
+               fd = start_server_addr(SOCK_DGRAM, dst_addr, sizeof(*dst_addr), NULL);
+               if (!ASSERT_OK_FD(fd, "start_server_addr")) {
                        log_err("failed to create tx socket");
                        return -1;
                }
 
-               ret = bind(fd, (struct sockaddr *)dst_addr, sizeof(*dst_addr));
-               if (CHECK(ret, "bind", "failed\n")) {
-                       log_err("failed to bind tx socket");
-                       close(fd);
-                       return ret;
-               }
-
                msg.msg_control = NULL;
                msg.msg_controllen = 0;
                n = sendmsg(fd, &msg, 0);
@@ -451,6 +444,8 @@ static int udp_recv_send(int server_fd, bool dont_bind_reply)
 
                close(fd);
        }
+
+       return 0;
 }
 
 static int tcp_echo_test(int client_fd, int server_fd)

