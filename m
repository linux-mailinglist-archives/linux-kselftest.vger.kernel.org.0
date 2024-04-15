Return-Path: <linux-kselftest+bounces-7950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3058A4B6D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 11:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08361F219A8
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 09:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A35E3FB2F;
	Mon, 15 Apr 2024 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1cQA0vJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E243A1B9
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173299; cv=none; b=Nl3yQn9v80qerOBLJZXjDZOX/UHvQMf31ZIGxm5ZOlrk57JROoWnH1h0dmp0xPuP9ojx52Cw26HKVY47372Pz/G4iowz3OqJr+rdhSvQFRGkJHoxEUSVQgH63zd51vm0Whzzw9zFunBEBxDHjAacNZcFDtFYvVTBfDbNCslzkU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173299; c=relaxed/simple;
	bh=Rtwf1LUZ0C5de0f4l9YxH+EU9vb5sTlrq63++U9G8qA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YBxs0ZYeKz+rGpWoIo8JMzDuH0sxu5wjcF43rpHXxQSSVyD7xMtd/6wpETd1Xgxg1qwKVDosJpbdFC2UHjFn9g5WSgNLac59AfrZEWvJMefGoPKqX4tznAAurn9iO8w3KzUuFIzvZtGD1ljkhvTurrAAtQ1WPbCep0Jl4w2uRqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1cQA0vJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713173296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h7bR2LedUATRVDf655y2bhnsuMbO0tp6N20IPGhI3FM=;
	b=R1cQA0vJB8DIC5nSlA1KomT3VYva1qDMP1JOxdiN7UP0o8iOKPAecPI/gXS8c1yRdwqtj2
	8Cv6PULNnbbNuAMOgLQ3iZGLSSVacHMYc6Z48PTTDUMvOkZbfpdIjv9Lk5qVQ3S7csREiX
	ZJwJQjF90h/UvwHW3vcZksYlBdeSgTk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-6dUx4ETrM1yE0tAmJazhBA-1; Mon, 15 Apr 2024 05:28:14 -0400
X-MC-Unique: 6dUx4ETrM1yE0tAmJazhBA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3450bcc1482so784190f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 02:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713173293; x=1713778093;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7bR2LedUATRVDf655y2bhnsuMbO0tp6N20IPGhI3FM=;
        b=VolZeAl9ZyQVakKvCkIsuPJ3cMzRj69X5O0yaWRMMmJSuxDdZUv5abB3ekPYbGO3PT
         YM5bokRopxdP5szN51ikhbWux0pywh085OPxBoDt6Df5j7bS0eHFoqmmTcMUCmQaQALr
         TDNvmFJqYcwVC3C3fZDtuNXzoaMMRTg7sb58H66BPwQ4Q6I71Q7oSNwwydHFpUxDn7NE
         6ywA+BlDSRtDS5D0lDEZO2WaYsNr6FPAfY2QoJ0F61Mmeu4X3IVpzGNNe0XZvIhWlj/q
         SABKmtp/EhauclMT9JcV+fpu+Kk03ccoV/XtuAObzMXJxDJ8oJU8n+Pbdx6nz+Bvwkcs
         1ZQA==
X-Forwarded-Encrypted: i=1; AJvYcCU/kUB3noETN0xVDXnxaeGOb7LDWpy67O1NQUxr7PvJ3wX3ezC27djqqzDeWrB0pT7AzpOJyzR+0/S44tLsTCfg6usVsnls5ljGzfWD3m7l
X-Gm-Message-State: AOJu0Yx2rw/9ZA00Nz6JbKsA8yzfoz3KCX7d7/g16YlhwnU92K1OZ7rV
	+u6O40JAXvhmfKZ3YgBPgBmIRfbscoh0RWR+bMDpIHGi0/4LPBw2iAspiiU+zfGmBIg1FkXy7+O
	9unf/bUI+MfpVV9Qb15hfSZkD9vwCAOWuyKkfGDU2eySmtG++0NRKR82PJbRrHhB25A==
X-Received: by 2002:a05:600c:5690:b0:418:73d1:94e9 with SMTP id jt16-20020a05600c569000b0041873d194e9mr547029wmb.4.1713173293019;
        Mon, 15 Apr 2024 02:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERNPGSp2Pz5tYD+hkyj8EJ0CMtIasjyE4g8O/XMwLQhUeF+ogNCEPyisj9rRe4tOleSXxBlw==
X-Received: by 2002:a05:600c:5690:b0:418:73d1:94e9 with SMTP id jt16-20020a05600c569000b0041873d194e9mr547020wmb.4.1713173292653;
        Mon, 15 Apr 2024 02:28:12 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-238.dyn.eolo.it. [146.241.228.238])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c314900b004161bffa48csm15575915wmo.40.2024.04.15.02.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 02:28:12 -0700 (PDT)
