Return-Path: <linux-kselftest+bounces-653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B8B7FA517
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 16:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794E31F20D44
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 15:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6493455F;
	Mon, 27 Nov 2023 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUstPTet"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B46BE;
	Mon, 27 Nov 2023 07:46:33 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77d72aeae3bso185192485a.1;
        Mon, 27 Nov 2023 07:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701099993; x=1701704793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQn+nfZn0k/15RIKJDHqgnJW9L0h46ZKz5egxGpypNQ=;
        b=SUstPTetz14ro4nwubtkhYV06yNDCybYDllFysqH97d+WsC4pmZI+oThkRoHCVD4wC
         qNkftg3UmeUWSrAnELIiW8MMNrgQp/sSx1zWcXHerglCgXGE8qN7mkeoq7+ZP2tEV7uG
         awqNaLBzdbQWsWi0XzXNcWkwCzmu/jgMmatKMyIDLXwwMOEJHhgC2iDi4K9Q6G61Ne1W
         G8aYkdqddYnWsS1uN9WhnI+wqhQPYyRy/+Lxg7cMxzz/fZAoQerE+eaR6NAfA59O86fR
         +NPHH9ZNObIlWHRPxlGyFSiWD8RCJiqxThTETAxalnq4pnv+0U9FmkoChoezgpbbJgOm
         eqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701099993; x=1701704793;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dQn+nfZn0k/15RIKJDHqgnJW9L0h46ZKz5egxGpypNQ=;
        b=EK5NdKaRS5IPJbM6JAYl3pZCy9s+ul0NntR4coDVz3Z7tMOE3x55vlxVkXjVofvJ4B
         RJq/ADA/rcBdWPTRd5BoFdOfC6LO86NtbKBnKDI2wIonBV24bft8Zk5lGkA0wFDJiEuV
         VhicbOaM+4n6cc1HSrVIOc4Zp6nCbqKDvlKvdH5HPhoVTk0iHhejKrVitQul8cJ1CiCd
         YQpiYcvk1IEyimLpNtChRYkBFTZwhcwarYRDSL6N7xSyPW3rlsKWi+jNtRDpAVM+fO4z
         MADmZeMGPEIwUjGoUmhgfX6bqiNGaH6XVQF5mJRyWuaqscE0rFy3FMZTFTAtCycxBJFN
         OLlA==
X-Gm-Message-State: AOJu0Yzx+ms/ZU7IIBhGsJZXIpyuomkdrE7d1pZJwsxTvPAqIjdAkfPB
	kJ4nICHWjOZb7m7VlKhZo+A=
X-Google-Smtp-Source: AGHT+IE3MaWwPx811HWE6Z1JCLCB7GQvQMZYVYPljdxgpiA3wP6Lhn644czcnNQd2UEdF76Ej2je9Q==
X-Received: by 2002:a05:620a:4895:b0:777:457:34be with SMTP id ea21-20020a05620a489500b00777045734bemr12809491qkb.24.1701099992822;
        Mon, 27 Nov 2023 07:46:32 -0800 (PST)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id g12-20020a05620a13cc00b0077580becd52sm3781679qkl.103.2023.11.27.07.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:46:32 -0800 (PST)
Date: Mon, 27 Nov 2023 10:46:32 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Florian Westphal <fw@strlen.de>, 
 MPTCP Upstream <mptcp@lists.linux.dev>
Message-ID: <6564b9d831e24_8a1ac29498@willemb.c.googlers.com.notmuch>
In-Reply-To: <7418fa0c-c0c2-4615-ba55-f148ceb82328@kernel.org>
References: <20231124171645.1011043-1-willemdebruijn.kernel@gmail.com>
 <20231124171645.1011043-5-willemdebruijn.kernel@gmail.com>
 <7418fa0c-c0c2-4615-ba55-f148ceb82328@kernel.org>
Subject: Re: [PATCH net 4/4] selftests/net: mptcp: fix uninitialized variable
 warnings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Matthieu Baerts wrote:
