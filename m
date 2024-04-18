Return-Path: <linux-kselftest+bounces-8374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72BA8AA360
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 21:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126C91C23170
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 19:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CBF199EA2;
	Thu, 18 Apr 2024 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJPRQcZp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0CC190676;
	Thu, 18 Apr 2024 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469694; cv=none; b=IldV99ZhYo6KD/Mu3BUCyIObSWFFCzzdU1SgT11i/Umr67y6dYqFfWIGrVy7kpqvKcrBwEiNDUF5aNPBzOs8n5BsV2ZyZRacBmz98xS3hn3j6uzamn1eEHpDWo6lFB5qOnVtz6l3jIT64ItPfdhM0LbwMXsK2xwh3lRXCWHmipY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469694; c=relaxed/simple;
	bh=OmUmZ/bnXeCow6bbFJBnXFl2ZoWC0wNBfhjT9hW/AYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPmiFsvD5LfBoIvGKSUYpc39Kcn+jYbsjBtfsNBzrN8dcPl7ofHb0NGxIS3jb5Rb4kFHdj25ZIZ9wrKpqBuYnjhB6RwRuDVSvTHn6LCwXof1nDNiEPCWYeYDwv+VA8HAYglzbX51lDEKbXPdm/3x4QxgwzjoSTQQKYPd+fL3mBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJPRQcZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B77C113CC;
	Thu, 18 Apr 2024 19:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713469694;
	bh=OmUmZ/bnXeCow6bbFJBnXFl2ZoWC0wNBfhjT9hW/AYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LJPRQcZpProwGjh9Z8otCZ0M9wMBqR6OML/+gw9DS1Tr0OcvTWZ0ZFFF3vxVzlCw7
	 Y+tTR2zlcqFbSJMsbpbDY/NcFflYnxh+9H7rkPMPXcjWPW6T8Ud2KdZJr+fCHP7jTy
	 ybVzZoWWy/RpNpM1P4PvAAkd5JlOLNDZrH4fDnlnSmSllycHz9vtT2KhzdQtHn0Y+Q
	 Aiwjqr5Y4Tyk74t14BU5UlNwxebWwu3Q2Q8YlncVLlfaotmNgSnDEBG61A85SRZrUL
	 Ol+9I9o2WLLcdp6MalO+cU5Xa5fp+IeXOvW3ex6DDniqol0n8BQnYoTvVQi+bNr9+e
	 2D1tgas0kdM9A==
Date: Thu, 18 Apr 2024 12:48:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, petrm@nvidia.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 8/8] selftests: drv-net: add a TCP ping test
 case (and useful helpers)
Message-ID: <20240418124812.48788da6@kernel.org>
In-Reply-To: <662131d77b55d_ec9b92945@willemb.c.googlers.com.notmuch>
References: <20240417231146.2435572-1-kuba@kernel.org>
	<20240417231146.2435572-9-kuba@kernel.org>
	<662131d77b55d_ec9b92945@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 10:44:39 -0400 Willem de Bruijn wrote:
> > +def test_tcp(cfg) -> None:
> > +    port = random.randrange(1024 + (1 << 15))
> > +    with bkg(f"nc -l {cfg.addr} {port}") as nc:
> > +        wait_port_listen(port)
> > +
> > +        cmd(f"echo ping | nc {cfg.addr} {port}",
> > +            shell=True, host=cfg.remote)
> > +    ksft_eq(nc.stdout.strip(), "ping")
> > +
> > +    port = random.randrange(1024 + (1 << 15))
> > +    with bkg(f"nc -l {cfg.remote_addr} {port}", host=cfg.remote) as nc:
> > +        wait_port_listen(port, host=cfg.remote)
> > +
> > +        cmd(f"echo ping | nc {cfg.remote_addr} {port}", shell=True)
> > +    ksft_eq(nc.stdout.strip(), "ping")
> > +  
> 
> There are different netcat implementations floating around.
> 
> I notice that I have to pass -N on the client to terminate the
> connection after EOF. Else both peers keep the connection open,
> waiting for input. And explicitly pass -6 if passing an IPv6
> address. I think this is the one that ships with Debian..

Right, 100% laziness on my part. Mostly because socat requires
bracketed IPv6. But once I tried it I also run into the premature
termination problem, so ended up with this diff on top:

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 579c5b34e6fd..2f62270d59fa 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -110,6 +110,10 @@ from .remote import Remote
         self.addr = self.v6 if self.v6 else self.v4
         self.remote_addr = self.remote_v6 if self.remote_v6 else self.remote_v4
 
+        # Bracketed addresses, some commands need IPv6 to be inside []
+        self.baddr = f"[{self.v6}]" if self.v6 else self.v4
+        self.remote_baddr = f"[{self.remote_v6}]" if self.remote_v6 else self.remote_v4
+
         self.ifname = self.dev['ifname']
         self.ifindex = self.dev['ifindex']
 
diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
index 8532e3be72ba..985b06ce2e81 100755
--- a/tools/testing/selftests/drivers/net/ping.py
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -27,18 +27,20 @@ from lib.py import bkg, cmd, wait_port_listen
 
 def test_tcp(cfg) -> None:
     port = random.randrange(1024 + (1 << 15))
-    with bkg(f"nc -l {cfg.addr} {port}") as nc:
+
+    with bkg(f"socat -t 2 -u TCP-LISTEN:{port} STDOUT", exit_wait=True) as nc:
         wait_port_listen(port)
 
-        cmd(f"echo ping | nc {cfg.addr} {port}",
+        cmd(f"echo ping | socat -t 2 -u STDIN TCP:{cfg.baddr}:{port}",
             shell=True, host=cfg.remote)
     ksft_eq(nc.stdout.strip(), "ping")
 
     port = random.randrange(1024 + (1 << 15))
-    with bkg(f"nc -l {cfg.remote_addr} {port}", host=cfg.remote) as nc:
+    with bkg(f"socat -t 2 -u TCP-LISTEN:{port} STDOUT", host=cfg.remote,
+             exit_wait=True) as nc:
         wait_port_listen(port, host=cfg.remote)
 
-        cmd(f"echo ping | nc {cfg.remote_addr} {port}", shell=True)
+        cmd(f"echo ping | socat -t 2 -u STDIN TCP:{cfg.remote_baddr}:{port}", shell=True)
     ksft_eq(nc.stdout.strip(), "ping")
 
 
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 6bacdc99d21b..85a6a9bb35fd 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -42,15 +42,17 @@ import time
 
 
 class bkg(cmd):
-    def __init__(self, comm, shell=True, fail=True, ns=None, host=None):
+    def __init__(self, comm, shell=True, fail=True, ns=None, host=None,
+                 exit_wait=False):
         super().__init__(comm, background=True,
                          shell=shell, fail=fail, ns=ns, host=host)
+        self.terminate = not exit_wait
 
     def __enter__(self):
         return self
 
     def __exit__(self, ex_type, ex_value, ex_tb):
-        return self.process()
+        return self.process(terminate=self.terminate)
 
 
 def ip(args, json=None, ns=None, host=None):

