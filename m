Return-Path: <linux-kselftest+bounces-7928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C778A4450
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 19:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CAD1B20BF0
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 17:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A1E135407;
	Sun, 14 Apr 2024 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+HyPimu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FFF13540C;
	Sun, 14 Apr 2024 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713114289; cv=none; b=o02ZeZE0w5rxkDxRv5gED0k5bmge6LZyM4OEYd7IQ7di5oSnfqoeW/iPblJ59KgsDvFC2/07GvmKOg4AmwhmUjehvFfYH+cCVu2judbb9f+mJWQ0H9HA3TB1FmW6gSGvodK017SxVqLDf0LO6L9oGv0jpklV6bhgWIdTZKmthVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713114289; c=relaxed/simple;
	bh=n2hlkYHsfz9JZd9Aevy3nJrxNbnZHp/6pu1yts4G4Qo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UrS7eS4cBxbAZZXWk0zkMgn5ErCiWLKUR/t2XmNquxeMxOVe9qewaZmlfGGdFzOu8RRdYBUCL3GWX2bCb1iq52awh56VRB7nw1v2/Vk4pzgW0DJZ0NTGIbn+qyGQPL1tZRfSokqeMQzme7J+67BtNAQB80aiMsVTsGdWNsqaisM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+HyPimu; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-69b137d09e3so12499656d6.1;
        Sun, 14 Apr 2024 10:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713114287; x=1713719087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tG91y4f7+w2KDY/8G5tmXZfncmdAId21hF/f0l1pttk=;
        b=c+HyPimuiprb+sidXkogC6LTS71b1L/90gbGTqc2htFoFlrusVzzwRZhR1mueLjGKT
         9JLgelon74YeEZgaPpPJTYMiRamNS+w2jqXBgab95SgzQBtj3Ww2UNiPtW2zUg9Hyj9S
         a2gfd53T+pqXw1noR1UFwOiXNzcEvFM9tbpahwaSGu+u9tX79Qtnoy1P3tNDgB7l8ZP9
         +QJU4wMwcyDjqmyl+AsOFe5XvKGY7rBhL9PwP2jHmcixfrn15IuT9AdlgFuKd7Z9352v
         BPZe57arwgh+cMCoaVwqVlpQrk2k1as6f6GyDfr7baLi8RTSj4z+bTtRQ+UCQgW5NWG9
         ZQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713114287; x=1713719087;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tG91y4f7+w2KDY/8G5tmXZfncmdAId21hF/f0l1pttk=;
        b=EKG449UsKvrh/7caI2qLsufsb71Op6ap999NhHDapF4ooehuWJhJuhcObdjKqRYQN1
         JK1l78glUJfVYt+tqsPwNpCxjsomu2nKXqp5LQ6UW4EwErG64Wo/uUIenm+tEf+FIUOX
         yQmSCHVie8z/y+NIF37CzrT0IdEOxTOw70R9KIUrSd6vBZP2FD9RdEC5f6TglSPkxVKN
         hXwAdtFVZxmR3OPORzWt9vgmty7nbTaLPBecqtHpec8j2tdBx2VDGeFdRpS6/N4LCxph
         +7kRMq4Sh37mZXh+pUWpOMfVKVOs4fuM4zKwe5VtqafDNgDGBbMbH4zDsx7D782BVNHl
         STDA==
X-Forwarded-Encrypted: i=1; AJvYcCVj7FzmIlukR+0iN+IAi502T2jupExKy5ohljCFyDIr8A2oNLuDThS7JEsx816sgSbDmWelw+HsaNvWPLTm2Hlo455BArbSgBgs01EenzE1
X-Gm-Message-State: AOJu0YzVZ4exzi7aVbVlsJalh+t2/Q8t5topwyiLSKypLwuNe9PZz95J
	E+OQbQaxU8CNjal0kDHRYPHDhvqxiKEljOTKjy+ONmr0ZRPfKQCY