Message-ID: <65b3afd1a4adb8648561ea8b669c2e541cf34f9e.camel@redhat.com>
Subject: Re: [PATCH net-next 4/5] selftests: drv-net: construct environment
 for running tests which require an endpoint
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, shuah@kernel.org, 
	petrm@nvidia.com, linux-kselftest@vger.kernel.org, willemb@google.com
Date: Mon, 15 Apr 2024 11:28:11 +0200
In-Reply-To: <20240412233705.1066444-5-kuba@kernel.org>
References: <20240412233705.1066444-1-kuba@kernel.org>
	 <20240412233705.1066444-5-kuba@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-12 at 16:37 -0700, Jakub Kicinski wrote:
> Nothing surprising here, hopefully. Wrap the variables from
> the environment into a class or spawn a netdevsim based env
> and pass it to the tests.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../testing/selftests/drivers/net/README.rst  | 31 +++++++
>  .../selftests/drivers/net/lib/py/env.py       | 93 ++++++++++++++++++-
>  .../testing/selftests/net/lib/py/__init__.py  |  1 +
>  tools/testing/selftests/net/lib/py/netns.py   | 31 +++++++
>  4 files changed, 155 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/net/lib/py/netns.py
>=20
> diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testi=
ng/selftests/drivers/net/README.rst
> index 5ef7c417d431..ffc15fe5d555 100644
> --- a/tools/testing/selftests/drivers/net/README.rst
> +++ b/tools/testing/selftests/drivers/net/README.rst
> @@ -23,8 +23,39 @@ Variables can be set in the environment or by creating=
 a net.config
>    # Variable set in a file
>    NETIF=3Deth0
> =20
> +Please note that the config parser is very simple, if there are
> +any non-alphanumeric characters in the value it needs to be in
> +double quotes.
> +
>  NETIF
>  ~~~~~
> =20
>  Name of the netdevice against which the test should be executed.
>  When empty or not set software devices will be used.
> +
> +LOCAL_V4, LOCAL_V6, EP_V4, EP_V6
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Local and remote (endpoint) IP addresses.
> +
> +EP_TYPE
> +~~~~~~~
> +
> +Communication method used to run commands on the endpoint.
> +Test framework supports using ``netns`` and ``ssh`` channels.
> +``netns`` assumes the "remote" interface is part of the same
> +host, just moved to the specified netns.
> +``ssh`` communicates with remote endpoint over ``ssh`` and ``scp``.
> +
> +Communication methods are defined by classes in ``lib/py/ep_{name}.py``.
> +It should be possible to add a new method without modifying any of
> +the framework, by simply adding an appropriately named file to ``lib/py`=
`.
> +
> +EP_ARGS
> +~~~~~~~
> +
> +Arguments used to construct the communication channel.
> +Communication channel dependent::
> +
> +  for netns - name of the "remote" namespace
> +  for ssh - name/address of the remote host
> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/te=
sting/selftests/drivers/net/lib/py/env.py
> index a081e168f3db..f63be0a72a53 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
> @@ -4,7 +4,8 @@ import os
>  import shlex
>  from pathlib import Path
>  from lib.py import ip
> -from lib.py import NetdevSimDev
> +from lib.py import NetNS, NetdevSimDev
> +from .endpoint import Endpoint
> =20
> =20
>  def _load_env_file(src_path):
> @@ -59,3 +60,93 @@ from lib.py import NetdevSimDev
>              self._ns =3D None
> =20
> =20
> +class NetDrvEpEnv:
> +    """
> +    Class for an environment with a local device and "remote endpoint"
> +    which can be used to send traffic in.
> +
> +    For local testing it creates two network namespaces and a pair
> +    of netdevsim devices.
> +    """
> +    def __init__(self, src_path):
> +
> +        self.env =3D _load_env_file(src_path)
> +
> +        # Things we try to destroy
> +        self.endpoint =3D None
> +        # These are for local testing state
> +        self._netns =3D None
> +        self._ns =3D None
> +        self._ns_peer =3D None
> +
> +        if "NETIF" in self.env:
> +            self.dev =3D ip("link show dev " + self.env['NETIF'], json=
=3DTrue)[0]
> +
> +            self.v4 =3D self.env.get("LOCAL_V4")
> +            self.v6 =3D self.env.get("LOCAL_V6")
> +            self.ep_v4 =3D self.env.get("EP_V4")
> +            self.ep_v6 =3D self.env.get("EP_V6")
> +            ep_type =3D self.env["EP_TYPE"]
> +            ep_args =3D self.env["EP_ARGS"]
> +        else:
> +            self.create_local()
> +
> +            self.dev =3D self._ns.nsims[0].dev
> +
> +            self.v4 =3D "192.0.2.1"
> +            self.v6 =3D"0100::1"

Minor nit, what about using 2001:db8:, for more consistency with
existing 'net' self-tests?

Also +1 on Willem suggestion to possibly have both endpoints remote.

(Very cool stuff, =C3=A7a va sans dire ;)

Thanks,

Paolo