> Hi Willem,
> 
> (+ cc MPTCP list)
> 
> On 24/11/2023 18:15, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > Same init_rng() in both tests. The function reads /dev/urandom to
> > initialize srand(). In case of failure, it falls back onto the
> > entropy in the uninitialized variable. Not sure if this is on purpose.
> > But failure reading urandom should be rare, so just fail hard. While
> > at it, convert to getrandom(). Which man 4 random suggests is simpler
> > and more robust.
> > 
> >     mptcp_inq.c:525:6:
> >     mptcp_connect.c:1131:6:
> > 
> >     error: variable 'foo' is used uninitialized
> >     whenever 'if' condition is false
> >     [-Werror,-Wsometimes-uninitialized]
> 
> Thank you for the patch!
> 
> It looks good to me:
> 
> Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
> 
> > Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
> > Fixes: b51880568f20 ("selftests: mptcp: add inq test case")
> > Cc: Florian Westphal <fw@strlen.de>
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > 
> > ----
> > 
> > When input is randomized because this is expected to meaningfully
> > explore edge cases, should we also add
> > 1. logging the random seed to stdout and
> > 2. adding a command line argument to replay from a specific seed
> > I can do this in net-next, if authors find it useful in this case.
> 
> I think we should have done that from the beginning, otherwise we cannot
> easily reproduce these edge cases. To be honest, I don't think this
> technique helped to find bugs, and it was probably used here as a good
> habit to increase the coverage. But on the other hand, we might not
> realise some inputs are randomised and can cause instabilities in the
> tests because we don't print anything about that.
> 
> So I would say that the minimal thing to do is to log the random seed.
> But it might not be that easy to do, for example 'mptcp_connect' is used
> a lot of time by the .sh scripts: printing this seed number each time
> 'mptcp_connect' is started will "flood" the logs. Maybe we should only
> print that at the end, in case of errors: e.g. in xerror() and
> die_perror() for example, but I see 'exit(1)' is directly used in other
> places...
> 
> That's more code to change, but if it is still OK for you to do that,
> please also note that you will need to log this to stderr: mptcp_connect
> prints what has been received from the other peer to stdout.
> 
> Because it is more than just adding a 'printf()', I just created a
> ticket in our bug tracker, so anybody can look at that and check all the
> details about that:
> 
> https://github.com/multipath-tcp/mptcp_net-next/issues/462

Thanks for the detailed feedback, Matthieu!

Another option to avoid flooding the logs might be to choose a pseudo
random number in the script and pass the explicit value mptcp_connect.

I haven't looked closely, but for transport layer tests it is likely
that the payload is entirely ignored. Bar perhaps checksum coverage.
If it does not increase code coverage, randomization can also just be
turned off.
 
> > ---
> >  tools/testing/selftests/net/mptcp/mptcp_connect.c | 11 ++++-------
> >  tools/testing/selftests/net/mptcp/mptcp_inq.c     | 11 ++++-------
> >  2 files changed, 8 insertions(+), 14 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > index c7f9ebeebc2c5..d2043ec3bf6d6 100644
> > --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> 
> (...)
> 
> > @@ -1125,15 +1126,11 @@ int main_loop_s(int listensock)
> >  
> >  static void init_rng(void)
> >  {
> > -	int fd = open("/dev/urandom", O_RDONLY);
> >  	unsigned int foo;
> >  
> > -	if (fd > 0) {
> 
> I just realised that here, we could have fd == 0 which is a valid value.
> I don't think we would have that when executing the selftests, but
> that's another reason to change this :)
> 
> > -		int ret = read(fd, &foo, sizeof(foo));
> > -
> > -		if (ret < 0)
> > -			srand(fd + foo);
> > -		close(fd);
> > +	if (getrandom(&foo, sizeof(foo), 0) == -1) {
> > +		perror("getrandom");
> > +		exit(1);
> >  	}
> >  
> >  	srand(foo);
> 
> Cheers,
> Matt