X-Google-Smtp-Source: AGHT+IFweAZlzVU+Hu9R+O28T4JFhf7r9girmd22iik0Gks3GvAKZ/f/RX0/OE9/GavfQPUcGASmNA==
X-Received: by 2002:a05:6214:1746:b0:69b:aa1:7910 with SMTP id dc6-20020a056214174600b0069b0aa17910mr7226659qvb.1.1713114287118;
        Sun, 14 Apr 2024 10:04:47 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id mn12-20020a0562145ecc00b0069b76fd6b4bsm737951qvb.71.2024.04.14.10.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 10:04:46 -0700 (PDT)
Date: Sun, 14 Apr 2024 13:04:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 petrm@nvidia.com, 
 linux-kselftest@vger.kernel.org, 
 willemb@google.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <661c0cae8110a_3e773229418@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240412233705.1066444-2-kuba@kernel.org>
References: <20240412233705.1066444-1-kuba@kernel.org>
 <20240412233705.1066444-2-kuba@kernel.org>
Subject: Re: [PATCH net-next 1/5] selftests: drv-net: define endpoint
 structures
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Define the endpoint "model". To execute most meaningful device
> driver tests we need to be able to communicate with a remote system,
> and have it send traffic to the device under test.
> 
> Various test environments will have different requirements.
> 
> 0) "Local" netdevsim-based testing can simply use net namespaces.
> netdevsim supports connecting two devices now, to form a veth-like
> construct.
> 
> 1) Similarly on hosts with multiple NICs, the NICs may be connected
> together with a loopback cable or internal device loopback.
> One interface may be placed into separate netns, and tests
> would proceed much like in the netdevsim case. Note that
> the loopback config or the moving of one interface
> into a netns is not expected to be part of selftest code.
> 
> 2) Some systems may need to communicate with the endpoint via SSH.
> 
> 3) Last but not least environment may have its own custom communication
> method.
> 
> Fundamentally we only need two operations:
>  - run a command remotely
>  - deploy a binary (if some tool we need is built as part of kselftests)
> 
> Wrap these two in a class. Use dynamic loading to load the Endpoint
> class. This will allow very easy definition of other communication
> methods without bothering upstream code base.
> 
> Stick to the "simple" / "no unnecessary abstractions" model for
> referring to the endpoints. The host / endpoint object are passed
> as an argument to the usual cmd() or ip() invocation. For example:
> 
>  ip("link show", json=True, host=endpoint)
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../selftests/drivers/net/lib/py/__init__.py  |  1 +
>  .../selftests/drivers/net/lib/py/endpoint.py  | 13 +++++++
>  .../selftests/drivers/net/lib/py/ep_netns.py  | 15 ++++++++
>  .../selftests/drivers/net/lib/py/ep_ssh.py    | 34 +++++++++++++++++++
>  tools/testing/selftests/net/lib/py/utils.py   | 19 ++++++-----
>  5 files changed, 73 insertions(+), 9 deletions(-)
>  create mode 100644 tools/testing/selftests/drivers/net/lib/py/endpoint.py
>  create mode 100644 tools/testing/selftests/drivers/net/lib/py/ep_netns.py
>  create mode 100644 tools/testing/selftests/drivers/net/lib/py/ep_ssh.py
> 
> diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
> index 4653dffcd962..0d71ec83135b 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
> @@ -15,3 +15,4 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
>      sys.exit(4)
>  
>  from .env import *
> +from .endpoint import Endpoint
> diff --git a/tools/testing/selftests/drivers/net/lib/py/endpoint.py b/tools/testing/selftests/drivers/net/lib/py/endpoint.py
> new file mode 100644
> index 000000000000..9272fdc47a06
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/lib/py/endpoint.py
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import importlib
> +
> +_modules = {}
> +
> +def Endpoint(ep_type, ep_args):
> +    global _modules
> +
> +    if ep_type not in _modules:
> +        _modules[ep_type] = importlib.import_module("..ep_" + ep_type, __name__)
> +
> +    return getattr(_modules[ep_type], "Endpoint")(ep_args)
> diff --git a/tools/testing/selftests/drivers/net/lib/py/ep_netns.py b/tools/testing/selftests/drivers/net/lib/py/ep_netns.py
> new file mode 100644
> index 000000000000..f5c588bb31f0
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/lib/py/ep_netns.py
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from lib.py import cmd
> +
> +
> +class Endpoint:
> +    def __init__(self, name):
> +        self.name = name
> +
> +    def cmd(self, *args):
> +        c = cmd(*args, ns=self.name)
> +        return c.stdout, c.stderr, c.ret
> +
> +    def deploy(self, what):
> +        return what
> diff --git a/tools/testing/selftests/drivers/net/lib/py/ep_ssh.py b/tools/testing/selftests/drivers/net/lib/py/ep_ssh.py
> new file mode 100644
> index 000000000000..620df0dd8c07
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/lib/py/ep_ssh.py
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import os
> +import shlex
> +import string
> +import random
> +
> +from lib.py import cmd
> +
> +
> +class Endpoint:
> +    def __init__(self, name):
> +        self.name = name
> +        self._tmpdir = None
> +
> +    def __del__(self):
> +        if self._tmpdir:
> +            self.cmd("rm -rf " + self._tmpdir)
> +            self._tmpdir = None
> +
> +    def cmd(self, comm, *args):
> +        c = cmd("ssh " + self.name + " " + shlex.quote(comm), *args)
> +        return c.stdout, c.stderr, c.ret
> +
> +    def _mktmp(self):
> +        return ''.join(random.choice(string.ascii_lowercase) for _ in range(8))
> +
> +    def deploy(self, what):
> +        if not self._tmpdir:
> +            self._tmpdir = "/tmp/" + self._mktmp()
> +            self.cmd("mkdir " + self._tmpdir)
> +        file_name = self._tmpdir + "/" + self._mktmp() + os.path.basename(what)
> +        cmd(f"scp {what} {self.name}:{file_name}")
> +        return file_name
> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> index f0d425731fd4..eff50ddd9a9d 100644
> --- a/tools/testing/selftests/net/lib/py/utils.py
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -4,10 +4,8 @@ import json as _json
>  import subprocess
>  
>  class cmd:
> -    def __init__(self, comm, shell=True, fail=True, ns=None, background=False):
> +    def __init__(self, comm, shell=True, fail=True, ns=None, background=False, host=None):
>          if ns:
> -            if isinstance(ns, NetNS):
> -                ns = ns.name
>              comm = f'ip netns exec {ns} ' + comm
>  
>          self.stdout = None
> @@ -15,10 +13,13 @@ import subprocess
>          self.ret = None
>  
>          self.comm = comm
> -        self.proc = subprocess.Popen(comm, shell=shell, stdout=subprocess.PIPE,
> -                                     stderr=subprocess.PIPE)
> -        if not background:
> -            self.process(terminate=False, fail=fail)
> +        if host:
> +            self.stdout, self.stderr, self.ret = host.cmd(comm)
> +        else:
> +            self.proc = subprocess.Popen(comm, shell=shell, stdout=subprocess.PIPE,
> +                                         stderr=subprocess.PIPE)
> +            if not background:
> +                self.process(terminate=False, fail=fail)
>  
>      def process(self, terminate=True, fail=None):
>          if terminate:

Perhaps superfluous / putting the cart before the horse, but a few
thorny issues I've repeatedly run into with similar infra is

1. Cleaning up remote state in all conditions, including timeout/kill.

   Some tests require a setup phase before the test, and a matching
   cleanup phase. If any of the configured state is variable (even
   just a randomized filepath) this needs to be communicated to the
   cleanup phase. The remote filepath is handled well here. But if
   a test needs per-test setup? Say, change MTU or an Ethtool feature.
   Multiple related tests may want to share a setup/cleanup.

   Related: some tests may need benefit from a lightweight stateless
   check phase to detect preconditions before committing to any setup.
   Again, say an Ethtool feature like rx-gro-hw, or AF_XDP metadata rx.

2. Synchronizing peers. Often both peers need to be started at the
   same time, but then the client may need to wait until the server
   is listening. Paolo added a nice local script to detect a listening
   socket with sockstat. Less of a problem with TCP tests than UDP or
   raw packet tests.

